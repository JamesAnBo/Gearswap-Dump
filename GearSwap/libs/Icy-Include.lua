-- register_event for multi_use_item method
windower.register_event('chat message', function(original, sender, mode, gm)
	local match
	if sender == player.name then
		if string.match(original, "use ") then
			multi_use_item(original)
			--test()
		end
	end
	return sender, mode, gm
end)

function test()
	for i=1, 10 do
		sleep(5)
		add_to_chat(8, "test")
	end
	
end

-- Usage:		/tell <me> use 'Name Of Item' waitNumber(optional, default 3sec)
-- Example: 	/tell <me> use 'Bead Pouch' 4
function multi_use_item(cmd)
	--add_to_chat(8, 'CMD: '..cmd)
	
	splat = {}
	for word in cmd:gmatch("%w+") do table.insert(splat, word) end
	
	item = cmd:match("'[^!]*'")
	if item then
		item = item:gsub("%'", "")
	else
		item = cmd:match('"[^!]*"')
		if item then
			item = item:gsub('%"', '')
		else
			item = splat[2]
		end
	end 
	
	useWait = 3 --default 3 sec
	lastCmdVal = tonumber(splat[table.getn(splat)])
	if type(lastCmdVal)=="number" then
		useWait = lastCmdVal
	end
	--add_to_chat(8, 'item='..item..' wait='..useWait)
	
    if player.inventory[item] then
		NItem = player.inventory[item].count
		bag = windower.ffxi.get_bag_info(0).count
		max = windower.ffxi.get_bag_info(0).max
		spots = max-bag
		if spots > 0 then
			add_to_chat(204, '*-*-*-*-*-*-*-*-* [ '..NItem..'x '..item..' to open - Inventory('..bag..'/'..max..') ] *-*-*-*-*-*-*-*-*')
			local nextcommand = ""
			for i=1, NItem do
				nextcommand = nextcommand .. ' input /item "'..item..'" <me>; wait '..useWait..';'
			end
			
			nextcommand = nextcommand .. ' input /tell '..player.name..' use "'..item..'" '..useWait..';'
			--add_to_chat(8, nextcommand)
			
			send_command(nextcommand)
		else
			add_to_chat(204, '*-*-*-*-*-*-*-*-* [ Inventory('..bag..'/'..max..') ] *-*-*-*-*-*-*-*-*')
		end
    else
        add_to_chat(204, '*-*-*-*-*-*-*-*-* [ No '..item..' in inventory ] *-*-*-*-*-*-*-*-*')
    end
end



-- Sleep Timers
function sleep_timers(spell)	
	if spell.name == "Sleep II" or spell.name == "Sleepga II" or spell.name == "Repose" or spell.name == "Dream Flower" or spell.name == "Yawn" then
		windower.send_command('wait 75;input /echo [ WARNING! '..spell.name..' : Will wear off within 0:15 ]')
		windower.send_command('wait 80;input /echo [ WARNING! '..spell.name..' : Will wear off within 0:10 ]')
		windower.send_command('wait 85;input /echo [ WARNING! '..spell.name..' : Will wear off within 0:05 ]')
	elseif spell.name == "Sleep" or spell.name == "Sleepga" then
		windower.send_command('wait 45;input /echo [ WARNING! '..spell.name..' : Will wear off within 0:15 ]')
		windower.send_command('wait 50;input /echo [ WARNING! '..spell.name..' : Will wear off within 0:10 ]')
		windower.send_command('wait 55;input /echo [ WARNING! '..spell.name..' : Will wear off within 0:05 ]')
	end
end