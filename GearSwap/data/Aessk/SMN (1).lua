-- IdleMode determines the set used after casting. You change it with "/console gs c <IdleMode>"
-- The modes are:
-- Refresh: Uses the most refresh available.
-- DT: A mix of refresh, PDT, and MDT to help when you can't avoid AOE.
-- PetDT: Sacrifice refresh to reduce avatar's damage taken. WARNING: Selenian Cap drops you below 119, use with caution!
-- DD: When melee mode is on and you're engaged, uses TP gear. Otherwise, avatar melee gear.
-- Favor: Uses Beckoner's Horn +1 and max smn skill to boost the favor effect.
-- Zendik: Favor build with the Zendik Robe added in, for Shiva's Favor in manaburn parties. (Shut up, it sounded like a good idea at the time)

-- Additional Bindings:
-- F9 - Toggles between a subset of IdleModes (Refresh > DT > PetDT)
-- F10 - Toggles MeleeMode (When enabled, equips Nirvana and Elan+1, then disables those 2 slots from swapping)
--       NOTE: If you don't already have the Nirvana & Elan+1 equipped, YOU WILL LOSE TP

-- Additional Commands:
-- /console gs c AccMode - Toggles high-accuracy sets to be used where appropriate.
-- /console gs c ImpactMode - Toggles between using normal magic BP set for Fenrir's Impact or a custom high-skill set for debuffs.
-- /console gs c ForceIlvl - I have this set up to override a few specific slots where I normally use non-ilvl pieces.
-- /console gs c LagMode - Used to help BPs land in the right gear in high-lag situations.
--							This will swap gear at the JA's aftercast, rather than waiting for the "Pet readies command" packet.

function file_unload()
	send_command('unbind f9')
	send_command('unbind f10')
	send_command('unbind f11')
	send_command('unbind @h')
end

function get_sets()	
	send_command('bind f9 gs c Lagmode')
	send_command('bind @h gs c MaxHP')
	send_command('bind f10 gs c AccMode')
	send_command('bind f11 gs c MeleeMode')

	-- Set your merits here. This is used in deciding between Enticer's Pants or Apogee Slacks +1.
	-- To change in-game, "/console gs c MeteorStrike3" will change Meteor Strike to 3/5 merits.
	MeteorStrike = 1
	HeavenlyStrike = 1
	WindBlade = 1
	Geocrush = 1
	Thunderstorm = 1
	GrandFall = 1

	-- StartLockStyle = '85'
	IdleMode = 'Refresh'
	AccMode = false
	MeleeMode = false
	ImpactDebuff = false
	MeleeMode = false
	ForceIlvl = false
	LagMode = false -- Default LagMode. If you have a lot of lag issues, change to "true"
	MaxHP = false
	AutoRemedy = false
	AutoEcho = false
	Test = 0

	-- ===================================================================================================================
	--		Sets
	-- ===================================================================================================================

	-- Base Damage Taken Set - Mainly used when IdleMode is "DT"
	sets.DT_Base = {	
		main="Nirvana",
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head="Convoker's Horn +3",
		body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		hands="Asteria Mitts +1",
		legs="Assid. Pants +1",
		feet="Baaya. Sabots +1",
		neck="Loricate Torque +1",
		waist="Lucidity Sash",
		left_ear="Evans Earring",
		right_ear="C. Palug Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe2"},
		right_ring="Shneddick Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},
	}

	sets.precast = {}

	-- Fast Cast
	sets.precast.FC = {
		main={ name="Grioavolr", augments={'Blood Pact Dmg.+9','Pet: STR+5','Pet: Mag. Acc.+4','Pet: "Mag.Atk.Bns."+24',}},
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head="C. Palug Crown",
		body="Zendik Robe",
		hands="Lamassu Mitts +1",
		legs="Assid. Pants +1",
		feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		neck="Baetyl Pendant",
		waist="Lucidity Sash",
		left_ear="Malignance Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Kishar Ring",
		right_ring="Prolix Ring",
	}

	sets.precast.WS={
			head="Tali'ah Turban +2",
		body="Tali'ah Manteel +2",
		hands="Volte Bracers",
		legs="Tali'ah Sera. +2",
		feet="Tali'ah Crackows +2",
		neck="Shulmanu Collar",
		waist="Olseni Belt",
		left_ear="Mache Earring +1",
		right_ear="Mache Earring +1",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
	}
	
    sets.midcast = {}

	-- BP Timer Gear
    sets.midcast.BP = {
		main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
		sub="Vox Grip",
		ammo="Sancus Sachet +1",
		head="Beckoner's Horn +1",
		body="Con. Doublet +2",
		hands="Lamassu Mitts +1",
		legs="Assid. Pants +1",
		feet="Baaya. Sabots +1",
		neck="Caller's Pendant",
		waist="Lucidity Sash",
		left_ear="C. Palug Earring",
		right_ear="Evans Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Conveyance Cape", augments={'Summoning magic skill +4','Pet: Enmity+10','Blood Pact Dmg.+1','Blood Pact ab. del. II -3',}},
	}

    sets.midcast.Siphon = {
		head="Convoker's Horn +3",
		ammo="Sancus Sachet +1",
		body="Baayami Robe",
		hands="Baayami Cuffs +1",
		legs="Baayami Slops +1",
		feet="Baaya. Sabots +1",
		neck="Caller's Pendant",
		waist="Lucidity Sash",
		left_ear="Evans Earring",
		right_ear="C. Palug Earring",
		left_ring="Stikini Ring +1",
		right_ring="Evoker's Ring",
		back={ name="Conveyance Cape", augments={'Summoning magic skill +2','Blood Pact Dmg.+3','Blood Pact ab. del. II -3',}},
	}

	sets.midcast.SiphonZodiac = set_combine(sets.midcast.Siphon, {})

	sets.midcast.Summon = set_combine(sets.DT_Base, {body="Baayami Robe"})

	sets.midcast.Cure = {  
		main="Serenity", 
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+3','MND+4',}},
		feet={ name="Medium's Sabots", augments={'MP+50','MND+10','"Conserve MP"+7','"Cure" potency +5%',}},
		right_ear="Mendi. Earring",
		back="Solemnity Cape",
	}

	sets.midcast.Cursna = set_combine(sets.precast.FC, {})
	
	sets.midcast.EnmityRecast = set_combine(sets.precast.FC, {})

	sets.midcast.Enfeeble = {}

	sets.midcast.Enhancing = {legs="Doyen Pants"}

	sets.midcast.Stoneskin = set_combine(sets.midcast.Enhancing, {	
		right_ear="Earthcry Earring", 
		waist="Siegel Sash",
		neck="Nodens Gorget",
	})

	sets.midcast.Nuke = {	}

    sets.midcast["Refresh"] = set_combine(sets.midcast.Enhancing, {feet="Inspirited Boots", waist="Gishdubar Sash",})

	sets.midcast["Mana Cede"] = { }

    sets.midcast["Astral Flow"] = {head={ name="Glyphic Horn +1", augments={'Enhances "Astral Flow" effect',}}, }

	sets.midcast["Garland of Bliss"] = set_combine(sets.midcast.Nuke, {	})

	sets.midcast["Shattersoul"] = {	}

	sets.midcast["Cataclysm"] = sets.midcast.Nuke

	sets.pet_midcast = {}

	-- Main physical pact set (Volt Strike, Pred Claws, etc.)
	sets.pet_midcast.Physical_BP = {
		main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head={ name="Apogee Crown +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}},
		body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Blood Pact Dmg.+9','Pet: INT+8','Pet: "Mag.Atk.Bns."+13',}},
		legs={ name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}},
		feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}},
		neck="Smn. Collar +2",
		waist="Incarnation Sash",
		left_ear="Lugalbanda Earring",
		right_ear="Gelos Earring",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10','Mag. Evasion+15',}},
	}

	sets.pet_midcast.Physical_BP_AM3 = set_combine(sets.pet_midcast.Physical_BP, {	})

	-- Physical pacts which benefit more from TP than Pet:DA (like single-hit BP)
	sets.pet_midcast.Physical_BP_TP = set_combine(sets.pet_midcast.Physical_BP, {	})

	-- Used for all physical pacts when AccMode is true
	sets.pet_midcast.Physical_BP_Acc = set_combine(sets.pet_midcast.Physical_BP, {	})

	-- Base magic pact set
	sets.pet_midcast.Magic_BP_Base = {
		main={ name="Grioavolr", augments={'Blood Pact Dmg.+9','Pet: STR+5','Pet: Mag. Acc.+4','Pet: "Mag.Atk.Bns."+24',}},
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head="C. Palug Crown",
		body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Blood Pact Dmg.+9','Pet: INT+8','Pet: "Mag.Atk.Bns."+13',}},
		legs={ name="Enticer's Pants", augments={'MP+50','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Mag. Acc.+15','Pet: Damage taken -5%',}},
		feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		neck="Smn. Collar +2",
		waist="Regal Belt",
		left_ear="Lugalbanda Earring",
		right_ear="Gelos Earring",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','Mag. Evasion+15',}},
	}
	
	-- Some magic pacts benefit more from TP than others.
	-- Note: This set will only be used on merit pacts if you have less than 4 merits.
	--       Make sure to update your merit values at the top of this Lua.
	sets.pet_midcast.Magic_BP_TP = set_combine(sets.pet_midcast.Magic_BP_Base, { legs={ name="Enticer's Pants", augments={'MP+50','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Mag. Acc.+15','Pet: Damage taken -5%',}},	})

	-- NoTP set used when you don't need Enticer's
	sets.pet_midcast.Magic_BP_NoTP = set_combine(sets.pet_midcast.Magic_BP_Base, {	})

	sets.pet_midcast.Magic_BP_TP_Acc = set_combine(sets.pet_midcast.Magic_BP_TP, {body="Con. Doublet +3", feet="Convo. Pigaches +3",	})

	sets.pet_midcast.Magic_BP_NoTP_Acc = set_combine(sets.pet_midcast.Magic_BP_NoTP, {body="Con. Doublet +3", feet="Convo. Pigaches +3",	})

	sets.pet_midcast.FlamingCrush = {
		main={ name="Grioavolr", augments={'Blood Pact Dmg.+9','Pet: STR+5','Pet: Mag. Acc.+4','Pet: "Mag.Atk.Bns."+24',}},
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head="C. Palug Crown",
		body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Blood Pact Dmg.+9','Pet: INT+8','Pet: "Mag.Atk.Bns."+13',}},
		legs="Assid. Pants +1",
		feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		neck="Smn. Collar +2",
		waist="Regal Belt",
		left_ear="Lugalbanda Earring",
		right_ear="Gelos Earring",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','Mag. Evasion+15',}},
	}

	sets.pet_midcast.FlamingCrush_Acc = set_combine(sets.pet_midcast.FlamingCrush, {feet="Convo. Pigaches +3", 	})

	-- Pet: Magic Acc set - Mainly used for debuff pacts like Shock Squall
	sets.pet_midcast.MagicAcc_BP = {
		main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head="Tali'ah Turban +2",
		body="Tali'ah Manteel +2",
		hands="Tali'ah Gages +1",
		legs="Tali'ah Sera. +2",
		feet="Tali'ah Crackows +2",
		neck={ name="Smn. Collar +2", augments={'Path: A',}},
		waist="Incarnation Sash",
		left_ear="Lugalbanda Earring",
		right_ear="Kyrene's Earring",
		left_ring="Varar Ring +1",
		right_ring="C. Palug Ring",
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','Mag. Evasion+15',}},
	}

	sets.pet_midcast.Debuff_Rage = sets.pet_midcast.MagicAcc_BP

	-- Pure summoning magic set, mainly used for buffs like Hastega II.
	sets.pet_midcast.SummoningMagic = {
		main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
		sub="Vox Grip",
		ammo="Sancus Sachet +1",
		head="Beckoner's Horn +1",
		body="Con. Doublet +2",
		hands="Lamassu Mitts +1",
		legs="Assid. Pants +1",
		feet="Baaya. Sabots +1",
		neck="Incanter's Torque",
		waist="Lucidity Sash",
		left_ear="C. Palug Earring",
		right_ear="Kyrene's Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Conveyance Cape", augments={'Summoning magic skill +5','Blood Pact Dmg.+3','Blood Pact ab. del. II -1',}},
	}

	sets.pet_midcast.Buff = sets.pet_midcast.SummoningMagic

	-- I use Apogee gear for healing BPs because the amount healed is affected by avatar max HP.
	-- I'm probably stupid. It puts you in yellow HP after using a healing move.
	sets.pet_midcast.Buff_Healing = set_combine(sets.pet_midcast.SummoningMagic, {
	    head={ name="Apogee Crown +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}},
		body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		hands="Asteria Mitts +1",
		legs={ name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}},
		feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}},
	})

	-- This set is used for certain blood pacts when ImpactDebuff mode is ON. (/console gs c ImpactDebuff)
	-- These pacts are normally used as nukes, but they're also strong debuffs which are enhanced by smn skill.
	sets.pet_midcast.Impact = set_combine(sets.pet_midcast.SummoningMagic, {	})

	sets.aftercast = {}

	-- Idle set with no avatar out.
	sets.aftercast.Idle = {
		main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head="Beckoner's Horn +1",
		body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		hands="Asteria Mitts +1",
		legs="Assid. Pants +1",
		feet="Baaya. Sabots +1",
		neck="Loricate Torque +1",
		waist="Regal Belt",
		left_ear="C. Palug Earring",
		right_ear="Sanare Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10','Mag. Evasion+15',}},
	}
	
	-- Idle set used when ForceIlvl is ON. Use this mode to avoid Gaiters dropping ilvl.
	sets.aftercast.Idle_Ilvl = set_combine(sets.aftercast.Idle, {
		feet="Baaya. Sabots +1",
	})
	
	sets.aftercast.DT = sets.DT_Base

	-- Many idle sets inherit from this set.
	-- Put common items here so you don't have to repeat them over and over.
	sets.aftercast.Perp_Base = {
		main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head="Beckoner's Horn +1",
		body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+30 Pet: Rng. Acc.+30','"Avatar perpetuation cost" -6','Pet: Mag. Acc.+15','Pet: "Mag.Atk.Bns."+2',}},
		legs="Assid. Pants +1",
		feet="Baaya. Sabots +1",
		neck="Caller's Pendant",
		waist="Lucidity Sash",
		left_ear="C. Palug Earring",
		right_ear="Evans Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10','Mag. Evasion+15',}},
	}

	-- Avatar Melee set. Equipped when IdleMode is "DD" and MeleeMode is OFF.
	sets.aftercast.Perp_DD = set_combine(sets.aftercast.Perp_Base, {	})

	-- Refresh set with avatar out. Equipped when IdleMode is "Refresh".
	sets.aftercast.Perp_Refresh = set_combine(sets.aftercast.Perp_Base, {	})

	sets.aftercast.Perp_RefreshSub50 = set_combine(sets.aftercast.Perp_Refresh, {	})
	
	sets.aftercast.Perp_Favor = set_combine(sets.aftercast.Perp_Refresh, {	})

	sets.aftercast.Perp_Zendik = set_combine(sets.aftercast.Perp_Favor, {	})

	-- TP set. Equipped when IdleMode is "DD" and MeleeMode is ON.
	sets.aftercast.Perp_Melee = set_combine(sets.aftercast.Perp_Refresh, {
	})

	-- Pet:DT build. Equipped when IdleMode is "PetDT".
	sets.aftercast.Avatar_DT = {
		main="Nirvana",
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head="Convoker's Horn +3",
		body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		hands="Asteria Mitts +1",
		legs="Assid. Pants +1",
		feet="Baaya. Sabots +1",
		neck="Loricate Torque +1",
		waist="Lucidity Sash",
		left_ear="Evans Earring",
		right_ear="C. Palug Earring",
		left_ring={name="Varar Ring +1", bag="wardrobe2"},
		right_ring={name="Varar Ring +1", bag="wardrobe3"},
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},
	}

	-- Perp down set used when ForceIlvl is ON. Use this mode to avoid Selenian Cap dropping ilvl.
	sets.aftercast.Avatar_DT_Ilvl = set_combine(sets.aftercast.Avatar_DT, {	})

	-- DT build with avatar out. Equipped when IdleMode is "DT".
	sets.aftercast.Perp_DT = set_combine(sets.DT_Base, {	})

	sets.aftercast.Spirit = {	
		main="Nirvana",
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head="Convoker's Horn +3",
		body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
		hands="Asteria Mitts +1",
		legs="Assid. Pants +1",
		feet="Baaya. Sabots +1",
		neck="Caller's Pendant",
		waist="Lucidity Sash",
		left_ear="Evans Earring",
		right_ear="C. Palug Earring",
		left_ring="Evoker's Ring",
		right_ring={name="Stikini Ring +1", bag="wardrobe3"},
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},
	}

	sets.engaged = {
		head="Tali'ah Turban +2",
		body="Tali'ah Manteel +2",
		hands="Volte Bracers",
		legs="Tali'ah Sera. +2",
		feet="Tali'ah Crackows +2",
		neck="Shulmanu Collar",
		waist="Olseni Belt",
		left_ear="Mache Earring +1",
		right_ear="Mache Earring +1",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
	}
	
	sets.MaxHP = {
	    head="Tali'ah Turban +2",
		body="Udug Jacket",
		hands="Volte Bracers",
		legs="Tali'ah Sera. +2",
		feet="Baaya. Sabots +1",
		neck={ name="Smn. Collar +2", augments={'Path: A',}},
		waist="Regal Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Odnowa Earring",
		left_ring="Overbearing Ring",
		right_ring="C. Palug Ring",
	}

	-- ===================================================================================================================
	--		End of Sets
	-- ===================================================================================================================

	Buff_BPs_Healing = S{'Healing Ruby','Healing Ruby II','Whispering Wind','Spring Water'}
	Debuff_BPs = S{'Mewing Lullaby','Eerie Eye','Lunar Cry','Lunar Roar','Nightmare','Pavor Nocturnus','Ultimate Terror','Somnolence','Slowga','Tidal Roar','Diamond Storm','Sleepga','Shock Squall'}
	Debuff_Rage_BPs = S{'Moonlit Charge','Tail Whip'}

	Magic_BPs_NoTP = S{'Holy Mist','Nether Blast','Aerial Blast','Searing Light','Diamond Dust','Earthen Fury','Zantetsuken','Tidal Wave','Judgment Bolt','Inferno','Howling Moon','Ruinous Omen','Night Terror','Thunderspark'}
	Magic_BPs_TP = S{'Impact','Conflag Strike','Level ? Holy','Lunar Bay'}
	Merit_BPs = S{'Meteor Strike','Geocrush','Grand Fall','Wind Blade','Heavenly Strike','Thunderstorm'}
	Physical_BPs_TP = S{'Rock Buster','Mountain Buster','Crescent Fang','Spinning Dive'}

	AvatarList = S{'Shiva','Ramuh','Garuda','Leviathan','Diabolos','Titan','Fenrir','Ifrit','Carbuncle','Fire Spirit','Air Spirit','Ice Spirit','Thunder Spirit','Light Spirit','Dark Spirit','Earth Spirit','Water Spirit','Cait Sith','Alexander','Odin','Atomos'}
	TownIdle = S{"windurst woods","windurst waters","windurst walls","port windurst","bastok markets","bastok mines","port bastok","southern san d'oria","northern san d'oria","port san d'oria","upper jeuno","lower jeuno","port jeuno","ru'lude gardens","norg","kazham","tavnazian safehold","rabao","selbina","mhaura","aht urhgan whitegate","al zahbi","nashmau","western adoulin","eastern adoulin"}
	Salvage = S{"Bhaflau Remnants","Zhayolm Remnants","Arrapago Remnants","Silver Sea Remnants"}

	-- Select initial macro set and set lockstyle
	-- This section likely requires changes or removal if you aren't Pergatory
		-- End macro set / lockstyle section
end



function pet_change(pet,gain)
    idle()
end

function pretarget(spell,action)
	if not buffactive['Muddle'] then
		-- Auto Remedy --
		if AutoRemedy and (spell.action_type == 'Magic' or spell.type == 'JobAbility') then
			if buffactive['Paralysis'] or (buffactive['Silence'] and not AutoEcho) then
				cancel_spell()
				send_command('input /item "Remedy" <me>')
			end
		end
		-- Auto Echo Drop --
		if AutoEcho and spell.action_type == 'Magic' and buffactive['Silence'] then
			cancel_spell()
			send_command('input /item "Echo Drops" <me>')
		end
	end
end

function precast(spell)
    if pet_midaction() or spell.type=="Item" then
		return
	end
	-- Spell fast cast
    if spell.action_type=="Magic" then
		if spell.name=="Stoneskin" then
			equip(sets.precast.FC,{legs="Doyen Pants", })
		else
			equip(sets.precast.FC)
		end
    end
end

function midcast(spell)
    if pet_midaction() or spell.type=="Item" then
        return
    end
	-- BP Timer gear needs to swap here
	if (spell.type=="BloodPactWard" or spell.type=="BloodPactRage") and not buffactive["Astral Conduit"] then
		equip(sets.midcast.BP)
	-- Spell Midcast & Potency Stuff
    elseif sets.midcast[spell.english] then
        equip(sets.midcast[spell.english])
	elseif spell.name=="Elemental Siphon" then
		if pet.element=="Light" or pet.element=="Dark" then
			equip(sets.midcast.Siphon)
		else
			equip(sets.midcast.SiphonZodiac)
		end
	elseif spell.type=="SummonerPact" then
		equip(sets.midcast.Summon)
	elseif spell.type=="WhiteMagic" then
		if string.find(spell.name,"Cure") or string.find(spell.name,"Curaga") then
			equip(sets.midcast.Cure)
		elseif string.find(spell.name,"Protect") or string.find(spell.name,"Shell") then
			equip(sets.midcast.Enhancing,{ring2="Sheltered Ring"})
		elseif spell.skill=="Enfeebling Magic" then
			equip(sets.midcast.Enfeeble)
		elseif spell.skill=="Enhancing Magic" then
			equip(sets.midcast.Enhancing)
		else
			idle()
		end
	elseif spell.type=="BlackMagic" then
		if spell.skill=="Elemental Magic" then
			equip(sets.midcast.Nuke)
		end
	elseif spell.action_type=="Magic" then
		equip(sets.midcast.EnmityRecast)
    else
        idle()
    end
	-- Auto-cancel existing buffs
	if spell.name=="Stoneskin" and buffactive["Stoneskin"] then
		windower.send_command('cancel 37;')
	elseif spell.name=="Sneak" and buffactive["Sneak"] and spell.target.type=="SELF" then
		windower.send_command('cancel 71;')
	elseif spell.name=="Utsusemi: Ichi" and buffactive["Copy Image"] then
		windower.send_command('wait 1;cancel 66;')
	end
end

function aftercast(spell)
    if pet_midaction() or spell.type=="Item" then
        return
    end
	if string.find(spell.type,"BloodPact") and LagMode then
		equipBPGear(spell)
    elseif (not string.find(spell.type,"BloodPact") and not AvatarList:contains(spell.name)) or spell.interrupted then
        idle()
    end
end

function status_change(new,old)
	if new=="Idle" then
        idle()
	end
	if new=="Engaged" then
        equip(sets.engaged)
    end
end

function buff_change(name,gain)
    if name=="Quickening" then
        idle()
    end
end

function pet_midcast(spell)
	if not LogMode then
		equipBPGear(spell)
	end
end

function pet_aftercast(spell)
    idle()
end

function equipBPGear(spell)
    if spell.name=="Perfect Defense" then
        equip(sets.pet_midcast.SummoningMagic)
	elseif spell.type=="BloodPactWard" then
        if Debuff_BPs:contains(spell.name) then
            equip(sets.pet_midcast.MagicAcc_BP)
		elseif Buff_BPs_Healing:contains(spell.name) then
			equip(sets.pet_midcast.Buff_Healing)
        else
            equip(sets.pet_midcast.Buff)
        end
    elseif spell.type=="BloodPactRage" then
        if spell.name=="Flaming Crush" then
			if AccMode then
				equip(sets.pet_midcast.FlamingCrush_Acc)
			else
				equip(sets.pet_midcast.FlamingCrush)
			end
		elseif ImpactDebuff and (spell.name=="Impact" or spell.name=="Conflag Strike") then
			equip(sets.pet_midcast.Impact)
        elseif Magic_BPs_TP:contains(spell.name) or string.find(spell.name," II") or string.find(spell.name," IV") then
			if AccMode then
				equip(sets.pet_midcast.Magic_BP_TP_Acc)
			else
                equip(sets.pet_midcast.Magic_BP_TP)
			end
        elseif Magic_BPs_NoTP:contains(spell.name) then
			if AccMode then
				equip(sets.pet_midcast.Magic_BP_NoTP_Acc)
			else
                equip(sets.pet_midcast.Magic_BP_NoTP)
			end
		elseif Merit_BPs:contains(spell.name) then
			if AccMode then
				equip(sets.pet_midcast.Magic_BP_TP_Acc)
			elseif spell.name=="Meteor Strike" and MeteorStrike>4 then
				equip(sets.pet_midcast.Magic_BP_NoTP)
			elseif spell.name=="Geocrush" and Geocrush>4 then
				equip(sets.pet_midcast.Magic_BP_NoTP)
			elseif spell.name=="Grand Fall" and GrandFall>4 then
				equip(sets.pet_midcast.Magic_BP_NoTP)
			elseif spell.name=="Wind Blade" and WindBlade>4 then
				equip(sets.pet_midcast.Magic_BP_NoTP)
			elseif spell.name=="Heavenly Strike" and HeavenlyStrike>4 then
				equip(sets.pet_midcast.Magic_BP_NoTP)
			elseif spell.name=="Thunderstorm" and Thunderstorm>4 then
				equip(sets.pet_midcast.Magic_BP_NoTP)
			else
				equip(sets.pet_midcast.Magic_BP_TP)
			end
		elseif Debuff_Rage_BPs:contains(spell.name) then
			equip(sets.pet_midcast.Debuff_Rage)
        else
			if AccMode then
				equip(sets.pet_midcast.Physical_BP_Acc)
			elseif Physical_BPs_TP:contains(spell.name) then
				equip(sets.pet_midcast.Physical_BP_TP)
			elseif buffactive["Aftermath: Lv.3"] then
				equip(sets.pet_midcast.Physical_BP_AM3)
			elseif Test>0 then
				equip(set_combine(sets.pet_midcast.Physical_BP, {}))
			else
				equip(sets.pet_midcast.Physical_BP)
			end
        end
    end
end

function self_command(command)
	IdleModeCommands = {'DD','Refresh','DT','Favor','PetDT','Zendik'}
	is_valid = false

	for _, v in ipairs(IdleModeCommands) do
		if command:lower()==v:lower() then
			IdleMode = v
			send_command('console_echo "Idle Mode: ['..IdleMode..']"')
			idle()
			return
		end
	end
	if command:lower()=="accmode" then
		AccMode = AccMode==false
		is_valid = true
		send_command('console_echo "AccMode: '..tostring(AccMode)..'"')
	elseif command:lower()=="meleemode" then
		ImpactDebuff = MeleeMode==false
		is_valid = true
		send_command('console_echo "Impact Debuff: '..tostring(MeleeMode)..'"')
	elseif command:lower()=="impactmode" then
		ImpactDebuff = ImpactDebuff==false
		is_valid = true
		send_command('console_echo "Impact Debuff: '..tostring(ImpactDebuff)..'"')
    elseif command:lower()=="forceilvl" then
        ForceIlvl = ForceIlvl==false
        is_valid = true
        send_command('console_echo "Force iLVL: '..tostring(ForceIlvl)..'"')
	elseif command:lower()=="lagmode" then
		LagMode = LagMode==false
		is_valid = true
		send_command('console_echo "Lag Compensation Mode: '..tostring(LagMode)..'"')
	elseif command:lower()=="maxhp" then
		-- MaxHP = MaxHP==false
		-- is_valid = true
		if MaxHP then
			MaxHP = false
			enable('head')
			enable('body')
			enable('hands')
			enable('legs')
			enable('feet')
			enable('neck')
			enable('ear1')
			enable('ear2')
			enable('ring1')
			enable('ring2')
			enable('waist')
			send_command('console_echo "MaxHP Mode: false"')
		else
			MaxHP = true
			equip(sets.MaxHP)
			disable('head')
			disable('body')
			disable('hands')
			disable('legs')
			disable('feet')
			disable('neck')
			disable('ear1')
			disable('ear2')
			disable('ring1')
			disable('ring2')
			disable('waist')
			send_command('console_echo "MaxHP Mode: true"')
		end
		is_valid = true
	elseif command:lower()=="meleemode" then
		if MeleeMode then
			MeleeMode = false
			enable("main","sub")
			send_command('console_echo "Melee Mode: false"')
		else
			MeleeMode = true
			equip({main="Nirvana",sub="Elan Strap +1"})
			disable("main","sub")
			send_command('console_echo "Melee Mode: true"')
		end
		is_valid = true
	elseif command=="ToggleIdle" then
		is_valid = true
		if IdleMode=="Refresh" then
			IdleMode = "DT"
		elseif IdleMode=="DT" then
			IdleMode = "PetDT"
		elseif IdleMode=="PetDT" then
			IdleMode = "DD"
		else
			IdleMode = "Refresh"
		end
		send_command('console_echo "Idle Mode: ['..IdleMode..']"')
	elseif command:lower()=="lowhp" then
		-- Use for "Cure 500 HP" objectives in Omen
		equip({head="Apogee Crown +1",body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},legs="Apogee Slacks +1",feet="Apogee Pumps +1",back="Campestres's Cape"})
		return
	elseif string.sub(command:lower(),1,12)=="meteorstrike" then
		MeteorStrike = string.sub(command,13,13)
		send_command('console_echo "Meteor Strike: '..MeteorStrike..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,8)=="geocrush" then
		Geocrush = string.sub(command,9,9)
		send_command('console_echo "Geocrush: '..Geocrush..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,9)=="grandfall" then
		GrandFall = string.sub(command,10,10)
		send_command('console_echo "Grand Fall: '..GrandFall..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,9)=="windblade" then
		WindBlade = +string.sub(command,10,10)
		send_command('console_echo "Wind Blade: '..WindBlade..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,14)=="heavenlystrike" then
		HeavenlyStrike = string.sub(command,15,15)
		send_command('console_echo "Heavenly Strike: '..HeavenlyStrike..'/5"')
		is_valid = true
	elseif string.sub(command:lower(),1,12)=="thunderstorm" then
		Thunderstorm = string.sub(command,13,13)
		send_command('console_echo "Thunderstorm: '..Thunderstorm..'/5"')
		is_valid = true
	elseif command=="TestMode" then
		Test = Test + 1
		if Test==3 then
			Test = 0
		end
		is_valid = true
		send_command('console_echo "Test Mode: '..tostring(Test)..'"')
	end

	if not is_valid then
		send_command('console_echo "gs c {Refresh|DT|DD|PetDT|Favor} {AccMode} {MeleeMode} {ImpactMode} {MeleeMode}"')
	end
	idle()
end

function idle()
	--if TownIdle:contains(world.area:lower()) then
	--	return
	--end
    if pet.isvalid then
		if IdleMode=='DT' then
			equip(sets.aftercast.Perp_DT)
		elseif string.find(pet.name,'Spirit') then
            equip(sets.aftercast.Spirit)
		elseif IdleMode=='PetDT' then
			if ForceIlvl then
				equip(sets.aftercast.Avatar_DT_Ilvl)
			else
				equip(sets.aftercast.Avatar_DT)
			end
        elseif IdleMode=='Refresh' then
			if player.mpp < 50 then
				equip(sets.aftercast.Perp_RefreshSub50)
			else
				equip(sets.aftercast.Perp_Refresh)
			end
		elseif IdleMode=='Favor' then
			equip(sets.aftercast.Perp_Favor)
		elseif IdleMode=='Zendik' then
			equip(sets.aftercast.Perp_Zendik)
		elseif MeleeMode then
			equip(sets.aftercast.Perp_Melee)
        elseif IdleMode=='DD' then
            equip(sets.aftercast.Perp_DD)
        end
		-- Gaiters if Fleet Wind is up
		if buffactive['Quickening'] and IdleMode~='DT' and not ForceIlvl then
			equip({feet="Herald's Gaiters"})
		end
	else
		if IdleMode=='DT' then
			equip(sets.aftercast.DT)
		elseif MeleeMode and IdleMode=='DD' then
			equip(sets.aftercast.Perp_Melee)
		elseif ForceIlvl then
			equip(sets.aftercast.Idle_Ilvl)
		else
			equip(sets.aftercast.Idle)
		end
    end
	-- Balrahn's Ring
	--if Salvage:contains(world.area) then
	--	equip({ring2="Balrahn's Ring"})
	--end
	-- Maquette Ring
	--if world.area=='Maquette Abdhaljs-Legion' and not IdleMode=='DT' then
	--	equip({ring2="Maquette Ring"})
	--end
end