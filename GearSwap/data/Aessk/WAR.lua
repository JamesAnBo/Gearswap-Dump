-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
--[[ Updated 9/18/2014, functions with Mote's new includes.
-- Have not played WAR recently]]--

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
			state.Buff['Aftermath'] = buffactive['Aftermath: Lv.1'] or
            buffactive['Aftermath: Lv.2'] or
            buffactive['Aftermath: Lv.3'] or false
			state.Buff['Mighty Strikes'] = buffactive['Mighty Strikes'] or false
			
		TPbonus_ws = S{'Savage Blade', 'Impulse Drive', 'Upheaval', 'Judgment', 'Resolution'}	
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'STP', 'Hybrid')
	state.RangedMode:options('Normal')
	state.HybridMode:options('Normal', 'PDT')
	state.WeaponskillMode:options('Normal', 'AccLow', 'AccHigh', 'Attack')
	state.CastingMode:options('Normal')
	state.IdleMode:options('Normal', 'Regen')
	state.RestingMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT', 'Reraise')
	state.MagicalDefenseMode:options('MDT')
	
	update_combat_weapon()
	update_melee_groups()
	
	
	-- Additional Binds
    send_command('bind f9 gs c cycle OffenseMode')
    send_command('bind f10 gs c cycle Weaponset')							   
    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
     send_command('unbind f9')
     send_command('unbind f10')
end


function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
	-- Sets to apply to arbitrary JAs
	sets.precast.JA.Berserk = {
body="Pumm. Lorica +3",
feet={ name="Agoge Calligae +3", augments={'Enhances "Tomahawk" effect',}},}

    sets.precast.JA['Aggressor'] = {    
       head="Pummeler's Mask +3",
       body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
}
    sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers +1"}
	sets.precast.JA['Blood Rage'] = {body="Boii Lorica +1",}
	sets.precast.JA['Warcry'] = {head="Agoge Mask +3"}
	--sets.precast.JA['Tomahawk'] = {ammo="Thr. Tomahawk",feet="Agoge Calligae +1"}

sets.precast.JA['Jump'] = {
    ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head="Flam. Zucchetto +2",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Pumm. Cuisses +3",
    feet="Pumm. Calligae +3",
    neck={ name="Vim Torque +1", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear={ name="Brutal Earring", priority=2},
    right_ear={ name="Schere Earring", augments={'Path: A',}},
    left_ring={ name="Niqmaddu Ring", priority=1},
    right_ring="Chirich Ring +1",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

sets.precast.JA['High Jump'] = {
    ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head="Flam. Zucchetto +2",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Pumm. Cuisses +3",
    feet="Pumm. Calligae +3",
    neck={ name="Vim Torque +1", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear={ name="Brutal Earring", priority=2},
    right_ear={ name="Schere Earring", augments={'Path: A',}},
    left_ring={ name="Niqmaddu Ring", priority=1},
    right_ring="Chirich Ring +1",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}


	-- Sets to apply to any actions of spell.type
	sets.precast.Waltz = {}
		
	-- Sets for specific actions within spell.type
	sets.precast.Waltz['Healing Waltz'] = {}

    -- Sets for fast cast gear for spells
	sets.precast.FC = {    
    ammo="Sapience Orb",
    head={ name="Sakpata's Helm", augments={'Path: A',}},
    body="Sakpata's Plate",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Sakpata's Cuisses",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Baetyl Pendant",
    waist="Ioskeha Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Weather. Ring +1",
    right_ring={ name="Moonlight Ring", priority=1},
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
 }

    -- Fast cast gear for specific spells or spell maps
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

	-- Weaponskill sets
	sets.precast.WS = {    
    ammo="Knobkierrie",
    head="Flam. Zucchetto +2",
    body="Pumm. Lorica +3",
    hands="Sakpata's Gauntlets",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet="Sulev. Leggings +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear={ name="Thrud Earring", priority=1},
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}
	
	-- Specific weaponskill sets.
	sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {
    head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
    body="Pumm. Lorica +3",
    neck="War. Beads +2",
    waist="Ioskeha Belt +1",
    right_ear={ name="Thrud Earring", priority=1},
    left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},

})
	sets.precast.WS['Upheaval'].AccLow = set_combine(sets.precast.WS['Upheaval'], {})
	sets.precast.WS['Upheaval'].AccHigh = set_combine(sets.precast.WS['Upheaval'].AccLow, {})
	sets.precast.WS['Upheaval'].Attack = set_combine(sets.precast.WS['Upheaval'], {})
	sets.precast.WS['Upheaval'].MS = set_combine(sets.precast.WS['Upheaval'], {})


	
	sets.precast.WS['Ukko\'s Fury'] = set_combine(sets.precast.WS, {legs="Sakpata's Cuisses",})
	sets.precast.WS['Ukko\'s Fury'].AccLow = set_combine(sets.precast.WS['Ukko\'s Fury'], {})
	sets.precast.WS['Ukko\'s Fury'].AccHigh = set_combine(sets.precast.WS['Ukko\'s Fury'].AccLow, {})
	sets.precast.WS['Ukko\'s Fury'].Attack = set_combine(sets.precast.WS['Ukko\'s Fury'], {})
	sets.precast.WS['Ukko\'s Fury'].MS = set_combine(sets.precast.WS['Ukko\'s Fury'], {})

sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {    
    head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
    right_ear={ name="Thrud Earring", priority=1},
    left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    neck={ name="War. Beads +2", augments={'Path: A',}},
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    legs="Sakpata's Cuisses",
    left_ring="Epaminondas's Ring",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
})


	
	sets.precast.WS['King\'s Justice'] = set_combine(sets.precast.WS, {
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
})
	sets.precast.WS['King\'s Justice'].AccLow = set_combine(sets.precast.WS['King\'s Justice'], {})
	sets.precast.WS['King\'s Justice'].AccHigh = set_combine(sets.precast.WS['King\'s Justice'].AccLow, {})
	sets.precast.WS['King\'s Justice'].Attack = set_combine(sets.precast.WS['King\'s Justice'], {})
	sets.precast.WS['King\'s Justice'].MS = set_combine(sets.precast.WS['King\'s Justice'], {})

	sets.precast.WS['Judgment'] = set_combine(sets.precast.WS, {    
    head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
    right_ear={ name="Thrud Earring", priority=1},
    left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    neck={ name="War. Beads +2", augments={'Path: A',}},
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
	hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    left_ring="Epaminondas's Ring",
})
	
	sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {    
    head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
    right_ear={ name="Thrud Earring", priority=1},
    left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    neck={ name="War. Beads +2", augments={'Path: A',}},
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    left_ring="Epaminondas's Ring",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},

})
	sets.precast.WS['Impulse Drive'].AccLow = set_combine(sets.precast.WS['Impulse Drive'], {})
	sets.precast.WS['Impulse Drive'].AccHigh = set_combine(sets.precast.WS['Impulse Drive'].AccLow, {})
	sets.precast.WS['Impulse Drive'].Attack = set_combine(sets.precast.WS['Impulse Drive'], {})
	sets.precast.WS['Impulse Drive'].MS = set_combine(sets.precast.WS['Impulse Drive'], {})


	
	sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Fell Cleave'].AccLow = set_combine(sets.precast.WS['Fell Cleave'], {})
	sets.precast.WS['Fell Cleave'].AccHigh = set_combine(sets.precast.WS['Fell Cleave'].AccLow, {})
	sets.precast.WS['Fell Cleave'].Attack = set_combine(sets.precast.WS['Fell Cleave'], {})
	sets.precast.WS['Fell Cleave'].MS = set_combine(sets.precast.WS['Fell Cleave'], {})


	
	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
right_ear={ name="Thrud Earring", priority=1},
feet="Pumm. Calligae +3",
})
	sets.precast.WS['Resolution'].AccLow = set_combine(sets.precast.WS['Resolution'], {})
	sets.precast.WS['Resolution'].AccHigh = set_combine(sets.precast.WS['Resolution'].AccLow, {})
	sets.precast.WS['Resolution'].Attack = set_combine(sets.precast.WS['Resolution'], {})
	sets.precast.WS['Resolution'].MS = set_combine(sets.precast.WS['Resolution'], {})
	

	--------------------------------------
	-- Midcast sets
	--------------------------------------

    -- Generic spell recast set
	sets.midcast.FastRecast = {}
		
	-- Specific spells
	sets.midcast.Utsusemi = {}

	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------
	
	-- Resting sets
	sets.resting = {}
	

	-- Idle sets
	sets.idle = {
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Sanctity Necklace",
    waist="Gishdubar Sash",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ear="Eabani Earring",
    left_ring="Defending Ring",
    right_ring="Chirich Ring +1",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},

}

	sets.idle.DT = {
    ammo="Coiste Bodhar",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs="Sakpata's Cuisses",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Eabani Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Chirich Ring +1",
    right_ring={ name="Moonlight Ring", priority=1},
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},

}
	
	sets.idle.Regen = {
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Sanctity Necklace",
    waist="Ioskeha Belt +1",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ear="Eabani Earring",
    left_ring="Defending Ring",
    right_ring="Chirich Ring +1",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}
	
		
	-- Defense sets
	sets.defense.PDT = {}
	sets.defense.Reraise = set_combine(sets.defense.PDT, {})
	sets.defense.MDT = {}

    -- Gear to wear for kiting
	sets.Kiting = {}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	-- If using a weapon that isn't specified later, the basic engaged sets should automatically be used.
	-- Equip the weapon you want to use and engage, disengage, or force update with f12, the correct gear will be used; default weapon is whats equip when file loads.

	sets.engaged = {
    ammo="Coiste Bodhar",
    head="Flam. Zucchetto +2",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Pumm. Cuisses +3",
    feet="Pumm. Calligae +3",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Brutal Earring",
    right_ear="Telos Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}


	sets.engaged.STP = {
    ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head="Flam. Zucchetto +2",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Pumm. Cuisses +3",
    feet="Pumm. Calligae +3",
    neck={ name="Vim Torque +1", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear={ name="Brutal Earring", priority=2},
    right_ear={ name="Schere Earring", augments={'Path: A',}},
    left_ring="Niqmaddu Ring",
    right_ring={ name="Moonlight Ring", priority=1},
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}


	sets.engaged.Hybrid = {
    ammo="Coiste Bodhar",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Pumm. Calligae +3",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Brutal Earring",
    right_ear="Telos Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Moonlight Ring",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

	sets.engaged.AccLow = set_combine(sets.engaged, {})
	sets.engaged.AccHigh = set_combine(sets.engaged.AccLow, {})
	sets.engaged.PDT = set_combine(sets.engaged, {})
	sets.engaged.AccLow.PDT = set_combine(sets.engaged.PDT, {})
	sets.engaged.AccHigh.PDT = set_combine(sets.engaged.AccLow.PDT, {})
	
--[[	sets.engaged.Conqueror = {}
	sets.engaged.Conqueror.AccLow = set_combine(sets.engaged.Conqueror, {})
	sets.engaged.Conqueror.AccHigh = set_combine(sets.engaged.Conqueror.AccLow, {})
	sets.engaged.Conqueror.PDT = set_combine(sets.engaged.Conqueror, {})
	sets.engaged.Conqueror.AccLow.PDT = set_combine(sets.engaged.Conqueror.PDT, {})
	sets.engaged.Conqueror.AccHigh.PDT = set_combine(sets.engaged.Conqueror.AccLow.PDT, {})
	-- Conqueror Aftermath Lv.3 sets
	sets.engaged.Conqueror.AM3 = {}
	sets.engaged.Conqueror.AccLow.AM3 = set_combine(sets.engaged.Conqueror.AM3, {})
	sets.engaged.Conqueror.AccHigh.AM3 = set_combine(sets.engaged.Conqueror.AccLow.AM3, {})
	sets.engaged.Conqueror.PDT.AM3 = set_combine(sets.engaged.Conqueror.AM3, {})
	sets.engaged.Conqueror.AccLow.PDT.AM3 = set_combine(sets.engaged.Conqueror.PDT.AM3, {})
	sets.engaged.Conqueror.AccHigh.PDT.AM3 = set_combine(sets.engaged.Conqueror.AccLow.PDT.AM3, {})
	
	sets.engaged.Ukonvasara = {}
	sets.engaged.Ukonvasara.AccLow = set_combine(sets.engaged.Ukonvasara, {})
	sets.engaged.Ukonvasara.AccHigh = set_combine(sets.engaged.Ukonvasara.AccLow, {})
	sets.engaged.Ukonvasara.PDT = set_combine(sets.engaged.Ukonvasara, {})
	sets.engaged.Ukonvasara.AccLow.PDT = set_combine(sets.engaged.Ukonvasara.PDT, {})
	sets.engaged.Ukonvasara.AccHigh.PDT = set_combine(sets.engaged.Ukonvasara.AccLow.PDT, {})
	
	sets.engaged.Bravura = {}
	sets.engaged.Bravura.AccLow = set_combine(sets.engaged.Bravura, {})
	sets.engaged.Bravura.AccHigh = set_combine(sets.engaged.Bravura.AccLow, {})
	sets.engaged.Bravura.PDT = set_combine(sets.engaged.Bravura, {})
	sets.engaged.Bravura.AccLow.PDT = set_combine(sets.engaged.Bravura.PDT, {})
	sets.engaged.Bravura.AccHigh.PDT = set_combine(sets.engaged.Bravura.AccLow.PDT, {})
	-- Bravura Aftermath sets, will only apply if aftermath, bravura, and hybridmode are on
	sets.engaged.Bravura.PDT.AM = set_combine(sets.engaged.Bravura, {})
	sets.engaged.Bravura.AccLow.PDT.AM = set_combine(sets.engaged.Bravura.PDT.AM , {})
	sets.engaged.Bravura.AccHigh.PDT.AM = set_combine(sets.engaged.Bravura.AccLow.PDT.AM , {})
	
	sets.engaged.Ragnarok = {}
	sets.engaged.Ragnarok.AccLow = set_combine(sets.engaged.Ragnarok, {})
	sets.engaged.Ragnarok.AccHigh = set_combine(sets.engaged.Ragnarok.AccLow, {})
	sets.engaged.Ragnarok.PDT = set_combine(sets.engaged.Ragnarok, {})
	sets.engaged.Ragnarok.AccLow.PDT = set_combine(sets.engaged.Ragnarok.PDT, {})
	sets.engaged.Ragnarok.AccHigh.PDT = set_combine(sets.engaged.Ragnarok.AccLow.PDT, {}) ]]
	
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	-- Mighty Strikes TP Gear, combines with current melee set.
	sets.buff.MS = {}
	-- Earrings to use with all other weaponskills when TP is 3000
	sets.STR_earring = {
    left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
}
	-- Mantle to use with Upheaval on Darksday
	sets.Upheaval_shadow = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] or buffactive['lullaby'] then
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
    if spell.english == 'Berserk'  and windower.ffxi.get_ability_recasts()[spell.recast_id] > 0 then
				eventArgs.cancel = true
                     get_recast_time()

--add_to_chat(410, 'Stopped due to Recast:'..get_recast_time())

    end

end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' then 	
		if TPbonus_ws:contains(spell.name) then
		--windower.add_to_chat(167,"Effective TP:"..get_effective_player_tp(spell, spellMap))
		-- Replace Moonshade Earring if we're at cap TP
		if get_effective_player_tp(spell, spellMap) > 3200 then
					equip(sets.STR_earring)
		end
		end
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if spell.english == "Tomahawk" and not spell.interrupted then 
		send_command('timers create "Tomahawk" 90 down')
	end

	if spell.english == 'Warcry'  and not spell.interrupted then
		lastwarcry = player.name
	end

end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
	update_combat_weapon()
	update_melee_groups()
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == 'Blood Rage' then
 	if gain then
		send_command('timers create "Blood Rage" 60 down abilities/00255.png')
		
		else
		send_command('timers delete "Blood Rage"')
	end
	end
	if buff == 'Warcry' then
	if gain then
		send_command('timers create "Warcry" 60 down abilities/00255.png')
			if windower.ffxi.get_ability_recasts()[2] > 297 then
				lastwarcry = player.name
			end
		else
		lastwarcry = ''
		send_command('timers delete "Warcry"')
	end
	end

    if buff == "terror" then
        if gain then
            equip(sets.idle)
	   else
		handle_equipping_gear(player.status)
        end
    end

    if buff == "petrification" then
        if gain then
            equip(sets.idle)
	   else
		handle_equipping_gear(player.status)
        end
    end

    if buff == "sleep" or buff == "lullaby" then
        if gain then
            equip(sets.idle)
          if player.hp > 300 and player.status == "Engaged" then
               equip({neck={ name="Vim Torque +1", augments={'Path: A',}},})
          end
	   else
		handle_equipping_gear(player.status)
        end
    end

    if buff == "doom" then
        if gain then
            send_command('@input /p Doomed.')
        else
            handle_equipping_gear(player.status)
        end
    end

	if buff == "stun" then
          if gain then
		equip(sets.idle)
		else
		handle_equipping_gear(player.status)
          end
	end
	--if buff == "sleep" then
		--if gain and player.hp > 200 and player.status == "Engaged" then
		--equip({neck="Berserker's Torque"})
		--else
		--handle_equipping_gear(player.status)
		--end
	--end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------


--TP Bonus Handling
function get_effective_player_tp(spell, spellMap)
	local effective_tp = player.tp
	if player.equipment.sub:contains("Blurred Shield +1")  then
 effective_tp = effective_tp + 830
end
	if buffactive['Crystal Blessing'] then
 effective_tp = effective_tp + 250
     end
	if buffactive['Warcry'] and lastwarcry == player.name then
 effective_tp = effective_tp + 700
     end
	--if buffactive['Warcry'] and lastwarcry ~= player.name then
 --effective_tp = effective_tp + 500
     --end
	if TPbonus_ws:contains(spell.name) then
 effective_tp = effective_tp + 250
     end
	if player.equipment.main:contains("Chango") then 
 effective_tp = effective_tp + 500
	end

	return effective_tp
end


--Convert recast time
function get_recast_time(spell, spellMap)

local total_seconds = windower.ffxi.get_ability_recasts()[spell.recast_id]

   local time_hours    = floor(mod(total_seconds, 86400) / 3600)
    local time_minutes  = floor(mod(total_seconds, 3600) / 60)
    local time_seconds  = floor(mod(total_seconds, 60))

    if (time_minutes < 10) then
        time_minutes = "0" .. time_minutes
    end
    if (time_seconds < 10) then
        time_seconds = "0" .. time_seconds
    end
    actualrecast = 'Time left: ' .. time_hours .. ":" .. time_minutes .. ":" .. time_seconds

add_to_chat(122, actualrecast)

end


-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
	local wsmode = ''
	if state.Buff['Mighty Strikes'] then
        wsmode = wsmode .. 'MS'
    end
        if wsmode ~= '' then
            return wsmode
    end
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if buffactive["Mighty Strikes"] then
		meleeSet = set_combine(meleeSet, sets.buff.MS)
	end
	return meleeSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	update_combat_weapon()
	update_melee_groups()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
local msg = 'Melee'
if state.CombatForm.has_value then
msg = msg .. ' (' .. state.CombatForm.value .. ')'
end
if state.CombatWeapon.has_value then
msg = msg .. ' (' .. state.CombatWeapon.value .. ')'
end
msg = msg .. ': '
msg = msg .. state.OffenseMode.value
if state.HybridMode.value ~= 'Normal' then
msg = msg .. '/' .. state.HybridMode.value
end
msg = msg .. ', WS: ' .. state.WeaponskillMode.value
if state.DefenseMode.value ~= 'None' then
msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
end
if state.Kiting.value == true then
msg = msg .. ', Kiting'
end
if state.PCTargetMode.value ~= 'default' then
msg = msg .. ', Target PC: '..state.PCTargetMode.value
end
if state.SelectNPCTargets.value == true then
msg = msg .. ', Target NPCs'
end
add_to_chat(122, msg)
eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.

function update_combat_weapon()
	state.CombatWeapon:set(player.equipment.main)
end

function update_melee_groups()
	classes.CustomMeleeGroups:clear()
	if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Conqueror" then
		classes.CustomMeleeGroups:append('AM3')
	end
	if buffactive.Aftermath and player.equipment.main == "Bravura" and state.HybridMode.value == 'PDT' then
		classes.CustomMeleeGroups:append('AM')
	end
end

function select_default_macro_book()
    	set_macro_page(10, 1) send_command('wait 2; input /lockstyleset 99')
end

