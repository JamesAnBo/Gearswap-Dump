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
--
--  Abilities:  [ CTRL+- ]          Primary step element cycle forward.
--              [ CTRL+= ]          Primary step element cycle backward.
--              [ ALT+- ]           Secondary step element cycle forward.
--              [ ALT+= ]           Secondary step element cycle backward.
--              [ CTRL+[ ]          Toggle step target type.
--              [ CTRL+] ]          Toggle use secondary step.
--              [ Numpad0 ]         Perform Current Step
--
--              [ CTRL+` ]          Saber Dance
--              [ ALT+` ]           Chocobo Jig II
--              [ ALT+[ ]           Contradance
--              [ CTRL+Numlock ]    Reverse Flourish
--              [ CTRL+Numpad/ ]    Berserk/Meditate
--              [ CTRL+Numpad* ]    Warcry/Sekkanoki
--              [ CTRL+Numpad- ]    Aggressor/Third Eye
--              [ CTRL+Numpad+ ]    Climactic Flourish
--              [ CTRL+NumpadEnter ]Building Flourish
--              [ CTRL+Numpad0 ]    Sneak Attack
--              [ CTRL+Numpad. ]    Trick Attack
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  WS:         [ CTRL+Numpad7 ]    Exenterator
--              [ CTRL+Numpad4 ]    Evisceration
--              [ CTRL+Numpad5 ]    Rudra's Storm
--              [ CTRL+Numpad6 ]    Pyrrhic Kleos
--              [ CTRL+Numpad1 ]    Aeolian Edge
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c step                       Uses the currently configured step on the target, with either <t> or
--                                  <stnpc> depending on setting.
--  gs c step t                     Uses the currently configured step on the target, but forces use of <t>.
--
--  gs c cycle mainstep             Cycles through the available steps to use as the primary step when using
--                                  one of the above commands.
--  gs c cycle altstep              Cycles through the available steps to use for alternating with the
--                                  configured main step.
--  gs c toggle usealtstep          Toggles whether or not to use an alternate step.
--  gs c toggle selectsteptarget    Toggles whether or not to use <stnpc> (as opposed to <t>) when using a step.


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
	state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
    state.AltStep = M{['description']='Alt Step', 'Quickstep', 'Feather Step', 'Stutter Step', 'Box Step'}
    state.UseAltStep = M(false, 'Use Alt Step')
    state.SelectStepTarget = M(false, 'Select Step Target')
    state.IgnoreTargetting = M(true, 'Ignore Targetting')

    state.ClosedPosition = M(false, 'Closed Position')

    state.CurrentStep = M{['description']='Current Step', 'Main', 'Alt'}
--  state.SkillchainPending = M(false, 'Skillchain Pending')

    state.CP = M(false, "Capacity Points Mode")

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    lockstyleset = 60
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('STP', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal', 'DT')

    -- Additional local binds
  --  include('Global-Binds.lua') -- OK to remove this line
  --  include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('lua l gearinfo')

	send_command('bind @h gs c cycle HasteMode')
--   send_command('bind ^- gs c cycleback mainstep')
--    send_command('bind ^= gs c cycle mainstep')
--    send_command('bind !- gs c cycleback altstep')
--    send_command('bind != gs c cycle altstep')
--    send_command('bind ^] gs c toggle usealtstep')
--    send_command('bind ![ input /ja "Contradance" <me>')
--    send_command('bind ^` input /ja "Saber Dance" <me>')
--    send_command('bind !` input /ja "Chocobo Jig II" <me>')
--    send_command('bind @f gs c toggle ClosedPosition')
--    send_command('bind ^numlock input /ja "Reverse Flourish" <me>')

--    send_command('bind @c gs c toggle CP')

--    if player.sub_job == 'WAR' then
--        send_command('bind ^numpad/ input /ja "Berserk" <me>')
--        send_command('bind ^numpad* input /ja "Warcry" <me>')
--        send_command('bind ^numpad- input /ja "Aggressor" <me>')
--    elseif player.sub_job == 'SAM' then
--        send_command('bind ^numpad/ input /ja "Meditate" <me>')
--        send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
--        send_command('bind ^numpad- input /ja "Third Eye" <me>')
--    elseif player.sub_job == 'THF' then
--        send_command('bind ^numpad0 input /ja "Sneak Attack" <me>')
--        send_command('bind ^numpad. input /ja "Trick Attack" <me>')
--    end

--    send_command('bind ^numpad+ input /ja "Climactic Flourish" <me>')
--    send_command('bind ^numpadenter input /ja "Building Flourish" <me>')

--    send_command('bind ^numpad7 input /ws "Exenterator" <t>')
--    send_command('bind ^numpad4 input /ws "Evisceration" <t>')
--    send_command('bind ^numpad5 input /ws "Rudra\'s Storm" <t>')
--    send_command('bind ^numpad6 input /ws "Pyrrhic Kleos" <t>')
--    send_command('bind ^numpad1 input /ws "Aeolian Edge" <t>')

--    send_command('bind numpad0 gs c step t')

	select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
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
        ammo="Sapience Orb",
        head=gear.Herc_MAB_head, --7
        body=gear.Taeon_FC_body, --8
        hands="Leyline Gloves", --8
        legs="Rawhide Trousers", --5
        feet=gear.Herc_MAB_feet, --2
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring2="Weatherspoon Ring", --6(4)
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
		ear2="Brutal Earring",
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

    sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {
        ear2="Mache Earring +1",
        -- ring1="Gere Ring",
        -- ring2="Epona's Ring",
        })

    sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS['Pyrrhic Kleos'], {
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

    sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {
        neck="Etoile Gorget +2",
        -- waist="Artful Belt +1",
        })

    sets.precast.WS['Rudra\'s Storm'].Acc = set_combine(sets.precast.WS['Rudra\'s Storm'], {
        })

    sets.precast.WS['Aeolian Edge'] = {
        ammo="Pemphredo Tathlum",
        head="Malignance Chapeau",
        -- head=gear.Herc_MAB_head,
        -- body="Samnuha Coat",
        hands="Maxixi Bangles +2",
        legs="Limbo Trousers",
        feet=gear.Herc_WSD_feet,
        neck="Baetyl Pendant",
        ear1="Hermetic Earring",
        ear2="Enchanter Earring +1",
        -- ear1="Crematio Earring",
        -- ear2="Friomisi Earring",
        ring1="Metamor. Ring +1",
        ring2="Weather. Ring",
        -- ring2="Epaminondas's Ring",
        -- back="Argocham. Mantle",
        -- waist="Hachirin-no-Obi", -- or try swapping Eschan Stone
        waist="Eschan Stone", -- or try swapping Eschan Stone
        -- waist="Orpheus's Sash",
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
        -- ammo="Staunch Tathlum +1",
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
        ring1="Chirich Ring +1",
        ring2="Regal Ring",
        back="Senuna's Mantle",
        --back="Moonlight Cape",
        -- waist="Engraved Belt",
        }

    sets.idle.DT = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1", --3/3
        head="Malignance Chapeau", --6/6
        body="Malignance Tabard", --9/9
        hands="Malignance Gloves", --5/5
        legs="Malignance Tights", --7/7
        feet="Malignance Boots", --4/4
        neck="Warder's Charm +1",
        ear2="Sanare Earring",
        ring1="Purity Ring", --0/4
        ring2="Defending Ring", --10/10
        back="Moonlight Cape", --6/6
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
    -- sets.Kiting = {feet="Skd. Jambeaux +1"}

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
        ammo="Aurgelmir Orb",
        head="Turms cap +1",
        body="Horos Casaque +3",
        hands="Mummu wrists +1",
        legs="Meg. Chausses +2",
        feet="Herculean Boots",
        neck="Etoile Gorget +2",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        ring1="Hetairoi Ring",
        ring2="Regal Ring",
        back="Senuna's mantle",
        waist="Grunfeld rope",
        } -- 41%

    sets.engaged.LowAcc = set_combine(sets.engaged, {
        })

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
        ammo="Voluspa Tathlum",
        head="Maxixi Tiara +2", --8
        ring1="Chirich Ring +1",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
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
        left_ring="Chirich Ring +1",
        right_ring="Regal Ring",
        back={ name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    })

    sets.engaged.STP = set_combine(sets.engaged, {
        })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.LowHaste = set_combine(sets.engaged, {
        })

    sets.engaged.LowAcc.LowHaste = set_combine(sets.engaged.LowHaste, {
        })

    sets.engaged.MidAcc.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, {
        })

    sets.engaged.HighAcc.LowHaste = set_combine(sets.engaged.MidAcc.LowHaste, {
        })

    sets.engaged.STP.LowHaste = set_combine(sets.engaged.LowHaste, {
        })

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.MidHaste = set_combine(sets.engaged, {
        })

    sets.engaged.LowAcc.MidHaste = set_combine(sets.engaged.MidHaste, {
        })

    sets.engaged.MidAcc.MidHaste = set_combine(sets.engaged.LowAcc.MidHaste, {
        })

    sets.engaged.HighAcc.MidHaste = set_combine(sets.engaged.MidAcc.MidHaste, {
        })

    sets.engaged.STP.MidHaste = set_combine(sets.engaged.MidHaste, {
        })

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.HighHaste = set_combine(sets.engaged, {
        })

    sets.engaged.LowAcc.HighHaste = set_combine(sets.engaged.HighHaste, {
        })

    sets.engaged.MidAcc.HighHaste = set_combine(sets.engaged.LowAcc.HighHaste, {
        })

    sets.engaged.HighAcc.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, {
        })

    sets.engaged.STP.HighHaste = set_combine(sets.engaged.HighHaste, {
        })

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.MaxHaste = set_combine(sets.engaged, {
        })

    sets.engaged.LowAcc.MaxHaste = set_combine(sets.engaged.MaxHaste, {
        })

    sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, {
        })

    sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, {
        })

    sets.engaged.STP.MaxHaste = set_combine(sets.engaged.MaxHaste, {
        })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

    sets.engaged.DT.LowHaste = set_combine(sets.engaged.LowHaste, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.LowHaste = set_combine(sets.engaged.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.LowHaste = set_combine(sets.engaged.HighAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.STP.DT.LowHaste = set_combine(sets.engaged.STP.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DT.MidHaste = set_combine(sets.engaged.MidHaste, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.MidHaste = set_combine(sets.engaged.LowAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.MidHaste = set_combine(sets.engaged.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.MidHaste = set_combine(sets.engaged.HighAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.STP.DT.MidHaste = set_combine(sets.engaged.STP.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DT.HighHaste = set_combine(sets.engaged.HighHaste, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.HighHaste = set_combine(sets.engaged.LowAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.HighHaste = set_combine(sets.engaged.HighAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.STP.DT.HighHaste = set_combine(sets.engaged.HighHaste.STP, sets.engaged.Hybrid)

    sets.engaged.DT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.STP.DT.MaxHaste = set_combine(sets.engaged.STP.MaxHaste, sets.engaged.Hybrid)


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
    --sets.Reive = {neck="Ygnas's Resolve +1"}

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
        if state.Buff['Sneak Attack'] == true then
            equip(sets.precast.WS.Critical)
        end
        if state.Buff['Climactic Flourish'] then
            equip(sets.buff['Climactic Flourish'])
        end
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
    check_moving()
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
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
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
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local s_msg = state.MainStep.current
    if state.UseAltStep.value == true then
        s_msg = s_msg .. '/'..state.AltStep.current
    end

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
        ..string.char(31,060).. ' Step: '  ..string.char(31,001)..s_msg.. string.char(31,002)..  ' |'
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

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
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
    -- Default macro set/book: (set, book)
    if player.sub_job == 'WAR' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'THF' then
        set_macro_page(2, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 2)
    elseif player.sub_job == 'RUN' then
        set_macro_page(4, 2)
    elseif player.sub_job == 'SAM' then
        set_macro_page(5, 2)
    else
        set_macro_page(1, 2)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end
