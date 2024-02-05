-- Original: Motenten / Modified: Arislan /Additional Modification: Aessk
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ ALT+F9 ]          Cycle Ranged Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ WIN+` ]           Toggle use of Luzaf Ring.
--              [ WIN+Q ]           Quick Draw shot mode selector.
--
--  Abilities:  [ CTRL+- ]          Quick Draw primary shot element cycle forward.
--              [ CTRL+= ]          Quick Draw primary shot element cycle backward.
--              [ ALT+- ]           Quick Draw secondary shot element cycle forward.
--              [ ALT+= ]           Quick Draw secondary shot element cycle backward.
--              [ CTRL+[ ]          Quick Draw toggle target type.
--              [ CTRL+] ]          Quick Draw toggle use secondary shot.
--
--              [ CTRL+C ]          Crooked Cards
--              [ CTRL+` ]          Double-Up
--              [ CTRL+X ]          Fold
--              [ CTRL+S ]          Snake Eye
--              [ CTRL+NumLock ]    Triple Shot
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ WIN+E/R ]         Cycles between available Weapon Sets
--              [ WIN+W ]           Toggle Ranged Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Savage Blade
--              [ CTRL+Numpad8 ]    Last Stand
--              [ CTRL+Numpad4 ]    Leaden Salute
--              [ CTRL+Numpad5 ]    Requiescat
--              [ CTRL+Numpad6 ]    Wildfire
--              [ CTRL+Numpad1 ]    Aeolian Edge
--              [ CTRL+Numpad2 ]    Evisceration
--
--  RA:         [ Numpad0 ]         Ranged Attack
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c qd                         Uses the currently configured shot on the target, with either <t> or
--                                  <stnpc> depending on setting.
--  gs c qd t                       Uses the currently configured shot on the target, but forces use of <t>.
--
--  gs c cycle mainqd               Cycles through the available steps to use as the primary shot when using
--                                  one of the above commands.
--  gs c cycle altqd                Cycles through the available steps to use for alternating with the
--                                  configured main shot.
--  gs c toggle usealtqd            Toggles whether or not to use an alternate shot.
--  gs c toggle selectqdtarget      Toggles whether or not to use <stnpc> (as opposed to <t>) when using a shot.
--
--  gs c toggle LuzafRing           Toggles use of Luzaf Ring on and off


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
    -- QuickDraw Selector
    state.Mainqd = M{['description']='Primary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot'}
    state.Altqd = M{['description']='Secondary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot'}
    state.UseAltqd = M(false, 'Use Secondary Shot')
    state.SelectqdTarget = M(false, 'Select Quick Draw Target')
    state.IgnoreTargetting = M(false, 'Ignore Targetting')

    state.DualWield = M(false, 'Dual Wield III')
    state.QDMode = M{['description']='Quick Draw Mode', 'STP', 'Magic Enhance', 'Magic Attack'}

    state.Currentqd = M{['description']='Current Quick Draw', 'Main', 'Alt'}

    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(true, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)
	
	include('Mote-TreasureHunter')
 
    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
	
    define_roll_values()

    lockstyleset = 58
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc', 'STP')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('Normal', 'Acc', 'HighAcc', 'Critical', 'STP')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'Refresh')

    state.WeaponSet = M{['description']='Weapon Set', 'DeathPenalty', 'Ataktos', 'Fomalhaut'} --'DeathPenalty', 'Ataktos', 'Trials'
	state.MeleeSet = M{['description']='Melee Set', 'Hybrid', 'Leaden', 'Savage', 'Ranged', 'DT', }
    state.CP = M(false, "Capacity Points Mode")
    state.WeaponLock = M(false, 'Weapon Lock')
	--Whether to use Warp Ring and Dem Ring
	state.Warp = M(false, "Warp Ring")
	-- state.Fish = M(false, "Fish")

	gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Living Bullet"
    gear.QDbullet = "Living Bullet"	
	--gear.QDbullet = "Animikii Bullet"
    gear.QDMGbullet = "Hauksbok Bullet"
	options.ammo_warning_limit = 10

	elemental_ws = S{'Aeolian Edge', 'Leaden Salute', 'Wildfire'}   

   -- Additional local binds
    -- include('Global-Binds.lua') -- OK to remove this line
    -- include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('lua l gearinfo')

    -- send_command('bind ^` input /ja "Double-up" <me>')
    -- send_command('bind ^c input /ja "Crooked Cards" <me>')
    -- send_command('bind ^s input /ja "Snake Eye" <me>')
    -- send_command('bind ^f input /ja "Fold" <me>')
    -- send_command('bind !` input /ja "Bolter\'s Roll" <me>')
    send_command ('bind ^; gs c toggle LuzafRing')
	send_command('bind !; gs c toggle Warp')
	send_command('bind ![ gs c toggle Fish')
	
    --send_command('bind ^- gs c cycle mainqd')
	--send_command('bind ^= gs c cycleback mainqd')
    --send_command('bind !- gs c cycle altqd')
    --send_command('bind != gs c cycleback altqd')
    --send_command('bind ^[ gs c toggle selectqdtarget')
    --send_command('bind ^] gs c toggle usealtqd')
	
	send_command('bind ^= gs c cycle treasuremode')
	
    send_command('bind @c gs c toggle CP')
    send_command('bind @q gs c cycle QDMode')
    send_command('bind @e gs c cycle WeaponSet')
    send_command('bind @r gs c cycle MeleeSet')
    send_command('bind @w gs c toggle WeaponLock')

    -- send_command('bind ^numlock input /ja "Triple Shot" <me>')

    if player.sub_job == 'WAR' then
        -- send_command('bind ^numpad/ input /ja "Berserk" <me>')
        -- send_command('bind ^numpad* input /ja "Warcry" <me>')
        -- send_command('bind ^numpad- input /ja "Aggressor" <me>')
    end

    -- send_command('bind ^numpad7 input /ws "Savage Blade" <t>')
    -- send_command('bind ^numpad8 input /ws "Last Stand" <t>')
    -- send_command('bind ^numpad4 input /ws "Leaden Salute" <t>')
    -- send_command('bind ^numpad5 input /ws "Requiescat" <t>')
    -- send_command('bind ^numpad6 input /ws "Wildfire" <t>')
    -- send_command('bind ^numpad1 input /ws "Aeolian Edge" <t>')
    -- send_command('bind ^numpad2 input /ws "Evisceration" <t>')

    -- send_command('bind numpad0 input /ra <t>')

    select_default_macro_book()
    set_lockstyle('58')

    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind ^c')
    send_command('unbind ^s')
    send_command('unbind ^f')
    send_command('unbind !`')
    send_command('unbind @`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^[')
    send_command('unbind ^]')
    send_command('unbind ^,')
    send_command('unbind @c')
    send_command('unbind @q')
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind ^numlock')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad2')
    send_command('unbind numpad0')

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

    send_command('lua u gearinfo')

end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.TreasureHunter = {
		head="Wh. rarab cap +1",
		waist="Chaac Belt",
	}
	
    sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +3"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}

    sets.precast.CorsairRoll = {
		main={name="Rostam", bag="Wardrobe 3"},
		head={ name="Lanun Tricorne +3", augments={'Enhances "Winning Streak" effect',}},
		body="Malignance Tabard",
		hands="Chasseur's Gants +1",
		legs="Desultor Tassets",
		feet="Malignance Boots",
		neck="Regal Necklace",
		waist="Windbuffet Belt +1",
		left_ear="Eabani Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Luzaf's Ring",
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
        }

    sets.precast.CorsairRoll.Gun = set_combine(sets.precast.CorsairRoll.Engaged, {range="Compensator"})
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes +1"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes +1"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +1"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})

    sets.precast.LuzafRing = set_combine(sets.precast.CorsairRoll, {right_ring="Luzaf's Ring"})
    sets.precast.FoldDoubleBust = {hands={ name="Lanun Gants +3", augments={'Enhances "Fold" effect',}}}

    sets.precast.Waltz = {
        body="Passion Jacket",
        --neck="Phalaina Locket",
        ring1="Asklepian Ring",
        waist="Gishdubar Sash",
        }

    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.FC = {
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body={ name="Taeon Tabard", augments={'Mag. Evasion+16','"Fast Cast"+3','"Regen" potency+2',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Meg. Chausses +2",
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
		neck="Baetyl Pendant",
		waist="Sarissapho. Belt",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Kishar Ring",
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
        }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        body="Passion Jacket",
		neck="Magoraga Beads",
        -- ring1="Lebeche Ring",
        })

    -- (10% Snapshot from JP Gifts)
    sets.precast.RA = {
        ammo=gear.RAbullet,
		head={ name="Taeon Chapeau", augments={'Rng.Acc.+20 Rng.Atk.+20','"Snapshot"+5','"Snapshot"+5',}},
		body="Laksa. Frac +3",
		--body="Oshosi Vest +1",
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},
		feet="Meg. Jam. +2",
		neck="Comm. Charm +2",
		waist="Yemaya Belt",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Snapshot"+10',}},
      } --61/26

    sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
        body="Laksa. Frac +3", --0/20
        }) --47/46

    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
        head="Chass. Tricorne +1", --0/14
        feet="Pursuer's Gaiters", --0/10
        waist="Impulse Belt", --3/0
        }) --30/65


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
		ammo=gear.WSbullet,
		head={ name="Lanun Tricorne +3", augments={'Enhances "Winning Streak" effect',}},
		body="Laksa. Frac +3",
		hands="Meg. Gloves +2",
		legs={ name="Lanun Trews +3", augments={'Enhances "Snake Eye" effect',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
		right_ring="Regal Ring",
		left_ring="Epaminondas's Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
        }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
		left_ear="Moonshade Earring"
	})

    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
        neck="Iskur Gorget",
        ear2="Telos Earring",
        ring1="Epaminondas's Ring",
		ring2="Ilabrat Ring", 
        waist="Kwahu Kachina Belt",
        })
		
    sets.precast.WS['Wildfire'] = {
		ammo=gear.MAbullet,
		head={ name="Herculean Helm", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Weapon skill damage +1%','MND+10','"Mag.Atk.Bns."+15',}},
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +4%','"Mag.Atk.Bns."+12',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Comm. Charm +2",
		waist="Skrymir Cord +1",
		left_ear="Hecate's Earring",
		right_ear="Friomisi Earring",
		left_ring="Dingir Ring",
		right_ring="Ilabrat Ring",
		--right_ring="Epaminondas's Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
        }

    sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']

    sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], {
        head="Pixie Hairpin +1",
		left_ear="Moonshade Earring",
        right_ring="Archon Ring",
		waist="Skrymir Cord +1",
        })

    sets.precast.WS['Leaden Salute'].FullTP = set_combine(sets.precast.WS['Leaden Salute'], {
		left_ear="Hecate's Earring",
	})
	
	sets.precast.WS['Split Shot'] = {
		ammo=gear.WSbullet,
		head="Mummu Bonnet +2",
		body="Mummu Jacket +2",
		hands="Mummu Wrists +2",
		legs="Mummu Kecks +2",
		feet="Mummu Gamash. +2",
		neck="Comm. Charm +2",
		waist="K. Kachina Belt +1",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Longshot Ring",
		right_ring="Cacoethic Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Damage taken-5%',}},
	}

    sets.precast.WS['Evisceration'] = {}

    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
   		head={ name="Lilitu Headpiece", augments={'STR+10','DEX+10','Attack+15','Weapon skill damage +3%',}},
		legs="Meg. Chausses +2",
		--legs={ name="Herculean Trousers", augments={'Mag. Acc.+2','Weapon skill damage +4%','STR+15','"Mag.Atk.Bns."+7',}},
		neck="Comm. Charm +2",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		left_ring="Rufescent Ring",
		right_ring="Karieyh Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    })

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
	})

    sets.precast.WS['Swift Blade'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Swift Blade'].Acc = set_combine(sets.precast.WS['Swift Blade'], {})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Swift Blade'], {
        hands="Meg. Gloves +2",
        right_ear="Moonshade Earring",
        left_ring="Rufescent Ring",
        }) --MND

    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {
        head="Meghanada Visor +2",
        ear1="Cessance Earring",
        })

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Wildfire'], {
        left_ear="Moonshade Earring",
        -- ring1="Shiva Ring +1",
		waist="Orpheus's Sash",
        })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        legs="Carmine Cuisses +1", --20
        ring1="Evanescence Ring", --5
        }

    sets.midcast.Cure = {}

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt
	
	sets.midcast['Sylvie (UC)'] = {
		body="Sylvie Unity Shirt",
	}

    -- Occult Acumen Set
    sets.midcast['Dark Magic'] = {}

    sets.midcast.CorsairShot = {
        ammo=gear.QDMGbullet,
		head={ name="Herculean Helm", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Weapon skill damage +1%','MND+10','"Mag.Atk.Bns."+15',}},
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'"Store TP"+4','"Mag.Atk.Bns."+30','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Baetyl Pendant",
		waist="Skrymir Cord +1",
		left_ear="Hecate's Earring",
		right_ear="Friomisi Earring",
		left_ring="Dingir Ring",
		right_ring="Stikini Ring +1",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
        }

    sets.midcast.CorsairShot.STP = {
        ammo=gear.MAbullet,
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Ilabrat Ring",
		right_ring="Petrov Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10','Damage taken-5%',}},
        }

    sets.midcast.CorsairShot.Resistant = set_combine(sets.midcast.CorsairShot, {
		ammo=gear.QDbullet,
		head="Laksa. Tricorne +3",
		body="Malignance Tabard",
		hands="Laksa. Gants +3",
		legs="Malignance Tights",
		feet="Laksa. Boots +3",
		neck="Comm. Charm +2",
		waist="Orpheus's Sash",
		left_ear="Digni. Earring",
		right_ear="Gwati Earring",
		left_ring="Regal Ring",
		right_ring="Stikini Ring +1",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
        })

    sets.midcast.CorsairShot['Light Shot'] = sets.midcast.CorsairShot.Resistant
    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot.Resistant
    sets.midcast.CorsairShot.Enhance = {body="Mirke Wardecors", feet="Chass. Bottes +1"}

    -- Ranged gear
    sets.midcast.RA = {
        ammo=gear.RAbullet,
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Dingir Ring",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Damage taken-5%',}},
        }

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
        head="Meghanada Visor +2",
		hands={ name="Lanun Gants +3", augments={'Enhances "Fold" effect',}},
        ring1="Regal Ring",
        })

    sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA.Acc, {
        body="Laksa. Frac +3",
        legs="Laksa. Trews +3",
        -- ring2="Hajduk Ring +1",
        waist="Kwahu Kachina Belt",
        })

    sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Mummu Wrists +2",
		legs="Darraigner's Brais",
		feet="Osh. Leggings +1",
		waist="K. Kachina Belt +1",
		left_ring="Mummu Ring",
		right_ring="Begrudging Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+9','Crit.hit rate+10','Mag. Evasion+15',}},
        })

    sets.midcast.RA.STP = set_combine(sets.midcast.RA, {
        right_ear="Dedition Earring",
        })

    sets.TripleShot = {
        head="Oshosi Mask +1", --4
        body="Chasseur's Frac +1", --12
		hands={ name="Lanun Gants +3", augments={'Enhances "Fold" effect',}},
        legs="Oshosi Trousers +1", --5
        feet="Oshosi Leggings +1", --2
        } --27

    sets.TripleShotCritical = {
        waist="K. Kachina Belt +1",
		left_ring="Mummu Ring",
		right_ring="Begrudging Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+9','Crit.hit rate+10','Mag. Evasion+15',}},
        }


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = {}

    sets.idle = {
		ammo=gear.RAbullet,
		head="Malignance Chapeau",	--6
		body="Malignance Tabard",	--9
		hands="Malignance Gloves",	--5
		legs="Malignance Tights",	--7
		feet="Malignance Boots",	--4
		neck="Loricate Torque +1",	--6
		waist="Flume Belt +1",
		left_ear="Ethereal Earring",
		right_ear="Infused Earring",
		left_ring="Defending Ring",--10
		right_ring="Karieyh Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
        }

    sets.idle.DT = set_combine(sets.idle, {
		head="Malignance Chapeau",	--6
		body="Malignance Tabard",	--9
		hands="Malignance Gloves",	--5
		legs="Malignance Tights",	--7
		feet="Malignance Boots",	--4
		neck="Loricate Torque +1",	--6
		left_ring="Defending Ring",--10
	})

    sets.idle.Refresh = set_combine(sets.idle, {})

    sets.idle.Town = set_combine(sets.idle, {})


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+21','"Triple Atk."+4','STR+5',}},
		neck="Sanctity Necklace",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
        }

    sets.engaged.LowAcc = set_combine(sets.engaged, {
        head="Dampening Tam",
        })

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
        left_ring="Ilabrat Ring",
        right_ring="Regal Ring",
        waist="Kentarch Belt +1",
        })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
		head="Mummu Bonnet +2",
		legs="Mummu Kecks +2",
		feet="Mummu Gamash. +2",
		right_ear="Digni. Earring",
		right_ring="Mummu Ring",
	})

    sets.engaged.STP = set_combine(sets.engaged, {})

    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
		head={ name="Herculean Helm", augments={'"Dual Wield"+6','DEX+2','Accuracy+12',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Taeon Boots", augments={'Accuracy+22','"Dual Wield"+3','DEX+10',}},
		neck="Iskur Gorget",
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Suppanomimi",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	} -- 48%

    sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {
	    head="Dampening Tam",
        neck="Combatant's Torque",
	})

    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {
		left_ear="Telos Earring",
        left_ring="Ilabrat Ring",
        right_ring="Regal Ring",
        waist="Kentarch Belt +1",
	})

    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
		head="Mummu Bonnet +2",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Mummu Kecks +2",
		feet="Mummu Gamash. +2",
		right_ear="Digni. Earring",
		right_ring="Mummu Ring",
	})

    sets.engaged.DW.STP = set_combine(sets.engaged.DW, { })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Taeon Boots", augments={'Accuracy+22','"Dual Wield"+3','DEX+10',}},
		neck="Iskur Gorget",
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Suppanomimi",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	} -- 42%

    sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
	    head="Dampening Tam",
        neck="Combatant's Torque",
	})

    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {
		left_ear="Telos Earring",
        left_ring="Ilabrat Ring",
        right_ring="Regal Ring",
        waist="Kentarch Belt +1",
	})

    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
		head="Mummu Bonnet +2",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Mummu Kecks +2",
		feet="Mummu Gamash. +2",
		right_ear="Digni. Earring",
		right_ring="Mummu Ring",
	})

    sets.engaged.DW.STP.LowHaste = set_combine(sets.engaged.DW.LowHaste, {})

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Taeon Boots", augments={'Accuracy+22','"Dual Wield"+3','DEX+10',}},
		neck="Iskur Gorget",
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Suppanomimi",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	} -- 31%

    sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
		head="Dampening Tam",
        neck="Combatant's Torque",
		})

    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {
			left_ear="Telos Earring",
        left_ring="Ilabrat Ring",
        right_ring="Regal Ring",
        waist="Kentarch Belt +1",
	})

    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
		head="Mummu Bonnet +2",
		legs="Mummu Kecks +2",
		feet="Mummu Gamash. +2",
		right_ear="Digni. Earring",
		right_ring="Mummu Ring",
	})

    sets.engaged.DW.STP.MidHaste = set_combine(sets.engaged.DW.MidHaste, {})

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Taeon Boots", augments={'Accuracy+22','"Dual Wield"+3','DEX+10',}},
		neck="Iskur Gorget",
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Suppanomimi",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
        } -- 27%

    sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
        head="Dampening Tam",
        neck="Combatant's Torque",
        })

    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {
		left_ear="Telos Earring",
        left_ring="Ilabrat Ring",
        right_ring="Regal Ring",
        waist="Kentarch Belt +1",
	})

    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
		head="Mummu Bonnet +2",
		legs="Mummu Kecks +2",
		feet="Mummu Gamash. +2",
		right_ear="Digni. Earring",
		right_ring="Mummu Ring",
	})

    sets.engaged.DW.STP.HighHaste = set_combine(sets.engaged.DW.HighHaste, {})

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = {
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','CHR+3','Accuracy+15','Attack+13',}},
		neck="Iskur Gorget",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Suppanomimi",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
        } -- 11%

    sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
        head="Dampening Tam",
        neck="Combatant's Torque",
        })

    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {
        left_ring="Ilabrat Ring",
        right_ring="Regal Ring",
        waist="Kentarch Belt +1",
	})

    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
		head="Mummu Bonnet +2",
		legs="Mummu Kecks +2",
		feet="Mummu Gamash. +2",
		right_ear="Digni. Earring",
		right_ring="Mummu Ring",
	})

    sets.engaged.DW.STP.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {})

    sets.engaged.DW.MaxHastePlus = set_combine(sets.engaged.DW.MaxHaste, {back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},})
    sets.engaged.DW.LowAcc.MaxHastePlus = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},})
    sets.engaged.DW.MidAcc.MaxHastePlus = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},})
    sets.engaged.DW.HighAcc.MaxHastePlus = set_combine(sets.engaged.DW.HighAcc.MaxHaste, {back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},})
    sets.engaged.DW.STP.MaxHastePlus = set_combine(sets.engaged.DW.STP.MaxHaste, {back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},})


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
	}

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT = set_combine(sets.engaged.DW.LowAcc, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT = set_combine(sets.engaged.DW.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.LowHaste = set_combine(sets.engaged.DW.STP.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MidHaste = set_combine(sets.engaged.DW.STP.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MaxHaste = set_combine(sets.engaged.DW.STP.MaxHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHastePlus = set_combine(sets.engaged.DW.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MaxHastePlus = set_combine(sets.engaged.DW.LowAcc.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHastePlus = set_combine(sets.engaged.DW.MidAcc.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHastePlus = set_combine(sets.engaged.DW.HighAcc.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MaxHastePlus = set_combine(sets.engaged.DW.STP.MaxHastePlus, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Eshmun's Ring", --20
        waist="Gishdubar Sash", --10
        }

    sets.Obi = {waist="Anrin Obi"}
    sets.CP = {back="Mecisto. Mantle"}
    sets.Reive = {neck="Ygnas's Resolve +1"}
	sets.Warp = {
	    left_ring="Warp Ring",
		right_ring="Dim. Ring (Dem)",
		waist="Chr. Bul. Pouch",
		--waist="Liv. Bul. Pouch",
	 }

	sets.Normal = {}
	sets.Hybrid = {
		Main={name="Rostam", bag ="Wardrobe 2"},
		sub="Tauret",
	}
	sets.Leaden = {
		Main={name="Rostam", bag ="Wardrobe 2"},
		sub="Tauret",
	}
	sets.Savage = {
		main="Naegling",
		sub="Gleti's Knife",
	}
	sets.Ranged = {
		Main={name="Rostam", bag ="Wardrobe 2"},
		sub="Nusku Shield",
	}
	sets.DT = {}
	sets.DeathPenalty = {ranged="Death Penalty"}
	sets.Ataktos = {ranged="Ataktos"}
	sets.Fomalhaut = {ranged="Fomalhaut"}
	--sets.Armageddon = {ranged="Armageddon"}
	-- sets.Trials = {
		-- ranged="Ataktos",
		-- main={name="Rostam", bag="Inventory", priority=2},
		-- sub="Gleti's Knife",
	-- }
	-- sets.TH= {
		-- ranged="Fomalhaut",
		-- main={name="Rostam", bag="Inventory"},
		-- sub="Nusku Shield",
		-- head="Wh. Rarab Hat +1",
		-- waist="Chaac Belt",
		-- legs="Volte Hose",
	-- }
	
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
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])

    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- Gear
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
        if player.status ~= 'Engaged' then
            equip(sets.precast.CorsairRoll.Gun)
        end
        if state.LuzafRing.value then
            equip(sets.precast.LuzafRing)
        end
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    end

    if spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
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

--equips TP earring if not Wildfire and Obi or Orph sash for defined elemental WS
function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
        if player.status ~= 'Engaged' then
            equip(sets.precast.CorsairRoll.Gun)
        end
    elseif spell.action_type == 'Ranged Attack' then
        if flurry == 2 then
            equip(sets.precast.RA.Flurry2)
        elseif flurry == 1 then
            equip(sets.precast.RA.Flurry1)
        end
	elseif spell.type == 'WeaponSkill' and spell.english ~= 'Wildfire' then
		if player.tp < 1750 and player.equipment.range:contains("Anarchy +2") then
			equip({left_ear="Moonshade Earring"})
			--windower.add_to_chat(80,"Adding in Moonshade Earring for more TP:"..player.tp)
		elseif player.tp < 2750 and not player.equipment.range:contains("Anarchy +2") then
			--windower.add_to_chat(80,"Adding in Moonshade Earring for more TP:"..player.tp)
			equip({left_ear="Moonshade Earring"})
		end
	end
	
    if elemental_ws:contains(spell.name) then
		if spell.english == 'Leaden Salute' then
			-- Matching double weather (w/o day conflict).
			if spell.element == world.weather_element and get_weather_intensity() == 2 then
               equip({waist="Anrin Obi"})
			-- Target distance under 1.7 yalms.
			elseif spell.target.distance < (1.7 + spell.target.model_size) then
				equip({waist="Orpheus's Sash"})
			-- Matching day and weather.
			elseif spell.element == world.day_element and spell.element == world.weather_element then
				equip({waist="Anrin Obi"})
			-- Target distance under 8 yalms.
			elseif spell.target.distance < (8 + spell.target.model_size) then
				equip({waist="Orpheus's Sash"})
			-- Match day or weather.
			elseif spell.element == world.day_element or spell.element == world.weather_element then
				equip({waist="Anrin Obi"})
			end
		elseif spell.english ~= 'Leaden Salute' then
		-- Target distance under 11 yalms.
			if spell.target.distance < (11 + spell.target.model_size) then
				equip({waist="Orpheus's Sash"})
			end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Equip obi if weather/day matches for Quick Draw.
    if spell.type == 'CorsairShot' then
        if (spell.element == world.day_element or spell.element == world.weather_element) and
        (spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot') then
            equip(sets.Obi)
        end
        if state.QDMode.value == 'Magic Enhance' then
            equip(sets.midcast.CorsairShot.Enhance)
        elseif state.QDMode.value == 'STP' then
            equip(sets.midcast.CorsairShot.STP)
        end
    elseif spell.action_type == 'Ranged Attack' then
        if buffactive['Triple Shot'] then
            equip(sets.TripleShot)
            if buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
                equip(sets.TripleShotCritical)
            end
        elseif buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
            equip(sets.midcast.RA.Critical)
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])

    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and not spell.interrupted then
        display_roll_info(spell)
    end
    if spell.english == "Light Shot" then
        send_command('@timers c "Light Shot ['..spell.target.name..']" 60 down abilities/00195.png')
    end
end

function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
    if S{'flurry'}:contains(buff:lower()) then
        if not gain then
            flurry = nil
            --add_to_chat(122, "Flurry status cleared.")
        end
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

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
    if state.WeaponLock.value == true then
        disable('ranged')
    else
        enable('ranged')
    end

    equip(sets[state.WeaponSet.current])

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    update_combat_form()
    determine_haste_group()
end

function job_update(cmdParams, eventArgs)
    equip(sets[state.WeaponSet.current])
	equip(sets[state.MeleeSet.current])
    handle_equipping_gear(player.status)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Modify the default idle set after it was constructed.
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

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end

        eventArgs.SelectNPCTargets = state.SelectqdTarget.value
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''

    msg = msg .. '[ Offense/Ranged: '..state.OffenseMode.current

    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end

    msg = msg .. '/' ..state.RangedMode.current

    msg = msg .. ' (' ..state.WeaponSet.current .. ') ]'
	
	msg = msg .. ' (' ..state.MeleeSet.current .. ') ]'

    if state.WeaponskillMode.value ~= 'Normal' then
        msg = msg .. '[ WS: '..state.WeaponskillMode.current .. ' ]'
    end

    if state.DefenseMode.value ~= 'None' then
        msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
    end

    if state.Kiting.value then
        msg = msg .. '[ Kiting Mode: ON ]'
    end

    msg = msg .. '[ *'..state.Mainqd.current

    if state.UseAltqd.value == true then
        msg = msg .. '/'..state.Altqd.current
    end

    msg = msg .. ' ('

    if state.QDMode.value then
        msg = msg .. state.QDMode.current .. ') '
    end

    msg = msg .. ']'

    add_to_chat(060, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

--Read incoming packet to differentiate between Haste/Flurry I and II
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
                if param == 845 and flurry ~= 2 then
                    --add_to_chat(122, 'Flurry Status: Flurry I')
                    flurry = 1
                elseif param == 846 then
                    --add_to_chat(122, 'Flurry Status: Flurry II')
                    flurry = 2
                end
            end
        end
    end)

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 11 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 11 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('MaxHastePlus')
        elseif DW_needed > 21 and DW_needed <= 27 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 27 and DW_needed <= 31 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 31 and DW_needed <= 42 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 42 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'qd' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local doqd = ''
        if state.UseAltqd.value == true then
            doqd = state[state.Currentqd.current..'qd'].current
            state.Currentqd:cycle()
        else
            doqd = state.Mainqd.current
        end

        send_command('@input /ja "'..doqd..'" <t>')
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

function define_roll_values()
    rolls = {
        ["Corsair's Roll"] =    {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"] =        {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"] =     {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"] =        {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"] =      {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"] =     {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Drachen Roll"] =      {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"] =       {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"] =       {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"] =        {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"] =      {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"] =     {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"] =      {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"] =    {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"] =    {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Puppet Roll"] =       {lucky=3, unlucky=7, bonus="Pet Magic Attack/Accuracy"},
        ["Gallant's Roll"] =    {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"] =     {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"] =     {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"] =    {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Naturalist's Roll"] = {lucky=3, unlucky=7, bonus="Enh. Magic Duration"},
        ["Runeist's Roll"] =    {lucky=4, unlucky=8, bonus="Magic Evasion"},
        ["Bolter's Roll"] =     {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"] =     {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"] =    {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"] =    {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] =  {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies' Roll"] =      {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"] =      {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] =  {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"] =    {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, '[ Lucky: '..tostring(rollinfo.lucky)..' / Unlucky: '..tostring(rollinfo.unlucky)..' ] '..spell.english..': '..rollinfo.bonus..' ('..rollsize..') ')
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1

    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.english == 'Wildfire' or spell.english == 'Leaden Salute' then
                -- magical weaponskills
                bullet_name = gear.MAbullet
            else
                -- physical weaponskills
                bullet_name = gear.WSbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end

    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]

    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end

    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end

    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
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

windower.register_event('zone change', 
    function()
        send_command('gi ugs true')
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'DNC' then
        set_macro_page(1, 4)
    else
        set_macro_page(1, 4)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end