--[[
-----------------------------------------------------------------------------------------------------------------
== TODO ==
	Add a warning for
		- Crusade
		- Repraisal
		- Enlight/Enlight II
		

-----------------------------------------------------------------------------------------------------------------
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib.lua')
	include('Icy-Include.lua')	
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('PDT', 'MDT', 'Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    --state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'HP', 'Reraise', 'Charm')
    state.MagicalDefenseMode:options('MDT', 'HP', 'Reraise', 'Charm')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')

    update_defense_mode()
    
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')

    --select_default_macro_book(15)
	set_lockstyle('1')
end

function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	organizer_items = {
		echoes="Echo Drops",
		capring="Capacity Ring",
		copper_voucher="Copper Voucher",
		silver_voucher="Silver Voucher",
		sp_key="SP Gobbie Key",
	}
	
    --------------------------------------
    -- Precast sets
    --------------------------------------
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {legs="Caballarius Breeches"}
    sets.precast.JA['Holy Circle'] = {} --feet="Reverence Leggings"
    sets.precast.JA['Shield Bash'] = {hands="Caballarius Gauntlets"} --ear1="Knightly earring"
    sets.precast.JA['Sentinel'] = {feet="Caballarius Leggings"}
    sets.precast.JA['Rampart'] = {head="Caballarius Coronet"}
    sets.precast.JA['Fealty'] = {body="Caballarius Surcoat"}
    sets.precast.JA['Divine Emblem'] = {feet="Creed Sabatons +2"}
    sets.precast.JA['Cover'] = {} --head="Reverence Coronet"

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
        -- head="Reverence Coronet",
        body="Caballarius Surcoat",
	}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {} 
    sets.precast.Flourish1 = {} 

    -- Fast cast sets for spells
    -- Cap = 80%
    sets.precast.FC = {
	    main="Sakpata's Sword",
		sub="Aegis",
		ammo="Staunch Tathlum +1",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
		neck="Baetyl Pendant",
		waist="Flume Belt +1",
		--left_ear="Enchntr. Earring +1",
		--right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Kishar Ring",
		back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','Damage taken-5%',}},
	}
	
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash"
	})
	
	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {

	})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
    ammo="Aurgelmir Orb +1",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Fotia Gorget",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Ishvara Earring",
    right_ear="Thrud Earring",
    left_ring="Epaminondas's Ring",
    right_ring="Regal Ring",
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','Damage taken-5%',}},
	}

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
	-- Mod: 80% DEX
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, { })
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], { })
	
	-- Deals property-less damage (not Magic or Physical), but uses regular physical damage equations. 
	-- Mod: 73~85% MND
    sets.precast.WS['Requiescat'] = { 

	}
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], { })

	-- dSTAT: (pINT-mINT)*2
	-- Mod: 50% MND / 30% STR
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS["Requiescat"], {

	})
    
	-- Damage dealt is based on Enmity, capping out at Player Level*10 damage.
	-- Weapon Skill Damage equipment applies to both hits.
    sets.precast.WS['Atonement'] = set_combine(sets.precast.WS, sets.midcast.Enmity)
    
	
	
    --------------------------------------
    -- Midcast sets
    --------------------------------------
	
	-- Cap gear haste
    sets.midcast.FastRecast = {

	}
        
    sets.midcast.Enmity = {
	main="Brilliance",
	sub="Aegis",
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Moonlight Necklace",
    waist="Flume Belt +1",
    left_ear="Trux Earring",
    right_ear="Pluto's Pearl",
    left_ring="Apeile Ring +1",
    right_ring="Apeile Ring",
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','Damage taken-5%',}},
	}
	
	sets.midcast.Stun = sets.midcast.Enmity
	
    sets.midcast.Cure = set_combine(sets.midcast.Enmity, {

	})

    sets.midcast['Enhancing Magic'] = {
		main="Brilliance",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
		neck="Incanter's Torque",
		waist="Flume Belt +1",
		left_ear="Sanare Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
	    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','Damage taken-5%',}},
	}
    
	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
		main="Sakpata's Sword",
	    ammo="Staunch Tathlum +1",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hand="Souv. Handsch. +1",
		legs="Sakpata's Cuisses",
		feet="Odyssean Greaves",
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
	
	})
	
	sets.midcast['Blue Magic'] = set_combine(sets.midcast.Enmity, {
	    ammo="Staunch Tathlum +1",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Founder's Hose", augments={'MND+8','Mag. Acc.+14','Attack+13','Breath dmg. taken -3%',}},
		feet="Odyssean Greaves",
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
	})
	
	-- Divine magic to enhance Enlight
	sets.midcast['Divine Magic'] = {

	}
	
	sets.midcast['Flash'] = set_combine(sets.midcast['Divine Magic'], sets.midcast.Enmity)
	
    sets.midcast.Protect = set_combine(sets.midcast["Enhancing Magic"], {ring1="Sheltered Ring"})
    sets.midcast.Shell = set_combine(sets.midcast["Enhancing Magic"], {ring1="Sheltered Ring"})
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
	
    -- Idle sets
    sets.idle = {
    main="Brilliance",
    sub="Aegis",
    ammo="Staunch tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Kgt. Beads +2",
    waist="Flume Belt +1",
    left_ear="Sanare Earring",
    right_ear="Odnowa Earring +1",
	left_ring="Moonlight Ring",
	right_ring="Moonlight Ring",
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','Damage taken-5%',}},
	}

    sets.idle.Town = set_combine(sets.idle, {})
    
    sets.idle.Weak = set_combine(sets.idle, {})
    
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
    
    sets.Kiting = {feet="Hippomenes Socks"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

	sets.resting = set_combine(sets.idle, {})
	
	
    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {} -- back="Repulse Mantle"
    sets.MP = {neck="Coatl Gorget +1",waist="Flume Belt +1"}
    sets.MP_Knockback = {waist="Flume Belt +1"} -- back="Repulse Mantle"
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {main="Brilliance", sub="Ochain"}
    sets.MagicalShield = {main="Almace", sub="Aegis"} 

    -- Basic defense sets.
    -- Source: https://www.bg-wiki.com/bg/Damage_Taken
	-- -50% cap on the various types of damage taken. 
	-- There is an overall cap of -87.5% damage taken, including sources that bypass the other caps.
    sets.defense.PDT = {
    ammo="Staunch tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Kgt. Beads +2",
    waist="Flume Belt +1",
    left_ear="Sanare Earring",
    right_ear="Odnowa Earring +1",
	left_ring="Moonlight Ring",
	right_ring="Moonlight Ring",
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','Damage taken-5%',}},
		-- Gear totals: 
		--	DEF				627
		-- 	PDT 		   -50%
		--	MDT 		   -47%
		--	MDB			  	12%
		--	MEva			320
		--	Enmity			18%
		--	Haste 			22%
		--	Dmg to MP 		 7%
		--	Convert to MP	 3%
		--	Shield skill	10%
		--	Resist Elements	25%
		--	Block chance	 2%
		--	Cure Pot. Rec.	10%
		--	HP				617
		--	VIT				155
		--	Acc				130
	}
    sets.defense.HP = sets.defense.PDT
    sets.defense.Reraise = set_combine(sets.defense.PDT, sets.Reraise)
    sets.defense.Charm = {neck="Unmoving Collar"}
	
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
	-- (I assume I will always have Shellra V)
    sets.defense.MDT = {
    ammo="Staunch tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Kgt. Beads +2",
    waist="Flume Belt +1",
    left_ear="Sanare Earring",
    right_ear="Odnowa Earring +1",
	left_ring="Moonlight Ring",
	right_ring="Moonlight Ring",
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','Damage taken-5%',}},
	}


    --------------------------------------
    -- Engaged sets
    --------------------------------------
    -- acc = 1019, DA = 22%, Haste = 22%
    sets.engaged = {
	    -- ammo="Aurgelmir Orb +1",
		-- head="Flam. Zucchetto +2",
		-- body={ name="Valorous Mail", augments={'Accuracy+26','"Dbl.Atk."+5','STR+1',}},
		-- hands="Sulev. Gauntlets +2",
		-- legs="Sulev. Cuisses +2",
		-- feet="Flam. Gambieras +2",
		-- neck="Combatant's Torque",
		-- waist="Windbuffet Belt +1",
		-- left_ear="Brutal Earring",
		-- right_ear="Mache Earring +1",
		-- left_ring="Flamma Ring",
		-- right_ring="Petrov Ring",
		-- back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','DEF+8',}},
	
		ammo="Staunch tathlum +1",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Kgt. Beads +2",
		waist="Flume Belt +1",
		left_ear="Sanare Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','Damage taken-5%',}},
	}

	-- acc = 1049, DA = 19%
    sets.engaged.Acc = {
    ammo="Staunch tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Kgt. Beads +2",
    waist="Flume Belt +1",
    left_ear="Sanare Earring",
    right_ear="Odnowa Earring +1",
	left_ring="Moonlight Ring",
	right_ring="Moonlight Ring",
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','Damage taken-5%',}},
	}
	
	sets.engaged.PDT = sets.defense.PDT
    sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {})
	
	sets.engaged.MDT = sets.defense.MDT
    sets.engaged.Acc.MDT = set_combine(sets.engaged.MDT, {})
	
	sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)
	
    sets.engaged.DW = set_combine(sets.engaged, {})
    sets.engaged.DW.Acc = set_combine(sets.engaged.Acc, {})
	
	sets.engaged.DW.PDT = set_combine(sets.engaged.PDT, {})
    sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.Acc.PDT, {})
	
	sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)
	

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {} -- ring2="Saida Ring"
    sets.buff.Cover = {body="Caballarius Surcoat"} -- head="Reverence Coronet"
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end


function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end
    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' and 
		   player.equipment.sub ~= 'Ajax' and player.equipment.sub ~= 'Priwen' then
			state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(4, 15)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 2)
    elseif player.sub_job == 'RDM' then
        set_macro_page(3, 2)
    else
        set_macro_page(10, 15)
    end
end

function set_lockstyle(num)
	send_command('wait 2; input /lockstyleset '..num)
end