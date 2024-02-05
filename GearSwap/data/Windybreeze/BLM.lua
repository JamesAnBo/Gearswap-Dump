-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')

end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function job_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Mid', 'Resistant', 'Proc')
    state.IdleMode:options('Normal', 'PDT')
  
  	MagicBurstIndex = 0
    state.MagicBurst = M(false, 'Magic Burst')
	state.TreasureHunter = M(false, 'TH')
	state.ConsMP = M(false, 'Conserve MP')
	state.Death = M{['description'] = 'Death Mode', false, 'Death Mode'}

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

    
    -- Additional local binds
    send_command('bind ^` input //gs disable back;input /equip back "Mecistopins Mantle"')
    send_command('bind @` gs c toggle MagicBurst')

	custom_timers = {}

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {feet="Goetia Sabots +2"}

    sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {
	    main={ name="Grioavolr", augments={'"Fast Cast"+4','Mag. Acc.+22','"Mag.Atk.Bns."+17','Magic Damage +3',}},
		sub="Niobid Strap",
		ammo="Sapience Orb",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+3%','"Mag.Atk.Bns."+12',}},
		body="Zendik Robe",
		hands="Jhakri Cuffs +1",
		legs="Orvail Pants +1",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+4%','MND+5','"Mag.Atk.Bns."+9',}},
		neck="Incanter's Torque",
		waist="Channelar's Stone",
		left_ear="Etiolation Earring",
		right_ear="Hermetic Earring",
		left_ring="Kishar Ring",
		right_ring="Lebeche Ring",
		back="Perimede Cape",
	}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})


    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear1="Barkarole earring"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris",legs="Doyen pants", back="Pahtli Cape"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {}


    ---- Midcast Sets ----

    sets.midcast.FastRecast = {
        head=gear.nuke_head,neck="Voltsurge torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
        body="Shango Robe",hands="Helios gloves",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Psycloth lappas",feet="Amalric nails"}

    sets.midcast.Cure = {
        head="Telchine cap",neck="Incanter's Torque",ear1="Roundel earring",ear2="Beatific Earring",
        body="Vrikodara jupon",hands="Telchine Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Solemnity cape",waist="Bishop's sash",legs="Telchine braconi",feet="Vanya clogs"}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
	head="Telchine cap",neck="Incanter's Torque",ear1="Andoaa earring",
      body="Telchine Chasuble",hands="Telchine gloves",
      back="Fi follet cape",waist="Olympus sash",legs="Telchine Braconi",feet="Telchine pigaches"}
    
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],
		{head="Amalric coif"})

	sets.midcast.Haste = set_combine(sets.midcast['Enhancing Magic'], 
		{ammo="Sapience orb",
		neck="Voltsurge torque",ear1="Enchanter earring +1",ear2="Loquacious earring",
		ring1="Prolix ring",
		back="Swith cape +1",waist="Ninurta's sash"})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
		{head="Amalric coif",waist="Emphatikos Rope"})

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], 
		{waist="Siegel Sash",neck="Nodens gorget"})

    sets.midcast['Enfeebling Magic'] = {}
        
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], { })	

    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'],{ring1="Evanescence Ring",
        waist="Fucho-no-obi"})
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {}

    --Death sets
    sets.precast.FC['Death'] = {}
    
    sets.midcast['Death'] = {}
        --death specific MB set
    sets.MB_death = {}

    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
		main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Niobid Strap",
		ammo="Ghastly Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+3%','"Mag.Atk.Bns."+12',}},
		body={ name="Merlinic Jubbah", augments={'Phys. dmg. taken -1%','"Mag.Atk.Bns."+28','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
		hands="Jhakri Cuffs +1",
		legs={ name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+30','Magic Damage +9','Mag. Acc.+6',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+4%','MND+5','"Mag.Atk.Bns."+9',}},
		neck="Mizu. Kubikazari",
		waist="Eschan Stone",
		left_ear="Regal Earring",
		right_ear="Hermetic Earring",
		left_ring="Jhakri Ring",
		right_ring="Stikini Ring +1",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},
	}

	sets.midcast['Elemental Magic'].Mid = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'].Mid, 
		{
		neck="Incanter's torque"})


    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], 
		{})
	sets.midcast['Elemental Magic'].HighTierNuke.Mid = set_combine(sets.midcast['Elemental Magic'].HighTierNuke, 
		{})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].HighTierNuke.Mid, 
		{neck="Incanter's Torque"})

    sets.midcast.Impact = {}



    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {}

	sets.magic_burst = {}

     sets.Obi = {back="Twilight Cape",waist='Hachirin-no-Obi'}
       
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {    
		main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Niobid Strap",
		ammo="Amar Cluster",
		head="Befouled Crown",
		body="Jhakri Robe +2",
		hands={ name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		legs="Assid. Pants +1",
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck="Twilight Torque",
		waist="Porous Rope",
		left_ear="Etiolation Earring",
		right_ear="Dominance Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Solemnity Cape",}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {}
	
    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {}
    
    -- Town gear.
    sets.idle.Town = set_combine(sets.idle,{feet="Herald's gaiters"})
        
    -- Defense sets
	
	sets.TreasureHunter = {waist="Chaac Belt"}
	sets.ConsMP = {body="Spaekona's coat +1"}

    sets.defense.PDT = {main="Mafic cudgel",sub="Genmei shield",ammo="Brigantia pebble",
        head="Befouled crown",neck="Loricate torque",ear1="Genmei earring",ear2="Impregnable Earring",
        body="Vrikodara jupon",hands="Telchine gloves",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity cape",waist="Slipor sash",legs=gear.merllegs_pdt,feet="Battlecast Gaiters"}

    sets.defense.MDT = {main="Mafic cudgel",sub="Genmei shield",ammo="Vanir Battery",
        head="Amalric coif",neck="Loricate torque",ear1="Sanare earring",ear2="Zennaroi earring",
        body=gear.nuke_body,hands="Telchine gloves",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity Cape",waist="Slipor sash",legs=gear.merllegs_pdt,feet="Vanya clogs"}

    sets.Kiting = {feet="Herald's gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head="Befouled crown",neck="Loricate torque",ear1="Sanare Earring",ear2="Zennaroi Earring",
        body="Onca suit",hands=empty,ring1="Rajas Ring",
        back="Repulse Mantle",waist="Ninurta's sash",legs=empty,feet=empty}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Impact" then
        equip({head=empty,body="Twilight Cloak"})
	end
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Hachirin-no-obi"
    elseif spell.skill == 'Elemental Magic' then
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
end

function job_precast(spell, action, spellMap, eventArgs)
	if state.Death.value then
		equip(sets.precast.FC['Death'])
        eventArgs.handled = true
	end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	equipSet = {}
	if spell.type:endswith('Magic') or spell.type == 'Ninjutsu' or spell.type == 'BardSong' then
			equipSet = sets.midcast
		if state.Death.value then
			equipSet = equipSet['Death']
			eventArgs.handled = true
		end

	elseif string.find(spell.english,'Cure') then
			equipSet = equipSet.Cure
	elseif string.find(spell.english,'Cura') then
			equipSet = equipSet.Curaga
	elseif string.find(spell.english,'Banish') then
			equipSet = set_combine(equipSet.MndEnfeebles)
	elseif spell.english == "Stoneskin" then
	  equipSet = equipSet.Stoneskin
			if buffactive.Stoneskin then
					send_command('cancel stoneskin')
		end
	elseif spell.english == "Sneak" then
			if spell.target.name == player.name and buffactive['Sneak'] then
					send_command('cancel sneak')
			end
			equipSet = equipSet.Haste
	elseif string.find(spell.english,'Utsusemi') then
			if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
					send_command('@wait 1.7;cancel Copy Image*')
			end
			equipSet = equipSet.Haste
	elseif spell.english == 'Monomi: Ichi' then
			if buffactive['Sneak'] then
					send_command('cancel sneak')
			end
			equipSet = equipSet.Haste

	else
		if equipSet[spell.english] then
				equipSet = equipSet[spell.english]
		end
		if equipSet[spell.skill] then
				equipSet = equipSet[spell.skill]
		end
		if equipSet[spell.type] then
				equipSet = equipSet[spell.type]
		end
		
		if string.find(spell.english,'Cure')  and (world.weather_element == spell.element) or  (world.day_element == spell.element) then
				equipSet = set_combine(equipSet,sets.Obi)
		end    
		if ((spell.english == 'Drain') or (spell.english == 'Aspir')) and ((world.day_element == spell.element) or (world.weather_element == spell.element)) then
				equipSet = set_combine(equipSet,sets.Obi)
		end  
	end
	
    if equipSet[spell.english] then
        equipSet = equipSet[spell.english]
    end
    equip(equipSet)
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
	   if spell.skill == 'Elemental Magic' then
			if spell.element == world.day_element or spell.element == world.weather_element then
			equip(equipSet, sets.Obi)
			if string.find(spell.english,'helix') then
							equip(sets.midcast.Helix)
			end
		end
	   end
	if spell.skill == 'Elemental Magic' and state.ConsMP.value then
		equip(sets.ConsMP)
	end
    --Death specific MB rule
    if spell.english == 'Death' and state.Death.value and state.MagicBurst.value then
        equip(set_combine(sets.midcast['Death'],sets.MB_death))
    end

	if not spell.interrupted then
                if spell.english == "Sleep II" or spell.english == "Sleepga II" then -- Sleep II Countdown --
                        send_command('wait 60;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
                elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
                        send_command('wait 30;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
                elseif spell.english == "Break" then -- Break Countdown --
                        send_command('wait 25;input /echo Break Effect: [WEARING OFF IN 5 SEC.]')
                                elseif spell.english == "Paralyze" then -- Paralyze Countdown --
                                                send_command('wait 115;input /echo Paralyze Effect: [WEARING OFF IN 5 SEC.]')
                                elseif spell.english == "Slow" then -- Slow Countdown --
                                                send_command('wait 115;input /echo Slow Effect: [WEARING OFF IN 5 SEC.]')
                                
                end
        end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        end
    elseif spell.skill == 'Enhancing Magic' then
            adjust_timers(spell, spellMap)
	end
end



function adjust_timers(spell, spellMap)
    local current_time = os.time()
    
    local temp_timer_list = {}
    local dur = calculate_duration(spell, spellName, spellMap)
         custom_timers[spell.name] = nil
         send_command('timers delete "'..spell.name..' ['..spell.target.name..']"')
         custom_timers[spell.name] = current_time + dur
         send_command('@wait 1;timers create "'..spell.name..' ['..spell.target.name..']" '..dur..' down')
end



function calculate_duration(spell, spellName, spellMap)

    local mult = 1.00

	if player.equipment.Head == 'Telchine Cap' then mult = mult + 0.09 end
	if player.equipment.Body == 'Telchine Chas.' then mult = mult + 0.09 end
	if player.equipment.Hands == 'Telchine Gloves' then mult = mult + 0.09 end
	if player.equipment.Legs == 'Telchine Braconi' then mult = mult + 0.09 end
	if player.equipment.Feet == 'Telchine Pigaches' then mult = mult + 0.08 end
	
	if player.equipment.Feet == 'Estq. Houseaux +2' then mult = mult + 0.20 end
	if player.equipment.Legs == 'Futhark Trousers' then mult = mult + 0.10 end
	if player.equipment.Legs == 'Futhark Trousers +1' then mult = mult + 0.20 end
	if player.equipment.Hands == 'Atrophy Gloves' then mult = mult + 0.15 end
	if player.equipment.Hands == 'Atrophy Gloves +1' then mult = mult + 0.16 end
	if player.equipment.Back == 'Estoqueur\'s Cape' then mult = mult + 0.10 end
	if player.equipment.Hands == 'Dynasty Mitts' then mult = mult + 0.05 end
	if player.equipment.Body == 'Shabti Cuirass' then mult = mult + 0.09 end
	if player.equipment.Body == 'Shabti Cuirass +1' then mult = mult + 0.10 end
	if player.equipment.Feet == 'Leth. Houseaux' then mult = mult + 0.25 end
	if player.equipment.Feet == 'Leth. Houseaux +1' then mult = mult + 0.30 end


	local base = 0

	if spell.name == 'Haste' then base = base + 180 end
	if spell.name == 'Stoneskin' then base = base + 300 end
	if string.find(spell.name,'Bar') then base = base + 480 end
	if spell.name == 'Blink' then base = base + 300 end
	if spell.name == 'Aquaveil' then base = base + 600 end
	if string.find(spell.name,'storm') then base = base + 180 end
	if spell.name == 'Auspice' then base = base + 180 end
	if string.find(spell.name,'Boost') then base = base + 300 end
	if spell.name == 'Phalanx' then base = base + 180 end
	if string.find(spell.name,'Protect') then base = base + 1800 end
	if string.find(spell.name,'Shell') then base = base + 1800 end
	if string.find(spell.name,'Refresh') then base = base + 150 end
	if string.find(spell.name,'Regen') then base = base + 60 end
	if spell.name == 'Adloquium' then base = base + 180 end
	if string.find(spell.name,'Animus') then base = base + 180 end
	if spell.name == 'Crusade' then base = base + 300 end
	if spell.name == 'Embrava' then base = base + 90 end
	if string.find(spell.name,'En') then base = base + 180 end
	if string.find(spell.name,'Flurry') then base = base + 180 end
	if spell.name == 'Foil' then base = base + 30 end
	if string.find(spell.name,'Gain') then base = base + 180 end
	if spell.name == 'Reprisal' then base = base + 60 end
	if string.find(spell.name,'Temper') then base = base + 180 end
	if string.find(spell.name,'Spikes') then base = base + 180 end

	if buffactive['Perpetuance'] then
		if player.equipment.Hands == 'Arbatel Bracers' then
			mult = mult*2.5
		elseif player.equipment.Hands == 'Arbatel Bracers +1' then
			mult = mult*2.55
		else
			mult = mult*2
		end
	end

	if buffactive['Composure'] then
		if spell.target.type == 'SELF' then
			mult = mult*3
		else
			mult = mult
		end
	end
			
			

    local totalDuration = math.floor(mult*base)

	--print(totalDuration)


    return totalDuration

end
-- Function to reset timers.

function reset_timers()

    for i,v in pairs(custom_timers) do

        send_command('timers delete "'..i..'"')

    end

    custom_timers = {}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------


-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
        handle_equipping_gear(player.status)
    end
	if buff == "Commitment" and not gain then
		equip({ring2="Capacity Ring"})
		if player.equipment.right_ring == "Capacity Ring" then
			disable("ring2")
			send_command('@wait 9; input /item "Capacity Ring" <me>;')
		else
			enable("ring2")
		end
	end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Death.value then
        idleSet = set_combine(idleSet, sets.midcast['Death'])
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

function job_status_change(newStatus, oldStatus, eventArgs)
end
-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 19)
end