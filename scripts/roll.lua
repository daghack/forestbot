function handler(msg, args)
	local resp = ""
	if #args >= 1 then
		local i = string.match(args[1], "(%d+)")
		if i then
			local r = tonumber(i)
			if r < 1 or r > 1000 then
				send_msg(msg.ChannelID, "<@" .. msg.Author.ID .. "> Nah, bro. That's for Ayan worshippers.")
				return
			end
			resp = "<@" .. msg.Author.ID .. "> rolls a " .. i .. " sided die...\nResults: " .. tostring(math.random(r))
			send_msg(msg.ChannelID, resp)
			return
		end
	end
	resp = "<@" .. msg.Author.ID .. "> rolls a 20 sided die...\nResults: " .. tostring(math.random(20))
	send_msg(msg.ChannelID, resp)
end
