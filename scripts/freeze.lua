function handler(msg)
	local ch = get_channel(msg.ChannelID)
	if not string.match(ch.Name, "_freeze") then
		set_channel_name(msg.ChannelID, ch.Name .. "_freeze")
	else
		local name = ch.Name:gmatch("(.-)_freeze")()
		set_channel_name(msg.ChannelID, name)
	end
end
