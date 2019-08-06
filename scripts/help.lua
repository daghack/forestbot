function handler(msg)
	local freeze = "@freeze -- Freezes/Unfreezes a channel."
	local roll = "@roll -- Rolls a 20-sided die."
	local rolln = "@roll N -- Rolls an N-sided die (example: @roll 100)"
	local fyrn = "@fyrnism -- Drop a fyrnism!"
	local resp = "Current commands:\n" .. freeze .. "\n" .. roll .. "\n" .. rolln .. "\n" .. fyrn .. "\n"
	send_msg(msg.ChannelID, resp)
end
