-- Original: Motenten / Modified: Arislan / Aessk

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
--
--				[ WIN+M ]			Toggle Movement Speed Mode (needs Movespeed.lua)
--				[ WIN+F ]			Toggle Flurry Normal/Hi (I/II)
--				[ WIN+H ]			Toggle Haste Normal/Hi (I/II)
--
--  Weapons:    [ WIN+E ]         Cycles between available Weapon Sets
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
    mote_include_version = 2
	include('Mote-Include.lua')
	--include('Movespeed.lua') --Uncomment for auto movement speed swaps
	include('organizer-lib')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Barrage = buffactive.Barrage or false
    state.Buff.Camouflage = buffactive.Camouflage or false
    state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
    state.Buff['Velocity Shot'] = buffactive['Velocity Shot'] or false
    state.Buff['Double Shot'] = buffactive['Double Shot'] or false
	
	state.FlurryMode = M{['description']='Flurry Mode', 'Normal', 'Hi'}
    state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi'}

    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    elemental_ws = S{'Aeolian Edge', 'Trueflight', 'Wildfire'}

    lockstyleset = 8

no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}


end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Multi')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('Normal', 'Acc', 'HighAcc', 'Critical')
    state.WeaponskillMode:options('Normal','Mid', 'Acc')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponSet = M{['description']='Weapon Set', 'Gastraphetes', 'Fomalhaut', 'Annihilator'} --'Armageddon', 'Gandiva', 'Yoichinoyumi', 'Accipiter'
    state.CP = M(false, "Capacity Points Mode")

    DefaultAmmo = {['Yoichinoyumi'] = "Chrono Arrow",
                   ['Gandiva'] = "Chrono Arrow",
                   ['Fail-Not'] = "Chrono Arrow",
                   ['Annihilator'] = "Chrono Bullet",
                   ['Armageddon'] = "Chrono Bullet",
                   ['Gastraphetes'] = "Quelling Bolt",
                   ['Fomalhaut'] = "Chrono Bullet",
                   }

    AccAmmo = {    ['Yoichinoyumi'] = "Yoichi's Arrow",
                   ['Gandiva'] = "Yoichi's Arrow",
                   ['Fail-Not'] = "Yoichi's Arrow",
                   ['Annihilator'] = "Devastating Bullet",
                   ['Armageddon'] = "Devastating Bullet",
                   ['Gastraphetes'] = "Quelling Bolt",
                   ['Fomalhaut'] = "Chrono Bullet",
                   }

    WSAmmo = {     ['Yoichinoyumi'] = "Chrono Arrow",
                   ['Gandiva'] = "Chrono Arrow",
                   ['Fail-Not'] = "Chrono Arrow",
                   ['Annihilator'] = "Chrono Bullet",
                   ['Armageddon'] = "Chrono Bullet",
                   ['Gastraphetes'] = "Quelling Bolt",
                   ['Fomalhaut'] = "Chrono Bullet",
                   }

    MagicAmmo = {  ['Yoichinoyumi'] = "Chrono Arrow",
                   ['Gandiva'] = "Chrono Arrow",
                   ['Fail-Not'] = "Chrono Arrow",
                   ['Annihilator'] = "Chrono Bullet",
                   ['Armageddon'] = "Chrono Bullet",
                   ['Gastraphetes'] = "Quelling Bolt",
                   ['Fomalhaut'] = "Chrono Bullet",
                   }


    -- Additional local binds


    send_command('bind ^` input /ja "Velocity Shot" <me>')
    send_command('bind @` input /ja "Scavenge" <me>')

    send_command('bind @c gs c toggle CP')
    send_command('bind @e gs c cycle WeaponSet')
	send_command('bind @h gs c cycle HasteMode')
    send_command('bind @f gs c cycle FlurryMode')

    select_default_macro_book()
    set_lockstyle()

    Haste = 0
    DW_needed = 0
    DW = false
    update_combat_form()
    determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind f9')
    send_command('unbind ^f9')
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
    send_command('unbind ^,')
    send_command('unbind @f')
    send_command('unbind @c')
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind ^numlock')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad2')
    send_command('unbind ^numpad3')
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

     send_command('unbind f10')
     send_command('unbind !f10')


end


-- Set up all gear sets.
function init_gear_sets()
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Bounty Shot'] = {hands="Amini Glovelettes +1"} --Put TH gear here
    sets.precast.JA['Double Shot'] = {} -- head="Amini Gapette +1"
    sets.precast.JA['Camouflage'] = {body="Orion Jerkin +1"}
    sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +1"}
    sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
    sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +1"} 

    -- Fast cast sets for spells

    sets.precast.Waltz = {
		--Waltz Potency and CHR/VIT
		}

    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.FC = {
		--Fast Cast set goes here
		}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        body="Passion Jacket",
        neck="Magoraga Beads",
        })


    -- (10% Snapshot, 5% Rapid from Merits)
	-- (Cap: 70% (60% with merits))
    sets.precast.RA = {
		--Snapshot/Rapid Shot set foes here 
		}
		
	-- (Cap: 55% (45% with merits))
    sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {}) 
	
	-- (Cap: 40% (30% with merits))
    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {}) 
	
    sets.precast.RA.Gastra = set_combine(sets.precast, {})
    sets.precast.RA.Gastra.Flurry1 = set_combine(sets.precast.RA.Gastra, {})
    sets.precast.RA.Gastra.Flurry2 = set_combine(sets.precast.RA.Gastra.Flurry1, {})


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
		--Default WS set goes here
		}

    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        --Default mid accuracy WS set goes here
		})
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
        --Default High accuracy WS set goes here
		})

    sets.precast.WS["Last Stand"] = set_combine(sets.precast.WS, {
		--Last Stand set goes here
		})
    sets.precast.WS['Last Stand'].Mid = set_combine(sets.precast.WS['Last Stand'], {})
    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'].Mid, {})

    sets.precast.WS["Coronach"] = set_combine(sets.precast.WS['Last Stand'], {
		--Coronach set goes here
		})
    sets.precast.WS['Coronach'].Mid = set_combine(sets.precast.WS['Coronach'], {})
    sets.precast.WS["Coronach"].Acc = set_combine(sets.precast.WS['Coronach'].Mid, {})

    sets.precast.WS["Trueflight"] = {
		--Trueflight set goes here
		}
	sets.precast.WS["Trueflight"].Acc = set_combine(sets.precast.WS['Trueflight'], {})

    sets.precast.WS["Wildfire"] = set_combine(sets.precast.WS["Trueflight"], {
		--Wildfire set Goes here
		})

	sets.precast.WS['Aeolian Edge']  = set_combine(sets.precast.WS["Trueflight"], {
		--Aeolian Edge set goes here
		})

    sets.precast.WS['Evisceration'] = {
		--Evisceration set goes here
		}
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})

	sets.precast.WS['Savage Blade'] = {
		--Savage Blade set goes here
		}
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {})
	
    sets.precast.WS['Namas Arrow'] = {
		--Namas Arrow set goes here
		}
    sets.precast.WS['Namas Arrow'].Mid = set_combine(sets.precast.WS['Namas Arrow'], {})
    sets.precast.WS['Namas Arrow'].Acc = set_combine(sets.precast.WS['Namas Arrow'].Mid, {})
    
    sets.precast.WS['Jishnu\'s Radiance'] = {
		--Jishnu's Radiance set goes here
		}
    sets.precast.WS['Jishnu\'s Radiance'].Mid = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {})
    sets.precast.WS['Jishnu\'s Radiance'].Acc = set_combine(sets.precast.WS['Jishnu\'s Radiance'].Mid, {})


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast recast for spells

    sets.midcast.FastRecast = sets.precast.FC

	-- (102% SIRD is full immunity to interruption)
    sets.midcast.SpellInterrupt = {
		--Spell interruption rate down set goes here 
		}

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    -- Ranged sets

    sets.midcast.RA = {
		--Ranged set goes here
        }

    sets.midcast.RA.Mid = set_combine(sets.midcast.RA, {
		--Ranged mid accuracy set goes here
		})

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA.Acc, {
		--Ranged high accuracy set goes here
        })

	-- (Critical set will equip with appropriate AM3)
    sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {
		--Ranged critical hit set goes here 
		})

    sets.DoubleShot = {
		--Double shot set goes here
		}
	-- (Critical set will equip with appropriate AM3)
	sets.DoubleShot.Critical = {
		--Double shot critical set goes here
		}

    sets.midcast.RA.Annihilator = set_combine(sets.midcast.RA, {
		--Annihilator ranged set goes here
		})
    sets.midcast.RA.Annihilator.Acc = set_combine(sets.midcast.RA.Annihilator, {})
    sets.midcast.RA.Annihilator.HighAcc = set_combine(sets.midcast.RA.Annihilator.Acc, {})
	sets.midcast.RA.Annihilator.Critical = set_combine(sets.midcast.RA.Annihilator, sets.midcast.RA.Critical)

    sets.midcast.RA.Yoichinoyumi = set_combine(sets.midcast.RA, {
		--Yoichinoyumi ranged set goes here
		})
    sets.midcast.RA.Yoichinoyumi.Acc = set_combine(sets.midcast.RA.Yoichinoyumi, {})
    sets.midcast.RA.Yoichinoyumi.HighAcc = set_combine(sets.midcast.RA.Yoichinoyumi.Acc, {})
    sets.midcast.RA.Yoichinoyumi.Critical = set_combine(sets.midcast.RA.Yoichinoyumi, sets.midcast.RA.Critical)

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = {}
	
	sets.MoveSpeed = {} -- Movement speed goes here. This will automatically equip when you move if Movespeed.lua is included

    -- Idle sets
    sets.idle = {
		--Field idle set goes here
        }

    sets.idle.DT = set_combine(sets.idle, {
		--Field DT idle set goes here
		}) 

    sets.idle.Town = set_combine(sets.idle, {
		body="Councilor's Garb"
        })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {} --Movement speed goes here


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
	-- Use WIN+H to toggle between Haste I and Haste II sets.

    sets.engaged = {
		--0% magic haste melee set goes here
		}

    sets.engaged.LowAcc = set_combine(sets.engaged, {})

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {})

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {})

    sets.engaged.Multi = set_combine(sets.engaged, {})


    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.Haste_15 = set_combine(sets.engaged, {
		--Haste I melee set goes here
		})

    sets.engaged.LowAcc.Haste_15 = set_combine(sets.engaged.Haste_15, {})

    sets.engaged.MidAcc.Haste_15 = set_combine(sets.engaged.LowAcc.Haste_15, {})

    sets.engaged.HighAcc.Haste_15 = set_combine(sets.engaged.MidAcc.Haste_15, {})

    sets.engaged.Multi.Haste_15 = set_combine(sets.engaged.Haste_15, {})


    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.Haste_30 = set_combine(sets.engaged, {
		--Haste II melee set goes here-
		})

    sets.engaged.LowAcc.Haste_30 = set_combine(sets.engaged.Haste_30, {})

    sets.engaged.MidAcc.Haste_30 = set_combine(sets.engaged.LowAcc.Haste_30, {})

    sets.engaged.HighAcc.Haste_30 = set_combine(sets.engaged.MidAcc.Haste_30, {})

    sets.engaged.Multi.Haste_30 = set_combine(sets.engaged.Haste_30, {})


    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.MaxHaste = set_combine(sets.engaged, {
		--Capped magic haste melee set goes here
		})

    sets.engaged.LowAcc.MaxHaste = set_combine(sets.engaged.MaxHaste, {})

    sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, {})

    sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, {})

    sets.engaged.Multi.MaxHaste = set_combine(sets.engaged.MaxHaste, {})
	   

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
		--Hybrid DT set goes here
        }

	-- Hybrid DT sets
    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.Multi.DT = set_combine(sets.engaged.Multi, sets.engaged.Hybrid)

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.Multi.DT = set_combine(sets.engaged.Multi, sets.engaged.Hybrid)

    sets.engaged.DT.Haste_15 = set_combine(sets.engaged.Haste_15, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.Haste_15 = set_combine(sets.engaged.LowAcc.Haste_15, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.Haste_15 = set_combine(sets.engaged.MidAcc.Haste_15, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.Haste_15 = set_combine(sets.engaged.HighAcc.Haste_15, sets.engaged.Hybrid)
    sets.engaged.Multi.DT.Haste_15 = set_combine(sets.engaged.Multi.Haste_15, sets.engaged.Hybrid)

    sets.engaged.DT.Haste_30 = set_combine(sets.engaged.Haste_30, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.Haste_30 = set_combine(sets.engaged.LowAcc.Haste_30, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.Haste_30 = set_combine(sets.engaged.MidAcc.Haste_30, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.Haste_30 = set_combine(sets.engaged.HighAcc.Haste_30, sets.engaged.Hybrid)
    sets.engaged.Multi.DT.Haste_30 = set_combine(sets.engaged.Multi.Haste_30, sets.engaged.Hybrid)

    sets.engaged.DT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.Multi.DT.MaxHaste = set_combine(sets.engaged.Multi.MaxHaste, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

	sets.precast.JA['Eagle Eye Shot'] = set_combine(sets.midcast.RA, {legs="Arcadian Braccae +1"})

    sets.buff.Barrage = set_combine(sets.precast.RA, {hands="Orion Bracers +1"})
    sets.buff['Velocity Shot'] = set_combine(sets.precast.RA, {body="Amini Caban +1"})
    sets.buff.Camouflage = {body="Orion Jerkin +1"}

    sets.buff.Doom = {
        waist="Gishdubar Sash", --10
        }
    sets.Obi = {waist="Hachirin-no-Obi"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}
    sets.CP = {back="Mecisto. Mantle"}

    sets.Annihilator = {ranged="Annihilator"}
	sets.Armageddon = {ranged="Armageddon"}
    sets.Fomalhaut = {ranged="Fomalhaut"}
    sets.Gastraphetes = {ranged="Gastraphetes"}
	sets.Yoichinoyumi = {ranged="Yoichinoyumi"}
	sets.Gandiva = {ranged="Gandiva"}
	sets.Accipiter = {ranged="Accipiter"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])

    if spell.action_type == 'Ranged Attack' then
        state.CombatWeapon:set(player.equipment.range)
    end
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
        check_ammo(spell, action, spellMap, eventArgs)
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
    if spell.action_type == 'Ranged Attack' then
        if spell.action_type == 'Ranged Attack' and state.WeaponSet.current == "Gastraphetes" then
            if flurry == 2 then
                equip(sets.precast.RA.Gastra.Flurry2)
            elseif flurry == 1 then
                equip(sets.precast.RA.Gastra.Flurry1)
            else
                equip(sets.precast.RA.Gastra)
            end        
        elseif spell.action_type == 'Ranged Attack' then
            if flurry == 2 then
                equip(sets.precast.RA.Flurry2)
            elseif flurry == 1 then
                equip(sets.precast.RA.Flurry1)
            end
        end
	end
	
    if spell.type == 'WeaponSkill' then
        -- Replace TP-bonus gear if not needed.
        if spell.english ~= 'Wildfire' then
            if player.tp < 1750 and player.equipment.range:contains("Accipiter") then
				equip({left_ear="Moonshade Earring"})
				--windower.add_to_chat(80,"Adding in Moonshade Earring for more TP:"..player.tp)
			elseif player.tp < 2750 and not player.equipment.range:contains("Accipiter") then
				--windower.add_to_chat(80,"Adding in Moonshade Earring for more TP:"..player.tp)
				equip({left_ear="Moonshade Earring"})
			end
        end
        -- Equip orpheus sash for defined WS.
		if spell.english == 'Trueflight' then
			-- Matching double weather (w/o day conflict).
			if spell.element == world.weather_element and get_weather_intensity() == 2 then
               equip({waist="Korin Obi"})
			-- Target distance under 1.7 yalms.
			elseif spell.target.distance < (1.7 + spell.target.model_size) then
				equip({waist="Orpheus's Sash"})
			-- Matching day and weather.
			elseif spell.element == world.day_element and spell.element == world.weather_element then
				equip({waist="Korin Obi"})
			-- Target distance under 8 yalms.
			elseif spell.target.distance < (8 + spell.target.model_size) then
				equip({waist="Orpheus's Sash"})
			-- Match day or weather.
			elseif spell.element == world.day_element or spell.element == world.weather_element then
				equip({waist="Korin Obi"})
			end
		elseif elemental_ws:contains(spell.name) then
            -- Matching double weather (w/o day conflict).
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
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        if buffactive['Double Shot'] then
			if buffactive['Aftermath: Lv.3'] and (player.equipment.ranged == "Armageddon" or player.equipment.ranged == "Gandiva")then
                equip(sets.DoubleShot.Critical)
			else
				equip(sets.DoubleShot)
            end
        elseif buffactive['Aftermath: Lv.3'] and (player.equipment.ranged == "Armageddon" or player.equipment.ranged == "Gandiva") then
            equip(sets.midcast.RA.Critical)
        end
        if state.Buff.Barrage then
            equip(sets.buff.Barrage)
        end
    end
end


function job_aftercast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])

    if spell.english == "Shadowbind" then
        send_command('@timers c "Shadowbind ['..spell.target.name..']" 42 down abilities/00122.png')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
    if S{'flurry'}:contains(buff:lower()) then
        if not gain then
            flurry = nil
            add_to_chat(122, "Flurry status cleared.")
        end
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end


    if buff == "doom" then
        if gain then
            --equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
        else
            enable('right_ring','left_ring','waist')
            handle_equipping_gear(player.status)
        end
    end

end

function job_state_change(stateField, newValue, oldValue)
    --if state.WeaponLock.value == true then
    --    disable('ranged')
    --else
    --    enable('ranged')
   -- end

    equip(sets[state.WeaponSet.current])

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
    equip(sets[state.WeaponSet.current])
    handle_equipping_gear(player.status)
end

function update_combat_form()
        state.CombatForm:reset()
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

-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        if player.equipment.ammo == 'empty' or player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
            if DefaultAmmo[player.equipment.range] then
                if player.inventory[DefaultAmmo[player.equipment.range]] then
                    --add_to_chat(3,"Using Default Ammo")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                else
                    add_to_chat(3,"Default ammo unavailable.  Leaving empty.")
                end
            else
                add_to_chat(3,"Unable to determine default ammo for current weapon.  Leaving empty.")
            end
        end
    elseif spell.type == 'WeaponSkill' then
        if spell.element == 'None' then
        --physical weaponskills
            if state.WeaponskillMode.value == 'Acc' then
                if player.inventory[AccAmmo[player.equipment.range]] then
                    equip({ammo=AccAmmo[player.equipment.range]})
                else
                    add_to_chat(3,"Acc ammo unavailable.  Using default ammo.")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                end
            else
                if player.inventory[WSAmmo[player.equipment.range]] then
                    equip({ammo=WSAmmo[player.equipment.range]})
                else
                    add_to_chat(3,"WS ammo unavailable.  Using default ammo.")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                end
            end
        else
            -- magical weaponskills
            if player.inventory[MagicAmmo[player.equipment.range]] then
                equip({ammo=MagicAmmo[player.equipment.range]})
            else
                add_to_chat(3,"Magic ammo unavailable.  Using default ammo.")
                equip({ammo=DefaultAmmo[player.equipment.range]})
            end
        end
    end
    if player.equipment.ammo ~= 'empty' and player.inventory[player.equipment.ammo].count < 15 then
        add_to_chat(39,"*** Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low! *** ("..player.inventory[player.equipment.ammo].count..")")
    end
end

function update_offense_mode()
        state.CombatForm:reset()
end

--disables swaps for warp and tele rings
function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("right_ring")
    else
        enable("right_ring")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("left_ring")
    else
        enable("left_ring")
    end
end


windower.register_event('zone change', 
    function()
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            send_command('gi ugs true')
        end

        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("right_ring")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("left_ring")
            equip(sets.idle)
        end
    end
)


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR'then
            set_macro_page(1, 8)
    elseif player.sub_job == 'DNC' then
            set_macro_page(1, 8)
    else
        set_macro_page(1, 8)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end
