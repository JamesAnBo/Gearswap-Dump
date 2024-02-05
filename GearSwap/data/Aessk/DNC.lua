-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
end
 
-- Setup variables that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
 
    state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
    state.AltStep = M{['description']='Alt Step', 'Quickstep', 'Feather Step', 'Stutter Step', 'Box Step'}
    state.UseAltStep = M(false, 'Use Alt Step')
    state.SelectStepTarget = M(false, 'Select Step Target')
    state.IgnoreTargetting = M(true, 'Ignore Targetting')
 
    state.ClosedPosition = M(false, 'Closed Position')
 
    state.CurrentStep = M{['description']='Current Step', 'Main', 'Alt'}
--  state.SkillchainPending = M(false, 'Skillchain Pending')
 
    state.CP = M(false, "Capacity Points Mode")
 
    lockstyleset = 81
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Gear Modes
function user_setup()
    state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'HIGH', 'MID', 'LOW')
    state.WeaponskillMode:options('Normal', 'Acc')
   
    send_command('lua l dnc-hud')
   
-- Allows the use of Ctrl + ~ and Alt + ~ for 2 more macros of your choice.
    --send_command('bind ^` input /ja "Chocobo Jig II" <me>') --Ctrl'~'
    --send_command('bind !` input /ja "Spectral Jig" <me>') --Alt'~'
    send_command('bind f9 gs c cycle OffenseMode') --F9
    --send_command('bind ^f9 gs c cycle WeaponSkillMode') --Ctrl'F9'
    send_command('bind f10 gs c cycle HybridMode') --F10
    send_command('bind f11 gs c cycle mainstep') --F11
 
    select_default_macro_book()
    set_lockstyle()
 
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end
 
-- Erases the Key Binds above when you switch to another job.
function user_unload()

	send_command('lua u dnc-hud')

    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind !-')
    send_command('unbind ^=')
    send_command('unbind f11')
    --send_command('bind @c')
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()

	organizer_items = {
		remedy="Remedy",
		--shihei="Shihei",
		--shihei_bag="Toolbag (Shihei)",
		grape="Grape Daifuku +1",
		maze="Maze Tabula M01",
		mog_amp="Moogle Amp.",
		copper_voucher="Copper Voucher",
		silver_voucher="Silver Voucher",
		sp_key="SP Gobbie Key",
	}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
 
    sets.Enmity = {
		head="Halitus Helm",
	    body="Emet Harness +1",
		hands="Kurys Gloves",
		legs="Zoar Subligar +1",
		neck="Unmoving Collar +1",
		waist="Sinew Belt",
		left_ear="Pluto's Pearl",
		right_ear="Trux Earring",
		left_ring="Eihwaz Ring",
		right_ring="Begrudging Ring",
		back="Agema Cape",
	}
 
    sets.precast.JA['Provoke'] = sets.Enmity
    sets.precast.JA['No Foot Rise'] = {body="Horos Casaque +3"}
    sets.precast.JA['Trance'] = {head="Horos Tiara +3"}
 
    sets.precast.Waltz = {
		ammo="Voluspa Tathlum", --0/5
		head="Anwig Salade", --Recast
		body="Maxixi Casaque +3", --19/33/Recast
		hands="Regal Gloves", --0/40
		legs="Dashing Subligar", --10/11/blink
		feet="Maxixi Toe Shoes +3", --14/40
		neck="Etoile Gorget +2", --10/25
		waist="Aristo Belt", --0/8
		left_ear="Enchntr. Earring +1", --0/5
		right_ear="Handler's Earring +1", --0/5
		left_ring="Carb. Ring +1", --0/9
		right_ring="Metamor. Ring +1", --0/16
        --back="Toetapper Mantle", --5/0
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	} --58/
 
    sets.precast.WaltzSelf = set_combine(sets.precast.Waltz, {ring1="Asklepian Ring"})
    sets.precast.Waltz['Healing Waltz'] = {}
    
	sets.precast.Samba = {
		head="Maxixi Tiara +3",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
    sets.precast.Jig = {
		feet="Maxixi Toe shoes +3",
		legs="Horos Tights +3"
	}
 
    sets.precast.Step = {
		ammo="Yamarang",
		head="Maxixi Tiara +3",
		body="Maxixi Casaque +3",
		hands="Maxixi Bangles +3",
		legs="Malignance Tights",
		feet="Horos T. Shoes +3",
		neck="Etoile Gorget +2",
		waist="Olseni Belt",
		left_ear="Mache Earring +1",
		right_ear="Mache Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		--left_ring="Regal Ring",
		--right_ring="Cacoethic Ring +1",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
    sets.precast.Step['Feather Step'] = set_combine(sets.precast.Step, {feet="Macu. Toe Shoes +1"})
   
    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Animated Flourish'] = sets.Enmity
    sets.precast.Flourish1['Violent Flourish'] = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Horos Casaque +3",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Etoile Gorget +2",
		waist="Eschan Stone",
		left_ear="Digni. Earring",
		right_ear="Gwati Earring",
		left_ring="Stikini Ring +1",
		right_ring="Metamor. Ring +1",
	}
	
    sets.precast.Flourish1['Desperate Flourish'] = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Etoile Gorget +2",
		waist="Eschan Stone",
		left_ear="Digni. Earring",
		right_ear="Gwati Earring",
		left_ring="Stikini Ring +1",
		right_ring="Metamor. Ring +1",
	}
 
    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {hands="Macu. Bangles +1",back="Toetapper Mantle"}
   
    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {body="Macu. Casaque +1"}
    sets.precast.Flourish3['Climactic Flourish'] = {head="Maculele Tiara +1",}
	
	sets.precast.JA['Jump'] = {
		ammo="Coiste Bodhar",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Anu Torque",
		waist="Kentarch Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Petrov Ring",
		right_ring="Ilabrat Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.JA['High Jump'] = sets.precast.JA['Jump']
 
    sets.precast.FC = {ammo="Impatiens",ear2="Loquacious Earring"}
 
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
 
    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------
    sets.precast.WS = {
		ammo="C. Palug Stone",
 		head="Nyame Helm",   
		body="Nyame Mail",
		hands="Maxixi Bangles +3",
		--legs="Horos Tights +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Etoile Gorget +2",
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    }
 
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
 
    sets.precast.WS.Critical = set_combine(sets.precast.WS, {})
 
    sets.precast.WS['Exenterator'] = {}
 
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})
 
    sets.precast.WS['Pyrrhic Kleos'] = {
		}
 
    sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS['Pyrrhic Kleos'], {})
 
    sets.precast.WS['Evisceration'] = {
	    ammo="Yetshila +1",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear="Moonshade Earring",
		left_ring="Mummu Ring",
		right_ring="Ilabrat Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
        }
 
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
 
    sets.precast.WS['Rudra\'s Storm'] = sets.precast.WS
    sets.precast.WS['Rudra\'s Storm'].Acc = set_combine(sets.precast.WS['Rudra\'s Storm'], {})
 
    sets.precast.WS['Aeolian Edge'] = {
        }
 
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
 
    sets.midcast.FastRecast = sets.precast.FC
    sets.midcast.SpellInterrupt = {}
    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt
 
    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------
 
    sets.idle = {
	    ammo="Yamarang",
	    head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Sanare Earring",
		right_ear="Eabani Earring",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
 
    sets.idle.Town = {
	    ammo="Yamarang",
	    head="Gleti's Mask",
		body="Councilor's Garb",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Sanare Earring",
		right_ear="Eabani Earring",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
 
	sets.idle.DT = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Warder's Charm +1",
		waist="Gishdubar Sash",
		left_ear="Sanare Earring",
		right_ear="Eabani Earring",
		left_ring="Purity Ring",
		right_ring="Archon Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
-- This is a Set that would only be used when you are NOT Dual Wielding.  Most likely Airy Buckler Builds with Fencer as War Sub.
-- There are no haste parameters set for this build, because you wouldn't be juggling DW gear, you would always use the same gear, other than Damage Taken and Accuracy sets which ARE included below.
   sets.engaged = {
		ammo="Coiste Bodhar",
		head="Maxixi Tiara +3",
		body="Horos Casaque +3",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Horos T. Shoes +3",
		neck="Etoile Gorget +2",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Epona's Ring",
		right_ring="Gere Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
 
   ------------------------------------------------------------------------------------------------
   -------------------------------------- Dual Wield Sets -----------------------------------------
    ------------------------------------------------------------------------------------------------
   -- * DNC Native DW Trait: 30% DW
   -- * DNC Job Points DW Gift: 5% DW
 
   -- No Magic Haste (39% DW to cap)
   sets.engaged.DW = {
		ammo="Coiste Bodhar",
		head="Maxixi Tiara +3",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Horos T. Shoes +3",
		neck="Etoile Gorget +2",
		waist="Reiki Yotai",
		left_ear="Suppanomimi",
		right_ear="Eabani Earring",
		left_ring="Epona's Ring",
		right_ring="Gere Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    } -- 28%
 
   -- 15% Magic Haste (32% DW to cap)
   sets.engaged.DW.LowHaste = set_combine(sets.engaged.DW, {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	}) -- 28%
 
   -- 30% Magic Haste (21% DW to cap)
   sets.engaged.DW.MidHaste = set_combine(sets.engaged.DW, {
		head="Maxixi Tiara +3",
    }) -- 21%
 
   -- 35% Magic Haste (16% DW to cap)
   sets.engaged.DW.HighHaste = set_combine(sets.engaged.DW, {
		head="Maxixi Tiara +3",
		right_ear="Sherida Earring",
    }) -- 16% Gear
 
   -- 45% Magic Haste (1% DW to cap)
   sets.engaged.DW.MaxHaste = set_combine(sets.engaged.DW, {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Horos Casaque +3",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
    }) -- 0%
   
    ------------------------------------------------------------------------------------------------
   --------------------------------------- Accuracy Sets ------------------------------------------
   ------------------------------------------------------------------------------------------------
-- Define three tiers of Accuracy.  These sets are cycled with the F9 Button to increase accuracy in stages as desired.
   sets.engaged.Acc1 = {head="Horos Tiara +3"}
   sets.engaged.Acc2 = {head="Horos Tiara +3",legs="Mummu Kecks +2",ammo="Yamarang"}
   sets.engaged.Acc3 = {head="Horos Tiara +3",legs="Mummu Kecks +2",ammo="Yamarang"}
-- Base Shield
    sets.engaged.LowAcc = set_combine(sets.engaged, sets.engaged.Acc1)
   sets.engaged.MidAcc = set_combine(sets.engaged, sets.engaged.Acc2)
   sets.engaged.HighAcc = set_combine(sets.engaged, sets.engaged.Acc3)
-- Base DW
   sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, sets.engaged.Acc1)
   sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW, sets.engaged.Acc2)
   sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW, sets.engaged.Acc3)
-- LowHaste DW
    sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Acc1)
   sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Acc2)
   sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Acc3)
-- MidHaste DW
   sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Acc1)
   sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Acc2)
    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Acc3)
-- HighHaste DW
    sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Acc1)
   sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Acc2)
   sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Acc3)
-- HighHaste DW
    sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.LowAcc)
   sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.MidAcc)
   sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.HighAcc)
 
   ------------------------------------------------------------------------------------------------
   ---------------------------------------- Hybrid Sets -------------------------------------------
   ------------------------------------------------------------------------------------------------
-- Define three tiers of Defense Taken.  These sets are cycled with the F10 Button. DT1-31%, DT2-44%, DT3-51%
   sets.engaged.DT1 = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
	}
   sets.engaged.DT2 = {
		--ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
	}
   sets.engaged.DT3 = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",	
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
   }
 
-- Shield Base
   sets.engaged.LOW = set_combine(sets.engaged, sets.engaged.DT1)
   sets.engaged.LowAcc.LOW = set_combine(sets.engaged.LowAcc, sets.engaged.DT1)
   sets.engaged.MidAcc.LOW = set_combine(sets.engaged.MidAcc, sets.engaged.DT1)
   sets.engaged.HighAcc.LOW = set_combine(sets.engaged.HighAcc, sets.engaged.DT1)
   
    sets.engaged.MID = set_combine(sets.engaged, sets.engaged.DT2)
   sets.engaged.LowAcc.MID = set_combine(sets.engaged.LowAcc, sets.engaged.DT2)
   sets.engaged.MidAcc.MID = set_combine(sets.engaged.MidAcc, sets.engaged.DT2)
   sets.engaged.HighAcc.MID = set_combine(sets.engaged.HighAcc, sets.engaged.DT2)
   
    sets.engaged.HIGH = set_combine(sets.engaged, sets.engaged.DT3)
   sets.engaged.LowAcc.HIGH = set_combine(sets.engaged.LowAcc, sets.engaged.DT3)
   sets.engaged.MidAcc.HIGH = set_combine(sets.engaged.MidAcc, sets.engaged.DT3)
    sets.engaged.HighAcc.HIGH = set_combine(sets.engaged.HighAcc, sets.engaged.DT3)
-- No Haste DW
   sets.engaged.DW.LOW = set_combine(sets.engaged.DW, sets.engaged.DT1)
   sets.engaged.DW.LowAcc.LOW = set_combine(sets.engaged.DW.LowAcc, sets.engaged.DT1)
   sets.engaged.DW.MidAcc.LOW = set_combine(sets.engaged.DW.MidAcc, sets.engaged.DT1)
   sets.engaged.DW.HighAcc.LOW = set_combine(sets.engaged.DW.HighAcc, sets.engaged.DT1)
   
   sets.engaged.DW.MID = set_combine(sets.engaged.DW, sets.engaged.DT2)
   sets.engaged.DW.LowAcc.MID = set_combine(sets.engaged.DW.LowAcc, sets.engaged.DT2)
   sets.engaged.DW.MidAcc.MID = set_combine(sets.engaged.DW.MidAcc, sets.engaged.DT2)
   sets.engaged.DW.HighAcc.MID = set_combine(sets.engaged.DW.HighAcc, sets.engaged.DT2)
 
   sets.engaged.DW.HIGH = set_combine(sets.engaged.DW, sets.engaged.DT3)
   sets.engaged.DW.LowAcc.HIGH = set_combine(sets.engaged.DW.LowAcc, sets.engaged.DT3)
   sets.engaged.DW.MidAcc.HIGH = set_combine(sets.engaged.DW.MidAcc, sets.engaged.DT3)
    sets.engaged.DW.HighAcc.HIGH = set_combine(sets.engaged.DW.HighAcc, sets.engaged.DT3)  
-- Low Haste DW
   sets.engaged.DW.LOW.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.DT1)
   sets.engaged.DW.LowAcc.LOW.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.DT1)
   sets.engaged.DW.MidAcc.LOW.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.DT1)
   sets.engaged.DW.HighAcc.LOW.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.DT1)
   
   sets.engaged.DW.MID.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.DT2)
   sets.engaged.DW.LowAcc.MID.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.DT2)
   sets.engaged.DW.MidAcc.MID.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.DT2)
   sets.engaged.DW.HighAcc.MID.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.DT2)
   
    sets.engaged.DW.HIGH.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.DT3)
   sets.engaged.DW.LowAcc.HIGH.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.DT3)
   sets.engaged.DW.MidAcc.HIGH.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.DT3)
   sets.engaged.DW.HighAcc.HIGH.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.DT3)
-- Mid Haste
   sets.engaged.DW.LOW.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.DT1)
   sets.engaged.DW.LowAcc.LOW.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.DT1)
   sets.engaged.DW.MidAcc.LOW.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.DT1)
   sets.engaged.DW.HighAcc.LOW.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.DT1)
   
   sets.engaged.DW.MID.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.DT2)
   sets.engaged.DW.LowAcc.MID.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.DT2)
   sets.engaged.DW.MidAcc.MID.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.DT2)
   sets.engaged.DW.HighAcc.MID.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.DT2)
 
   sets.engaged.DW.HIGH.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.DT3)
   sets.engaged.DW.LowAcc.HIGH.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.DT3)
   sets.engaged.DW.MidAcc.HIGH.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.DT3)
    sets.engaged.DW.HighAcc.HIGH.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.DT3)    
-- High Haste
   sets.engaged.DW.LOW.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.DT1)
   sets.engaged.DW.LowAcc.LOW.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.DT1)
   sets.engaged.DW.MidAcc.LOW.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.DT1)
   sets.engaged.DW.HighAcc.LOW.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.DT1)
   
    sets.engaged.DW.MID.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.DT2)
   sets.engaged.DW.LowAcc.MID.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.DT2)
   sets.engaged.DW.MidAcc.MID.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.DT2)
   sets.engaged.DW.HighAcc.MID.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.DT2)
   
    sets.engaged.DW.HIGH.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.DT3)
   sets.engaged.DW.LowAcc.HIGH.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.DT3)
   sets.engaged.DW.MidAcc.HIGH.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.DT3)
   sets.engaged.DW.HighAcc.HIGH.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.DT3)
-- Max Haste
   sets.engaged.DW.LOW.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.DT1)
   sets.engaged.DW.LowAcc.LOW.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.DT1)
   sets.engaged.DW.MidAcc.LOW.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.DT1)
   sets.engaged.DW.HighAcc.LOW.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.DT1)
   
    sets.engaged.DW.MID.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.DT2)
   sets.engaged.DW.LowAcc.MID.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.DT2)
   sets.engaged.DW.MidAcc.MID.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.DT2)
   sets.engaged.DW.HighAcc.MID.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.DT2)
   
   sets.engaged.DW.HIGH.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.DT3)
   sets.engaged.DW.LowAcc.HIGH.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.DT3)
   sets.engaged.DW.MidAcc.HIGH.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.DT3)
    sets.engaged.DW.HighAcc.HIGH.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.DT3)
 
   ------------------------------------------------------------------------------------------------
   ---------------------------------------- Special Sets ------------------------------------------
   ------------------------------------------------------------------------------------------------
 
  sets.buff['Saber Dance'] = {legs="Horos Tights +3"}
  sets.buff['Fan Dance'] = {body="Horos Bangles +3"}
   sets.buff['Climactic Flourish'] = {
		head="Maculele Tiara +1",
		body="Meg. Cuirie +2",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		}
   sets.buff['Closed Position'] = {feet="Horos T. Shoes +3"}
 
   sets.buff.Doom = {
       --neck="Nicander's Necklace", --20
       left_ring="Purity Ring", --10
       right_ring="Eshmun's Ring", --20
       waist="Gishdubar Sash", --10
       }
 
	sets.Kiting = {feet="Skd. Jambeaux +1"}
--   sets.CP = {back="Mecisto. Mantle"}
--  sets.Reive = {neck="Ygnas's Resolve +1"}
 
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

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)

	--Check for debuffs that prevent abilities or weaponskills and stop gear swaps if you can't do the action.
    if buffactive['sleep'] or buffactive['lullaby'] or buffactive['stun'] or buffactive['terror'] or buffactive['petrification'] then
        add_to_chat(167, 'Stopped due to status.')
        eventArgs.cancel = true
        send_command('gs c update')
        return
    end
    if (spell.action_type == 'Ability' or spell.type == 'WeaponSkill') and buffactive['amnesia'] then
        add_to_chat(167, 'Stopped due to status.')
        eventArgs.cancel = true
        send_command('gs c update')
        return
	end


    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
   
-- Used to overwrite Moonshade Earring if TP is more than 2750.
    if spell.type == 'WeaponSkill' then
        if player.tp > 2750 then
        equip({right_ear = "Sherida Earring"})
        end
    end
   
-- Used to optimize Rudra's Storm when Climactic Flourish is active.
   if spell.type == 'WeaponSkill' then
       if spell.english == "Rudra's Storm" and buffactive['Climactic Flourish'] then
            equip({head="Maculele Tiara +1", left_ear="Ishvara Earring"})
       end
   end
   
-- Forces Maculele Tiara +1 to override your WS Head slot if Climactic Flourish is active.  Corresponds with sets.buff['Climactic Flourish'].
   if spell.type == "WeaponSkill" then
       if state.Buff['Climactic Flourish'] then
           equip(sets.buff['Climactic Flourish'])
       end
   end
end
 
function job_post_precast(spell, action, spellMap, eventArgs)
   if spell.type == "WeaponSkill" then
       if state.Buff['Sneak Attack'] == true then
           equip(sets.precast.WS.Critical)
       end
       if state.Buff['Climactic Flourish'] then
           equip(sets.buff['Climactic Flourish'])
       end
   end
   if spell.type=='Waltz' and spell.target.type == 'SELF' then
       equip(sets.precast.WaltzSelf)
   end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
   -- Weaponskills wipe SATA.  Turn those state vars off before default gearing is attempted.
   if spell.type == 'WeaponSkill' and not spell.interrupted then
       state.Buff['Sneak Attack'] = false
   end
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
function job_buff_change(buff,gain)
   if buffactive['Saber Dance'] or buffactive['Climactic Flourish'] or buffactive['Fan Dance'] then
       handle_equipping_gear(player.status)
   end
   
   if buffactive['sleep'] or buffactive['lullaby'] or buffactive['stun'] or buffactive['terror'] or buffactive['petrification'] then
		if gain then
			equip(sets.idle.DT)
			add_to_chat(123, '**!! [ASLEEP / STUNED / TERRORIZED / PETRIFIED] !!**')
		else
			handle_equipping_gear(player.status)
		end
	end
	
	if buffactive['curse'] then
		if gain then
			equip(sets.idle.DT)
			add_to_chat(123, '~~~**!! [CURSED/ZOMBIE] !!**~~~')
			windower.play_sound(windower.addon_path..'data/sounds/cursed.wav')
			disable('ammo','head','body','hands','legs','feet','ear1','ear2','ring1','ring2','waist','neck','back')
		else
			send_command('gs enable all')
			handle_equipping_gear(player.status)
		end
	end
 
	if buffactive['doom'] then
		if gain then
           equip(sets.buff.Doom)
           send_command('@input /p Doomed.')
		   windower.play_sound(windower.addon_path..'data/sounds/doomed.wav')
           disable('ring1','ring2','waist','neck')
		else
           enable('ring1','ring2','waist','neck')
           handle_equipping_gear(player.status)
		end
	end
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
function job_handle_equipping_gear(playerStatus, eventArgs)
   update_combat_form()
   determine_haste_group()
end
 
function job_update(cmdParams, eventArgs)
   handle_equipping_gear(player.status)
end
 
function update_combat_form()
   if DW == true then
       state.CombatForm:set('DW')
   elseif DW == false then
       state.CombatForm:reset()
   end
end
 
function get_custom_wsmode(spell, spellMap, defaut_wsmode)
   local wsmode
 
   if state.Buff['Sneak Attack'] then
       wsmode = 'SA'
   end
 
   return wsmode
end
 
function customize_idle_set(idleSet)
   if state.CP.current == 'on' then
       equip(sets.CP)
       disable('back')
   else
       enable('back')
   end
 
   return idleSet
end
 
function customize_melee_set(meleeSet)
   if state.Buff['Climactic Flourish'] then
        meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
   end
   if state.ClosedPosition.value == true then
       meleeSet = set_combine(meleeSet, sets.buff['Closed Position'])
   end
 
   return meleeSet
end
 
-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
   if spell.type == 'Step' then
       if state.IgnoreTargetting.value == true then
           state.IgnoreTargetting:reset()
           eventArgs.handled = true
       end
 
       eventArgs.SelectNPCTargets = state.SelectStepTarget.value
   end
end
 
 
-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
   local msg = '[ Melee'
 
   if state.CombatForm.has_value then
       msg = msg .. ' (' .. state.CombatForm.value .. ')'
   end
 
   msg = msg .. ': '
 
   msg = msg .. state.OffenseMode.value
   if state.HybridMode.value ~= 'Normal' then
       msg = msg .. '/' .. state.HybridMode.value
   end
   msg = msg .. ' ][ WS: ' .. state.WeaponskillMode.value .. ' ]'
 
   if state.DefenseMode.value ~= 'None' then
       msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
   end
 
   if state.ClosedPosition.value then
       msg = msg .. '[ Closed Position: ON ]'
   end
 
   if state.Kiting.value then
       msg = msg .. '[ Kiting Mode: ON ]'
   end
 
   msg = msg .. '[ '..state.MainStep.current
 
   if state.UseAltStep.value == true then
       msg = msg .. '/'..state.AltStep.current
   end
 
   msg = msg .. ' ]'
 
   add_to_chat(060, msg)
 
   eventArgs.handled = true
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
function determine_haste_group()
   classes.CustomMeleeGroups:clear()
   if DW == true then
       if DW_needed <= 1 then
           classes.CustomMeleeGroups:append('MaxHaste')
       elseif DW_needed > 1 and DW_needed <= 9 then
           classes.CustomMeleeGroups:append('HighHaste')
       elseif DW_needed > 9 and DW_needed <= 21 then
           classes.CustomMeleeGroups:append('MidHaste')
       elseif DW_needed > 21 and DW_needed <= 39 then
           classes.CustomMeleeGroups:append('LowHaste')
       elseif DW_needed > 39 then
           classes.CustomMeleeGroups:append('')
       end
   end
end
 
function job_self_command(cmdParams, eventArgs)
   if cmdParams[1] == 'step' then
       if cmdParams[2] == 't' then
           state.IgnoreTargetting:set()
       end
 
       local doStep = ''
       if state.UseAltStep.value == true then
           doStep = state[state.CurrentStep.current..'Step'].current
           state.CurrentStep:cycle()
       else
           doStep = state.MainStep.current
       end
 
       send_command('@input /ja "'..doStep..'" <t>')
   end
   gearinfo(cmdParams, eventArgs)
end
 
function gearinfo(cmdParams, eventArgs)
   if cmdParams[1] == 'gearinfo' then
       if type(tonumber(cmdParams[2])) == 'number' then
           if tonumber(cmdParams[2]) ~= DW_needed then
           DW_needed = tonumber(cmdParams[2])
           DW = true
           end
       elseif type(cmdParams[2]) == 'string' then
           if cmdParams[2] == 'false' then
                DW_needed = 0
               DW = false
            end
       end
       if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
           end
       end
       if type(cmdParams[4]) == 'string' then
           if cmdParams[4] == 'true' then
               moving = true
           elseif cmdParams[4] == 'false' then
               moving = false
           end
       end
       if not midaction() then
           job_update()
       end
   end
end
 
-- If you attempt to use a step, this will automatically use Presto if you are under 5 Finishing moves and resend step.
function job_pretarget(spell, action, spellMap, eventArgs)
   if spell.type == 'Step' then
       local allRecasts = windower.ffxi.get_ability_recasts()
       local prestoCooldown = allRecasts[236]
       local under5FMs = not buffactive['Finishing Move 5'] and not buffactive['Finishing Move (6+)']
       
       if player.main_job_level >= 77 and prestoCooldown < 1 and under5FMs then
           cast_delay(1.1)
           send_command('input /ja "Presto" <me>')
       end
   end
   
-- If you attempt to use Climactic Flourish with zero finishing moves, this will automatically use Box Step and then resend Climactic Flourish.
        -- local under1FMs = not buffactive['Finishing Move 1'] and not buffactive['Finishing Move 2'] and not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5'] and not buffactive['Finishing Move (6+)']
 
   -- if spell.english == "Climactic Flourish" and under1FMs then
           -- cast_delay(1.9)
           -- send_command('input /ja "Box Step" <t>')
    -- end
end
 
-- My Waltz Rules to Overwrite Mote's
-- My Current Waltz Amounts: I:372 II:697 III:1134
function refine_waltz(spell, action, spellMap, eventArgs)
   if missingHP ~= nil then
       if player.main_job == 'DNC' then
           if missingHP < 40 and spell.target.name == player.name then
               -- Not worth curing yourself for so little.
               -- Don't block when curing others to allow for waking them up.
               add_to_chat(122,'Full HP!')
               eventArgs.cancel = true
               return
           elseif missingHP < 475 then
               newWaltz = 'Curing Waltz'
               waltzID = 190
           elseif missingHP < 850 then
               newWaltz = 'Curing Waltz II'
               waltzID = 191
           else
               newWaltz = 'Curing Waltz III'
               waltzID = 192
           end
       else
           -- Not dnc main or sub; ignore
           return
       end
   end
end
 
-- Automatically loads a Macro Set by: (Pallet,Book)
function select_default_macro_book()
   if player.sub_job == 'SAM' then
       set_macro_page(1, 14)
   elseif player.sub_job == 'WAR' then
       set_macro_page(2, 14)
   elseif player.sub_job == 'RUN' then
       set_macro_page(3, 14)    
   elseif player.sub_job == 'BLU' then
       set_macro_page(4, 14)
   elseif player.sub_job == 'THF' then
       set_macro_page(9, 14)
   elseif player.sub_job == 'NIN' then
       set_macro_page(10, 14)
   else
       set_macro_page(1, 14)
   end
end
 
function set_lockstyle()
   send_command('wait 6; input /lockstyleset ' .. lockstyleset)
end