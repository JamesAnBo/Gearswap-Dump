-- Original: Motenten / //
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ CTRL+F9 ]        Cycle Hybrid Modes
--              [ WIN+F9 ]         Cycle Weapon Skill Modes
--              [ ALT+F10 ]        Toggle Kiting Mode
--              [ CTRL+F11 ]       Cycle Elemental Casting Modes
--              [ F12 ]            Update Current Gear / Report Current Status
--              [ CTRL+F12 ]       Cycle Idle Modes
--              [ ALT+F12 ]        Cancel Emergency -PDT/-MDT Mode
--              [ ALT+` ]          Toggle Magic Burst Mode
--              [ F9 ]             Toggle Enspell Mode
--
--  Abilities:  [ CTRL+- ]         Light Arts/Addendum: White
--              [ CTRL+= ]         Dark Arts/Addendum: Black
--              [ CTRL+; ]         Celerity/Alacrity
--              [ ALT+[ ]          Accesion/Manifestation
--              [ ALT+; ]          Penury/Parsimony
--
--Spells:DISABLED[CTRL+`]           Stun
--              [ ALT+Q ]           Temper
--              [ ALT+W ]           Flurry II
--              [ ALT+E ]           Haste II
--              [ ALT+R ]           Refresh II
--              [ ALT+Y ]           Phalanx
--              [ ALT+O ]           Regen II
--              [ ALT+P ]           Shock Spikes
--              [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ ALT+F11 ]        Toggle Auto Weapon Lock
--              [ F11 ]            Toggle Weapon Lock
--              [ F10 ]            Cycle Weapon Set
--
--  WS:DISABLED [ CTRL+Numpad7 ]    Savage Blade
--              [ CTRL+Numpad9 ]    Chant Du Cygne
--              [ CTRL+Numpad4 ]    Requiescat
--              [ CTRL+Numpad1 ]    Sanguine Blade
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--              Addendum Commands:
--              Shorthand versions for each strategem type that uses the version appropriate for
--              the current Arts.
--                                          Light Arts                  Dark Arts
--                                          ----------                  ---------
--              gs c scholar light          Light Arts/Addendum
--              gs c scholar dark                                       Dark Arts/Addendum
--              gs c scholar cost           Penury                      Parsimony
--              gs c scholar speed          Celerity                    Alacrity
--              gs c scholar aoe            Accession                   Manifestation
--              gs c scholar addendum       Addendum: White             Addendum: Black


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

    state.Buff.Composure = buffactive.Composure or false
    state.Buff.Saboteur = buffactive.Saboteur or false
    state.Buff.Stymie = buffactive.Stymie or false

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    enfeebling_magic_acc = S{'Bind', 'Break', 'Dispel', 'Distract', 'Distract II', 'Frazzle',
        'Frazzle II',  'Gravity', 'Gravity II', 'Silence'}
    enfeebling_magic_skill = S{'Distract III', 'Frazzle III', 'Poison II'}
    enfeebling_magic_effect = S{'Dia', 'Dia II', 'Dia III', 'Diaga', 'Blind', 'Blind II'}
    enfeebling_magic_sleep = S{'Sleep', 'Sleep II', 'Sleepga'}

    skill_spells = S{
        'Temper', 'Temper II', 'Enfire', 'Enfire II', 'Enblizzard', 'Enblizzard II', 'Enaero', 'Enaero II',
        'Enstone', 'Enstone II', 'Enthunder', 'Enthunder II', 'Enwater', 'Enwater II'}

    lockstyleset = 84
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')
    state.MoveSpeed  = M(true, "MoveSpeed")


    state.EnSpell = M{['description']='EnSpell', 'Enfire', 'Enblizzard', 'Enaero', 'Enstone', 'Enthunder', 'Enwater'}
    state.BarElement = M{['description']='BarElement', 'Barfire', 'Barblizzard', 'Baraero', 'Barstone', 'Barthunder', 'Barwater'}
    state.BarStatus = M{['description']='BarStatus', 'Baramnesia', 'Barvirus', 'Barparalyze', 'Barsilence', 'Barpetrify', 'Barpoison', 'Barblind', 'Barsleep'}
    state.GainSpell = M{['description']='GainSpell', 'Gain-STR', 'Gain-INT', 'Gain-AGI', 'Gain-VIT', 'Gain-DEX', 'Gain-MND', 'Gain-CHR'}

	state.WeaponSet = M{['description']='Weapon Set', 'Crocea_Daybreak', 'Crocea_Tauret', 'Naegling_Thib'} 
    state.WeaponLock = M(false, 'Weapon Lock')
    state.AutoWeaponLock = M(true, 'Auto Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.SleepMode = M{['description']='Sleep Mode', 'Normal', 'MaxDuration'}
    state.EnspellMode = M(false, 'Enspell Melee Mode')
    
elemental_ws = S{'Seraph Blade', 'Sanguine Blade'}

    -- Additional local binds
    --include('Global-Binds.lua') -- OK to remove this line
    --include('Global-GEO-Binds.lua') -- OK to remove this line

    --send_command('lua l gearinfo')

    --send_command('bind ^` input /ja "Composure" <me>')
    send_command('bind !` gs c toggle MagicBurst')

    --if player.sub_job == 'SCH' then
        --send_command('bind ^- gs c scholar light')
        --send_command('bind ^= gs c scholar dark')
        --send_command('bind !- gs c scholar addendum')
        --send_command('bind != gs c scholar addendum')
        --send_command('bind ^; gs c scholar speed')
        --send_command('bind ![ gs c scholar aoe')
        --send_command('bind !; gs c scholar cost')
    --end

    --send_command('bind !q input /ma "Temper II" <me>')
    --send_command('bind !w input /ma "Flurry II" <stpc>')
    --send_command('bind !e input /ma "Haste II" <stpc>')
    --send_command('bind !r input /ma "Refresh III" <stpc>')
    --send_command('bind !y input /ma "Phalanx II" <stpc>')
    --send_command('bind !o input /ma "Regen II" <stpc>')
    --send_command('bind !p input /ma "Shock Spikes" <me>')

    --send_command('bind !insert gs c cycleback EnSpell')
    --send_command('bind !delete gs c cycle EnSpell')
    --send_command('bind ^insert gs c cycleback GainSpell')
    --send_command('bind ^delete gs c cycle GainSpell')
    --send_command('bind ^home gs c cycleback BarElement')
    --send_command('bind ^end gs c cycle BarElement')
    --send_command('bind ^pageup gs c cycleback BarStatus')
    --send_command('bind ^pagedown gs c cycle BarStatus')

    send_command('bind !f9 gs c cycle SleepMode')
    send_command('bind f9 gs c cycle EnspellMode')
    send_command('bind f10 gs c cycle WeaponSet')
    send_command('bind !f10 gs c toggle MoveSpeed')
    send_command('bind f11 gs c toggle WeaponLock')
    send_command('bind !f11 gs c toggle AutoWeaponLock')

    select_default_macro_book()
    set_lockstyle()

    state.Moving  = M(false, "moving")
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^;')
    send_command('unbind ![')
    send_command('unbind !;')
    send_command('unbind !q')
    send_command('unbind !w')
    send_command('unbind !e')
    send_command('unbind !r')
    send_command('unbind !y')
    send_command('unbind !o')
    send_command('unbind !p')
    send_command('unbind @s')
    send_command('unbind @e')
    send_command('unbind @d')
    send_command('unbind @w')
    send_command('unbind @c')
    send_command('unbind @r')
    send_command('unbind !insert')
    send_command('unbind !delete')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind ^home')
    send_command('unbind ^end')
    send_command('unbind ^pageup')
    send_command('unbind ^pagedown')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad9')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad2')

    send_command('unbind #`')
    send_command('unbind #1')
    send_command('unbind #2')
    send_command('unbind #3')
    send_command('unbind #4')
    send_command('unbind #5')
    send_command('unbind #6')
    send_command('unbind #7')
    send_command('unbind #8')
    send_command('unbind #9')
    send_command('unbind #0')

    send_command('unbind f9')
    send_command('unbind !f9')
    send_command('unbind f10')
    send_command('unbind !f10')
    send_command('unbind f11')
    send_command('unbind !f11')


    --send_command('lua u gearinfo')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Viti. Tabard +3"}

    -- Fast cast sets for spells
    sets.precast.FC = {
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}, priority=1},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs={ name="Lengo Pants", augments={'INT+5','Mag. Acc.+4','"Mag.Atk.Bns."+1','"Refresh"+1',}},
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}, priority=2},
		neck="Baetyl Pendant",
		waist="Embla Sash",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		right_ring="Kishar Ring",
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC['Healing Magic'] = sets.precast.FC.Cure
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		main={ name="Crocea Mors", augments={'Path: C',}}, 
		body="Twilight Cloak",
    })

    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield"})
    sets.precast.Storm = set_combine(sets.precast.FC, { })
    sets.precast.FC.Utsusemi = sets.precast.FC.Cure
	
	
	------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Set Toggles ---------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.Crocea_Daybreak={main={ name="Crocea Mors", augments={'Path: C',}}, sub="Daybreak",}
	
	sets.Crocea_Tauret={main={ name="Crocea Mors", augments={'Path: C',}}, sub="Tauret",}
	
	sets.Naegling_Thib={main="Naegling", sub="Thibron",}

    sets.MageIdle={main={ name="Colada", augments={'"Refresh"+2','CHR+3','Mag. Acc.+15',}}, sub="Genmei Shield",}

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Aurgelmir Orb +1",
    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
    body="Jhakri Robe +2",
    hands="Atrophy Gloves +3",
    legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Sherida Earring",
    right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    left_ring="Epaminondas's Ring",
    right_ring="Rufescent Ring",
    back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
        }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {    })

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {       })

    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {        })

    sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']
    sets.precast.WS['Vorpal Blade'].Acc = sets.precast.WS['Chant du Cygne'].Acc

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        neck="Dls. Torque +2",
        body="Viti. Tabard +3",
        waist="Sailfi Belt +1",
        })

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
        
        })

    sets.precast.WS['Death Blossom'] = sets.precast.WS['Savage Blade']
    sets.precast.WS['Death Blossom'].Acc = sets.precast.WS['Savage Blade'].Acc

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {        })

    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {        })

sets.precast.WS['Flat Blade'] = {    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Sherida Earring",
    right_ear="Cessance Earring",
    left_ring="Chirich Ring +1",
    right_ring="Ilabrat Ring",
    back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},


}

    sets.precast.WS['Sanguine Blade'] = {
        
    ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    hands="Jhakri Cuffs +2",
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
    neck="Baetyl Pendant",
    waist="Orpheus's Sash",
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Epaminondas's Ring",
    right_ring="Archon Ring",
    back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Weapon skill damage +10%',}},

        }

    sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS['Sanguine Blade'], {
    ammo="Pemphredo Tathlum",
    head="C. Palug Crown",
    body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    hands="Jhakri Cuffs +2",
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
    neck="Baetyl Pendant",
    waist="Orpheus's Sash",
    left_ear="Malignance Earring",
    right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    left_ring="Epaminondas's Ring",
    right_ring="Weather. Ring +1",
    back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Weapon skill damage +10%',}},
        })

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Seraph Dlade'], { right_ring="Freke Ring",       })

    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS['Savage Blade'], {        })

    sets.precast.WS['Black Halo'].Acc = set_combine(sets.precast.WS['Black Halo'], {        })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        legs="Carmine Cuisses +1", --20
        ring1="Evanescence Ring", --5
        
        }

    sets.midcast.Cure = {
    ammo="Regal Gem",
    head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
    body={ name="Kaykaus Bliaut +1", augments={'MP+80','"Cure" potency +6%','"Conserve MP"+7',}},
    hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
    legs={ name="Kaykaus Tights +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
    feet={ name="Kaykaus Boots +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
    neck={ name="Dls. Torque +2", augments={'Path: A',}},
    waist="Luminary Sash",
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring={name="Stikini Ring +1", bag="wardrobe2"},
    right_ring={name="Stikini Ring +1", bag="wardrobe3"},
    back={ name="Fi Follet Cape +1", augments={'Path: A',}},
        }

    sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
        })

    sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {
        waist="Gishdubar Sash", -- (10)
        })

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {    })

    sets.midcast.StatusRemoval = {        }

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {        })

    sets.midcast['Enhancing Magic'] = {
    main="Pukulatmuj +1",
    sub={name="Ammurapi Shield", priority=1},
    head="Befouled Crown",
    hands="Atrophy Gloves +3",
    body="Viti. Tabard +3",
    feet="Leth. Houseaux +1",
    waist="Embla Sash", 
    back="Ghostfyre Cape",
    left_ring={name="Stikini Ring +1", bag="wardrobe2"},
    right_ring={name="Stikini Ring +1", bag="wardrobe3"},
    legs="Atrophy Tights +3",
    left_ear="Andoaa Earring",
    right_ear="Mimir Earring",
    neck="Dls. Torque +2",
        }

    sets.midcast.EnhancingDuration = {
        sub={name="Ammurapi Shield", priority=1},
        body="Viti. Tabard +3",
        hands="Atrophy Gloves +3",
        feet="Leth. Houseaux +1",
        neck="Dls. Torque +2",
        back="Ghostfyre Cape", 
        waist="Embla Sash",
        }

    sets.midcast.EnhancingSkill = {
        main="Pukulatmuj +1",
        hands="Viti. Gloves +3",
        waist="Olympus Sash",
        back="Ghostfyre Cape",
        neck="Incanter's Torque",
        }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        sub={name="Ammurapi Shield", priority=1},
        })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif +1", -- +1
        body="Atrophy Tabard +3", -- +3
        legs="Leth. Fuseau +1", -- +2
        })

    sets.midcast.RefreshSelf = {
        waist="Gishdubar Sash",
        }

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {  
    neck="Nodens Gorget",
    waist="Siegel Sash",
    left_ear="Earthcry Earring",
        })

    sets.midcast['Phalanx'] = set_combine(sets.midcast.EnhancingDuration, {
    head="Befouled Crown", 
    body={ name="Taeon Tabard", augments={'Mag. Evasion+20','Spell interruption rate down -10%','Phalanx +3',}},
    hands={ name="Taeon Gloves", augments={'Mag. Evasion+17','Spell interruption rate down -10%','Phalanx +3',}},
    legs={ name="Taeon Tights", augments={'Mag. Evasion+16','"Fast Cast"+5','Phalanx +3',}},
    feet={ name="Taeon Boots", augments={'Mag. Evasion+19','Spell interruption rate down -10%','Phalanx +3',}},
    right_ear="Mimir Earring",
    back="Ghostfyre Cape",
       })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif +1",
        ear1="Halasz Earring",
        ring1="Freke Ring",
        ring2="Evanescence Ring",
        })

    sets.midcast.Storm = sets.midcast.EnhancingDuration
    sets.midcast.GainSpell = {hands="Viti. Gloves +3"}
    sets.midcast.SpikesSpell = {legs="Viti. Tights +3"}

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell


     -- Custom spell classes

    sets.midcast.MndEnfeebles = {
        main="Daybreak",
        sub={name="Ammurapi Shield", priority=1},
        ammo={name="Regal Gem", priority=2},
        head="Viti. Chapeau +3",
        body="Lethargy Sayon +1",
        hands="Kaykaus Cuffs +1",
        legs="Chironic Hose",
        feet="Vitiation Boots +3",
        neck="Dls. Torque +2",
        left_ear="Malignance Earring",
        right_ear="Snotra Earring",
        right_ring="Kishar Ring",
        left_ring="Metamor. Ring +1",
        back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Weapon skill damage +10%',}},
        waist="Luminary Sash",
        }

    sets.midcast.MndEnfeeblesAcc = set_combine(sets.midcast.MndEnfeebles, {
        main={ name="Crocea Mors", augments={'Path: C',}},
        range="Ullr",
        
        body="Atrophy Tabard +3",
        right_ring={name="Stikini Ring +1", bag="wardrobe3"},
        left_ear="Regal Earring"
        })

    sets.midcast.MndEnfeeblesEffect = set_combine(sets.midcast.MndEnfeebles, {
        ammo={name="Regal Gem", priority=2},
        body="Lethargy Sayon +1",
        feet="Vitiation Boots +3",
        neck="Dls. Torque +2",
        back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Weapon skill damage +10%',}},
        })

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        main="Maxentius",
        sub={name="Ammurapi Shield", priority=1},
        back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
        })

    sets.midcast.IntEnfeeblesAcc = set_combine(sets.midcast.IntEnfeebles, {
        main={ name="Crocea Mors", augments={'Path: C',}},
        sub={name="Ammurapi Shield", priority=1},
        range="Ullr",
        
        body="Atrophy Tabard +3",
        left_ear="Regal Earring",
        right_ring={name="Stikini Ring +1", bag="wardrobe3"},
        })

    sets.midcast.IntEnfeeblesEffect = set_combine(sets.midcast.IntEnfeebles, {
        ammo={name="Regal Gem", priority=2},
        body="Lethargy Sayon +1",
        feet="Vitiation Boots +3",
        neck="Dls. Torque +2",
        })

    sets.midcast.SkillEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
		main={ name="Contemplator +1", augments={'Path: A',}, priority=1},
		sub="Enki Strap",
        head="Viti. Chapeau +3",
        body="Atrophy Tabard +3",
        hands="Kaykaus Cuffs +1",
        feet="Vitiation Boots +3",
        left_ring={name="Stikini Ring +1", bag="wardrobe2"},
        right_ring={name="Stikini Ring +1", bag="wardrobe3"},
        left_ear="Vor Earring",
        right_ear="Snotra Earring",
        waist="Rumination Sash",
        })

    sets.midcast.Sleep = set_combine(sets.midcast.IntEnfeeblesAcc, {
        head="Viti. Chapeau +3",
        neck="Dls. Torque +2",
        right_ear="Snotra Earring",
        right_ring="Kishar Ring",
        })

    sets.midcast.SleepMaxDuration = set_combine(sets.midcast.Sleep, {
        head="Leth. Chappel +1",
        body="Lethargy Sayon +1",
        hands="Leth. Gantherots +1",
        legs="Leth. Fuseau +1",
        feet="Leth. Houseaux +1",
        })

    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles
    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeeblesAcc, {main="Daybreak", sub="Ammurapi Shield"})

    sets.midcast['Dark Magic'] = {
    main="Daybreak",
    sub={name="Ammurapi Shield", priority=1},
    ammo="Pemphredo Tathlum",
    head={ name="Amalric Coif +1", augments={'INT+12','Mag. Acc.+25','Enmity-6',}},
    body="Atrophy Tabard +3",
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs="Chironic Hose",
    feet={ name="Merlinic Crackows", augments={'"Dbl.Atk."+2','Accuracy+21','"Refresh"+2','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
    neck="Erra Pendant",
    waist="Skrymir Cord +1",
    right_ear="Regal Earring",
    left_ear="Malignance Earring",
    left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
    right_ring="Evanescence Ring",
    back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},

        }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Pixie Hairpin +1",
        legs="Chironic Hose",
        ring1="Archon Ring",
        ring2="Evanescence Ring",
        neck="Erra Pendant",
        waist="Fucho-no-obi",
        })

    sets.midcast.Aspir = sets.midcast.Drain
    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {waist="Luminary Sash"})
    sets.midcast['Bio III'] = set_combine(sets.midcast['Dark Magic'], { })

    sets.midcast['Elemental Magic'] = {
        main="Daybreak",
        sub={name="Ammurapi Shield", priority=1},
    ammo={name="Pemphredo Tathlum", priority=2},
    head="C. Palug Crown",
    body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
    neck="Sanctity Necklace",
    waist="Skrymir Cord +1",
    right_ear="Regal Earring",
    left_ear="Malignance Earring",
    left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
    right_ring="Freke Ring",
    back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
        }


    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        range="Ullr",
        
        })

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        main={ name="Crocea Mors", augments={'Path: C',}},
        range="Ullr",
        
        head=empty,
        body="Twilight Cloak",
        legs="Chironic Hose",
        neck="Dls. Torque +2",
        right_ear="Snotra Earring",
        right_ring="Archon Ring",
        })

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    -- Job-specific buff sets
    sets.buff.ComposureOther = {
        main={ name="Colada", augments={'Enh. Mag. eff. dur. +4','STR+4','Mag. Acc.+2','"Mag.Atk.Bns."+17','DMG:+20',}},
        head="Leth. Chappel +1",
        body="Viti. Tabard +3",
        hands="Atrophy Gloves +3",
        legs="Leth. Fuseau +1",
        feet="Leth. Houseaux +1",
        }

    sets.buff.Saboteur = {hands="Leth. Gantherots +1"}


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
    ammo="Homiliary",
    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
    body="Jhakri Robe +2",
    hands={ name="Merlinic Dastanas", augments={'Pet: "Dbl. Atk."+3','"Dual Wield"+3','"Refresh"+2',}},
    legs={ name="Lengo Pants", augments={'INT+5','Mag. Acc.+4','"Mag.Atk.Bns."+1','"Refresh"+1',}},
    feet={ name="Merlinic Crackows", augments={'"Dbl.Atk."+2','Accuracy+21','"Refresh"+2','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
    neck="Loricate Torque +1",
    waist="Gishdubar Sash",
    left_ear="Etiolation Earring",
    right_ear="Ethereal Earring",
    left_ring={name="Stikini Ring +1", bag="wardrobe2"},
    right_ring={name="Stikini Ring +1", bag="wardrobe3"},
    back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
        }

    sets.idle.DT = set_combine(sets.idle, {
        head="Malignance Chapeau", --6/6
        body="Malignance Tabard", --9/9
        hands="Malignance Gloves", --5/5
        legs="Malignance Tights", --7/7
        feet="Malignance Boots", --4/4
        left_ring="Defending Ring", --10/10
        })

    sets.idle.Town = set_combine(sets.idle, {
        })

    sets.resting = set_combine(sets.idle, {
        })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.magic_burst = {
    head="Ea Hat +1",
    body="Ea Houppe. +1",
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs="Ea Slops +1",
    feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
    neck="Mizu. Kubikazari",
    left_ring="Locus Ring",
    right_ring="Mujin Band",
        }

    sets.Kiting = {legs="Carmine Cuisses +1"}
    sets.latent_refresh = {waist="Fucho-no-obi"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
    ammo="Aurgelmir Orb +1",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Anu Torque",
    waist="Reiki Yotai",
    left_ear="Sherida Earring",
    right_ear="Eabani Earring",
    left_ring="Chirich Ring +1",
    right_ring="Hetairoi Ring",
    back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
        }

    sets.engaged.MidAcc = set_combine(sets.engaged, {
        })

    sets.engaged.HighAcc = set_combine(sets.engaged, {
        
        })

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
    ammo="Aurgelmir Orb +1",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Anu Torque",
    waist="Reiki Yotai",
    left_ear="Sherida Earring",
    right_ear="Eabani Earring",
    left_ring="Chirich Ring +1",
    right_ring="Hetairoi Ring",
    back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
        } --41

    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW, {
        })

    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
        })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = set_combine(sets.engaged.DW, {
        }) --41

    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
        })

    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
        })

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = set_combine(sets.engaged.DW, {
        }) --31

    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
        })

    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
        })

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = set_combine(sets.engaged.DW, {
      }) --26

    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
        })

    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
        })

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = set_combine(sets.engaged.DW, {
        }) --10

    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
        })

    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
        })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        neck="Loricate Torque +1", --6/6
        right_ring="Defending Ring", --10/10
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)

-- removed for now neck="Dls. Torque +2",
    sets.engaged.Enspell = {
        hands="Aya. Manopolas +2",
        waist="Orpheus's Sash",
        right_ear="Telos Earring",
        back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},
        }

    

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
        }

    sets.Obi = {waist="Hachirin-no-Obi"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
	if player.sub_job == 'NIN' then
		equip(sets[state.WeaponSet.current])
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
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
    if spell.english == "Phalanx II" and spell.target.type == 'SELF' then
        cancel_spell()
        send_command('@input /ma "Phalanx" <me>')
    end
	if spell.type == 'WeaponSkill' and elemental_ws:contains(spell.name) then
		if spell.english == 'Sanguine Blade' and (spell.element == world.weather_element and get_weather_intensity() == 2) then
			equip({waist="Anrin Obi"})
		end
		if spell.english == 'Seraph Blade' and (spell.element == world.weather_element and get_weather_intensity() == 2) then
			equip({waist="Korin Obi"})
		end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
                if spell.target.type == 'SELF' then
                    equip (sets.midcast.RefreshSelf)
              end
            end
        elseif skill_spells:contains(spell.english) then
		 if player.sub_job == 'NIN' then
   equip(set_combine(sets.midcast.EnhancingSkill, {sub="Pukulatmuj",}))
            else
            equip(sets.midcast.EnhancingSkill)
            end
        elseif spell.english:startswith('Gain') then
            equip(sets.midcast.GainSpell)
        elseif spell.english:contains('Spikes') then
            equip(sets.midcast.SpikesSpell)
        end
        if (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and buffactive.Composure then
            equip(sets.buff.ComposureOther)
        end
    end
    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value and spell.english ~= 'Death' then
            equip(sets.magic_burst)
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if spell.target.distance < (13 + spell.target.model_size) then
				equip({waist="Orpheus's Sash"})
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
	if player.sub_job == 'NIN' then
		equip(sets[state.WeaponSet.current])
	else
		send_command('gs equip sets.MageIdle')
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
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

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if player.sub_job == 'NIN' then
		equip(sets[state.WeaponSet.current])
	else
		send_command('gs equip sets.MageIdle')
	end
	if state.WeaponLock.value == true then
        disable('main','sub','range')
    else
        enable('main','sub','range')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
     if player.sub_job == 'NIN' then
		equip(sets[state.WeaponSet.current])
	else
		send_command('gs equip sets.MageIdle')
	end
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
if state.AutoWeaponLock.value==true then
    if player.status=='Engaged' then
         disable('main','sub','range')
    elseif player.status=='Idle' and state.WeaponLock.value ~= true then
         enable('main','sub','range')
   end
end
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return 'CureWeather'
            end
        end
        if spell.skill == 'Enfeebling Magic' then
            if enfeebling_magic_skill:contains(spell.english) then
                return "SkillEnfeebles"
            elseif spell.type == "WhiteMagic" then
                if enfeebling_magic_acc:contains(spell.english) and not buffactive.Stymie then
                    return "MndEnfeeblesAcc"
                elseif enfeebling_magic_effect:contains(spell.english) then
                    return "MndEnfeeblesEffect"
                else
                    return "MndEnfeebles"
              end
            elseif spell.type == "BlackMagic" then
                if enfeebling_magic_acc:contains(spell.english) and not buffactive.Stymie then
                    return "IntEnfeeblesAcc"
                elseif enfeebling_magic_effect:contains(spell.english) then
                    return "IntEnfeeblesEffect"
                elseif enfeebling_magic_sleep:contains(spell.english) and ((buffactive.Stymie and buffactive.Composure) or state.SleepMode.value == 'MaxDuration') then
                    return "SleepMaxDuration"
                elseif enfeebling_magic_sleep:contains(spell.english) then
                    return "Sleep"
                else
                    return "IntEnfeebles"
                end
            else
                return "MndEnfeebles"
            end
        end
    end
end



--determine moving and equip movespeed
mov = {counter=0}
if player and player.index and windower.ffxi.get_mob_by_index(player.index) then
    mov.x = windower.ffxi.get_mob_by_index(player.index).x
    mov.y = windower.ffxi.get_mob_by_index(player.index).y
    mov.z = windower.ffxi.get_mob_by_index(player.index).z
end

moving = false
windower.raw_register_event('prerender',function()
    mov.counter = mov.counter + 1;
    if mov.counter>15 and not midaction() then
        local pl = windower.ffxi.get_mob_by_index(player.index)
        if pl and pl.x and mov.x then
            dist = math.sqrt( (pl.x-mov.x)^2 + (pl.y-mov.y)^2 + (pl.z-mov.z)^2 )
            if dist > 1 and not moving and player.status=='Idle' and state.MoveSpeed.value then
                state.Moving.value = true
				send_command('gs c update')
                send_command('gs equip sets.Kiting')
			    --if world.area:contains("Adoulin") then
			--send_command('gs equip sets.Adoulin')
				--end
                moving = true
				
            elseif dist < 1 and moving and state.MoveSpeed.value then
                state.Moving.value = false
                send_command('gs c update')
                moving = false
            end
        end
        if pl and pl.x then
            mov.x = pl.x
            mov.y = pl.y
            mov.z = pl.z
        end
        mov.counter = 0
    end
end)

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

function customize_melee_set(meleeSet)
    if state.EnspellMode.value == true then
        meleeSet = set_combine(meleeSet, sets.engaged.Enspell)
    end
    return meleeSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------




-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>

function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end




function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("ring1")
    else
        enable("ring1")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("ring2")
    else
        enable("ring2")
    end
end

windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("ring1")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("ring2")
            equip(sets.idle)
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'NIN' then
        set_macro_page(3, 17)
    elseif player.sub_job == 'SCH' then
        set_macro_page(7, 17)
    else
        set_macro_page(3, 17)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end

