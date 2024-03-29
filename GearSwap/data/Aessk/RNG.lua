-- Owner: AlanWarren, aka ~ Orestes 
-- current file resides @ https://github.com/AlanWarren/gearswap
--[[ 
 === Notes ===
 -- Set format is as follows:
    sets.midcast.RA.[CustomClass][CombatForm][CombatWeapon][RangedMode][CustomRangedGroup]
    ex: sets.midcast.RA.SAM.Bow.Mid.SamRoll = {}
    you can also append CustomRangedGroups to each other
 
 -- These are the available sets per category
 -- CustomClass = SAM
 -- CombatForm = DW
 -- RangedMode = Normal, Mid, Acc
 -- CustomRangedGroup = SamRoll
 -- SamRoll is applied automatically whenever you have the roll on you. 
 -- SAM is used when you're RNG/SAM 
 * Auto RA
 - You can use the built in hotkey (CTRL -) or create a macro. (like below) Note "AutoRA" is case sensitive
   /console gs c toggle AutoRA
 - You have to shoot once after toggling autora for it to begin.
 - AutoRA will use weaponskills @ 1000TP, depending on which weapon you're using. However, this will only
   work if you set gear.Gun or gear.Bow to the weapon you're using. You also have to specify the desired
   ws it should use, with the settings auto_gun_ws and auto_bow_ws. 
 
 === Helpful Commands ===
    //gs validate
    //gs showswaps
    //gs debugmode
--]]
 
function get_sets()
        mote_include_version = 2
        -- Load and initialize the include file.
        include('Mote-Include.lua')
        include('organizer-lib')
end

-- setup vars that are user-independent.
function job_setup()
        state.Buff.Barrage = buffactive.Barrage or false
        state.Buff.Camouflage = buffactive.Camouflage or false
        state.Buff.Overkill = buffactive.Overkill or false
        state.Buff['Double Shot'] = buffactive['Double Shot'] or false

        -- settings
        state.CapacityMode = M(false, 'Capacity Point Mantle')

        state.AutoRA = M{['description']='Auto RA', 'Normal', 'Shoot', 'WS' }
        auto_gun_ws = "Last Stand"
        auto_bow_ws = "Namas Arrow"


        gear.Gun = "Fomalhaut"
        gear.Bow = "Fail-Not"
        --gear.Bow = "Hangaku-no-Yumi"
       
        rng_sub_weapons = S{'Malevolence', 'Vanir Knife', 'Perun', 
            'Eminent Axe', 'Odium', 'Aphotic Kukri', 'Atoyac'}
        
        sam_sj = player.sub_job == 'SAM' or false

        DefaultAmmo = {[gear.Bow] = "Apex arrow", [gear.Gun] = "Chrono bullet"}
        U_Shot_Ammo = {[gear.Bow] = "Apex arrow", [gear.Gun] = "Chrono bullet"} 

        update_combat_form()
        get_combat_weapon()
        get_custom_ranged_groups()
end
 
function user_setup()
        -- Options: Override default values
        state.OffenseMode:options('Normal', 'Melee')
        state.RangedMode:options('Normal', 'Mid', 'Acc')
        state.HybridMode:options('Normal', 'PDT')
        state.IdleMode:options('Normal', 'PDT')
        state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
        state.PhysicalDefenseMode:options('PDT')
        state.MagicalDefenseMode:options('MDT')
 
        select_default_macro_book()

        send_command('bind != gs c toggle CapacityMode')
        send_command('bind f9 gs c cycle RangedMode')
        send_command('bind !f9 gs c cycle OffenseMode')
        send_command('bind ^f9 gs c cycle HybridMode')
        send_command('bind ^] gs c cycle WeaponskillMode')
        send_command('bind !- gs equip sets.crafting')
        send_command('bind ^- gs c cycle AutoRA')
        send_command('bind ^[ input /lockstyle on')
        send_command('bind ![ input /lockstyle off')
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind f9')
    send_command('unbind ^f9')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind !=')
    send_command('unbind ^=')
    send_command('unbind @=')
    send_command('unbind ^-')
end
 
function init_gear_sets()
        -- Augmented gear
        TaeonHands = {}
        TaeonHands.TA = {name="Taeon Gloves", augments={'DEX+6','Accuracy+17 Attack+17','"Triple Atk."+2'}}
        TaeonHands.Snap = {name="Taeon Gloves", augments={'"Snapshot"+5', 'Attack+22','"Snapshot"+5'}}
        
        TaeonHead = {}
        TaeonHead.Snap = { name="Taeon Chapeau", augments={'Accuracy+20 Attack+20','"Snapshot"+5','"Snapshot"+4',}}
        
        HercFeet = {}
        --HercFeet.TH = { name="Herculean Boots", augments={'AGI+1','Weapon Skill Acc.+3','"Treasure Hunter"+1','Accuracy+19 Attack+19','Mag. Acc.+7 "Mag.Atk.Bns."+7',}}
       -- HercFeet.MAB = { name="Herculean Boots", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+4%','Mag. Acc.+14','"Mag.Atk.Bns."+13',}}
        HercFeet.MAB={ name="Herculean Boots", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','Weapon skill damage +4%','Mag. Acc.+6','"Mag.Atk.Bns."+6',}}
        HercFeet.TP = { name="Herculean Boots", augments={'Accuracy+22 Attack+22','"Triple Atk."+3','STR+5','Attack+11',}}

        Belenus = {}
        Belenus.STP = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Damage taken-5%',}}
        Belenus.WSD = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
        Belenus.Snap = {name="Belenus's Cape", augments={'"Snapshot"+10',}}

        sets.Organizer = {
            main="Annihilator",
            sub="Nusku Shield",
            ammo="Perun +1",
            ear2="Reraise Earring",
            range="Yoichinoyumi",
            hands="Taeon Gloves",
            feet="Eradicating Bullet Pouch"
        }
        -- Misc. Job Ability precasts
        sets.precast.JA['Bounty Shot'] = {hands="Amini Glovelettes +1"}
        sets.precast.JA['Double Shot'] = {head="Amini Gapette"}
        sets.precast.JA['Camouflage'] = {body="Orion Jerkin +2"}
        sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +1"}
        sets.precast.JA['Velocity Shot'] = {body="Amini Caban +1", back=Belenus.Snap }
        sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}

        sets.CapacityMantle = {back="Mecistopins Mantle"}

        sets.precast.JA['Eagle Eye Shot'] = set_combine(sets.midcast.RA, {    head="Meghanada Visor +2",
    body="Sayadio's Kaftan",
    hands="Meg. Gloves +2",
    legs={ name="Adhemar Kecks +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
    feet={ name="Herculean Boots", augments={'"Triple Atk."+4','CHR+3','Accuracy+15','Attack+13',}},
    neck="Iskur Gorget",
    waist="Eschan Stone",
    left_ear="Telos Earring",
    right_ear="Enervating Earring",
    left_ring="Regal Ring",
    right_ring="Dingir Ring",
    back="Quarrel Mantle",
        })
        sets.precast.JA['Eagle Eye Shot'].Mid = set_combine(sets.precast.JA['Eagle Eye Shot'], {})
        sets.precast.JA['Eagle Eye Shot'].Acc = set_combine(sets.precast.JA['Eagle Eye Shot'].Mid, {})

        sets.precast.FC = {}
        sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads" })
        
        sets.idle = {waist="Chr. Bul. Pouch"}
        sets.idle.Regen = set_combine(sets.idle, {})
        sets.idle.PDT = set_combine(sets.idle, {})
        sets.idle.Town = set_combine(sets.idle, { })
 
        -- Engaged sets
        sets.engaged =  {
			ammo=DefaultAmmo,
			head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
			body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
			hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
			legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
			feet={ name="Herculean Boots", augments={'"Triple Atk."+4','CHR+3','Accuracy+15','Attack+13',}},
			neck="Combatant's Torque",
			waist="Windbuffet Belt +1",
			left_ear="Telos Earring",
			right_ear="Sherida Earring",
			left_ring="Epona's Ring",
			right_ring="Petrov Ring",
        }
        sets.engaged.PDT = set_combine(sets.engaged, {})
        sets.engaged.Bow = set_combine(sets.engaged, {})

        sets.engaged.Melee = {
			ammo=DefaultAmmo,
			head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
			body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
			hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
			legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
			feet={ name="Herculean Boots", augments={'"Triple Atk."+4','CHR+3','Accuracy+15','Attack+13',}},
			neck="Combatant's Torque",
			waist="Windbuffet Belt +1",
			left_ear="Telos Earring",
			right_ear="Sherida Earring",
			left_ring="Epona's Ring",
			right_ring="Petrov Ring",
        }
        sets.engaged.Bow.Melee = sets.engaged.Melee

        sets.engaged.Melee.PDT = set_combine(sets.engaged.Melee, {})

        sets.engaged.DW = sets.engaged

        -- sets.engaged.DW.Melee = set_combine(sets.engaged.Melee, {
        --     head="Herculean Helm",
        --     ear1="Eabani Earring",
        --     ear2="Sherida Earring",
        --     body="Herculean Vest",
        --     hands="Floral Gauntlets",
        --     back="Grounded Mantle +1",
        --     waist="Patentia Sash",
        --     legs="Carmine Cuisses +1",
        --     feet=HercFeet.TP
        -- })

        ------------------------------------------------------------------
        -- Preshot / Snapshot sets 
        -- 50 snap in gear will cap
        -- Pieces that provide delay reduction via velocity shot, do NOT
        -- count towards cap.
        ------------------------------------------------------------------
        sets.precast.RA = {
		    ammo=DefaultAmmo,
			head={ name="Taeon Chapeau", augments={'Rng.Acc.+13 Rng.Atk.+13','"Snapshot"+5','"Snapshot"+5',}},
			body="Oshosi Vest +1",
			hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
			legs={ name="Adhemar Kecks +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
			feet="Meg. Jam. +2",
			neck="Iskur Gorget",
			waist="Impulse Belt",
			left_ear="Telos Earring",
			right_ear="Enervating Earring",
			left_ring="Dingir Ring",
			right_ring="Cacoethic Ring",
		}
		
        sets.precast.RA.F1 = set_combine(sets.precast.RA, { })
        sets.precast.RA.F2 = set_combine(sets.precast.RA.F1, {})
        
        ------------------------------------------------------------------
        -- Default Base Gear Sets for Ranged Attacks. Geared for Gun
        ------------------------------------------------------------------
        sets.midcast.RA = { 
			ammo=DefaultAmmo,
			head="Meghanada Visor +2",
			body="Meg. Cuirie +2",
			hands="Meg. Gloves +2",
			legs="Meg. Chausses +2",
			feet="Meg. Jam. +2",
			neck="Iskur Gorget",
			waist="Yemaya Belt",
			left_ear="Telos Earring",
			right_ear="Enervating Earring",
			left_ring="Dingir Ring",
			right_ring="Cacoethic Ring",
        }
        sets.midcast.RA.Mid = set_combine(sets.midcast.RA, {})
        sets.midcast.RA.Acc = set_combine(sets.midcast.RA.Mid, { })

        -- sets.midcast.RA.Annihilator = set_combine(sets.midcast.RA, {
        --     ear2="Dedition Earring"
        -- })
        -- sets.midcast.RA.Annihilator.AM = set_combine(sets.midcast.RA.Annihilator, {
        --     legs="Mummu Kecks +2"
        -- })

        -- Bow base set.
        sets.midcast.RA.Yoichinoyumi = { }
        sets.midcast.RA.Yoichinoyumi.Mid = set_combine(sets.midcast.RA.Yoichinoyumi, { })
        sets.midcast.RA.Yoichinoyumi.Acc = set_combine(sets.midcast.RA.Yoichinoyumi.Mid, {})
       
        -- Weaponskill sets  
        sets.precast.WS = {
			head="Meghanada Visor +2",
			body="Sayadio's Kaftan",
			hands="Meg. Gloves +2",
			legs={ name="Adhemar Kecks +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
			feet={ name="Herculean Boots", augments={'"Triple Atk."+4','CHR+3','Accuracy+15','Attack+13',}},
			neck="Fotia Gorget",
			waist="Fotia Belt",
			left_ear="Telos Earring",
			right_ear="Enervating Earring",
			left_ring="Regal Ring",
			right_ring="Dingir Ring",
			back="Quarrel Mantle",
        }
        sets.precast.WS.Mid = set_combine(sets.precast.WS, {})
        sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {})

        -- WILDFIRE
        sets.precast.WS['Wildfire'] = {
		    ammo="Devistating Bullet",
			head={ name="Herculean Helm", augments={'Accuracy+4','"Mag.Atk.Bns."+19','Accuracy+9 Attack+9','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
			body="Oshosi Vest +1",
			hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
			legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+21','Weapon skill damage +5%','INT+8','Mag. Acc.+4',}},
			feet="Meg. Jam. +2",
			neck="Baetyl Pendant",
			waist="Eschan Stone",
			left_ear="Ishvara Earring",
			right_ear="Friomisi Earring",
			left_ring="Dingir Ring",
			right_ring="Regal Ring",
		}
		
        sets.precast.WS['Wildfire'].Mid = sets.precast.WS['Wildfire']
        sets.precast.WS['Wildfire'].Acc = sets.precast.WS['Wildfire']
        
        sets.precast.WS['Trueflight'] = {}
        sets.precast.WS['Trueflight'].Mid = set_combine(sets.precast.WS['Trueflight'], {})
        sets.precast.WS['Trueflight'].Acc = sets.precast.WS['Trueflight'].Mid

        sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Trueflight']

        -- CORONACH
        sets.precast.WS['Coronach'] = set_combine(sets.precast.WS, {})
        sets.precast.WS['Coronach'].Mid = set_combine(sets.precast.WS['Coronach'], {})
        sets.precast.WS['Coronach'].Acc = set_combine(sets.precast.WS['Coronach'].Mid, {})

        -- LAST STAND
        sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
			ammo=DefaultAmmo,
			head="Meghanada Visor +2",
			body="Nisroch Jerkin",
			hands="Meg. Gloves +2",
			legs={ name="Adhemar Kecks +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
			feet="Meg. Jam. +2",
			neck="Fotia Gorget",
			waist="Fotia Belt",
			left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
			right_ear="Ishvara Earring",
			left_ring="Dingir Ring",
			right_ring="Regal Ring",
			back="Quarrel Mantle",
        })
        sets.precast.WS['Last Stand'].Mid = set_combine(sets.precast.WS['Last Stand'], {
            body="Meghanada Cuirie +2",
        })
        sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'].Mid, {
            neck="Iskur Gorget",
        })

        -- sets.precast.WS['Last Stand'].SAM = set_combine(sets.precast.WS, {
        --     neck="Aqua Gorget",
        --     ear1="Tripudio Earring",
        --     ear2="Moonshade Earring",
        --     hands="Amini Glovelettes +1",
        --     ring2="Garuda Ring",
        --     waist="Light Belt",
        --     legs="Amini Brague +1", 
        -- })
        
        -- DETONATOR
        sets.Detonator = {}
        sets.precast.WS['Detonator'] = set_combine(sets.precast.WS, sets.Detonator)
        sets.precast.WS['Detonator'].Mid = set_combine(sets.precast.WS.Mid, sets.Detonator)
        sets.precast.WS['Detonator'].Acc = set_combine(sets.precast.WS.Acc, sets.Detonator)
        
        -- SLUG SHOT
        sets.SlugShot = {
           neck="Breeze Gorget",
           ear2="Moonshade Earring",
           waist="Light Belt",
        }
        sets.precast.WS['Slug Shot'] = set_combine(sets.precast.WS, sets.SlugShot)
        sets.precast.WS['Slug Shot'].Mid = set_combine(sets.precast.WS.Mid, sets.SlugShot)
        sets.precast.WS['Slug Shot'].Acc = set_combine(sets.precast.WS.Acc, sets.SlugShot)
        
        sets.precast.WS['Heavy Shot'] = set_combine(sets.precast.WS, sets.SlugShot)
        sets.precast.WS['Heavy Shot'].Mid = set_combine(sets.precast.WS.Mid, sets.SlugShot)
        sets.precast.WS['Heavy Shot'].Acc = set_combine(sets.precast.WS.Acc, sets.SlugShot)

        -- NAMAS
        sets.Namas = {
            neck="Aqua Gorget",
            waist="Light Belt",
            back=Belenus.WSD,
        }
        sets.precast.WS['Namas Arrow'] = set_combine(sets.precast.WS, sets.Namas)
        sets.precast.WS['Namas Arrow'].Mid = set_combine(sets.precast.WS.Mid, sets.Namas)
        sets.precast.WS['Namas Arrow'].Acc = set_combine(sets.precast.WS.Acc, sets.Namas)
        
        -- sets.precast.WS['Namas Arrow'].SAM = set_combine(sets.precast.WS, {
        --     neck="Aqua Gorget",
        --     ear1="Enervating Earring",
        --     ear2="Tripudio Earring",
        --     waist="Light Belt",
        --     back="Sylvan Chlamys",
        --     legs="Amini Brague +1", 
        -- })

        -- JISHNUS
        sets.Jishnus = {
            neck="Flame Gorget",
            ear2="Moonshade Earring",
            waist="Light Belt",
            ring2="Mummu Ring",
            back=Belenus.WSD,
            legs="Mummu Kecks +2",
            feet="Thereoid Greaves"
        }
        sets.precast.WS['Jishnu\'s Radiance'] = set_combine(sets.precast.WS, sets.Jishnus)
        sets.precast.WS['Jishnu\'s Radiance'].Mid = set_combine(sets.precast.WS.Mid, {
            neck="Flame Gorget",
            ear2="Moonshade Earring",
            waist="Light Belt",
            legs="Mummu Kecks +2",
            ring2="Rajas Ring",
            feet="Mummu Gamashes +2"

        })
        sets.precast.WS['Jishnu\'s Radiance'].Acc = set_combine(sets.precast.WS.Acc, {
            neck="Flame Gorget",
            ear2="Moonshade Earring",
            waist="Light Belt"
        })
        -- just a test (it works)
        -- sets.precast.WS['Jishnu\'s Radiance'].Yoichinoyumi = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {
        --     neck="Iskur Gorget"
        -- })

        -- SIDEWINDER
        sets.Sidewinder = {
            neck="Aqua Gorget",
            ear2="Moonshade Earring",
            waist="Light Belt",
        }
        sets.precast.WS['Sidewinder'] = set_combine(sets.precast.WS, sets.Sidewinder)
        sets.precast.WS['Sidewinder'].Mid = set_combine(sets.precast.WS.Mid, sets.Sidewinder)
        sets.precast.WS['Sidewinder'].Acc = set_combine(sets.precast.WS.Acc, sets.Sidewinder)

        sets.precast.WS['Refulgent Arrow'] = sets.precast.WS['Sidewinder']
        sets.precast.WS['Refulgent Arrow'].Mid = sets.precast.WS['Sidewinder'].Mid
        sets.precast.WS['Refulgent Arrow'].Acc = sets.precast.WS['Sidewinder'].Acc
       
        -- Resting sets
        sets.resting = {}
       
        -- Defense sets
        sets.defense.PDT = set_combine(sets.idle, {})
        sets.defense.MDT = set_combine(sets.idle, {})
        --sets.Kiting = {feet="Fajin Boots"}
       
        sets.buff.Barrage = {}
        -- placeholder until I can get to it
        sets.buff.Barrage.Mid = sets.buff.Barrage
        sets.buff.Barrage.Acc = set_combine(sets.buff.Barrage, {})
        sets.buff.Camouflage =  {body="Orion Jerkin +2"}

        sets.Overkill =  {
            body="Arcadian Jerkin +3"
        }
        sets.Overkill.Preshot = set_combine(sets.precast.RA, sets.Overkill)

end

function job_pretarget(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
    -- If autora enabled, use WS automatically at 100+ TP
    if spell.action_type == 'Ranged Attack' then
        if player.tp >= 1000 and state.AutoRA.value == 'WS' and not buffactive.amnesia then
            cancel_spell()
            use_weaponskill()
        end
    end
end 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
 
function job_precast(spell, action, spellMap, eventArgs)
        
        if state.Buff[spell.english] ~= nil then
            state.Buff[spell.english] = true
        end
        --add_to_chat(8, state.CombatForm)
        if sam_sj then
            classes.CustomClass = 'SAM'
        end

        -- if spell.action_type == 'Ranged Attack' and player.equipment.range == gear.Bow then
        --     state.CombatWeapon:set('Bow')
        -- end
        -- add support for RangedMode toggles to EES
        if spell.english == 'Eagle Eye Shot' then
            classes.JAMode = state.RangedMode.value
        end
        -- Safety checks for weaponskills 
        if spell.type:lower() == 'weaponskill' then
            if player.tp < 1000 then
                    eventArgs.cancel = true
                    return
            end
            if ((spell.target.distance >8 and spell.skill ~= 'Archery' and spell.skill ~= 'Marksmanship') or (spell.target.distance >21)) then
                -- Cancel Action if distance is too great, saving TP
                add_to_chat(122,"Outside WS Range! /Canceling")
                eventArgs.cancel = true
                return
            
            elseif state.DefenseMode.value ~= 'None' then
                -- Don't gearswap for weaponskills when Defense is on.
                eventArgs.handled = true
            end
        end
        -- Ammo checks
        if spell.action_type == 'Ranged Attack' or
          (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
            check_ammo(spell, action, spellMap, eventArgs)
        end
end
 
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
-- This is where you place gear swaps you want in precast but applied on top of the precast sets
function job_post_precast(spell, action, spellMap, eventArgs)
    if state.Buff.Camouflage then
        equip(sets.buff.Camouflage)
    elseif state.Buff.Overkill then
        equip(sets.Overkill.Preshot)
    end
    if spell.type == 'WeaponSkill' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    -- Barrage
    if spell.action_type == 'Ranged Attack' and state.Buff.Barrage then
        if state.RangedMode.current == 'Mid' then
            equip(sets.buff.Barrage.Mid)
        elseif state.RangedMode.current == 'Acc' then
            equip(sets.buff.Barrage.Acc)
        else
            equip(sets.buff.Barrage.Acc)
        end
        eventArgs.handled = true
    end
    if state.Buff.Camouflage then
        equip(sets.buff.Camouflage)
    end
    if state.Buff.Overkill then
        equip(sets.Overkill)
    end
    if spell.action_type == 'Ranged Attack' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end

 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- autora
    if state.AutoRA.value ~= 'Normal' then
        use_ra(spell)
    end

    if state.Buff[spell.name] ~= nil then
        state.Buff[spell.name] = not spell.interrupted or buffactive[spell.english]
    end

end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    --if S{"courser's roll"}:contains(buff:lower()) then
    --if string.find(buff:lower(), 'samba') then

    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
    if buff == 'Velocity Shot' and gain then
        windower.send_command('wait 290;input /echo **VELOCITY SHOT** Wearing off in 10 Sec.')
    elseif buff == 'Double Shot' and gain then
        windower.send_command('wait 90;input /echo **DOUBLE SHOT OFF**;wait 90;input /echo **DOUBLE SHOT READY**')
    elseif buff == 'Decoy Shot' and gain then
        windower.send_command('wait 170;input /echo **DECOY SHOT** Wearing off in 10 Sec.];wait 120;input /echo **DECOY SHOT READY**')
    end

    -- DoubleShot CombatForm
    if (buff == 'Double Shot' and gain or buffactive['Double Shot']) then
        -- state.CombatForm:set('DoubleShot')
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    else
        if state.CombatForm.current ~= 'DW' then
            state.CombatForm:reset()
        end
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    
    if buff == "Camouflage" then
        if gain then
            equip(sets.buff.Camouflage)
            disable('body')
        else
            enable('body')
        end
    end

    if buff == "Camouflage" or buff == "Overkill" or buff == "Samurai Roll" or buff == "Courser's Roll" then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

    if (( string.find(buff:lower(), 'flurry') and gain ) or buff:startswith('Aftermath')) then
        get_custom_ranged_groups()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
    --select_earring()
end
 
function customize_idle_set(idleSet)
    if state.HybridMode.value == 'PDT' then
        state.IdleMode.value = 'PDT'
    elseif state.HybridMode.value ~= 'PDT' then
        state.IdleMode.value = 'Normal'
    end
    if state.Buff.Camouflage then
        idleSet = set_combine(idleSet, sets.buff.Camouflage)
    end
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    return idleSet
end
 
function customize_melee_set(meleeSet)
    if state.Buff.Camouflage then
        meleeSet = set_combine(meleeSet, sets.buff.Camouflage)
    end
    if state.Buff.Overkill then
        meleeSet = set_combine(meleeSet, sets.Overkill)
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    return meleeSet
end
 
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        update_combat_form()
        get_combat_weapon()
    end
    if camo_active() then
        disable('body')
    else
        enable('body')
    end
end
 

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
end
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    get_combat_weapon()
    get_custom_ranged_groups()
    sam_sj = player.sub_job == 'SAM' or false
    -- called here incase buff_change failed to update value
    state.Buff.Camouflage = buffactive.camouflage or false
    state.Buff.Overkill = buffactive.overkill or false

    if camo_active() then
        disable('body')
    else
        enable('body')
    end
end
 
---- Job-specific toggles.
--function job_toggle_state(field)
--    if field:lower() == 'autora' then
--        state.AutoRA = not state.AutoRA
--        return state.AutoRA
--    end
--end
 
---- Request job-specific mode lists.
---- Return the list, and the current value for the requested field.
--function job_get_option_modes(field)
--    if field:lower() == 'autora' then
--        return state.AutoRA
--    end
--end
-- 
---- Set job-specific mode values.
---- Return true if we recognize and set the requested field.
--function job_set_option_mode(field, val)
--    if field:lower() == 'autora' then
--        state.AutoRA = val
--        return true
--    end
--end
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    if state.AutoRA.value ~= 'Normal' then
        msg = '[Auto RA: ON]['..state.AutoRA.value..']'
    else
        msg = '[Auto RA: OFF]'
    end

    add_to_chat(122, 'Ranged: '..state.RangedMode.value..'/'..state.HybridMode.value..', WS: '..state.WeaponskillMode.value..', '..msg)
    
    eventArgs.handled = true
 
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- Special WS mode for weapon types
function get_custom_wsmode(spell, spellMap, ws_mode)
    if spell.skill == 'Marksmanship' then
        if player.equipment.range == 'Annihilator' then
            return 'Annihilator'
        elseif player.equipment.range == 'Armageddon' then
            return 'Armageddon'
        elseif player.equipment.range == 'Fomalhaut' then
            return 'Fomalhaut'
        elseif player.equipment.range == 'Gastraphetes' then
            return 'Gastraphetes'
        end
    end

    if spell.skill == 'Archery' then
        if player.equipment.range == 'Yoichinoyumi' then
            return 'Yoichinoyumi'
        elseif player.equipment.range == 'Gandiva' then
            return 'Gandiva'
        elseif player.equipment.range == 'Fail-Not' then
            return 'FailNot'
        end
    end

end


function get_combat_weapon()
    state.CombatWeapon:reset()
    if player.equipment.range == 'Annihilator' then
        state.CombatWeapon:set('Annihilator')
    elseif player.equipment.range == 'Armageddon' then
        state.CombatWeapon:set('Armageddon')
    elseif player.equipment.range == 'Fomalhaut' then
        state.CombatWeapon:set('Fomalhaut')
    elseif player.equipment.range == 'Gastraphetes' then
        state.CombatWeapon:set('Gastraphetes')
    elseif player.equipment.range == 'Yoichinoyumi' then
        state.CombatWeapon:set('Yoichinoyumi')
    elseif player.equipment.range == 'Gandiva' then
        state.CombatWeapon:set('Gandiva')
    elseif player.equipment.range == 'Fail-Not' then
        state.CombatWeapon:set('FailNot')
    end
end

function get_custom_ranged_groups()
    classes.CustomRangedGroups:clear()
    -- Flurry I = 265, Flurry II = 581
    if buffactive[265] then
        classes.CustomRangedGroups:append('F1')
    elseif buffactive[581] then
        classes.CustomRangedGroups:append('F2')
    end
    
    -- relic aftermath is just "Aftermath", while empy + mythic are numbered
    if buffactive.Aftermath then
        classes.CustomRangedGroups:append('AM')
    elseif buffactive['Aftermath: Lv.1'] then
        classes.CustomRangedGroups:append('AM1')
    elseif buffactive['Aftermath: Lv.2'] then
        classes.CustomRangedGroups:append('AM2')
    elseif buffactive['Aftermath: Lv.3'] then
        classes.CustomRangedGroups:append('AM2')
    end
end
function update_combat_form()
    state.CombatForm:reset()
    if S{'NIN', 'DNC'}:contains(player.sub_job) and rng_sub_weapons:contains(player.equipment.sub) then
        state.CombatForm:set("DW")
    end
    
    if buffactive['Double Shot'] then
        state.CombatForm:set('DoubleShot')
    end
end

 
function use_weaponskill()
    if player.equipment.range == gear.Bow then
        send_command('input /ws "'..auto_bow_ws..'" <t>')
    elseif player.equipment.range == gear.Gun then
        send_command('input /ws "'..auto_gun_ws..'" <t>')
    end
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Auto RA' then
        if newValue ~= 'Normal' then
            send_command('@wait 2.5; input /ra <t>')
        end
    end
end

function use_ra(spell)
    
    local delay = '2.2'
    -- BOW
    if player.equipment.range == gear.Bow then
        if spell.type:lower() == 'weaponskill' then
            delay = '2.25'
         else
             if buffactive["Courser's Roll"] then
                 delay = '0.7' -- MAKE ADJUSTMENT HERE
             elseif buffactive["Flurry II"] or buffactive.Overkill then
                 delay = '0.5'
             else
                delay = '1.05' -- MAKE ADJUSTMENT HERE
            end
        end
    else
    -- GUN 
        if spell.type:lower() == 'weaponskill' then
            delay = '2.25' 
        else
            if buffactive["Courser's Roll"] then
                delay = '0.7' -- MAKE ADJUSTMENT HERE
            elseif buffactive.Overkill or buffactive['Flurry II'] then
                delay = '0.5'
            else
                delay = '1.05' -- MAKE ADJUSTMENT HERE
            end
        end
    end
    send_command('@wait '..delay..'; input /ra <t>')
end

function camo_active()
    return state.Buff['Camouflage']
end
-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
    -- Filter ammo checks depending on Unlimited Shot
    if state.Buff['Unlimited Shot'] then
        if player.equipment.ammo ~= U_Shot_Ammo[player.equipment.range] then
            if player.inventory[U_Shot_Ammo[player.equipment.range]] or player.wardrobe[U_Shot_Ammo[player.equipment.range]] then
                add_to_chat(122,"Unlimited Shot active. Using custom ammo.")
                equip({ammo=U_Shot_Ammo[player.equipment.range]})
            elseif player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] then
                add_to_chat(122,"Unlimited Shot active but no custom ammo available. Using default ammo.")
                equip({ammo=DefaultAmmo[player.equipment.range]})
            else
                add_to_chat(122,"Unlimited Shot active but unable to find any custom or default ammo.")
            end
        end
    else
        if player.equipment.ammo == U_Shot_Ammo[player.equipment.range] and player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
            if DefaultAmmo[player.equipment.range] then
                if player.inventory[DefaultAmmo[player.equipment.range]] then
                    add_to_chat(122,"Unlimited Shot not active. Using Default Ammo")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                else
                    add_to_chat(122,"Default ammo unavailable.  Removing Unlimited Shot ammo.")
                    equip({ammo=empty})
                end
            else
                add_to_chat(122,"Unable to determine default ammo for current weapon.  Removing Unlimited Shot ammo.")
                equip({ammo=empty})
            end
        elseif player.equipment.ammo == 'empty' then
            if DefaultAmmo[player.equipment.range] then
                if player.inventory[DefaultAmmo[player.equipment.range]] then
                    add_to_chat(122,"Using Default Ammo")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                else
                    add_to_chat(122,"Default ammo unavailable.  Leaving empty.")
                end
            else
                add_to_chat(122,"Unable to determine default ammo for current weapon.  Leaving empty.")
            end
        elseif player.inventory[player.equipment.ammo].count < 15 then
            add_to_chat(122,"Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low ("..player.inventory[player.equipment.ammo].count..")")
        end
    end
end
-- Orestes uses Samurai Roll. The total comes to 5!
--function detect_cor_rolls(old,new,color,newcolor)
--    if string.find(old,'uses Samurai Roll. The total comes to') then
--        add_to_chat(122,"SAM Roll")
--    end
--end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR'then
            set_macro_page(3, 5)
    elseif player.sub_job == 'SAM' then
            set_macro_page(4, 5)
    else
        set_macro_page(3, 5)
    end
end
