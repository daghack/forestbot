urlbase = "https://drive.google.com/uc?export=view&id="

imgids = {
	"1stTtOsNJ_6a7M8oKu7KaTxRcVWsC1oKM",
	"18Tv__aIE1GeQLoZRAHLpYW4dCPn0Vz1M"
}

function handler(msg)
	send_msg(msg.ChannelID, urlbase .. imgids[math.random(#imgids)])
end
