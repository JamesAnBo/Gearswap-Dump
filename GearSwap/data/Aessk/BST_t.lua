-------------------------------------------------------------------------------------------------------------------
-- ctrl+F12 cycles Idle modes


-------------------------------------------------------------------------------------------------------------------
							-- THE STUFF YOU CARE ABOUT STARTS AFTER LINE 101 --
							-- THE STUFF YOU CARE ABOUT STARTS AFTER LINE 101 --
							-- THE STUFF YOU CARE ABOUT STARTS AFTER LINE 101 --
							-- THE STUFF YOU CARE ABOUT STARTS AFTER LINE 101 --
							-- THE STUFF YOU CARE ABOUT STARTS AFTER LINE 101 --
							-- THE STUFF YOU CARE ABOUT STARTS AFTER LINE 101 --
							-- THE STUFF YOU CARE ABOUT STARTS AFTER LINE 101 --
							-- THE STUFF YOU CARE ABOUT STARTS AFTER LINE 101 --
							-- THE STUFF YOU CARE ABOUT STARTS AFTER LINE 101 --
-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end

function job_setup()
	
	get_combat_form()
	state.Buff['Killer Instinct'] = buffactive['Killer Instinct'] or false
	state.Buff["Unleash"] = buffactive["Unleash"] or false
	
	-- 'Out of Range' distance; WS will auto-cancel
	target_distance = 6

	-- Complete list of Ready moves to use with Sic & Ready Recast -5 Gleti’s Breeches.

	tp_based_ready_moves = S{
		'Sic','Somersault ','Dust Cloud','Foot Kick','Sheep Song','Sheep Charge','Lamb Chop',
        'Rage','Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang','Roar',
        'Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Geist Wall','Numbing Noise','Frog Kick',
        'Nimble Snap','Cyclotail','Spoil','Rhino Guard','Rhino Attack','Hi-Freq Field','Sandpit','Sandblast',
        'Mandibular Bite','Metallic Body','Bubble Shower','Bubble Curtain','Scissor Guard','Grapple','Spinning Top',
        'Double Claw','Filamented Hold','Spore','Blockhead','Secretion','Fireball','Tail Blow','Plague Breath',
        'Brain Crush','Infrasonics','Needleshot','Chaotic Eye','Blaster','Ripper Fang','Intimidate','Recoil Dive',
        'Water Wall','Snow Cloud','Wild Carrot','Sudden Lunge','Noisome Powder','Wing Slap','Beak Lunge','Suction',
        'Drainkiss','Acid Mist','TP Drainkiss','Back Heel','Jettatura','Choke Breath','Fantod','Charged Whisker',
        'Purulent Ooze','Corrosive Ooze','Tortoise Stomp','Harden Shell','Aqua Breath','Sensilla Blades',
        'Tegmina Buffet','Sweeping Gouge','Zealous Snort','Tickling Tendrils','Pecking Flurry','Pestilent Plume',
		'Foul Waters','Spider Web','Crossthrash','Venom Shower','Mega Scissors','Fluid Toss',
		'Fluid Spread','Digest','Rhinowrecker','Disembowel','Extirpating Salvo','Frenzied Rage'
	}

	-- List of Magic-based Ready moves to use with Pet MAB or Pet M.Acc gearset.
	magic_ready_moves = S{
		'Dust Cloud','Sheep Song','Scream','Dream Flower','Roar','Gloeosuccus','Palsy Pollen',
        'Soporific','Cursed Sphere','Venom','Geist Wall','Toxic Spit','Numbing Noise','Spoil','Hi-Freq Field',
        'Sandpit','Sandblast','Venom Spray','Bubble Shower','Filamented Hold','Silence Gas','Spore','Dark Spore',
		'Fireball','Plague Breath','Infrasonics','Chaotic Eye','Blaster','Intimidate','Snow Cloud',
		'Noisome Powder','TP Drainkiss','Jettatura','Charged Whisker','Purulent Ooze','Corrosive Ooze','Aqua Breath',
		'Molting Plumage','Stink Bomb','Nectarous Deluge','Nepenthic Plunge','Pestilent Plume','Foul Waters',
		'Spider Web','Nihility Song','Venom Shower','Digest'
	}
		
	debuff_ready_moves = S{
		'Dust Cloud','Sheep Song','Scream','Dream Flower','Roar','Gloeosuccus','Palsy Pollen',
        'Soporific','Geist Wall','Numbing Noise','Spoil','Hi-Freq Field','Sandpit','Sandblast','Filamented Hold',
		'Spore','Fireball','Infrasonics','Chaotic Eye','Blaster','Intimidate','Noisome Powder','TP Drainkiss',
		'Jettatura','Purulent Ooze','Corrosive Ooze','Pestilent Plume','Spider Web','Nihility Song'
	}
		
	multi_hit_ready_moves = S{
		'Pentapeck','Tickling Tendrils','Sweeping Gouge','Chomp Rush','Wing Slap','Pecking Flurry'
	}

	physical_debuff_ready_moves = S{
		'Sudden Lunge','Extirpating Salvo','Choke Breath'
	}

end


function user_setup()
        state.IdleMode:options('Normal', 'Reraise')
		state.OffenseMode:options('Normal','DT')
		
		--CTRL+F8 to change Correlation Mode
		state.CorrelationMode = M{['description']='Correlation Mode', 'Neutral', 'HighAcc', 'MaxAcc'}
        send_command('bind ^f8 gs c cycle CorrelationMode')
       
 end


function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end

	-- Unbinds the Jug Pet, Reward, Correlation, Treasure, PetMode, MDEF Mode hotkeys.
	send_command('unbind !=')
	send_command('unbind ^=')
	send_command('unbind !f8')
	send_command('unbind ^f8')
	send_command('unbind @f8')
	send_command('unbind ^f11')
end



		-- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
		-- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
		-- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
		-- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
		-- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
		-- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
		-- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
		-- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
		-- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
		-- HERE IS THE BEGINNING OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED FOR EDITING GEAR --
		

-- BST gearsets
function init_gear_sets()


	-- PRECAST SETS
        sets.precast.JA['Killer Instinct'] = {head="Ankusa Helm +1"}
		
		sets.precast.JA['Bestial Loyalty'] = {hands="Ankusa Gloves",body="Mirke Wardecors",}
		
		sets.precast.JA['Call Beast'] = sets.precast.JA['Bestial Loyalty']
		
        sets.precast.JA.Familiar = {legs="Ankusa Trousers"}
		
		sets.precast.JA.Tame = {head="Totemic Helm +1",}
		
		sets.precast.JA.Spur = {feet="Nukumi Ocreae +1"}

        
	--This is what will equip when you use Reward.  No need to manually equip Pet Food Theta.
    sets.precast.JA.Reward = {
		ammo="Pet Food Theta",
		head="Stout Bonnet",
		body="Totemic Jackcoat +1",
		hands="Leyline Gloves",
		legs="Ankusa Trousers",
		feet="Tot. Gaiters +1",
        neck="Aife's Medal",
		waist="Crudelis Belt",
        ear1="Lifestorm Earring",
        ear2="Neptune's Pearl",
		ring1="Aquasoul Ring",
        ring2="Aquasoul Ring",
        back="Pastoralist's Mantle",
	}
 
	--This is your base FastCast set that equips during precast for all spells/magic.
    sets.precast.FC = {
		ammo="Impatiens",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Malignance Tights",
		feet="Meg. Jam. +2",
		neck="Voltsurge Torque",
		waist="Flume Belt",
		left_ear="Etiolation Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Lebeche Ring",
		back={ name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}	
         			
	sets.midcast.Stoneskin = {
		head="Taeon Chapeau",
		neck="Stone Gorget",
		ear1="Earthcry Earring",
		ear2="Lifestorm Earring",
		body="Totemic Jackcoat +1",
		hands="Stone Mufflers",
		ring1="Aquasoul Ring",
		ring2="Aquasoul Ring",
		back="Pastoralist's Mantle",
		waist="Crudelis Belt",
		legs="Haven Hose",
		feet="Amm Greaves"
	}
				
    -- WEAPONSKILLS
		
    -- Default weaponskill set.
	sets.precast.WS = {
		ammo="Coiste Bodhar",
		head="Skormoth Mask",
		body="Tali'ah Manteel +2",
		hands="Gleti's Gauntlets",
		legs="Gleti’s Breeches",
		feet="Gleti's Boots",
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Gere Ring",
		right_ring="Regal Ring",
		back={ name="Artio's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-2%',}} , 
	}

    -- Specific weaponskill sets.
    sets.precast.WS['Onslaught'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		head="Skormoth Mask",
		body="Tali'ah Manteel +2",
		hands="Gleti's Gauntlets",
		legs="Gleti’s Breeches",
		feet="Gleti's Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		right_ear="Brutal Earring",
		left_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Regal Ring",
		back={ name="Artio's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-2%',}},
	})
			
	sets.precast.WS['Primal Rend'] = {
		head="Taeon Chapeau",
		body="Tot. Jackcoat +1",
		hands="Leyline Gloves",
		legs="Taeon Tights",
		feet="Taeon Boots",
		neck="Stoicheion Medal",
		waist="Salire Belt",
		left_ear="Hecate's Earring",
		right_ear="Friomisi Earring",
		left_ring="Epona's Ring",
		right_ring="Rajas Ring",
		back="Argocham. Mantle",
	}
		
	sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS['Primal Rend'],{
		ammo="Erlene's Notebook",
		head="Highwing Helm",
		neck="Stoicheion Medal",
		ear1="Moonshade Earring",
		ear2="Friomisi Earring",
		body="Taeon Tabard",
		hands="Taeon Gloves",
		ring1="Acumen Ring",
		ring2="Carb. Ring",
		back="Toro Cape",
		waist="Salire Belt",
		legs="Taeon Tights",
		feet="Taeon Boots",
	})

	-- PET SIC & READY MOVES

	--This is your base Ready move set, activating for physical Ready moves. Merlin/D.Tassets are accounted for already. 
	sets.midcast.Pet.WS = {
		head="Gavialis Helm"
	}
	
	--CorrelationMode sets (CTRL+F8 to change mode)
	sets.midcast.Pet.Neutral = set_combine(sets.midcast.Pet.WS, {  
		head="Gavialis Helm"
	})
			
	sets.midcast.Pet.HighAcc = set_combine(sets.midcast.Pet.WS, {
		main="Odium",
		ear1="Handler's Earring +1",
		head="Despair Helm",
		body="Valorous Mail",
		legs="Wisent Kecks",
		feet="Valorous Greaves",
		hands="Nukumi Manoplas +1",
		ammo="Demonry Core",
		neck="Empath Necklace",
		waist="Incarnation Sash",
		ear2="Handler's Earring",
		sub="Digirbalag",
		ring1="Thurandaut Ring",
		back="Pastoralist's Mantle",
	})
			
	sets.midcast.Pet.MaxAcc = set_combine(sets.midcast.Pet.WS, {
		main="Malevolence",
		ear1="Handler's Earring +1",
		head="Valorous Mask",
		body="Valorous Mail",
		legs="Wisent Kecks",
		feet="Valorous Greaves",
		hands="Nukumi Manoplas +1",
		ammo="Demonry Core",
		neck="Empath Necklace",
		waist="Incarnation Sash",
		ear2="Handler's Earring",
		sub="Digirbalag",
		ring1="Thurandaut Ring",
		back="Pastoralist's Mantle",
	})

	sets.midcast.Pet.MultiHitReady = set_combine(sets.midcast.Pet.WS, {})

	--This will equip for Magical Ready moves like Fireball
	sets.midcast.Pet.MagicReady = set_combine(sets.midcast.Pet.WS, {
		head="Tali'ah Turban +2",
		body="Tali'ah Turban +2",
		hands="Gleti's Gauntlets",
		legs="Gleti’s Breeches",
		feet="Gleti's Boots",
		waist="Klouskap Sash +1",
		neck="Adad Amulet",
		back={ name="Artio's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20',}},
		ring1="Thurandaut Ring",
	})
	
	sets.midcast.Pet.DebuffReady = {}
	
	sets.midcast.Pet.PhysicalDebuffReady = {}
	
	sets.midcast.Pet.TPBonus = {hands="Nukumi Manoplas +1",}
		
	sets.midcast.Pet.ReadyRecast = {legs="Gleti’s Breeches",}
        
    -- IDLE SETS (TOGGLE between RERAISE and NORMAL with CTRL+F12)
		
	-- Base Idle Set (when you do NOT have a pet out)
    sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Meg. Jam. +2",
		neck="Loricate Torque",
		waist="Flume Belt",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Eabani Earring",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})

	-- Idle Set that equips when you have a pet out and not fighting an enemy.
	sets.idle.Pet = set_combine(sets.idle, {
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Meg. Jam. +2",
		neck="Loricate Torque",
		waist="Flume Belt",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Eabani Earring",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back={ name="Artio's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	})

	-- Idle set that equips when you have a pet out and ARE fighting an enemy.
	sets.idle.Pet.Engaged = set_combine(sets.idle, {
		main={ name="Skullrender", augments={'DMG:+15','Pet: Accuracy+20','Pet: Attack+20',}},
		sub={ name="Skullrender", augments={'DMG:+15','Pet: Accuracy+20','Pet: Attack+20',}},
		ammo="Hesperiidae",
		head={ name="Emicho Coronet", augments={'Pet: Accuracy+15','Pet: Attack+15','Pet: "Dbl. Atk."+3',}},
		body="Tali'ah Manteel +2",
		hands="Gleti's Gauntlets",
		legs={ name="Valorous Hose", augments={'Pet: Accuracy+8 Pet: Rng. Acc.+8','Pet: "Dbl. Atk."+5','Pet: Attack+3 Pet: Rng.Atk.+3',}},
		feet="Gleti's Boots",
		neck="Beastmaster Collar",
		waist="Klouskap Sash +1",
		left_ear="Domes. Earring",
		right_ear="Sabong Earring",
		left_ring="Varar Ring",
		right_ring="Thurandaut Ring",
		back={ name="Artio's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20',}},
	})

    -- MELEE (SINGLE-WIELD) SETS
	
	sets.engaged = {
		main="Dolichenus",
		sub="adapa shield",
		ammo="Coiste Bodhar",
		head="Skormoth Mask",
		body="Tali'ah Manteel +2",
		hands="Gleti's Gauntlets",
		legs="Meg. Chausses +2",
		feet="Gleti's Boots",
		neck="Ainia Collar",
		waist="Sailfi Belt +1", augments={'Path: A',},
		left_ear="Dedition Earring",
		right_ear="Sherida Earring",
		left_ring="Moonlight Ring",
		right_ring="Gere Ring" ,
		back={ name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
			
	sets.engaged.DT = {
		ammo="Coiste Bodhar",
		head="Skormoth Mask",
		body="Tali'ah Manteel +2",
		hands="Gleti's Gauntlets",
		legs="Gleti’s Breeches",
		feet="Gleti's Boots",
		neck="Ainia Collar",
		waist="Sailfi Belt +1", augments={'Path: A',},
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Moonlight Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
				
	-- MELEE (DUAL-WIELD) SETS FOR DNC AND NIN SUBJOB
		
	sets.engaged.DW = {
		main="Dolichenus",
		sub="Ternion Dagger",
		ammo="Coiste Bodhar",
		head="Skormoth Mask",
		body="Tali'ah Manteel +2",
		hands="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',},
		legs="Meg. Chausses +2",
		feet="Gleti's Boots",
		neck="Combatant's Torque",
		waist="Sailfi Belt +1", augments={'Path: A',},
		left_ear="Sherida Earring",
		right_ear="Dedition Earring",
		left_ring="Gere Ring",
		right_ring="Moonlight Ring",
		back={ name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.engaged.DW.DT = {
		ammo="Coiste Bodhar",
		head="Skormoth Mask",
		body="Tali'ah Manteel +2",
		hands="Gleti's Gauntlets",
		legs="Gleti’s Breeches",
		feet="Gleti's Boots",
		neck="Combatant's Torque",
		waist="Sailfi Belt +1", augments={'Path: A',},
		left_ear="Suppanomimi",
		right_ear="Sherida Earring",
		left_ring="Moonlight Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
			-- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED -- 
			-- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --
			-- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --
			-- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --
			-- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --
			-- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --
			-- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --
			-- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --
			-- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --
			-- THIS IS THE END OF THE GEARSWAP AS FAR AS YOU SHOULD BE CONCERNED --


end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, spellMap, eventArgs)
        if spell.type == "WeaponSkill" and spell.english ~= 'Mistral Axe' and spell.english ~= 'Bora Axe' and spell.target.distance > target_distance then
                eventArgs.cancel = true
                add_to_chat(123, spell.name..' Canceled: [Out of Range]')

		elseif spell.english == 'Reward' then
			equip(sets.precast.JA.Reward)

		elseif spell.english == 'Spur' then
			equip(sets.precast.JA.Spur)

		elseif spell.english == 'Bestial Loyalty' or spell.english == 'Call Beast' then
			equip(sets.precast.JA['Bestial Loyalty'])
		
-- Define class for Sic and Ready moves.
        elseif spell.type == 'Monster' then
            classes.CustomClass = "WS"
			equip(sets.midcast.Pet.ReadyRecast)
        end
end

function job_post_precast(spell, spellMap, eventArgs)
	--uses the cancel addon
	if spell.name == 'Spectral Jig' and buffactive.sneak then
            -- If sneak is active when using, cancel before completion
            send_command('cancel sneak')
    end

end

function job_pet_midcast(spell, action, spellMap, eventArgs)
	
end

function job_midcast(spell, action, spellMap, eventArgs)
	--uses the cancel addon
	if spell.english == "Stoneskin" then
		if buffactive.Stoneskin then
			-- If stoneskin is active when using, cancel before completion
			send_command('cancel stoneskin')
		end
	elseif spell.english == "Sneak" then
		if spell.target.name == player.name and buffactive['Sneak'] then
			-- If sneak is active when using and target is self, cancel before completion
			send_command('cancel sneak')
		end
	elseif string.find(spell.english,'Utsusemi') then
		if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
			-- If 1 or 2 shadows are active when using, cancel before completion
			send_command('@wait 1.7;cancel Copy Image*')
		end
	elseif spell.english == 'Monomi: Ichi' then
		if buffactive['Sneak'] then
			-- If sneak is active when using, cancel before completion
			send_command('@wait 1.7;cancel sneak')
		end
	end
end

-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, spellMap, eventArgs)
	if spell.type == 'Monster' then
		equip(get_pet_midcast_set(spell, spellMap))
		
        if magic_ready_moves:contains(spell.english) then
			if debuff_ready_moves:contains(spell.english) and sets.midcast.Pet.DebuffReady then
					equip(sets.midcast.Pet.DebuffReady)
			else
				if sets.midcast.Pet.MagicReady[state.OffenseMode.value] then
					equip(sets.midcast.Pet.MagicReady[state.OffenseMode.value])
				else
					equip(sets.midcast.Pet.MagicReady)
				end
			end
		elseif physical_debuff_ready_moves:contains(spell.english) and sets.midcast.Pet.PhysicalDebuffReady then
			equip(sets.midcast.Pet.PhysicalDebuffReady)
		elseif multi_hit_ready_moves:contains(spell.english) and sets.midcast.Pet.MultiHitReady then
			equip(sets.midcast.Pet.MultiHitReady)
        else
			if sets.midcast.Pet[state.OffenseMode.value] then
				equip(sets.midcast.Pet[state.OffenseMode.value])
			else
				equip(sets.midcast.Pet.WS)
			end
        end
        -- If Pet TP, before bonuses, is less than a certain value then equip Nukumi Manoplas +1
        if tp_based_ready_moves:contains(spell.english) then
			if pet.tp < 1900 or (PetJob ~= 'Warrior' and pet.tp < 2400) then
				equip(sets.midcast.Pet.TPBonus)
			end
        end
		
		if state.Buff["Unleash"] then
			disable('main','sub','range','ammo','head','neck','lear','rear','body','hands','lring','rring','back','waist','legs','feet')
			add_to_chat(217, "Unleash is on, locking your current Ready set.")
		end
	end
end

function job_customize_idle_set(idleSet)
    return idleSet
end

function job_buff_change(buff, gain)
	if buff == 'Unleash' and not gain then
		enable('main','sub','range','ammo','head','neck','lear','rear','body','hands','lring','rring','back','waist','legs','feet')
		add_to_chat(217, "Unleash has worn, enabling all slots.")
		handle_equipping_gear(player.status)
	end
end

function job_state_change(stateField, newValue, oldValue)
	if stateField == 'Correlation Mode' then
		state.CorrelationMode:set(newValue)
	end
end

function get_combat_form()
	if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
		state.CombatForm:set('DW')
	else
		state.CombatForm:reset()
	end

end
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(2, 9)
    else
        set_macro_page(2, 9)
    end
end


send_command('@wait 5;input /lockstyleset 2')