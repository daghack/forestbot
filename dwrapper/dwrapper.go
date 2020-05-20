package dwrapper

import (
	"github.com/bwmarrin/discordgo"
)

type DWrapper struct {
	session *discordgo.Session
}

func New() (*DWrapper, error) {
	discord, err := discordgo.New("Bot NTk2MDMzMDMzNTY4NTE4MTY4.XUC4WQ.sXRhCgQETIc_aTFOcJlsJZvh1Zs")
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

func (dw *DWrapper) SetChannel(channelId, name string, position int) {
	dw.session.ChannelEditComplex(channelId, &discordgo.ChannelEdit{
		Name:     name,
		Position: position,
	})
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
