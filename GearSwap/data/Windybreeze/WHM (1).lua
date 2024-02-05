-- Original: Motenten / Heavily Modified: Aessk

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--
--
--				[ WIN+A ]           Cycle Afflatus Mode (Default SOLACE)
--				[ WIN+S ]           Cycle Arts Mode (Default LIGHT)
--              [ WIN+R ]           Cycle Regen Mode (Default DURATION)
--              [ WIN+D ]           Toggle Auto Abilities Mode (Default ON)
--              [ WIN+F ]           Toggle Auto Accession on Cursna Mode (Default ON)
--
--  Weapons:    [ WIN+W ]          	Toggles Weapon Lock
--
--
--	In Auto Abilities Mode (Toggle mode with WIN+D):
--		-When casting any spell:
--			-Afflatus will be used if not active (Set mode with WIN+A)
--			-Light/Dark Arts will be used if not active (Set mode with WIN+S)
--
--		-When casting any status removal spell:
--			-Divine Caress will be used if available
--
--		-When casting Cursna:
--			-Divine Seal will be used if available
--				-If Divine Seal is not available, Accession will be used if available (Toggle mode with WIN+F)

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
	state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
	state.Buff['Sublimation: Complete'] = buffactive['Sublimation: Complete'] or false

	BarStatus = S{'Baramnesra','Barsleepra','Barpoisonra','Barparalyzra','Barblindra','Barsilencera','Barpetra','Barvira'}
	BoostStat = S{'Boost-STR','Boost-DEX','Boost-VIT','Boost-AGI','Boost-INT','Boost-MND','Boost-CHR'}
	Dia_Spells = S{'Dia', 'Dia II', 'Dia III', 'Diaga', 'Diaga II'}
	Accession_Maps = S{'StatusRemoval', 'Regen', 'Cure', 'Protect', 'Shell', 'Storm'}
	Accession_Spells = S{'Aquaveil', 'Stoneskin', 'Blink', 'Invisible', 'Sneak', 'Deodorize'}
	
    lockstyleset = 20
	Accession_Check = false

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal', 'DT', 'MEva')

    state.RegenMode = M{['description']='Regen Mode', 'Duration', 'Potency'}
	state.CursnaMode = M{['description']='Cursna Mode', 'Yagrush', 'Gambanteinn'}
	state.AfflatusMode = M{['description']='Afflatus Mode', 'Solace', 'Misery', 'None'}
	state.ArtsMode = M{['description']='Arts Mode', 'Light', 'Dark', 'None'}
 
    state.WeaponLock = M(false, 'Weapon Lock')
    state.CP = M(false, "Capacity Points Mode")
	state.AccessionCursna = M(true, "Accession Cursna Mode") -- Set to false if you don't want default to be ON
	state.AccessionRegen = M(true, "Accession Regen Mode") -- Set to false if you don't want default to be ON
	state.AutoAbilities = M(true, "Auto Abilities Mode") -- Set to false if you don't want default to be ON
	state.AutoSub = M(false, "Auto Sublimation Mode") -- Set to false if you don't want default to be ON

    -- Additional local binds
	
	send_command('bind @a gs c cycle AfflatusMode')		--win A
	send_command('bind @s gs c cycle ArtsMode')			--win S
	send_command('bind @c gs c cycle CursnaMode')		--win C	
    send_command('bind @r gs c cycle RegenMode')		--win R
	send_command('bind @d gs c toggle AutoAbilities')	--win D
	send_command('bind @z gs c toggle AccessionRegen')	--win Z
	send_command('bind @f gs c toggle AccessionCursna')	--win F
	send_command('bind @x gs c toggle AutoSub')			--win X
    send_command('bind @w gs c toggle WeaponLock')		--win W
	
	
	--ctrl numpad 0-9
	send_command('bind ^numpad0 input /item "Remedy" <me>')
	send_command('bind ^numpad1 input /ma "Baramnesra" <me>')
	send_command('bind ^numpad2 input /ma "Barvira" <me>')
	send_command('bind ^numpad3 input /ma "Barparalyzra" <me>')
	send_command('bind ^numpad4 input /ma "Barsilencera" <me>')
	send_command('bind ^numpad5 input /ma "Barpetra" <me>')
	send_command('bind ^numpad6 input /ma "Barpoisonra" <me>')
	send_command('bind ^numpad7 input /ma "Barblindra" <me>')
	send_command('bind ^numpad8 input /ma "Barsleepra" <me>')
	send_command('bind ^numpad9 input /ma "haste" <t>')
	
	--alt numpad 0-9
	send_command('bind !numpad0 input /ma "Regen IV" <t>')
	send_command('bind !numpad1 input /ma "Barfira" <me>')
	send_command('bind !numpad2 input /ma "Barblizzara" <me>')
	send_command('bind !numpad3 input /ma "Baraera" <me>')
	send_command('bind !numpad4 input /ma "Barstonra" <me>')
	send_command('bind !numpad5 input /ma "Barthundra" <me>')
	send_command('bind !numpad6 input /ma "Barwatera" <me>')
	send_command('bind !numpad7 input /ma "Auspice" <me>')
	send_command('bind !numpad8 input /ma "Protectra V" <me>')			
	send_command('bind !numpad9 input /ma "Shellra V" <me>')
	
	--ctrl alt numpad 0-9
	send_command('bind !^numpad0 input /ja "Accession" <me>')
	send_command('bind !^numpad1 input /ma "Boost-STR" <me>')
	send_command('bind !^numpad2 input /ma "Boost-DEX" <me>')
	send_command('bind !^numpad3 input /ma "Boost-VIT" <me>')
	send_command('bind !^numpad4 input /ma "Boost-AGI" <me>')
	send_command('bind !^numpad5 input /ma "Boost-INT" <me>')
	send_command('bind !^numpad6 input /ma "Boost-MND" <me>')
	send_command('bind !^numpad7 input /ja "Light Arts" <me>')
	send_command('bind !^numpad8 input /ja "Afflatus Solace" <me>')
	send_command('bind !^numpad9 input /ja "Divine Caress"')

	state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    select_default_macro_book()
    set_lockstyle()
end

function user_unload()
	
	send_command('unbind @a')
    send_command('unbind @c')
    send_command('unbind @r')
    send_command('unbind @w')
	send_command('unbind @s')
	send_command('unbind @d')
	send_command('unbind @f')
	send_command('unbind @z')
	
	send_command('unbind ^numpad0')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad2')
    send_command('unbind ^numpad3')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
	send_command('unbind ^numpad6')
	send_command('unbind ^numpad7')
	send_command('unbind ^numpad8')
	send_command('unbind ^numpad9')
	
	send_command('unbind !numpad0')
    send_command('unbind !numpad1')
    send_command('unbind !numpad2')
    send_command('unbind !numpad3')
    send_command('unbind !numpad4')
    send_command('unbind !numpad5')
	send_command('unbind !numpad6')
	send_command('unbind !numpad7')
	send_command('unbind !numpad8')
	send_command('unbind !numpad9')
	
	send_command('unbind !^numpad0')
    send_command('unbind !^numpad1')
    send_command('unbind !^numpad2')
    send_command('unbind !^numpad3')
    send_command('unbind !^numpad4')
    send_command('unbind !^numpad5')
	send_command('unbind !^numpad6')
	send_command('unbind !^numpad7')
	send_command('unbind !^numpad8')
	send_command('unbind !^numpad9')

end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells

    sets.precast.FC = {
        main="C. Palug Hammer",	--7
        sub="Chanter's Shield",	--3
        ammo="Incantor Stone",	--2
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},	--10
        body="Inyanga Jubbah +2",	--14
        hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},	--7
        legs="Aya. Cosciales +2",	--6
        feet="Regal Pumps +1",	--7
        neck="Cleric's Torque +2",	--6
        left_ear="Malignance Earring",	--4
        right_ear="Loquac. Earring",	--2
		left_ring="Kishar Ring",	--4
		right_ring="Prolix Ring",	--2
        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},	--10
        waist="Embla Sash",	--5
        } --89 too much!

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash",
        })

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {
        legs="Ebers Pant. +1", --13
        })
	sets.precast.FC.Cursna = set_combine(sets.precast.FC['Healing Magic'], {
		main="Yagrush"
		})
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
		sub="Sors Shield", --5
		legs="Ebers pant. +1", --13
		feet="Hygieia Clogs", --17
		right_ear="Mendi. Earring", --5
		})
	
	sets.precast.FC.dispelga = set_combine(sets.precast.FC, {
		main="Daybreak"
		})
	
	sets.precast.FC.QuickCast = set_combine(sets.precast.FC, {
        ammo="Impatiens",	--2
		waist="Witful Belt",	--3
		right_ring="Lebeche Ring",	--2
		back="Perimede Cape",	--4
		}) --73/11
	
    sets.precast.FC.StatusRemoval = set_combine(sets.precast.FC.QuickCast, {
		main="Yagrush",
		legs="Ebers Pant. +1", --13
		})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})

    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Bliaut +3",}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
	    ammo="Amar Cluster",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Sanctity Necklace",
		waist="Grunfeld Rope",
		left_ear="Telos Earring",
		right_ear="Digni. Earring",
		left_ring="Apate Ring",
		right_ring="Petrov Ring",
		back="Relucent Cape",
       }

    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
        })

    sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS, {
        })

    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS, {
		})

    -- Midcast Sets

    sets.midcast.FC = {
        main="C. Palug Hammer", --5
        sub="Chanter's Shield", --3
        ammo="Incantor Stone", --2
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},	 --10
        body="Inyanga Jubbah +2", --14
        hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}}, --7
        legs="Aya. Cosciales +2", --6
        feet="Regal Pumps +1", --6
        neck="Cleric's Torque +2", --6
        left_ear="Malignance Earring", --4
        right_ear="Loquac. Earring", --2
		left_ring="Kishar Ring", --4
		right_ring="Prolix Ring", --2
        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}, --10
        waist="Embla Sash", --5
    } -- Haste

    sets.midcast.ConserveMP = {
        main="Sucellus",
        head="Vanya Hood",
        body="Vedic Coat",
        feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
        right_ear="Mendi. Earring",
        back="Solemnity Cape",
        waist="Austerity Belt +1",
        }
		
    -- Cure sets

    sets.midcast.CureSolace = {
		main="Raetic Rod +1",
		sub="Chanter's Shield",
		ammo="Incantor Stone",
		head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		body="Ebers Bliaut +1",
		hands="Theophany Mitts +3",
		legs="Ebers Pant. +1",
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		neck="Cleric's Torque +2",
		waist="Ninurta's Sash",
		left_ear="Glorious Earring",
		right_ear="Malignance Earring",
		left_ring="Janniston Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
        }

    sets.midcast.CureSolaceWeather = set_combine(sets.midcast.CureSolace, {
        back="Twilight Cape",
        waist="Hachirin-no-Obi",
        })

    sets.midcast.CureNormal = set_combine(sets.midcast.CureSolace, {
        body="Theo. Bliaut +3",
        })

    sets.midcast.CureWeather = set_combine(sets.midcast.CureNormal, {
        back="Twilight Cape",
        waist="Hachirin-no-Obi",
        })

    sets.midcast.CuragaNormal = set_combine(sets.midcast.CureNormal, {
        body="Theo. Bliaut +3",
		right_ear="Regal Earring",
        })

    sets.midcast.CuragaWeather = set_combine(sets.midcast.CureNormal, {
        body="Theo. Bliaut +3",
        back="Twilight Cape",
        waist="Hachirin-no-Obi",
        })

    sets.midcast.StatusRemoval = set_combine(sets.midcast.FC, {
        main="Yagrush",
        })

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
		main="Yagrush",
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		body="Ebers Bliaut +1",
		hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
		legs="Th. Pant. +3",
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck="Debilis Medallion",
		waist="Bishop's Sash",
		left_ear="Beatific Earring",
		right_ear="Meili Earring",
		left_ring="Menelaus's Ring",
		right_ring="Haoma's Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
        })

    sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Cleric's Torque +2"})

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {
		main={ name="Gada", augments={'Enh. Mag. eff. dur. +6','VIT+1','Mag. Acc.+1',}},
		sub="Ammurapi Shield",
		ammo="Incantor Stone",
		head="Befouled Crown",
		body={ name="Telchine Chas.", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Piety Pantaln. +3", augments={'Enhances "Afflatus Misery" effect',}},
		feet="Theo. Duckbills +3",
		neck="Incanter's Torque",
		waist="Embla Sash",
		right_ear="Mimir Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe"},
		right_ring={name="Stikini Ring +1", bag="wardrobe2"},
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
        }

    sets.midcast.EnhancingDuration = {
        main={ name="Gada", augments={'Enh. Mag. eff. dur. +6','VIT+1','Mag. Acc.+1',}},
        sub="Ammurapi Shield",
		head={ name="Telchine Cap", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},	--5fc
		body={ name="Telchine Chas.", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},	--5fc
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},	--5fc
		legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},	--5fc
		feet="Theo. Duckbills +3",
		waist="Embla Sash",
    }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        head="Inyanga Tiara +2",
        body="Piety Bliaut +3",
        hands="Ebers Mitts +1",
        legs="Th. Pant. +3",
        })

    sets.midcast.RegenDuration = set_combine(sets.midcast.EnhancingDuration, {
        hands="Ebers Mitts +1",
        legs="Th. Pant. +3",
        })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        feet="Inspirited Boots",
		waist="Gishdubar Sash",
        back="Grapevine Cape",
        })

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.EnhancingDuration, {
		legs="Shedir Seraweels",
        neck="Nodens Gorget",
        waist="Siegel Sash",
		left_ear="Earthcry Earring",
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.EnhancingDuration, {
        main="Vadose Rod",
		head={ name="Chironic Hat", augments={'Pet: DEX+7','Sklchn.dmg.+3%','"Refresh"+2','Mag. Acc.+3 "Mag.Atk.Bns."+3',}},
		hands="Regal Cuffs",
		legs="Shedir Seraweels",
        waist="Emphatikos Rope",
		left_ear="Andoaa Earring",
        })

    sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.EnhancingDuration, {
        feet="Ebers Duckbills +1",
		left_ear="Andoaa Earring",
        })

    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
		main="Beneficus",
		head="Ebers Cap +1",
		body="Ebers Bliaut +1",
		hands="Ebers Mitts +1",
		feet="Ebers Duckbills +1",
		left_ear="Andoaa Earring",	
        })
	sets.midcast.BarStatus = set_combine(sets.midcast['Enhancing Magic'], {left_ear="Andoaa Earring",})
	
    sets.midcast.BoostStat = set_combine(sets.midcast['Enhancing Magic'], {left_ear="Andoaa Earring",})

    sets.midcast.Protect = set_combine(sets.midcast.ConserveMP, sets.midcast.EnhancingDuration, {left_ear="Brachyura Earring",})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = set_combine(sets.midcast.ConserveMP, sets.midcast.EnhancingDuration, {left_ear="Brachyura Earring",})
    sets.midcast.ShellraV = set_combine(sets.midcast.Shellra, {})

    sets.midcast['Divine Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Theophany Cap +3",
		body="Theo. Bliaut +3",
		hands="Theophany Mitts +3",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Mag. Acc.+29','Phalanx +4',}},
		neck="Erra Pendant",
		waist="Luminary Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe"},
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}},
    }

    sets.midcast.Banish = set_combine(sets.midcast['Divine Magic'], {
		hands={ name="Piety Mitts +3", augments={'Enhances "Martyr" effect',}},
		left_ring="Fenian Ring",
		back="Disperser's Cape",
	})

    sets.midcast.Holy = set_combine(sets.midcast['Divine Magic'], {
	})

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Theophany Cap +3",
		body="Theo. Bliaut +3",
		hands="Kaykaus Cuffs +1",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Mag. Acc.+29','Phalanx +4',}},
		feet="Theo. Duckbills +3",
		neck="Erra Pendant",
		waist="Luminary Sash",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back="Aurist's Cape +1",
    }

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
    })
	
	sets.midcast.EnfeeblingDuration = {
		hands="Regal Cuffs",
		waist="Obstin. Sash",
		left_ring="Kishar Ring",
	}
	
	sets.midcast.Dia = set_combine(sets.midcast.MndEnfeebles, sets.midcast.EnfeeblingDuration)

	sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {
		main="Daybreak",
    })


    sets.midcast['Dark Magic'] = sets.midcast.dispelga

    sets.midcast.Impact = {
		main="Bunzi's Rod",
        sub="Ammurapi Shield",
        head=empty,
        body="Twilight Cloak",
        hands="Inyan. Dastanas +2",
        legs="Th. Pant. +3",
        feet="Theo. Duckbills +3",
        left_ring="Archon Ring",
        }

    sets.midcast.Trust = sets.precast.FC

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
		main="Daybreak",
		sub="Genmei Shield",
		ammo="Homiliary",
		head={ name="Chironic Hat", augments={'Pet: DEX+7','Sklchn.dmg.+3%','"Refresh"+2','Mag. Acc.+3 "Mag.Atk.Bns."+3',}},
		body="Shamash Robe",
		hands={ name="Chironic Gloves", augments={'Weapon skill damage +1%','Accuracy+5','"Refresh"+2','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		legs={ name="Chironic Hose", augments={'MND+9','Weapon skill damage +2%','"Refresh"+2','Accuracy+4 Attack+4','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		feet={ name="Chironic Slippers", augments={'AGI+8','Phys. dmg. taken -2%','"Refresh"+2',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear="Moonshade Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe"},
		right_ring={name="Stikini Ring +1", bag="wardrobe2"},
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','Enmity-10','Mag. Evasion+15',}},
        }

    sets.idle.DT = set_combine(sets.idle, {
		main="Malignance Pole",
		sub="Oneiros Grip",
		ammo="Staunch Tathlum +1",
		head={ name="Chironic Hat", augments={'Pet: DEX+7','Sklchn.dmg.+3%','"Refresh"+2','Mag. Acc.+3 "Mag.Atk.Bns."+3',}},
		body="Shamash Robe",
		hands={ name="Chironic Gloves", augments={'Weapon skill damage +1%','Accuracy+5','"Refresh"+2','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		legs={ name="Chironic Hose", augments={'MND+9','Weapon skill damage +2%','"Refresh"+2','Accuracy+4 Attack+4','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		feet={ name="Chironic Slippers", augments={'AGI+8','Phys. dmg. taken -2%','"Refresh"+2',}},
		neck="Loricate Torque +1",
		waist="Carrier's Sash",
		left_ear="Eabani Earring",
		right_ear={ name="Moonshade Earring", augments={'HP+25','Latent effect: "Refresh"+1',}},
		left_ring={name="Stikini Ring +1", bag="wardrobe"},
		right_ring="Defending Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','Enmity-10','Mag. Evasion+15',}},
        })

    sets.idle.MEva = set_combine(sets.idle.DT, {
        main="Daybreak",
        sub="Genmei Shield",
		ammo="Staunch Tathlum +1",
        head="Inyanga Tiara +2",
        body="Inyanga Jubbah +2",
        hands="Inyan. Dastanas +2",
        legs="Inyanga Shalwar +2",
        feet="Inyan. Crackows +2",
        neck="Warder's Charm +1",
        ear1="Eabani Earring",
        ear2="Sanare Earring",
        ring1="Inyanga Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','Enmity-10','Mag. Evasion+15',}},
        waist="Carrier's Sash",
        })

    sets.idle.Town = set_combine(sets.idle, {feet="Iaso Boots"})

    sets.idle.Weak = sets.idle

    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Iaso Boots"}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
	    ammo="Amar Cluster",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Sanctity Necklace",
		waist="Grunfeld Rope",
		left_ear="Telos Earring",
		right_ear="Digni. Earring",
		left_ring="Apate Ring",
		right_ring="Petrov Ring",
		back="Relucent Cape",
    }

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1", back="Mending Cape"}
    sets.buff['Devotion'] = {head="Piety Cap +1"}
	sets.buff.Sublimation = {waist="Embla Sash"}

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe2"}, --20
        waist="Gishdubar Sash", --10
        }

    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}


end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' and state.AutoAbilities.current == 'on' then
		automated_abilities(spell, spellMap, eventArgs)
	end

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
	
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
	
	if spell.english == "Accession" then
		Accession_Check = true
	end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
	if spell.name == 'Dispelga' then
		equip(sets.precast.FC.dispelga)
	end
	if spellMap == 'Raise' or spellMap == 'Reraise' then
		equip(sets.precast.FC.QuickCast)
	end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
	if spell.action_type == 'Magic' then
		if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
			equip(sets.buff['Divine Caress'])
		end
		if spell.name == 'Cursna' then
			if buffactive['Divine Seal'] or Accession_Check == true or state.CursnaMode.value == 'Gambanteinn' then
				equip({main = "Gambanteinn"})
			end
		end
		if spellMap == 'Banish' or spellMap == "Holy" then
			if (world.weather_element == 'Light' or world.day_element == 'Light') then
				equip(sets.Obi)
			end
		end
		if spell.name == 'Dispelga' then
			equip(sets.midcast.Dispelga)
		end
		if Dia_Spells:contains(spell.name) then
			equip(sets.midcast.Dia)
		end
		if spell.skill == 'Enhancing Magic' then
			if classes.NoSkillSpells:contains(spell.english) then
				equip(sets.midcast.EnhancingDuration)
				if spellMap == 'Refresh' then
					equip(sets.midcast.Refresh)
				end
			end
			if BoostStat:contains(spell.english) then
				equip(sets.midcast.BoostStat)
			end
			if BarStatus:contains(spell.english) then
				equip(sets.midcast.BarStatus)
			end
			if storms:contains(spell.english) then
				equip(sets.midcast.EnhancingDuration)
			end
			if spell.name == 'Shellra V' then
				equip(sets.midcast.ShellraV)
			end
			if spellMap == "Regen" and state.RegenMode.value == 'Duration' then
				equip(sets.midcast.RegenDuration)
			end
		end
	end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Repose" then
            send_command('@timers c "Repose ['..spell.target.name..']" 90 down spells/00098.png')
        end
		
		if Accession_Maps:contains(spellMap) or Accession_Spells:contains(spell.name) then
			Accession_Check = false
		end
    end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
	if state.AutoSub.current == 'on' then
		auto_sublimation()
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
	end
-- If we gain or lose any flurry buffs, adjust gear.
    if S{'refresh'}:contains(buff:lower()) then
        if not gain then
            refresh = nil
            --add_to_chat(122, "refresh status cleared.")
        end
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
	if buff == "Accession" then
		if not gain then
			Accession_Check = false
		end
	end
	if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            --send_command('@input /p Doomed.')
             disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end
	if buffactive['sleep'] or buffactive['lullaby'] or buffactive['stun'] or buffactive['terror'] or buffactive['petrification'] or buffactive['mute'] then
		if gain then
			equip(sets.idle.DT)
			add_to_chat(123, '**!! [ASLEEP / STUNED / TERRORIZED / PETRIFIED / MUTE] !!**')
			windower.play_sound(windower.addon_path..'data/sounds/whm_stopped.wav')
		else
			handle_equipping_gear(player.status)
		end
	end
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, spell, eventArgs)
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' then
            if buffactive['Afflatus Solace'] then
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureSolaceWeather"
                else
                    return "CureSolace"
                end
            else
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureWeather"
                else
                    return "CureNormal"
                end
            end
        elseif default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return "CuragaWeather"
            else
                return "CuragaNormal"
            end
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

function customize_idle_set(idleSet)
	if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.Sublimation)
        end
    end
	if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
	if world.area:contains('Adoulin') or world.area == "Celennia Memorial Library" then
		idleSet = set_combine(idleSet, {body="Councilor's Garb"})
	elseif world.area == "Mog Garden" then
		idleSet = set_combine(idleSet, {body="Jubilee Shirt"})
	end

    return idleSet
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local c_msg = state.CursnaMode.value

    local r_msg = state.RegenMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Cursna: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Regen: ' ..string.char(31,001)..r_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Automated abilities
function automated_abilities(spell, spellMap, eventArgs)
	local ability_recasts = windower.ffxi.get_ability_recasts()
	-- Auto Light/Dark Arts
	if player.sub_job == 'SCH'and not buffactive['SJ Restriction'] then
		if state.ArtsMode.current == 'Light' and not buffactive['Light Arts'] then
			if ability_recasts[228] == 0 then
				send_command('@input /ja "Light Arts" <me>; wait 1.5;  input /ma "'..spell.name..'" '..spell.target.name)
				eventArgs.cancel = true
				return
			end
		elseif state.ArtsMode.current == 'Dark' and not buffactive['Dark Arts'] then
			if ability_recasts[232] == 0 then
				send_command('@input /ja "Dark Arts" <me>; wait 1.5;  input /ma "'..spell.name..'" '..spell.target.name)
				eventArgs.cancel = true
				return
			end
		end
	end
	-- Auto Divine Seal / Divine Caress
	if spellMap == 'StatusRemoval' then	
		if spell.name == 'Cursna' then
			if ability_recasts[26] == 0 and ability_recasts[32] == 0 then -- Divine Seal then Divine Caress before Cursna
				send_command('@input /ja "Divine Seal" <me>; wait 1.5; input /ja "Divine Caress" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
				eventArgs.cancel = true
				return
			elseif ability_recasts[26] == 0 then -- Divine Seal before Cursna, if Divine Caress is on cooldown
				send_command('@input /ja "Divine Seal" <me>; wait 1.5;  input /ma "'..spell.name..'" '..spell.target.name)
				eventArgs.cancel = true
				return
			elseif state.AccessionCursna.current == 'on' and buffactive['Light Arts'] and not buffactive['Divine Seal'] then -- Accession before Cursna, if Divine Seal is on cooldown 
				local currentStrats = get_current_strategem_count()
				if not buffactive['Accession'] and currentStrats > 0 then -- Light Arts then Accession
					send_command('@input /ja "Accession" <me>; wait 1.5;  input /ma "'..spell.name..'" '..spell.target.name)
					eventArgs.cancel = true
					return
				end
			end
		end
		if ability_recasts[32] == 0 then -- Divine Caress before status removal spells
			send_command('@input /ja "Divine Caress" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
			eventArgs.cancel = true
			return
		end
	end
	-- Auto Afflatus
	if state.AfflatusMode.current == 'Solace' and not buffactive['Afflatus Solace'] then
		if ability_recasts[29] == 0 then
			send_command('@input /ja "Afflatus Solace" <me>; wait 1.5;  input /ma "'..spell.name..'" '..spell.target.name)
			eventArgs.cancel = true
			return
		end
	elseif state.AfflatusMode.current == 'Misery' and not buffactive['Afflatus Misery'] then
		if ability_recasts[30] == 0 then
			send_command('@input /ja "Afflatus Misery" <me>; wait 1.5;  input /ma "'..spell.name..'" '..spell.target.name)
			eventArgs.cancel = true
			return
		end
	end
	if spellMap == 'Regen' then
		if state.AccessionRegen.current == 'on' and buffactive['Light Arts'] then -- Accession before Cursna, if Divine Seal is on cooldown 
			local currentStrats = get_current_strategem_count()
			if buffactive['Light Arts'] and not buffactive['Accession'] and currentStrats > 0 then -- Light Arts then Accession
				send_command('@input /ja "Accession" <me>; wait 1.5;  input /ma "'..spell.name..'" '..spell.target.name)
				eventArgs.cancel = true
				return
			end
		end
	end
end

function auto_sublimation()
	local ability_recasts = windower.ffxi.get_ability_recasts()
	if not (buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete'] or refresh ~= 3) then
		if not (buffactive['Invisible'] or buffactive['Weakness']) then
			if abil_recasts[234] == 0 then
				send_command('@wait 2;input /ja "Sublimation" <me>')
			end
		end
	elseif buffactive['Sublimation: Complete'] then
		if (player.max_mp - player.mp) > 500 and abil_recasts[234] == 0 then
				send_command('@wait 2;input /ja "Sublimation" <me>')
		end
	end			
end

--Read incoming packet to differentiate between Refresh I and II
windower.register_event('action',
    function(act)
        --check if you are a target of spell
        local actionTargets = act.targets
        playerId = windower.ffxi.get_player().id
        isTarget = false
        for _, target in ipairs(actionTargets) do
            if playerId == target.id then
                isTarget = true
            end
        end
        if isTarget == true then
            if act.category == 4 then
                local param = act.param
                if param == 109 and (refresh ~= 3 or refresh ~= 2) then
                    --add_to_chat(122, 'refresh Status: refresh I')
                    refresh = 1
                elseif param == 473 and (refresh ~= 3 or refresh ~= 1) then
                    --add_to_chat(122, 'refresh Status: refresh II')
                    refresh = 2
				elseif param == 894 then
                    --add_to_chat(122, 'refresh Status: refresh II')
                    refresh = 3
                end
            end
        end
    end)

function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
	
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 5*32

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)
	
    return currentCharges
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 3)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end