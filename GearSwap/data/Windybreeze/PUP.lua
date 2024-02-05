----------------------------------------------------------------------------------------
--  __  __           _                     __   _____                        _
-- |  \/  |         | |                   / _| |  __ \                      | |
-- | \  / | __ _ ___| |_ ___ _ __    ___ | |_  | |__) |   _ _ __  _ __   ___| |_ ___
-- | |\/| |/ _` / __| __/ _ \ '__|  / _ \|  _| |  ___/ | | | '_ \| '_ \ / _ \ __/ __|
-- | |  | | (_| \__ \ ||  __/ |    | (_) | |   | |   | |_| | |_) | |_) |  __/ |_\__ \
-- |_|  |_|\__,_|___/\__\___|_|     \___/|_|   |_|    \__,_| .__/| .__/ \___|\__|___/
--                                                         | |   | |
--                                                         |_|   |_|
-----------------------------------------------------------------------------------------
--[[

    Originally Created By: Faloun
    Programmers: Arrchie, Kuroganashi, Byrne, Tuna
    Testers:Arrchie, Kuroganashi, Haxetc, Patb, Whirlin, Petsmart
    Contributors: Xilkk, Byrne, Blackhalo714

    ASCII Art Generator: http://www.network-science.de/ascii/
    
]]

-- Initialization function for this job file.
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include("Mote-Include.lua")
end

function user_setup()
    -- Alt-F10 - Toggles Kiting Mode.

    --[[
        F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
        
        These are for when you are fighting with or without Pet
        When you are IDLE and Pet is ENGAGED that is handled by the Idle Sets
    ]]
    state.OffenseMode:options("MasterPet", "Master", "Trusts")

    --[[
        Ctrl-F9 - Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).
        
        Used when you are Engaged with Pet
        Used when you are Idle and Pet is Engaged
    ]]
    state.HybridMode:options("Normal", "Acc", "TP", "DT", "Regen", "Ranged")

    --[[
        Alt-F12 - Turns off any emergency mode
        
        Ctrl-F10 - Cycle type of Physical Defense Mode in use.
        F10 - Activate emergency Physical Defense Mode. Replaces Magical Defense Mode, if that was active.
    ]]
    state.PhysicalDefenseMode:options("PetDT", "MasterDT")

    --[[
        Alt-F12 - Turns off any emergency mode

        F11 - Activate emergency Magical Defense Mode. Replaces Physical Defense Mode, if that was active.
    ]]
    state.MagicalDefenseMode:options("PetMDT")

    --[[ IDLE Mode Notes:

        F12 - Update currently equipped gear, and report current status.
        Ctrl-F12 - Cycle Idle Mode.
        
        Will automatically set IdleMode to Idle when Pet becomes Engaged and you are Idle
    ]]
    state.IdleMode:options("Idle", "MasterDT")

    --Various Cycles for the different types of PetModes
    state.PetStyleCycleTank = M {"NORMAL", "DD", "MAGIC", "SPAM"}
    state.PetStyleCycleMage = M {"NORMAL", "HEAL", "SUPPORT", "MB", "DD"}
    state.PetStyleCycleDD = M {"NORMAL", "BONE", "SPAM", "OD", "ODACC"}

    --The actual Pet Mode and Pet Style cycles
    --Default Mode is Tank
    state.PetModeCycle = M {"TANK", "DD", "MAGE"}
    --Default Pet Cycle is Tank
    state.PetStyleCycle = state.PetStyleCycleTank

    --Toggles
    --[[
        Alt + E will turn on or off Auto Maneuver
    ]]
    state.AutoMan = M(false, "Auto Maneuver")

    --[[
        //gs c toggle autodeploy
    ]]
    state.AutoDeploy = M(false, "Auto Deploy")

    --[[
        Alt + D will turn on or off Lock Pet DT
        (Note this will block all gearswapping when active)
    ]]
    state.LockPetDT = M(false, "Lock Pet DT")

    --[[
        Alt + (tilda) will turn on or off the Lock Weapon
    ]]
    state.LockWeapon = M(false, "Lock Weapon")

    --[[
        //gs c toggle setftp
    ]]
    state.SetFTP = M(false, "Set FTP")

   --[[
        This will hide the entire HUB
        //gs c hub all
    ]]
    state.textHideHUB = M(false, "Hide HUB")

    --[[
        This will hide the Mode on the HUB
        //gs c hub mode
    ]]
    state.textHideMode = M(false, "Hide Mode")

    --[[
        This will hide the State on the HUB
        //gs c hub state
    ]]
    state.textHideState = M(false, "Hide State")

    --[[
        This will hide the Options on the HUB
        //gs c hub options
    ]]
    state.textHideOptions = M(false, "Hide Options")

    --[[
        This will toggle the HUB lite mode
        //gs c hub lite
    ]]  
    state.useLightMode = M(false, "Toggles Lite mode")

    --[[
        This will toggle the default Keybinds set up for any changeable command on the window
        //gs c hub keybinds
    ]]
    state.Keybinds = M(false, "Hide Keybinds")

    --[[ 
        This will toggle the CP Mode 
        //gs c toggle CP 
    ]] 
    state.CP = M(false, "CP") 
    CP_CAPE = "Aptitude Mantle +1" 

    --[[
        Enter the slots you would lock based on a custom set up.
        Can be used in situation like Salvage where you don't want
        certain pieces to change.

        //gs c toggle customgearlock
        ]]
    state.CustomGearLock = M(false, "Custom Gear Lock")
    --Example customGearLock = T{"head", "waist"}
    customGearLock = T{}

    send_command("bind !f7 gs c cycle PetModeCycle")
    send_command("bind ^f7 gs c cycleback PetModeCycle")
    send_command("bind !f8 gs c cycle PetStyleCycle")
    send_command("bind ^f8 gs c cycleback PetStyleCycle")
    --send_command("bind !e gs gs c hide keybinds")
    send_command("bind !d gs c toggle LockPetDT")
    send_command("bind !f6 gs c predict")
    send_command("bind ^` gs c toggle LockWeapon")
    send_command("bind home gs c toggle setftp")
    send_command("bind PAGEUP gs c toggle autodeploy")
    send_command("bind PAGEDOWN gs c toggle AutoMan")
    send_command("bind end gs c toggle CP") 
    send_command("bind = gs c clear")
	send_command("bind !q gs equip sets.pet.OD_Sharpshot; gs disable all")  --SS Overdrive Lock
	send_command("bind ^q gs equip sets.pet.OD_Valoredge; gs disable all")	--VE Overdrive Lock
	send_command("bind !e gs enable all")

    select_default_macro_book()

    -- Adjust the X (horizontal) and Y (vertical) position here to adjust the window
    pos_x = 2140
    pos_y = 390
    setupTextWindow(pos_x, pos_y)
    
	set_lockstyle()
end

function file_unload()
    send_command("unbind !f7")
    send_command("unbind ^f7")
    send_command("unbind !f8")
    send_command("unbind ^f8")
    send_command("unbind !e")
    send_command("unbind !d")
    send_command("unbind !f6")
    send_command("unbind ^`")
    send_command("unbind home")
    send_command("unbind PAGEUP")
    send_command("unbind PAGEDOWN")       
    send_command("unbind end")
    send_command("unbind =")
	send_command("unbind !q")
	send_command("unbind ^q")
	send_command("unbind !e")
end

function job_setup()
    include("PUP-LIB.lua")
	lockstyleset = 96
end

function init_gear_sets()
    --Table of Contents
    ---Gear Variables
    ---Master Only Sets
    ---Hybrid Only Sets
    ---Pet Only Sets
    ---Misc Sets

    -------------------------------------------------------------------------
    --  _____                  __      __        _       _     _
    -- / ____|                 \ \    / /       (_)     | |   | |
    --| |  __  ___  __ _ _ __   \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___
    --| | |_ |/ _ \/ _` | '__|   \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
    --| |__| |  __/ (_| | |       \  / (_| | |  | | (_| | |_) | |  __/\__ \
    -- \_____|\___|\__,_|_|        \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
    -------------------------------------------------------------------------
    --[[
        This section is best ultilized for defining gear that is used among multiple sets
        You can simply use or ignore the below
    ]]
    Animators = {}
    Animators.Range = "Animator P II +1"
    Animators.Melee = "Animator P +1"
	Animators.Neo = "Neo Animator"

    --Adjust to your reforge level
    --Sets up a Key, Value Pair
    Artifact_Foire = {}
    Artifact_Foire.Head = "Foire Taj +1" --Pet Regen
    Artifact_Foire.Body = "Foire Tobe +1" --WSD + Pet HP
    Artifact_Foire.Hands = "Foire Dastanas +3" --Overload
    Artifact_Foire.Legs = "Foire Churidars +1" --Pet Cure
    Artifact_Foire.Feet = "Foire Babouches +3" --Repair + Pet Magic

    Relic_Pitre = {}
    Relic_Pitre.Head = "Pitre Taj +1" --Enhances Optimization + Pet Regen
    Relic_Pitre.Body = "Pitre Tobe +3" --Enhances Overdrive + Pet TP
    Relic_Pitre.Hands = "Pitre Dastanas +1" --Enhances Fine-Tuning + WSD
    Relic_Pitre.Legs = "Pitre Churidars +1" --Enhances Ventriloquy + Pet Magic
    Relic_Pitre.Feet = "Pitre Babouches +1" --Enhances Role Reversal + Pet Magic

    Empy_Karagoz = {}
    Empy_Karagoz.Head = "Karagoz Capello +1" --Pet TP Bonus
    Empy_Karagoz.Body = "Karagoz Farsetto +1" --Overload
    Empy_Karagoz.Hands = "Karagoz Guanti +1" --
    Empy_Karagoz.Legs = "Karagoz Pantaloni +1" --Pet Combat Skills
    Empy_Karagoz.Feet = "Karagoz Scarpe +1" --Tactical Switch

	Herc_PSTP = {}
	Herc_PSTP.Head = { 
		name="Herculean Helm",
		augments={
			'Pet: Accuracy+27 Pet: Rng. Acc.+27',
			'Pet: "Store TP"+10',
			'Pet: CHR+5',
		}
	}
	Herc_PSTP.Hands = {
		name="Herculean Gloves",
		augments={
			'Pet: Accuracy+26 Pet: Rng. Acc.+26',
			'Pet: "Store TP"+10',
			'Pet: AGI+6',
			'Pet: "Mag.Atk.Bns."+6',
		}
	}
	Herc_PSTP.Legs = {
		name="Herculean Trousers",
		augments={
			'Pet: Accuracy+27 Pet: Rng. Acc.+27',
			'Pet: "Store TP"+9',
			'Pet: DEX+5',
			'Pet: Attack+6 Pet: Rng.Atk.+6',
		}
	}
	Herc_PSTP.Feet = {
		name="Herculean Boots",
		augments={
			'Pet: Accuracy+29 Pet: Rng. Acc.+29',
			'Pet: "Store TP"+5',
			'Pet: DEX+4',
			'Pet: Attack+14 Pet: Rng.Atk.+14',
			'Pet: "Mag.Atk.Bns."+15',
		}
	}
	
	Herc_PMA = {}
	Herc_PMA.Head = {}
	Herc_PMA.Hands = {}
	
	Herc_Repair = {}
	Herc_Repair.Head = { 
		name="Herculean Helm",
		augments={
			'Pet: Attack+21 Pet: Rng.Atk.+21',
			'"Repair" potency +8%',
			'Pet: MND+4',
			'Pet: "Mag.Atk.Bns."+11',
		}
	}
	Herc_Repair.Body = {
		name="Herculean Vest",
		augments={
			'Pet: Mag. Acc.+15',
			'"Repair" potency +8%',
			'Pet: AGI+7',
			'Pet: Attack+10 Pet: Rng.Atk.+10',
		}
	}
	Herc_Repair.Hands = {
		name="Herculean Gloves",
		augments={
			'Pet: Attack+13 Pet: Rng.Atk.+13',
			'"Repair" potency +8%',
			'Pet: STR+3',
		}
	}
	
	Taeon = {}
	Taeon.Head	= {
		name="Taeon Chapeau",
		augments={
			'Pet: Accuracy+25 Pet: Rng. Acc.+25',
			'Pet: "Dbl. Atk."+5',
			'Pet: Damage taken -4%',
		}
	}
	Taeon.Body = {
		name="Taeon Tabard",
		augments={
			'Pet: Accuracy+24 Pet: Rng. Acc.+24',
			'Pet: "Dbl. Atk."+5',
			'Pet: Damage taken -4%',
		}
	}
	Taeon.Hands = {
		name="Taeon Gloves",
		augments={
			'Pet: Accuracy+25 Pet: Rng. Acc.+25',
			'Pet: "Dbl. Atk."+5',
			'Pet: Damage taken -4%',
		}
	}
	Taeon.Legs = {
		name="Taeon Tights",
		augments={
			'Pet: Accuracy+22 Pet: Rng. Acc.+22',
			'Pet: "Dbl. Atk."+5',
			'Pet: Damage taken -4%',
		}
	}
	Taeon.Feet = {
		name="Taeon Boots",
		augments={
			'Pet: Accuracy+24 Pet: Rng. Acc.+24',
			'Pet: "Dbl. Atk."+5',
			'Pet: Damage taken -4%',
		}
	}

    Visucius = {}
    Visucius.PetHaste = {
		name="Visucius's Mantle",
		augments={
			'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20',
			'Eva.+20 /Mag. Eva.+20',	--Master
			'Pet: Accuracy+10 Pet: Rng. Acc.+10',
			'Pet: Haste+10',
			'Pet: Damage taken -5%',
		}
    }
    Visucius.PetRegen = {
		name="Visucius's Mantle",
		augments={
			'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20',
			'Accuracy+20 Attack+20',	--Master
			'Pet: Accuracy+10 Pet: Rng. Acc.+10',
			'Pet: "Regen"+10',
			'System: 1 ID: 1247 Val: 4', --pet:MDT-10
		}
    }
	Visucius.MasterMelee = {
		name="Visucius's Mantle", 
		augments={
			'DEX+20',
			'Accuracy+20 Attack+20',
			'Accuracy+10',
			'"Dbl.Atk."+10',
			'Damage taken-5%',
		}
	}

    --------------------------------------------------------------------------------
    --  __  __           _               ____        _          _____      _
    -- |  \/  |         | |             / __ \      | |        / ____|    | |
    -- | \  / | __ _ ___| |_ ___ _ __  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- | |\/| |/ _` / __| __/ _ \ '__| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  | | (_| \__ \ ||  __/ |    | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|  |_|\__,_|___/\__\___|_|     \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                                  __/ |
    --                                                 |___/
    ---------------------------------------------------------------------------------
    --This section is best utilized for Master Sets
    --[[
        Will be activated when Pet is not active, otherwise refer to sets.idle.Pet
    ]]
    sets.idle = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Warder's Charm +1",
		waist="Moonbow Belt +1",
		left_ear="Sanare Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="C. Palug Ring",
		back=Visucius.PetRegen,
	}

    -------------------------------------Fastcast
    sets.precast.FC = {
		head={ name="Herculean Helm", augments={'MND+7','Pet: Haste+3','"Fast Cast"+8','Accuracy+5 Attack+5','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		body="Zendik Robe",
		hands={ name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+13','"Fast Cast"+6','MND+2',}},
		feet={ name="Herculean Boots", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Fast Cast"+6','STR+10',}},
		neck="Baetyl Pendant",
		waist="Moonbow Belt +1",
		left_ear="Enchntr. Earring +1",
		right_ear="Loquac. Earring",
		left_ring="Prolix Ring",
		right_ring="Rahab Ring",
		back=Visucius.PetRegen,
    }

    -------------------------------------Midcast
    sets.midcast = {} --Can be left empty

    sets.midcast.FastRecast = {
       -- Add your set here 
    }

    -------------------------------------Kiting
    sets.Kiting = {} --feet = "Hermes' Sandals +1"

    -------------------------------------JA
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck = "Magoraga Beads", body = "Passion Jacket"})

    -- Precast sets to enhance JAs
    sets.precast.JA = {} -- Can be left empty

    sets.precast.JA["Tactical Switch"] = {feet = Empy_Karagoz.Feet}

    sets.precast.JA["Ventriloquy"] = {legs = Relic_Pitre.Legs}

    sets.precast.JA["Role Reversal"] = {feet = Relic_Pitre.Feet}

    sets.precast.JA["Overdrive"] = {body = Relic_Pitre.Body}

    sets.precast.JA["Repair"] = {
		main = "Nibiru Sainti",
        ammo = "Automat. Oil +3",
	    --head=Herc_Repair.Head,
		--body=Herc_Repair.Body,
		--hands=Herc_Repair.Hands,
		head = { name="Rao Kabuto +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		body = { name="Rao Togi +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		hands = { name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		legs = { name="Desultor Tassets", augments={'"Phantom Roll" ability delay -5','"Repair" potency +10%',}},											--10																													--10
        feet = Artifact_Foire.Feet,
		left_ear = "Pratik Earring",																														--10
		right_ear = "Guignol Earring",																													--20
		right_ring = "Overbearing Ring",
		back = Visucius.PetRegen,
    }

    sets.precast.JA["Maintenance"] = set_combine(sets.precast.JA["Repair"], {})

    sets.precast.JA.Maneuver = {
		main = "Kenkonken",
        neck = "Buffoon's Collar +1",
        body = Empy_Karagoz.Body,
        hands = Artifact_Foire.Hands,
        right_ear = "Burana Earring",
		back = Visucius.PetRegen,
    }

    sets.precast.JA["Activate"] = {back = Visucius.PetRegen}

    sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]

    sets.precast.JA["Provoke"] = {}

    --Waltz set (chr and vit)
    sets.precast.Waltz = {
       -- Add your set here 
    }

    sets.precast.Waltz["Healing Waltz"] = {}

    -------------------------------------WS
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head = "Mpaca's Cap",
		body = "Mpaca's Doublet",
		hands = { name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
		legs = "Mpaca's Hose",
		feet = "Mpaca's Boots",
		neck = "Fotia Gorget",
		waist = "Fotia Belt",
		left_ear = "Brutal Earring",
		right_ear = { name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring = "Niqmaddu Ring",
		right_ring = "Gere Ring",
		back = Visucius.MasterMelee,

    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Stringing Pummel"] = set_combine(sets.precast.WS, {})

    sets.precast.WS["Stringing Pummel"].Mod = set_combine(sets.precast.WS, {})

    sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {})

    sets.precast.WS["Shijin Spiral"] = set_combine(sets.precast.WS, {})

    sets.precast.WS["Howling Fist"] = set_combine(sets.precast.WS, {})

    -------------------------------------Idle
    --[[
        Pet is not active
        Idle Mode = MasterDT
    ]]
    sets.idle.MasterDT = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Warder's Charm +1",
		waist="Moonbow Belt +1",
		left_ear="Sanare Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="C. Palug Ring",
		back = Visucius.MasterMelee,

    }

    -------------------------------------Engaged
    --[[
        Offense Mode = Master
        Hybrid Mode = Normal
    ]]
    sets.engaged.Master = {
		range=Animators.Neo,
		ammo="Automat. Oil +3",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back = Visucius.MasterMelee,
    }

    -------------------------------------Acc
    --[[
        Offense Mode = Master
        Hybrid Mode = Acc
    ]]
    sets.engaged.Master.Acc = set_combine(sets.engaged.Master, {})

    -------------------------------------TP
    --[[
        Offense Mode = Master
        Hybrid Mode = TP
    ]]
    sets.engaged.Master.TP = set_combine(sets.engaged.Master, {})

    -------------------------------------DT
    --[[
        Offense Mode = Master
        Hybrid Mode = DT
    ]]
    sets.engaged.Master.DT = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Warder's Charm +1",
		waist="Moonbow Belt +1",
		left_ear="Sanare Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="C. Palug Ring",
		back = Visucius.MasterMelee,
    }

    ----------------------------------------------------------------------------------
    --  __  __         _           ___     _     ___      _
    -- |  \/  |__ _ __| |_ ___ _ _| _ \___| |_  / __| ___| |_ ___
    -- | |\/| / _` (_-<  _/ -_) '_|  _/ -_)  _| \__ \/ -_)  _(_-<
    -- |_|  |_\__,_/__/\__\___|_| |_| \___|\__| |___/\___|\__/__/
    -----------------------------------------------------------------------------------

    --[[
        These sets are designed to be a hybrid of player and pet gear for when you are
        fighting along side your pet. Basically gear used here should benefit both the player
        and the pet.
    ]]
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Normal
    ]]
    sets.engaged.MasterPet = {
		main={ name="Xiucoatl", augments={'Path: C',}},
		range=Animators.Melee,
		ammo="Automat. Oil +3",
		head="Heyoka Cap +1",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Heyoka Subligar +1",
		feet="Mpaca's Boots",
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back=Visucius.PetHaste,
    }

    -------------------------------------Acc
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Acc
    ]]
    sets.engaged.MasterPet.Acc = set_combine(sets.engaged.MasterPet, {})

    -------------------------------------TP
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = TP
    ]]
    sets.engaged.MasterPet.TP = set_combine(sets.engaged.MasterPet, {})

    -------------------------------------DT
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = DT
    ]]
    sets.engaged.MasterPet.DT = {
       -- Add your set here 
    }

    -------------------------------------Regen
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Regen
    ]]
    sets.engaged.MasterPet.Regen = {
       -- Add your set here 
    }

    ----------------------------------------------------------------
    --  _____     _      ____        _          _____      _
    -- |  __ \   | |    / __ \      | |        / ____|    | |
    -- | |__) |__| |_  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- |  ___/ _ \ __| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  |  __/ |_  | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|   \___|\__|  \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                  __/ |
    --                                 |___/
    ----------------------------------------------------------------

    -------------------------------------Magic Midcast
    sets.midcast.Pet = {
       -- Add your set here 
    }

    sets.midcast.Pet.Cure = {
       -- Add your set here 
    }

    sets.midcast.Pet["Healing Magic"] = {
       -- Add your set here 
    }

    sets.midcast.Pet["Elemental Magic"] = {
       -- Add your set here 
    }

    sets.midcast.Pet["Enfeebling Magic"] = {
       -- Add your set here 
    }

    sets.midcast.Pet["Dark Magic"] = {
       -- Add your set here 
    }

    sets.midcast.Pet["Divine Magic"] = {
       -- Add your set here 
    }

    sets.midcast.Pet["Enhancing Magic"] = {
       -- Add your set here 
    }

    -------------------------------------Idle
    --[[
        This set will become default Idle Set when the Pet is Active 
        and sets.idle will be ignored
        Player = Idle and not fighting
        Pet = Idle and not fighting

        Idle Mode = Idle
    ]]
    sets.idle.Pet = {
		main="Denouements",
		range=Animators.Melee,
		ammo="Automat. Oil +3",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Warder's Charm +1",
		waist="Moonbow Belt +1",
		left_ear="Sanare Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="C. Palug Ring",
		back=Visucius.PetRegen,
    }

    --[[
        If pet is active and you are idle and pet is idle
        Player = idle and not fighting
        Pet = idle and not fighting

        Idle Mode = MasterDT
    ]]
    sets.idle.Pet.MasterDT = sets.engaged.Master.DT

    -------------------------------------Enmity
    sets.pet = {} -- Not Used

    --Equipped automatically
    sets.pet.Enmity = {
		head="Heyoka Cap +1",
		body="He. Harness +1",
		hands="He. Mittens +1",
		legs="Heyoka Subligar +1",
		feet="He. Leggings +1",
		left_ear="Domes. Earring",
		right_ear="Rimeice Earring",
    }

    --[[
        Activated by Alt+D or
        F10 if Physical Defense Mode = PetDT
    ]]
    sets.pet.EmergencyDT = {
		main="Condemners",
		range=Animators.Melee,
		ammo="Automat. Oil +3",
		head={ name="Anwig Salade", augments={'Attack+3','Pet: Damage taken -10%','Attack+3','Pet: "Regen"+1',}},
		body={ name="Rao Togi +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		hands={ name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		legs={ name="Rao Haidate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		feet={ name="Rao Sune-Ate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		neck="Shepherd's Chain",
		waist="Isa Belt",
		left_ear="Enmerkar Earring",
		right_ear="Rimeice Earring",
		left_ring="Thurandaut Ring",
		right_ring="Overbearing Ring",
		back=Visucius.PetRegen,
    }

	--[[
		Overdrive sets to lock in.
	]]--
	sets.pet.OD_Sharpshot = {
		main={ name="Xiucoatl", augments={'Path: C',}},
	    range=Animators.Melee,
		ammo="Automat. Oil +3",
		head=Empy_Karagoz.Head,
		body=Relic_Pitre.Body,
		hands="Mpaca's Gloves",
		legs="Heyoka Subligar +1",
		feet="Mpaca's Boots",
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Enmerkar Earring",
		right_ear="Rimeice Earring",
		left_ring="Thurandaut Ring",
		right_ring="C. Palug Ring",
		back={ name="Dispersal Mantle", augments={'STR+2','DEX+1','Pet: TP Bonus+500','"Martial Arts"+13',}},
	}
	sets.pet.OD_Valoredge = {
		main={ name="Xiucoatl", augments={'Path: C',}},
	    range=Animators.Melee,
		ammo="Automat. Oil +3",
		head=Taeon.Head,
		body=Taeon.Body,
		hands="Mpaca's Gloves",
		legs=Taeon.Legs,
		feet="Mpaca's Boots",
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Enmerkar Earring",
		right_ear="Rimeice Earring",
		left_ring="Thurandaut Ring",
		right_ring="C. Palug Ring",
		back=Visucius.PetHaste,
	}

    -------------------------------------Engaged for Pet Only
    --[[
      For Technical Users - This is layout of below
      sets.idle[idleScope][state.IdleMode][ Pet[Engaged] ][CustomIdleGroups] 

      For Non-Technical Users:
      If you the player is not fighting and your pet is fighting the first set that will activate is sets.idle.Pet.Engaged
      You can further adjust this by changing the HyrbidMode using Ctrl+F9 to activate the Acc/TP/DT/Regen/Ranged sets
    ]]
    --[[
        Idle Mode = Idle
        Hybrid Mode = Normal
    ]]
    sets.idle.Pet.Engaged = {
		main="Ohtas",
		range=Animators.Melee,
		ammo="Automat. Oil +3",
		head=Taeon.Head,
		body=Relic_Pitre.Body,
		hands=Taeon.Hands,
		legs=Taeon.Legs,
		feet="Mpaca's Boots",
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Enmerkar Earring",
		right_ear="Rimeice Earring",
		left_ring="Thurandaut Ring",
		right_ring="C. Palug Ring",
		back=Visucius.PetHaste,
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Acc
    ]]
    sets.idle.Pet.Engaged.Acc = set_combine(sets.idle.Pet.Engaged, {})

    --[[
        Idle Mode = Idle
        Hybrid Mode = TP
    ]]
    sets.idle.Pet.Engaged.TP = set_combine(sets.idle.Pet.Engaged, {})

    --[[
        Idle Mode = Idle
        Hybrid Mode = DT
    ]]
    sets.idle.Pet.Engaged.DT = {
		main={ name="Ohtas", augments={'Accuracy+70','Pet: Accuracy+70','Pet: Haste+10%',}},
		range=Animators.Melee,
		ammo="Automat. Oil +3",
		head={ name="Anwig Salade", augments={'Attack+3','Pet: Damage taken -10%','Attack+3','Pet: "Regen"+1',}},
		body=Taeon.Body,
		hands=Taeon.Hands,
		legs=Taeon.Legs,
		feet=Taeon.Feet,
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Enmerkar Earring",
		right_ear="Domes. Earring",
		left_ring="Thurandaut Ring",
		right_ring="C. Palug Ring",
		back=Visucius.PetHaste,
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Regen
    ]]
    sets.idle.Pet.Engaged.Regen = {
       -- Add your set here 
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Ranged
    ]]
    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {
		main={ name="Xiucoatl", augments={'Path: C',}},
		range=Animators.Melee,
		ammo="Automat. Oil +3",
		head=Herc_PSTP.Head,
		body=Relic_Pitre.Body,
		hands="Mpaca's Gloves",
		legs = Empy_Karagoz.Legs,
		feet="Mpaca's Boots",
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Enmerkar Earring",
		right_ear="Kyrene's Earring",
		left_ring="Thurandaut Ring",
		right_ring="Varar Ring +1",
		back=Visucius.PetHaste,
        }
    )

    -------------------------------------WS
    --[[
        WSNoFTP is the default weaponskill set used
    ]]
    sets.midcast.Pet.WSNoFTP = {
		main={ name="Xiucoatl", augments={'Path: C',}},
		range=Animators.Melee,
		ammo="Automat. Oil +3",
        head = Empy_Karagoz.Head_PTPBonus,
		body=Relic_Pitre.Body,
		hands="Mpaca's Gloves",
		legs="Kara. Pantaloni +1",
		feet="Mpaca's Boots",
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Enmerkar Earring",
		right_ear="Burana Earring",
		left_ring="Overbearing Ring",
		right_ring="Thurandaut Ring",
		back={ name="Dispersal Mantle", augments={'STR+2','DEX+1','Pet: TP Bonus+500','"Martial Arts"+13',}},
    }

    --[[
        If we have a pet weaponskill that can benefit from WSFTP
        then this set will be equipped
    ]]
    sets.midcast.Pet.WSFTP = {
		main={ name="Xiucoatl", augments={'Path: C',}},
		range=Animators.Melee,
		ammo="Automat. Oil +3",
		head=Taeon.Head,
		body=Relic_Pitre.Body,
		hands="Mpaca's Gloves",
		legs=Taeon.Legs,
		feet="Mpaca's Boots",
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Domes. Earring",
		right_ear="Burana Earring",
		left_ring="Varar Ring +1",
		right_ring="C. Palug Ring",
		back=Visucius.PetHaste,
    }

    --[[
        Base Weapon Skill Set
        Used by default if no modifier is found
    ]]
    sets.midcast.Pet.WS = {}

    --Chimera Ripper, String Clipper
    sets.midcast.Pet.WS["STR"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Bone crusher, String Shredder
    sets.midcast.Pet.WS["VIT"] = set_combine(sets.midcast.Pet.WSFTP, {})

    -- Cannibal Blade
    sets.midcast.Pet.WS["MND"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Armor Piercer, Armor Shatterer
    sets.midcast.Pet.WS["DEXFTP"] = set_combine(sets.midcast.Pet.WSFTP, {})

    -- Arcuballista, Daze
    sets.midcast.Pet.WS["DEX"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    ---------------------------------------------
    --  __  __ _             _____      _
    -- |  \/  (_)           / ____|    | |
    -- | \  / |_ ___  ___  | (___   ___| |_ ___
    -- | |\/| | / __|/ __|  \___ \ / _ \ __/ __|
    -- | |  | | \__ \ (__   ____) |  __/ |_\__ \
    -- |_|  |_|_|___/\___| |_____/ \___|\__|___/
    ---------------------------------------------
    -- Town Set
    sets.idle.Town = {
       -- Add your set here
    }

    -- Resting sets
    sets.resting = {
       -- Add your set here
    }

    sets.defense.MasterDT = sets.idle.MasterDT

    sets.defense.PetDT = sets.pet.EmergencyDT

    sets.defense.PetMDT = set_combine(sets.pet.EmergencyDT, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == "WAR" then
        set_macro_page(1, 19)
    elseif player.sub_job == "NIN" then
        set_macro_page(1, 19)
    elseif player.sub_job == "DNC" then
        set_macro_page(1, 19)
    else
        set_macro_page(1, 19)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end
