-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+F ]           Toggle Closed Position (Facing) Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--				[ WIN+H ]			Toggle Current Haste Value (Normal = Haste 1, Hi = Haste 2)
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)

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
    state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false

    state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi'}
	state.Moving   	= M(true)
	state.MoveSpeed = M(true, "MoveSpeed")
	
    state.ClosedPosition = M(false, 'Closed Position')

--  state.SkillchainPending = M(false, 'Skillchain Pending')

    state.CP = M(false, "Capacity Points Mode")
	
	elemental_ws = S{'Gust Slash', 'Cyclone', 'Aeolian Edge'}

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    lockstyleset = 60
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc', 'Critical')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal', 'DT')

	-- Additional local binds
	--  include('Global-Binds.lua') -- OK to remove this line
	--  include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('lua l gearinfo')

	send_command('bind @m gs c toggle MoveSpeed')
	send_command('bind @h gs c cycle HasteMode')
    send_command('bind @f gs c toggle ClosedPosition')
    --send_command('bind @c gs c toggle CP')


	select_default_macro_book()
    set_lockstyle()
	
    update_combat_form()
    determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^]')
    send_command('unbind ^[')
    send_command('unbind ^]')
    send_command('unbind ![')
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^,')
    send_command('unbind @f')
    send_command('unbind @c')
	send_command('unbind @h')
    send_command('unbind ^numlock')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad+')
    send_command('unbind ^numpadenter')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad1')
    send_command('unbind numpad0')
    send_command('unbind ^numpad0')
    send_command('unbind ^numpad.')

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

    -- Enmity set
    sets.Enmity = {
		-- legs="Zoar Subligar +1",
        ammo="Sapience Orb", --2
        head="Halitus Helm", --8
        body="Emet Harness +1", --10
        hands="Horos Bangles +3", --9
        feet="Ahosi Leggings", --7
        neck="Unmoving Collar +1", --10
        ear1="Cryptic Earring", --4
        ear2="Trux Earring", --5
        ring1="Pernicious Ring", --5
        ring2="Eihwaz Ring", --5
        back="Fravashi Mantle", --10
        waist="Kasiri Belt", --3
        }

    sets.precast.JA['Provoke'] = sets.Enmity
    sets.precast.JA['No Foot Rise'] = {body="Horos Casaque +3"}
    sets.precast.JA['Trance'] = {head="Horos Tiara +3"}

    sets.precast.Waltz = {
		-- ammo="Voluspa Tathlum",
        -- head="Anwig Salade",
		-- hands="Regal Gloves",
		-- hands="Horos Bangles +3",
		-- ear1="Handler's Earring +1",
        head="Maxixi Tiara +2",
        body="Maxixi Casaque +2", --17
        hands={ name="Gazu Bracelet +1", augments={'Path: A',}},
        legs="Dashing Subligar", --10
        feet="Maxixi Toeshoes +2", --12
        neck="Etoile Gorget +2", --7
        ear2="Enchntr. Earring +1",
        ring1="Carb. Ring +1",
        ring2="Metamor. Ring +1",
        back={ name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
        waist="Aristo Belt",
        ammo="Yamarang", --5
        } -- Waltz Potency/CHR

    sets.precast.WaltzSelf = set_combine(sets.precast.Waltz, {ring1="Asklepian Ring",}) -- Waltz effects received

    sets.precast.Waltz['Healing Waltz'] = {}
    sets.precast.Samba = {head="Maxixi Tiara +2", back={ name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},}
    sets.precast.Jig = {legs="Horos Tights +3", feet="Maxixi Toeshoes +2"}

    sets.precast.Step = {
		-- ring2="Cacoethic Ring +1",
        ammo="C. Palug Stone",
        head="Maxixi Tiara +2",
        body="Maxixi Casaque +2",
        hands="Maxixi Bangles +2",
        legs="Meg. Chausses +2",
        feet="Horos T. Shoes +3",
        neck="Etoile Gorget +2",
        ear1="Mache Earring +1",
        ear2="Telos Earring",
        ring1="Regal Ring",
        ring2="Chirich Ring +1",
        waist="Olseni Belt",
        back={ name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
        }

    sets.precast.Step['Feather Step'] = set_combine(sets.precast.Step, {feet="Macu. Toeshoes +1"})
    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Animated Flourish'] = sets.Enmity

    sets.precast.Flourish1['Violent Flourish'] = {
        ammo="Yamarang",
        head="Malignance Chapeau",
        body="Horos Casaque +3",
		hands="Nyame Gauntlets",
        legs={ name="Horos Tights +3", augments={'Enhances "Saber Dance" effect',}},
        feet="Nyame Sollerets",
        neck="Etoile Gorget +2",
        ear1="Digni. Earring",
        ear2="Enchntr. Earring +1",
        ring1="Metamor. Ring +1",
        ring2="Weather. Ring",
        waist="Eschan Stone",
        back={ name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
        } -- Magic Accuracy

    sets.precast.Flourish1['Desperate Flourish'] = {
        ammo="C. Palug Stone",
        head="Malignance Chapeau",
        body="Horos Casaque +3",
        hands={ name="Gazu Bracelet +1", augments={'Path: A',}},
        legs="Meg. Chausses +2",
        feet="Maxixi Toeshoes +2",
        neck="Etoile Gorget +2",
        ear1="Cessance Earring",
        ear2="Telos Earring",
        ring1="Regal Ring",
        ring2="Chirich Ring +1",
        back={ name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
        } -- Accuracy

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {hands="Macu. Bangles +1",    back="Toetapper Mantle"}
    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {body="Macu. Casaque +1"}
    sets.precast.Flourish3['Climactic Flourish'] = {head="Maculele Tiara +1",}

    sets.precast.FC = {
        }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        ammo="Impatiens",
        body="Passion Jacket",
        ring1="Lebeche Ring",
        })


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
		-- hands="Maxixi Bangles +3",
        -- neck="Fotia Gorget",
        -- waist="Fotia Belt",
		-- ear2="Moonshade Earring",
        ammo="C. Palug Stone",
        head="Mummu Bonnet +2",
        body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
		hands="Meg. Gloves +2",
        legs="Horos Tights +3",
        feet={ name="Horos T. Shoes +3", augments={'Enhances "Closed Position" effect',}},
		neck="Etoile Gorget +2",
        ear1="Sherida Earring",
		right_ear="Brutal Earring",
        ring1="Regal Ring",
        ring2="Mummu Ring",
        back={ name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
		waist="Grunfeld Rope",
        } -- default set

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        ear1="Telos Earring",
        })

    sets.precast.WS.Critical = {body="Meg. Cuirie +2"}

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
        body="Meg. Cuirie +2",
        legs="Meg. Chausses +2",
        feet="Meg. Jam. +2",
        ear1="Sherida Earring",
        ear2="Brutal Earring",
        })

    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {
        body="Horos Casaque +3",
        ear1="Telos Earring",
        })
		
    sets.precast.WS['Exenterator'].Critical = set_combine(sets.precast.WS['Exenterator'], {
        })

    sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {
        --ear2="Mache Earring +1",
        feet={ name="Herculean Boots", augments={'Enmity+4','MND+1','Weapon skill damage +6%','Accuracy+9 Attack+9',}},
        -- feet={ name="Herculean Boots", augments={'DEX+8','Accuracy+4 Attack+4','Weapon skill damage +3%','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
        -- ring1="Gere Ring",
        -- ring2="Epona's Ring",
        })

    sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS['Pyrrhic Kleos'], {
        })
		
    sets.precast.WS['Pyrrhic Kleos'].Critical = set_combine(sets.precast.WS['Pyrrhic Kleos'], {
        })

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		-- ammo="Yetshila +1",
        ammo="Charis Feather",
        body="Meg. Cuirie +1",
        legs="Meg. Chausses +2",
        ear2="Mache Earring +1",
        ring2="Mummu Ring",
        })

    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {
        ammo="Voluspa Tathlum",
        head="Dampening Tam",
        body="Horos Casaque +3",
        legs="Meg. Chausses +2",
        feet="Maxixi Toeshoes +2",
        ring1="Regal Ring",
        })
		
    sets.precast.WS['Evisceration'].Critical = set_combine(sets.precast.WS['Evisceration'], {
		})

    sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {
        neck="Etoile Gorget +2",
        -- waist="Artful Belt +1",
        })

    sets.precast.WS['Rudra\'s Storm'].Acc = set_combine(sets.precast.WS['Rudra\'s Storm'], {
        })

    sets.precast.WS['Rudra\'s Storm'].Critical = set_combine(sets.precast.WS['Rudra\'s Storm'], {
        })

    sets.precast.WS['Aeolian Edge'] = {
		-- ammo="Ghastly Tathlum +1", --Augmented
        -- hands="Maxixi Bangles +3",
		-- neck="Baetyl Pendant",
        -- left_ear="Crematio Earring",
        -- right_ear="Friomisi Earring",
        -- rght_ring="Epaminondas's Ring",
        -- waist="Orpheus's Sash",
		ammo="Pemphredo Tathlum",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs={ name="Horos Tights +3", augments={'Enhances "Saber Dance" effect',}},
		feet="Nyame Sollerets",
		neck="Sanctity Necklace",
		left_ear="Enchanter Earring +1",
		right_ear="Hermetic Earring",
		left_ring="Regal Ring",
		right_ring="Metamor. Ring +1",
		waist="Eschan Stone",
		back={ name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
        }

    sets.precast.Skillchain = {
        hands="Macu. Bangles +1",
        legs="Maxixi Tights +2",
        }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Impatiens", --10
        ring1="Evanescence Ring", --5
        }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = {}

    sets.idle = {
        head="Turms Cap +1",
        body="Horos Casaque +3",
        -- hands="Turms Mittens +1",
        -- legs="Turms Subligar +1",
        -- feet="Turms Leggings +1",
       -- body="Malignance Tabard",
        --hands="Turms Mittens +1",
        --legs="Turms Subligar +1",
        --feet="Turms Leggings +1",
        neck="Sanctity Necklace",
        --ear1="Eabani Earring",
        --ear2="Sanare Earring",
        ear1="Infused Earring",
        ear2="Thureous Earring",
        ring2="Chirich Ring +1",
        ring1="Regal Ring",
        back="Senuna's Mantle",
        --back="Moonlight Cape",
        -- waist="Engraved Belt",
        }

    sets.idle.DT = set_combine(sets.idle, {
        -- ammo="Staunch Tathlum +1",
		-- neck="Warder's Charm +1",
		-- left_ring="Purity Ring",
        -- right_ring="Defending Ring",
		-- back="Moonlight Cape",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque",
		left_ear="Etiolation Earring",
        right_ear="Genmei Earring",
		left_ring="Warden's Ring",
        })

    sets.idle.Town = set_combine(sets.idle, {
		body="Councilor's Garb",
        })

    sets.idle.Weak = sets.idle.DT

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Tandava crackows"}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- * DNC Native DW Trait: 30% DW
    -- * DNC Job Points DW Gift: 5% DW

    -- No Magic Haste (74% DW to cap)
    sets.engaged = {
		-- head="Maxixi Tiara +3",
		-- hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		-- legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		-- waist="Windbuffet Belt +1",
		-- left_ring="Epona's Ring",
		-- right_ring="Gere Ring",
        ammo="Aurgelmir Orb",
        head="Malignance Chapeau",
        body="Horos Casaque +3",
        hands="Mummu wrists +1",
        legs="Meg. Chausses +2",
        feet="Horos T. Shoes +3",
        neck="Etoile Gorget +2",
        left_ear="Sherida Earring",
        right_ear="Telos Earring",
        left_ring="Regal Ring",
        right_ring="Hetairoi Ring",
        back={ name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
        waist="Grunfeld rope",
        } -- 41%


    sets.engaged.MidAcc = set_combine(sets.engaged, {
        })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
        ammo="Yamarang",
        head="Turms Cap +1",
        body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
        hands={ name="Gazu Bracelet +1", augments={'Path: A',}},
        legs="Meg. Chausses +2",
        feet="Maxixi Toe Shoes +2",
        neck={ name="Etoile Gorget +2", augments={'Path: A',}},
        waist="Eschan Stone",
        left_ear="Sherida Earring",
        -- left_ear="Odnowa Earring",
        right_ear="Telos Earring",
        left_ring="Regal Ring",
        right_ring="Chirich Ring +1",
        back={ name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
		})

		
	sets.engaged.Critical = set_combine(sets.engaged, {
		ammo="Charis Feather",
		head="Mummu Bonnet +2",
		body="Mummu Jacket +1",
		hands="Mummu Wrists +1",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		left_ring="Mummu Ring",
		waist="Gerdr Belt",
        })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.Haste_15 = set_combine(sets.engaged, {
		-- waist="Reiki Yotai",
		-- left_ear="Eabani Earring",
		right_ear="Suppanomimi",
        })

    sets.engaged.MidAcc.Haste_15 = set_combine(sets.engaged.Haste_15, {
        })

    sets.engaged.HighAcc.Haste_15 = set_combine(sets.engaged.MidAcc.Haste_15, {
        })
		
    sets.engaged.Critical.Haste_15 = set_combine(sets.engaged.Critical, {
		-- left_ear="Eabani Earring",
		right_ear="Suppanomimi",
        })

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.Haste_30 = set_combine(sets.engaged, {
        })

    sets.engaged.MidAcc.Haste_30 = set_combine(sets.engaged.Haste_30, {
        })

    sets.engaged.HighAcc.Haste_30 = set_combine(sets.engaged.MidAcc.Haste_30, {
        })
		
    sets.engaged.Critical.Haste_30 = set_combine(sets.engaged.Critical, {
		-- left_ear="Eabani Earring",
		right_ear="Suppanomimi",
        })

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.MaxHaste = set_combine(sets.engaged, {
        })

    sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.MaxHaste, {
        })

    sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, {
        })
		
    sets.engaged.Critical.MaxHaste = set_combine(sets.engaged.Critical, {
		-- left_ear="Eabani Earring",
		right_ear="Suppanomimi",
        })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
		head="Malignance Chapeau",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
	sets.engaged.Critical.DT = set_combine(sets.engaged.Critical, sets.engaged.Hybrid)

    sets.engaged.DT.Haste_15 = set_combine(sets.engaged.Haste_15, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.Haste_15 = set_combine(sets.engaged.MidAcc.Haste_15, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.Haste_15 = set_combine(sets.engaged.HighAcc.Haste_15, sets.engaged.Hybrid)
    sets.engaged.Critical.DT.Haste_15 = set_combine(sets.engaged.Critical.Haste_15, sets.engaged.Hybrid)

    sets.engaged.DT.Haste_30 = set_combine(sets.engaged.Haste_30, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.Haste_30 = set_combine(sets.engaged.MidAcc.Haste_30, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.Haste_30 = set_combine(sets.engaged.HighAcc.Haste_30, sets.engaged.Hybrid)
    sets.engaged.Critical.DT.Haste_30 = set_combine(sets.engaged.Critical.Haste_30, sets.engaged.Hybrid)

    sets.engaged.DT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.Critical.DT.MaxHaste = set_combine(sets.engaged.Critical.MaxHaste, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff['Saber Dance'] = {legs="Horos Tights +3"}
    sets.buff['Fan Dance'] = {body="Horos Bangles +3"}
    sets.buff['Climactic Flourish'] = {head="Maculele Tiara +1"} --body="Meg. Cuirie +2"}
    sets.buff['Closed Position'] = {feet="Horos T. Shoes +3"}

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
        }

    -- sets.CP = {back="Mecisto. Mantle"}
    -- sets.Reive = {neck="Ygnas's Resolve +1"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    --auto_presto(spell)
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
    if spell.type == "WeaponSkill" then
        -- Replace TP-bonus gear if not needed.
		if player.tp < 2750 then
			equip({left_ear="Moonshade Earring"})
		end
		
		----------------------------------------------------
		--Umcomment these lines when you have Orpheus Sash--
		----------------------------------------------------
        -- if elemental_ws:contains(spell.name) then
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
            -- elseif spell.element == world.day_element or spell.element == world.weather_element then
                -- equip({waist="Hachirin-no-Obi"})
            -- end
        -- end
		
		------------------------------------------------------
		--Remove the next 6 lines when you have Orpheus Sash--
		------------------------------------------------------
		if elemental_ws:contains(spell.name) then
		    -- Match day or weather.
            if spell.element == world.day_element or spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            end
        end
    end
	
	if spell.name == 'Spectral Jig' and buffactive.sneak then
		-- If sneak is active when using, cancel before completion
        send_command('cancel 71')
    end
    if state.Buff['Sneak Attack'] == true then
            equip(sets.precast.WS.Critical)
    end
    if state.Buff['Climactic Flourish'] then
            equip(sets.buff['Climactic Flourish'])
    end
    if spell.type=='Waltz' and spell.english:startswith('Curing') and spell.target.type == 'SELF' then
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

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
    if buff == 'Saber Dance' or buff == 'Climactic Flourish' or buff == 'Fan Dance' then
        handle_equipping_gear(player.status)
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

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
    determine_haste_group()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function update_combat_form()
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
	elseif state.OffenseMode.value == 'Critical' then
		wsmode = 'Critical'
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
    --if state.Buff['Climactic Flourish'] then
    --    meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
    --end
    if state.ClosedPosition.value == true then
        meleeSet = set_combine(meleeSet, sets.buff['Closed Position'])
    end

    return meleeSet
end



-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
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

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

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

function job_self_command(cmdParams, eventArgs)

end


-- Automatically use Presto for steps when it's available and we have less than 3 finishing moves
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        local allRecasts = windower.ffxi.get_ability_recasts()
        local prestoCooldown = allRecasts[236]
        local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']

        if player.main_job_level >= 77 and prestoCooldown < 1 and under3FMs then
            cast_delay(1.1)
            send_command('input /ja "Presto" <me>')
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
    -- Default macro set/book: (set, book)
    if player.sub_job == 'WAR' then
        set_macro_page(8, 3)
    elseif player.sub_job == 'THF' then
        set_macro_page(3, 3)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 3)
    elseif player.sub_job == 'RUN' then
        set_macro_page(4, 2)
    elseif player.sub_job == 'SAM' then
        set_macro_page(5, 2)
    else
        set_macro_page(3, 3)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end
