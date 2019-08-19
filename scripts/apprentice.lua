reasons = {}

function keysfrom(t)
	local keyset = {}
	for k in pairs(t) do
		table.insert(keyset, k)
	end
	return keyset
end

function join(t, c)
	local len = #t
	if len == 0 then
		return ""
	end
	local toret = t[1]
	for i = 2, len do
		toret = toret .. c .. t[i]
	end
	return toret
end

function handler(msg, args)
	if #args == 0 then
		send_msg(msg.ChannelID, "Me? An apprentice? I'm a bot, silly!\nWe're all apprentices...")
		return
	end
	local userstr = join(args, " ")
	print(userstr, reasons[userstr])
	reason = reasons[userstr]
	if reason == nil then
		reason = set_reason(userstr)
	end
	send_msg(msg.ChannelID, fmt_reason(userstr, reason))
end

function fmt_reason(userstr, reason)
	local msg = "```diff\n- APPRENTICE CONFIRMRED! -```\n" .. userstr .. " is an Apprentice because " .. reason .. "!"
	return userstr .. "? Let me check my notes...\n" .. msg
end

function set_reason(userstr)
	local users = keysfrom(reasons)
	local reason = ""
	if #users < 2 then
		reason = base_reason()
	else
		c = { base_reason, base_reason, associate_reason }
		reason = c[math.random(3)]()
	end
	reasons[userstr] = reason
	return reason
end

function base_reason()
	local common = {
		"they've been seen dining with Ayan, making fun of the Returned",
		"rumor has it they have an hourglass tattoo on their hand",
		"I've seen them doodling hearts around Ayan's name in the tavern"
	}
	local uncommon = {
		"rumor has it they've been spotted using Dream Magic. Since Dream Magic is illegal, we know that only Apprentices use it",
		"they play **WAY** too much chess",
		"people have seen them sleeping, and that's something only an Apprentice would do"
	}
	local rare = {
		"they've been seen wearing red, and only Apprentices wear red",
		"when they woke up this morning, the word 'Apprentice' was scrawled on their forehead",
		"we all know they worship the Moon, and the Moon only comes out when Ayan comes out"
	}
	local choice_set = {common, common, common, uncommon, uncommon, rare}
	local br = choice_set[math.random(#choice_set)]
	return br[math.random(#br)]
end

function associate_reason()
	local ar_1 = {
		"they're known friends with",
		"they've been seen around",
		"everybody has heard them talking to"
	}
	local ar_2 = {
		". It's obvious",
		". Everybody knows",
		". It's common knowledge",
		" and rumor has it"
	}
	local c1 = ar_1[math.random(#ar_1)]
	local c2 = ar_2[math.random(#ar_2)]
	local users = keysfrom(reasons)
	local user = users[math.random(#users)]
	return c1 .. " " .. user .. c2 .. " that " .. user .. " is an Apprentice!"
end
