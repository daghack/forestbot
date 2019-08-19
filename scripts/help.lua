function handler(msg)
	local freeze = "@freeze -- Freezes/Unfreezes a channel."
	local roll = "@roll -- Rolls a 20-sided die."
	local rolln = "@roll N -- Rolls an N-sided die (example: @roll 100)"
	local fyrn = "@fyrnism -- Drop a fyrnism!"
	local icyblue = "@icyblue -- Herald the arrival with ANTHRO COCK."
	local appr = "@apprentice [user] -- Determine whether [user] is one of Ayan's apprentices."
	local resp = "Current commands:\n" .. freeze .. "\n" .. roll .. "\n" .. rolln .. "\n" .. fyrn .. "\n" .. icyblue .. "\n" .. appr .. "\n"
	send_msg(msg.ChannelID, resp)
end
