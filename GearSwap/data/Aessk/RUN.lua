
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
================  SR  ====================
1st Boss
	Arciela: Tenebrae, Barfire/amnesia
	Ingrid: Tenebrae, Barfire/amnesia
	Darrcuiln: Gelus, Barstone/petrify		


2nd Boss
	Rosulatia: Flabra, Barstone/petrify
	Teodor: Lux, Baraero/silence
	Morimar: Ignis, Barblizzard


3rd Boss
	Super Arciela: Tenebrae, Barfire/amnesia
	August: Tenebrae, Barthunder/amnesia
	Sajj'aka: Tenebrae, Barblizzard/paralyze
=========================================
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
	
	-- Organizer library
	include('organizer-lib.lua')
end


-- Setup vars that are user-independent.
function job_setup()
    -- Table of entries
    rune_timers = T{}
    -- entry = rune, index, expires
    
    if player.main_job_level >= 65 then
        max_runes = 3
    elseif player.main_job_level >= 35 then
        max_runes = 2
    elseif player.main_job_level >= 5 then
        max_runes = 1
    else
        max_runes = 0
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'DD', 'Acc', 'PDT', 'MDT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT')
    state.IdleMode:options('Regen', 'Refresh', 'Pulling')

	gear.weaponskill_waist = "Fotia Belt"
	gear.weaponskill_neck = "Fotia Gorget"
	--select_default_macro_book()
	set_lockstyle('55')
end


function init_gear_sets()	
	organizer_items = {
		main="Macbain",
		sub="Forefathers' Grip",
		main="Aettir",
		echos="Echo Drops",
		shihei="Shihei",
		capring="Capacity Ring"
	}

    sets.enmity = {
		ammo="Aqreqaq Bomblet",
		head="Highwing Helm",
		body="Passion Jacket",
		hands="Kurys Gloves",
		legs="Erilaz Leg Guards",
		feet="Erilaz Greaves",
		neck="Unmoving Collar",
		waist="Goading Belt",
		left_ear="Friomisi Earring",
		left_ring="Petrov Ring",
		right_ring="Begrudging Ring",
		back="Mubvum. Mantle",
	}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = {
		body="Runeist coat +1",
		legs="Futhark trousers +1"}
		
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = {feet="Runeist bottes +1"}
    sets.precast.JA['Battuta'] = {head="Futhark Bandeau +1"}
    sets.precast.JA['Liement'] = {body="Futhark Coat +1"}
    sets.precast.JA['Lunge'] = {
		ammo="Grenade Core",
		head={ name="Herculean Helm", augments={'Accuracy+4','"Mag.Atk.Bns."+19','Accuracy+9 Attack+9','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Mag. Acc.+11','"Mag.Atk.Bns."+12',}},
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Acumen Ring",
		right_ring="Regal Ring",
		--back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+14','"Dbl.Atk."+1','Damage taken-4%',}},
	}
		
    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands="Runeist Mitons +1"}
    sets.precast.JA['Rayke'] = {feet="Futhark Boots"}
    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat +1"}
    sets.precast.JA['Swordplay'] = {hands="Futhark Mitons"}
    sets.precast.JA['Embolden'] = {back="Evasionist's Cape"}
    sets.precast.JA['Vivacious Pulse'] = {head="Erilaz Galea"}
    sets.precast.JA['One For All'] = {}
    sets.precast.JA['Provoke'] = sets.enmity


	-- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Impatiens",
		head="Rune. Bandeau +1",
		body="Dread Jupon",
		hands="Leyline Gloves",
		legs="Orvail Pants +1",
		left_ear="Enchntr. Earring +1",
		right_ear="Loquac. Earring",
		left_ring="Prolix Ring",
		right_ring="Veneficium Ring"
	}
    
	sets.precast.FC['Enhancing Magic'] = {
		waist="Siegel Sash"
	}
		
    sets.precast.FC['Utsusemi: Ichi'] = set_combine(sets.precast.FC, {
		neck='Magoraga beads'
	})
	
    sets.precast.FC['Utsusemi: Ni'] = set_combine(sets.precast.FC['Utsusemi: Ichi'], {})
	
	-- Weaponskill sets
	
	-- Resolution 73%~85% STR, Breeze, Thunder, Soil 
    sets.precast.WS['Resolution'] = {
    ammo="Knobkierrie",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Epona's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
    
	sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'].Normal, {
	})
    
	-- Dimidiation 90% DEX, Breeze, Thunder
	sets.precast.WS['Dimidiation'] = {
		ammo="Knobkierrie",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','CHR+3','Accuracy+15','Attack+13',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Mecisto. Mantle", augments={'Cap. Point+48%','MP+27','DEF+10',}},
	}
		
    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'].Normal, {
	
	})

	-- Herculean Slash 80% VIT, MAB
	sets.precast.WS['Herculean Slash'] = set_combine(sets.precast['Lunge'], {})
    sets.precast.WS['Herculean Slash'].Acc = set_combine(sets.precast.WS['Herculean Slash'].Normal, {})


	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
    sets.midcast.FastRecast = {} 
	
    sets.midcast['Enhancing Magic'] = {}

	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
	
	})
    
	sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], {
		head="Runeist Bandeau +1"
	})
    
	sets.midcast['Stoneskin'] = set_combine(sets.midcast['Enhancing Magic'], {
		waist="Siegel Sash"
	})
    
	-- healing magic skill, cure potency, MND
	sets.midcast.Cure = {
		
	}

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.idle = {

	}
		
    sets.idle.Refresh = set_combine(sets.idle, {
	})
	
	sets.idle.Pulling = {
	}
		
	sets.defense.PDT = sets.idle.Pulling

	sets.defense.MDT = {}

	sets.Kiting = {feet="Skadi's Jambeaux +1"}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {
		ammo="Yamarang",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','CHR+3','Accuracy+15','Attack+13',}},
		neck="Anu Torque",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epona's Ring",
		back={ name="Mecisto. Mantle", augments={'Cap. Point+48%','MP+27','DEF+10',}},
	}
		
	-- NOTE: need 21 STP for 6 hit build
    sets.engaged.DD = {
		ammo="Aurgelmir Orb",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','CHR+3','Accuracy+15','Attack+13',}},
		neck="Anu Torque",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Epona's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
		
    sets.engaged.Acc = set_combine(sets.engaged.DD, {})
		
    sets.engaged.PDT = {
	}
		
    sets.engaged.MDT = {
	}
		
    sets.engaged.repulse = {} --back="Repulse Mantle"
	
	count_msg_mecisto = 0
end

------------------------------------------------------------------
-- Action events
------------------------------------------------------------------

function job_precast(spell)
	slot_disabling()
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        local obi = get_obi(get_rune_obi_element())
        if obi then
            equip({waist=obi})
        end
    end
end


function job_aftercast(spell)
    if not spell.interrupted then
        if spell.type == 'Rune' then
            update_timers(spell)
        elseif spell.name == "Lunge" or spell.name == "Gambit" or spell.name == 'Rayke' then
            reset_timers()
        elseif spell.name == "Swipe" then
            send_command(trim(1))
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(3, 20)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 20)
	elseif player.sub_job == 'SAM' then
		set_macro_page(2, 20)
	else
		set_macro_page(5, 20)
	end
end

function get_rune_obi_element()
    weather_rune = buffactive[elements.rune_of[world.weather_element] or '']
    day_rune = buffactive[elements.rune_of[world.day_element] or '']
    
    local found_rune_element
    
    if weather_rune and day_rune then
        if weather_rune > day_rune then
            found_rune_element = world.weather_element
        else
            found_rune_element = world.day_element
        end
    elseif weather_rune then
        found_rune_element = world.weather_element
    elseif day_rune then
        found_rune_element = world.day_element
    end
    
    return found_rune_element
end

function get_obi(element)
    if element and elements.obi_of[element] then
        return (player.inventory[elements.obi_of[element]] or player.wardrobe[elements.obi_of[element]]) and elements.obi_of[element]
    end
end


------------------------------------------------------------------
-- Timer manipulation
------------------------------------------------------------------

-- Add a new run to the custom timers, and update index values for existing timers.
function update_timers(spell)
    local expires_time = os.time() + 300
    local entry_index = rune_count(spell.name) + 1

    local entry = {rune=spell.name, index=entry_index, expires=expires_time}

    rune_timers:append(entry)
    local cmd_queue = create_timer(entry).. ';wait 0.05;'
    
    cmd_queue = cmd_queue .. trim()

    --add_to_chat(123,'cmd_queue='..cmd_queue)

    send_command(cmd_queue)
end

-- Get the command string to create a custom timer for the provided entry.
function create_timer(entry)
    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
    local duration = entry.expires - os.time()
    return 'timers c ' .. timer_name .. ' ' .. tostring(duration) .. ' down'
end

-- Get the command string to delete a custom timer for the provided entry.
function delete_timer(entry)
    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
    return 'timers d ' .. timer_name .. ''
end

-- Reset all timers
function reset_timers()
    local cmd_queue = ''
    for index,entry in pairs(rune_timers) do
        cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
    end
    rune_timers:clear()
    send_command(cmd_queue)
end

-- Get a count of the number of runes of a given type
function rune_count(rune)
    local count = 0
    local current_time = os.time()
    for _,entry in pairs(rune_timers) do
        if entry.rune == rune and entry.expires > current_time then
            count = count + 1
        end
    end
    return count
end

-- Remove the oldest rune(s) from the table, until we're below the max_runes limit.
-- If given a value n, remove n runes from the table.
function trim(n)
    local cmd_queue = ''

    local to_remove = n or (rune_timers:length() - max_runes)

    while to_remove > 0 and rune_timers:length() > 0 do
        local oldest
        for index,entry in pairs(rune_timers) do
            if oldest == nil or entry.expires < rune_timers[oldest].expires then
                oldest = index
            end
        end
        
        cmd_queue = cmd_queue .. prune(rune_timers[oldest].rune)
        to_remove = to_remove - 1
    end
    
    return cmd_queue
end

-- Drop the index of all runes of a given type.
-- If the index drops to 0, it is removed from the table.
function prune(rune)
    local cmd_queue = ''
    
    for index,entry in pairs(rune_timers) do
        if entry.rune == rune then
            cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
            entry.index = entry.index - 1
        end
    end

    for index,entry in pairs(rune_timers) do
        if entry.rune == rune then
            if entry.index == 0 then
                rune_timers[index] = nil
            else
                cmd_queue = cmd_queue .. create_timer(entry) .. ';wait 0.05;'
            end
        end
    end
    
    return cmd_queue
end

function slot_disabling()
    -- Disable slots for items you don't want removed when performing actions
    if player.equipment.head == 'Reraise Hairpin' then
        disable('head')
        windower.add_to_chat(8,'Reraise Hairpin equiped on head')
    else
        enable('head')
    end

    if player.equipment.left_ear == 'Reraise Earring' then
        disable('left_ear')
        windower.add_to_chat(8,'Reraise Earring equiped on left ear')
    else
        enable('left_ear')
    end

    if player.equipment.right_ear == 'Reraise Earring' then
        disable('right_ear')
        windower.add_to_chat(8,'Reraise Earring equiped on right ear')
    else
        enable('right_ear')
    end

    --[[ count_msg_mecisto can be adjusted to the value you want for periodic
            reminders that you have slot locked, count is incresed twice by
            most actions due to slot_disabling() being called in precast
            and again after the cast in gear_modes() ]]
    if player.equipment.back == 'Mecisto. Mantle' then
        disable('back')
        if count_msg_mecisto == 0 then
            windower.add_to_chat(8,'REMINDER:  '
                ..'Mecistopins mantle equiped on back')
        end
        count_msg_mecisto = (count_msg_mecisto + 1) % 30
    else
        enable('back')
        count_msg_mecisto = 0
    end
end

------------------------------------------------------------------
-- Reset events
------------------------------------------------------------------

windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)
windower.raw_register_event('status change',function(new, old)
    if gearswap.res.statuses[new].english == 'Dead' then
        reset_timers()
    end
end)


function set_lockstyle(num)
	send_command('wait 2; input /lockstyleset '..num)
end