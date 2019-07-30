package main

import (
	"fmt"
	"os"
	"path"
	"path/filepath"
	"strings"

	dw "forestbot/dwrapper"
	"github.com/aarzilli/golua/lua"
	"github.com/bwmarrin/discordgo"
	"github.com/fsnotify/fsnotify"
	"github.com/stevedonovan/luar"
)

var (
	commandPrefix string
	botID         string
	runner        *BotRunner
	scriptDir     string
)

const luaCode = `
function roll_handler(msg, username)
end
`

func errH(err error) {
	if err != nil {
		panic(err)
	}
}

type BotRunner struct {
	watcher  *fsnotify.Watcher
	state    *lua.State
	commands map[string]*luar.LuaObject
	dwrapper *dw.DWrapper
}

func (br *BotRunner) Close() {
	defer br.state.Close()
	defer br.dwrapper.Close()
	for _, f := range br.commands {
		f.Close()
	}
}

func (br *BotRunner) FsListen() {
	for event := range br.watcher.Events {
		fmt.Printf("New file event:\t%+v\n", event)
		cmd := ""
		_, err := fmt.Sscanf(strings.ToLower(event.Name), scriptDir+"/%s", &cmd)
		if err != nil || cmd == "" {
			continue
		}
		cmd = strings.Split(cmd, ".")[0]
		fmt.Println(event.Name, "->", cmd)
		if event.Op&fsnotify.Create == fsnotify.Create {
			br.RegisterCommand(cmd)
		}
		if event.Op&fsnotify.Remove == fsnotify.Remove {
			br.DeleteCommand(cmd)
		}
		if event.Op&fsnotify.Write == fsnotify.Write {
			br.DeleteCommand(cmd)
			br.RegisterCommand(cmd)
		}
	}
}

func (br *BotRunner) DeleteCommand(cmd string) {
	if luacmd, ok := br.commands[cmd]; ok {
		luacmd.Close()
		delete(br.commands, cmd)
	}
}

func (br *BotRunner) RegisterCommand(command string) error {
	if _, ok := br.commands[command]; ok {
		return fmt.Errorf(command + " command already registered")
	}
	err := br.state.DoFile(path.Join(scriptDir, command+".lua"))
	if err != nil {
		return err
	}
	br.commands[command] = luar.NewLuaObjectFromName(br.state, "handler")
	return nil
}

func (br *BotRunner) RegisterCommands(commands ...string) {
	for _, cmd := range commands {
		err := br.RegisterCommand(cmd)
		errH(err)
	}
}

func init() {
	scriptDir = "scripts"
	commandPrefix = "@"

	dw, err := dw.New()
	errH(err)
	dw.AddHandler(joinHandler)
	dw.AddHandler(msgHandler)

	state := luar.Init()
	luar.Register(state, "", luar.Map{
		"send_msg":         dw.SendMessageToChannel,
		"set_channel_name": dw.SetChannelName,
		"get_channel":      dw.GetChannelInfo,
	})

	watcher, err := fsnotify.NewWatcher()
	errH(err)
	watcher.Add("scripts")

	runner = &BotRunner{
		watcher:  watcher,
		dwrapper: dw,
		state:    state,
		commands: map[string]*luar.LuaObject{},
	}

	err = filepath.Walk(scriptDir, func(p string, info os.FileInfo, err error) error {
		if info.IsDir() {
			return nil
		}
		cmd := strings.TrimSuffix(path.Base(p), ".lua")
		return runner.RegisterCommand(cmd)
	})
	errH(err)

	go runner.FsListen()
}

func main() {
	defer runner.Close()
	<-make(chan struct{})
}

func msgHandler(session *discordgo.Session, msg *discordgo.MessageCreate) {
	fmt.Println("Msg Received?", msg.Author.Username)
	if msg.Author.ID == session.State.User.ID {
		return
	}

	content := strings.TrimSpace(strings.ToLower(msg.Content))
	contentPieces := strings.Split(content, " ")

	command := ""
	_, err := fmt.Sscanf(contentPieces[0], commandPrefix+"%s", &command)
	if err != nil {
		return
	}

	if cmd, ok := runner.commands[command]; ok {
		err = cmd.Call(nil, msg)
		errH(err)
	}
}

func joinHandler(session *discordgo.Session, event *discordgo.Ready) {
	fmt.Println("READY")
	session.UpdateStatus(0, "Mah bot")
	fmt.Println("Joined:")
	for _, guild := range session.State.Guilds {
		fmt.Println("\t", guild.Name, ":", guild.ID)
	}
}
