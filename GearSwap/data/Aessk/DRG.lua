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
	state.AutoMode = M{['description'] = 'Auto Mode(default: On)'}
	state.AutoMode:options('On', 'Off')
	windower.register_event('tp change', function(tp)
        if tp > 100
				and state.AutoMode.value == 'On'
				and player.status == 'Engaged' then
            relaxed_play_mode()
        end
    end)
	get_combat_form()
    include('Mote-TreasureHunter')
    state.TreasureMode:set('None')
    state.BreathMode = M(false, 'Breath Mode')
	state.TestMode = M(false, 'Test Mode')
	
    -- list of weaponskills that make better use of otomi helm in low acc situations
    wsList = S{'Drakesbane'}

	state.Buff = {}
	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.default_ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.default_u_ja_ids = S{201, 202, 203, 205, 207}
	
	lockstyleset = 90
	
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Mid', 'Acc')
	state.HybridMode:options('Normal', 'PDT', 'Reraise')
	state.WeaponskillMode:options('Normal', 'Acc','PDL')
	state.PhysicalDefenseMode:options('PDT', 'Reraise')
	state.MagicalDefenseMode:options('MDT')
    
    nin_sj = player.sub_job == 'NIN' or false
	war_sj = player.sub_job == 'WAR' or false

	select_default_macro_book(1, 13)
	send_command('bind ^= gs c cycle treasuremode')
    send_command('bind @h gs c cycle AutoMode')
    send_command('bind @b gs c toggle BreathMode')
	
	set_lockstyle()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	send_command('unbind @h')
	send_command('unbind @b')
	send_command('unbind ^=')
	send_command('unbind !=')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

	organizer_items = {
		remedy="Remedy",
		--shihei="Shihei",
		--shihei_bag="Toolbag (Shihei)",
		grape="Grape Daifuku +1",
		shield="Cait Sith Gua. +1",
		copper_voucher="Copper Voucher",
		silver_voucher="Silver Voucher",
		sp_key="SP Gobbie Key",
	}
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
    sets.WakeUp = {neck="Vim Torque +1"}
    sets.WSDayBonus = {
	}
	
	sets.TreasureHunter = {
		body="Volte Jupon",
		hands="Volte Bracers", 
		legs="Volte Hose",
	}

	sets.precast.JA.Jump = {
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
		hands="Vis. Fng. Gaunt. +3",
		legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
		feet="Ostro Greaves",
		neck="Vim Torque +1",
		waist="Ioskeha Belt +1",
		left_ear="Dedition Earring",
		right_ear="Sherida Earring",
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    }

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
	
	sets.precast.JA['Ancient Circle'] = {legs="Vishap Brais +3"}
	
	-- Elemental Breath sets
	sets.EB = {
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
		left_ring="Dreki Ring",
		right_ring="C. Palug Ring",
		back={ name="Updraft Mantle", augments={'STR+1','Pet: Breath+10',}},
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
		left_ear="Anastasi Earring",
		right_ear="Lancer's Earring",
		left_ring="Defending Ring",
		right_ring="Dreki Ring",
		back={ name="Updraft Mantle", augments={'STR+1','Pet: Breath+10',}},
    }
	
	--Steady Wing / Wyvern HP sets
	sets.SteadyWing = {
		ammo="Staunch Tathlum +1",
		head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
		body={ name="Emicho Haubert +1", augments={'Pet: HP+125','Pet: INT+20','Pet: "Regen"+3',}},
		hands={ name="Despair Fin. Gaunt.", augments={'Accuracy+10','Pet: VIT+7','Pet: Damage taken -3%',}},
		legs="Vishap Brais +3",
		feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Isa Belt",
		left_ear="Anastasi Earring",
		right_ear="Lancer's Earring",
		left_ring="Defending Ring",
		right_ring="Dreki Ring",
		back={ name="Updraft Mantle", augments={'STR+1','Pet: Breath+10',}},
	}
	
	sets.precast.JA['Steady Wing'] = sets.SteadyWing

	sets.precast.JA['Spirit Surge'] = set_combine(sets.SteadyWing, {
		body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
    })
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = {
		ammo="Sapience Orb", --2
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --12
		body="Sacro Breastplate", --10
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --8
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}}, --8
		neck="Baetyl Pendant", --4
		left_ear="Enchntr. Earring +1", --2
		right_ear="Loquac. Earring", --2
		left_ring="Rahab Ring", --2
		right_ring="Prolix Ring", --2
    } --42
    
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --12
		body="Sacro Breastplate", --10
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --8
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}}, --8
		neck="Baetyl Pendant", --4
		left_ear="Enchntr. Earring +1", --2
		right_ear="Loquac. Earring", --2
		left_ring="Rahab Ring", --2
		right_ring="Prolix Ring", --2
	} --40
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	
	sets.precast.WS = {
		ammo="Knobkierrie",
		head="Nyame Helm", 
		body="Nyame Mail",
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Nyame Flanchard",
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    }
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stardiver'] = {
		ammo="Knobkierrie",
		head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
		body="Gleti's Cuirass",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet={ name="Lustra. Leggings +1", augments={'Attack+20','STR+8','"Dbl.Atk."+3',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	}
	sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS['Stardiver'], {})
	sets.precast.WS['Stardiver'].PDL = set_combine(sets.precast.WS['Stardiver'], {
		ammo="Crepuscular Pebble",
		head="Flam. Zucchetto +2",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Flam. Gambieras +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
	})

    sets.precast.WS["Camlann's Torment"] = {
		ammo="Knobkierrie",
		head="Nyame Helm", 
		body="Nyame Mail",
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Nyame Flanchard",
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    }
	sets.precast.WS["Camlann's Torment"].Acc = set_combine(sets.precast.WS["Camlann's Torment"], {})
	
	sets.precast.WS['Geirskogal'] = set_combine(sets.precast.WS["Camlann's Torment"], {
		left_ear="Sherida Earring",
	})
	sets.precast.WS['Geirskogal'].Acc = set_combine(sets.precast.WS['Geirskogal'], {})

	sets.precast.WS['Drakesbane'] = {
		ammo="Knobkierrie",
	    head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	}
	sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS['Drakesbane'], {})
	
	sets.precast.WS['Impulse Drive'] = {
		ammo="Knobkierrie",
	    head="Nyame Helm", 
		body="Nyame Mail",
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Nyame Flanchard",
		feet="Sulev. Leggings +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	}
	
	sets.precast.WS['Impulse Drive'].PDL = set_combine(sets.precast.WS['Impulse Drive'], {
		--This is a Crit set
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		})

	sets.precast.WS['Savage Blade'] = {
		ammo="Knobkierrie",
	    head="Nyame Helm", 
		--body="Nyame Mail",
		body="Gleti's Cuirass",
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	}
	
	sets.precast.WS['Savage Blade'].PDL = set_combine(sets.precast.WS['Savage Blade'], {
		ammo="Crepuscular Pebble",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
	})
	
	sets.precast.WS['Full Swing'] = {
	    ammo="Knobkierrie",
		head="Nyame Helm", 
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	}
	
	sets.precast.WS['Retribution'] = {
		ammo="Knobkierrie",
	    head="Nyame Helm", 
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Thrud Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Epaminondas's Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	}
	
	sets.precast.WS['Shattersoul'] = {
	    ammo="Knobkierrie",
		head="Nyame Helm", 
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Ishvara Earring",
		right_ear="Thrud Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Epaminondas's Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	}
	
	sets.precast.WS['Raiden Thrust'] = {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Sacro Breastplate",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}	
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
		legs="Gleti's Breeches",
		feet="Flam. Gambieras +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Digni. Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	}
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {
        --head="Twilight Helm",
        --neck="Twilight Torque",
    }
	

	-- Idle sets
	sets.idle = {}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Field = {
		ammo="Staunch Tathlum +1", --3DT
	    head="Gleti's Mask", --6PDT
		body="Gleti's Cuirass", --9PDT
		hands="Gleti's Gauntlets", --7PDT
		legs="Gleti's Breeches", --8PDT
		--legs="Carmine Cuisses +1",
		feet="Gleti's Boots", --5PDT
		neck="Loricate Torque +1", --6DT
		waist="Flume Belt +1", --4PDT
		left_ear="Eabani Earring",
		right_ear="Sanare Earring",
		left_ring="Defending Ring", --10DT
		right_ring="Moonlight Ring", --5DT
		back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}} --10PDT
    }
	
	sets.idle.Town = set_combine(sets.idle.Field, {
		legs="Carmine Cuisses +1"
    })

    sets.idle.Regen = set_combine(sets.idle.Field, {
		body="Sacro Breastplate",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1"
    })

	sets.idle.Weak = set_combine(sets.idle.Field, {
		--head="Twilight Helm",
		--body="Twilight Mail",
    })
	
	-- Defense sets
	sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",   
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Isa Belt",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    }

	sets.defense.Reraise = set_combine(sets.defense.PDT, {
		--head="Twilight Helm",
		--body="Twilight Mail"
    })

	sets.defense.MDT = set_combine(sets.defense.PDT, {
    })

	sets.Kiting = {legs="Carmine Cuisses +1",}
	
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
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2", --4
		body="Gleti's Cuirass",
		hands={ name="Acro Gauntlets", augments={'Accuracy+20 Attack+20','"Store TP"+6','STR+7 DEX+7',}},	--4
		legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},	--5
		feet="Flam. Gambieras +2",	--2
		neck="Vim Torque +1",
		waist="Ioskeha Belt +1",	--8
		left_ear="Brutal Earring",
		right_ear="Sherida Earring",
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
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
		head="Hjarrandi Helm", --10DT
		body="Hjarrandi Breast.", --12DT
		hands="Sulev. Gauntlets +2", --5DT
		left_ring="Moonlight Ring", --5DT
		right_ring="Moonlight Ring", --5DT
    })
	sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, {
		head="Hjarrandi Helm", --10DT
		body="Hjarrandi Breast.", --12DT
		hands="Sulev. Gauntlets +2", --5DT
		left_ring="Moonlight Ring", --5DT
		right_ring="Moonlight Ring", --5DT
    })
	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {
		head="Hjarrandi Helm", --10DT
		body="Hjarrandi Breast.", --12DT
		hands="Sulev. Gauntlets +2", --5DT
		left_ring="Moonlight Ring", --5DT
		right_ring="Moonlight Ring", --5DT
    })

    sets.engaged.Nin = set_combine(sets.engaged, {
		hands="Sulev. Gauntlets +2",
		legs={ name="Valorous Hose", augments={'Accuracy+18 Attack+18','"Dbl.Atk."+5','DEX+6','Attack+13',}},
		neck="Shulmanu Collar",
    })
    sets.engaged.Nin.PDT = set_combine(sets.engaged.Nin, {
		head="Hjarrandi Helm", --10DT
		body="Hjarrandi Breast.", --12DT
		left_ring="Moonlight Ring", --5DT
		right_ring="Moonlight Ring", --5DT
    })
	
	sets.engaged.War = set_combine(sets.engaged, {
		neck="Shulmanu Collar",
		hands="Sulev. Gauntlets +2",
    })
	sets.engaged.War.PDT = set_combine(sets.engaged.War, {
		head="Hjarrandi Helm", --10DT
		body="Hjarrandi Breast.", --12DT
		left_ring="Moonlight Ring", --5DT
		right_ring="Moonlight Ring", --5DT
    })

	sets.engaged.Reraise = set_combine(sets.engaged, {
		--head="Twilight Helm",
		--body="Twilight Mail"
    })

	sets.engaged.Acc.Reraise = sets.engaged.Reraise
	
	sets.buff.Doom = {
       --neck="Nicander's Necklace", --20
       left_ring="Purity Ring", --10
       right_ring="Eshmun's Ring", --20
       waist="Gishdubar Sash", --10
    }

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
	
	if spell.type == 'WeaponSkill' then
		if player.tp < 1000 then
            eventArgs.cancel = true
            return
        end
        if ((spell.target.distance >8 and spell.skill ~= 'Marksmanship') or (spell.target.distance >21)) then
            -- Cancel Action if distance is too great, saving TP
            add_to_chat(122,"Outside WS Range! /Canceling")
            eventArgs.cancel = true
            return

        -- elseif state.DefenseMode.value ~= 'None' then
            -- -- Don't gearswap for weaponskills when Defense is on.
            -- eventArgs.handled = true
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
		if state.BreathMode.value then
			classes.CustomClass = "Breath" 
		end
	end
    if spell.type == 'WeaponSkill' then
		if spell.english ~= 'Shell Crusher' then
			-- Replace TP-bonus gear if not needed.
			if player.tp < 2750 then
				equip({left_ear="Moonshade Earring"})
			end
		end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
	    equip(sets.midcast.FastRecast)
	    if player.hpp < 51 then
			if state.BreathMode.value then
				classes.CustomClass = "Breath" 
			end
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
    if spell.english:startswith('Healing Breath') or spell.english == 'Restoring Breath' then
		equip(sets.HB)
	end
	if spell.english == 'Smiting Breath' then
		equip(sets.EB)
	end
	if spell.english == 'Steady Wing' then
		equip(sets.SteadyWing)
		windower.send_command('wait 1.2;gs c update')
	end
	if string.find(spell.name,' Breath') then
		if state.BreathMode.value then
			if string.find(spell.name,'Healing') then 
				equip(sets.HB)
			else
				equip(sets.EB)
			end
			windower.send_command('wait 1.2;gs c update')
		end
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
	-- if world.area:contains('Echoes') then
		-- idleSet = set_combine(idleSet, {legs="Carmine Cuisses +1"})
	if world.area:contains('Adoulin') or world.area == "Celennia Memorial Library" then
		idleSet = set_combine(idleSet, {body="Councilor's Garb"})
	elseif world.area == "Mog Garden" then
		idleSet = set_combine(idleSet, {body="Jubilee Shirt"})
	end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.TreasureMode.value == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
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
        equip(sets.WakeUp)
    else
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end

function job_update(cmdParams, eventArgs)
    nin_sj = player.sub_job == 'NIN' or false
	war_sj = player.sub_job == 'WAR' or false
	classes.CustomMeleeGroups:clear()
	th_update(cmdParams, eventArgs)
	get_combat_form()
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
	if cmdParams[1] == 'true' then
		state.TestMode.value = true
	end
	if cmdParams[1] == 'false' then
		state.TestMode.value = false
	end
	if cmdParams[1] == 'test' then
		if state.TestMode.value then
			add_to_chat(123, 'hmm')
		else
			add_to_chat(123, 'umm')
		end
	end
end

function get_combat_form()
	--if areas.Adoulin:contains(world.area) and buffactive.ionis then
	--	state.CombatForm:set('Adoulin')
	--end

    if nin_sj then
        state.CombatForm:set("Nin")
    elseif war_sj then
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
    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
			windower.play_sound(windower.addon_path..'data/sounds/doomed.wav')
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end
end

function check_buffs(...)
    --[[ Function Author: Arcon
            Simple check before attempting to auto activate Job Abilities that
            check active buffs and debuffs ]]
    return table.any({...}, table.get+{buffactive})
end

do
    --[[ Author: Arcon
            The three next "do" sections are used to aid in checking recast
            times, can check multiple recast times at once ]]
    local cache = {}

    function j(str)
        if not cache[str] then
            cache[str] = gearswap.res.job_abilities:with('name', str)
        end

        return cache[str]
    end
end

do
    local cache = {}

    function s(str)
        if not cache[str] then
            cache[str] = gearswap.res.spells:with('name', str)
        end

        return cache[str]
    end
end

do
    local ja_types = S(gearswap.res.job_abilities:map(table.get-{'type'}))

    function check_recasts(...)
        local spells = S{...}

        for spell in spells:it() do
            local fn = 'get_' .. (ja_types:contains(spell.type)
                    and 'ability'
                    or 'spell') ..'_recasts'
            if windower.ffxi[fn]()[spell.recast_id] > 0 then
                return false
            end
        end

        return true
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

function relaxed_play_mode()
    -- This can be used as a mini bot to automate actions
    if not midaction() and player.status == 'Engaged' then
        if player.sub_job == 'SAM' 
				and not check_buffs('Hasso')
				and not check_buffs('Seigan')
                and not check_buffs('amnesia')
                and check_recasts(s('Hasso')) then
            windower.send_command('Hasso')
        end
		
    end
	
end



-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
    	set_macro_page(3, 13)
	elseif player.sub_job == 'NIN' or player.sub_job == 'DNC' then
		set_macro_page(2, 13)
    else
    	set_macro_page(1, 13)
    end
end

-- function set_lockstyle()
	-- if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
		-- send_command('wait 6; input /lockstyleset 96')
	-- elseif player.sub_job == 'WAR' then
		-- send_command('wait 6; input /lockstyleset 97')
	-- else
		-- send_command('wait 6; input /lockstyleset ' .. lockstyleset)
	-- end
-- end

function set_lockstyle()
	if player.equipment.main:contains("Naegling") and player.equipment.sub:contains("Ternion Dagger +1") then
		send_command('wait 6; input /lockstyleset 83')
	elseif player.equipment.main:contains("Naegling") and player.equipment.sub:contains("Cait Sith Gua. +1") then
		send_command('wait 6; input /lockstyleset 87')
	elseif player.equipment.main:contains("Trishula") or player.equipment.main:contains("Shinning One") then
		send_command('wait 6; input /lockstyleset 90')
	else
		send_command('wait 6; input /lockstyleset ' .. lockstyleset)
	end
end

