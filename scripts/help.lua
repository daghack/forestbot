function handler(msg)
	local resp = "Current commands:\n@freeze -- Freezes/Unfreezes a channel.\n@roll -- Rolls a d20."
	send_msg(msg.ChannelID, resp)
end
