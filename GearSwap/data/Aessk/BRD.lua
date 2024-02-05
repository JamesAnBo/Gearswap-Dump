----- Credit: Krystela of Asura | Last Update: 22 November 2016 ---->
---- .:: This was entirely created by me, it's not based off anyone's file ::. ---->
---- Always visit http://pastebin.com/u/KrystelaRose to look for possible updates ---->
---- .:: Please leave credit where it's due ::. ---->
---- .:: If you have any problem contact me via ffxiah: http://www.ffxiah.com/player/Asura/Krystela ::. ---->

function get_sets()

	include('organizer-lib')

	
	AccIndex = 1
	AccArray = {"LowACC","MaxACC"} -- 2 Levels Of Accuracy Sets For TP/WS/Hybrid. First Set Is LowACC. Add More ACC Sets If Needed Then Create Your New ACC Below. Most of These Sets Are Empty So You Need To Edit Them On Your Own. Remember To Check What The Combined Set Is For Each Sets. --
	WeaponIndex = 1
	WeaponArray = {"Naegling","Carnwenhan"} -- Default Main Weapon Is Conqueror. Can Delete Any Weapons/Sets That You Don't Need Or Replace/Add The New Weapons That You Want To Use. --
	IdleIndex = 1
	IdleArray = {"Movement","Regen"} -- Default Idle Set Is Movement --
	target_distance = 5 -- Set Default Distance Here --
	
	lockstyleset = 84
	set_lockstyle()
	
-- Binds for modes
    send_command('bind ^f9 gs c C9')
	send_command('bind ^f10 gs c C10')
    send_command('bind ^f11 gs c C11')
  -- Auto Functions --
    AutoPianissimo = 'ON' -- Set to On if you want Pianissimo to be automatically used, otherwise set to OFF --
	AutoRemedy = 'OFF' -- Set to ON if you want to auto use remedies if silenced or Paralyzed, otherwise set to OFF --	  
-- Modes --
    Pulling = 'OFF' -- Press ctrl + F9 if you want to equip mov+ feet and Defense Set as aftercast --
	WeaponLock = 'OFF' -- Press ctrl + F10 for Weapon Lock--
    Capacity = 'OFF' -- Press Ctrl +F11 to have Capacity cape locked on while Idle, Change the cape at line 40 --
-- Gears --
    gear = {}
	gear.Capacity_Cape = {name="Mecisto. Mantle"} -- The cape you use for capacity --
-- Set macro book/set --
    send_command('input /macro book 6;wait .1;input /macro set 1') -- set macro book/set here --
-- Area mapping --	
    Town = S{"Ru'Lude Gardens","Upper Jeuno","Lower Jeuno","Port Jeuno","Port Windurst","Windurst Waters","Windurst Woods","Windurst Walls","Heavens Tower",
	         "Port San d'Oria","Northern San d'Oria","Southern San d'Oria","Port Bastok","Bastok Markets","Bastok Mines","Metalworks","Aht Urhgan Whitegate",
	         "Tavanazian Safehold","Nashmau","Selbina","Mhaura","Norg","Eastern Adoulin","Western Adoulin","Kazham"}	

	organizer_items = {
		remedy="Remedy",
		shihei="Shihei",
		shihei_bag="Toolbag (Shihei)",
		grape="Grape Daifuku +1",
		maze="Maze Tabula M01",
		mog_amp="Moogle Amp.",
	}

---- Precast ----
    sets.precast = {}
	
	-- Base Set --																																
	sets.precast.FC = {																															--fc/haste
		main={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}},																	--7/0
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},																--10/8																		
		body="Inyanga Jubbah +2",																												--14/2
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},							--5/8
		legs="Aya. Cosciales +2",																												--6/9
		feet="Aya. Gambieras +2",																												--0/3
		neck="Baetyl Pendant",																													--4/0
		waist="Embla Sash",																														--5/0
		left_ear="Loquac. Earring",																												--2/0
		right_ear="Enchntr. Earring +1",																										--2/0
		left_ring="Prolix Ring",																												--2/0
		right_ring="Kishar Ring",																												--4/0
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},	--10/0
	}																																			--total:71/30
		
	-- Healing Magic --
	sets.precast.Cure = set_combine(sets.precast.FC, {})
		
	-- Enhancing Magic --	
	sets.precast.Enhancing = set_combine(sets.precast.FC, {
		waist="Siegel Sash",
	})
	
	sets.precast['Stoneskin'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash",
	})
	
	-- Ninjutsu --
	sets.precast.Utsusemi = set_combine(sets.precast.FC, {
	})
	
	-- Waltz Set --
	sets.Waltz = {
	}
	
	-- Songs --
	sets.precast.SSC = {  -- If you have Gjallarhorn, make sure to put it in this set, if you don't, leave the range empty --			fc/songcast
	    main={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}},																--7/0
		range="Gjallarhorn",
		head="Fili Calot +1",																												--0/14
		body="Inyanga Jubbah +2",																											--14/0
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -4%','Song spellcasting time -5%',}},			--7/5
		legs="Aya. Cosciales +2",																											--6/0
		feet={ name="Telchine Pigaches", augments={'Song spellcasting time -7%','Enh. Mag. eff. dur. +10',}},								--0/13
		neck="Mnbw. Whistle +1",																										
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",																										--1/0
		right_ear="Eabani Earring",																									
		left_ring="defending Ring",
		right_ring="Kishar Ring",																											--4/0
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},--10/0
	}																																		--total: 81
	
-- If you cast Pastoral/Gavotte/Capriccio/Fantasia/Aubade it will equip this set automatically --	 	
	sets.precast.Dummy = set_combine(sets.precast.SSC, {range="Daurdabla"}) -- Make sure to have Daurdabla or Terpender in this set --	
    -- If you have Gjallarhorn, take out the instruments in these sets --
	--If you dont have Gjallarhorn, put your appropriate instrument in here --	
	sets.precast.Honor= set_combine(sets.precast.SSC,{Range="Marsyas"})
	sets.precast.March= set_combine(sets.precast.SSC,{})
    sets.precast.Minuet= set_combine(sets.precast.SSC,{})
	sets.precast.Madrigal= set_combine(sets.precast.SSC,{})
	sets.precast.Prelude= set_combine(sets.precast.SSC,{})
	sets.precast.Carols= set_combine(sets.precast.SSC,{})
	sets.precast.Scherzo= set_combine(sets.precast.SSC,{})
	sets.precast.Minne= set_combine(sets.precast.SSC,{})
	sets.precast.Paeon= set_combine(sets.precast.SSC,{})
	sets.precast.Etude= set_combine(sets.precast.SSC,{})
	sets.precast.Hymnus= set_combine(sets.precast.SSC,{})
	sets.precast.Ballad= set_combine(sets.precast.SSC,{})
	sets.precast.Mambo= set_combine(sets.precast.SSC,{})
	sets.precast.Mazurka= set_combine(sets.precast.SSC,{})
	sets.precast.Dirge= set_combine(sets.precast.SSC,{})
	sets.precast.Sirvente= set_combine(sets.precast.SSC,{})	
    sets.precast.Finale= set_combine(sets.precast.SSC,{})
	sets.precast.Elegy= set_combine(sets.precast.SSC,{})
	sets.precast.Lullaby= set_combine(sets.precast.SSC,{})
	sets.precast.Requiem= set_combine(sets.precast.SSC,{})
	sets.precast.Threnody= set_combine(sets.precast.SSC,{})
	sets.precast.Nocturne= set_combine(sets.precast.SSC,{})
	sets.precast.Virelai= set_combine(sets.precast.SSC,{})
	
    -- Job Abilities --
    sets.JA = {}
    sets.JA['Nightingale'] = {feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}}}
    sets.JA['Troubadour'] = {body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}}}
    sets.JA['Soul Voice'] = {legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}}}
    
	-- Weaponskills --
    sets.WS = {
		--range={ name="Linos", augments={'Accuracy+17','Weapon skill damage +3%','STR+8',}},
		head={ name="Bihu Roundlet +3", augments={'Enhances "Con Anima" effect',}},
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}},
		legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},
		feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
		left_ring="Rufescent Ring",
		right_ring="Epaminondas's Ring",
		 back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
    
	sets.WS['Aeolian Edge'] = {
		head="Nyame Helm",   
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}
	
	sets.WS['Savage Blade']  = {
		range={ name="Linos", augments={'Accuracy+17','Weapon skill damage +3%','STR+8',}},
		head="Nyame Helm",
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
		left_ring="Rufescent Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	sets.WS['Evisceration'] = {
		head="Aya. Zucchetto +2",
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Bard's Charm +2",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Brutal Earring",
		left_ring="Karieyh Ring",
		right_ring="Ayanmo Ring",
		 back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
    
	sets.WS['Exenterator'] = {
		head="Aya. Zucchetto +2",
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Bard's Charm +2",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Brutal Earring",
		left_ring="Karieyh Ring",
		right_ring="Ayanmo Ring",
		 back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
    
	sets.WS['Rudra\'s Storm'] = {
		head="Nyame Helm",
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Bard's Charm +2",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Brutal Earring",
		left_ring="Karieyh Ring",
		right_ring="Ayanmo Ring",
		 back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
    
	sets.WS['Mordant Rime'] = {
		head="Nyame Helm",
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Bard's Charm +2",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Brutal Earring",
		left_ring="Karieyh Ring",
		right_ring="Ayanmo Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','"Weapon skill damage +10%'}}
	}
	
---- Midcast  ----
    sets.midcast = {}
	
 	-- Base Set --
	sets.midcast.Recast = { 	
		main="Carnwenhan",																--7/0
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},																--10/8																		
		body="Inyanga Jubbah +2",																												--14/2
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},							--5/8
		legs="Aya. Cosciales +2",																												--6/9
		feet="Aya. Gambieras +2",																												--0/3
		neck="Baetyl Pendant",																													--4/0
		waist="Embla Sash",																														--5/0
		left_ear="Loquac. Earring",																												--2/0
		right_ear="Enchntr. Earring +1",																										--2/0
		left_ring="Prolix Ring",																												--2/0
		right_ring="Kishar Ring",																												--4/0
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},	--10/0
	}																																			--total:71/30
		
	-- Healing Magic --
	sets.midcast.Cure = {
	    main="Daybreak",
		sub="Ammurapi Shield",
       -- sub="Clerisy Strap +1",
	    --head="Kaykaus Mitra +1",
	    neck="Moonbow Whistle +1",
		ear1="Loquacious Earring",
        ear2="Mendi. Earring",			
	   -- body="Chironic Doublet",
	    --hands="Kaykaus Cuffs +1",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		--back="Solemnity Cape",
		--waist="Rumination Sash",
		--legs="Chironic Hose",
		--feet="Kaykaus Boots +1"
	}
	sets.midcast.Cure.Weather = set_combine(sets.midcast.Cure, {
	    main="Chatoyant Staff",
        back="Twilight Cape",
        waist="Hachirin-no-Obi",
        legs="Chironic Hose"
	})		
	sets.midcast.Cure.WeaponLock = set_combine(sets.midcast.Cure, { -- For when weapon is locked --
        ring1="Lebeche Ring",
        legs="Chironic Hose"
	})	
    sets.midcast['Cursna'] = set_combine(sets.midcast.Recast, {  -- for doom removal gears --	
		neck="Moonbow Whistle +1",
		ring1="Haoma's Ring",
		ring2="Haoma's Ring",
	})
	
    -- Enhancing Magic --
	sets.midcast.Enhancing = set_combine(sets.midcast.Recast, { -- For haste/refresh/regen/Reraise --
		sub="Ammurapi Shield",
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Cure" potency +3%','Enh. Mag. eff. dur. +10',}},
		feet={ name="Telchine Pigaches", augments={'Song spellcasting time -7%','Enh. Mag. eff. dur. +10',}},
		waist="Embla Sash",
	})
	sets.midcast['Stoneskin'] = {
		waist="Siegel Sash",
	}	
    sets.midcast['Aquaveil'] = {}
	
    -- Ninjutsu --
    sets.midcast.Utsusemi = set_combine(sets.midcast.Recast, {})
	
	-- Bard Songs --
-- If you cast Pastoral/Gavotte/Capriccio/Fantasia/Aubade it will equip this set automatically --	
	sets.midcast.Dummy = { -- Make sure to have Daurdabla or Terpender in this set --
   		range="Daurdabla",
		ammo=empty,
		head="Aya. Zucchetto +2",
		body="Inyanga Jubbah +2",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Mnbw. Whistle +1",
		waist="Luminary Sash",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Prolix Ring",
		right_ring="Kishar Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
	}
	sets.midcast.Buffs = { -- If you have Gjallarhorn, make sure to put it in this set, if you don't, leave the range empty --
		main="Carnwenhan",
		sub={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}},
		range="Gjallarhorn",
		head="Fili Calot +1",
		body="Fili Hongreline +1",
		hands="Fili Manchettes +1",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Flume Belt +1",
		left_ear="Sanare Earring",
		right_ear="Etiolation Earring",
		left_ring="defending Ring",
		right_ring="Moonlight Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
	}
		
-- If you have Gjallarhorn, take out the instruments in these sets --
-- If you dont have Gjallarhorn, put your appropriate instrument in here --	
	sets.midcast.Honor = set_combine(sets.midcast.Buffs, {range="Marsyas"})
	sets.midcast.March = set_combine(sets.midcast.Buffs, {hands="Fili Manchettes +1"})
    sets.midcast.Minuet = set_combine(sets.midcast.Buffs, {body="Fili Hongreline +1"})
	sets.midcast.Madrigal = set_combine(sets.midcast.Buffs, {head="Fili Calot +1", back="Intarabus's Cape"})
	sets.midcast.Prelude = set_combine(sets.midcast.Buffs, {back="Intarabus's Cape"})
	sets.midcast.Carols = set_combine(sets.midcast.Buffs, {hands="Mousai Gages +1"})
	sets.midcast.Scherzo = set_combine(sets.midcast.Buffs, {feet="Fili Cothurnes +1"})
	sets.midcast.Minne = set_combine(sets.midcast.Buffs, {legs="Mou. Seraweels +1"})
	sets.midcast.Paeon = set_combine(sets.midcast.Buffs, {head="Brioso Roundlet +3"})
	sets.midcast.Etude = set_combine(sets.midcast.Buffs, {})
	sets.midcast.Hymnus = set_combine(sets.midcast.Buffs, {})
	sets.midcast.Ballad = set_combine(sets.midcast.Buffs, {legs="Fili Rhingrave +1"})
	sets.midcast.Mambo = set_combine(sets.midcast.Buffs, {})
	sets.midcast.Mazurka = set_combine(sets.midcast.Buffs, {})
	sets.midcast.Dirge = set_combine(sets.midcast.Buffs, {})
	sets.midcast.Sirvente = set_combine(sets.midcast.Buffs, {})
	
	sets.midcast.Debuffs = { -- If you have Gjallarhorn, make sure to put it in this set, if you don't, leave the range empty --
		main="Carnwenhan",
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head="Brioso Roundlet +3",
		body="Ayanmo Corazza +2",
		hands="Brioso Cuffs +3",
		legs="Aya. Cosciales +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Luminary Sash",
		left_ear="Digni. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
	}
	
-- If you have Gjallarhorn, take out the instruments in these sets --
-- If you dont have Gjallarhorn, put your appropriate instrument in here --		
    sets.midcast.Finale = set_combine(sets.midcast.Debuffs,  {})
	sets.midcast.Elegy = set_combine(sets.midcast.Debuffs,  {})
	sets.midcast.Lullaby = set_combine(sets.midcast.Debuffs,  {range="Blurred Harp +1",hands="Brioso Cuffs +3"})
	sets.midcast.Requiem = set_combine(sets.midcast.Debuffs,  {})
	sets.midcast.Threnody = set_combine(sets.midcast.Debuffs, {body="Mou. Manteel +1"})
	sets.midcast.Nocturne = set_combine(sets.midcast.Debuffs,  {})
	sets.midcast.Virelai = set_combine(sets.midcast.Debuffs,  {})
	-- For when N/T is on --	
-- If you have Marsyas make sure to put in this set --
-- If you dont have Marsyas but you have Gjallarhorn, put it in this set --
-- If you have none of the above instruments, leave it empty --		
	sets.midcast.Debuffs.Duration = set_combine(sets.midcast.Debuffs, { 
		range="Marsyas",
		ammo=empty,
		body="Fili Hongreline +1",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3"
	})	
-- If you have Marsyas or Gjallarhorn, take out the instruments from these sets --
-- If you have none of the above instruments, add the appropriate instruments --			
	sets.midcast.Elegy.Duration = set_combine(sets.midcast.Debuffs.Duration)
	sets.midcast.Lullaby.Duration = set_combine(sets.midcast.Debuffs.Duration, {range="Blurred Harp +1", hands="Brioso Cuffs +3"})
	sets.midcast.Requiem.Duration = set_combine(sets.midcast.Debuffs.Duration)
	sets.midcast.Threnody.Duration = set_combine(sets.midcast.Debuffs.Duration, {body="Mou. Manteel +1"})
	sets.midcast.Nocturne.Duration = set_combine(sets.midcast.Debuffs.Duration)
	sets.midcast.Virelai.Duration = set_combine(sets.midcast.Debuffs.Duration)			
---- Aftercast  ----
    sets.aftercast = {}
	sets.aftercast.Idle = { -- Your movement speed goes here, mix of PDT/Refresh --
		range="Marsyas",
		ammo=empty,
		head="Nyame Helm",   
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Eabani Earring",
		right_ear="Sanare Earring",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
	}
	sets.aftercast.Refresh = set_combine(sets.aftercast.Idle, { -- Refresh gears goes here --
	})
	sets.aftercast.Pulling = set_combine(sets.aftercast.Idle, {}) -- For when you want you idle as full time PDT + Mov speed --
	sets.aftercast.Town = set_combine(sets.aftercast.Idle, { -- For town --
		range="Marsyas",
		ammo=empty,
		body="Councilor's Garb"
	})
	sets.Resting = set_combine(sets.aftercast.Refresh, {})		
----  Melee  ----
    sets.engaged = {
		--main="Naegling",
		main="Carnwenhan",
		--main="Twashtar",
		sub="Ammurapi Shield",
		--range={ name="Linos", augments={'Accuracy+13 Attack+13','"Dbl.Atk."+3','Quadruple Attack +3',}},
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Bunzi's Gloves",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		left_ear="Suppanomimi",
		right_ear="Brutal Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
	sets.engaged.DualWield = {
		--main="Naegling",
		--main="Tauret",
		main="Carnwenhan",
		sub="Ternion Dagger +1",
		--range={ name="Linos", augments={'Accuracy+13 Attack+13','"Dbl.Atk."+3','Quadruple Attack +3',}},
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Bunzi's Gloves",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Windbuffet Belt +1",
		left_ear="Suppanomimi",
		right_ear="Brutal Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	
-- for dnc/nin sub --
end	

-- spell maps --

spell_maps = {
    ['Cure']='Cure',['Cure II']='Cure',['Cure III']='Cure',['Cure IV']='Cure',['Cure V']='Cure',['Cure VI']='Cure',
    ['Full Cure']='Cure',
    ['Cura']='Curaga',['Cura II']='Curaga',['Cura III']='Curaga',
    ['Curaga']='Curaga',['Curaga II']='Curaga',['Curaga III']='Curaga',['Curaga IV']='Curaga',['Curaga V']='Curaga',
    -- Status Removal doesn't include Esuna or Sacrifice, since they work differently than the rest
    ['Poisona']='StatusRemoval',['Paralyna']='StatusRemoval',['Silena']='StatusRemoval',['Blindna']='StatusRemoval',['Cursna']='StatusRemoval',
    ['Stona']='StatusRemoval',['Viruna']='StatusRemoval',['Erase']='StatusRemoval',
    ['Barfire']='BarElement',['Barstone']='BarElement',['Barwater']='BarElement',['Baraero']='BarElement',['Barblizzard']='BarElement',['Barthunder']='BarElement',
    ['Barfira']='BarElement',['Barstonra']='BarElement',['Barwatera']='BarElement',['Baraera']='BarElement',['Barblizzara']='BarElement',['Barthundra']='BarElement',
    ['Raise']='Raise',['Raise II']='Raise',['Raise III']='Raise',['Arise']='Raise',
    ['Reraise']='Reraise',['Reraise II']='Reraise',['Reraise III']='Reraise',['Reraise IV']='Reraise',
    ['Protect']='Protect',['Protect II']='Protect',['Protect III']='Protect',['Protect IV']='Protect',['Protect V']='Protect',
    ['Shell']='Shell',['Shell II']='Shell',['Shell III']='Shell',['Shell IV']='Shell',['Shell V']='Shell',
    ['Protectra']='Protectra',['Protectra II']='Protectra',['Protectra III']='Protectra',['Protectra IV']='Protectra',['Protectra V']='Protectra',
    ['Shellra']='Shellra',['Shellra II']='Shellra',['Shellra III']='Shellra',['Shellra IV']='Shellra',['Shellra V']='Shellra',
    ['Regen']='Regen',['Regen II']='Regen',['Regen III']='Regen',['Regen IV']='Regen',['Regen V']='Regen',
    ['Refresh']='Refresh',['Refresh II']='Refresh',['Refresh III']='Refresh',
    ['Teleport-Holla']='Teleport',['Teleport-Dem']='Teleport',['Teleport-Mea']='Teleport',['Teleport-Altep']='Teleport',['Teleport-Yhoat']='Teleport',
    ['Teleport-Vahzl']='Teleport',['Recall-Pashh']='Teleport',['Recall-Meriph']='Teleport',['Recall-Jugner']='Teleport',
    ['Valor Minuet']='Minuet',['Valor Minuet II']='Minuet',['Valor Minuet III']='Minuet',['Valor Minuet IV']='Minuet',['Valor Minuet V']='Minuet',
    ["Knight's Minne"]='Minne',["Knight's Minne II"]='Minne',["Knight's Minne III"]='Minne',["Knight's Minne IV"]='Minne',["Knight's Minne V"]='Minne',
    ['Advancing March']='March',['Victory March']='March',['Honor March']='March',
    ['Sword Madrigal']='Madrigal',['Blade Madrigal']='Madrigal',
    ["Hunter's Prelude"]='Prelude',["Archer's Prelude"]='Prelude',
    ['Sheepfoe Mambo']='Mambo',['Dragonfoe Mambo']='Mambo',
    ['Raptor Mazurka']='Mazurka',['Chocobo Mazurka']='Mazurka',
    ['Sinewy Etude']='Etude',['Dextrous Etude']='Etude',['Vivacious Etude']='Etude',['Quick Etude']='Etude',['Learned Etude']='Etude',['Spirited Etude']='Etude',['Enchanting Etude']='Etude',
    ['Herculean Etude']='Etude',['Uncanny Etude']='Etude',['Vital Etude']='Etude',['Swift Etude']='Etude',['Sage Etude']='Etude',['Logical Etude']='Etude',['Bewitching Etude']='Etude',
    ["Mage's Ballad"]='Ballad',["Mage's Ballad II"]='Ballad',["Mage's Ballad III"]='Ballad',
    ["Army's Paeon"]='Paeon',["Army's Paeon II"]='Paeon',["Army's Paeon III"]='Paeon',["Army's Paeon IV"]='Paeon',["Army's Paeon V"]='Paeon',["Army's Paeon VI"]='Paeon',
    ['Fire Carol']='Carol',['Ice Carol']='Carol',['Wind Carol']='Carol',['Earth Carol']='Carol',['Lightning Carol']='Carol',['Water Carol']='Carol',['Light Carol']='Carol',['Dark Carol']='Carol',
    ['Fire Carol II']='Carol',['Ice Carol II']='Carol',['Wind Carol II']='Carol',['Earth Carol II']='Carol',['Lightning Carol II']='Carol',['Water Carol II']='Carol',['Light Carol II']='Carol',['Dark Carol II']='Carol',
    ['Foe Lullaby']='Lullaby',['Foe Lullaby II']='Lullaby',['Horde Lullaby']='Lullaby',['Horde Lullaby II']='Lullaby',
    ['Fire Threnody']='Threnody',['Ice Threnody']='Threnody',['Wind Threnody']='Threnody',['Earth Threnody']='Threnody',['Lightning Threnody']='Threnody',['Water Threnody']='Threnody',['Light Threnody']='Threnody',['Dark Threnody']='Threnody',
    ['Fire Threnody II']='Threnody',['Ice Threnody II']='Threnody',['Wind Threnody II']='Threnody',['Earth Threnody II']='Threnody',['Lightning Threnody II']='Threnody',['Water Threnody II']='Threnody',['Light Threnody II']='Threnody',['Dark Threnody II']='Threnody',
    ['Battlefield Elegy']='Elegy',['Carnage Elegy']='Elegy',
    ['Foe Requiem']='Requiem',['Foe Requiem II']='Requiem',['Foe Requiem III']='Requiem',['Foe Requiem IV']='Requiem',['Foe Requiem V']='Requiem',['Foe Requiem VI']='Requiem',['Foe Requiem VII']='Requiem',
	["Sentinel's Scherzo"]='Scherzo',
	["Goddess's Hymnus"]='Hymnus',
	["Adventurer's Dirge"]='Dirge',
	['Foe Sirvente']='Sirvente',
	['Magic Finale']='Finale',
	['Pining Nocturne']='Nocturne',
	["Maiden's Virelai"]='Virelai',
    ['Utsusemi: Ichi']='Utsusemi',['Utsusemi: Ni']='Utsusemi',['Utsusemi: San']='Utsusemi',
    ['Katon: Ichi'] = 'ElementalNinjutsu',['Suiton: Ichi'] = 'ElementalNinjutsu',['Raiton: Ichi'] = 'ElementalNinjutsu',
    ['Doton: Ichi'] = 'ElementalNinjutsu',['Huton: Ichi'] = 'ElementalNinjutsu',['Hyoton: Ichi'] = 'ElementalNinjutsu',
    ['Katon: Ni'] = 'ElementalNinjutsu',['Suiton: Ni'] = 'ElementalNinjutsu',['Raiton: Ni'] = 'ElementalNinjutsu',
    ['Doton: Ni'] = 'ElementalNinjutsu',['Huton: Ni'] = 'ElementalNinjutsu',['Hyoton: Ni'] = 'ElementalNinjutsu',
    ['Katon: San'] = 'ElementalNinjutsu',['Suiton: San'] = 'ElementalNinjutsu',['Raiton: San'] = 'ElementalNinjutsu',
    ['Doton: San'] = 'ElementalNinjutsu',['Huton: San'] = 'ElementalNinjutsu',['Hyoton: San'] = 'ElementalNinjutsu',
    ['Banish']='Banish',['Banish II']='Banish',['Banish III']='Banish',['Banishga']='Banish',['Banishga II']='Banish',
    ['Holy']='Holy',['Holy II']='Holy',['Drain']='Drain',['Drain II']='Drain',['Drain III']='Drain',['Aspir']='Aspir',['Aspir II']='Aspir',
    ['Absorb-Str']='Absorb',['Absorb-Dex']='Absorb',['Absorb-Vit']='Absorb',['Absorb-Agi']='Absorb',['Absorb-Int']='Absorb',['Absorb-Mnd']='Absorb',['Absorb-Chr']='Absorb',
    ['Absorb-Acc']='Absorb',['Absorb-TP']='Absorb',['Absorb-Attri']='Absorb',
    ['Enlight']='Enlight',['Enlight II']='Enlight',['Endark']='Endark',['Endark II']='Endark',
    ['Burn']='ElementalEnfeeble',['Frost']='ElementalEnfeeble',['Choke']='ElementalEnfeeble',['Rasp']='ElementalEnfeeble',['Shock']='ElementalEnfeeble',['Drown']='ElementalEnfeeble',
    ['Pyrohelix']='Helix',['Cryohelix']='Helix',['Anemohelix']='Helix',['Geohelix']='Helix',['Ionohelix']='Helix',['Hydrohelix']='Helix',['Luminohelix']='Helix',['Noctohelix']='DarkHelix',
    ['Pyrohelix II']='Helix',['Cryohelix II']='Helix',['Anemohelix II']='Helix',['Geohelix II']='Helix',['Ionohelix II']='Helix',['Hydrohelix II']='Helix',['Luminohelix II']='Helix',['Noctohelix II']='DarkHelix',
    ['Firestorm']='Storm',['Hailstorm']='Storm',['Windstorm']='Storm',['Sandstorm']='Storm',['Thunderstorm']='Storm',['Rainstorm']='Storm',['Aurorastorm']='Storm',['Voidstorm']='Storm',
    ['Firestorm II']='Storm',['Hailstorm II']='Storm',['Windstorm II']='Storm',['Sandstorm II']='Storm',['Thunderstorm II']='Storm',['Rainstorm II']='Storm',['Aurorastorm II']='Storm',['Voidstorm II']='Storm',
    ['Fire Maneuver']='Maneuver',['Ice Maneuver']='Maneuver',['Wind Maneuver']='Maneuver',['Earth Maneuver']='Maneuver',['Thunder Maneuver']='Maneuver',
    ['Water Maneuver']='Maneuver',['Light Maneuver']='Maneuver',['Dark Maneuver']='Maneuver',
}

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
		elseif spell.skill == 'Enhancing Magic' or string.find(spell.english, 'storm') then
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
		elseif string.find(spell.english, 'Haste') or string.find(spell.english, 'Flurry') or string.find(spell.english, 'Regen') or string.find(spell.english, 'Reraise') or string.find(spell.english, 'storm') then
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

function pretarget(spell,action)
	if spell.action_type == 'Magic' and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
		cancel_spell()
		send_command('input /item "Echo Drops" <me>')
	elseif spell.english == "Berserk" and buffactive.Berserk then -- Change Berserk To Aggressor If Berserk Is On --
		cancel_spell()
		send_command('Aggressor')
	elseif spell.english == "Seigan" and buffactive.Seigan then -- Change Seigan To Third Eye If Seigan Is On --
		cancel_spell()
		send_command('ThirdEye')
	elseif spell.english == "Meditate" and player.tp > 2900 then -- Cancel Meditate If TP Is Above 2900 --
		cancel_spell()
		add_to_chat(123, spell.name .. ' Canceled: ['..player.tp..' TP]')
	elseif spell.type == 'WeaponSkill' and player.status == 'Engaged' then
		if spell.english ~= 'Bora Axe' and spell.name ~= 'Mistral Axe' and spell.target.distance > target_distance then -- Cancel WS If You Are Out Of Range --
			cancel_spell()
			add_to_chat(123, spell.name..' Canceled: [Out of Range]')
			return
		end
	end
end


-- function precast(spell,action)
	-- if spell.type == "WeaponSkill" then
		-- if player.status ~= 'Engaged' then -- Cancel WS If You Are Not Engaged. Can Delete It If You Don't Need It --
			-- cancel_spell()
			-- add_to_chat(123,'Unable To Use WeaponSkill: [Disengaged]')
			-- return
		-- else
			-- equipSet = sets.WS
			-- if equipSet[spell.english] then
				-- equipSet = equipSet[spell.english]
			-- end
			-- if Attack == 'ON' then
				-- equipSet = equipSet["ATT"]
			-- end
			-- if equipSet[AccArray[AccIndex]] then
				-- equipSet = equipSet[AccArray[AccIndex]]
			-- end
			-- if buffactive["Mighty Strikes"] then -- Equip MS_WS Set When You Have Mighty Strikes On --
				-- equipSet = set_combine(equipSet,sets.MS_WS)
			-- end
			-- if buffactive['Reive Mark'] then -- Equip Ygnas's Resolve +1 During Reive --
				-- equipSet = set_combine(equipSet,{neck="Ygnas's Resolve +1"})
			-- end
			-- if (spell.english == "Ukko's Fury" or spell.english == "King's Justice") and (player.tp > 2990 or buffactive.Sekkanoki) then
				-- if world.time <= (7*60) or world.time >= (17*60) then -- 3000 TP or Sekkanoki: Equip Lugra Earring +1 From Dusk To Dawn --
					-- equipSet = set_combine(equipSet,{ear1="Lugra Earring +1"})
				-- else
					-- equipSet = set_combine(equipSet,{ear1="Kokou's Earring"}) -- 3000 TP or Sekkanoki: Equip Kokou's Earring --
				-- end
			-- end
			-- if spell.english == "Upheaval" then 
				-- if world.day_element == 'Dark' then -- Equip Shadow Mantle On Darksday --
					-- equipSet = set_combine(equipSet,{back="Shadow Mantle"})
				-- end
				-- if player.tp > 2990 or buffactive.Sekkanoki then
					-- if world.time <= (7*60) or world.time >= (17*60) then -- 3000 TP or Sekkanoki: Equip Lugra Earring +1 From Dusk To Dawn --
						-- equipSet = set_combine(equipSet,{ear1="Lugra Earring +1"})
					-- else
						-- equipSet = set_combine(equipSet,{ear1="Terra's Pearl"}) -- 3000 TP or Sekkanoki: Equip Terra's Earring --
					-- end
				-- end
			-- end
			-- equip(equipSet)
		-- end
	-- elseif spell.type == "JobAbility" then
		-- if sets.JA[spell.english] then
			-- equip(sets.JA[spell.english])
		-- end
	-- elseif spell.action_type == 'Magic' then
		-- if spell.english == 'Utsusemi: Ni' then
			-- if buffactive['Copy Image (3)'] then
				-- cancel_spell()
				-- add_to_chat(123, spell.name .. ' Canceled: [3 Images]')
				-- return
			-- else
				-- equip(sets.precast.FC)
			-- end
		-- else
			-- equip(sets.precast.FC)
		-- end
	-- elseif spell.type == "Waltz" then
		-- refine_waltz(spell,action)
		-- equip(sets.Waltz)
	-- elseif spell.english == 'Spectral Jig' and buffactive.Sneak then
		-- cast_delay(0.2)
		-- send_command('cancel Sneak')
	-- end
	-- if Twilight == 'Twilight' then
		-- equip(sets.Twilight)
	-- end
-- end

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

-- In Game: //gs c (command), Macro: /console gs c (command), Bind: gs c (command) --
function self_command(command)
	if command == 'C1' then -- Accuracy Toggle --
		AccIndex = (AccIndex % #AccArray) + 1
		add_to_chat(158,'Accuracy Level: ' .. AccArray[AccIndex])
		status_change(player.status)
	elseif command == 'C17' then -- Main Weapon Toggle --
		WeaponIndex = (WeaponIndex % #WeaponArray) + 1
		add_to_chat(158,'Main Weapon: '..WeaponArray[WeaponIndex])
		status_change(player.status)
	elseif command == 'C5' then -- Auto Update Gear Toggle --
		status_change(player.status)
		add_to_chat(158,'Auto Update Gear')
	elseif command == 'C2' then -- Hybrid Toggle --
		if Armor == 'Hybrid' then
			Armor = 'None'
			add_to_chat(123,'Hybrid Set: [Unlocked]')
		else
			Armor = 'Hybrid'
			add_to_chat(158,'Hybrid Set: '..AccArray[AccIndex])
		end
		status_change(player.status)
	elseif command == 'C7' then -- PDT Toggle --
		if Armor == 'PDT' then
			Armor = 'None'
			add_to_chat(123,'PDT Set: [Unlocked]')
		else
			Armor = 'PDT'
			add_to_chat(158,'PDT Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C15' then -- MDT Toggle --
		if Armor == 'MDT' then
			Armor = 'None'
			add_to_chat(123,'MDT Set: [Unlocked]')
		else
			Armor = 'MDT'
			add_to_chat(158,'MDT Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C12' then -- Kiting Toggle --
		if Armor == 'Kiting' then
			Armor = 'None'
			add_to_chat(123,'Kiting Set: [Unlocked]')
		else
			Armor = 'Kiting'
			add_to_chat(158,'Kiting Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C10' then -- Retaliation Toggle --
		if Retaliation == 'ON' then
			Retaliation = 'OFF'
			add_to_chat(123,'Retaliation Set: [Unlocked]')
		else
			Retaliation = 'ON'
			add_to_chat(158,'Retaliation Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C16' then -- Rancor Toggle --
		if Rancor == 'ON' then
			Rancor = 'OFF'
			add_to_chat(123,'Rancor: [OFF]')
		else
			Rancor = 'ON'
			add_to_chat(158,'Rancor: [ON]')
		end
		status_change(player.status)
	elseif command == 'C18' then -- SAM Roll Toggle --
		if Samurai_Roll == 'ON' then
			Samurai_Roll = 'OFF'
			add_to_chat(123,'SAM Roll: [OFF]')
		else
			Samurai_Roll = 'ON'
			add_to_chat(158,'SAM Roll: [ON]')
		end
		status_change(player.status)
	elseif command == 'C9' then -- Attack Toggle --
		if Attack == 'ON' then
			Attack = 'OFF'
			add_to_chat(123,'Attack: [OFF]')
		else
			Attack = 'ON'
			add_to_chat(158,'Attack: [ON]')
		end
		status_change(player.status)
	elseif command == 'C3' then -- Twilight Toggle --
		if Twilight == 'Twilight' then
			Twilight = 'None'
			add_to_chat(123,'Twilight Set: [Unlocked]')
		else
			Twilight = 'Twilight'
			add_to_chat(158,'Twilight Set: [locked]')
		end
		status_change(player.status)
	elseif command == 'C8' then -- Distance Toggle --
		if player.target.distance then
			target_distance = math.floor(player.target.distance*10)/10
			add_to_chat(158,'Distance: '..target_distance)
		else
			add_to_chat(123,'No Target Selected')
		end
	elseif command == 'C6' then -- Idle Toggle --
		IdleIndex = (IdleIndex % #IdleArray) + 1
		add_to_chat(158,'Idle Set: ' .. IdleArray[IdleIndex])
		status_change(player.status)
	elseif command == 'TP' then
		add_to_chat(158,'TP Return: ['..tostring(player.tp)..']')
	elseif command:match('^SC%d$') then
		send_command('//' .. sc_map[command])
	end
end

function set_lockstyle()
   send_command('wait 6; input /lockstyleset ' .. lockstyleset)
end