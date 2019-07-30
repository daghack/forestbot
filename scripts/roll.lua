function handler(msg)
	local resp = "<@" .. msg.Author.ID .. "> rolls a 20 sided die...\nResults: " .. tostring(math.random(20))
	send_msg(msg.ChannelID, resp)
end
