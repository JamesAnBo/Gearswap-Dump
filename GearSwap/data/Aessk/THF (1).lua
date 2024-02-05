-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
--[[
    Custom commands:
 
    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
     
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime
 
--]]
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
     
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
end
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    state.HasteMode = M{['description']='Haste Mode', 'Haste I', 'Haste II'}
    state.MarchMode = M{['description']='March Mode', 'Trusts', '3', '7', 'Honor'}
     
    include('Mote-TreasureHunter')
    determine_haste_group()
 
    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc', 'MaxAcc')
    state.HybridMode:options('Normal', 'PDT') -- 'Evasion'
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT') -- 'Evasion'
    state.IdleMode:options('Normal', 'Regen', 'STP')
	state.CP = M(false, "Capacity Points Mode")
	state.Warp = M(false, "Warp Ring")
	--state.Fish = M(false, "Fish")
     
 
    -- Additional local binds
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')
    send_command('bind !f9 gs c cycle HasteMode')
    send_command('bind !f11 gs c cycle MarchMode')
	send_command('bind ![ gs equip sets.defense.PDT')
	send_command('bind !] gs equip sets.defense.MDT')
     

 
    select_default_macro_book()
     
    target_distance = 6.9 -- Set Default Distance Here --
end
 
-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind !-')
    send_command('unbind ^=')
    send_command('unbind !f9')
    send_command('unbind !f10')
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------
 
    sets.TreasureHunter = {hands="Plunderer's Armlets +1",feet="Skulker's Poulaines +1"}
    sets.ExtraRegen = {}
    sets.Kiting = {}
 
    sets.buff['Sneak Attack'] = {}
 
    sets.buff['Trick Attack'] = {}
 
    -- Actions we want to use to tag TH.
    sets.precast.Step = set_combine(sets.TreasureHunter, {})
    sets.precast.Flourish1 = set_combine(sets.TreasureHunter, {})
    sets.precast.JA.Provoke = set_combine(sets.TreasureHunter, {})
 
    ------------------------------------------------------------------------------------------
    -------------------------------------- Precast sets --------------------------------------
    ------------------------------------------------------------------------------------------
 
    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Skulker's Bonnet +1"}
    sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet +1"}
    sets.precast.JA['Assassins Charge'] = {feet="Plunderer's Poulaines +3"}
    sets.precast.JA['Ambush'] = {}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +1"}
    sets.precast.JA['Hide'] = {body="Pillager's Vest +3"}
    sets.precast.JA['Conspirator'] = {body="Skulker's Vest +1"}
    sets.precast.JA['Steal'] = {ammo="Barathrum",head="Plun. Bonnet +3",hands="Pillager's Armlets +1",legs="Pillager's Culottes +3",feet="Pillager's Poulaines +1"}
    sets.precast.JA['Despoil'] = {ammo="Barathrum",feet="Skulker's Poulaines +1"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {legs="Plunderer's Culottes +3"}
    sets.precast.JA['Sneak Attack'] = set_combine(sets.buff['Sneak Attack'])
    sets.precast.JA['Trick Attack'] = set_combine(sets.buff['Trick Attack'])
    sets.precast.JA['Mug'] = set_combine(sets.buff['Sneak Attack'])
     
    organizer_items = {}
 
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		ammo="Yamarang",
		head="Mummu Bonnet +2",
		body="Passion Jacket",
		hands="Meg. Gloves +2",
		legs={ name="Plun. Culottes +3", augments={'Enhances "Feint" effect',}},
		feet="Meg. Jam. +2",
		neck="Loricate Torque +1",
		waist="Chaac Belt",
		left_ear="Handler's Earring +1",
		right_ear="Handler's Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	} --ring1="Kunaji Ring",
 
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
    -- Fast cast sets for spells
    sets.precast.FC = {}
 
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})
 
    -- Ranged snapshot gear
    sets.precast.RA = {
		range="",
		ammo="",
		head={ name="Taeon Chapeau", augments={'Rng.Acc.+13 Rng.Atk.+13','"Snapshot"+5','"Snapshot"+5',}},
		body="Mummu Jacket +2",
		hands="Malignance Gloves",
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
		feet="Meg. Jam. +2",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Enervating Earring",
		right_ear="Telos Earring",
		left_ring="Cacoethic Ring",
		right_ring="Paqichikaji Ring",
		back={ name="Toutatis's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Snapshot"+10',}},
	}
 
    ------------------------------------------------------------------------------------------
    ------------------------------------ Weaponskill sets ------------------------------------
    ------------------------------------------------------------------------------------------
 
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="C. Palug Stone",
		head="Pill. Bonnet +3", --AF
		body="Plunderer's Vest +3", --relic
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Plun. Culottes +3",  --relic
		feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
		neck="Asn. Gorget +2",
		waist="Artful Belt +1",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}
		
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Falcon Eye",head="Pillager's Bonnet +3",waist="Grunfeld Rope"})
    sets.precast.WS.SA = set_combine(sets.precast.WS,{})
    sets.precast.WS.SA.Acc = set_combine(sets.precast.WS.SA,{})
    sets.precast.WS.TA = set_combine(sets.precast.WS.SA,{})
    sets.precast.WS.TA.Acc = set_combine(sets.precast.WS.TA,{})
    sets.precast.WS.SATA = set_combine(sets.precast.WS.SA,{})
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
     
    ------------------------------------------------------------------------------------------
    ----------------------------------- Rudra's Storm sets -----------------------------------
    ------------------------------------------------------------------------------------------
    sets.precast.WS['Rudra\'s Storm'] = {
		ammo="C. Palug Stone",
		head="Pill. Bonnet +3", --AF
		body="Plunderer's Vest +3", --relic
		hands="Meg. Gloves +2",
		legs="Plun. Culottes +3",  --relic
		feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
		neck="Asn. Gorget +2",
		waist="Artful Belt +1",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Ilabrat Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}
		
    sets.precast.WS['Rudra\'s Storm'].Acc = set_combine(sets.precast.WS['Rudra\'s Storm'], {}) 
		
    sets.precast.WS['Rudra\'s Storm'].SA = set_combine(sets.precast.WS['Rudra\'s Storm'], {ammo="Yetshila +1", legs="Lustr. Subligar +1",})
	
    sets.precast.WS['Rudra\'s Storm'].SA.Acc = set_combine(sets.precast.WS['Rudra\'s Storm'].SA, {ammo="Yetshila +1", legs="Lustr. Subligar +1",})     
    sets.precast.WS['Rudra\'s Storm'].TA = set_combine(sets.precast.WS['Rudra\'s Storm'].SA, {ammo="Yetshila +1", legs="Lustr. Subligar +1",})
    sets.precast.WS['Rudra\'s Storm'].TA.Acc = set_combine(sets.precast.WS['Rudra\'s Storm'].TA, {ammo="Yetshila +1", legs="Lustr. Subligar +1",})
    sets.precast.WS['Rudra\'s Storm'].SATA = set_combine(sets.precast.WS['Rudra\'s Storm'].SA, {ammo="Yetshila +1", legs="Lustr. Subligar +1",})
     
    ------------------------------------------------------------------------------------------
    ----------------------------------- Mandalic Stab sets -----------------------------------
    ------------------------------------------------------------------------------------------
    sets.precast.WS['Mandalic Stab'] = {
		ammo="C. Palug Stone",
		head="Pill. Bonnet +3", --AF
		body="Plunderer's Vest +3", --relic
		hands="Meg. Gloves +2",
		legs="Plun. Culottes +3",  --relic
		feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
		neck="Asn. Gorget +2",
		waist="Artful Belt +1",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Ilabrat Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}
		
    sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {})
		
    sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'], {ammo="Yetshila +1", legs="Lustr. Subligar +1",})
		
    sets.precast.WS['Mandalic Stab'].SA.Acc = set_combine(sets.precast.WS['Mandalic Stab'].SA, {ammo="Yetshila +1", legs="Lustr. Subligar +1",})   
    sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'].SA, {ammo="Yetshila +1", legs="Lustr. Subligar +1",})
    sets.precast.WS['Mandalic Stab'].TA.Acc = set_combine(sets.precast.WS['Mandalic Stab'].TA, {ammo="Yetshila +1", legs="Lustr. Subligar +1",})
    sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'].SA, {ammo="Yetshila +1", legs="Lustr. Subligar +1",})
     
    ------------------------------------------------------------------------------------------
    ------------------------------------ Evisceration sets -----------------------------------
    ------------------------------------------------------------------------------------------
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
	    ammo="Yetshila +1",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Plunderer's Vest +3",  --relic
		hands="Mummu Wrists +2",
		legs="Pill. Culottes +3",  --AF
		feet="Lustra. Leggings +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Mummu Ring",
		right_ring="Ilabrat Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	})  
		
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})        
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'], {})    
    sets.precast.WS['Evisceration'].SA.Acc = set_combine(sets.precast.WS['Evisceration'].SA, {})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].SA, {})
    sets.precast.WS['Evisceration'].TA.Acc = set_combine(sets.precast.WS['Evisceration'].TA, {})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].SA, {})
     
    ------------------------------------------------------------------------------------------
    ------------------------------------ Exenterator sets ------------------------------------
    ------------------------------------------------------------------------------------------
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		ammo="Seething Bomblet +1",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Plunderer's Vest +3",  --relic
		hands="Mummu Wrists +2",
		legs="Meg. Chausses +2",
		feet="Lustra. Leggings +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+4','"Dbl.Atk."+10','Damage taken-5%',}},
	})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {})
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].SA, {})
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].SA, {})
     
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		ammo="Seething Bomblet +1",
		head="Pill. Bonnet +3", --AF
		body="Pillager's Vest +3",  --AF
		hands="Meg. Gloves +2",
		legs="Plun. Culottes +3",  --relic
		feet="Lustra. Leggings +1",
		neck="Caro Necklace",
		waist="Prosilio Belt +1",
		left_ear="Ishvara Earring",
		right_ear="Moonshade Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Gere Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	})
	 
    ------------------------------------------------------------------------------------------
    ----------------------------- Mercy Stroke sets -----------------------------
    ------------------------------------------------------------------------------------------
    --[[sets.precast.WS['Mercy Stroke'] = set_combine(sets.precast.WS, {ammo="Seething Bomblet +1",
        head="Lustratio Cap",ear1="Vulcan's Pearl",hands=herc_hands_STRWSD,
        ring1="Shukuyu Ring",ring2="Rajas Ring",back="Buquwik Cape",legs=herc_legs_STRWSD})
    sets.precast.WS['Mercy Stroke'].Acc = set_combine(sets.precast.WS['Mercy Stroke'], {})
    sets.precast.WS['Mercy Stroke'].SA = set_combine(sets.precast.WS['Mercy Stroke'], {})    
    sets.precast.WS['Mercy Stroke'].SA.Acc = set_combine(sets.precast.WS['Mercy Stroke'].SA, {})     
    sets.precast.WS['Mercy Stroke'].TA = set_combine(sets.precast.WS['Mercy Stroke'].SA, {})
    sets.precast.WS['Mercy Stroke'].TA.Acc = set_combine(sets.precast.WS['Mercy Stroke'].TA, {})
    sets.precast.WS['Mercy Stroke'].SATA = set_combine(sets.precast.WS['Mercy Stroke'].SA, {})
    --]]
 
	sets.precast.WS['Aeolian Edge'] = {
	ammo="Seething Bomblet +1",
    head={ name="Herculean Helm", augments={'Accuracy+4','"Mag.Atk.Bns."+19','Accuracy+9 Attack+9','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
    body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+21','Weapon skill damage +5%','INT+8','Mag. Acc.+4',}},
    feet={ name="Adhe. Gamashes +1", augments={'HP+65','"Store TP"+7','"Snapshot"+10',}},
    neck="Baetyl Pendant",
    waist="Eschan Stone",
    left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    right_ear="Friomisi Earring",
    left_ring="Epaminondas's Ring",
    right_ring="Dingir Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}
 
    ------------------------------------------------------------------------------------------
    -------------------------------------- Midcast sets --------------------------------------
    ------------------------------------------------------------------------------------------
 
    sets.midcast.FastRecast = {}
 
    -- Specific spells
    sets.midcast.Utsusemi = {}
 
    -- Ranged gear
    sets.midcast.RA = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Eschan Stone",
		left_ear="Enervating Earring",
		right_ear="Telos Earring",
		left_ring="Cacoethic Ring",
		right_ring="Paqichikaji Ring",
		back={ name="Toutatis's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Snapshot"+10',}},
	}
	
    sets.midcast.RA.Acc = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Eschan Stone",
		left_ear="Enervating Earring",
		right_ear="Telos Earring",
		left_ring="Cacoethic Ring",
		right_ring="Paqichikaji Ring",
		back={ name="Toutatis's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Snapshot"+10',}},
	}
 
    ------------------------------------------------------------------------------------------
    --------------------------------------- Idle sets ----------------------------------------
    ------------------------------------------------------------------------------------------
 
    -- Resting sets
    sets.resting = {}
 
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
 
    sets.idle = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Jute Boots +1",
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Sanare Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Fortified Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
         
    sets.idle.Regen = {}
 
    sets.idle.Town = {
		body="Councilor's Garb",
		feet="Jute Boots +1",
	}
 
    sets.idle.Weak = {}
         
    sets.idle.STP = {}  
 
    ------------------------------------------------------------------------------------------
    -------------------------------------- Defense sets --------------------------------------
    ------------------------------------------------------------------------------------------
 
    sets.defense.Evasion = set_combine(sets.defense.PDT, {})
 
    sets.defense.PDT = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Sanare Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Fortified Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
 
    sets.defense.MDT = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Sanare Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Fortified Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
 
    ----------------------------------------------------------------------------------------
    ------------------------------------- Melee sets ---------------------------------------
    ----------------------------------------------------------------------------------------
 
    -- Normal melee group
    -- THF Native DW Trait: 25% DWIII + 5% 550JP Gift
    -- No Haste (Need 44 DW)
    sets.engaged = {
		ammo="Yamarang",
		head="Plun. Bonnet +3",
		body="Pillager's Vest +3",  --AF
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Pill. Culottes +3",  --AF
		feet="Plunderer's Poulaines +3",
		neck="Asn. Gorget +2",
		waist="Windbuffet Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Hetairoi Ring",
		right_ring="Gere Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+4','"Dbl.Atk."+10','Damage taken-5%',}},
	}
		
    sets.engaged.MidAcc = set_combine (sets.engaged, {})    
    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {})
    sets.engaged.MaxAcc = {}
     
    -- Normal melee group, 15% Haste (Need 37 DW) 
    sets.engaged.MidHaste = set_combine(sets.engaged, {})
    sets.engaged.MidAcc.MidHaste = set_combine(sets.engaged.MidAcc, {})
    sets.engaged.HighAcc.MidHaste = set_combine(sets.engaged.HighAcc, {})
    sets.engaged.MaxAcc.MidHaste = set_combine(sets.engaged.MaxAcc, {})
     
    -- Normal melee group, 30% Haste (26 DW)
    sets.engaged.HighHaste = set_combine(sets.engaged.MidHaste, {})
    sets.engaged.MidAcc.HighHaste = set_combine(sets.engaged.MidAcc, {})
    sets.engaged.HighAcc.HighHaste = set_combine(sets.engaged.HighAcc, {})
		
    sets.engaged.MaxAcc.HighHaste = set_combine(sets.engaged.MaxAcc, {})
     
    -- Normal melee group, Capped Haste (Need 6 DW)
    sets.engaged.MaxHaste = set_combine(sets.engaged.HighHaste, {})
    sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.MaxHaste, {})
    sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.MaxHaste, {
})
    sets.engaged.MaxAcc.MaxHaste = set_combine(sets.engaged.MaxAcc, {
})
     
    -- Accuracy: 1216
    sets.engaged.PDT = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Asn. Gorget +2",
		waist="Windbuffet Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Hetairoi Ring",
		right_ring="Gere Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+4','"Dbl.Atk."+10','Damage taken-5%',}},
}
    sets.engaged.MaxAcc.PDT = set_combine(sets.engaged.PDT, {})
    
	sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Eshmun's Ring", --20
        waist="Gishdubar Sash", --10
    }
	
    sets.Fish= {
	    range="Lu Shang's F. Rod",
		ammo="Robber Rig",
		head="Tlahtlamah Glasses",
		body="Fsh. Tunica",
		hands="Fsh. Gloves",
		legs="Fisherman's Hose",
		feet="Fisherman's Boots",
		neck="Fisher's Torque",
		left_ring="Seagull Ring",
		right_ring="Pelican Ring",
		waist="Fisher's Rope",
	}
     
	sets.Charm = {
		main="Treat Staff II",
	}
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
-- function job_pretarget(spell,action)
    -- if spell.type == "WeaponSkill" and player.status == 'Engaged' and spell.target.distance > target_distance then -- Cancel WS If You Are Out Of Range --
       -- cancel_spell()
       -- add_to_chat(123, spell.name..' Canceled: [Out of Range]')
       -- return
    -- end
-- end 
 
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Berserk' then 
        if buffactive.Berserk then -- Change Berserk To Aggressor If Berserk Is On --
        cancel_spell()
        send_command('input /ja Aggressor <me>')
        end 
    end     
    if (spell.type:endswith('Magic') or spell.type == "Ninjutsu") then
       if buffactive.Silence then
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')
       end
    end 
    if spell.type == 'WeaponSkill' then
        if (spell.english == "Rudra's Storm" or spell.english == "Evisceration") and player.tp > 2900 then
            equip({ear1="Ishvara Earring",ear2="Sherida Earring"})
        end             
    end
end
 
-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and buffactive.Madrigal then
        equip({ear2="Kuwunga Earring"})
    end
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end
 
-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end
 
-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    determine_haste_group()
	
	if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end
end
 
function job_status_change(new_status, old_status)
    if new_status == 'Engaged' then
        determine_haste_group()
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode
 
    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end
 
    return wsmode
end
 
 
-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()
 
    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end
 
function customize_idle_set(idleSet)
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
	
	if state.Warp.current == 'on' then
		equip(sets.Warp)
		disable('ring1')
		disable('ring2')
		disable('waist')
	else
		enable('ring1')
		enable('ring2')
		enable('waist')
	end
	
	-- if state.Fish.current == 'on' then
		-- equip(sets.Fish)
		-- disable('range')
		-- disable('ammo')
		-- disable('head')
		-- disable('body')
		-- disable('hands')
		-- disable('legs')
		-- disable('feet')
		-- disable('neck')
		-- disable('ring1')
		-- disable('ring2')
		-- disable('waist')
	-- else
		-- enable('range')
		-- enable('ammo')
		-- enable('head')
		-- enable('body')
		-- enable('hands')
		-- enable('legs')
		-- enable('feet')
		-- enable('neck')
		-- enable('ring1')
		-- enable('ring2')
		-- enable('waist')
	-- end
    return idleSet
end
 
function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end 
    if (world.time >= 360 and world.time < 1080) and state.OffenseMode.value == 'Acc' then
       meleeSet = set_combine(meleeSet, sets.DaytimeAmmo)
    end
    --if player.mp >= 100 then
    --  meleeSet = set_combine(meleeSet, sets.OneirosRing)
    --end  
     
    return meleeSet
end
 
 
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
    determine_haste_group()
end
 
-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
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
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
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
     
    msg = msg .. ', TH: ' .. state.TreasureMode.value
     
    msg = msg .. ', Haste: ' .. state.HasteMode.value
     
    msg = msg .. ', March: ' .. state.MarchMode.value
     
    add_to_chat(122, msg)
 
    eventArgs.handled = true
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end
 
 
-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end
 
 
-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end
 
function determine_haste_group()
    -- Gearswap can't detect the difference between Hastes & Marches
    -- so use alt+F9 to manually set Haste and alt+F10 to manually set March spell levels.
 
    -- Haste (buffactive[33]) - 15%
    -- Haste II (buffactive[33]) - 30%
    -- Haste Samba - 5~10%
    -- Honor March - 12~16%
    -- Victory March - 15~28%
    -- Advancing March - 10~18%
    -- Embrava - 25%
    -- Mighty Guard (buffactive[604]) - 15%
    -- Geo-Haste (buffactive[580]) - 30~40%
     
    -- DW traits
        -- I = 10% (nin 10, dnc 20, thf 83)
        -- II = 15% (nin 25, dnc 40, thf 87)
        -- III = 25% (nin 45, dnc 60, thf 98)
        -- IV = 30% (nin 60, dnc 85, thf w/550 JP)
        -- V = 35% (nin 85)
     
    -- Magic Haste Cap
        -- Haste cap with 10 DW
        -- (1 - (0.2 / (1 - (0.4375 + .25))) -0.10 = 26 DW needed
        -- Haste cap with 15 DW
        -- (1 - (0.2 / (1 - (0.4375 + .25))) -0.15 = 21 DW needed
        -- Haste cap with 25 DW
        -- (1 - (0.2 / (1 - (0.4375 + .25))) -0.25 = 11 DW needed
        -- Haste cap with 30 DW
        -- (1 - (0.2 / (1 - (0.4375 + .25))) -0.30 = 6 DW needed
        -- Haste cap with 35 DW
        -- (1 - (0.2 / (1 - (0.4375 + .25))) -0.35 = 1 DW needed
     
    classes.CustomMeleeGroups:clear()
    h = 0
    -- Spell Haste 15/30
    if buffactive[33] then
        if state.HasteMode.value == 'Haste I' then
            h = h + 15
        elseif state.HasteMode.value == 'Haste II' then
            h = h + 30
        end
    end
    -- Geo Haste 30
    if buffactive[580] then
            h = h + 35
    end 
    -- Mighty Guard 15
    if buffactive[604] then
        h = h + 15
    end
    -- Embrava 15
    if buffactive.embrava then
        h = h + 15
    end
    -- March(es) 
    if buffactive.march then
        if state.MarchMode.value == 'Honor' then
            if buffactive.march == 2 then
                h = h + 27 + 16
            elseif buffactive.march == 1 then
                h = h + 16
            elseif buffactive.march == 3 then
                h = h + 27 + 17 + 16
            end
        elseif state.MarchMode.value == 'Trusts' then
            if buffactive.march == 2 then
                h = h + 26
            elseif buffactive.march == 1 then
                h = h + 16
            elseif buffactive.march == 3 then
                h = h + 27 + 17 + 16
            end
        elseif state.MarchMode.value == '7' then
            if buffactive.march == 2 then
                h = h + 27 + 17
            elseif buffactive.march == 1 then
                h = h + 27
            elseif buffactive.march == 3 then
                h = h + 27 + 17 + 16
            end
        elseif state.MarchMode.value == '3' then
            if buffactive.march == 2 then
                h = h + 13.5 + 20.6
            elseif buffactive.march == 1 then
                h = h + 20.6
            elseif buffactive.march == 3 then
                h = h + 27 + 17 + 16
            end
        end
    end
  
    -- Determine CustomMeleeGroups
    if h >= 15 and h < 30 then 
        classes.CustomMeleeGroups:append('MidHaste')
        add_to_chat('Haste Group: 15% -- From Haste Total: '..h)
    elseif h >= 30 and h < 35 then 
        classes.CustomMeleeGroups:append('HighHaste')
        add_to_chat('Haste Group: 30% -- From Haste Total: '..h)
    elseif h >= 35 and h < 40 then 
        classes.CustomMeleeGroups:append('HighHaste')
        add_to_chat('Haste Group: 35% -- From Haste Total: '..h)
    elseif h >= 40 then
        classes.CustomMeleeGroups:append('MaxHaste')
        add_to_chat('Haste Group: Max -- From Haste Total: '..h)
    end
     
end
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 1)
    else
        set_macro_page(1, 1)
    end
end