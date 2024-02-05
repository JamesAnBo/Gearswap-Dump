----- Credit: Krystela of Asura | Last Update: 22 November 2016 ---->
---- .:: This was entirely created by me, it's not based off anyone's file ::. ---->
---- Always visit http://pastebin.com/u/KrystelaRose to look for possible updates ---->
---- .:: Please leave credit where it's due ::. ---->
---- .:: If you have any problem contact me via ffxiah: http://www.ffxiah.com/player/Asura/Krystela ::. ---->
-- Binds for modes
    send_command('bind ^f9 gs c C9')
	send_command('bind ^f10 gs c C10')
    send_command('bind ^f11 gs c C11')
  -- Auto Functions --
    AutoPianissimo = 'ON' -- Set to On if you want Pianissimo to be automatically used, otherwise set to OFF --
	AutoRemedy = 'ON' -- Set to ON if you want to auto use remedies if silenced or Paralyzed, otherwise set to OFF --	  
-- Modes --
    Pulling = 'OFF' -- Press ctrl + F9 if you want to equip mov+ feet and Defense Set as aftercast --
	WeaponLock = 'OFF' -- Press ctrl + F10 for Weapon Lock--
    Capacity = 'OFF' -- Press Ctrl +F11 to have Capacity cape locked on while Idle, Change the cape at line 40 --
-- Gears --
    gear = {}
	gear.Capacity_Cape = {name="Mecisto. Mantle"} -- The cape you use for capacity --
-- Set macro book/set --
    send_command('input /macro book 3;wait .1;input /macro set 1') -- set macro book/set here --
-- Area mapping --	
    Town = S{"Ru'Lude Gardens","Upper Jeuno","Lower Jeuno","Port Jeuno","Port Windurst","Windurst Waters","Windurst Woods","Windurst Walls","Heavens Tower",
	         "Port San d'Oria","Northern San d'Oria","Southern San d'Oria","Port Bastok","Bastok Markets","Bastok Mines","Metalworks","Aht Urhgan Whitegate",
	         "Tavanazian Safehold","Nashmau","Selbina","Mhaura","Norg","Eastern Adoulin","Western Adoulin","Kazham"}	
---- Precast ----
    sets.precast = {}
	-- Base Set --
	sets.precast.FC = { 
	    head="Nahtirah Hat",
        neck="Moonbow Whistle +1",
        ear1="Loquacious Earring",
		ear2="Enchanter Earring +1",
        body="Inyanga Jubbah +2",
        hands="Leyline Gloves",
        ring1="Prolix Ring",
		ring2="Lebeche Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
        waist="Witful Belt",
        legs="Aya. Cosciales +2",
        feet="Chelona Boots +1"}
	-- Healing Magic --
	sets.precast.Cure = set_combine(sets.precast.FC, {
        main="Serenity",
        legs="Vanya Slops",
        feet="Kaykaus Boots +1"})
	-- Enhancing Magic --	
	sets.precast.Enhancing = set_combine(sets.precast.FC, {})
	sets.precast['Stoneskin'] = set_combine(sets.precast.FC, {})
	-- Ninjutsu --
	sets.precast.Utsusemi = set_combine(sets.precast.FC, {})		
	-- Waltz Set --
	sets.Waltz = {
		range="Gjallarhorn",
		head={ name="Bihu Roundlet +3", augments={'Enhances "Foe Sirvente" effect',}},
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands="Brioso Cuffs +3",
		legs="Dashing Subligar",
		feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
		neck="Bard's Charm +2",
		waist="Chaac Belt",
		left_ear="Handler's Earring +1",
		right_ear="Enchanter Earring +1",
		left_ring="Valseur's Ring",
		right_ring="Carbuncle Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Eva.+20 /Mag. Eva.+20','CHR+10','"Waltz" potency +10%',}}}
	-- Songs --
	sets.precast.SSC = {  -- If you have Gjallarhorn, make sure to put it in this set, if you don't, leave the range empty --
	    range="Gjallarhorn",
		head="Fili Calot +1",
        neck="Moonbow Whistle +1",
        ear1="Loquacious Earring",
		ear2="Enchanter Earring +1",
        body="Marduk's Jubbah +1",
        hands="Marduk's Dastanas +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
		ring1={name="Stikini Ring +1", bag ="Wardrobe 2"},
		ring2={name="Stikini Ring +1", bag ="Wardrobe 4"},   
		waist="Witful Belt",
        legs="Lengo Pants",
        feet="Telchine Pigaches"}
-- If you cast Pastoral/Gavotte/Capriccio/Fantasia/Aubade it will equip this set automatically --	 	
	sets.precast.Dummy = set_combine(sets.precast.SSC, {range="Daurdabla"}) -- Make sure to have Daurdabla or Terpender in this set --	
    -- If you have Gjallarhorn, take out the instruments in these sets --
	--If you dont have Gjallarhorn, put your appropriate instrument in here --	
	sets.precast.Honor= set_combine(sets.precast.SSC,{Range="Marsyas"})
	sets.precast.March= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
    sets.precast.Minuet= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Madrigal= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Prelude= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Carols= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Scherzo= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Minne= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Paeon= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Etude= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Hymnus= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Ballad= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Mambo= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Mazurka= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Dirge= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Sirvente= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})	
    sets.precast.Finale= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Elegy= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Lullaby= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Requiem= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Threnody= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Nocturne= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
	sets.precast.Virelai= set_combine(sets.precast.SSC,{Range="Gjallarhorn"})
    -- Job Abilities --
    sets.JA = {}
	sets.JA['Waltz'] = {
	range="Gjallarhorn",
	head={ name="Bihu Roundlet +3", augments={'Enhances "Foe Sirvente" effect',}},
	body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
	hands="Brioso Cuffs +3",
	legs="Dashing Subligar",
	feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
	neck="Bard's Charm +2",
	waist="Chaac Belt",
	left_ear="Handler's Earring +1",
	right_ear="Enchanter Earring +1",
	left_ring="Valseur's Ring",
	right_ring="Chirich Ring +1",
	back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%'}}}
	sets.JA['Nightingale'] = {feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}}}
    sets.JA['Troubadour'] = {body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}}}
    sets.JA['Soul Voice'] = {legs="Bihu Cannions +3"}
    
	-- Weaponskills --
    sets.WS = {
    head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}},
    legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
    neck="Bard's Charm +2",
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Brutal Earring",
    left_ring="Epaminondas's Ring",
    right_ring="Karieyh Ring",
    back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','"Weapon skill damage +10%'}}}
    
	sets.WS['Savage Blade']  = {
    head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}},
    legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
    neck="Bard's Charm +2",
	waist="Sailfi Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Ishvara Earring",
    left_ring="Epaminondas's Ring",
    right_ring="Karieyh Ring",
    back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}}
	
	sets.WS['Evisceration'] = {
    head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}},
    legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
    neck="Bard's Charm +2",
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Brutal Earring",
    left_ring="Epaminondas's Ring",
    right_ring="Karieyh Ring",
    back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','"Weapon skill damage +10%'}}}
    
	sets.WS['Exenterator'] = {
    head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}},
    legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
    neck="Bard's Charm +2",
	waist="Sailfi Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Brutal Earring",
    left_ring="Epaminondas's Ring",
    right_ring="Karieyh Ring",
    back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','"Weapon skill damage +10%'}}}
    
	sets.WS['Rudra Storm'] = {
    head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}},
    legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
    neck="Bard's Charm +2",
	waist="Sailfi Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Telos Earring",
    left_ring="Epaminondas's Ring",
    right_ring="Karieyh Ring",
    back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','"Weapon skill damage +10%'}}}
    
	sets.WS['Mercy Stroke'] = {
	head="Aya. Zucchetto +2",
	body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
    hands="Aya. Manopolas +2",
    legs="Zoar Subligar +1",
    feet="Aya. Gambieras +2",
    neck="Bard's Charm +2",
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Telos Earring",
    left_ring="Epaminondas's Ring",
    right_ring="Karieyh Ring",
    back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','"Weapon skill damage +10%'}}}
    
	sets.WS['Mordant Rime'] = {
    head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}},
    legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
    neck="Bard's Charm +2",
	waist="Sailfi Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Telos Earring",
    left_ring="Epaminondas's Ring",
    right_ring="Karieyh Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%'}}}
	
---- Midcast  ----
    sets.midcast = {}
 	-- Base Set --
	sets.midcast.Recast = { 	
	    head="Nahtirah Hat",
        neck="Moonbow Whistle +1",
        ear1="Loquacious Earring",
		ear2="Enchanter Earring +1",
        body="Marduk's Jubbah +1",
        hands="Gendewitha Gages +1",
        ring1="Prolix Ring",
		ring2="Lebeche Ring",
        waist="Witful Belt",
        legs="Lengo Pants",
		feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}}}
		
	-- Healing Magic --
	sets.midcast.Cure = {
	    main="Serenity",
        sub="Clerisy Strap +1",
	    head="Kaykaus Mitra +1",
	    neck="Moonbow Whistle +1",
		ear1="Loquacious Earring",
        ear2="Mendi. Earring",			
	    body="Chironic Doublet",
	    hands="Kaykaus Cuffs +1",
		ring1={name="Stikini Ring +1", bag ="Wardrobe 2"},
		ring2={name="Stikini Ring +1", bag ="Wardrobe 4"},
		back="Solemnity Cape",
		waist="Rumination Sash",
		legs="Chironic Hose",
		feet="Kaykaus Boots +1"}
	sets.midcast.Cure.Weather = set_combine(sets.midcast.Cure, {
	    main="Chatoyant Staff",
        back="Twilight Cape",
        waist="Hachirin-no-Obi",
        legs="Chironic Hose"})		
	sets.midcast.Cure.WeaponLock = set_combine(sets.midcast.Cure, { -- For when weapon is locked --
        ring1="Lebeche Ring",
        legs="Chironic Hose"})	
    sets.midcast['Cursna'] = set_combine(sets.midcast.Recast, {  -- for doom removal gears --	
		neck="Moonbow Whistle +1",
		ring1="Haoma's Ring",
		ring2="Haoma's Ring",
		feet="Gende. Galosh. +1"})
    -- Enhancing Magic --
	sets.midcast.Enhancing = set_combine(sets.midcast.Recast, { -- For haste/refresh/regen/Reraise --
	    main="Oranyan",
		head="Telchine Cap",
		body="Telchine Chasuble",
		hands="Telchine Gloves",
		legs="Telchine Braconi",
		feet="Telchine Pigaches"})
	sets.midcast['Stoneskin'] = {}	
    sets.midcast['Aquaveil'] = {}
    -- Ninjutsu --
    sets.midcast.Utsusemi = set_combine(sets.midcast.Recast, {})	
	-- Bard Songs --
-- If you cast Pastoral/Gavotte/Capriccio/Fantasia/Aubade it will equip this set automatically --	
	sets.midcast.Dummy = { -- Make sure to have Daurdabla or Terpender in this set --
		range="Daurdabla",
		ammo=empty,
	    head="Fili Calot +1",
        neck="Moonbow Whistle +1",
        ear1="Loquacious Earring",
		ear2="Enchanter Earring +1",
        body="Inyanga Jubbah +2",
        hands="Leyline Gloves",
        ring1="Prolix Ring",
		ring2="Kishar Ring",
        waist="Witful Belt",
        legs="Ayanmo Cosciales +2",
        feet="Bihu Slippers +3",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}}}
	sets.midcast.Buffs = { -- If you have Gjallarhorn, make sure to put it in this set, if you don't, leave the range empty --
	    main="Carnwenhan",
		sub="Kali",
		range="Gjallarhorn",
	    head="Fili Calot +1",        
		neck="Moonbow Whistle +1",	
        body="Fili Hongreline +1",
        hands="Fili Manchettes +1",		
		legs="Inyanga Shalwar +2",
        waist="Witful Belt",
		ring1="Prolix Ring",
	    ring2="Kishar Ring",
	    ear1="Loquacious Earring",
		ear2="Enchanter Earring +1",
		feet="Brioso Slippers +3",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}}}
-- If you have Gjallarhorn, take out the instruments in these sets --
-- If you dont have Gjallarhorn, put your appropriate instrument in here --	
	sets.midcast.Honor = set_combine(sets.midcast.Buffs, {range="Marsyas", main="Carnwenhan"})
	sets.midcast.March = set_combine(sets.midcast.Buffs, {range="Gjallarhorn", main="Carnwenhan", hands="Fili Manchettes +1"})
    sets.midcast.Minuet = set_combine(sets.midcast.Buffs, {range="Gjallarhorn", main="Carnwenhan", body="Fili Hongreline +1"})
	sets.midcast.Madrigal = set_combine(sets.midcast.Buffs, {range="Gjallarhorn", main="Carnwenhan", head="Fili Calot +1", back="Intarabus's Cape"})
	sets.midcast.Prelude = set_combine(sets.midcast.Buffs, {range="Gjallarhorn", main="Carnwenhan", back="Intarabus's Cape"})
	sets.midcast.Carols = set_combine(sets.midcast.Buffs, {range="Gjallarhorn", main="Carnwenhan", hands="Mousai Gages +1"})
	sets.midcast.Scherzo = set_combine(sets.midcast.Buffs, {range="Gjallarhorn", main="Carnwenhan", feet="Fili Cothurnes +1"})
	sets.midcast.Minne = set_combine(sets.midcast.Buffs, {range="Gjallarhorn", main="Carnwenhan", legs="Mousai Seraweels +1",})
	sets.midcast.Paeon = set_combine(sets.midcast.Buffs, {range="Gjallarhorn", main="Carnwenhan"})
	sets.midcast.Etude = set_combine(sets.midcast.Buffs, {range="Gjallarhorn", main="Carnwenhan", head="Mousai Turban +1"})
	sets.midcast.Hymnus = set_combine(sets.midcast.Buffs, {range="Gjallarhorn", main="Carnwenhan",})
	sets.midcast.Ballad = set_combine(sets.midcast.Buffs, {range="Gjallarhorn", main="Carnwenhan", legs="Fili Rhingrave +1"})
	sets.midcast.Mambo = set_combine(sets.midcast.Buffs, {range="Gjallarhorn", main="Carnwenhan", feet="Mousai Crackows +1"})
	sets.midcast.Mazurka = set_combine(sets.midcast.Buffs, {range="Gjallarhorn", main="Carnwenhan"})
	sets.midcast.Dirge = set_combine(sets.midcast.Buffs, {range="Gjallarhorn", main="Carnwenhan"})
	sets.midcast.Sirvente = set_combine(sets.midcast.Buffs, {range="Gjallarhorn", main="Carnwenhan",})			
	sets.midcast.Debuffs = { -- If you have Gjallarhorn, make sure to put it in this set, if you don't, leave the range empty --
		range="Gjallarhorn",
        head="Bihu Roundlet +3",
        neck="Moonbow Whistle +1",
        ear1="Digni. Earring",
		ear2="Enchanter's Earring +1",
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
        hands="Brioso Cuffs +3",
		ring1={name="Stikini Ring +1", bag ="Wardrobe 2"},
		ring2={name="Stikini Ring +1", bag ="Wardrobe 4"},
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
        waist="Porous Rope",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3"}
-- If you have Gjallarhorn, take out the instruments in these sets --
-- If you dont have Gjallarhorn, put your appropriate instrument in here --	
    sets.midcast.Finale = set_combine(sets.midcast.Debuffs,  {main="Carnwenhan", sub="Kali", range="Gjallarhorn", waist="Luminary Sash", right_ear="Digni. Earring"})
	sets.midcast.Elegy = set_combine(sets.midcast.Debuffs,  {main="Carnwenhan", sub="Kali", range="Gjallarhorn", waist="Luminary Sash", right_ear="Digni. Earring"})
	sets.midcast.Lullaby = set_combine(sets.midcast.Debuffs,  {main="Carnwenhan", sub="Kali", range="Blurred Harp +1", waist="Luminary Sash", right_ear="Digni. Earring"})
	sets.midcast.Requiem = set_combine(sets.midcast.Debuffs,  {main="Carnwenhan", sub="Kali", range="Gjallarhorn", waist="Luminary Sash", right_ear="Digni. Earring"})
	sets.midcast.Threnody = set_combine(sets.midcast.Debuffs, {main="Carnwenhan", sub="Kali", range="Gjallarhorn", body="Mou. Manteel +1", waist="Luminary Sash", right_ear="Digni. Earring"})
	sets.midcast.Nocturne = set_combine(sets.midcast.Debuffs,  {main="Carnwenhan", sub="Kali", range="Gjallarhorn", waist="Luminary Sash", right_ear="Digni. Earring"})
	sets.midcast.Virelai = set_combine(sets.midcast.Debuffs,  {main="Carnwenhan", sub="Kali", range="Gjallarhorn", waist="Luminary Sash", right_ear="Digni. Earring"})
	-- For when N/T is on --	
-- If you have Marsyas make sure to put in this set --
-- If you dont have Marsyas but you have Gjallarhorn, put it in this set --
-- If you have none of the above instruments, leave it empty --	
	sets.midcast.Debuffs.Duration = set_combine(sets.midcast.Debuffs, { 
		range="Marsyas",
		ammo=empty,
        neck="Moonbow Whistle +1",
        body="Fili Hongreline +1",	
		legs="Inyanga Shalwar +2",
		ring1={name="Stikini Ring +1", bag ="Wardrobe 2"},
		ring2={name="Stikini Ring +1", bag ="Wardrobe 4"},
        ear1="Loquacious Earring",
		ear2="Enchanter Earring +1",
		feet="Brioso Slippers +3"})	
-- If you have Marsyas or Gjallarhorn, take out the instruments from these sets --
-- If you have none of the above instruments, add the appropriate instruments --			
	sets.midcast.Elegy.Duration = set_combine(sets.midcast.Debuffs.Duration)
	sets.midcast.Lullaby.Duration = set_combine(sets.midcast.Debuffs.Duration, {range="Blurred Harp +1", hands="Brioso Cuffs +3"})
	sets.midcast.Requiem.Duration = set_combine(sets.midcast.Debuffs.Duration)
	sets.midcast.Threnody.Duration = set_combine(sets.midcast.Debuffs.Duration)
	sets.midcast.Nocturne.Duration = set_combine(sets.midcast.Debuffs.Duration)
	sets.midcast.Virelai.Duration = set_combine(sets.midcast.Debuffs.Duration)			
---- Aftercast  ----
    sets.aftercast = {}
	sets.aftercast.Idle = { -- Your movement speed goes here, mix of PDT/Refresh --
		range="Marsyas",
		ammo=empty,
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Infused Earring",
		right_ear="Ethereal	Earring",
		ring1="Defending Ring",
		right_ring="Karieyh Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}}
	sets.aftercast.Refresh = set_combine(sets.aftercast.Idle, { -- Refresh gears goes here --
		ear1="",
		hands="",
		feet=""})
	sets.aftercast.Pulling = set_combine(sets.aftercast.Idle, {}) -- For when you want you idle as full time PDT + Mov speed --
	sets.aftercast.Town = set_combine(sets.aftercast.Idle, { -- For town --
		range="Marsyas",
		ammo=empty,
		main="Naegling",
		sub="Gleti's Knife",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Bard's Charm +2",
		waist="Reiki Yotai",
		left_ear="Suppanomimi",
		right_ear="Brutal Earring",
		left_ring="Petrov Ring",
		right_ring="Chirich Ring +1",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}})
	sets.Resting = set_combine(sets.aftercast.Refresh, {})		
----  Melee  ----
    sets.engaged = {
		range="Linos",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Zoar Subligar +1",
		feet="Aya. Gambieras +2",
		neck="Bard's Charm +2",
		waist="Windbuffet Belt +1",
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Petrov Ring",
		right_ring="Chirich Ring +1",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}}
	
	sets.engaged.DualWield = {
		main="Naegling",
		sub="Gleti's Knife",
		range="Linos",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Zoar Subligar +1",
		feet="Aya. Gambieras +2",
		neck="Bard's Charm +2",
		waist="Reiki Yotai",
		left_ear="Suppanomimi",
		right_ear="Brutal Earring",
		left_ring="Petrov Ring",
		right_ring="Chirich Ring +1",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}}
	
-- for dnc/nin sub --
---- .::Pretarget Functions::. ---->
function pretarget(spell,action)	
-- Auto pianissimo --	
    if AutoPianissimo == 'ON' then
        if spell.type == 'BardSong' and spell.target.type == 'PLAYER' then
		    if windower.ffxi.get_ability_recasts()[112] < 1 and not buffactive[499] and not buffactive[16] then
                cancel_spell()
                send_command('input /ja "Pianissimo" <me>;wait 1.5;input /ma "'..spell.name..'" '..spell.target.name..';')	
			end
        end	
	end	
    -- Auto Remedy --
	if AutoRemedy == 'ON' then
        if buffactive['Silence'] or buffactive['Paralysis'] then
            if spell.action_type == 'Magic' or spell.type == 'JobAbility' then 	
                cancel_spell()
                send_command('input /item "Remedy" <me>')
            end				
		end	
	end
end	
---- .::Precast Functions::. ---->
function precast(spell)	
    if spell.action_type == 'Magic' then	
		-- Healing Magic --
	    if string.find(spell.english, 'Cure') or string.find(spell.english, 'Cura') then
		    equip(sets.precast.Cure)
		-- Enhancing Magic --	
		elseif spell.skill == 'Enhancing Magic' then
         	equip(sets.precast.Enhancing)
		-- Ninjutsu --	
        elseif string.find(spell.english, 'Utsusemi') then
            equip(sets.precast.Utsusemi)		
        -- Songs --			
	    elseif string.find(spell.english, 'Pastoral') or string.find(spell.english, 'Gavotte') or string.find(spell.english, 'Capriccio') or string.find(spell.english, 'Fantasia') or string.find(spell.english, 'Aubade') or string.find(spell.english, 'Bewitching') or string.find(spell.english, 'Logical') or string.find(spell.english, 'bewitching') or string.find(spell.english, 'logical') then
		    equip(sets.precast.Dummy) 
        elseif string.find(spell.english, 'March') then	
		    if spell.english == "Honor March" then
                if buffactive[347] then
                    equip(sets.midcast.Honor)
                else				
                    equip(sets.precast.Honor)	
			    end	
            elseif buffactive[347] then
                equip(sets.midcast.March)
            else				
                equip(sets.precast.March)	
			end												
		elseif string.find(spell.english,'Minuet') then
             if buffactive[347] then
                equip(sets.midcast.Minuet)
            else				
                equip(sets.precast.Minuet)	
			end			
		elseif string.find(spell.english,'Madrigal') then
            if buffactive[347] then
                equip(sets.midcast.Madrigal)
            else				
                equip(sets.precast.Madrigal)	
			end					
		elseif string.find(spell.english,'Prelude') then
            if buffactive[347] then
                equip(sets.midcast.Prelude)
            else				
                equip(sets.precast.Prelude)	
			end		
		elseif string.find(spell.english,'Carol') then
            if buffactive[347] then
                equip(sets.midcast.Carols)
            else				
                equip(sets.precast.Carols)	
			end		
		elseif string.find(spell.english,'Scherzo') then
            if buffactive[347] then
                equip(sets.midcast.Scherzo)
            else				
                equip(sets.precast.Scherzo)	
			end	
		elseif string.find(spell.english,'Minne') then
            if buffactive[347] then
                equip(sets.midcast.Minne)
            else				
                equip(sets.precast.Minne)	
			end	
		elseif string.find(spell.english,'Paeon') then
            if buffactive[347] then
                equip(sets.midcast.Paeon)
            else				
                equip(sets.precast.Paeon)	
			end	
		elseif string.find(spell.english,'Etude') then
            if buffactive[347] then
                equip(sets.midcast.Etude)
            else				
                equip(sets.precast.Etude)	
			end	
		elseif string.find(spell.english,'Hymnus') then
            if buffactive[347] then
                equip(sets.midcast.Hymnus)
            else				
                equip(sets.precast.Hymnus)	
			end	
		elseif string.find(spell.english,'Ballad') then
            if buffactive[347] then
                equip(sets.midcast.Ballad)
            else				
                equip(sets.precast.Ballad)	
			end	
		elseif string.find(spell.english,'Mambo') then
            if buffactive[347] then
                equip(sets.midcast.Mambo)
            else				
                equip(sets.precast.Mambo)	
			end		
		elseif string.find(spell.english,'Mazurka') then
            if buffactive[347] then
                equip(sets.midcast.Mazurka)
            else				
                equip(sets.precast.Mazurka)	
			end	
		elseif string.find(spell.english,'Dirge') then
            if buffactive[347] then
                equip(sets.midcast.Dirge)
            else				
                equip(sets.precast.Dirge)	
			end		
		elseif string.find(spell.english,'Sirvente') then
            if buffactive[347] then
                equip(sets.midcast.Sirvente)
            else				
                equip(sets.precast.Sirvente)	
			end	
		elseif string.find(spell.english,'Finale') then
            if buffactive[347] then
                equip(sets.midcast.Finale)
            else				
                equip(sets.precast.Finale)	
			end	
	    elseif string.find(spell.english,'Elegy') then
            if buffactive[347] then
                equip(sets.midcast.Elegy)
            else				
                equip(sets.precast.Elegy)	
			end			
		elseif string.find(spell.english,'Lullaby') then
            if buffactive[347] then
                equip(sets.midcast.Lullaby)
            else				
                equip(sets.precast.Lullaby)	
			end	
		elseif string.find(spell.english,'Requiem') then
            if buffactive[347] then
                equip(sets.midcast.Requiem)
            else				
                equip(sets.precast.Requiem)	
			end	
		elseif string.find(spell.english,'Threnody') then
            if buffactive[347] then
                equip(sets.midcast.Threnody)
            else				
                equip(sets.precast.Threnody)	
			end	
	    elseif string.find(spell.english,'Nocturne') then
            if buffactive[347] then
                equip(sets.midcast.Nocturne)
            else				
                equip(sets.precast.Nocturne)	
			end	
		elseif string.find(spell.english,'Virelai') then
            if buffactive[347] then
                equip(sets.midcast.Virelai)
            else				
                equip(sets.precast.Virelai)	
			end	
        -- Everything that have a specific name set --	
		elseif sets.precast[spell.english] then
	        equip(sets.precast[spell.english])				
        -- Everything else that doesn't have a specific set for it --			
		else
            equip(sets.precast.FC)
        end			
-- Job Abilities --
	elseif spell.type == "Waltz" then
		refine_waltz(spell,action)
		equip(sets.Waltz)
    elseif spell.type == 'JobAbility' then
        equip(sets.JA[spell.english])
    -- Weaponskills --
    elseif spell.type == 'WeaponSkill' then
        if sets.WS[spell.english] then	
            equip(sets.WS[spell.english])
	    else
		    equip(sets.WS)
		end	
    end		
end	
---- .::Midcast Functions::. ---->
function midcast(spell)
    if spell.action_type == 'Magic' then	
		-- Healing Magic --
	    if string.find(spell.english, 'Cure') or string.find(spell.english, 'Cura') then
		    if WeaponLock == 'ON' then
			    equip(sets.midcast.Cure.WeaponLock)
	        elseif spell.element == world.weather_element or spell.element == world.day_element then
                equip(sets.midcast.Cure.Weather)	
			else
                equip(sets.midcast.Cure)
			end
		-- Enhancing Magic --	
		elseif string.find(spell.english, 'Haste') or string.find(spell.english, 'Flurry') or string.find(spell.english, 'Regen') or string.find(spell.english, 'Reraise') then
         	equip(sets.midcast.Enhancing)
		-- Ninjutsu --	
        elseif string.find(spell.english, 'Utsusemi') then
            equip(sets.midcast.Utsusemi)			
        -- Bard Songs --		
	    elseif spell.type == 'BardSong' then
	        if string.find(spell.english, 'Pastoral') or string.find(spell.english, 'Gavotte') or string.find(spell.english, 'Capriccio') or string.find(spell.english, 'Fantasia') or string.find(spell.english, 'Aubade') then
		        equip(sets.midcast.Dummy)				
		    elseif spell.english == "Honor March" then
                equip(sets.midcast.Honor)	
			elseif spell.english == "Advancing March" then
                equip(sets.midcast.March)
    	    elseif spell.english == "Victory March" then
                equip(sets.midcast.March)				
			elseif string.find(spell.english,'Minuet') then
                equip(sets.midcast.Minuet)		
	        elseif string.find(spell.english,'Madrigal') then
                equip(sets.midcast.Madrigal)				
	        elseif string.find(spell.english,'Prelude') then
                equip(sets.midcast.Prelude)	
	        elseif string.find(spell.english,'Carol') then
                equip(sets.midcast.Carols)						
	        elseif string.find(spell.english,'Scherzo') then
                equip(sets.midcast.Scherzo)	
			elseif string.find(spell.english,'Minne') then
                equip(sets.midcast.Minne)
	        elseif string.find(spell.english,'Paeon') then
                equip(sets.midcast.Paeon)
	        elseif string.find(spell.english,'Etude') then
                equip(sets.midcast.Etude)
	        elseif string.find(spell.english,'Hymnus') then
                equip(sets.midcast.Hymnus)					
 	        elseif string.find(spell.english,'Ballad') then
                equip(sets.midcast.Ballad)
	        elseif string.find(spell.english,'Mambo') then
                equip(sets.midcast.Mambo)	
			elseif string.find(spell.english,'Mazurka') then
                equip(sets.midcast.Mazurka)
	        elseif string.find(spell.english,'Dirge') then
                equip(sets.midcast.Dirge)		
	        elseif string.find(spell.english,'Sirvente') then
                equip(sets.midcast.Sirvente)					
	        elseif string.find(spell.english,'Finale') then
                equip(sets.midcast.Finale)
    	    elseif string.find(spell.english,'Elegy') then
			    if buffactive[348] then
                    equip(sets.midcast.Elegy.Duration)
				else	
                    equip(sets.midcast.Elegy)
				end	
            -- Change your timers for lullaby here --				
	        elseif string.find(spell.english,'Lullaby') then
                if buffactive[52] and buffactive[499] and buffactive[348] then
                    equip(sets.midcast.Lullaby.Duration)
					-- If NT 2hr and Clarion is on --	
       			    windower.send_command('timers c "HQ Lullaby" 400')
                elseif buffactive[348]	then
                    equip(sets.midcast.Lullaby.Duration)
					-- if only NT is on --	
       			    windower.send_command('timers c "N/T Lullaby" 300')
				else	
					equip(sets.midcast.Lullaby)
				end	
	        elseif string.find(spell.english,'Requiem') then
			    if buffactive[348] then
                    equip(sets.midcast.Requiem.Duration)
				else	
                    equip(sets.midcast.Requiem)
				end	
	        elseif string.find(spell.english,'Threnody') then
			    if buffactive[348] then
                    equip(sets.midcast.Threnody.Duration)
				else	
                    equip(sets.midcast.Threnody)
				end	
     	    elseif string.find(spell.english,'Nocturne') then
			    if buffactive[348] then
                    equip(sets.midcast.Nocturne.Duration)
				else	
                    equip(sets.midcast.Nocturne)
				end	
	        elseif string.find(spell.english,'Virelai') then
                equip(sets.midcast.Virelai)					
            end	
        -- Everything that have a specific name set --	
		elseif sets.midcast[spell.english] then
	        equip(sets.midcast[spell.english])			
		-- Everything else that doesn't have a specific set for it --			
        else
		    equip(sets.midcast.Recast)
		end	
	end
end	
---- .::Aftercast Functions::. ---->
function aftercast(spell,action)
	status_change(player.status)	
end	
---- .::Status Changes Functions::. ---->
function status_change(new,tab,old)
    -- Idle --
    if new == 'Idle' then
        if Pulling == 'ON' then
            equip(sets.aftercast.Pulling)
        elseif Town:contains(world.zone) then	
            equip(sets.aftercast.Town)
        elseif player.mpp <80 then
            equip(sets.aftercast.Refresh)
        else
            equip(sets.aftercast.Idle)
        end
	-- Resting --	
	elseif new == 'Resting' then
        equip(sets.Resting)	
    -- Engaged --		
    elseif new == 'Engaged' then
	    if player.sub_job == 'DNC' or player.sub_job == 'NIN' then
            equip(sets.engaged.DualWield)	
		else	
            equip(sets.engaged)	
		end	
    end		
end 	
--- ..::Self Commands functions::.. --->
function self_command(command)
    status_change(player.status)
	-- Auto NT/2h/Clarion Call --
    if command == 'C1' then
        send_command('input /ja "Soul Voice" <me>;wait 1;input /ja "Nightingale" <me>;wait 1;input /ja "Troubadour" <me>;wait 1;input /ja "Clarion Call" <me>')					
    -- Pulling Mode --
    elseif command == 'C9' then
        if Pulling == 'ON' then
            Pulling = 'OFF'
            add_to_chat(123,'Pulling Set: [OFF]')
        else
            Pulling = 'ON'
            add_to_chat(158,'Pulling Set: [ON]')
        end
    -- Weapon Lock --		rr
    elseif command == 'C10' then
        if WeaponLock == 'ON' then
            WeaponLock = 'OFF'
            enable('main', 'sub')				
            add_to_chat(123,'Weapon Lock Set: [OFF]')
        else
            WeaponLock = 'ON'
            disable('main', 'sub')			
            add_to_chat(158,'Weapon Lock Set: [ON]')
        end	
    -- Capacity --		
    elseif command == 'C11' then
        if Capacity == 'ON' then
            Capacity = 'OFF'
            enable('back')				
            add_to_chat(123,'Capacity Cape Set: [OFF]')
        else
            Capacity = 'ON'
			equip({back=gear.Capacity_Cape})
			disable('back')
            add_to_chat(158,'Capacity Cape Set: [ON]')
        end
	end	
end	
-- Automatically changes Idle gears if you zone in or out of town --
windower.register_event('zone change', function()
	status_change(player.status)
	if Town:contains(world.zone) then	
        equip(sets.aftercast.Town)
    else
        equip(sets.aftercast.Idle)		
    end	
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type == "Waltz" then
		refine_waltz(spell,action)
		equip(sets.Waltz)
	elseif spell.english == 'Spectral Jig' and buffactive.Sneak then
		cast_delay(0.2)
		send_command('cancel Sneak')
	end
end


function refine_waltz(spell,action)
	if spell.type ~= 'Waltz' then
		return
	end

	if spell.name == "Healing Waltz" or spell.name == "Divine Waltz" or spell.name == "Divine Waltz II" then
		return
	end

	local newWaltz = spell.english
	local waltzID

	local missingHP

	if spell.target.type == "SELF" then
		missingHP = player.max_hp - player.hp
	elseif spell.target.isallymember then
		local target = find_player_in_alliance(spell.target.name)
		local est_max_hp = target.hp / (target.hpp/100)
		missingHP = math.floor(est_max_hp - target.hp)
	end

	if missingHP ~= nil then
		if player.sub_job == 'DNC' then
			if missingHP < 40 and spell.target.name == player.name then
				add_to_chat(8,'Full HP!')
				cancel_spell()
				return
			elseif missingHP < 150 then
				newWaltz = 'Curing Waltz'
				waltzID = 190
			elseif missingHP < 300 then
				newWaltz = 'Curing Waltz II'
				waltzID = 191
			else
				newWaltz = 'Curing Waltz III'
				waltzID = 192
			end
		else
			return
		end
	end

	local waltzTPCost = {['Curing Waltz'] = 20, ['Curing Waltz II'] = 35, ['Curing Waltz III'] = 50}
	local tpCost = waltzTPCost[newWaltz]

	local downgrade

	if player.tp < tpCost and not buffactive.trance then

		if player.tp < 20 then
			add_to_chat(8, 'Insufficient TP ['..tostring(player.tp)..']. Cancelling.')
			cancel_spell()
			return
		elseif player.tp < 35 then
			newWaltz = 'Curing Waltz'
		elseif player.tp < 50 then
			newWaltz = 'Curing Waltz II'
		end

		downgrade = 'Insufficient TP ['..tostring(player.tp)..']. Downgrading to '..newWaltz..'.'
	end

	if newWaltz ~= spell.english then
		send_command('@input /ja "'..newWaltz..'" '..tostring(spell.target.raw))
		if downgrade then
			add_to_chat(158, downgrade)
		end
		cancel_spell()
		return
	end

	if missingHP > 0 then
		add_to_chat(158,'Trying to cure '..tostring(missingHP)..' HP using '..newWaltz..'.')
	end
end
