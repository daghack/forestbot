function handler(msg)
	local ch = get_channel(msg.ChannelID)
	if not string.match(ch.Name, "_freeze") then
		set_channel(msg.ChannelID, ch.Name .. "_freeze", ch.Position)
	else
		local name = ch.Name:gmatch("(.-)_freeze")()
		set_channel(msg.ChannelID, name, ch.Position)
	end
end
