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
--              [ WIN+Q ]           Quick Draw shot mode selector.
--
--
--  Spells: 
--
--  Weapons:    [ WIN+E/R ]         Cycles between available Weapon Sets
--              [ WIN+W ]           Toggle Ranged Weapon Lock
--
-- CTRL + ;      toggles Luzaf ring, default is on
-- ALT + ;        toggles warp/dem ring and puts on your Chrono bullet pouch on and off.
-- WIN + E     switches through your guns
-- WIN + R    switches through your melee sets
-- WIN + W    locks all your weapons
-- WIN + H     toggles your haste levels (Normal is receiving Haste I, Hi if receiving Haste II)

-- CTRL + F1-8    All your QDs
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
	-- Whether to Quick Draw for damage or for element resistance down
    state.QDMode = M{['description']='Quick Draw Mode', 'Attack', 'Enhance'}
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(true, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)
	
	elemental_ws = S{'Aeolian Edge', 'Leaden Salute', 'Wildfire'}
	
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
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('Normal', 'Acc', 'Critical')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')
	state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi'}

    state.GunSet = M{['description']='Weapon Set', 'DeathPenalty','TPBonus','Fomalhaut'}		-- 'Armageddon'
	state.MeleeSet = M{['description']='Melee Set', 'Leaden','Savage','Multi','Ranged'}		-- 'DT', 'Hybrid', 'Ranged', 'Leaden',
    state.CP = M(false, "Capacity Points Mode")
    state.WeaponLock = M(false, 'Weapon Lock')
	--Whether to equip Warp Ring and Dem Ring
	state.Warp = M(false, "Warp Ring")

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Living Bullet"
    gear.QDbullet = "Living Bullet"
	gear.MDbullet = "Hauksbok Bullet"
    options.ammo_warning_limit = 10

	
    send_command('bind ^; gs c toggle LuzafRing')  			--ctrl ;
	send_command('bind !; gs c toggle Warp')				--alt ;
	
	
	send_command('bind ^= gs c cycle treasuremode')			--ctrl =

    send_command('bind @q gs c cycle QDMode')				--win q
    send_command('bind @e gs c cycle GunSet')				--win e
    send_command('bind @r gs c cycle MeleeSet')				--win r
    send_command('bind @w gs c toggle WeaponLock')			--win w
	send_command('bind @h gs c cycle HasteMode')			--win h

	send_command('bind ^f1 input /ja "Fire Shot" <t>')		--ctrl F1
	send_command('bind ^f2 input /ja "Ice Shot" <t>')		--ctrl F2
	send_command('bind ^f3 input /ja "Wind Shot" <t>')		--ctrl F3
	send_command('bind ^f4 input /ja "Earth Shot" <t>')		--ctrl F4
	send_command('bind ^f5 input /ja "Thunder Shot" <t>')	--ctrl F5
	send_command('bind ^f6 input /ja "Water Shot" <t>')		--ctrl F6
	send_command('bind ^f7 input /ja "Dark Shot" <t>')		--ctrl F7
	send_command('bind ^f8 input /ja "Light Shot" <t>')		--ctrl F8
    

    select_default_macro_book()
    set_lockstyle()

    Haste = 0
    DW_needed = 0
    DW = false
    --moving = false
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
	send_command('unbind !;')
	send_command('unbind ![')
	send_command('unbind !]')
    send_command('unbind ^[')
    send_command('unbind ^]')
    send_command('unbind ^,')
	send_command('unbind ^;')
    send_command('unbind @c')
    send_command('unbind @q')
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @r')
	send_command('unbind @f')
	send_command('unbind @h')
	send_command('unbind @m')
	send_command('unbind @n')
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
	
	send_command('unbind ^!@f1')
	send_command('unbind ^!@f2')
	send_command('unbind ^!@f3')
	send_command('unbind ^!@f4')
	send_command('unbind ^!@f5')
	send_command('unbind ^!@f6')
	send_command('unbind ^!@f7')
	send_command('unbind ^!@f8')
	send_command('unbind ^!@f9')
	send_command('unbind ^!@f10')
	send_command('unbind ^!@f11')
	send_command('unbind ^!@f12')
	
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
	
	send_command('unbind ^!1')
	send_command('unbind ^!2')
	send_command('unbind ^!3')
	send_command('unbind ^!4')
	send_command('unbind ^!5')
	send_command('unbind ^!6')
	send_command('unbind ^!7')
	send_command('unbind ^!8')
	send_command('unbind ^!9')
	send_command('unbind ^!0')

end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.TreasureHunter = {}
	
    sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +3"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}

    sets.precast.CorsairRoll = {
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
		back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Mag. Evasion+15',}},
        }

    sets.precast.CorsairRoll.Gun = set_combine(sets.precast.CorsairRoll.Engaged, {range="Compensator",main={ name="Rostam", augments={'Path: C',}},})
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes +1"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes +1"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +1"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})

    sets.precast.LuzafRing = set_combine(sets.precast.CorsairRoll, {right_ring="Luzaf's Ring"})
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}

    sets.precast.Waltz = {
        --body="Passion Jacket",
        --neck="Phalaina Locket",
        ring1="Asklepian Ring",
        --waist="Gishdubar Sash",
        }

    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.FC = {
		-- head={ name="Herculean Helm", augments={'MND+7','Pet: Haste+3','"Fast Cast"+8','Accuracy+5 Attack+5','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},		--15
		-- body={ name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4',}},													--10
		-- hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},									--8
		-- legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+13','"Fast Cast"+6','MND+2',}},														--6
		-- feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},															--8
		-- neck="Baetyl Pendant",																															--4
		-- left_ear="Loquac. Earring",																														--2
		-- right_ear="Enchntr. Earring +1",																												--2
		-- left_ring="Rahab Ring",																															--2
		-- right_ring="Kishar Ring",																														--4
		-- back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Mag. Evasion+15',}},								--10
		
		head="Haruspex Hat",
		ear2="Loquacious Earring",
		hands="Thaumas Gloves",
		ring1="Prolix Ring"
        }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        body="Passion Jacket",
		neck="Magoraga Beads",
        -- ring1="Lebeche Ring",
        })

    -- (10% Snapshot from JP Gifts)
    sets.precast.RA = {
        ammo=gear.RAbullet,
		-- head={ name="Taeon Chapeau", augments={'Rng.Acc.+13 Rng.Atk.+13','"Snapshot"+5','"Snapshot"+5',}}, 	--10/0
		-- body="Laksa. Frac +3",																				--0/20
		-- hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},	--8/11
		-- legs="Laksa. Trews +3",																				--15/0
		-- feet="Meg. Jam. +2",																				--10/0
		-- neck="Comm. Charm +2",																				--4/0
		-- waist="Impulse Belt",																				--3/0
		-- back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Snapshot"+10',}},	--10/0
		
	    head="Oshosi Mask +1",
		body="Oshosi Vest +1",
		hands="Oshosi Gloves +1",
		legs="Osh. Trousers +1",
		feet="Osh. Leggings +1",
		neck="Scout's Gorget +1",
		waist="Yemaya Belt",
		left_ear="Enervating Earring",
		right_ear="Telos Earring",
		left_ring="Dingir Ring",
		right_ring="Defending Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
      }

    sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
		-- legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},					--10/13
		-- feet="Pursuer's Gaiters", 																			--0/10
        })

    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
		-- head="Chass. Tricorne +1",																			--0/14
		-- waist="Yemaya Belt",																				--0/5
        })


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
		ammo=gear.WSbullet,
		-- head={ name="Lanun Tricorne +3", augments={'Enhances "Winning Streak" effect',}},
		-- body="Laksa. Frac +3",
		-- hands="Meg. Gloves +2",
		-- legs={ name="Lanun Trews +3", augments={'Enhances "Snake Eye" effect',}},
		-- feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		-- neck="Fotia Gorget",
		-- waist="Fotia Belt",
		-- left_ear="Telos Earring",
		-- right_ear="Ishvara Earring",
		-- left_ring="Regal Ring",
		-- right_ring="Epaminondas's Ring",
		-- back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
		
        head="Whirlpool Mask",
		neck="Fotia Gorget",
		ear1="Bladeborn Earring",
		ear2="Steelflash Earring",
        body="Laksamana's Frac +3",
		hands="Iuitl Wristbands",
		ring1="Rajas Ring",
		ring2="Epona's Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
		waist="Fotia Belt",
		legs="Manibozho Brais",
		feet="Iuitl Gaiters +1"
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
		head={ name="Lanun Tricorne +3", augments={'Enhances "Winning Streak" effect',}},
		ear1="Ishvara Earring",
		body="Laksa. Frac +3",
		hands="Meg. Gloves +2",
		ring1="Dingir Ring",
		ring2="Epaminondas's Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+15 Rng.Atk.+15','Weapon skill damage +10%',}},
		legs="Nahtirah Trousers",
		feet="Iuitl Gaiters +1"
	})

    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
        -- neck="Iskur Gorget",
		
		head="Malignance Chapeau",
		body="Laksa. Frac +3",
		hands="Meg. Gloves +2",
		legs={ name="Herculean Trousers", augments={'Rng.Acc.+28','Weapon skill damage +5%','AGI+3',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		right_ear="Ishvara Earring",
		left_ring="Dingir Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    })
		
    sets.precast.WS['Wildfire'] = {
		ammo=gear.MAbullet,
		-- head="Nyame Helm",
		-- body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		-- hands="Nyame Gauntlets",
		-- legs="Nyame Flanchard",
		-- feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		-- neck="Comm. Charm +2",
		-- waist="Skrymir Cord +1",
		-- left_ear="Crematio Earring",
		-- right_ear="Friomisi Earring",
		-- left_ring="Dingir Ring",
		-- right_ring="Epaminondas's Ring",
		-- back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
		
		head="Nyame Helm",
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'Pet: STR+5','"Mag.Atk.Bns."+20','Accuracy+20 Attack+20','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Novio Earring",
		right_ear="Friomisi Earring",
		left_ring="Dingir Ring",
		right_ring="Epaminondas's Ring",
		back="Gunslinger's Cape",
    }

    sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']

    sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], {
        head="Pixie Hairpin +1",
        right_ring="Archon Ring",
    })

	sets.precast.WS['Split Shot'] = {
		ammo=gear.WSbullet,
		-- head="Mummu Bonnet +2",
		-- body="Mummu Jacket +2",
		-- hands="Mummu Wrists +2",
		-- legs="Mummu Kecks +2",
		-- feet="Mummu Gamash. +2",
		-- neck="Comm. Charm +2",
		-- waist="K. Kachina Belt +1",
		-- left_ear="Telos Earring",
		-- right_ear="Enervating Earring",
		-- left_ring="Longshot Ring",
		-- right_ring="Cacoethic Ring +1",
		-- back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Damage taken-5%',}},
	}

    sets.precast.WS['Evisceration'] = {}

    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
   		-- head={ name="Herculean Helm", augments={'Accuracy+25 Attack+25','Weapon skill damage +3%','STR+10','Attack+14',}},
		-- legs={ name="Herculean Trousers", augments={'Mag. Acc.+2','Weapon skill damage +4%','STR+15','"Mag.Atk.Bns."+7',}},
		-- neck="Comm. Charm +2",
		-- waist="Sailfi Belt +1",
		-- left_ear="Brutal Earring",
		-- back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		
		head="Malignance Chapeau",
		body="Lanun Frac +3",
		hands="Meg. Gloves +2",
		legs={ name="Herculean Trousers", augments={'Rng.Acc.+28','Weapon skill damage +5%','AGI+3',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    })

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
	})
	
	sets.precast.WS['Circle Blade'] = set_combine(sets.precast.WS['Savage Blade'], {
    })
	
	sets.precast.WS['Viper Bite'] = set_combine(sets.precast.WS, {
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Combatant's Torque",
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Odr Earring",
		left_ring={ name="Cacoethic Ring +1", augments={'Path: A',}},
		right_ring="Chirich Ring +1",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Swift Blade'], {
        left_ring="Rufescent Ring",
    }) --MND

    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {
        head="Meghanada Visor +2",
        right_ear="Cessance Earring",
    })

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Wildfire'], {})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        legs="Carmine Cuisses +1", --20
        left_ring="Evanescence Ring", --5
        }

    sets.midcast.Cure = {}

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.precast.CorsairShot = {
        ammo=gear.MDbullet,
		-- head={ name="Herculean Helm", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Enmity-4','MND+5','Mag. Acc.+11','"Mag.Atk.Bns."+15',}},
		-- body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		-- hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		-- legs={ name="Herculean Trousers", augments={'"Store TP"+4','"Mag.Atk.Bns."+30','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
		-- feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		-- neck="Baetyl Pendant",
		-- waist="Skrymir Cord +1",
		-- left_ear="Crematio Earring",
		-- right_ear="Friomisi Earring",
		-- left_ring="Dingir Ring",
		-- right_ring="Metamor. Ring +1",
		-- back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
		
        head="Laksa. Tricorne +1",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		ear1="Friomisi Earring",
		ear2="Hecate's Earring",
        body="Lanun Frac +3",
		hands="Schutzen Mittens",
		ring1="Hajduk Ring",
		ring2="Demon's Ring",
        back="Gunslinger's Cape",
		waist="Aquiline Belt",
		legs="Iuitl Tights",
		feet="Chass. Bottes +1"
        }

    sets.precast.CorsairShot.Resistant = set_combine(sets.midcast.CorsairShot, {
		ammo=gear.QDbullet,
        head="Laksa. Tricorne +1",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		ear1="Lifestorm Earring",
		ear2="Psystorm Earring",
        body="Lanun Frac +3",
		hands="Schutzen Mittens",
		ring1="Stormsoul Ring",
		ring2="Sangoma Ring",
        back="Gunslinger's Cape",
		waist="Aquiline Belt",
		legs="Iuitl Tights",
		feet="Laksa. Bottes  +2"
        })

    sets.precast.CorsairShot['Light Shot'] = sets.precast.CorsairShot.Resistant
    sets.precast.CorsairShot['Dark Shot'] = sets.precast.CorsairShot.Resistant
    sets.precast.CorsairShot.Enhance = set_combine(sets.precast.CorsairShot, {
		body="Mirke Wardecors", 
		feet="Chass. Bottes +1"
		})

    -- Ranged gear
    sets.midcast.RA = {
        ammo=gear.RAbullet,
		-- head="Malignance Chapeau",
		-- body="Malignance Tabard",
		-- hands="Malignance Gloves",
		-- legs="Malignance Tights",
		-- feet="Malignance Boots",
		-- neck="Iskur Gorget",
		-- waist="Yemaya Belt",
		-- left_ear="Telos Earring",
		-- right_ear="Enervating Earring",
		-- left_ring="Dingir Ring",
		-- right_ring="Ilabrat Ring",
		-- back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Damage taken-5%',}},
		
        head="Malignance Chapeau",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		ear1="Telos Earring",
		ear2="Enervating Earring",
        body="Laksamana's Frac +3",
		hands="Malignance Gloves",
		ring1="Cacoethic Ring",
		ring2="Cacoethic Ring +1",
        back="Gunslinger's Cape",
		waist="K. Kachina Belt +1",
		legs="Nahtirah Trousers",
		feet="Iuitl Gaiters +1"
        }

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		waist="K. Kachina Belt +1",
		left_ring="Cacoethic Ring +1",
        })

    sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {
        -- head="Mummu Bonnet +2",
        -- body="Mummu Jacket +2",
        -- hands="Mummu Wrists +2",
        -- legs="Mummu Kecks +2",
        -- feet="Osh. Leggings +1",
        -- waist="K. Kachina Belt +1",
        -- left_ring="Mummu Ring",
		-- --right_ring="Begrudging Ring",
		-- right_ear="Odr Earring",
		-- back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','Crit.hit rate+10','Mag. Evasion+15',}},
        })

    sets.TripleShot = set_combine(sets.midcast.RA, {
        head="Oshosi Mask +1", --4
        body="Chasseur's Frac +1", --12
        hands="Lanun Gants +3",
        legs="Oshosi Trousers +1", --5
        feet="Oshosi Leggings +1", --2
        }) --27

    sets.TripleShotCritical = set_combine(sets.TripleShot, {
		head="Mummu Bonnet +2",
        waist="K. Kachina Belt +1",
		right_ear="Odr Earring",
		left_ring="Mummu Ring",
		--right_ring="Begrudging Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','Crit.hit rate+10','Mag. Evasion+15',}},
        })


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = {}

    sets.idle = {
		ammo=gear.RAbullet,
		-- head="Nyame Helm",   
		-- body="Nyame Mail",
		-- hands="Nyame Gauntlets",
		-- legs="Nyame Flanchard",
		-- --legs="Carmine Cuisses +1",
		-- feet="Nyame Sollerets",
		-- neck="Warder's Charm +1",
		-- waist="Flume Belt +1",
		-- left_ear="Eabani Earring",
		-- right_ear="Sanare Earring",
		-- left_ring="Defending Ring",
		-- right_ring="Fortified Ring",
		-- back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Mag. Evasion+15',}},
		
        head="Malignance Chapeau",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		ear1="Telos Earring",
		ear2="Volley Earring",
        body="Iuitl Vest",
		hands="Malignance Gloves",
		ring1="Sheltered Ring",
		ring2="Paguroidea Ring",
        back="Shadow Mantle",
		waist="Flume Belt",
		legs="Carmine Cuisses +1",
		feet="Lanun Bottes +3"
    }

    sets.idle.DT = set_combine(sets.idle, {
		ammo=gear.RAbullet,
		-- head="Nyame Helm",   
		-- body="Nyame Mail",
		-- hands="Nyame Gauntlets",
		-- legs="Nyame Flanchard",
		-- feet="Nyame Sollerets",
		-- neck="Warder's Charm +1",
		-- waist="Flume Belt +1",
		-- left_ear="Eabani Earring",
		-- right_ear="Sanare Earring",
		-- left_ring="Defending Ring",
		-- right_ring="Fortified Ring",
		-- back={ name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Mag. Evasion+15',}},
		
		head="Herculean Helm",
		neck="Twilight Torque",
		ear1="Clearview Earring",
		ear2="Volley Earring",
        body="Iuitl Vest",
		hands="Iuitl Wristbands",
		ring1="Defending Ring",
		ring2="Dark Ring",
        back="Shadow Mantle",
		waist="Flume Belt",
		legs="Carmine Cuisses +1",
		feet="Malignance Boots"
	})
	
    sets.idle.Town = set_combine(sets.idle, {legs="Carmine Cuisses +1"})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- No Magic Haste (74% DW to cap)
    sets.engaged = {
		-- head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		-- body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		-- hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		-- legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		-- feet={ name="Herculean Boots", augments={'"Triple Atk."+4','CHR+3','Accuracy+15','Attack+13',}},
		-- neck="Combatant's Torque",
		-- waist="Windbuffet Belt +1",
		-- left_ear="Telos Earring",
		-- right_ear="Cessance Earring",
		-- left_ring="Chirich Ring +1",
		-- right_ring="Epona's Ring",
		-- back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		
	    head="Malignance Chapeau",
		body="Lanun Frac +3",
		hands="Malignance Gloves",
		feet="Malignance Boots",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Suppanomimi",
		left_ring="Epona's Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
        }

    sets.engaged.MidAcc = set_combine(sets.engaged, {
		-- head="Dampening Tam",
        -- left_ring="Ilabrat Ring",
        -- right_ring="Regal Ring",
        -- waist="Kentarch Belt +1",
		
	    head="Malignance Chapeau",
		body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Malignance Boots",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Cacoethic Ring",
		right_ring="Cacoethic Ring +1",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
        })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
		-- head="Mummu Bonnet +2",
		-- legs="Mummu Kecks +2",
		-- feet="Mummu Gamash. +2",
		-- right_ear="Digni. Earring",
		-- right_ring="Mummu Ring",
	})

    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.Haste_15 = set_combine(sets.engaged, {
		-- head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		-- body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		-- hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
		-- legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		-- feet={ name="Taeon Boots", augments={'Accuracy+22','"Dual Wield"+3','DEX+10',}},
		-- neck="Iskur Gorget",
		-- waist="Reiki Yotai",
		-- left_ear="Eabani Earring",
		-- right_ear="Suppanomimi",
		-- left_ring="Chirich Ring +1",
		-- right_ring="Epona's Ring",
		-- back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}) -- 42%


    sets.engaged.MidAcc.Haste_15 = set_combine(sets.engaged.Haste_15, {
		-- left_ear="Telos Earring",
        -- left_ring="Ilabrat Ring",
        -- right_ring="Regal Ring",
        -- waist="Kentarch Belt +1",
	})

    sets.engaged.HighAcc.Haste_15 = set_combine(sets.engaged.MidAcc.Haste_15, {
		-- head="Mummu Bonnet +2",
		-- hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		-- legs="Mummu Kecks +2",
		-- feet="Mummu Gamash. +2",
		-- right_ear="Digni. Earring",
		-- right_ring="Mummu Ring",
	})

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.Haste_30 = set_combine(sets.engaged, {
		-- head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		-- body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		-- hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		-- legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		-- feet={ name="Taeon Boots", augments={'Accuracy+22','"Dual Wield"+3','DEX+10',}},
		-- neck="Iskur Gorget",
		-- waist="Reiki Yotai",
		-- left_ear="Eabani Earring",
		-- right_ear="Suppanomimi",
		-- left_ring="Chirich Ring +1",
		-- right_ring="Epona's Ring",
		-- back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	})-- 31%

    sets.engaged.MidAcc.Haste_30 = set_combine(sets.engaged.Haste_30, {
		-- left_ear="Telos Earring",
        -- left_ring="Ilabrat Ring",
        -- right_ring="Regal Ring",
        -- waist="Kentarch Belt +1",
	})

    sets.engaged.HighAcc.Haste_30 = set_combine(sets.engaged.MidAcc.Haste_30, {
		-- head="Mummu Bonnet +2",
		-- legs="Mummu Kecks +2",
		-- feet="Mummu Gamash. +2",
		-- right_ear="Digni. Earring",
		-- right_ring="Mummu Ring",
	})

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.MaxHaste = set_combine(sets.engaged, {
		-- head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		-- body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		-- hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		-- legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		-- feet={ name="Herculean Boots", augments={'"Triple Atk."+4','CHR+3','Accuracy+15','Attack+13',}},
		-- neck="Iskur Gorget",
		-- waist="Windbuffet Belt +1",
		-- left_ear="Telos Earring",
		-- right_ear="Suppanomimi",
		-- left_ring="Chirich Ring +1",
		-- right_ring="Epona's Ring",
		-- back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
        }) -- 11%

    sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.MaxHaste, {
        -- left_ring="Ilabrat Ring",
        -- right_ring="Regal Ring",
        -- waist="Kentarch Belt +1",
	})

    sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, {
		-- head="Mummu Bonnet +2",
		-- legs="Mummu Kecks +2",
		-- feet="Mummu Gamash. +2",
		-- right_ear="Digni. Earring",
		-- right_ring="Mummu Ring",
	})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
		-- head="Malignance Chapeau",
		-- body="Malignance Tabard",
		-- hands="Malignance Gloves",
		-- legs="Malignance Tights",
		-- feet="Malignance Boots",
	}

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DT.Haste_15 = set_combine(sets.engaged.Haste_15, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.Haste_15 = set_combine(sets.engaged.MidAcc.Haste_15, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.Haste_15 = set_combine(sets.engaged.HighAcc.Haste_15, sets.engaged.Hybrid)

    sets.engaged.DT.Haste_30 = set_combine(sets.engaged.Haste_30, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.Haste_30 = set_combine(sets.engaged.MidAcc.Haste_30, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.Haste_30 = set_combine(sets.engaged.HighAcc.Haste_30, sets.engaged.Hybrid)

    sets.engaged.DT.HighHaste = set_combine(sets.engaged.HighHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.HighHaste = set_combine(sets.engaged.HighAcc.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste, sets.engaged.Hybrid)

    sets.engaged.DT.MaxHastePlus = set_combine(sets.engaged.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.MaxHastePlus = set_combine(sets.engaged.MidAcc.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.MaxHastePlus = set_combine(sets.engaged.HighAcc.MaxHastePlus, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Eshmun's Ring", --20
        waist="Gishdubar Sash", --10
    }

	sets.FullTP = {
		-- ear1="Crematio Earring"
	}

    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}
	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.Warp = {
	    left_ring="Warp Ring",
		right_ring="Dim. Ring (Dem)",
		waist="Chr. Bul. Pouch",
		--waist="Liv. Bul. Pouch",
	 }

	sets.Normal = {}
	sets.Leaden = {
		main={ name="Rostam", augments={'Path: A',}},
		sub="Tauret",
	}
	sets.Savage = {
		main="Naegling",
		sub="Gleti's Knife",
	}
	sets.Ranged = {
		main={ name="Rostam", augments={'Path: A',}},
		sub="Nusku Shield",
	}
	sets.Multi = {
		main={ name="Rostam", augments={'Path: B',}},
		sub="Gleti's Knife",
	}
	sets.DeathPenalty = {ranged="Death Penalty"}
	sets.TPBonus = {ranged="Anarchy +2"}
	sets.Fomalhaut = {ranged="Fomalhaut"}
	sets.Armageddon = {ranged="Armageddon"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_precast(spell, action, spellMap, eventArgs)
    equip(sets[state.GunSet.current])
	
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

    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- if spell.type:lower() == 'weaponskill' then
        -- if player.tp < 1000 then
            -- eventArgs.cancel = true
            -- return
        -- end
        -- if ((spell.target.distance >8 and spell.skill ~= 'Marksmanship') or (spell.target.distance >21)) then
            -- -- Cancel Action if distance is too great, saving TP
            -- add_to_chat(122,"Outside WS Range! /Canceling")
            -- eventArgs.cancel = true
            -- return

        -- -- elseif state.DefenseMode.value ~= 'None' then
            -- -- -- Don't gearswap for weaponskills when Defense is on.
            -- -- eventArgs.handled = true
        -- end
	-- end

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
    elseif spell.type == 'WeaponSkill' then
        -- Replace TP-bonus gear if not needed.
        if spell.english ~= 'Wildfire' then
            if player.tp < 1750 and player.equipment.range:contains("Anarchy +2") then
				equip({left_ear="Moonshade Earring"})
				--windower.add_to_chat(80,"Adding in Moonshade Earring for more TP:"..player.tp)
			elseif player.tp < 2750 and not player.equipment.range:contains("Anarchy +2") then
				--windower.add_to_chat(80,"Adding in Moonshade Earring for more TP:"..player.tp)
				equip({left_ear="Moonshade Earring"})
			end
        end
        if elemental_ws:contains(spell.name) then
            -- -- Matching double weather (w/o day conflict).
            -- if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                -- equip({waist="Hachirin-no-Obi"})
            -- -- Target distance under 1.7 yalms.
            -- elseif spell.target.distance < (1.7 + spell.target.model_size) then
                -- equip({waist="Orpheus's Sash"})
            -- -- Matching day and weather.
            -- elseif spell.element == world.day_element and spell.element == world.weather_element then
                -- equip({waist="Hachirin-no-Obi"})
            -- -- Target distance under 8 yalms.
            -- elseif spell.target.distance < (8 + spell.target.model_size) then
                -- equip({waist="Orpheus's Sash"})
            -- -- Match day or weather.
            if spell.element == world.day_element or spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            end
        end
    end
	
	if spell.name == 'Spectral Jig' and buffactive.sneak then
		-- If sneak is active when using, cancel before completion
        send_command('cancel 71')
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' then
		if (spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot') then
			-- Matching double weather (w/o day conflict).
			-- if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
				-- equip({waist="Hachirin-no-Obi"})
			-- -- Target distance under 1.7 yalms.
			-- elseif spell.target.distance < (1.7 + spell.target.model_size) then
				-- equip({waist="Orpheus's Sash"})
			-- -- Matching day and weather.
			-- elseif spell.element == world.day_element and spell.element == world.weather_element then
				-- equip({waist="Hachirin-no-Obi"})
			-- -- Target distance under 8 yalms.
			-- elseif spell.target.distance < (8 + spell.target.model_size) then
				-- equip({waist="Orpheus's Sash"})
			-- -- Match day or weather.
			if spell.element == world.day_element or spell.element == world.weather_element then
				equip({waist="Hachirin-no-Obi"})
			end
		end
        if state.QDMode.value == 'Enhance' then
            equip(sets.precast.CorsairShot.Enhance)
        elseif state.QDMode.value == 'TH' then
            equip(sets.precast.CorsairShot)
            equip(sets.TreasureHunter)
        elseif state.QDMode.value == 'STP' then
            equip(sets.precast.CorsairShot.STP)
        end
    elseif spell.action_type == 'Ranged Attack' then
        if buffactive['Triple Shot'] then
            if buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
                equip(sets.TripleShotCritical)
			else
				equip(sets.TripleShot)
            end
        elseif buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
            equip(sets.midcast.RA.Critical)
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    equip(sets[state.GunSet.current])

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

	if buffactive['sleep'] or buffactive['lullaby'] or buffactive['stun'] or buffactive['terror'] or buffactive['petrification'] then
		if gain then
			equip(sets.idle.DT)
			add_to_chat(123, '**!! [ASLEEP / STUNED / TERRORIZED / PETRIFIED] !!**')
		else
			handle_equipping_gear(player.status)
		end
	end
	
	-- if buffactive['Defense Down'] then
		-- if gain then
			-- send_command('input /item "Panacea" <me>')
		-- end
	-- end

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
        disable('main')
		disable('sub')
		disable('ranged')
    else
        enable('main')
		enable('sub')
		enable('ranged')
    end
	
	equip(sets[state.GunSet.current])
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
    equip(sets[state.GunSet.current])
	equip(sets[state.MeleeSet.current])
    handle_equipping_gear(player.status)
end

function update_combat_form()
    state.CombatForm:reset()
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
	
	if world.area:contains('Echoes') then
		idleSet = set_combine(idleSet, {legs="Carmine Cuisses +1"})
	elseif world.area:contains('Adoulin') or world.area == "Celennia Memorial Library" then
		idleSet = set_combine(idleSet, {body="Councilor's Garb"})
	elseif world.area == "Mog Garden" then
		idleSet = set_combine(idleSet, {body="Jubilee Shirt"})
	end
		
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''

    msg = msg .. '[ Offense/Ranged: '..state.OffenseMode.current

    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end

    msg = msg .. '/' ..state.RangedMode.current

    msg = msg .. ' (' ..state.GunSet.current .. ') ]'
	
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
            --add_to_chat(8, '-------------Max-Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( ( buffactive[580] or buffactive[33] or buffactive.march == 2 ) or
                ( buffactive.march == 1 and buffactive[604] ) ) then
            --add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif ( buffactive.march == 1 or buffactive[604] ) then
            --add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    else
        if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
            ( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
            ( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
            ( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches
            --add_to_chat(8, '-------------Max Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( buffactive.march == 2 ) or -- two marches from ghorn
            ( (buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
            ( buffactive[580] ) or  -- geo haste
            ( buffactive[33] and buffactive[604] ) then  -- haste with MG
            --add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            --add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
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
        bullet_name = gear.MDbullet
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
    if spell.type ~= 'CorsairShot' and bullet_name == gear.MDbullet and available_bullets.count <= bullet_min_count then
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
        set_macro_page(1, 7)
    else
        set_macro_page(1, 7)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end