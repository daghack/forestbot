package dwrapper

import (
	"github.com/bwmarrin/discordgo"
)

type DWrapper struct {
	session *discordgo.Session
}

func New() (*DWrapper, error) {
	discord, err := discordgo.New("Bot NTk2MDMzMDMzNTY4NTE4MTY4.XRzt1w.2Y5J2wc9s3JZsgF7YqoErCybYDw")
	if err != nil {
		return nil, err
	}

	err = discord.Open()
	if err != nil {
		return nil, err
	}

	return &DWrapper{
		session: discord,
	}, nil
}

func (dw *DWrapper) Close() {
	dw.session.Close()
}

func (dw *DWrapper) SendMessageToChannel(channelId, msgId string) {
	dw.session.ChannelMessageSend(channelId, msgId)
}

func (dw *DWrapper) SetChannelName(channelId, name string) {
	dw.session.ChannelEdit(channelId, name)
}

func (dw *DWrapper) AddHandler(h interface{}) {
	dw.session.AddHandler(h)
}

func (dw *DWrapper) GetChannelInfo(channelId string) *discordgo.Channel {
	ch, err := dw.session.Channel(channelId)
	if err != nil {
		return nil
	}
	return ch
}
