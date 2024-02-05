-- Get Sets: Everything in this section is run as soon as you change jobs.
function get_sets()
	sets = {}
	petcast = false
	
	BrigDEXSTP = { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}}
	BrigSTRDA = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%',}}
	BrigDEXDA = { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Pet: Damage taken -5%',}}
	BrigSTRWSD = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
	
	-- Regular Sets --
	sets.Idle = {
		ammo="Staunch Tathlum +1",
		head="Hjarrandi Helm",
		body="Hjarrandi Breast.",
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Eabani Earring",
		right_ear="Crematio Earring",
		left_ring="Defending Ring",
		right_ring="C. Palug Ring",
		back=BrigDEXDA
	}
	
	sets.TP = {}
	sets.TP.index = {'Standard', 'Accuracy', 'Physical DT', 'Magic DT'}
	--1=Standard, 2=TPAcc, 3=PDT, 4=MDT--
	TP_ind = 1 -- Standard set is the Default

	sets.TP['Standard'] = {
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body="Hjarrandi Breast.",
		hands={ name="Acro Gauntlets", augments={'Accuracy+20 Attack+20','"Store TP"+6','STR+7 DEX+7',}},
		legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
		feet="Flam. Gambieras +2",
		neck="Vim Torque +1",
		waist="Ioskeha Belt +1",
		left_ear="Brutal Earring",
		right_ear="Sherida Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back=BrigDEXDA
	}
	sets.TP['Accuracy'] = set_combine(sets.TP, {
	    body="Vishap Mail +3",
		hands={ name="Emi. Gauntlets +1", augments={'HP+65','DEX+12','Accuracy+20',}},
		legs="Sulev. Cuisses +2",
		neck="Dgn. Collar +2",
	})                                                       
	sets.TP['Physical DT'] = set_combine(sets.TP, {
		head="Hjarrandi Helm",
		hands="Gleti's Gauntlets",
		legs="Gleti’s Breeches",
		feet="Gleti's Boots",
		left_ring="Defending Ring",
	})                                
	sets.TP['Magic DT'] = sets.TP['Physical DT']
							  
	sets.WS = {}						  
	-- Can add a set for each WS by making a new set: sets.WS["Raiden Thrust"] or sets.WS["Geirskogul"] for example
	sets.WS["Default"] = {
		ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Attack+23','Weapon skill damage +5%','DEX+3',}},
		body={ name="Valorous Mail", augments={'Attack+9','Weapon skill damage +5%','DEX+7','Accuracy+7',}},
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Vishap Brais +3",
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back=BrigSTRWSD
	}	
	sets.WS["Leg Sweep"] = {ammo="Amar Cluster",
							  head="Flam. Zucchetto +1",neck="Fotia Gorget",ear1="Telos Earring",ear2="Digni. Earring",
							  body="Flamma Korazin +1",hands="Flam. Manopolas +1",ring1="Rufescent Ring",ring2="Etana Ring",
							  back=BrigDEXSTP,waist="Fotia Belt",legs="Flamma Dirs +1",feet="Flam. Gambieras +1"}
	sets.WS["Drakesbane"] = {
		ammo="Knobkierrie",
	    head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti’s Breeches",
		feet="Gleti's Boots",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear="Sherida Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back=BrigSTRDA
	}	
	sets.WS["Stardiver"] = {
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti’s Breeches",
		feet="Flam. Gambieras +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back=BrigSTRDA
	}
	sets.WS["Camlann's Torment"] = {
		ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Attack+23','Weapon skill damage +5%','DEX+3',}},
		body={ name="Valorous Mail", augments={'Attack+9','Weapon skill damage +5%','DEX+7','Accuracy+7',}},
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Vishap Brais +3",
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back=BrigSTRWSD
	}
	sets.WS["Sonic Thrust"] = sets.WS["Camlann's Torment"]
	sets.WS["Impulse Drive"] = {
		ammo="Knobkierrie",
	    head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti’s Breeches",
		feet="Flam. Gambieras +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back=BrigSTRWSD
	}
	sets.WS["Accuracy"] = {}
	sets.WS["Sanguine Blade"] = {ammo="Ghastly Tathlum",
					  head="Jumalik Helm",neck="Fotia Gorget",ear1="Friomisi Earring",ear2="Ishvara Earring",
					  body="Found. Breastplate",hands="Founder's Gauntlets",ring1="Archon Ring",ring2="Weather. Ring",
					  back=BrigSTRDA,waist="Fotia Belt",legs="Founder's Hose",feet="Founder's Greaves"} 
	sets.WS['Savage Blade'] = {
		ammo="Knobkierrie",
	    head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Vishap Brais +3",
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back=BrigSTRWSD
	}
	
	sets.WS['Full Swing'] = {
	    ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Attack+23','Weapon skill damage +5%','DEX+3',}},
		body={ name="Valorous Mail", augments={'Attack+9','Weapon skill damage +5%','DEX+7','Accuracy+7',}},
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Vishap Brais +3",
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back=BrigSTRWSD
	}
	
	sets.WS['Retribution'] = {
		ammo="Knobkierrie",
	    head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Vishap Brais +3",
		feet="Sulev. Leggings +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Epaminondas's Ring",
		back=BrigSTRWSD
	}
	
	sets.WS['Shattersoul'] = {
	    ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Attack+23','Weapon skill damage +5%','DEX+3',}},
		body={ name="Valorous Mail", augments={'Attack+9','Weapon skill damage +5%','DEX+7','Accuracy+7',}},
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Vishap Brais +3",
		feet="Sulev. Leggings +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Ishvara Earring",
		right_ear="Thrud Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Epaminondas's Ring",
		back=BrigSTRWSD
	}
	
	sets.WS['Raiden Thrust'] = {
		ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'"Mag.Atk.Bns."+24','Enmity+2','"Treasure Hunter"+1','Accuracy+4 Attack+4','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
		body="Sacro Breastplate",
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Vishap Brais +3",
		feet={ name="Valorous Greaves", augments={'Blood Pact Dmg.+2','"Mag.Atk.Bns."+26','Quadruple Attack +1','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back=BrigSTRWSD
	}
	
	sets.WS['Cataclysm'] = set_combine(sets.WS['Raiden Thrust'], {
		head="Pixie Hairpin +1",
		right_ring="Archon Ring",
	})
	
	sets.WS['Shell Crusher'] = {
	    ammo="Voluspa Tathlum",
		head="Flam. Zucchetto +2",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti’s Breeches",
		feet="Flam. Gambieras +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Digni. Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back=BrigSTRDA
	}
    -- Job Ability Sets --
	sets.JA = {}
	sets.JA["Jump"] = { 
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		--body="Vishap Mail +3",
		body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
		hands="Vis. Fng. Gaunt. +3",
		legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
		feet="Ostro Greaves",
		neck="Vim Torque +1",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back=BrigSTRDA
	}
	sets.JA["Jump Accuracy"] = sets.JA["Jump"]
	
	sets.JA["Angon"] = {
		ammo="Angon",
		ear1="Dragoon's Earring",
		hands="Ptero. Fin. G. +3"
	} 
	-- Angon, Relic Hands, and that dumb earring in Mamook if you feel like it
	
	sets.JA["Ancient Circle"] = {
		legs="Vishap Brais +3"
	} 
	-- Ancient Circle normally: 3 minute duration, Damage+15% DT-15% DragonKiller+15% against Dragons (10% vs. NMs)
	-- Ancient Circle with AF1: 4.5 minute duration, Damage+17% DT-17% DragonKiller+17% against Dragons (11% vs. NMs)
	
	sets.JA["Spirit Link"] = {
        head="Vishap Armet +3",
		hands="Pel. Vambraces +1",
		feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
		right_ear="Pratik Earring",
	} 
	-- Spirit Link/Empathy gear go here; note that Relic Feet will cause a 100% Wyvern to still drain HP (unless leveling up
	
	sets.JA["Spirit Surge"] = {
		body="Ptero. Mail +3",
		hands="Despair Fin. Gaunt.", 
		legs="Vishap Brais +3",
		feet="Ptero. Greaves +3"
		neck="Chanoix's Gorget",
		ear1="Anastasi Earring",
		ear2="Lancer's Earring",
		back={ name="Updraft Mantle", augments={'STR+1','Pet: Breath+10',}},
	} 
	-- Augmented Relic Body affects duration; Wyvern Max HP affects Spirit Surge's Max HP effect on you
	
	sets.JA["Steady Wing"] = {
		body="Emicho Haubert",
		hands="Despair Fin. Gaunt.", 
		legs="Vishap Brais +3",
		feet="Ptero. Greaves +3"
		neck="Chanoix's Gorget",
		ear1="Anastasi Earring",
		ear2="Lancer's Earring",
		back={ name="Updraft Mantle", augments={'STR+1','Pet: Breath+10',}},
	} 
	-- Wyvern Max HP strongly affects Steady Wing's Stoneskin effect
	
	-- Casting Sets --
	sets.FastCast = {}
	-- Can add more FC and Quick Magic here for spells; AF1 Head recommended in case of GearSwap error, at least for faster spells
	
	sets.Midcast = {}
	-- AF1 Head strongly advised for Healing Breath trigger
	-- HP or defensive stuff for Healing Breath; can use Fast Cast or Magic Acc. or whatever if you want too
	
	sets.HealingBreath = {
		ammo="Staunch Tathlum +1",
		head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
		body={ name="Acro Surcoat", augments={'Pet: Mag. Acc.+22','Pet: Breath+8','HP+49',}},
		hands={ name="Acro Gauntlets", augments={'Pet: Mag. Acc.+23','Pet: Breath+8','HP+50',}},
		legs="Vishap Brais +3",
		feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist="Glassblower's Belt",
		left_ear="Eabani Earring",
		right_ear="Dragoon's Earring",
		left_ring="Defending Ring",
		right_ring="C. Palug Ring",
		back={ name="Updraft Mantle", augments={'STR+1','Pet: Breath+10',}},
	}
	sets.ElementalBreath = {
		ammo="Voluspa Tathlum",
		head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
		body={ name="Acro Surcoat", augments={'Pet: Mag. Acc.+22','Pet: Breath+8','HP+49',}},
		hands={ name="Acro Gauntlets", augments={'Pet: Mag. Acc.+23','Pet: Breath+8','HP+50',}},
		legs={ name="Acro Breeches", augments={'Pet: Mag. Acc.+23','Pet: Breath+8','HP+40',}},
		feet={ name="Acro Leggings", augments={'Pet: Mag. Acc.+25','Pet: Breath+8','HP+39',}},
		neck="Adad Amulet",
		waist="Incarnation Sash",
		left_ear="Enmerkar Earring",
		right_ear="Kyrene's Earring",
		right_ring="C. Palug Ring",
		back={ name="Updraft Mantle", augments={'STR+1','Pet: Breath+10',}},
	}
	Breath = sets.HealingBreath
	-- Healing Breath is modified by Wyvern Max HP and Wyvern: Breath+
	-- Elemental Breaths are modified by Wyvern Current HP, Wyvern: Breath+, and Pet: Magic Accuracy
	-- Remove Status Breaths are presumably affected by nothing
end


-- Precast: JA and WS should be defined here, Fast Cast and such for magic. 
function precast(spell)
	if spell.type == "WeaponSkill" then
		if TP_ind == 2 then -- If using your Accuracy set, use the Accuracy WS set
		equip(sets.WS['Accuracy'])
		elseif sets.WS[spell.name] then -- If you made a set for a WS and then use it,
		equip(sets.WS[spell.name])  -- it'll equip that set for that WS only
		else
		equip(sets.WS["Default"]) -- otherwise, it'll use this set instead
		end
	elseif spell.action_type == 'Magic' then 
		equip(sets.FastCast)
	elseif spell.name == 'Dismiss' and pet.hpp < 100 then		
		cancel_spell() -- Dismiss resets the Call Wyvern recast IF your Wyvern is at 100% HP; largely pointless otherwise
		windower.add_to_chat(50,'  '..pet.name..' is below full HP (<pethpp>), cancelling Dismiss!')
	elseif spell.name == 'Call Wyvern' then
		if pet.isvalid then
			cancel_spell() -- Uses Spirit Link instead when your Wyvern is already present
			send_command('input /ja "Spirit Link" <me>')
		else
			equip(sets.JA["Spirit Surge"]) -- Relic Body goes here; can just use Spirit Surge set if you have it augmented
		end
	elseif spell.name == 'Spirit Link' then
		if pet.isvalid then
			equip(sets.JA["Spirit Link"])
		else
			cancel_spell() -- Uses Call Wyvern instead when your Wyvern isn't present
			send_command('input /ja "Call Wyvern" <me>')
		end
	elseif string.find(spell.name,"Jump") then -- Any spell or ability with the word Jump in it
		if not pet.isvalid then -- If you don't have a pet
			if spell.name == "Spirit Jump" then -- Forces Spirit Jump into regular Jump when Wyvern is dead
				cancel_spell()
				send_command('input /ja "Jump" <t>')
				return
			elseif spell.name == "Soul Jump" then -- Forces Soul Jump into High Jump when Wyvern is dead
				cancel_spell()
				send_command('input /ja "High Jump" <t>')
				return
			end
		end
		if TP_ind == 2 then -- If using your Accuracy set
		equip(sets.JA['Jump Accuracy'])
		else
		equip(sets.JA['Jump'])
		end
	elseif sets.JA[spell.name] then 
		equip(sets.JA[spell.name])
	end
end            
 
-- Midcast: For magic, this section affects your spell's potency, accuracy, etc. Unnecessary for JA/WS.
function midcast(spell)
	if spell.action_type == 'Magic' then 
        equip(sets.Midcast)
	end
end

-- Pet Change: Occurs when your Pet is summoned or killed.
function pet_change(pet,gain)
	if gain == false and pet.name then
		-- General announcement for when your Wyvern is killed, Dimissed, or eaten by Spirit Surge
		windower.add_to_chat(50,' *** '..string.upper(pet.name)..' IS DEAD ***')
	end
end

-- Pet Midcast: If GearSwap sees your pet readying a WS, this occurs
function pet_midcast(spell)
	if string.find(spell.name,' Breath') then
		if string.find(spell.name,'Healing') then 
		Breath = sets.HealingBreath
		else
		Breath = sets.ElementalBreath
		end
		petcast = true
		equip_current()		
		windower.send_command('wait 1.2;gs c petcast')
		-- Wyvern Breath Delay: 1.25s http://forum.square-enix.com/ffxi/threads/47481
		-- Remove Status should still be 1s: http://forum.square-enix.com/ffxi/threads/44090
		-- pet_aftercast won't run if your Wyvern's WS is interrupted (disengaging, stunned, Amnesia, etc.), so I recommend this

	end
end
 
-- Aftercast: Occurs following the use of any WS, JA, Spell, Item, or Ranged Attack
function aftercast(spell)
	equip_current()
end

-- Status Change: When Engaging, Disengaging, Resting, Standing Up, etc.
function status_change()
	equip_current()
end

-- Pet Status Change
function pet_status_change(new,old)
	if new ~= "Engaged" then
	petcast = false
	end
end

-- A custom function that equips a set based on whether you're engaged or not.
function equip_current()
	if player.status == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	else
		equip(sets.Idle)
	end
	if petcast == true then 
		equip(Breath) -- This will equip your Breath gear on top of whichever other set you're currently wearing.
	end
end
 
-- Manual commands sent in-game with //gs c <command>
function self_command(command)
	if command == 'toggle TP set' then
		TP_ind = TP_ind +1
		if TP_ind > #sets.TP.index then TP_ind = 1 end
		windower.add_to_chat(1,'<----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		equip_current()
	elseif command == 'reverse TP set' then
		TP_ind = TP_ind -1
		if TP_ind == 0 then TP_ind = #sets.TP.index end
		windower.add_to_chat(1,'<----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		equip_current()
	elseif command == 'petcast' and petcast then -- This command reverts to your regular gear 1.2 seconds after a Breath by default
		petcast = false
		equip_current() 
	end
end