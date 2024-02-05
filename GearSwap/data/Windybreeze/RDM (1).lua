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
    state.Buff.Saboteur = buffactive.saboteur or false
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('TP', 'ACC', 'DTACC')
    state.HybridMode:options('Normal')
    state.CastingMode:options('Normal', 'enmity')
    state.IdleMode:options('Normal')
   
    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
   
    send_command('bind !a gs c cycle CastingMode')
    send_command('bind !q gs c cycle  MagicBurst')
    send_command('bind !z gs c cycle OffenseMode')
    send_command('bind !w gs c toggle WeaponLock')
   
    select_default_macro_book()
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
   
    -- Precast Sets
   
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitivation Tabard"}
   
 
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
       
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
    -- Fast cast sets for spells
   
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
    sets.precast.FC = {
	--main={ name="Grioavolr", augments={'"Occult Acumen"+6','MND+9','Mag. Acc.+25','"Mag.Atk.Bns."+13','Magic Damage +4',}},
	--sub="Niobid Strap",
	ammo="Sapience Orb",
    head="Atro. Chapeau +1",
    body={ name="Merlinic Jubbah", augments={'Phys. dmg. taken -1%','"Mag.Atk.Bns."+28','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    legs="Aya. Cosciales +1",
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+4%','MND+5','"Mag.Atk.Bns."+9',}},
    left_ear="Etiolation Earring",
	left_ring="Kishar Ring",
	right_ring="Lebeche Ring",
	}

	sets.precast.FC['Stun'] = set_combine(sets.precast.FC, {
    ammo="Sapience Orb",
    head={ name="Chironic Hat", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Cure" spellcasting time -10%','MND+14','Mag. Acc.+14',}},
    hands="Jhakri Cuffs +1",
    neck="Incanter's Torque",
    waist="Luminary Sash",
    right_ear="Hermetic Earring",
	left_ring="Kishar Ring",
	right_ring="Lebeche Ring",
    back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+1','"Mag.Atk.Bns."+2',}}
	})
 
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash",})
 
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {legs="Doyen Pants",})
   
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = sets.engaged.TP
       
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    --sets.precast.WS['Requiescat'] = {}
   
    --sets.precast.WS['Sanguine Blade'] = {}
   
   
    -- Midcast Sets
	
	sets.midcast.macc = {
    main={ name="Emissary", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+20','"Refresh"+1',}},
    sub="Ammurapi Shield",
    ammo="Elis Tome",
    head={ name="Chironic Hat", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Cure" spellcasting time -10%','MND+14','Mag. Acc.+14',}},
    body="Atrophy Tabard +1",
    hands="Jhakri Cuffs +1",
    legs={ name="Chironic Hose", augments={'Mag. Acc.+26','"Cure" potency +7%','"Mag.Atk.Bns."+5',}},
    feet="Jhakri Pigaches +1",
    neck="Incanter's Torque",
    waist="Luminary Sash",
    left_ear="Lempo Earring",
    right_ear="Digni. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+1','"Mag.Atk.Bns."+2',}},
	}
	
    sets.midcast.enmity = {
    ammo="Elis Tome",
    body={ name="Merlinic Jubbah", augments={'Phys. dmg. taken -1%','"Mag.Atk.Bns."+28','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    hands={ name="Chironic Gloves", augments={'Pet: "Store TP"+1','Mag. Acc.+16','"Refresh"+1','Accuracy+15 Attack+15','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
    legs={ name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+30','Magic Damage +9','Mag. Acc.+6',}},
    feet={ name="Chironic Slippers", augments={'Attack+8','AGI+1','"Refresh"+1',}},
}
 
    sets.midcast.Cure = {
	main={ name="Grioavolr", augments={'"Occult Acumen"+6','MND+9','Mag. Acc.+25','"Mag.Atk.Bns."+13','Magic Damage +4',}},
    sub="Niobid Strap",
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body={ name="Chironic Doublet", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','"Cure" potency +11%','MND+2','Mag. Acc.+11',}},
    hands="Bokwus Gloves",
    legs={ name="Chironic Hose", augments={'Mag. Acc.+26','"Cure" potency +7%','"Mag.Atk.Bns."+5',}},
    neck="Incanter's Torque",
	}
       
    sets.midcast.Curaga = sets.midcast.Cure
   
    sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {
        waist="Gishdubar Sash",}) -- (10)
   
    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {waist="Gishdubar Sash"})
       
 
    sets.midcast['Enhancing Magic'] = {}
 
    --sets.midcast.Refresh =  
 
    sets.midcast['Stoneskin'] = {
    --main={ name="Grioavolr", augments={'"Occult Acumen"+6','MND+9','Mag. Acc.+25','"Mag.Atk.Bns."+13','Magic Damage +4',}},
    --sub="Clemency Grip",
    head="Befouled Crown",
    hands={ name="Chironic Gloves", augments={'Pet: "Store TP"+1','Mag. Acc.+16','"Refresh"+1','Accuracy+15 Attack+15','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
    neck="Nodens Gorget",
    waist="Porous Rope",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Estoqueur's Cape",
	}
   
    ------ MND Enfeebling skill ----
     
    sets.midcast['Frazzle II'] = sets.midcast.macc
   
    sets.midcast['Slow II'] = sets.midcast.macc
 
    sets.midcast['Paralyze II'] = sets.midcast.macc
	
    --- Enfeebling potancy ----
   
    sets.midcast['Distract III'] = sets.midcast.macc
 
    sets.midcast['Frazzle III'] = sets.midcast.macc
 
    sets.midcast['Poison II'] = sets.midcast.macc
   
    sets.midcast['Addle II'] = sets.midcast.macc
   
    ---- MACC Enfeebling magic ----
	
	sets.midcast['Blind II'] = sets.midcast.macc
	
	sets.midcast['Stun'] = sets.midcast.macc
   
    sets.midcast['Inundation'] = sets.midcast.macc
	
    sets.midcast['Sleepga'] = sets.midcast.macc
   
    sets.midcast['Sleep'] = sets.midcast.macc
   
    sets.midcast['Sleep II'] = sets.midcast.macc
 
    sets.midcast['Silence'] = sets.midcast.macc
 
    sets.midcast['Gravity II'] = sets.midcast.macc
   
    sets.midcast['Dispel'] = sets.midcast.macc
    --- Enhancing ---
 
    sets.midcast.EnhancingDuration = {back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+1','"Mag.Atk.Bns."+2',}}}
   
    sets.midcast['Haste II'] = set_combine(sets.midcast['EnhancingDuration'], {})
    sets.midcast['[Regen II'] = set_combine(sets.midcast["EnhancingDuration"], {main="Bolelabunga"})
    sets.midcast['Flurry II'] = set_combine(sets.midcast['EnhancingDuration'], {})
    sets.midcast.Aquaveil = set_combine(sets.midcast['EnhancingDuration'], {})
   
    sets.midcast['Refresh II'] = {
    head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    body="Atrophy Tabard +2",
    hands="Atrophy Gloves +3",
    legs="Leth. Fuseau",
    feet="Leth. Houseaux +1",
    waist="Gishdubar Sash",
    back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+1','"Mag.Atk.Bns."+2',}},
}
   
    sets.midcast['Refresh III'] = {
    head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    body="Atrophy Tabard +2",
    hands="Atrophy Gloves +3",
    legs="Leth. Fuseau",
    feet="Leth. Houseaux +1",
    waist="Gishdubar Sash",
    back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+1','"Mag.Atk.Bns."+2',}},
}
   
    sets.midcast['Elemental Magic'] = {}
 
    sets.magicburst = {}  
 
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})
 
    sets.midcast['Dark Magic'] = sets.precast.FC
 
    --sets.midcast.Stun = sets.precast.FC
 
    sets.midcast.Drain = set_combine(sets.midcast.macc, {
	feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+4%','MND+5','"Mag.Atk.Bns."+9',}},
    neck="Erra Pendant",
    right_ring="Evanescence Ring"
	})
 
    sets.midcast.Aspir = sets.precast.FC
   
    sets.enmity = {}
 
   -- sets.midcast['Healing Magic'].enmity = set_combine(sets.enmity, {})
   -- sets.midcast['Dark Magic'].enmity = set_combine(sets.enmity, {})
    -- sets.midcast['Elemental Magic'].enmity = set_combine(sets.enmity, {})
    -- sets.midcast['Enfeebling Magic'].enmity = set_combine(sets.enmity, {})
    -- Sets for special buff conditions on spells.
 
    --sets.midcast.EnhancingDuration = {
    --main="Bolelabunga",
    --ammo="Ghastly Tathlum",
    --head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
    --body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
    --hands="Atrophy Gloves",
    --legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +9',}},
    --feet="Leth. Houseaux",
    --neck="Enhancing Torque",
    --waist="Gishdubar Sash",
    --left_ear="Lifestorm Earring",
    --right_ear="Loquac. Earring",
    --left_ring="Stikini Ring",
    --right_ring="Stikini Ring",
    --back="Sucellos's Cape",}
       
    sets.buff.ComposureOther = {}
 
    sets.buff.Saboteur = set_combine(sets.midcast['Enfeebling Magic'], {hands="lethargy gantherots"})
   
 
    -- Sets to return to when not performing an action.
   
    -- Idle sets
    sets.idle.Field  = {
    --main={ name="Grioavolr", augments={'"Occult Acumen"+6','MND+9','Mag. Acc.+25','"Mag.Atk.Bns."+13','Magic Damage +4',}},
    --sub="Clemency Grip",
    ammo="Homiliary",
    head="Befouled Crown",
    body="Jhakri Robe +2",
    hands={ name="Merlinic Dastanas", augments={'Pet: "Dbl. Atk."+3','CHR+3','"Refresh"+2','Accuracy+11 Attack+11',}},
    legs="Aya. Cosciales +1",
    feet={ name="Merlinic Crackows", augments={'Sklchn.dmg.+1%','MND+5','"Refresh"+1','Accuracy+6 Attack+6','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
    neck="Incanter's Torque",
    waist="Luminary Sash",
    left_ear="Etiolation Earring",
    right_ear="Calamitous Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Agema Cape",
}
 
    sets.idle.Town = sets.idle.Field
   
    -- Defense sets
   
    sets.Kiting = {legs="Blood Cuisses"}
 
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
   
    -- Normal melee group
    --acc1036 att966
    sets.engaged.TP = {
   -- main="Egeking",
    --sub={ name="Emissary", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+20','"Refresh"+1',}},
    ammo="Amar Cluster",
    head="Aya. Zucchetto +1",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +1",
    legs="Aya. Cosciales +1",
    feet="Jhakri Pigaches +1",
    neck="Sanctity Necklace",
    waist="Grunfeld Rope",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Begrudging Ring",
    right_ring="Petrov Ring",
    back="Atheling Mantle",
}
    --acc1131 att1010
    sets.engaged.ACC = sets.engaged.TP
   
    sets.engaged.DTACC = sets.engaged.TP
   
    sets.buff.Doom = {waist="Gishdubar Sash"}
   
    sets.precast.WS = sets.engaged.TP

 
    sets.precast.WS['Red Lotus Blade'] = sets.engaged.TP
   
    sets.precast.WS['Volpal Blade'] = sets.engaged.TP
   
    sets.precast.WS['Savage Blade'] = sets.engaged.TP
       
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
 
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
         equip(sets.buff.Saboteur)
     end
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value == true then
        equip(sets.magicburst)
      end
    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
     end
    if ( spell.action_type == 'Magic' and state.CastingMode.value == 'enmity' ) then
    equip(sets.enmity)
     end
  end    
    --if buffactive.composure and spell.target.type == 'PLAYER' then
      --  equip(sets.buff.ComposureOther)
     --end
 -- end
     
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Handle notifications of general user state change.
 --function job_state_change(stateField, newValue, oldValue)
  --   if stateField == 'Offense Mode' then
   --      if newValue == 'None' then
   --          enable('main','sub','range')
    --     else
   --          disable('main','sub','range')
   --      end
 --     end
--end    
 
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub','range')
    else
        enable('main','sub')
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
-- Modify the default idle set after it was constructed.
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 10)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 4)
    else
        set_macro_page(3, 3)
    end
end