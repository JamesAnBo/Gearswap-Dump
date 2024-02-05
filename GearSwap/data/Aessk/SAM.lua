-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
--Ionis Zones
--Anahera Blade (4 hit): 52
--Tsurumaru (4 hit): 49
--Kogarasumaru (or generic 450 G.katana) (5 hit): 40
--Amanomurakumo/Masamune 437 (5 hit): 46
--
--Non Ionis Zones:
--Anahera Blade (4 hit): 52
--Tsurumaru (5 hit): 24
--Kogarasumaru (5 hit): 40
--Amanomurakumo/Masamune 437 (5 hit): 46
--
--Aftermath sets
-- Koga AM1/AM2 = sets.engaged.Kogarasumaru.AM
-- Koga AM3 = sets.engaged.Kogarasumaru.AM3
-- Amano AM = sets.engaged.Amanomurakumo.AM
-- Using Namas Arrow while using Amano will cancel STPAM set

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
    mote_include_version = 2
	include('Mote-Include.lua')
	include('organizer-lib')
	
   
end


-- Setup vars that are user-independent.
function job_setup()
    get_combat_form()
    --get_combat_weapon()
    update_melee_groups()
    
	--state.TreasureMode:set('Tag')
    state.CapacityMode = M(false, 'Capacity Point Mantle')

    state.YoichiAM = M(false, 'Cancel Yoichi AM Mode')
    -- list of weaponskills that make better use of otomi helm in low acc situations
    wsList = S{'Tachi: Fudo', 'Tachi: Shoha'}

    gear.RAarrow = {name="Eminent Arrow"}
    LugraWSList = S{'Tachi: Fudo', 'Tachi: Shoha', 'Namas Arrow'}

	include('Mote-TreasureHunter')
	
	-- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    state.Buff.Sekkanoki = buffactive.sekkanoki or false
    state.Buff.Sengikori = buffactive.sengikori or false
    state.Buff['Third Eye'] = buffactive['Third Eye'] or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
	
	lockstyleset = 89
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'MDT')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc','DT')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    --state.Fish = M(false, "Fish")
	
    -- Additional local binds
	send_command('bind ^= gs c cycle treasuremode')
    --send_command('bind ^[ input /lockstyle on')
    --send_command('bind ![ input /lockstyle off')
    --send_command('bind != gs c toggle CapacityMode')
	--send_command('bind ![ gs c toggle Fish')
	
	--send_command('bind ^!1 ja Yaegasumi <me>')					--ctrl alt win F1
	-- send_command('bind ^!2 ')								--ctrl alt win F2
	-- send_command('bind ^!3 input /item "Remedy" <me>')		--ctrl alt win F3
	-- send_command('bind ^!4 ')								--ctrl alt win F4
	-- send_command('bind ^!5 ')								--ctrl alt win F5
	-- send_command('bind ^!6 ')								--ctrl alt win F6
	-- send_command('bind ^!7 ')								--ctrl alt win F7
	-- send_command('bind ^!8 ')								--ctrl alt win F8
	-- send_command('bind ^!9 ')								--ctrl alt win F9
	-- send_command('bind ^!0 ')								--ctrl alt win F10
    
    select_default_macro_book()
	set_lockstyle()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	send_command('unbind ^=')
    send_command('unbind ^[')
    send_command('unbind !=')
    send_command('unbind ![')
	
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

--[[
-- SC's
Rana > Shoha > Fudo > Kasha > Shoha > Fudo - light
Rana > Shoha > Fudo > Kasha > Rana > Fudo - dark
Kasha > Shoha > Fudo
Fudo > Kasha > Shoha > fudo - light
Shoha > Fudo > Kasha > Shoha > Fudo - 
--]]
function init_gear_sets()

	organizer_items = {
		remedy="Remedy",
		grape="Grape Daifuku +1",
		maze="Maze Tabula M01",
		mog_amp="Moogle Amp.",
		copper_voucher="Copper Voucher",
		silver_voucher="Silver Voucher",
		sp_key="SP Gobbie Key",
	}

    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
	sets.FullTP = {
		head="Flam. Zucchetto +2",
		body="Kasuga Domaru +1",
		hands={ name="Tatena. Gote +1", augments={'Path: A',}},
		legs={ name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}},
		feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",
		 back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {
        head="Wakido Kabuto +3",
        hands="Sakonji Kote +3",
         back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
    --sets.precast.JA.Seigan = {head="Unkai Kabuto +2"}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +3"}
    sets.precast.JA['Third Eye'] = {legs="Sakonji Haidate"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +3"}
	
	sets.precast['Lucid Wing'] = sets.FullTP
	sets.precast['Lucid Wing II'] = sets.FullTP
    
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    sets.Organizer = {}
    	
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
	sets.TreasureHunter = { body="Volte Jupon", hands="Volte Bracers", legs="Volte Hose",}
    sets.CapacityMantle  = { back="Mecistopins Mantle" }
    --sets.Berserker       = { neck="Berserker's Torque" }
    sets.WSDayBonus      = { head="Gavialis Helm" }
    sets.LugraMoonshade  = { ear1="Lugra Earring +1", ear2="Moonshade Earring" }
    sets.ThrudMoonshade = { ear1="Thrud Earring", ear2="Moonshade Earring" }
    sets.LugraThrud      = { ear1="Lugra Earring +1", ear2="Thrud Earring" }
    sets.FlameFlame      = { ear1="Flame Pearl", ear2="Flame Pearl" }
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		--head={ name="Valorous Mask", augments={'Attack+23','Weapon skill damage +5%','DEX+3',}},
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		hands="Nyame Gauntlets",
		legs="Wakido Haidate +3",
		feet="Nyame Sollerets",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    }
    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        -- head="Rao Kabuto",
    })
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
        -- ring2="Mars's Ring",
        -- hands="Mikinaak Gauntlets"
    })
    
    sets.precast.WS['Namas Arrow'] = {
    }
    sets.precast.WS['Namas Arrow'].Mid = set_combine(sets.precast.WS['Namas Arrow'], {
    })
    sets.precast.WS['Namas Arrow'].Acc = set_combine(sets.precast.WS['Namas Arrow'].Mid, {
    })
    
    sets.precast.WS['Apex Arrow'] = set_combine(sets.precast.WS['Namas Arrow'], {
    })
    sets.precast.WS['Apex Arrow'].Mid = sets.precast.WS['Apex Arrow']
    sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {
    })
    
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {
    })
    sets.precast.WS['Tachi: Fudo'].Mid = set_combine(sets.precast.WS['Tachi: Fudo'], {
    })
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS['Tachi: Fudo'].Mid, {
    })
    sets.precast.WS['Tachi: Fudo'].DT = set_combine(sets.precast.WS, {
		legs="Nyame Flanchard",
		right_ring="Defending Ring",
    })
    
    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
    })
    sets.precast.WS['Tachi: Shoha'].Mid = set_combine(sets.precast.WS.Acc, {
    })
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS['Tachi: Shoha'].Mid, {
    })
    sets.precast.WS['Tachi: Shoha'].DT = set_combine(sets.precast.WS['Tachi: Shoha'].Mid, {
		legs="Nyame Flanchard",
		right_ring="Defending Ring",
    })
	
    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {
    })
    sets.precast.WS['Tachi: Rana'].Mid = set_combine(sets.precast.WS['Tachi: Rana'], {
    })
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {
    })
    -- CHR Mod
    sets.precast.WS['Tachi: Ageha'] = {
	    ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		hands="Nyame Gauntlets",
		legs="Mpaca's Hose",
		feet="Nyame Sollerets",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Digni. Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		 back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
    --sets.precast.WS['Tachi: Jinpu'] = {}
    
    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {})
    
    sets.precast.WS['Tachi: Kasha'].DT = set_combine(sets.precast.WS, {
		legs="Nyame Flanchard",
		right_ring="Defending Ring",
	})
	
    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {})
    
    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {})
    
    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {
		head="Nyame Helm", 
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})
	
	sets.precast.WS['Tachi: Kagero'] = sets.precast.WS['Tachi: Jinpu']
	sets.precast.WS['Tachi: Koki'] = sets.precast.WS['Tachi: Jinpu']
	sets.precast.WS['Tachi: Goten'] = sets.precast.WS['Tachi: Jinpu']
	sets.precast.WS['Tachi: Koki'] = sets.precast.WS['Tachi: Jinpu']
    
	sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
	
	})
	
    -- Midcast Sets
    sets.midcast.FastRecast = {
    	--head="Otomi Helm",
        --body="Kyujutsugi",
    	legs="Wakido Haidate +3",
        --feet="Ejekamal Boots"
    }
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
        head="Twilight Helm",
        body="Twilight Mail",
    }
    
    sets.idle.Town = {
    }
    sets.idle.Town.Adoulin = set_combine(sets.idle.Town, {
        body="Councilor's Garb"
    })
    
    sets.idle.Field = set_combine(sets.idle.Town, {
	    sub="Utu Grip",
		ammo="Staunch Tathlum +1",
		--range="Grudge",
		head="Wakido Kabuto +3" , 
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Sanare Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Purity Ring",
		 back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    })

    sets.idle.Regen = set_combine(sets.idle.Field, {
		body="Sacro Breastplate",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1"
    })
    
    sets.idle.Weak = set_combine(sets.idle.Field, {
        head="Twilight Helm",
    	body="Twilight Mail"
    })
    sets.idle.Yoichi = set_combine(sets.idle.Field, {
    	ammo=gear.RAarrow
    })
    
    -- Defense sets
    sets.defense.PDT = {
	    sub="Utu Grip",
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",   
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Sanare Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Purity Ring",
		 back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
    
    sets.defense.Reraise = set_combine(sets.defense.PDT, {
    	head="Twilight Helm",
    	body="Twilight Mail"
    })
    
    sets.defense.MDT = set_combine(sets.defense.PDT, {
    })
    
    sets.Kiting = {feet="Danzo Sune-ate"}
    
    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
    
    -- Engaged sets
    
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- I generally use Anahera outside of Adoulin areas, so this set aims for 47 STP + 5 from Anahera (52 total)
    -- Note, this set assumes use of Cibitshavore (hence the arrow as ammo)
    sets.engaged = {
		sub="Utu Grip",
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body={ name="Tatena. Harama. +1", augments={'Path: A',}},
		hands="Wakido Kote +3",
		legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		 back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
    
    sets.engaged.Mid = set_combine(sets.engaged, {
		feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
		right_ear="Cessance Earring",
    })
    
    sets.engaged.Acc = set_combine(sets.engaged.Mid, {
		head="Ken. Jinpachi +1",
		right_ring="Regal Ring",
    })
    
    sets.engaged.Yoichi = set_combine(sets.engaged, {
		ammo=gear.RAarrow
    })
    
    sets.engaged.Yoichi.Mid = set_combine(sets.engaged.Yoichi, {
    })
    
    sets.engaged.Yoichi.Acc = set_combine(sets.engaged.Yoichi.Mid, {
    })
    
    sets.engaged.PDT = set_combine(sets.engaged, {
		ammo="Staunch Tathlum +1", --3
		head={ name="Mpaca's Cap", augments={'Path: A',}}, --7
		body="Wakido Domaru +3", --8
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
		left_ear="Schere Earring",
		left_ring="Defending Ring", --10
		right_ring="Gelatinous Ring +1", --7
		--5
    })
    
	sets.engaged.MDT = set_combine(sets.engaged, {
		ammo="Aurgelmir Orb +1",
		head="Ken. Jinpachi +1",
		body="Wakido Domaru +3",
		hands="Wakido Kote +3",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Defending Ring",
		right_ring="Chirich Ring +1",
		 back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    })
	
    sets.engaged.Yoichi.PDT = set_combine(sets.engaged.PDT,  {
        ammo=gear.RAarrow
    })
    
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, { 
    })
    
    sets.engaged.Reraise = set_combine(sets.engaged.PDT, {
        head="Twilight Helm", 
        body="Twilight Mail",
    })
    
    sets.engaged.Reraise.Yoichi = set_combine(sets.engaged.Reraise, {
        ammo=gear.RAarrow
    })
    
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Reraise, {
        --hands="Miki. Gauntlets",
        --ring1="Patricius Ring",
        --feet="Wakido Sune-Ate +1", 
    })
    
    sets.engaged.Acc.Reraise.Yoichi = set_combine(sets.engaged.Acc.Reraise, {
        ammo=gear.RAarrow
    })
    	
    sets.engaged.Amanomurakumo = set_combine(sets.engaged, {
    })
    sets.engaged.Amanomurakumo.AM = set_combine(sets.engaged, {
    })
    sets.engaged.Kogarasumaru = set_combine(sets.engaged, {
    })
    sets.engaged.Kogarasumaru.AM = set_combine(sets.engaged, {
    })
    sets.engaged.Kogarasumaru.AM3 = set_combine(sets.engaged, {
    })
    
    sets.buff.Sekkanoki = {hands="Unkai Kote +2"}
    sets.buff.Sengikori = {}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate"}
    
    sets.thirdeye = {legs="Sakonji Haidate"}
    --sets.seigan = {hands="Otronif Gloves +1"}
    sets.bow = {ammo=gear.RAarrow}
	
	-- sets.Fish= {
	    -- range="Lu Shang's F. Rod",
		-- head="Tlahtlamah Glasses",
		-- body="Fsh. Tunica",
		-- hands="Fsh. Gloves",
		-- legs="Fisherman's Hose",
		-- feet="Fisherman's Boots",
		-- neck="Fisher's Torque",
		-- left_ring="Seagull Ring",
		-- right_ring="Pelican Ring",
		-- waist="Fisher's Rope",
	-- }
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		if player.tp < 1000 then
            eventArgs.cancel = true
            return
        end
        if ((spell.target.distance >8 and spell.skill ~= 'Marksmanship') or (spell.target.distance >21)) then
            -- Cancel Action if distance is too great, saving TP
            add_to_chat(122,"Outside WS Range! /Canceling")
            eventArgs.cancel = true
            return

        -- elseif state.DefenseMode.value ~= 'None' then
            -- -- Don't gearswap for weaponskills when Defense is on.
            -- eventArgs.handled = true
        end
		-- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
		if player.equipment.main =='Shining One' or player.equipment.main =='Quint Spear' then
			if spell.english:startswith("Tachi:") then
				send_command('@input /ws "Impulse Drive" '..spell.target.raw)
				eventArgs.cancel = true
			end
		end
	end
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
	if buffactive['Meikyo Shisui'] and player.tp < 2000 then
		send_command('cancel 54')
	end
end

function job_precast(spell, action, spellMap, eventArgs)
    --if spell.english == 'Third Eye' and not buffactive.Seigan then
    --    cancel_spell()
    --    send_command('@wait 0.5;input /ja Seigan <me>')
    --    send_command('@wait 1;input /ja "Third Eye" <me>')
    --end
end
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		if state.Buff.Sekkanoki then
			equip(sets.buff.Sekkanoki)
		end
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        -- if is_sc_element_today(spell) then
        --     if state.OffenseMode.current == 'Normal' and wsList:contains(spell.english) then
        --         -- do nothing
        --     else
        --         equip(sets.WSDayBonus)
        --     end
        -- end
        if LugraWSList:contains(spell.english) then
            if world.time >= (17*60) or world.time <= (7*60) then
                if spell.english:lower() == 'namas arrow' then
                    equip(sets.LugraThrud)
                else
                    equip(sets.LugraMoonshade)
                end
            else
                if spell.english:lower() == 'namas arrow' then
                    equip(sets.FlameFlame)
                else
                    equip(sets.ThrudMoonshade)
                end
            end
        end
		if state.Buff['Meikyo Shisui'] then
			equip(sets.buff['Meikyo Shisui'])
		end
	end
    if spell.english == "Seigan" then
        -- Third Eye gearset is only called if we're in PDT mode
        if state.HybridMode.value == 'PDT' or state.PhysicalDefenseMode.value == 'PDT' then
            equip(sets.thirdeye)
        else
            equip(sets.seigan)
        end
    end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
            -- If sneak is active when using, cancel before completion
            send_command('cancel 71')
    end
    update_am_type(spell)
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		equip(sets.midcast.FastRecast)
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	-- Effectively lock these items in place.
	if state.HybridMode.value == 'Reraise' or
    (state.HybridMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
		equip(sets.Reraise)
	end
    if state.Buff['Seigan'] then
        if state.DefenseMode.value == 'PDT' then
            equip(sets.thirdeye)
        else
            equip(sets.seigan)
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
	end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end

	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff['Seigan'] then
        if state.DefenseMode.value == 'PDT' then
    	    meleeSet = set_combine(meleeSet, sets.thirdeye)
        else
            meleeSet = set_combine(meleeSet, sets.seigan)
        end
    end
	-- if state.TreasureMode.value == 'Fulltime' then
        -- meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    -- end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    if player.equipment.range == 'Yoichinoyumi' then
        meleeSet = set_combine(meleeSet, sets.bow)
    end
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
-- function job_status_change(newStatus, oldStatus, eventArgs)
    -- if newStatus == 'Engaged' then
        -- if player.inventory['Eminent Arrow'] then
            -- gear.RAarrow.name = 'Eminent Arrow'
        -- elseif player.inventory['Tulfaire Arrow'] then
            -- gear.RAarrow.name = 'Tulfaire Arrow'
        -- elseif player.equipment.ammo == 'empty' then
            -- add_to_chat(122, 'No more Arrows!')
        -- end
    -- elseif newStatus == 'Idle' then
        -- determine_idle_group()
    -- end
-- end
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
    	state.Buff[buff] = gain
        handle_equipping_gear(player.status)
    end
	
	if buff == "sleep" then
        if gain then
            equip({neck = "Vim Torque +1"})
            add_to_chat(167, 'Asleep! Changing to Vim Torque.')
            disable('neck')
        else
            enable('neck')
            handle_equipping_gear(player.status)
        end
    end

    if S{'aftermath'}:contains(buff:lower()) then
        classes.CustomMeleeGroups:clear()
       
        if player.equipment.main == 'Amanomurakumo' and state.YoichiAM.value then
            classes.CustomMeleeGroups:clear()
        elseif player.equipment.main == 'Kogarasumaru'  then
            if buff == "Aftermath: Lv.3" and gain or buffactive['Aftermath: Lv.3'] then
                classes.CustomMeleeGroups:append('AM3')
            end
        elseif buff == "Aftermath" and gain or buffactive.Aftermath then
            classes.CustomMeleeGroups:append('AM')
        end
    end
    
    if not midaction() then
        handle_equipping_gear(player.status)
    end

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	get_combat_form()
    update_melee_groups()
    --get_combat_weapon()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
--function get_combat_weapon()
--    if player.equipment.range == 'Yoichinoyumi' then
--        if player.equipment.main == 'Amanomurakumo' then
--            state.CombatWeapon:set('AmanoYoichi')
--        else
--            state.CombatWeapon:set('Yoichi')
--        end
--    else
--        state.CombatWeapon:set(player.equipment.main)
--    end
--end
-- Handle zone specific rules
windower.register_event('Zone change', function(new,old)
    determine_idle_group()
end)

function determine_idle_group()
    classes.CustomIdleGroups:clear()
    if areas.Adoulin:contains(world.area) then
    	classes.CustomIdleGroups:append('Adoulin')
    end
end

function get_combat_form()
    -- if areas.Adoulin:contains(world.area) and buffactive.ionis then
    -- 	state.CombatForm:set('Adoulin')
    -- else
    --     state.CombatForm:reset()
    -- end
end

function seigan_thirdeye_active()
    return state.Buff['Seigan'] or state.Buff['Third Eye']
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()

    if player.equipment.main == 'Amanomurakumo' and state.YoichiAM.value then
        -- prevents using Amano AM while overriding it with Yoichi AM
        classes.CustomMeleeGroups:clear()
    elseif player.equipment.main == 'Kogarasumaru' then
        if buffactive['Aftermath: Lv.3'] then
            classes.CustomMeleeGroups:append('AM3')
        end
    else
        if buffactive['Aftermath'] then
            classes.CustomMeleeGroups:append('AM')
        end
    end
end
-- call this in job_post_precast() 
function update_am_type(spell)
    if spell.type == 'WeaponSkill' and spell.skill == 'Archery' and spell.english == 'Namas Arrow' then
        if player.equipment.main == 'Amanomurakumo' then
            -- Yoichi AM overwrites Amano AM
            state.YoichiAM:set(true)
        end
    else
        state.YoichiAM:set(false)
    end
end

function relaxed_play_mode()
    -- This can be used as a mini bot to automate actions
    if not midaction() and player.status == 'Engaged'
        and not check_buffs('Hasso')
        and not check_buffs('Seigan')
        and not check_buffs('amnesia')
        and check_recasts(s('Hasso')) then
                
                windower.send_command('Hasso')

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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
    	set_macro_page(1, 15)
    elseif player.sub_job == 'DNC' then
    	set_macro_page(1, 15)
    else
    	set_macro_page(1, 15)
    end
end

function set_lockstyle()
		send_command('wait 6; input /lockstyleset ' .. lockstyleset)
end