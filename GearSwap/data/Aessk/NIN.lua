-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
-- Haste II has the same buff ID [33], so we have to use a toggle. 
-- gs c toggle hastemode -- Toggles whether or not you're getting Haste II
-- for Rune Fencer sub, you need to create two macros. One cycles runes, and gives you descrptive text in the log.
-- The other macro will use the actual rune you cycled to. 
-- Macro #1 //console gs c cycle Runes
-- Macro #2 //console gs c toggle UseRune
--
--	TreasureMode		ctrl =
--	UseWarp				ctrl [
--	CapacityMode		alt =
--	HasteMode			win f9
--	Cycle Runes			win [
--	UseRune				ctrl ]
--	Cycle WeaponSet		win r
--	DonarMode			win q


function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
    include('organizer-lib')
end


-- Setup vars that are user-independent.
function job_setup()

    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Sange = buffactive.sange or false
    state.Buff.Innin = buffactive.innin or false

    include('Mote-TreasureHunter')
    state.TreasureMode:set('Tag')

    state.HasteMode = M{['description']='Haste Mode', 'Hi', 'Normal'}
    state.Runes = M{['description']='Runes', "Ignis", "Gelus", "Flabra", "Tellus", "Sulpor", "Unda", "Lux", "Tenebrae"}
    state.UseRune = M(false, 'Use Rune')
    state.UseWarp = M(false, 'Use Warp')
    state.Adoulin = M(false, 'Adoulin')
    state.Moving  = M(false, 'moving')
	state.MagicBurst = M(false, 'Magic Burst')
	
    run_sj = player.sub_job == 'RUN' or false

    select_ammo()
    LugraWSList = S{'Blade: Ku', 'Blade: Jin', 'Blade: Shun'}
    state.CapacityMode = M(false, 'Capacity Point Mantle')
    state.Proc = M(false, 'Proc')
    state.unProc = M(false, 'unProc')
	state.DonarMode = M(false, 'Donar Gun')

    gear.RegularAmmo = 'Seki Shuriken'
    gear.SangeAmmo = 'Date Shuriken'

    wsList = S{'Blade: Hi', 'Blade: Kamu', 'Blade: Ten'}
    nukeList = S{'Katon: San', 'Doton: San', 'Suiton: San', 'Raiton: San', 'Hyoton: San', 'Huton: San'}
	elemental_ws = S{'Aeolian Edge', 'Leaden Salute', 'Wildfire'}

    update_combat_form()

    state.warned = M(false)
    options.ammo_warning_limit = 25
    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Proc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
	state.WeaponSet = M{['description']='Weapon Set', 'TPKatana', 'White', 'Nukes', 'Daggers', 'Aeolian', }
	
    select_default_macro_book()

    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind ^[ gs c toggle UseWarp')
    send_command('bind ![ input /lockstyle off')
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind @f9 gs c cycle HasteMode')
    send_command('bind @[ gs c cycle Runes')
    send_command('bind ^] gs c toggle UseRune')
	send_command('bind @r gs c cycle WeaponSet')				--win r
	send_command('bind @q gs c toggle DonarMode')				--win q
	send_command('bind @b gs c toggle MagicBurst')				--win b
    -- send_command('bind !- gs equip sets.crafting')

end


function file_unload()
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind ^=')
    send_command('unbind !=')
    send_command('unbind @f9')
    send_command('unbind @[')
	send_command('unbind @r')
	send_command('unbind @q')
end


-- Define sets and vars used by this job file.
-- visualized at http://www.ffxiah.com/node/194 (not currently up to date 10/29/2015)
-- Happo
-- Hachiya
-- sets.engaged[state.CombatForm][state.CombatWeapon][state.OffenseMode][state.HybridMode][classes.CustomMeleeGroups (any number)

-- Ninjutsu tips
-- To stick Slow (Hojo) lower earth resist with Raiton: Ni
-- To stick poison (Dokumori) or Attack down (Aisha) lower resist with Katon: Ni
-- To stick paralyze (Jubaku) lower resistence with Huton: Ni

function init_gear_sets()
	
	organizer_items = {
		remedy="Remedy",
		Cho="Chonofuda",
		Cho_bag="Toolbag (Cho)",
		Ino="Inoshishinofuda",
		Ino_bag="Toolbag (Ino)",
		Shika="Shikanofuda",
		Shika_bag="Toolbag (Shika)",
		grape="Grape Daifuku +1",
		silver_voucher="Silver Voucher",
		sp_key="SP Gobbie"
	}

    --------------------------------------
    -- Job Abilties
    --------------------------------------
    sets.precast.JA['Mijin Gakure'] = { legs="Mochizuki Hakama +3" }
    sets.precast.JA['Futae'] = { hands="Hattori Tekko +1" }
    sets.precast.JA['Provoke'] = { 
		ammo=gear.SangeAmmo,
		body="Emet Harness +1",
		hands="Kurys Gloves",
		legs="Zoar Subligar +1",
		feet={ name="Mochi. Kyahan +3", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}},
		neck="Unmoving Collar +1",
		left_ear="Trux Earring",
		right_ear="Pluto's Pearl",
		left_ring="Begrudging Ring",
		right_ring="Eihwaz Ring",
		back="Reiki Cloak",
    }
    sets.precast.JA.Sange = { ammo=gear.SangeAmmo, body="Mochizuki Chainmail +3" }

    -- Waltz (chr and vit)
    sets.precast.Waltz = {
    }
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {
    }
    sets.MadrigalBonus = {
    }
    -- sets.midcast.Trust =  {
    --     head="Hattori Zukin +1",
    --     hands="Ryuo Tekko",
    --     feet="Hachiya Kyahan +1"
    -- }
    -- sets.midcast["Apururu (UC)"] = set_combine(sets.midcast.Trust, {
        -- body="Apururu Unity shirt",
    -- })
    sets.Warp = {ring1="Warp Ring" }

    --------------------------------------
    -- Utility Sets for rules below
    --------------------------------------
    sets.TreasureHunter = { body="Volte Jupon", hands="Volte Bracers", legs="Volte Hose",}
    sets.CapacityMantle = { back="Mecistopins Mantle" }
	sets.DonarMode 		= { ranged="Donar Gun", ammo=empty, }
    sets.WSDayBonus     = { head="Gavialis Helm" }
    -- sets.WSBack         = { back="Trepidity Mantle" }
    sets.OdrLugra    	= { ear1="Lugra Earring +1", ear2="Odr Earring" }
    sets.OdrIshvara 	= { ear1="Odr Earring", ear2="Ishvara Earring" }
    sets.OdrBrutal 		= { ear1="Odr Earring", ear2="Brutal Earring" }
    sets.OdrMoon     	= { ear1="Odr Earring", ear2="Moonshade Earring" }
	sets.LugraLugra		= { ear1="Lugra Earring +1", ear2="Lugra Earring" }

    sets.RegularAmmo    = { ammo=gear.RegularAmmo }
    sets.SangeAmmo      = { ammo=gear.SangeAmmo }

    -- sets.NightAccAmmo   = { ammo="Ginsen" }
    -- sets.DayAccAmmo     = { ammo="Seething Bomblet +1" }

    --------------------------------------
    -- Ranged
    --------------------------------------

    sets.precast.RA = {
        head={ name="Taeon Chapeau", augments={'Rng.Acc.+13 Rng.Atk.+13','"Snapshot"+5','"Snapshot"+5',}},	--10
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},					--10
		feet={ name="Adhe. Gamashes +1", augments={'HP+65','"Store TP"+7','"Snapshot"+10',}},				--10
		waist="Yemaya Belt",
    }
    sets.midcast.RA = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Ilabrat Ring",
		right_ring="Cacoethic Ring +1",
    }
	
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
        --body="Mochizuki Chainmail +3"
    })
    sets.midcast.RA.TH = set_combine(sets.midcast.RA, set.TreasureHunter)

    -- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Sapience Orb",																																		--2
		head={ name="Herculean Helm", augments={'MND+7','Pet: Haste+3','"Fast Cast"+8','Accuracy+5 Attack+5','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},					--15
		body={ name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4',}},																--10									--9
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},												--8
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+13','"Fast Cast"+6','MND+2',}},																	--6
		feet={ name="Herculean Boots", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Fast Cast"+6','STR+10',}},														--6
		neck="Baetyl Pendant",																																		--4
		waist="Flume Belt +1",						
		left_ear="Loquac. Earring",																																	--2
		right_ear="Enchntr. Earring +1",																															--2
		left_ring="Kishar Ring",																																	--4
		right_ring="Rahab Ring",																																	--2
		back={ name="Andartia's Mantle", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Spell interruption rate down-10%',}},		--10
    }																																								--Total: 71
	
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads", body="Mochi. Chainmail +3" })

    -- Midcast Sets
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

    -- skill ++ 
    sets.midcast.Ninjutsu = {
		ammo="Yamarang",
        --ammo="Pemphredo Tathlum",
        head="Hachiya Hatsuburi +3",
		--head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Mochi. Kyahan +3",
		neck="Incanter's Torque",
		waist="Skrymir Cord +1",
		left_ear="Digni. Earring",
		right_ear="Gwati Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
    }
    -- any ninjutsu cast on self
    sets.midcast.SelfNinjutsu = sets.midcast.Ninjutsu
	sets.midcast.Noskill = set_combine(sets.precast.FC, {
        hands="Mochizuki Tekko +3", 
    })
    sets.midcast.Utsusemi = set_combine(sets.precast.FC, {
        --hands="Mochizuki Tekko +3", 
        back={ name="Andartia's Mantle", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
        feet="Hattori Kyahan +1"
    })
    sets.midcast.Migawari = set_combine(sets.midcast.Ninjutsu, {
		head="Hachiya Hatsuburi +3",
        body="Hattori Ningi +1", 
        back={ name="Andartia's Mantle", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
    })
    -- Nuking Ninjutsu (skill & magic attack)
    sets.midcast.ElementalNinjutsu = {
		ammo="Ghastly Tathlum +1",
		head={ name="Mochi. Hatsuburi +3", augments={'Enhances "Yonin" and "Innin" effect',}},
		body="Gyve Doublet",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Gyve Trousers",
		feet={ name="Mochi. Kyahan +3", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}},
		neck="Baetyl Pendant",
		waist="Skrymir Cord +1",
		left_ear="Friomisi Earring",
		right_ear="Crematio Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Shiva Ring +1",
		back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
    }
    sets.Burst = set_combine(sets.midcast.ElementalNinjutsu, { 
		body="Samnuha Coat",
		--hands={ name="Herculean Gloves", augments={'INT+10', 'Mag. Acc.+25','"Mag.Atk.Bns."+25','Magic burst dmg.+8%',}},
		--legs={ name="Herculean Trousers", augments={'INT+10', 'Mag. Acc.+25','"Mag.Atk.Bns."+25','Magic burst dmg.+8%',}},
		--neck={ name="Warder's Charm +1", augments={'Path: A',}},
		--right_ear="Static Earring",
		--left_ring="Mujin Band",
		--right_ring="Locus Ring",
	})
	sets.BurstFutae = set_combine(sets.Burst, { 
		hands="Hattori Tekko +1", 
	})
	sets.Futae = set_combine(sets.midcast.ElementalNinjutsu, { 
		hands="Hattori Tekko +1", 
	})

    -- Effusions
    sets.precast.Effusion = {}
    sets.precast.Effusion.Lunge = sets.midcast.ElementalNinjutsu
    sets.precast.Effusion.Swipe = sets.midcast.ElementalNinjutsu

    sets.idle = {
		ammo="Staunch Tathlum +1",
		-- head="Malignance Chapeau",
		-- body="Malignance Tabard",
		-- hands="Malignance Gloves",
		-- legs="Malignance Tights",
		-- feet="Malignance Boots",
		head="Nyame Helm",   
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Eabani Earring",
		right_ear="Sanare Earring",
		left_ring="Defending Ring",
		right_ring="Warden's Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
    }

    --sets.idle.Regen = set_combine(sets.idle, {
    --    head="Rao Kabuto",
    --    body="Hizamaru Haramaki +2",
    --    ring2="Paguroidea Ring"
    --})

    sets.Adoulin = {
        body="Councilor's Garb",
    }
    sets.idle.Town = sets.idle
    sets.idle.Town = set_combine(sets.idle, {
    })
    --sets.idle.Town.Adoulin = set_combine(sets.idle.Town, {
    --    body="Councilor's Garb"
    --})
    
    sets.idle.Weak = sets.idle

    -- Defense sets
    sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Eabani Earring",
		right_ear="Sanare Earring",
		left_ring="Defending Ring",
		right_ring="Warden's Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
    }

    sets.defense.MDT = set_combine(sets.defense.PDT, {
    })

    sets.DayMovement = {feet="Danzo sune-ate"}
    sets.NightMovement = {feet="Hachiya Kyahan +1"}

    -- Normal melee group without buffs
    sets.engaged = {
        --ammo=gear.RegularAmmo,
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','CHR+3','Accuracy+15','Attack+13',}},
		--head="Ken. Jinpachi +1",
		--hands="Ken. Tekko +1",
		--legs="Ken. Hakama +1",
		--feet="Ken. Sune-Ate +1",
		neck="Ninja Nodowa +2",
		waist="Windbuffet Belt +1",
		left_ear="Brutal Earring",
		right_ear="Telos Earring",
		left_ring="Epona's Ring",
		right_ring="Gere Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
    }
    -- assumptions made about targe
    sets.engaged.Mid = set_combine(sets.engaged, {
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Ken. Tekko +1",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
    })

    sets.engaged.Acc = set_combine(sets.engaged.Mid, {
		--ammo=gear.SangeAmmo,
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Odr Earring",
		left_ring="Cacoethic Ring +1",
		right_ring="Chirich Ring +1",
    })

    -- set for fooling around without dual wield
    -- using this as weak / proc set now
    sets.NoDW = set_combine(sets.engaged, {
    })
    sets.TPKatana = {
		--main="Heishi Shorinken",
		--sub="Ternion Dagger +1",
        --ammo=gear.RegularAmmo,
    }
	sets.White = {
		--main="Heishi Shorinken",
		--sub="Gokotai",
		--ammo=gear.RegularAmmo,
	}
	sets.Nukes = {
		--main="Gokotai",
		--sub="Tauret",
	}
	sets.Aeolian = {
		--main="Tauret",
		--sub="Gokotai",
	}
    sets.Daggers = {
        --main="Gleti's Knife",
		--sub="Kujaku +1",
		--ammo=gear.RegularAmmo,
    }
    sets.Proc = {
    }
    sets.unProc = set_combine(sets.engaged, {
    })

    sets.engaged.Innin = set_combine(sets.engaged, {
    })
    sets.engaged.Innin.Mid = sets.engaged.Mid
    sets.engaged.Innin.Acc = sets.engaged.Acc

    -- Defenseive sets
    sets.NormalPDT = {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
		--left_ring="Defending Ring",
    }
    sets.AccPDT = {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
    }

    sets.engaged.PDT = set_combine(sets.engaged, sets.NormalPDT)
    sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.NormalPDT)
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.AccPDT)

    sets.engaged.Innin.PDT = set_combine(sets.engaged.Innin, sets.NormalPDT )
    sets.engaged.Innin.Mid.PDT = sets.engaged.Mid.PDT
    sets.engaged.Innin.Acc.PDT = sets.engaged.Acc.PDT

    sets.engaged.HastePDT = {
        body="Malignance Tabard",
        head="Malignance Chapeau",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        --ring1="Defending Ring",
    }

    -- Delay Cap from spell + songs alone
    sets.engaged.MaxHaste = set_combine(sets.engaged, {
    })
    sets.engaged.Mid.MaxHaste = set_combine(sets.engaged.MaxHaste, {
    })
    sets.engaged.Acc.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, {
    })
    sets.engaged.Innin.MaxHaste     = sets.engaged.MaxHaste
    sets.engaged.Innin.Mid.MaxHaste = sets.engaged.Mid.MaxHaste
    sets.engaged.Innin.Acc.MaxHaste = sets.engaged.Acc.MaxHaste

    -- Defensive sets
    sets.engaged.PDT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.HastePDT)
    sets.engaged.Mid.PDT.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, sets.engaged.HastePDT)
    sets.engaged.Acc.PDT.MaxHaste = set_combine(sets.engaged.Acc.MaxHaste, sets.AccPDT)

    sets.engaged.Innin.PDT.MaxHaste = sets.engaged.Innin.MaxHaste
    sets.engaged.Innin.Mid.PDT.MaxHaste = sets.engaged.Mid.PDT.MaxHaste
    sets.engaged.Innin.Acc.PDT.MaxHaste = sets.engaged.Acc.PDT.MaxHaste

    -- 35% Haste 
    sets.engaged.Haste_35 = set_combine(sets.engaged.MaxHaste, {
    })
    sets.engaged.Mid.Haste_35 = set_combine(sets.engaged.Mid.MaxHaste, {
    })
    sets.engaged.Acc.Haste_35 = set_combine(sets.engaged.Acc.MaxHaste, {
    })

    sets.engaged.Innin.Haste_35 = set_combine(sets.engaged.Haste_35, { })
    sets.engaged.Innin.Mid.Haste_35 = sets.engaged.Mid.Haste_35
    sets.engaged.Innin.Acc.Haste_35 = sets.engaged.Acc.Haste_35

    sets.engaged.PDT.Haste_35 = set_combine(sets.engaged.Haste_35, sets.engaged.HastePDT)
    sets.engaged.Mid.PDT.Haste_35 = set_combine(sets.engaged.Mid.Haste_35, sets.engaged.HastePDT)
    sets.engaged.Acc.PDT.Haste_35 = set_combine(sets.engaged.Acc.Haste_35, sets.engaged.AccPDT)

    sets.engaged.Innin.PDT.Haste_35 = set_combine(sets.engaged.Innin.Haste_35, sets.engaged.HastePDT)
    sets.engaged.Innin.Mid.PDT.Haste_35 = sets.engaged.Mid.PDT.Haste_35
    sets.engaged.Innin.Acc.PDT.Haste_35 = sets.engaged.Acc.PDT.Haste_35

    -- 30% Haste 1626 / 798  +260 acc
    sets.engaged.Haste_30 = set_combine(sets.engaged.Haste_35, {
    })
    sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Haste_30, {
    })
    sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, {
    })

    sets.engaged.Innin.Haste_30 = set_combine(sets.engaged.Haste_30, { })
    sets.engaged.Innin.Mid.Haste_30 = sets.engaged.Mid.Haste_30
    sets.engaged.Innin.Acc.Haste_30 = sets.engaged.Acc.Haste_30

    sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.Haste_30, sets.engaged.HastePDT)
    sets.engaged.Mid.PDT.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, sets.engaged.HastePDT)
    sets.engaged.Acc.PDT.Haste_30 = set_combine(sets.engaged.Acc.Haste_30, sets.engaged.AccPDT)

    sets.engaged.Innin.PDT.Haste_30 = set_combine(sets.engaged.Innin.Haste_30, sets.engaged.HastePDT)
    sets.engaged.Innin.Mid.PDT.Haste_30 = sets.engaged.Mid.PDT.Haste_30
    sets.engaged.Innin.Acc.PDT.Haste_30 = sets.engaged.Acc.PDT.Haste_30


    -- haste spell - 139 dex | 275 acc | 1150 total acc (with shigi R15)
    sets.engaged.Haste_15 = set_combine(sets.engaged.Haste_30, {
    })
    sets.engaged.Mid.Haste_15 = set_combine(sets.engaged.Haste_15, { -- 676
    })
    sets.engaged.Acc.Haste_15 = set_combine(sets.engaged.Acc.Haste_30, {
    })
    
    sets.engaged.Innin.Haste_15 = set_combine(sets.engaged.Haste_15, { })
    sets.engaged.Innin.Mid.Haste_15 = sets.engaged.Mid.Haste_15
    sets.engaged.Innin.Acc.Haste_15 = sets.engaged.Acc.Haste_15
    
    sets.engaged.PDT.Haste_15 = set_combine(sets.engaged.Haste_15, sets.engaged.HastePDT)
    sets.engaged.Mid.PDT.Haste_15 = set_combine(sets.engaged.Mid.Haste_15, sets.engaged.HastePDT)
    sets.engaged.Acc.PDT.Haste_15 = set_combine(sets.engaged.Acc.Haste_15, sets.engaged.AccPDT)
    
    sets.engaged.Innin.PDT.Haste_15 = set_combine(sets.engaged.Innin.Haste_15, sets.engaged.HastePDT)
    sets.engaged.Innin.Mid.PDT.Haste_15 = sets.engaged.Mid.PDT.Haste_15
    sets.engaged.Innin.Acc.PDT.Haste_15 = sets.engaged.Acc.PDT.Haste_15
    
    sets.buff.Migawari = {body="Hattori Ningi +1"}
    
    -- Weaponskills 
	
    sets.precast.WS = {
		ammo="Aurgelmir Orb +1",
		head="Nyame Helm",
		--head={ name="Herculean Helm", augments={'Accuracy+25 Attack+25','Weapon skill damage +3%','STR+10','Attack+14',}},
		body={ name="Herculean Vest", augments={'Weapon skill damage +3%','DEX+15','Attack+15',}},
		hands="Nyame Gauntlets",
		legs="Mochi. Hakama +3",
		feet="Nyame Sollerets",
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
    
    sets.precast.WS.Mid = set_combine(sets.precast.WS, { })
    
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
    })
    
    sets.Kamu = {
    }
    sets.precast.WS['Blade: Kamu'] = set_combine(sets.precast.WS, sets.Kamu)
    sets.precast.WS['Blade: Kamu'].Mid = set_combine(sets.precast.WS.Mid, sets.Kamu)
    sets.precast.WS['Blade: Kamu'].Acc = set_combine(sets.precast.WS.Acc, sets.Kamu, {})
    
    -- BLADE: JIN
    sets.Jin = {
    }
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, sets.Jin)
    sets.precast.WS['Blade: Jin'].Mid = set_combine(sets.precast.WS['Blade: Jin'], {
    })
    sets.precast.WS['Blade: Jin'].Acc = set_combine(sets.precast.WS['Blade: Jin'].Mid, {
    })
    
    -- BLADE: HI
    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {
    })
    
    sets.precast.WS['Blade: Hi'].Mid = set_combine(sets.precast.WS['Blade: Hi'], {
    })
    
    sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS['Blade: Hi'].Mid, {
    })
    
    -- BLADE: SHUN
    sets.Shun = {
	    ammo="C. Palug Stone",
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Ken. Tekko +1",
		legs="Jokushu Haidate",
		feet="Ken. Sune-Ate +1",
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Gere Ring",
		right_ring="Regal Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
    }
    
    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, sets.Shun)
    sets.precast.WS['Blade: Shun'].Mid = set_combine(sets.Shun, {
    })
    sets.precast.WS['Blade: Shun'].Acc = sets.precast.WS['Blade: Shun'].Mid
    
    -- BLADE: Rin
    sets.Rin = {
    }
    sets.precast.WS['Blade: Rin'] = set_combine(sets.precast.WS, sets.Rin)
    sets.precast.WS['Blade: Rin'].Mid = set_combine(sets.precast.WS.Mid, sets.Rin)
    sets.precast.WS['Blade: Rin'].Acc = set_combine(sets.precast.WS.Acc, sets.Rin, {waist="Fotia Belt"})
    
    -- BLADE: KU 
    sets.Ku = {
    }
    sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS, sets.Ku)
    sets.precast.WS['Blade: Ku'].Mid = sets.precast.WS['Blade: Ku']
    sets.precast.WS['Blade: Ku'].Acc = set_combine(sets.precast.WS['Blade: Ku'].Mid, {
    })
    
    sets.Ten = {
    }
    
    sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, sets.Ten)
    sets.precast.WS['Blade: Ten'].Mid = set_combine(sets.precast.WS['Blade: Ten'], {
    })
    sets.precast.WS['Blade: Ten'].Acc = set_combine(sets.precast.WS['Blade: Ten'].Mid, {
    })
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, { 
    })
    
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
		ammo="Seeth. Bomblet +1",
		head="Mochi. Hatsuburi +3",
		hands="Nyame Gauntlets",
		body="Gyve Doublet",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ring="Dingir Ring",
		back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
    })
	
    sets.precast.WS['Blade: Chi'] = set_combine(sets.precast.WS['Aeolian Edge'], {
		neck="Ninja Nodowa +2",
		left_ear="Lugra Earring +1",
		right_ring="Gere Ring",
		back={ name="Andartia's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
    })
	
    sets.precast.WS['Blade: Teki'] = sets.precast.WS['Blade: Chi']
    sets.precast.WS['Blade: To'] = sets.precast.WS['Blade: Chi']
	sets.precast.WS['Blade: Ei'] = sets.precast.WS['Blade: Chi']
	sets.precast.WS['Blade: Yu'] = sets.precast.WS['Blade: Chi']

end



-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
    if (spell.type:endswith('Magic') or spell.type == "Ninjutsu") and buffactive.silence then
        --cancel_spell()
        send_command('input /item "Remedy" <me>')
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	equip(sets[state.WeaponSet.current])

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
	
    if spell.skill == "Ninjutsu" and spell.target.type:lower() == 'self' and spellMap ~= "Utsusemi" then
        if spell.english == "Migawari: Ichi" then
            classes.CustomClass = "Migawari"
        else
            classes.CustomClass = "SelfNinjutsu"
        end
    end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
        --If sneak is active when using, cancel before completion
        send_command('cancel 71')
    end
    if string.find(spell.english, 'Utsusemi') then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
            --cancel_spell()
            eventArgs.cancel = true
            return
        end
    end

end

function job_post_precast(spell, action, spellMap, eventArgs)
    -- Ranged Attacks 
    if spell.action_type == 'Ranged Attack' and state.OffenseMode ~= 'Acc' then
        equip( sets.SangeAmmo )
    end
    -- protection for lag
    if spell.name == 'Sange' and player.equipment.ammo == gear.RegularAmmo then
        state.Buff.Sange = false
        eventArgs.cancel = true
    end
    if spell.type == 'WeaponSkill' then
        -- if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
            -- equip(sets.TreasureHunter)
        -- end
        -- Mecistopins Mantle rule (if you kill with ws)
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
		if state.DonarMode.value then
			equip(sets.DonarMode)
		end
        -- Gavialis Helm rule
		if spell.element == world.day_element then
            if wsList:contains(spell.english) then
                -- do nothing
            else
                equip(sets.WSDayBonus)
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if nukeList:contains(spell.english) and state.MagicBurst.value and buffactive['Futae'] then
        equip(sets.BurstFutae)
	-- elseif nukeList:contains(spell.english) and buffactive['Futae'] then
        -- equip(sets.Futae)
	elseif nukeList:contains(spell.english) and state.MagicBurst.value then
        equip(sets.Burst)
    end
    -- if spell.english == "Monomi: Ichi" then
    --     if buffactive['Sneak'] then
    --         send_command('@wait 2.7;cancel sneak')
    --     end
    -- end
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spellMap == 'ElementalNinjutsu' then
		if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
            equip({waist="Hachirin-no-Obi"})
        -- Target distance under 1.7 yalms.
        elseif spell.target.distance < (1.7 + spell.target.model_size) then
            equip({waist="Orpheus's Sash"})
        -- Matching day and weather.
        elseif spell.element == world.day_element and spell.element == world.weather_element then
            equip({waist="Hachirin-no-Obi"})
        -- Target distance under 8 yalms.
        elseif spell.target.distance < (8 + spell.target.model_size) then
            equip({waist="Orpheus's Sash"})
        -- Match day or weather.
        elseif spell.element == world.day_element or spell.element == world.weather_element then
            equip({waist="Hachirin-no-Obi"})
        end
		if state.DonarMode.value then
			equip(sets.DonarMode)
		end
	end
    --if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
    --    equip(sets.TreasureHunter)
    --end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if midaction() then
        return
    end
    -- Aftermath timer creation
    aw_custom_aftermath_timers_aftercast(spell)
    --if spell.type == 'WeaponSkill' then
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    -- if state.CraftingMode then
    --     idleSet = set_combine(idleSet, sets.crafting)
    -- end
	    if state.DonarMode.current == 'on' then
        equip(sets.DonarMode)
        disable('ranged')
		disable('ammo')
    else
        enable('ranged')
		enable('ammo')
    end
    if state.HybridMode.value == 'PDT' then
        if state.Buff.Migawari then
            idleSet = set_combine(idleSet, sets.buff.Migawari)
        else 
            idleSet = set_combine(idleSet, sets.defense.PDT)
        end
    else
        idleSet = set_combine(idleSet, select_movement())
    end
    --local res = require('resources')
    --local info = windower.ffxi.get_info()
    --local zone = res.zones[info.zone].name
    --if zone:match('Adoulin') then
    --    idleSet = set_combine(idleSet, sets.Adoulin)
    --end
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
    if state.Buff.Migawari and state.HybridMode.value == 'PDT' then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if state.HybridMode.value == 'Proc' then
        meleeSet = set_combine(meleeSet, sets.NoDW)
    end
    meleeSet = set_combine(meleeSet, select_ammo())
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
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

    if S{'madrigal'}:contains(buff:lower()) then
        if buffactive.madrigal and state.OffenseMode.value == 'Acc' then
            equip(sets.MadrigalBonus)
        end
    end
    if (buff == 'Innin' and gain or buffactive['Innin']) then
        state.CombatForm:set('Innin')
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    else
        state.CombatForm:reset()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
	
	if buffactive['sleep'] or buffactive['lullaby'] or buffactive['stun'] or buffactive['terror'] or buffactive['petrification'] then
		if gain then
			equip(sets.defense.PDT)
			add_to_chat(123, '**!! [ASLEEP / STUNED / TERRORIZED / PETRIFIED] !!**')
		else
			handle_equipping_gear(player.status)
		end
	end

    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

end

function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        update_combat_form()
    end
end
--mov = {counter=0}
--if player and player.index and windower.ffxi.get_mob_by_index(player.index) then
--    mov.x = windower.ffxi.get_mob_by_index(player.index).x
--    mov.y = windower.ffxi.get_mob_by_index(player.index).y
--    mov.z = windower.ffxi.get_mob_by_index(player.index).z
--end
--moving = false
--windower.raw_register_event('prerender',function()
--    mov.counter = mov.counter + 1;
--    if mov.counter>15 then
--        local pl = windower.ffxi.get_mob_by_index(player.index)
--        if pl and pl.x and mov.x then
--            dist = math.sqrt( (pl.x-mov.x)^2 + (pl.y-mov.y)^2 + (pl.z-mov.z)^2 )
--            if dist > 1 and not moving then
--                state.Moving.value = true
--                send_command('gs c update')
--                moving = true
--            elseif dist < 1 and moving then
--                state.Moving.value = false
--                --send_command('gs c update')
--                moving = false
--            end
--        end
--        if pl and pl.x then
--            mov.x = pl.x
--            mov.y = pl.y
--            mov.z = pl.z
--        end
--        mov.counter = 0
--    end
--end)

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
   -- local res = require('resources')
   -- local info = windower.ffxi.get_info()
   -- local zone = res.zones[info.zone].name
   -- if state.Moving.value == true then
   --     if zone:match('Adoulin') then
   --         equip(sets.Adoulin)
   --     end
   --     equip(select_movement())
   -- end
    select_ammo()
    --determine_haste_group()
    update_combat_form()
    run_sj = player.sub_job == 'RUN' or false
    --select_movement()
    th_update(cmdParams, eventArgs)
	equip(sets[state.WeaponSet.current])
    handle_equipping_gear(player.status)
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
        then 
            return true
    end
end

function select_movement()
    -- world.time is given in minutes into each day
    -- 7:00 AM would be 420 minutes
    -- 17:00 PM would be 1020 minutes
    if world.time >= (17*60) or world.time <= (7*60) then
        return sets.NightMovement
    else
        return sets.DayMovement
    end
end

function determine_haste_group()

    classes.CustomMeleeGroups:clear()
    -- assuming +4 for marches (ghorn has +5)
    -- Haste (white magic) 15%
    -- Haste Samba (Sub) 5%
    -- Haste (Merited DNC) 10% (never account for this)
    -- Victory March +0/+3/+4/+5    9.4/14%/15.6%/17.1% +0
    -- Advancing March +0/+3/+4/+5  6.3/10.9%/12.5%/14%  +0
    -- Embrava 30% with 500 enhancing skill
    -- Mighty Guard - 15%
    -- buffactive[580] = geo haste
    -- buffactive[33] = regular haste
    -- buffactive[604] = mighty guard
    -- state.HasteMode = toggle for when you know Haste II is being cast on you
    -- Hi = Haste II is being cast. This is clunky to use when both haste II and haste I are being cast
    if state.HasteMode.value == 'Hi' then
        if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
             ( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
             ( buffactive.march == 2 and buffactive[604] ) ) then
            add_to_chat(8, '-------------Max-Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( (buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba'] ) then
            add_to_chat(8, '-------------Haste 35%-------------')
            classes.CustomMeleeGroups:append('Haste_35')
        elseif ( ( buffactive[580] or buffactive[33] or buffactive.march == 2 ) or
                 ( buffactive.march == 1 and buffactive[604] ) ) then
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif ( buffactive.march == 1 or buffactive[604] ) then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    else
        if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
           ( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
           ( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
           ( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches
            add_to_chat(8, '-------------Max Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( (buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or -- MG or haste + samba with 1 march
               ( buffactive.march == 2 and buffactive['haste samba'] ) or
               ( buffactive[580] and buffactive['haste samba'] ) then 
            add_to_chat(8, '-------------Haste 35%-------------')
            classes.CustomMeleeGroups:append('Haste_35')
        elseif ( buffactive.march == 2 ) or -- two marches from ghorn
               ( (buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
               ( buffactive[580] ) or  -- geo haste
               ( buffactive[33] and buffactive[604] ) then  -- haste with MG
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Capacity Point Mantle' then
        gear.Back = newValue
    elseif stateField == 'Proc' then
        --send_command('@input /console gs enable all')
        equip(sets.Proc)
        --send_command('@input /console gs disable all')
    elseif stateField == 'unProc' then
        send_command('@input /console gs enable all')
        equip(sets.unProc)
	elseif stateField == 'Donar Gun' then
		equip(sets.DonarMode)
    elseif stateField == 'Runes' then
        local msg = ''
        if newValue == 'Ignis' then
            msg = msg .. 'Increasing resistence against ICE and deals FIRE damage.'
        elseif newValue == 'Gelus' then
            msg = msg .. 'Increasing resistence against WIND and deals ICE damage.'
        elseif newValue == 'Flabra' then
            msg = msg .. 'Increasing resistence against EARTH and deals WIND damage.'
        elseif newValue == 'Tellus' then
            msg = msg .. 'Increasing resistence against LIGHTNING and deals EARTH damage.'
        elseif newValue == 'Sulpor' then
            msg = msg .. 'Increasing resistence against WATER and deals LIGHTNING damage.'
        elseif newValue == 'Unda' then
            msg = msg .. 'Increasing resistence against FIRE and deals WATER damage.'
        elseif newValue == 'Lux' then
            msg = msg .. 'Increasing resistence against DARK and deals LIGHT damage.'
        elseif newValue == 'Tenebrae' then
            msg = msg .. 'Increasing resistence against LIGHT and deals DARK damage.'
        end
        add_to_chat(123, msg)
   -- elseif stateField == 'moving' then
   --     if state.Moving.value then
   --         local res = require('resources')
   --         local info = windower.ffxi.get_info()
   --         local zone = res.zones[info.zone].name
   --         if zone:match('Adoulin') then
   --             equip(sets.Adoulin)
   --         end
   --         equip(select_movement())
   --     end
        
    elseif stateField == 'Use Rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    elseif stateField == 'Use Warp' then
        --add_to_chat(8, '------------WARPING-----------')
        --equip({ring1="Warp Ring"})
        --send_command('input //gs equip sets.Warp;@wait 10.0;input /item "Warp Ring" <me>;')
    end
end

--- Custom spell mapping.
--function job_get_spell_map(spell, default_spell_map)
--    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
--        return 'HighTierNuke'
--    end
--end
-- Creating a custom spellMap, since Mote capitalized absorbs incorrectly
function job_get_spell_map(spell, default_spell_map)
    if spell.type == 'Trust' then
        return 'Trust'
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    msg = msg .. 'Offense: '..state.OffenseMode.current
    msg = msg .. ', Hybrid: '..state.HybridMode.current
	msg = msg .. ' (' ..state.WeaponSet.current .. ') ]'
	
    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    if state.HasteMode.value ~= 'Normal' then
        msg = msg .. ', Haste: '..state.HasteMode.current
    end
    if state.RangedMode.value ~= 'Normal' then
        msg = msg .. ', Rng: '..state.RangedMode.current
    end
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end
    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(123, msg)
    eventArgs.handled = true
end

-- Call from job_precast() to setup aftermath information for custom timers.
function aw_custom_aftermath_timers_precast(spell)
    if spell.type == 'WeaponSkill' then
        info.aftermath = {}

        local empy_ws = "Blade: Hi"

        info.aftermath.weaponskill = empy_ws
        info.aftermath.duration = 0

        info.aftermath.level = math.floor(player.tp / 1000)
        if info.aftermath.level == 0 then
            info.aftermath.level = 1
        end

        if spell.english == empy_ws and player.equipment.main == 'Kannagi' then
            -- nothing can overwrite lvl 3
            if buffactive['Aftermath: Lv.3'] then
                return
            end
            -- only lvl 3 can overwrite lvl 2
            if info.aftermath.level ~= 3 and buffactive['Aftermath: Lv.2'] then
                return
            end

            -- duration is based on aftermath level
            info.aftermath.duration = 30 * info.aftermath.level
        end
    end
end

-- Call from job_aftercast() to create the custom aftermath timer.
function aw_custom_aftermath_timers_aftercast(spell)
    -- prevent gear being locked when it's currently impossible to cast 
    if not spell.interrupted and spell.type == 'WeaponSkill' and
        info.aftermath and info.aftermath.weaponskill == spell.english and info.aftermath.duration > 0 then

        local aftermath_name = 'Aftermath: Lv.'..tostring(info.aftermath.level)
        send_command('timers d "Aftermath: Lv.1"')
        send_command('timers d "Aftermath: Lv.2"')
        send_command('timers d "Aftermath: Lv.3"')
        send_command('timers c "'..aftermath_name..'" '..tostring(info.aftermath.duration)..' down abilities/aftermath'..tostring(info.aftermath.level)..'.png')

        info.aftermath = {}
    end
end

function select_ammo()
    if state.Buff.Sange then
        return sets.SangeAmmo
    else
        return sets.RegularAmmo
    end
end

-- function select_ws_ammo()
--     if world.time >= (18*60) or world.time <= (6*60) then
--         return sets.NightAccAmmo
--     else
--         return sets.DayAccAmmo
--     end
-- end

function update_combat_form()
    if state.Buff.Innin then
        state.CombatForm:set('Innin')
    else
        state.CombatForm:reset()
    end
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 9)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'RUN' then
        set_macro_page(3, 9)
    else
        set_macro_page(1, 9)
    end
end
