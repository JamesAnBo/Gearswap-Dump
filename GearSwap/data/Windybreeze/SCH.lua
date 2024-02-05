-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
        Custom commands:
        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
                                        Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
		

			
	Fusion (Fire, Light) - Level 2
		Fire Magic > Lightning Magic

	Fragmentation (Wind, Lightning) - Level 2
		Ice Magic > Water Magic

	Distortion (Ice, Water) - Level 2
		Light Magic > Earth Magic

	Gravitation (Earth, Dark) - Level 2
		Wind Magic > Dark Magic

	Liquefaction (Fire) - Level 1
		Earth Magic > Fire Magic
		Lightning Magic > Fire Magic

	Transfixion (Light) - Level 1
		Dark Magic > Light Magic

	Detonation (Wind) - Level 1
		Dark Magic > Wind Magic
		Earth Magic > Wind Magic
		Lightning Magic > Wind Magic

	Impaction (Lightning) - Level 1
		Ice Magic > Lightning Magic
		Water Magic > Lightning Magic

	Induration (Ice) - Level 1
		Water Magic > Ice Magic
		
	Reverberation (Water) - Level 1
		Earth Magic > Water Magic
		Light Magic > Water Magic
		
	Scission (Earth) - Level 1
		Fire Magic > Earth Magic
		Wind Magic > Earth Magic
		
	Compression (Dark) - Level 1
		Ice Magic > Dark Magic
		Light Magic > Dark Magic
		
		
		
	== Toggle Magic Burst ==
	/con gs c toggle MagicBurst
--]]



-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	
	include('organizer-lib')
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	--include('Icy-Include.lua')	
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

	Non_Obi_Spells = S{'Burn','Choke','Drown','Frost','Rasp','Shock','Impact','Anemohelix','Cryohelix',
					'Geohelix','Hydrohelix','Ionohelix','Luminohelix','Noctohelix','Pyrohelix'}

	Cure_Spells = {"Cure","Cure II","Cure III","Cure IV"} -- Cure Degradation --
	Curaga_Spells = {"Curaga","Curaga II"} -- Curaga Degradation --
		
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT', 'Hybrid', 'Burst')
	state.RegenMode = M{['description']='Regen Mode', 'Duration', 'Potency'}
	
	MagicBurstIndex = 0
    state.MagicBurst = M(false, 'Magic Burst')
	
    info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
                       "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",}
    info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    send_command('bind ^` input /ma Stun <t>')		--ctrl '
    send_command('bind @m gs c toggle MagicBurst')	--win m
	send_command('bind @r gs c cycle RegenMode')	--win r
	
	--ctrl numpad0-9
	send_command('bind ^numpad0 input /item "Remedy" <me>')
	send_command('bind ^numpad1 input /ma "Baramnesra" <me>')
	send_command('bind ^numpad2 input /ma "Barvira" <me>')
	send_command('bind ^numpad3 input /ma "Barparalyzra" <me>')
	send_command('bind ^numpad4 input /ma "Barsilencera" <me>')
	send_command('bind ^numpad5 input /ma "Barpetra" <me>')
	send_command('bind ^numpad6 input /ma "Barpoisonra" <me>')
	send_command('bind ^numpad7 input /ma "Barblindra" <me>')
	send_command('bind ^numpad8 input /ma "Barsleepra" <me>')
	--send_command('bind ^numpad9 ')
	
		--alt numpad0-9
	send_command('bind !numpad0 input /ja "Accession" <me>; wait 1; input /ja "Perpetuance" <me>; wait 1; input /ma "Regen V" <me>')
	send_command('bind !numpad1 input /ma "Barfira" <me>')
	send_command('bind !numpad2 input /ma "Barblizzara" <me>')
	send_command('bind !numpad3 input /ma "Baraera" <me>')
	send_command('bind !numpad4 input /ma "Barstonra" <me>')
	send_command('bind !numpad5 input /ma "Barthundra" <me>')
	send_command('bind !numpad6 input /ma "Barwatera" <me>')
	send_command('bind !numpad7 ')
	--send_command('bind !numpad8 ')			
	--send_command('bind !numpad9 ')
	
	--ctrl alt numpad0-9
	send_command('bind !^numpad0 input /ja "Tabula Rasa" <me>')
	send_command('bind !^numpad1 input /ja "Light Arts" <me>')
	send_command('bind !^numpad2 input /ja "Accession" <me>')
	send_command('bind !^numpad3 input /ja "Perpetuance" <me>')
	send_command('bind !^numpad4 input /ma "Regen V" <me>')
	send_command('bind !^numpad5 input /ma "Aquaveil" <me>')
	send_command('bind !^numpad6 input /ma "Haste" <stpt>')
	--send_command('bind !^numpad7 ')
	--send_command('bind !^numpad8 ')
	--send_command('bind !^numpad9 ')
	
	send_command('bind ^!f1 input /ma "Firestorm II" <me>')		--ctrl alt F1
	send_command('bind ^!f2 input /ma "Hailstorm II" <me>')		--ctrl alt F2
	send_command('bind ^!f3 input /ma "Windstorm II" <me>')		--ctrl alt F3
	send_command('bind ^!f4 input /ma "Sandstorm II" <me>')		--ctrl alt F4
	send_command('bind ^!f5 input /ma "Thunderstorm II" <me>')	--ctrl alt F5
	send_command('bind ^!f6 input /ma "Rainstorm II" <me>')		--ctrl alt F6
	send_command('bind ^!f7 input /ma "Aurorastorm II" <me>')	--ctrl alt F7
	send_command('bind ^!f8 input /ma "Voidstorm II" <me>')		--ctrl alt F8
	send_command('bind ^!f9 input /ma "Fire V" <t>')		--ctrl alt F9 (M1G5)
	send_command('bind ^!f10 input /ma "Blizzard V" <t>')		--ctrl alt F10 (M1G6)
	send_command('bind ^!f11 input /ma "Aero V" <t>')		--ctrl alt F11
	send_command('bind ^!f12 input /ma "Stone V" <t>')		--ctrl alt F12

	send_command('bind ^!1 input /ma "Thunder V" <t>')			--ctrl alt win F1
	send_command('bind ^!2 input /ma "Water V" <t>')			--ctrl alt win F2
	send_command('bind ^!3 input /ma "Luminohelix II" <t>')		--ctrl alt win F3
	send_command('bind ^!4 input /ma "Noctohelix II" <t>')		--ctrl alt win F4
	send_command('bind ^!5 input /ma "Pyrohelix II" <t>')								--ctrl alt win F5
	send_command('bind ^!6 input /ma "Cryohelix II" <t>')								--ctrl alt win F6
	send_command('bind ^!7 input /ma "Anemohelix II" <t>')								--ctrl alt win F7
	send_command('bind ^!8 input /ma "Geohelix II" <t>')								--ctrl alt win F8
	send_command('bind ^!9 input /ma "Ionohelix II" <t>')								--ctrl alt win F9
	send_command('bind ^!0 input /ma "Hydrohelix II" <t>')								--ctrl alt win F10

	send_command('bind ^!@f1 input /ja "Light Arts" <me>; wait 1; input /ja "Addendum: White" <me>')					--ctrl alt win F1
	send_command('bind ^!@f2 input /ja "Dark Arts" <me>; wait 1; input /ja "Addendum: Black" <me>')						--ctrl alt win F2
	send_command('bind ^!@f3 input ')						--ctrl alt win F3
	send_command('bind ^!@f4 input ')						--ctrl alt win F4
	send_command('bind ^!@f5 input ')						--ctrl alt win F5
	send_command('bind ^!@f6 input ')						--ctrl alt win F6
	send_command('bind ^!@f7 input ')						--ctrl alt win F7
	send_command('bind ^!@f8 input ')						--ctrl alt win F8
	send_command('bind ^!@f9 input ')						--ctrl alt win F9
	send_command('bind ^!@f10 input ')						--ctrl alt win F10
	send_command('bind ^!@f11 input ')						--ctrl alt win F11
	send_command('bind ^!@f12 input ')						--ctrl alt win F12
		
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    update_active_strategems()
    select_default_macro_book()
	set_lockstyle('19')
	
	custom_timers = {}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.

function user_unload()
    send_command('unbind ^`')
	send_command('unbind @m')
	send_command('unbind @r')
	
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


function init_gear_sets()

	organizer_items = {
		remedy="Remedy",
		silver_voucher="Silver Voucher",
		sp_key="SP Gobbie"
	}
	
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Tabula Rasa'] = {legs="Pedagogy Pants +3"}

    -- Fast cast sets for spells

    sets.precast.FC = {
		main={ name="Musa", augments={'Path: C',}},
		sub="Khonsu",
		ammo="Incantor Stone",
		head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		body="Zendik Robe",
		hands="Acad. Bracers +3",
		legs={ name="Kaykaus Tights +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
		feet={ name="Peda. Loafers +3", augments={'Enhances "Stormsurge" effect',}},
		neck="Orunmila's Torque",
		waist="Embla Sash",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Kishar Ring",
		back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Mag. Evasion+15',}},
	}
	
    sets.precast.FC.Stun = sets.precast.FC

    sets.precast.FC.Arts = {
		head={ name="Peda. M.Board +3", augments={'Enh. "Altruism" and "Focalization"',}},
		feet="Acad. Loafers +3",
	}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Enhancing Magic'].Stoneskin = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {}) --ear1="Barkarole earring",

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		body={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		hands={ name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		legs="Doyen Pants",
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
	})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty, body="Twilight Cloak"}) --, body="Twilight Cloak"

	sets.precast.WS = {}
    
	sets.precast.WS['Myrkr'] = {}



    -- Midcast Sets 

    sets.midcast.FastRecast = {}

    sets.midcast.Cure = {
		main="Chatoyant Staff",																											--10c /00cc /00e /00f /00h /005mnd /005vit /000s /00cmp
		sub="Khonsu",																													--00c /00cc /05e /00f /04h /000mnd /000vit /000s /00cmp
		ammo="Incantor Stone",																											--00c /00cc /00e /02f /00h /000mnd /000vit /000s /00cmp
		head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},									--11c /02cc /06e /00f /06h /019mnd /014vit /016s /00cmp
		body={ name="Kaykaus Bliaut +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},													--00c /06cc /00e /00f /03h /045mnd /020vit /000s /00cmp
		hands="Peda. Bracers +3",																										--00c /03cc /07e /00f /03h /046mnd /035vit /019s /00cmp
		legs={ name="Kaykaus Tights +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},													--11c /02cc /00e /07f /05h /042mnd /012vit /000s /00cmp
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},									--11c /02cc /12e /00f /03h /019mnd /010vit /000s /07cmp
		neck="Incanter's Torque",																										--00c /00cc /00e /00f /00h /000mnd /000vit /010s /00cmp
		left_ear="Malignance Earring",																									--00c /00cc /00e /04f /00h /008mnd /000vit /000s /00cmp
		right_ear="Mendi. Earring",																										--05c /00cc /00e /00f /00h /000mnd /000vit /000s /02cmp
		left_ring="Janniston Ring",																										--00c /05cc /07e /00f /00h /000mnd /000vit /000s /00cmp
		right_ring="Lebeche Ring",																										--03c /00cc /05e /00f /00h /000mnd /000vit /000s /00cmp
		waist="Witful Belt",																											--00c /00cc /00e /03f /03h /000mnd /000vit /000s /00cmp
		back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Mag. Evasion+15',}},	--00c /00cc /00e /10f /00h /020mnd /000vit /000s /00cmp
	}																																	 --51c /20cc /42e /26f /27h /196mnd /096vit /045s /09cmp sub total
																																		 --51c /20cc /42e /13f /24h /176mnd /096vit /045s /09cmd w/ weather
																																		 --51c /20cc /47e /13f /24h /274mnd /188vit /501s /09cmd total w/ weather
																																		 --Cure Power: floor(MND÷2) + floor(VIT÷4) + Healing Magic Skill = 685
																																		 --Cure III Base: floor( (Power - Power Floor) ÷ Rate ) + HP Floor = 337
																																		 --Cure III Final: floor(floor(floor((Base + JP + Raetic) × Cure Potency Equip) × Cure Received Equip) × Daywx) = 
    sets.midcast.CureWithLightWeather = set_combine(sets.midcast.Cure, {
		waist="Hachirin-no-Obi",
		back="Twilight Cape",
	})

    sets.midcast.Curaga = sets.midcast.Cure

	sets.midcast.SelfCure = sets.midcast.Cure
	
	
    sets.midcast['Enhancing Magic'] = {
		main="Musa", --20
		sub="Khonsu",
		ammo="Pemphredo Tathlum",
		head={ name="Telchine Cap", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}, --10
		body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}}, --12
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}, --10
		legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}, --10
		feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}}, --10
		neck="Incanter's Torque",
		waist="Embla Sash", --10
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe"},
		right_ring={name="Stikini Ring +1", bag="wardrobe2"},
		back="Fi Follet Cape +1",
	} --82

    --sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {feet="Pedagogy Loafers +1"})
	   
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		head="Arbatel Bonnet +1",
		body={ name="Telchine Chas.", augments={'Mag. Evasion+25','"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Mag. Evasion+15',}},
	})
	
	sets.midcast.RegenPotency = set_combine(sets.midcast.Regen, {
		head="Arbatel Bonnet +1",
		body={ name="Telchine Chas.", augments={'"Regen" potency+3',}},
		hands={ name="Telchine Gloves", augments={'"Regen" potency+3',}},
		legs={ name="Telchine Braconi", augments={'"Regen" potency+3',}},
		feet={ name="Telchine Pigaches", augments={'"Regen" potency+3',}},
		back={ name="Bookworm's Cape", augments={'INT+3','MND+4','Helix eff. dur. +12','"Regen" potency+10',}},
	})
	
	sets.midcast.Haste = set_combine(sets.midcast['Enhancing Magic'], {
		back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Mag. Evasion+15',}},
	})

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
		back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Mag. Evasion+15',}},
	})
	
	sets.midcast.SelfRefresh = set_combine(sets.midcast['Enhancing Magic'], {
		waist="Gishdubar Sash",
		back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Mag. Evasion+15',}},
	})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		head="Amalric Coif +1",
		hands="Regal Cuffs",
		legs="Shedir Seraweels",
		waist="Emphatikos Rope",
	})

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		legs="Shedir Seraweels",
		waist="Siegel Sash",
		neck="Nodens Gorget"
	})


    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {right_ear="Brachyura Earring",})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect
	
	sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {feet="Pedagogy Loafers +3"})

	sets.midcast.Cursna = {
	    main="Musa",
		sub="Khonsu",
		ammo="Incantor Stone",
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		body={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		hands={ name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck="Debilis Medallion",
		waist="Bishop's Sash",
		left_ear="Beatific Earring",
		right_ear="Meili Earring",
		left_ring="Haoma's Ring",
		right_ring="Menelaus's Ring",
		back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Mag. Evasion+15',}},
	}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
		main={ name="Musa", augments={'Path: C',}},
		sub="Khonsu",
		ammo="Hydrocera",
		head="Acad. Mortar. +3",
		body="Acad. Gown +3",
		hands="Regal Cuffs",
		legs="Acad. Pants +3",
		feet="Acad. Loafers +3",
		neck="Argute Stole +2",
		waist="Luminary Sash",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring="Kishar Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Cure" potency +10%',}},
	}

	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast.MndEnfeebles,{
		hands="Acad. Bracers +3",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Mag. Acc.+29','Phalanx +4',}},
	})

    sets.midcast.IntEnfeebles = {
	    main={ name="Musa", augments={'Path: C',}},
		sub="Khonsu",
		ammo="Pemphredo Tathlum",
		head="Acad. Mortar. +3",
		body="Acad. Gown +3",
		hands="Regal Cuffs",
		legs="Acad. Pants +3",
		feet="Acad. Loafers +3",
		neck="Argute Stole +2",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring="Kishar Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}

    sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast.IntEnfeebles,{
		hands="Acad. Bracers +3",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Mag. Acc.+29','Phalanx +4',}},
	})


    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles

    sets.midcast['Dark Magic'] = set_combine(sets.midcast.IntEnfeebles, {
	neck="Erra Pendant",
	})

    sets.midcast.Kaustra = {
	}

	

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		--head={ name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Drain" and "Aspir" potency +4','INT+6','Mag. Acc.+10','"Mag.Atk.Bns."+8',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Occult Acumen"+5','INT+6','"Mag.Atk.Bns."+15',}},
		neck="Erra Pendant",
		waist="Fucho-no-Obi",
		left_ring="Archon Ring",
		right_ring="Evanescence Ring",
	})

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
	
	})
    sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {})
	
	sets.midcast.Helix = {
		main="Mpaca's Staff",
		sub="Enki Strap",
		ammo="Ghastly Tathlum +1",
		head={ name="Peda. M.Board +3", augments={'Enh. "Altruism" and "Focalization"',}},
		body={ name="Amalric Doublet +1", augments={'MP+80','"Mag.Atk.Bns."+25','"Fast Cast"+4',}},
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
		neck={ name="Argute Stole +2", augments={'Path: A',}},
		waist="Hachirin-no-Obi",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Jhakri Ring",
		right_ring={name="Stikini Ring +1", bag="wardrobe2"},
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}

	sets.midcast.Helix.Resistant = sets.midcast.Helix

	sets.midcast['Luminohelix II'] = set_combine(sets.midcast.Helix, {}) --ring1="Weatherspoon Ring"
	
	sets.midcast['Noctohelix II'] = set_combine(sets.midcast.Helix, {head="Pixie Hairpin +1", ring1="Archon Ring"})
	
	sets.helix_burst = set_combine(sets.midcast.Helix, {
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+10%','INT+7',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Magic burst dmg.+10%','Mag. Acc.+13','"Mag.Atk.Bns."+9',}},
		back={ name="Bookworm's Cape", augments={'INT+5','MND+1','Helix eff. dur. +20','"Regen" potency+4',}},
	})

    -- Elemental Magic sets are default for handling low-tier nukes.
	sets.midcast['Elemental Magic'] = {
		main="Mpaca's Staff",
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Peda. M.Board +3", augments={'Enh. "Altruism" and "Focalization"',}},
		body={ name="Amalric Doublet +1", augments={'MP+80','"Mag.Atk.Bns."+25','"Fast Cast"+4',}},
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
		neck={ name="Argute Stole +2", augments={'Path: A',}},
		waist="Hachirin-no-Obi",
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring="Jhakri Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})

    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})

	sets.magic_burst = set_combine(sets.midcast['Elemental Magic'], {
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+10%','INT+7',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Magic burst dmg.+10%','Mag. Acc.+13','"Mag.Atk.Bns."+9',}},
	})

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty, body="Twilight Cloak"})


    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {
	}
	
	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	
	--18 Refresh
    sets.idle.Field = {
		--main="Contemplator +1", --1~2
		main="Mpaca's Staff", --2
		sub="Oneiros Grip", --1
		ammo="Homiliary", --1
		head={ name="Chironic Hat", augments={'Pet: DEX+7','Sklchn.dmg.+3%','"Refresh"+2','Mag. Acc.+3 "Mag.Atk.Bns."+3',}}, --2
		body="Shamash Robe", --3
		hands={ name="Chironic Gloves", augments={'Weapon skill damage +1%','Accuracy+5','"Refresh"+2','Mag. Acc.+16 "Mag.Atk.Bns."+16',}}, --2
		legs={ name="Chironic Hose", augments={'MND+9','Weapon skill damage +2%','"Refresh"+2','Accuracy+4 Attack+4','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},  --2
		feet={ name="Chironic Slippers", augments={'AGI+8','Phys. dmg. taken -2%','"Refresh"+2',}}, --2
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear={ name="Moonshade Earring", augments={'HP+25','Latent effect: "Refresh"+1',}}, --1
		left_ring={name="Stikini Ring +1", bag="wardrobe"}, --1
		right_ring={name="Stikini Ring +1", bag="wardrobe2"}, --1
		back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Mag. Evasion+15',}},
	}

	--50PDT/42MDT/13 Refresh
    sets.idle.Field.PDT = {
		main="Malignance Pole", --20DT
		sub="Khonsu", --6DT
		ammo="Staunch Tathlum +1", --3DT
		head={ name="Chironic Hat", augments={'Pet: DEX+7','Sklchn.dmg.+3%','"Refresh"+2','Mag. Acc.+3 "Mag.Atk.Bns."+3',}},
		body="Shamash Robe", --10PDT
		hands={ name="Chironic Gloves", augments={'Weapon skill damage +1%','Accuracy+5','"Refresh"+2','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		legs={ name="Chironic Hose", augments={'MND+9','Weapon skill damage +2%','"Refresh"+2','Accuracy+4 Attack+4','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		feet={ name="Chironic Slippers", augments={'AGI+8','Phys. dmg. taken -2%','"Refresh"+2',}}, --4PDT
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring", --3MDT
		right_ear={ name="Moonshade Earring", augments={'HP+25','Latent effect: "Refresh"+1',}},
		left_ring={name="Stikini Ring +1", bag="wardrobe"},
		right_ring="Defending Ring", --10DT
		back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Mag. Evasion+15',}},
	}

	sets.idle.Field.MDT = sets.idle.Field.PDT

	sets.idle.Field.Burst = sets.idle.Field

	sets.idle.Field.Hybrid = sets.idle.Field
	
    sets.idle.Field.Stun = sets.idle.Field

    sets.idle.Weak = sets.idle.Field

    sets.idle.Town = set_combine(sets.idle.Field, {body="Councilor's Garb"})
	
    -- Defense sets

    sets.defense.PDT = {
		main="Malignance Pole",
		sub="Khonsu",
		ammo="Staunch Tathlum +1",
		head={ name="Chironic Hat", augments={'Pet: DEX+7','Sklchn.dmg.+3%','"Refresh"+2','Mag. Acc.+3 "Mag.Atk.Bns."+3',}},
		body="Shamash Robe",
		hands={ name="Chironic Gloves", augments={'Weapon skill damage +1%','Accuracy+5','"Refresh"+2','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		legs={ name="Chironic Hose", augments={'MND+9','Weapon skill damage +2%','"Refresh"+2','Accuracy+4 Attack+4','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		feet={ name="Chironic Slippers", augments={'AGI+8','Phys. dmg. taken -2%','"Refresh"+2',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Eabani Earring",
		right_ear={ name="Moonshade Earring", augments={'HP+25','Latent effect: "Refresh"+1',}},
		left_ring={name="Stikini Ring +1", bag="wardrobe"},
		right_ring="Defending Ring",
		back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Mag. Evasion+15',}},
	}

    sets.defense.MDT = sets.defense.PDT

    sets.Kiting = {feet="Iaso Boots"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {}


    -- Elemental Obi/Twilight Cape --
	sets.Obi = {waist='Hachirin-no-Obi'}
       
	sets.MagicTorque = {neck="Incanter's torque"}
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Ebullience'] = {head="Arbatel Bonnet +1"}
    sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}
    sets.buff['Perpetuance'] = {hands="Arbatel bracers +1"}
    sets.buff['Immanence'] = {hands="Arbatel bracers +1"}
    sets.buff['Penury'] = {legs="Arbatel pants"}
    sets.buff['Parsimony'] = {legs="Arbatel pants"}
    sets.buff['Celerity'] = {feet="Pedagogy Loafers +3"}
    sets.buff['Alacrity'] = {feet="Pedagogy Loafers +3"}
    sets.buff['Klimaform'] = {feet="Arbatel loafers +1"}

    sets.buff.FullSublimation = {
		--head="Academic's Mortarboard", 
		--body="Pedagogy Gown", 
		waist="Embla Sash",
		left_ear="Savant's Earring"
	}
    sets.buff.PDTSublimation = {
		--head="Academic's Mortarboard", 
		--body="Pedagogy Gown", 
		waist="Embla Sash",
		left_ear="Savant's Earring"
	}
	
	sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe2"}, --20
        waist="Gishdubar Sash", --10
    }

end




-------------------------------------------------------------------------
--Pretarget
-------------------------------------------------------------------------
function job_auto_change_target(spell, action, spellMap, eventArgs)
	eventArgs = {handled = false, PCTargetMode = state.PCTargetMode.value, SelectNPCTargets = state.SelectNPCTargets.value}
end

function pretarget(spell, action, spellMap, eventArgs)
	job_auto_change_target(spell, action, spellMap, eventArgs)
    -- if (spell.type:endswith('Magic') or spell.type == "Ninjutsu") and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
		-- cancel_spell()
		-- send_command('input /item "Echo Drops" <me>')
	if buffactive['Light Arts'] or buffactive['Addendum: White'] then
		if spell.english == "Light Arts" and not buffactive['Addendum: White'] then
			cancel_spell()
			send_command('input /ja Addendum: White <me>')
		elseif spell.english == "Manifestation" then
			cancel_spell()
			send_command('input /ja Accession <me>')
		elseif spell.english == "Alacrity" then
			cancel_spell()
			send_command('input /ja Celerity <me>')
		elseif spell.english == "Parsimony" then
			cancel_spell()
			send_command('input /ja Penury <me>')
		end
	elseif buffactive['Dark Arts'] or buffactive['Addendum: Black'] then
		if spell.english == "Dark Arts" and not buffactive['Addendum: Black'] then
			cancel_spell()
			send_command('input /ja Addendum: Black <me>')
		elseif spell.english == "Accession" then
			cancel_spell()
			send_command('input /ja Manifestation <me>')
		elseif spell.english == "Celerity" then
			cancel_spell()
			send_command('input /ja Alacrity <me>')
		elseif spell.english == "Penury" then
			cancel_spell()
			send_command('input /ja Parsimony <me>')
		end
    end
end
-----------------------------------------------------------------
--Precast
------------------------------------------------------------------
function job_precast(spell, action, spellMap)
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
	
    if spell.english == "Impact" then
		equip(set_combine(sets.precast.FC,{body="Twilight Cloak"}))
	end
end

function job_post_precast(spell, action, spellMap, eventArgs)
	if (buffactive['Addendum: White'] or buffactive['Light Arts']) and spell.type == 'WhiteMagic' then
		equip(sets.precast.FC.Arts)
	end
	if (buffactive['Addendum: Black'] or buffactive['Dark Arts']) and spell.type == 'BlackMagic' then
		equip(sets.precast.FC.Arts)
	end
end

-----------------------------------------------------------------------
--Midcast
-------------------------------------------------------------------------
function job_midcast(spell, action, spellMap, eventArgs)
    equipSet = {}
	if spell.type:endswith('Magic') or spell.type == 'Ninjutsu' or spell.type == 'BardSong' then
		equipSet = sets.midcast
	elseif string.find(spell.english,'helix') then
		equipSet = equipSet.Helix
	elseif string.find(spell.english,'Cure') then
		equipSet = equipSet.Cure
		if spell.target.name == player.name then
			equipSet = equipSet.SelfCure
		end
	elseif string.find(spell.english,'Cura') then
		equipSet = equipSet.Curaga
	elseif string.find(spell.english,'Storm') then
		equipSet = equipSet.Storm
	elseif string.find(spell.english,'Banish') then
		equipSet = set_combine(equipSet.MndEnfeebles)
	elseif spell.english == "Stoneskin" then
		equipSet = equipSet.Stoneskin
		if buffactive.Stoneskin then
			send_command('cancel stoneskin')
		end
	elseif spell.english == "Sneak" then
		if spell.target.name == player.name and buffactive['Sneak'] then
			send_command('cancel sneak')
		end
		equipSet = equipSet.Haste
	elseif string.find(spell.english,'Utsusemi') then
		if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
			send_command('@wait 1.7;cancel Copy Image*')
		end
		equipSet = equipSet.Haste
	elseif spell.english == 'Monomi: Ichi' then
		if buffactive['Sneak'] then
			send_command('@wait 1.7;cancel sneak')
		end
		equipSet = equipSet.Haste
	else
		if equipSet[spell.english] then
			equipSet = equipSet[spell.english]
		end
		if equipSet[spell.skill] then
			equipSet = equipSet[spell.skill]
		end
		if equipSet[spell.type] then
			equipSet = equipSet[spell.type]
		end
		
		if string.find(spell.english,'Cure')  and (world.weather_element == spell.element) or  (world.day_element == spell.element) then
			equipSet = set_combine(equipSet,sets.Obi)
		end    
		if ((spell.english == 'Drain') or (spell.english == 'Aspir')) and ((world.day_element == spell.element) or (world.weather_element == spell.element)) then
			equipSet = set_combine(equipSet,sets.Obi)
		end  
	end
	
    if equipSet[spell.english] then
        equipSet = equipSet[spell.english]
    end
	
    equip(equipSet)
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
	apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
	   if spell.skill == 'Elemental Magic' then
		if spell.element == world.day_element or spell.element == world.weather_element then
			equip(sets.Obi)
			if string.find(spell.english,'helix') then
				if state.MagicBurst.value then
					equip(sets.helix_burst)
				end
			elseif state.MagicBurst.value then
				equip(sets.magic_burst) 
			end
		elseif state.MagicBurst.value then
			equip(sets.magic_burst) 
		end
	   end
	   if string.find(spell.english,'Cur') and spell.target.name == player.name then
			equip(sets.midcast.SelfCure)
	   end
	   if string.find(spell.english,'Refresh') and spell.target.name == player.name then
			equip(sets.midcast.SelfRefresh)
	   end
	end
    if spellMap == "Regen" and state.RegenMode.value == 'Potency' then
            equip(sets.midcast.RegenPotency)
    end
	if not spell.interrupted then
		if spell.english == "Sleep II" then -- Sleep II Countdown --
			send_command('wait 60;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
		elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
			send_command('wait 30;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
		elseif spell.english == "Break" then -- Break Countdown --
			send_command('wait 25;input /echo Break Effect: [WEARING OFF IN 5 SEC.]')
		elseif spell.english == "Poison II" then
			send_command('wait 90;input /echo Poison Effect: [WEARING OFF IN 30 SEC.];wait 20;input /echo Poison Effect: [WEARING OFF IN 10 SEC.]')
		end
	end
end

function job_aftercast(spell, action, spellMap, eventArgs)
     if not spell.interrupted then
         if spell.skill == 'Elemental Magic' then
            ---state.MagicBurst:reset()
  		elseif spell.skill == 'Enhancing Magic' then
			adjust_timers(spell, spellMap)
		end
	end
	handle_equipping_gear(player.status)
end

--function job_post_aftercast(spell, action, spellMap, eventArgs)
---auto_sublimation()
--end

-- Function to create custom buff-remaining timers with the Timers plugin,

-- keeping only the actual valid songs rather than spamming the default

-- buff remaining timers.

function adjust_timers(spell, spellMap)
    local current_time = os.time()
    local temp_timer_list = {}
    local dur = calculate_duration(spell, spellName, spellMap)
         custom_timers[spell.name] = nil
         send_command('timers delete "'..spell.name..' ['..spell.target.name..']"')
         custom_timers[spell.name] = current_time + dur
         send_command('@wait 1;timers create "'..spell.name..' ['..spell.target.name..']" '..dur..' down')
end

function calculate_duration(spell, spellName, spellMap)

    local mult = 1.00

	if player.equipment.Head == 'Telchine Cap' then mult = mult + 0.10 end
	if player.equipment.Body == 'Telchine Chas.' then mult = mult + 0.10 end
	if player.equipment.Hands == 'Telchine Gloves' then mult = mult + 0.10 end
	if player.equipment.Legs == 'Telchine Braconi' then mult = mult + 0.10 end
	if player.equipment.Feet == 'Telchine Pigaches' then mult = mult + 0.10 end
	
	if player.equipment.Waist == 'Embla Sash' then mult = mult + 0.10 end
	if player.equipment.Main == 'Musa' then mult = mult + 0.20 end
	if player.equipment.Body == 'Pedagogy gown +2' then mult = mult + 0.08 end
	if player.equipment.Body == 'Pedagogy gown +3' then mult = mult + 0.12 end
	if player.equipment.Feet == 'Estq. Houseaux +2' then mult = mult + 0.20 end
	if player.equipment.Legs == 'Futhark Trousers' then mult = mult + 0.10 end
	if player.equipment.Legs == 'Futhark Trousers +1' then mult = mult + 0.20 end
	if player.equipment.Hands == 'Atrophy Gloves' then mult = mult + 0.15 end
	if player.equipment.Hands == 'Atrophy Gloves +1' then mult = mult + 0.16 end
	if player.equipment.Back == 'Estoqueur\'s Cape' then mult = mult + 0.10 end
	if player.equipment.Hands == 'Dynasty Mitts' then mult = mult + 0.05 end
	if player.equipment.Body == 'Shabti Cuirass' then mult = mult + 0.09 end
	if player.equipment.Body == 'Shabti Cuirass +1' then mult = mult + 0.10 end
	if player.equipment.Feet == 'Leth. Houseaux' then mult = mult + 0.25 end
	if player.equipment.Feet == 'Leth. Houseaux +1' then mult = mult + 0.30 end
	if player.equipment.Head == 'Erilaz Galea' then mult = mult + 0.10 end
	if player.equipment.Head == 'Erilaz Galea +1' then mult = mult + 0.15 end

	local base = 0

	if spell.name == 'Haste' then base = base + 180 end
	if spell.name:startswith("Bar") then base = base + 480 end
	if spell.name == 'Aquaveil' then base = base + 600 end
	if string.find(spell.english,'storm') then base = base + 180 end
	if spell.name == 'Auspice' then base = base + 180 end
	if spell.name:startswith("Boost") then base = base + 300 end
	if spell.name == 'Phalanx' then base = base + 180 end
	if spell.name:startswith("Refresh") then base = base + 150 end
	if spell.name:startswith("Regen") then 
		base = base + 60
		if buffactive['Light arts'] and player.main_job == 'SCH' then
			base = base*2+60
		-----the *2 here is the additional 60sec from Light Arts job points maxed
		-----+48 is from light arts, +12 more from telchine chas.
		elseif player.main_job == 'WHM' then
			base = base + 60
			if player.equipment.Hands == 'Ebers Mitts' then 
				base = base +  20
			elseif player.equipment.Hands == 'Ebers Mitts +1' then 
				base = base + 22
			end
			if player.equipment.Legs == 'Theo. Pantaloons' or player.equipment.Legs == 'Theo. Pant. +1' then
				base = base + 18
			end
		end
	end
	if spell.name == 'Adloquium' then base = base + 180 end
	if spell.name:startswith("Animus") then base = base + 180 end
	if spell.name == 'Crusade' then base = base + 300 end
	if spell.name == 'Embrava' then base = base + 90 end
	if spell.name:startswith("En") then base = base + 180 end
	if spell.name:startswith("Flurry") then base = base + 180 end
	if spell.name == 'Foil' then base = base + 30 end
	if spell.name:startswith("Gain") then base = base + 180 end
	if spell.name == 'Reprisal' then base = base + 60 end
	if spell.name:startswith("Temper") then base = base + 180 end
	if string.find(spell.english,'Spikes') then base = base + 180 end

	if buffactive['Perpetuance'] then
		if player.equipment.Hands == 'Arbatel Bracers' then
			mult = mult*2.5
		elseif player.equipment.Hands == 'Arbatel Bracers +1' then
			mult = mult*2.55
		else
			mult = mult*2
		end
	end

	if buffactive['Composure'] then
		if spell.target.type == 'SELF' then
			mult = mult*3
		else
			mult = mult
		end
	end			
    local totalDuration = math.floor(mult*base)

	--print(totalDuration)

    return totalDuration
end

function reset_timers()
    for i,v in pairs(custom_timers) do
        send_command('timers delete "'..i..'"')
    end
    custom_timers = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
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
	
	if buffactive['sleep'] or buffactive['lullaby'] or buffactive['stun'] or buffactive['terror'] or buffactive['petrification'] then
		if gain then
			equip(sets.defense.PDT)
			add_to_chat(123, '**!! [ASLEEP / STUNED / TERRORIZED / PETRIFIED] !!**')
		else
			handle_equipping_gear(player.status)
		end
	end
	
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

function auto_sublimation()
	local abil_recasts = windower.ffxi.get_ability_recasts()
	if not (buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete']) then
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

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' then
                return 'CureWithLightWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Elemental Magic' then
            if info.low_nukes:contains(spell.english) then
                return 'LowTierNuke'
            elseif info.mid_nukes:contains(spell.english) then
                return 'MidTierNuke'
            elseif info.high_nukes:contains(spell.english) then
                return 'HighTierNuke'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not (buffactive['light arts'] or buffactive['dark arts'] or buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end
	
    update_active_strategems()
    update_sublimation()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
-- In Game: //gs c (command), Macro: /console gs c (command), Bind: gs c (command) --
-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true

    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end


-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if (spellMap == 'Cure' or spellMap == 'Curaga') and (buffactive['Light Arts'] or buffactive['Addendum: White']) then
		if state.Buff.Rapture then
			equip(sets.buff['Rapture'])
		end
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' and not state.MagicBurst.value then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
	
	local currentStrats = get_current_strategem_count()
	local newStratCount = currentStrats - 1
	if currentStrats > 0 then
		add_to_chat(122, '***Current Charges Available: ['..newStratCount..']***')
	else
		add_to_chat(122, '***Out of stratagems! Cancelling...***')
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
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
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
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
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
    set_macro_page(1, 5)
end


function set_lockstyle(num)
	send_command('wait 2; input /lockstyleset '..num)
end