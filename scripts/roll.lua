last = {
	user = "daghack",
	die = 20,
	roll = 1
}

function print_roll(channelId, author, die, roll)
	last.user = author.Username
	last.die = die
	last.roll = roll
	resp = "<@" .. author.ID .. "> rolls a " .. die .. " sided die...\nResults: " .. tostring(roll)
	send_msg(channelId, resp)
end

function roll_win_or_tie(die)
	if last.roll == die then
		return last.roll
	end
	return math.random(last.roll+1, die)
end

function roll_lose_or_tie(die)
	return math.random(last.roll)
end

function fair_roll(die)
	return math.random(die)
end

function cheating_roll(author, die)
	if die ~= last.die or author.Username == last.user then
		return fair_roll(die)
	end
	if last.user == "daghack" then
		return roll_lose_or_tie(die)
	elseif author.Username == "daghack" then
		return roll_win_or_tie(die)
	end
	return fair_roll(die)
end

function handler(msg, args)
	local resp = ""
	local i = "20"

	if #args >= 1 then
		local li = string.match(args[1], "(%d+)")
		if li then
			i = li
		end
	end

	local die = tonumber(i)
	if die < 1 or die > 1000 then
		send_msg(msg.ChannelID, "<@" .. msg.Author.ID .. "> Nah, bro. That's for Ayan worshippers.")
		return
	end

	local roll = cheating_roll(msg.Author, die)
	print_roll(msg.ChannelID, msg.Author, i, roll)
end
