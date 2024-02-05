-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	include('organizer-lib')
end


-- Setup vars that are user-independent.
function job_setup()
	get_combat_form()
    include('Mote-TreasureHunter')
    state.TreasureMode:set('Tag')
    
    state.CapacityMode = M(false, 'Capacity Point Mantle')
	
    -- list of weaponskills that make better use of otomi helm in low acc situations
    wsList = S{'Drakesbane'}

	state.Buff = {}
	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.default_ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.default_u_ja_ids = S{201, 202, 203, 205, 207}
	
	lockstyleset = 98
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Mid', 'Acc')
	state.HybridMode:options('Normal', 'PDT', 'Reraise')
	state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
	state.PhysicalDefenseMode:options('PDT', 'Reraise')
	state.MagicalDefenseMode:options('MDT')
    
    war_sj = player.sub_job == 'WAR' or false

	--select_default_macro_book(13, 1)
    send_command('bind != gs c toggle CapacityMode')
	send_command('bind ^= gs c cycle treasuremode')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
	
	set_lockstyle('58')
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	send_command('unbind ^[')
	send_command('unbind ![')
	send_command('unbind ^=')
	send_command('unbind !=')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Angon = {
		ammo="Angon",
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		left_ear="Dragoon's Earring",
	}
    sets.CapacityMantle = {
		back="Mecistopins Mantle",
	}
    --sets.Berserker = {neck="Berserker's Torque"}
    sets.WSDayBonus = {
	}

    sets.Organizer = {
    }

	sets.precast.JA.Jump = {
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		--body="Vishap Mail +3",
		body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
		hands="Vis. Fng. Gaunt. +3",
		legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
		feet="Ostro Greaves",
		neck="Vim Torque +1",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
    }

	sets.precast.JA['Ancient Circle'] = {
		legs="Vishap Brais +3",
	}
	sets.TreasureHunter = {}

	sets.precast.JA['High Jump'] = set_combine(sets.precast.JA.Jump, {
    }) 
	sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA.Jump, {
		body="Vishap Mail +3",
		hands={ name="Acro Gauntlets", augments={'Accuracy+20 Attack+20','"Store TP"+6','STR+7 DEX+7',}},
    })
	sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA.Jump, {
		feet="Pelt. Schyn. +1",
    })
	sets.precast.JA['Super Jump'] = sets.precast.JA.Jump

	sets.precast.JA['Spirit Link'] = {
        head="Vishap Armet +3",
		hands="Pel. Vambraces +1",
		feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
		right_ear="Pratik Earring",
    }
	sets.precast.JA['Call Wyvern'] = {
		body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
	}
	sets.precast.JA['Deep Breathing'] = {
		head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
    }
	sets.precast.JA['Spirit Surge'] = {
		body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
    }
	
	-- Healing Breath sets
	sets.HB = {
		ammo="Staunch Tathlum +1",
		head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
		body={ name="Acro Surcoat", augments={'Pet: Mag. Acc.+22','Pet: Breath+8','HP+49',}},
		hands={ name="Acro Gauntlets", augments={'Pet: Mag. Acc.+23','Pet: Breath+8','HP+50',}},
		legs="Vishap Brais +3",
		feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Glassblower's Belt",
		left_ear="Eabani Earring",
		right_ear="Dragoon's Earring",
		left_ring="Defending Ring",
		right_ring="C. Palug Ring",
		back={ name="Updraft Mantle", augments={'STR+1','Pet: Breath+10',}},
    }

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
    }
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = {
        --ammo="Impatiens",
        --head="Cizin Helm +1", 
        --ear1="Loquacious Earring", 
        --hands="Leyline Gloves",
        --legs="Limbo Trousers",
        --ring1="Prolix Ring",
    }
    
	-- Midcast Sets
	sets.midcast.FastRecast = {}	
		
	sets.midcast.Breath = {
		ammo="Voluspa Tathlum",
		head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
		body={ name="Acro Surcoat", augments={'Pet: Mag. Acc.+22','Pet: Breath+8','HP+49',}},
		hands={ name="Acro Gauntlets", augments={'Pet: Mag. Acc.+23','Pet: Breath+8','HP+50',}},
		legs={ name="Acro Breeches", augments={'Pet: Mag. Acc.+23','Pet: Breath+8','HP+40',}},
		feet={ name="Acro Leggings", augments={'Pet: Mag. Acc.+25','Pet: Breath+8','HP+39',}},
		neck="Adad Amulet",
		waist="Incarnation Sash",
		left_ear="Enmerkar Earring",
		right_ear="Kyrene's Earring",
		right_ring="C. Palug Ring",
		back={ name="Updraft Mantle", augments={'STR+1','Pet: Breath+10',}},
	}
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	
	sets.precast.WS = {
		ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Attack+23','Weapon skill damage +5%','DEX+3',}},
		body={ name="Valorous Mail", augments={'Attack+9','Weapon skill damage +5%','DEX+7','Accuracy+7',}},
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Vishap Brais +3",
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stardiver'] = {
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti’s Breeches",
		feet="Flam. Gambieras +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	sets.precast.WS['Stardiver'].Mid = set_combine(sets.precast.WS['Stardiver'], {})
	sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Camlann's Torment"] = {
		ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Attack+23','Weapon skill damage +5%','DEX+3',}},
		body={ name="Valorous Mail", augments={'Attack+9','Weapon skill damage +5%','DEX+7','Accuracy+7',}},
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Vishap Brais +3",
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
	sets.precast.WS["Camlann's Torment"].Mid = set_combine(sets.precast.WS["Camlann's Torment"], {})
	sets.precast.WS["Camlann's Torment"].Acc = set_combine(sets.precast.WS["Camlann's Torment"].Mid, {})

	sets.precast.WS['Drakesbane'] = {
		ammo="Knobkierrie",
	    head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti’s Breeches",
		feet="Gleti's Boots",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear="Sherida Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	sets.precast.WS['Drakesbane'].Mid = set_combine(sets.precast.WS['Drakesbane'], {})
	sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS['Drakesbane'].Mid, {})
	
	sets.precast.WS["Impulse Drive"] = {
		ammo="Knobkierrie",
	    head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti’s Breeches",
		feet="Flam. Gambieras +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	sets.precast.WS['Savage Blade'] = {
		ammo="Knobkierrie",
	    head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Vishap Brais +3",
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.precast.WS['Full Swing'] = {
	    ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Attack+23','Weapon skill damage +5%','DEX+3',}},
		body={ name="Valorous Mail", augments={'Attack+9','Weapon skill damage +5%','DEX+7','Accuracy+7',}},
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Vishap Brais +3",
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.precast.WS['Retribution'] = {
		ammo="Knobkierrie",
	    head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Vishap Brais +3",
		feet="Sulev. Leggings +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Epaminondas's Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.precast.WS['Shattersoul'] = {
	    ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Attack+23','Weapon skill damage +5%','DEX+3',}},
		body={ name="Valorous Mail", augments={'Attack+9','Weapon skill damage +5%','DEX+7','Accuracy+7',}},
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Vishap Brais +3",
		feet="Sulev. Leggings +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Ishvara Earring",
		right_ear="Thrud Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Epaminondas's Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.precast.WS['Raiden Thrust'] = {
		ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'"Mag.Atk.Bns."+24','Enmity+2','"Treasure Hunter"+1','Accuracy+4 Attack+4','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
		body="Sacro Breastplate",
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Vishap Brais +3",
		feet={ name="Valorous Greaves", augments={'Blood Pact Dmg.+2','"Mag.Atk.Bns."+26','Quadruple Attack +1','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},	
	}
	
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS['Raiden Thrust'], {
		head="Pixie Hairpin +1",
		right_ring="Archon Ring",
	})
	
	sets.precast.WS['Shell Crusher'] = {
	    ammo="Voluspa Tathlum",
		head="Flam. Zucchetto +2",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti’s Breeches",
		feet="Flam. Gambieras +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Digni. Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Pet: Damage taken -5%',}},
	}
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {
        --head="Twilight Helm",
        --neck="Twilight Torque",
        --ear1="Cessance Earring",
        --ear2="Sherida Earring",
		--body="Twilight Mail",
        --ring1="Dark Ring",
        --ring2="Paguroidea Ring",
       -- back="Impassive Mantle",
        --legs="Carmine Cuisses +1",
        --feet="Flamma Gambieras +1"
    }
	

	-- Idle sets
	sets.idle = {}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Field = {
		ammo="Staunch Tathlum +1",
		head="Hjarrandi Helm",
		body="Hjarrandi Breast.",
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Eabani Earring",
		right_ear="Crematio Earring",
		left_ring="Defending Ring",
		right_ring="C. Palug Ring",
		back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Pet: Damage taken -5%',}},
    }

	sets.idle.Town = set_combine(sets.idle.Field, {
		body="Councilor's Garb",
    })

    sets.idle.Regen = set_combine(sets.idle.Field, {
        --head="Valorous Mask",
		--body="Kumarbi's Akar",
        --neck="Lissome Necklace",
    })

	sets.idle.Weak = set_combine(sets.idle.Field, {
		--head="Twilight Helm",
		--body="Twilight Mail",
    })
	
	-- Defense sets
	sets.defense.PDT = {
		head="Hjarrandi Helm",
		body="Hjarrandi Breast.",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet={ name="Amm Greaves", augments={'HP+50','VIT+10','Accuracy+15','Damage taken-2%',}},
		left_ring="Defending Ring",
		back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Dbl.Atk."+10','Pet: Damage taken -5%',}},
    }

	sets.defense.Reraise = set_combine(sets.defense.PDT, {
		--head="Twilight Helm",
		--body="Twilight Mail"
    })

	sets.defense.MDT = set_combine(sets.defense.PDT, {
         --back="Impassive Mantle",
    })

	sets.Kiting = {
        legs="Carmine Cuisses +1",
    }

	sets.Reraise = {
		--head="Twilight Helm",
		--body="Twilight Mail",
	}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body="Hjarrandi Breast.",
		hands={ name="Acro Gauntlets", augments={'Accuracy+20 Attack+20','"Store TP"+6','STR+7 DEX+7',}},
		legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
		feet="Flam. Gambieras +2",
		neck="Vim Torque +1",
		waist="Ioskeha Belt +1",
		left_ear="Brutal Earring",
		right_ear="Sherida Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Pet: Damage taken -5%',}},
    }

	sets.engaged.Mid = set_combine(sets.engaged, {
	    body="Vishap Mail +3",
		hands={ name="Emi. Gauntlets +1", augments={'HP+65','DEX+12','Accuracy+20',}},
		legs="Sulev. Cuisses +2",
		neck="Dgn. Collar +2",
    })

	sets.engaged.Acc = set_combine(sets.engaged.Mid, {
	
    })

    sets.engaged.PDT = set_combine(sets.engaged, {
		head="Hjarrandi Helm",
		body="Hjarrandi Breast.",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet={ name="Amm Greaves", augments={'HP+50','VIT+10','Accuracy+15','Damage taken-2%',}},
		left_ring="Defending Ring",
		back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Pet: Damage taken -5%',}},
    })
	sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, {
        --head="Ighwa Cap",
        --ring2="Patricius Ring",
        --body="Founder's Breastplate",
        --hands="Crusher Gauntlets",
        --back="Repulse Mantle",
        --legs="Cizin Breeches +1",
    })
	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {
        --head="Ighwa Cap",
        --ring2="Patricius Ring",
        --body="Founder's Breastplate",
        --hands="Crusher Gauntlets",
        --back="Repulse Mantle",
        --legs="Cizin Breeches +1",
    })

    sets.engaged.War = set_combine(sets.engaged, {
        --hands="Emicho Gauntlets",
        --neck="Asperity Necklace",
        --ring2="Petrov Ring"
    })
    sets.engaged.War.Mid = set_combine(sets.engaged.Mid, {
        --neck="Defiant Collar",
    })

	sets.engaged.Reraise = set_combine(sets.engaged, {
		--head="Twilight Helm",
		--body="Twilight Mail"
    })

	sets.engaged.Acc.Reraise = sets.engaged.Reraise

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.english == "Spirit Jump" then
        if not pet.isvalid then
            cancel_spell()
            send_command('Jump')
        end
    elseif spell.english == "Soul Jump" then
        if not pet.isvalid then
            cancel_spell()
            send_command("High Jump")
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if player.hpp < 51 then
		classes.CustomClass = "Breath" 
	end
    if spell.type == 'WeaponSkill' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        -- if is_sc_element_today(spell) then
            -- if state.OffenseMode.current == 'Normal' and wsList:contains(spell.english) then
                -- --do nothing
            -- else
                -- equip(sets.WSDayBonus)
            -- end
        -- end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
	    equip(sets.midcast.FastRecast)
	    if player.hpp < 51 then
		    classes.CustomClass = "Breath" 
	    end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
end

function job_pet_precast(spell, action, spellMap, eventArgs)
end
-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if spell.english:startswith('Healing Breath') or spell.english == 'Restoring Breath' or spell.english == 'Steady Wing' or spell.english == 'Smiting Breath' then
		equip(sets.HB)
	end
end

-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)
	
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.HybridMode.value == 'Reraise' or
    (state.HybridMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
		equip(sets.Reraise)
	end
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)

end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)

end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.TreasureMode.value == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if string.lower(buff) == "sleep" and gain and player.hp > 200 then
        equip(sets.Berserker)
    else
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end

function job_update(cmdParams, eventArgs)
    war_sj = player.sub_job == 'WAR' or false
	classes.CustomMeleeGroups:clear()
	th_update(cmdParams, eventArgs)
	get_combat_form()
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

function get_combat_form()
	--if areas.Adoulin:contains(world.area) and buffactive.ionis then
	--	state.CombatForm:set('Adoulin')
	--end

    if war_sj then
        state.CombatForm:set("War")
    else
        state.CombatForm:reset()
    end
end


-- Job-specific toggles.
function job_toggle(field)

end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

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
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
    	set_macro_page(13, 1)
    elseif player.sub_job == 'WHM' then
    	set_macro_page(13, 1)
    else
    	set_macro_page(13, 1)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end