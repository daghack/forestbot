math.randomseed(os.time())
function handler(msg)
	local category = {"singular", "plural"}
	local c = random_from(category)

	local article = {singular = {"a", "the"}, plural = {"the", "all the", "one of the"}}
	local a = random_from(article[c])

	local subject = {
		singular = {
			"dragon",
			"raspberry",
			"fruit tree",
			"dancer",
			"mildew",
			"thistle",
			"dream",
			"peacock",
			"bird",
			"wayward goat",
			"fae"
		},
		plural = {
			"dragons",
			"raspberries",
			"fruit trees",
			"dancers",
			"mildew",
			"thistles",
			"dreams",
			"peacocks",
			"birds",
			"wayward goats"
		}
	}
	local s = random_from(subject[c])

	local object = {
		"upside-down",
		"rotting",
		"twisting",
		"falling down",
		"running away",
		"dancing",
		"spinning",
		"melting",
		"praising Ayan",
		"flowing from Paradox",
		"waving",
		"pink",
		"blue",
		"colorful",
		"rainbow"
	}
	local o = random_from(object)

	local joining = {
		singular = {
			"is",
			"will be",
			"might be",
			"is definitely",
			"can be",
			"isn't",
			"will never be",
			"will always be"
		},
		plural = {
			"are",
			"will be",
			"might be",
			"are definitely",
			"can be",
			"aren't",
			"will never be",
			"will always be"
		}
	}
	local j = random_from(joining[c])

	local resp = a .. " " .. s .. " " .. j .. " " .. o

	send_msg(msg.ChannelID, resp)
end

function random_from(t)
	return t[math.random(#t)]
end
