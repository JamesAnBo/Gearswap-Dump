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
     
    include('Mote-TreasureHunter')
 
    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
	
	lockstyleset = 81
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'RA', 'Mod')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')
	state.IdleMode:options('Normal', 'Evasion')
	
	state.WeaponLock = M(false, 'Weapon Lock')
 
    gear.default.weaponskill_neck = "Fotia Gorget"
    gear.default.weaponskill_waist = "Fotia Belt"
    gear.AugQuiahuiz = {name="Quiahuiz Trousers", augments={'Haste+2','"Snapshot"+2','STR+8'}}
 
    -- Additional local binds

    send_command('bind ^` input /ja "Flee" <me>')
	send_command('bind ^= gs c cycle treasuremode') 	--ctrl =
	send_command('bind ^!f10 input /ra <t>')				--ctrl alt F10 (M1G6)
    --send_command('bind f1 gs c cycle OffenseMode')
    --send_command('bind f2 gs c cycle RangedMode')
	send_command('bind @w gs c toggle WeaponLock')		--win W
 
    select_default_macro_book()
	set_lockstyle()
end
 
-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
	send_command('unbind ^=')
	send_command('unbind @w')
	
	send_command('unbind ^!f1')
	send_command('unbind ^!f2')
	send_command('unbind ^!f3')
	send_command('unbind ^!f4')
	send_command('unbind ^!f5')
	send_command('unbind ^!f6')
	send_command('unbind ^!f7')
	send_command('unbind ^!f8')
	send_command('unbind ^!f9')
	send_command('unbind ^!f10')
	send_command('unbind ^!f11')
	send_command('unbind ^!f12')
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()

	organizer_items = {
		remedy="Remedy",
		grape="Grape Daifuku +1",
		maze="Maze Tabula M01",
		mog_amp="Moogle Amp.",
		gandring="Gandring",
		gash_quiver="Gash. Bolt Quiver",
		gash_bolt="Gashing Bolt",
		x_bow="Exalted C.Bow +1",
		--jubilee="Jubilee Shirt",
		copper_voucher="Copper Voucher",
		silver_voucher="Silver Voucher",
		sp_key="SP Gobbie Key",
	}

    --------------------------------------
    -- Start defining the sets
    --------------------------------------
 
    -- Treasure Hunter - Gandring TH+3
     
    -- sets.TreasureHunter = {
		-- ammo="Per. Lucky Egg",	--1
		-- --head=gear.Herc_TH_head, --2
		-- --body="Volte Jupon", --2
		-- hands={ name="Plun. Armlets +3", augments={'Enhances "Perfect Dodge" effect',}}, --4
		-- --legs="Volte Hose", --1
		-- --feet="Skulk. Poulaines +1", --2
		-- --waist="Chaac Belt", --1
	-- }
	sets.TreasureHunter = {
		ammo="Per. Lucky Egg",	--1
		head=gear.Herc_TH_head, --2
		body="Volte Jupon", --2
		hands={ name="Plun. Armlets +3", augments={'Enhances "Perfect Dodge" effect',}}, --4
		legs="Volte Hose", --1
		feet="Skulk. Poulaines +1", --2
		waist="Chaac Belt", --1
	}
	sets.TH5 = {
		ammo="Per. Lucky Egg",	--1
		--head=gear.Herc_TH_head, --2
		hands={ name="Plun. Armlets +3", augments={'Enhances "Perfect Dodge" effect',}}, --4
	}

    sets.TreasureHunterRA = {
		head=gear.Herc_TH_head, --2
		body="Volte Jupon", --2
		hands={ name="Plun. Armlets +3", augments={'Enhances "Perfect Dodge" effect',}}, --4
		legs="Volte Hose", --1
		feet="Skulk. Poulaines +1", --2
		waist="Chaac Belt", --1
		neck="Iskur Gorget",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Cacoethic Ring +1",
		right_ring="Hajduk Ring +1",
		back=gear.THF_SNP_Cape,
	}
     
    sets.ExtraRegen = {
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1"
	}
     
    sets.Kiting = {feet="Jute Boots +1"}
     
    sets.CapacityMantle = {back="Mecistopins Mantle"}
 
    sets.buff['Sneak Attack'] = {
		ammo="C. Palug Stone",
		head="Pill. Bonnet +3",
		body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
		hands="Mummu Wrists +2",
		legs="Pill. Culottes +3",
		feet=gear.Lust_D_feet,
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Odr Earring",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		gear.THF_WS2_Cape
    }
 
    sets.buff['Trick Attack'] = {
		ammo="C. Palug Stone",
		head="Pill. Bonnet +3",
		body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
		hands=gear.Adhemar_A_hands,
		legs="Pill. Culottes +3",
		feet=gear.Lust_D_feet,
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back=gear.THF_SNP_Cape
    }
     
    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.FullTH
    sets.precast.Flourish1 = sets.FullTH
    sets.precast.JA.Provoke = sets.FullTH
 
    --------------------------------------
    -- Precast sets
    --------------------------------------
 
    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Skulker's Bonnet +1"}
    sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet +1"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +3"}
    sets.precast.JA['Hide'] = {body="Pillager's Vest +3"}
    sets.precast.JA['Conspirator'] = {body="Skulker's Vest +1"}
    sets.precast.JA['Steal'] = {
		ammo="Barathrum",
		head="Plun. Bonnet +3",
		feet="Pillager's Poulaines +3",
		neck="Pentalagus Charm",
		waist="Key Ring Belt"
	}
    sets.precast.JA['Despoil'] = {ammo="Barathrum",legs="Skulker's Culottes +1",feet="Skulker's Poulaines +1"}
	sets.precast.JA['Mug'] = {
	    ammo="C. Palug Stone",
		head={ name="Plun. Bonnet +3", augments={'Enhances "Aura Steal" effect',}},
		body="Mummu Jacket +2",
		hands="Mummu Wrists +2",
		legs="Mummu Kecks +2",
		feet="Mummu Gamash. +2",
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Odr Earring",
		left_ring={ name="Cacoethic Ring +1", augments={'Path: A',}},
		right_ring="Ilabrat Ring",
		back=gear.THF_WS2_Cape
	}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +3"}
    sets.precast.JA['Feint'] = {legs="Plunderer's Culottes +3"}
 
    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']
 
 
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		-- ammo="Yamarang",
		-- head={ name="Plun. Bonnet +3", augments={'Enhances "Aura Steal" effect',}},
		-- body="Passion Jacket",
		-- hands="Regal Gloves",
		-- legs="Dashing Subligar",
		-- feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
		-- neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		-- waist="Chaac Belt",
		-- left_ear="Handler's Earring +1",
		-- right_ear="Enchntr. Earring +1",
		-- left_ring="Moonlight Ring",
		-- right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		-- back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }
 
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
 
    -- Fast cast sets for spells
    sets.precast.FC = {
		head=gear.Herc_FC_head,	--15
		body=gear_Adhemar_D_body,	--10
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},	--8
		legs=gear.Herc_FC_legs, --6																													
		feet=gear.Herc_FC_feet,	--6
		neck="Baetyl Pendant",	--4
		left_ear="Loquac. Earring",	--2
		right_ear="Enchntr. Earring +1",	--2
		left_ring="Rahab Ring",	--2
		right_ring="Prolix Ring",	--2
	}
 
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        body="Passion Jacket",
		neck="Magoraga Beads",
    })
 
 
    -- Ranged snapshot gear
    sets.precast.RA = {
		head=gear.Taeon_SNP_head,
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs=gear.Adhemar_D_legs,
		feet="Meg. Jam. +2",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring={ name="Cacoethic Ring +1", augments={'Path: A',}},
		right_ring="Crepuscular Ring",
		back=gear.THF_SNP_Cape
	}
 
 
    -- Weaponskill sets
 
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="C. Palug Stone",
		head="Nyame Helm",
		body="Plunderer's Vest +3", --relic
		hands="Meg. Gloves +2",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Asn. Gorget +2",
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back=gear.THF_WS1_Cape
}
    
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Rudra\'s Storm'] = {
		ammo="C. Palug Stone",
		head="Nyame Helm",
		body="Plunderer's Vest +3", --relic
		hands="Meg. Gloves +2",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Asn. Gorget +2",
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear="Moonshade Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Ilabrat Ring",
		back=gear.THF_WS1_Cape
	}
	
	sets.precast.WS['Rudra\'s Storm'].SA = set_combine(sets.precast.WS['Rudra\'s Storm'], {head="Pill. Bonnet +3",})
	
	sets.precast.WS['Rudra\'s Storm'].TA = set_combine(sets.precast.WS['Rudra\'s Storm'], {head="Pill. Bonnet +3",})

    sets.precast.WS['Mandalic Stab'] = {
		ammo="C. Palug Stone",
		head="Nyame Helm",
		body="Plunderer's Vest +3", --relic
		hands="Meg. Gloves +2",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Asn. Gorget +2",
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Ilabrat Ring",
		back=gear.THF_WS1_Cape
	}

	sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'], {head="Pill. Bonnet +3",})
	
	sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'], {head="Pill. Bonnet +3",})

    sets.precast.WS['Evisceration'] = {
	    ammo="Yetshila +1",
		head="Pill. Bonnet +3", --AF
		body="Plunderer's Vest +3", --relic
		hands="Gleti's Gauntlets",
		legs="Pill. Culottes +3",  --AF
		feet="Plunderer's Poulaines +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear="Moonshade Earring",
		left_ring="Mummu Ring",
		right_ring="Ilabrat Ring",
		back=gear.THF_WS2_Cape
	}

	sets.precast.WS['Aeolian Edge'] = {
		ammo="Ghastly Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}
	sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], {
		head=gear.Herc_TH_head
	})
	sets.precast.WS['Savage Blade'] = {
		ammo="Aurgelmir Orb +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Asn. Gorget +2",
		waist="Sailfi Belt +1",
		left_ear="Ishvara Earring",
		right_ear="Moonshade Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Gere Ring",
		back=gear.THF_WS1_Cape
	}

	sets.precast.WS['Last Stand'] = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Meg. Gloves +2",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear="Moonshade Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Cacoethic Ring +1",
		back=gear.THF_WS1_Cape
		}

    --------------------------------------
    -- Midcast sets
    --------------------------------------
 
    sets.midcast.FastRecast = {}
 
    -- Specific spells
    sets.midcast.Utsusemi = {neck="Magoraga Beads",}
 
    -- Ranged gear
    sets.midcast.RA = {
		ammo="Gashing Bolt",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Hajduk Ring +1",
		right_ring="Cacoethic Ring +1",
		back=gear.THF_SNP_Cape
	}
 
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {})
 
 
    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------
 
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
 
    sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Sanare Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Purity Ring",
		back=gear.THF_TP_Cape,
	}
 
    sets.idle.Town = {
		feet="Pill. Poulaines +3"
	}
 
    sets.idle.Weak = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",   
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",	
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Sanare Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Purity Ring",
		back=gear.THF_TP_Cape,
	}
	
	sets.idle.Evasion = {
		ammo="Yamarang",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Sanare Earring",
		right_ear="Eabani Earring",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
 
    -- Resting sets
    sets.resting = sets.idle.Weak
 
    -- Defense sets
 
    sets.defense.Evasion = {
		ammo="Yamarang",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Sanare Earring",
		right_ear="Eabani Earring",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
 
    sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",   
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",	
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Sanare Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Purity Ring",
		back=gear.THF_TP_Cape,
	}
 
    sets.defense.MDT = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",   
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",	
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Sanare Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Purity Ring",
		back=gear.THF_TP_Cape,
	}
 
 
    --------------------------------------
    -- Melee sets
    --------------------------------------
 
    -- Normal melee group
    -- Triple Attack 35%, Triple Attack Damage 42%, ACC 1173, Attack 1129
    sets.engaged = {
		ammo="Coiste Bodhar",
		head="Plun. Bonnet +3",
		body="Pillager's Vest +3",  --AF
		hands=gear.Adhemar_A_hands,
		legs="Pill. Culottes +3",  --AF
		feet="Plunderer's Poulaines +3",
		neck="Asn. Gorget +2",
		waist="Windbuffet Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Hetairoi Ring",
		right_ring="Gere Ring",
		back=gear.THF_TP_Cape,
	}
    sets.engaged.Acc = {
		ammo="Coiste Bodhar",
		head="Plun. Bonnet +3",
		body="Pillager's Vest +3",  --AF
		hands=gear.Adhemar_A_hands,
		legs="Pill. Culottes +3",  --AF
		feet="Plunderer's Poulaines +3",
		neck="Asn. Gorget +2",
		waist="Windbuffet Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Hetairoi Ring",
		right_ring="Gere Ring",
		back=gear.THF_TP_Cape,
	}
 
	sets.engaged.RA = {
		ammo="Gashing Bolt",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Cacoethic Ring +1",
		right_ring="Hajduk Ring +1",
		back=gear.THF_SNP_Cape
	}
         
     
    sets.engaged.Evasion = {
		ammo="Coiste Bodhar",
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
		back=gear.THF_TP_Cape,
	}

    sets.engaged.PDT = {
		ammo="Coiste Bodhar",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Asn. Gorget +2",
		waist="Windbuffet Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back=gear.THF_TP_Cape,
}

    sets.engaged.MDT = {
		ammo="Coiste Bodhar",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Asn. Gorget +2",
		waist="Windbuffet Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Moonlight Ring",
		right_ring="Gere Ring",
		back=gear.THF_TP_Cape,
		}

   sets.buff.Doom = {
       --neck="Nicander's Necklace", --20
       left_ring="Purity Ring", --10
       right_ring="Eshmun's Ring", --20
       waist="Gishdubar Sash", --10
       }
     
	sets.Kiting = {feet="Pill. Poulaines +3"}
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell, action, spellMap, eventArgs)
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
        send_command('input /item "Remedy" <me>')
       end
    end 
    if spell.type == 'WeaponSkill' then
        if spell.english == "Rudra's Storm" and player.tp > 2900 then
            equip({ear1="Ishvara Earring",ear2="Sherida Earring"})
		elseif spell.english == "Evisceration" and player.tp > 2900 then
			equip({ear1="Odr Earring",ear2="Sherida Earring"})
        end          
    end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english=='Sneak Attack' or spell.english=='Trick Attack' then
        if state.TreasureMode.value == 'SATA' then
            equip(sets.TreasureHunter)
		elseif state.TreasureMode.value == 'Fulltime' then
			equip(sets.TH5)
        end
    end
	
	if spell.type == 'WeaponSkill' then
		if spell.english == "Aeolian Edge" then
			if state.TreasureMode.value == 'SATA' then
				equip(sets.TreasureHunter)
			elseif state.TreasureMode.value == 'Fulltime' then
				equip(sets.TH5)
			end
        end
    end
end
 
-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
		if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
			equip(sets.TreasureHunterRA)
		end
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
 
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub','ranged','ammo')
    else
        enable('main','sub','ranged','ammo')
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
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
	if world.area:contains('Adoulin') or world.area == "Celennia Memorial Library" then
		idleSet = set_combine(idleSet, {body="Councilor's Garb"})
	elseif world.area == "Mog Garden" then
		idleSet = set_combine(idleSet, {body="Jubilee Shirt"})
	end
 
    return idleSet
end
 
 
function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TH5)
    end
	if buff == "Aftermath: Lv.3" and gain or buffactive['Aftermath: Lv.3'] then
		meleeSet = set_combine(meleeSet, sets.AM3)
    end
 
    return meleeSet
end
 
 
 
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
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
     
function idle_town_values ()
sets.idle.Town = S{
    "Ru'Lude Gardens",
    "Upper Jeuno",
    "Lower Jeuno",
    "Port Jeuno",
    "Port Windurst",
    "Windurst Waters",
    "Windurst Woods",
    "Windurst Walls",
    "Heavens Tower",
    "Port San d'Oria",
    "Northern San d'Oria",
    "Southern San d'Oria",
    "Port Bastok",
    "Bastok Markets",
    "Bastok Mines",
    "Metalworks",
    "Aht Urhgan Whitegate",
    "Al Zahbi",
    "South Sandoria [S]",
    "Bastok Markets [S]",
    "Windurst Waters [S]",
    "Tavnazian Safehold",
    "Nashmau",
    "Selbina",
    "Mhaura",
    "Rabao",
    "Norg",
    "Eastern Adoulin",
    "Western Adoulin",
    "Kazham"
}
end
 
end
 

-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('ranged', 'ammo')
    else
        enable('ranged', 'ammo')
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

function set_lockstyle()
    send_command('wait 6; input /lockstyleset ' .. lockstyleset)
end