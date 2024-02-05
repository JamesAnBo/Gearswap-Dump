function get_sets()
	send_command('bind ^f11 gs c C2') -- alt fp for macc
	send_command('bind f9 gs c C1') -- f9 for accuracy
	send_command('bind ^f9 gs c C17') -- ctrl f9 for weapon toggle
	send_command('bind f10 gs c C7') -- f10 toggle pdt
	send_command('bind f11 gs c C2') -- f11 toggle hybrid
	send_command('bind f12 gs c C5') -- Auto Update Gear Toggle -- I have no idea what this does, but I put it on f12
	send_command('bind ^f12 gs c C6') -- change between different idle sets
-- 3 Levels Of Accuracy Sets For TP/WS/Hybrid/Stun. First Set Is LowACC.
--Add More ACC Sets If Needed Then Create Your New ACC Below.
    AccIndex = 1
    AccArray = {"LowACC","MidACC","HighACC"}
    MaccIndex = 1
    MaccArray = {"Potency","Resist","Duration"}
--Can Delete Any Weapons/Sets That You Don't Need Or Replace/Add The New Weapons That You Want To Use. --
    WeaponIndex = 1
    WeaponArray = {"Caladbolg","Apocalypse","Club"} --,"Liberator,"Ragnarok"
    IdleIndex = 1
    IdleArray = {"Regen","Refresh","Regain","Twilight"} -- Default Idle Set Is Movement --
    DarkSealIndex = 0 --Index for Dark Seal headpiece Potency(0) vs Duration(1)
    --add_to_chat(158,'DarkSeal Potency: [On]')
    Armor = 'None'
    Twilight = 'None'
    Samurai_Roll = 'ON' -- Set Default SAM Roll ON or OFF Here --
    target_distance = 5 -- Set Default Distance Here --
    select_default_macro_book() -- Change Default Macro Book At The End --
 
   
    sets.Idle = {          
    ammo="Staunch Tathlum +1",
    head="Ratri Sallet +1",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Carmine Cuisses +1",
    feet="Sakpata's Leggings",
    neck="Twilight Torque",
    waist="Flume Belt",
    left_ear="Cessance Earring",
    right_ear="Eabani Earring", 
    left_ring="Defending Ring",
    right_ring={name="Moonlight Ring",bag="wardrobe4"},
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
 
    sets.Idle.Regen = {   
     ammo="Staunch Tathlum +1",
    head="Volte Salade",
     body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Carmine Cuisses +1",
    feet="Sakpata's Leggings",
    neck="Wiglen Gorget",
    waist="Flume Belt",
    left_ear="Cessance Earring",
    right_ear="Eabani Earring", 
    left_ring="Chirich Ring +1",
    right_ring="Sheltered Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
	
	 sets.Idle.Refresh = {   
     ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Carmine Cuisses +1",
    feet="Sakpata's Leggings",
    neck="Sanctity Necklace",
    waist="Flume Belt",
    left_ear="Cessance Earring",
    right_ear="Eabani Earring", 
        left_ring={name="Stikini Ring +1", bag="wardrobe2"},
        right_ring={name="Stikini Ring +1", bag="wardrobe3"},
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
	
	    sets.Idle.Twilight = {   
     ammo="Staunch Tathlum +1",
    head="Twilight Helm",
    body="Twilight Mail",
    hands="Sakpata's Gauntlets",
    legs="Carmine Cuisses +1",
    feet="Sakpata's Leggings",
    neck="Twilight Torque",
    waist="Flume Belt",
    left_ear="Cessance Earring",
    right_ear="Eabani Earring", 
    left_ring="Chirich Ring +1",
    right_ring="Sheltered Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
	
	
	
	
 

 
    -- JA Sets --
    sets.JA = {}
    sets.JA['Diabolic Eye'] = {hands="Fallen's finger gauntlets +3"}
    sets.JA['Arcane Circle'] = {feet="Ignominy Sollerets +1"}
    sets.JA['Nether Void'] = {legs="Heath. Flanchard +1"}
    sets.JA['Souleater'] = {head="Ignominy Burgonet +1"}
    sets.JA['Weapon Bash'] = {hands="Ignominy Gauntlets +1"}
    sets.JA['Last Resort'] = {back="Ankou's Mantle",feet="Fallen's Sollerets"}
    sets.JA['Dark Seal'] = {head="Fallen's Burgeonet +2"}
    sets.JA['Blood Weapon'] = {body="Fallen's Cuirass +1"}
 
    sets.Precast = {}
    -- Fastcast Set --
    sets.Precast.FastCast = {
    ammo="Sapience Orb",
    head="Carmine Mask +1",
    body={ name="Odyss. Chestplate", augments={'"Mag.Atk.Bns."+14','"Fast Cast"+6','MND+4',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
    feet="Carmine Greaves +1",
    neck="Baetyl Pendant",
    waist="Flume Belt",
    left_ear="Loquac. Earring",
    right_ear="Malignance Earring",
    left_ring="Kishar Ring",
    left_ring={name="Stikini Ring +1", bag="wardrobe2"},
    back="Moonlight Cape",} -- 11
        --72 FC
 
    -- Precast Dark Magic --
    sets.Precast['Dark Magic'] = set_combine(sets.Precast.FastCast,{})
 
    -- Midcast Base Set --
    sets.Midcast = {}
   
    -- Magic Haste Set --
    sets.Midcast.Haste = set_combine(sets.PDT,{})
 
    -- Dark Magic Set --
    sets.Midcast['Dark Magic'] = {
        ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body="Carm. Scale Mail",
    hands="Fallen's finger gauntlets +3",
    legs="Fallen's Flanchard +3",
    feet={ name="Odyssean Greaves", augments={'"Fast Cast"+4','Mag. Acc.+11',}},
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Digni. Earring",
    right_ear="Friomisi Earring",
    left_ring={name="Stikini Ring +1", bag="wardrobe2"},
    right_ring="Evanescence Ring",
    back={ name="Niht Mantle", augments={'Attack+12','Dark magic skill +9','"Drain" and "Aspir" potency +21',}},}
   
    -- Absorb Set --
    sets.Midcast.Absorb = {
        ammo="Pemphredo Tathlum",
    head="Ignominy Burgonet +3",
    body="Carm. Scale Mail",
    hands="Fallen's finger gauntlets +3",
    legs="Fallen's Flanchard +3",
    feet="Ratri Sollerets +1",
    neck="Erra Pendant",
    waist="Eschan Stone",
    left_ear="Digni. Earring",
    right_ear="Friomisi Earring",
    left_ring={name="Stikini Ring +1", bag="wardrobe2"},
    right_ring="Kishar Ring",
    back="Chuparrosa Mantle",}
    
    sets.Midcast.Absorb.Duration = set_combine(sets.Midcast.Absorb,{hands="Onyx Gadlings", legs="Black Cuisses"})
           
    -- Absorb-TP Set --
    sets.Midcast['Absorb-TP'] = set_combine(sets.Midcast.Absorb,{hands="Heathen's Gauntlets +1"})
 
    -- Stun Sets --
    sets.Midcast.Stun = set_combine(sets.Midcast['Dark Magic'],{
        head="Carmine Mask +1",
        hands="Leyline Gloves",
        left_ring="Regal Ring",
        waist="Eschan Stone",
        legs="Eschite cuisses",
        feet="Ignominy Sollerets +1",
        back=""})
    sets.Midcast.Stun.Resist = set_combine(sets.Midcast.Stun,{})
    sets.Midcast.Stun.Duration = set_combine(sets.Midcast.Stun,{left_ring="Stikini Ring",feet="Ratri Sollerets +1",})
 
    -- Endark Set --
    sets.Midcast['Endark II'] = {
        ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body="Carm. Scale Mail",
    hands="Fallen's finger gauntlets +3",
    legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
    feet={ name="Odyssean Greaves", augments={'"Fast Cast"+4','Mag. Acc.+11',}},
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Digni. Earring",
    right_ear="Friomisi Earring",
    left_ring="Archon Ring",
    right_ring="Evanescence Ring",
    back={ name="Niht Mantle", augments={'Attack+12','Dark magic skill +9','"Drain" and "Aspir" potency +21',}},}
 
    -- Enfeebling Magic Set --
    sets.Midcast['Enfeebling Magic'] = {
        ammo="Pemphredo Tathlum",
        head="Carmine Mask +1",
        body="Ignominy Cuirass +3",
        hands="Leyline Gloves",
        legs="Eschite cuisses",
        feet="Ignominy Sollerets +2",
        neck="Sanctity necklace",
        waist="Eschan Stone",
        left_ear="Loquacious Earring",
        right_ear="Digni. Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back="",}
 
    -- Elemental Magic Set --
    sets.Midcast['Elemental Magic'] = {
        ammo="Pemphredo Tathlum",
        head="Carmine Mask +1",
        body="Carmine Scale Mail",
        hands="Leyline gloves",
        legs="Eschite Cuisses",
        feet="Ignominy Sollerets +1",
        neck="Sanctity necklace",
        waist="Eschan Stone",
        left_ear="Hecate's Earring",
        right_ear="Friomisi Earring",
        left_ring="Stikini Ring",
        right_ring="Shiva Ring",
        back="",}
 
    -- Dread Spikes Set --
    sets.Midcast['Dread Spikes'] = {
        head="Ratri Sallet +1",
    body="Heath. Cuirass +1",
    hands="Ratri Gadlings +1",
    legs="Ratri Cuisses +1",
    feet="Ratri Sollerets +1",
    neck="Erra Pendant",
    waist="Eschan Stone",
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring={name="Moonlight Ring",bag="wardrobe2"},
    right_ring={name="Moonlight Ring",bag="wardrobe4"},
    back="Moonlight Cape",}
       
    sets.Midcast.Drain = {
    --Range="ullr",
    head="Fall. Burgeonet +3",
    body="Carm. Scale Mail",
    hands="Fallen's finger gauntlets +3",
    legs={ name="Odyssean Cuisses", augments={'MND+9','"Drain" and "Aspir" potency +9','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    feet="Ratri Sollerets +1",
    neck="Erra Pendant",
    waist="Eschan Stone",
    left_ear="Digni. Earring",
    right_ear="Malignance Earring",
    left_ring="Archon Ring",
    right_ring="Evanescence Ring",
    back={ name="Niht Mantle", augments={'Attack+12','Dark magic skill +9','"Drain" and "Aspir" potency +21',}},}
 
    sets.Midcast.Aspir = set_combine(sets.Midcast.Drain, {})
   
    sets.MAXDrain = {main="Misanthropy",}
   
        -- TP Base Set --
    sets.TP = {}
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------- LIBERATOR SETS -----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
   
    -- Liberator(AM3 Down) TP Sets --
    sets.TP.Liberator = {main="Liberator",}
    sets.TP.Liberator.MidACC = set_combine(sets.TP.Liberator,{})
    sets.TP.Liberator.HighACC = set_combine(sets.TP.Liberator.MidACC,{})
 
    -- Liberator(AM3 Up) TP Sets --
    sets.TP.Liberator.AM3 = set_combine(sets.TP.Liberator,{})
    sets.TP.Liberator.MidACC.AM3 = set_combine(sets.TP.Liberator.AM3,{})
    sets.TP.Liberator.HighACC.AM3 = set_combine(sets.TP.Liberator.MidACC.AM3,{})
 
    -- Liberator(AM3 Down: High Haste) TP Sets --
    sets.TP.Liberator.HighHaste = set_combine(sets.TP.Liberator,{})
    sets.TP.Liberator.MidACC.HighHaste = set_combine(sets.TP.Liberator.HighHaste,{})
    sets.TP.Liberator.HighACC.HighHaste = set_combine(sets.TP.Liberator.MidACC.HighHaste,{})
 
    -- Liberator(AM3 Up: High Haste) TP Sets --
    sets.TP.Liberator.AM3_HighHaste = set_combine(sets.TP.Liberator.AM3,{})
    sets.TP.Liberator.MidACC.AM3_HighHaste = set_combine(sets.TP.Liberator.AM3_HighHaste,{})
    sets.TP.Liberator.HighACC.AM3_HighHaste = set_combine(sets.TP.Liberator.MidACC.AM3_HighHaste,{})
 
    -- Liberator(AM3 Down: SAM Roll) TP Sets --
    sets.TP.Liberator.STP = set_combine(sets.TP.Liberator,{})
    sets.TP.Liberator.MidACC.STP = set_combine(sets.TP.Liberator.MidACC,{})
    sets.TP.Liberator.HighACC.STP = set_combine(sets.TP.Liberator.HighACC,{})
 
    -- Liberator(AM3 Up: SAM Roll) TP Sets --
    sets.TP.Liberator.AM3.STP = set_combine(sets.TP.Liberator.AM3,{})
    sets.TP.Liberator.MidACC.AM3.STP = set_combine(sets.TP.Liberator.MidACC.AM3,{})
    sets.TP.Liberator.HighACC.AM3.STP = set_combine(sets.TP.Liberator.HighACC.AM3,{})
 
    -- Liberator(AM3 Down: High Haste + SAM Roll) TP Sets --
    sets.TP.Liberator.HighHaste.STP = set_combine(sets.TP.Liberator.HighHaste,{})
    sets.TP.Liberator.MidACC.HighHaste.STP = set_combine(sets.TP.Liberator.MidACC.HighHaste,{})
    sets.TP.Liberator.HighACC.HighHaste.STP = set_combine(sets.TP.Liberator.HighACC.HighHaste,{})
 
    -- Liberator(AM3 Up: High Haste + SAM Roll) TP Sets --
    sets.TP.Liberator.AM3_HighHaste.STP = set_combine(sets.TP.Liberator.HighHaste,{})
    sets.TP.Liberator.MidACC.AM3_HighHaste.STP = set_combine(sets.TP.Liberator.MidACC.HighHaste,{})
    sets.TP.Liberator.HighACC.AM3_HighHaste.STP = set_combine(sets.TP.Liberator.HighACC.HighHaste,{})
 
    ---------------------------------- /sam sets --------------------------------------
   
    -- Liberator(AM3 Down) /SAM TP Sets --
    sets.TP.Liberator.SAM = {main="Liberator",}
    sets.TP.Liberator.SAM.MidACC = set_combine(sets.TP.Liberator.SAM,{})
    sets.TP.Liberator.SAM.HighACC = set_combine(sets.TP.Liberator.SAM.MidACC,{})
 
    -- Liberator(AM3 Up) /SAM TP Sets --
    sets.TP.Liberator.SAM.AM3 = set_combine(sets.TP.Liberator.SAM,{})
    sets.TP.Liberator.SAM.MidACC.AM3 = set_combine(sets.TP.Liberator.SAM.AM3,{})
    sets.TP.Liberator.SAM.HighACC.AM3 = set_combine(sets.TP.Liberator.SAM.MidACC.AM3,{})
 
    -- Liberator(AM3 Down: High Haste) /SAM TP Sets --
    sets.TP.Liberator.SAM.HighHaste = set_combine(sets.TP.Liberator.SAM,{waist="Sailfi Belt +1",})
    sets.TP.Liberator.SAM.MidACC.HighHaste = set_combine(sets.TP.Liberator.SAM.HighHaste,{})
    sets.TP.Liberator.SAM.HighACC.HighHaste = set_combine(sets.TP.Liberator.SAM.MidACC.HighHaste,{})
 
    -- Liberator(AM3 Up: High Haste) /SAM TP Sets --
    sets.TP.Liberator.SAM.AM3_HighHaste = set_combine(sets.TP.Liberator.SAM.AM3,{waist="Sailfi Belt +1",})
    sets.TP.Liberator.SAM.MidACC.AM3_HighHaste = set_combine(sets.TP.Liberator.SAM.AM3_HighHaste,{})
    sets.TP.Liberator.SAM.HighACC.AM3_HighHaste = set_combine(sets.TP.Liberator.SAM.MidACC.AM3_HighHaste,{})
 
    -- Liberator(AM3 Down: SAM Roll) /SAM TP Sets --
    sets.TP.Liberator.SAM.STP = set_combine(sets.TP.Liberator.SAM,{})
    sets.TP.Liberator.SAM.MidACC.STP = set_combine(sets.TP.Liberator.SAM.MidACC,{})
    sets.TP.Liberator.SAM.HighACC.STP = set_combine(sets.TP.Liberator.SAM.HighACC,{})
 
    -- Liberator(AM3 Up: SAM Roll) /SAM TP Sets --
    sets.TP.Liberator.SAM.AM3.STP = set_combine(sets.TP.Liberator.SAM.AM3,{})
    sets.TP.Liberator.SAM.MidACC.AM3.STP = set_combine(sets.TP.Liberator.SAM.MidACC.AM3,{})
    sets.TP.Liberator.SAM.HighACC.AM3.STP = set_combine(sets.TP.Liberator.SAM.HighACC.AM3,{})
 
    -- Liberator(AM3 Down: High Haste + SAM Roll) /SAM TP Sets --
    sets.TP.Liberator.SAM.HighHaste.STP = set_combine(sets.TP.Liberator.SAM.HighHaste,{})
    sets.TP.Liberator.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.Liberator.SAM.MidACC.HighHaste,{})
    sets.TP.Liberator.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.Liberator.SAM.HighACC.HighHaste,{})
 
    -- Liberator(AM3 Up: High Haste + SAM Roll) /SAM TP Sets --
    sets.TP.Liberator.SAM.AM3_HighHaste.STP = set_combine(sets.TP.Liberator.SAM.HighHaste,{})
    sets.TP.Liberator.SAM.MidACC.AM3_HighHaste.STP = set_combine(sets.TP.Liberator.SAM.MidACC.HighHaste,{})
    sets.TP.Liberator.SAM.HighACC.AM3_HighHaste.STP = set_combine(sets.TP.Liberator.SAM.HighACC.HighHaste,{})
 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------- RAGNAROK SETS -----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
    -- Ragnarok TP Sets --
    sets.TP.Ragnarok = {main="Ragnarok",
        ammo="Aurgelmir Orb +1",
    head="Flam. Zucchetto +2",
    Body="Sakpata's Breastplate",
    hands={ name="Emi. Gauntlets +1", augments={'HP+65','DEX+12','Accuracy+20',}},
    legs="Ignominy Flanchard +3",
    feet="Flam. Gambieras +2",
    neck="Abyssal Beads +2",
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Digni. Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}}
       
    sets.TP.Ragnarok.MidACC = set_combine(sets.TP.Ragnarok,{
        hands="Emicho Gauntlets +1",
        left_ear="Cessance earring",
        left_ring="Chirich Ring",})
       
    sets.TP.Ragnarok.HighACC = set_combine(sets.TP.Ragnarok.MidACC,{
        head="Ignominy Burgonet +3",
        neck="Abyssal Beads +2",
        body="Ignominy Cuirass +3",
        hands="Ignominy Gauntlets +3",
        legs="Ignominy Flanchard +3",
        left_ring="Regal Ring",})
       
    -- Ragnarok(High Haste) TP Sets --
    sets.TP.Ragnarok.HighHaste = set_combine(sets.TP.Ragnarok,{waist="Sailfi Belt +1",})
    sets.TP.Ragnarok.MidACC.HighHaste = set_combine(sets.TP.Ragnarok.HighHaste,{waist="Sailfi Belt +1",})
    sets.TP.Ragnarok.HighACC.HighHaste = set_combine(sets.TP.Ragnarok.MidACC.HighHaste,{ammo="Aurgelmir Orb +1",waist="Kentarch Belt +1",})
   
    -- Ragnarok(SAM Roll) TP Sets --
    sets.TP.Ragnarok.STP = set_combine(sets.TP.Ragnarok,{left_ear="Cessance earring",})
    sets.TP.Ragnarok.MidACC.STP = set_combine(sets.TP.Ragnarok.STP,{})
    sets.TP.Ragnarok.HighACC.STP = set_combine(sets.TP.Ragnarok.MidACC.STP,{
        ammo="Aurgelmir Orb +1",
        neck="Abyssal Beads +2",
        ear1="Mache Earring",
        feet="Flamma Gambieras +1"})
                           
    -- Ragnarok(High Haste + SAM Roll) TP Sets --
    sets.TP.Ragnarok.HighHaste.STP = set_combine(sets.TP.Ragnarok.STP,{waist="Sailfi Belt +1",})
    sets.TP.Ragnarok.MidACC.HighHaste.STP = set_combine(sets.TP.Ragnarok.MidACC.STP,{waist="Sailfi Belt +1",})
    sets.TP.Ragnarok.HighACC.HighHaste.STP = set_combine(sets.TP.Ragnarok.HighACC.STP,{waist="Sailfi Belt +1",})
   
    ------------------- /sam sets -----------------------------
   
    -- Ragnarok /SAM TP Sets --
    sets.TP.Ragnarok.SAM = {main="Ragnarok",
        ammo="Aurgelmir Orb +1",
    head="Flam. Zucchetto +2",
    Body="Sakpata's Breastplate",
    hands={ name="Emi. Gauntlets +1", augments={'HP+65','DEX+12','Accuracy+20',}},
    legs="Ignominy Flanchard +3",
    feet="Flam. Gambieras +2",
    neck="Abyssal Beads +2",
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Digni. Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}}
   
    sets.TP.Ragnarok.SAM.MidACC = set_combine(sets.TP.Ragnarok.SAM,{
        hands="Emicho Gauntlets +1",
        left_ear="Cessance earring",
        left_ring="Chirich Ring",})
   
    sets.TP.Ragnarok.SAM.HighACC = set_combine(sets.TP.Ragnarok.SAM.MidACC,{
        head="Ignominy Burgonet +3",
        neck="Abyssal Beads +2",
        body="Ignominy Cuirass +3",
        hands="Ignominy Gauntlets +3",
        legs="Ignominy Flanchard +3",
        left_ring="Regal Ring",})
 
    -- Ragnarok(High Haste) /SAM TP Sets --
    sets.TP.Ragnarok.SAM.HighHaste = set_combine(sets.TP.Ragnarok.SAM,{waist="Sailfi Belt +1",})
    sets.TP.Ragnarok.SAM.MidACC.HighHaste = set_combine(sets.TP.Ragnarok.SAM.MidACC,{waist="Sailfi Belt +1",})
    sets.TP.Ragnarok.SAM.HighACC.HighHaste = set_combine(sets.TP.Ragnarok.SAM.HighACC,{ammo="Aurgelmir Orb +1",waist="Kentarch Belt +1",})
 
    -- Ragnarok(SAM Roll) /SAM TP Sets --
    sets.TP.Ragnarok.SAM.STP = set_combine(sets.TP.Ragnarok.SAM,{left_ear="Cessance earring",})
    sets.TP.Ragnarok.SAM.MidACC.STP = set_combine(sets.TP.Ragnarok.SAM.MidACC,{})
    sets.TP.Ragnarok.SAM.HighACC.STP = set_combine(sets.TP.Ragnarok.SAM.HighACC,{
        ammo="Aurgelmir Orb +1",
        neck="Abyssal Beads +2",
        ear1="Mache Earring",
        feet="Flamma Gambieras +1"})
 
    -- Ragnarok(High Haste + SAM Roll) /SAM TP Sets --
    sets.TP.Ragnarok.SAM.HighHaste.STP = set_combine(sets.TP.Ragnarok.SAM.STP,{waist="Sailfi Belt +1",})
    sets.TP.Ragnarok.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.Ragnarok.SAM.MidACC.STP,{waist="Sailfi Belt +1",})
    sets.TP.Ragnarok.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.Ragnarok.SAM.HighACC.STP,{waist="Sailfi Belt +1",})
   -------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------- CLUB SETS -----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

    sets.TP.Club = {
	main="Loxotic Mace +1",
	sub="Blurred Shield +1",
    ammo="Aurgelmir Orb +1",
    head="Flamma zucchetto +2",
    body={ name="Valorous Mail", augments={'Accuracy+17 Attack+17','"Store TP"+7','DEX+10','Accuracy+7','Attack+13',}},
    hands="Flamma manopolas +2",
    legs="Ig. Flanchard +3",
    feet="Flamma gambieras +2",
    neck={ name="Abyssal Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}




-------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------- APOCALYPSE SETS -----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
    -- Apocalypse(AM Down) TP Sets --
    sets.TP.Apocalypse = {main="Apocalypse",
	sub="Utu Grip",
    ammo="Aurgelmir Orb +1",
    head="Sakpata's Helm",
    body={ name="Valorous Mail", augments={'Accuracy+17 Attack+17','"Store TP"+7','DEX+10','Accuracy+7','Attack+13',}},
    hands="Sakpata's Gauntlets",
    legs="Ig. Flanchard +3",
    feet="Sakpata's Leggings",
    neck={ name="Abyssal Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}
       
    sets.TP.Apocalypse.MidACC = set_combine(sets.TP.Apocalypse,{
            hands={ name="Emi. Gauntlets +1", augments={'HP+65','DEX+12','Accuracy+20',}},})
       
    sets.TP.Apocalypse.HighACC = set_combine(sets.TP.Apocalypse.MidACC,{
        ammo="Aurgelmir Orb +1",
        head="Ignominy Burgonet +3",
        body="Ignominy Cuirass +3",
        legs="Ignominy Flanchard +3",
		right_ring="Chirich Ring +1",
		 waist="Ioskeha Belt +1",
		 right_ear="Zennaroi Earring",
        --left_ring="Regal Ring",
        feet="",})
 
 
    -- Apocalypse(AM Down: High Haste) TP Sets --
    sets.TP.Apocalypse.HighHaste = set_combine(sets.TP.Apocalypse,{})
    sets.TP.Apocalypse.MidACC.HighHaste = set_combine(sets.TP.Apocalypse.MidACC,{})
    sets.TP.Apocalypse.HighACC.HighHaste = set_combine(sets.TP.Apocalypse.HighACC,{})
   
    -- Apocalypse(AM Down: SAM Roll) TP Sets --
    sets.TP.Apocalypse.STP = set_combine(sets.TP.Apocalypse,{})
    sets.TP.Apocalypse.MidACC.STP = set_combine(sets.TP.Apocalypse.MidACC,{})
    sets.TP.Apocalypse.HighACC.STP = set_combine(sets.TP.Apocalypse.HighACC,{})
   
    -- Apocalypse(AM Down: High Haste + SAM Roll) TP Sets --
    sets.TP.Apocalypse.HighHaste.STP = set_combine(sets.TP.Apocalypse.STP,{})
    sets.TP.Apocalypse.MidACC.HighHaste.STP = set_combine(sets.TP.Apocalypse.MidACC.STP,{})
    sets.TP.Apocalypse.HighACC.HighHaste.STP = set_combine(sets.TP.Apocalypse.HighACC.STP,{})
   
    -- Apocalypse(AM Up) TP Sets --
    sets.TP.Apocalypse.AM = set_combine(sets.TP.Apocalypse,{})
    sets.TP.Apocalypse.MidACC.AM = set_combine(sets.TP.Apocalypse.MidACC,{})
    sets.TP.Apocalypse.HighACC.AM = set_combine(sets.TP.Apocalypse.HighACC,{})
 
    -- Apocalypse(AM Up: High Haste) TP Sets --
    sets.TP.Apocalypse.AM.HighHaste = set_combine(sets.TP.Apocalypse.AM,{})
    sets.TP.Apocalypse.MidACC.AM.HighHaste = set_combine(sets.TP.Apocalypse.MidACC.AM,{})
    sets.TP.Apocalypse.HighACC.AM.HighHaste = set_combine(sets.TP.Apocalypse.HighACC.AM,{})
 
    -- Apocalypse(AM Up: SAM Roll) TP Sets --
    sets.TP.Apocalypse.AM.STP = set_combine(sets.TP.Apocalypse.AM,{})
    sets.TP.Apocalypse.MidACC.AM.STP = set_combine(sets.TP.Apocalypse.MidACC.AM,{})
    sets.TP.Apocalypse.HighACC.AM.STP = set_combine(sets.TP.Apocalypse.HighACC.AM,{})
 
    -- Apocalypse(AM Up: High Haste + SAM Roll) TP Sets --
    sets.TP.Apocalypse.AM.HighHaste.STP = set_combine(sets.TP.Apocalypse.AM.STP,{})
    sets.TP.Apocalypse.MidACC.AM.HighHaste.STP = set_combine(sets.TP.Apocalypse.MidACC.AM.STP,{})
    sets.TP.Apocalypse.HighACC.AM.HighHaste.STP = set_combine(sets.TP.Apocalypse.HighACC.AM.STP,{})
 
    ------------ /sam sets --------------------------------
   
    -- Apocalypse(AM Down) /SAM TP Sets --
    sets.TP.Apocalypse.SAM = {
	main="Apocalypse",
	sub="Utu Grip",
    ammo="Aurgelmir Orb +1",
    head="Sakpata's Helm",
    body="Sakpata's Breastplate",
    hands="Sakpata's Gauntlets",
    legs="Ig. Flanchard +3",
    feet="Sakpata's Leggings",
    neck={ name="Abyssal Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}
       
    sets.TP.Apocalypse.SAM.MidACC = {
    ammo="Aurgelmir Orb +1",
    head="Flam. Zucchetto +2",
    body={ name="Valorous Mail", augments={'Accuracy+17 Attack+17','"Store TP"+7','DEX+10','Accuracy+7','Attack+13',}},
    hands={ name="Emi. Gauntlets +1", augments={'HP+65','DEX+12','Accuracy+20',}},
    legs="Ig. Flanchard +3",
    feet="Flam. Gambieras +2",
    neck={ name="Abyssal Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		}
       
    sets.TP.Apocalypse.SAM.HighACC = {
    ammo="Aurgelmir Orb +1",
    head="Flam. Zucchetto +2",
    body="Ignominy Cuirass +3",
    hands={ name="Emi. Gauntlets +1", augments={'HP+65','DEX+12','Accuracy+20',}},
    legs="Ig. Flanchard +3",
    feet="Flam. Gambieras +2",
    neck={ name="Abyssal Beads +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Zennaroi Earring",
    left_ring="Moonlight Ring",
    right_ring="Chirich Ring +1",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}
 

 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------- CALADBOLG SETS -----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
   
    -- Caladbolg(AM Down) TP Sets --
    sets.TP.Caladbolg = {main="Caladbolg",
	sub="Utu Grip",
    ammo="Aurgelmir Orb +1",
    head="Flam. Zucchetto +2",
    body={ name="Valorous Mail", augments={'Accuracy+17 Attack+17','"Store TP"+7','DEX+10','Accuracy+7','Attack+13',}},
    hands="Flam. Manopolas +2",
    legs="Sakpata's Cuisses",
    feet="Flam. Gambieras +2",
    neck={ name="Abyssal Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}


    sets.TP.Caladbolg.MidACC = set_combine(sets.TP.Caladbolg,{
        hands="Emicho Gauntlets +1",
        left_ear="Cessance earring",
        left_ring="Chirich Ring",})
       
    sets.TP.Caladbolg.HighACC = set_combine(sets.TP.Caladbolg.MidACC,{
        ammo="Aurgelmir Orb +1",
        head="Ignominy Burgonet +3",
        body="Ignominy Cuirass +3",
        legs="Ignominy Flanchard +3",
		right_ring="Chirich Ring +1",
		 waist="Ioskeha Belt +1",
		 right_ear="Zennaroi Earring",
        --left_ring="Regal Ring",
        feet="",})
       
    -- Caladbolg(AM Down: High Haste) TP Sets --
    sets.TP.Caladbolg.HighHaste = set_combine(sets.TP.Caladbolg,{})
    sets.TP.Caladbolg.MidACC.HighHaste = set_combine(sets.TP.Caladbolg.MidACC,{})
    sets.TP.Caladbolg.HighACC.HighHaste = set_combine(sets.TP.Caladbolg.HighACC,{})
 
    -- Caladbolg(AM Down: SAM Roll) TP Sets --
    sets.TP.Caladbolg.STP = set_combine(sets.TP.Caladbolg,{})
    sets.TP.Caladbolg.MidACC.STP = set_combine(sets.TP.Caladbolg.MidACC,{})
    sets.TP.Caladbolg.HighACC.STP = set_combine(sets.TP.Caladbolg.HighACC,{})
 
    -- Caladbolg(AM Down: High Haste + SAM Roll) TP Sets --
    sets.TP.Caladbolg.HighHaste.STP = set_combine(sets.TP.Caladbolg.STP,{})
    sets.TP.Caladbolg.MidACC.HighHaste.STP = set_combine(sets.TP.Caladbolg.MidACC.STP,{})
    sets.TP.Caladbolg.HighACC.HighHaste.STP = set_combine(sets.TP.Caladbolg.HighACC.STP,{})
   
    -- Caladbolg(AM Up) TP Sets --
    sets.TP.Caladbolg.AM = set_combine(sets.TP.Caladbolg,{
    ammo="Aurgelmir Orb +1",
    head="Flam. Zucchetto +2",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Ig. Flanchard +3",
    feet="Flam. Gambieras +2",
    neck={ name="Abyssal Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Hetairoi Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
})
       
    sets.TP.Caladbolg.MidACC.AM = set_combine(sets.TP.Caladbolg.AM,{
        hands="Emicho Gauntlets +1",
        left_ear="Cessance earring",
        left_ring="Chirich Ring",})
       
    sets.TP.Caladbolg.HighACC.AM = set_combine(sets.TP.Caladbolg.MidACC.AM,{
        head="Ignominy Burgonet +3",
        neck="Abyssal Beads +2",
        body="Ignominy Cuirass +3",
        hands="Ignominy Gauntlets +3",
        legs="Ignominy Flanchard +3",
		waist="Ioskeha Belt +1",
        left_ring="Regal Ring",})
 
    -- Caladbolg(AM Up: High Haste) TP Sets --
    sets.TP.Caladbolg.AM.HighHaste = set_combine(sets.TP.Caladbolg.AM,{})
    sets.TP.Caladbolg.MidACC.AM.HighHaste = set_combine(sets.TP.Caladbolg.AM.MidACC,{})
    sets.TP.Caladbolg.HighACC.AM.HighHaste = set_combine(sets.TP.Caladbolg.HighACC.AM,{})
 
    -- Caladbolg(AM Up: SAM Roll) TP Sets --
    sets.TP.Caladbolg.AM.STP = set_combine(sets.TP.Caladbolg.STP,{})
    sets.TP.Caladbolg.MidACC.AM.STP = set_combine(sets.TP.Caladbolg.MidACC.AM,{})
    sets.TP.Caladbolg.HighACC.AM.STP = set_combine(sets.TP.Caladbolg.HighACC.AM,{})
 
    -- Caladbolg(AM Up: High Haste + SAM Roll) TP Sets --
    sets.TP.Caladbolg.AM.HighHaste.STP = set_combine(sets.TP.Caladbolg.HighHaste.STP,{})
    sets.TP.Caladbolg.MidACC.AM.HighHaste.STP = set_combine(sets.TP.Caladbolg.MidACC.STP,{})
    sets.TP.Caladbolg.HighACC.AM.HighHaste.STP = set_combine(sets.TP.Caladbolg.HighACC.STP,{})
   
   
    -- Caladbolg /SAM TP Sets -------------------------------------------------------------------
 
    -- Caladbolg(AM Down) TP Sets --  /SAM
    --[ACC: 1150 STP: 61]--
    sets.TP.Caladbolg.SAM = {
	main="Caladbolg",
	sub="Utu Grip",
    ammo="Aurgelmir Orb +1",
    head="Sakpata's Helm",
    body={ name="Valorous Mail", augments={'Accuracy+17 Attack+17','"Store TP"+7','DEX+10','Accuracy+7','Attack+13',}},
    hands="Sakpata's Gauntlets",
    legs="Ig. Flanchard +3",
    feet="Sakpata's Leggings",
    neck={ name="Abyssal Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}
       
    --[ACC: 1184 STP: 63]--
    sets.TP.Caladbolg.SAM.MidACC = set_combine(sets.TP.Caladbolg.SAM,{
        hands="Emicho Gauntlets +1",
        left_ring="Chirich Ring",
		legs="Ig. Flanchard +3",})
       
    --[ACC: 1264 STP: 27]--    
    sets.TP.Caladbolg.SAM.HighACC = set_combine(sets.TP.Caladbolg.SAM.MidACC,{
        head="Ignominy Burgonet +3",
        body="Ignominy Cuirass +3",
        legs="Ignominy Flanchard +3",
		left_ring={name="Moonlight Ring",bag="wardrobe2"},
		left_ring="Chirich Ring +1",
		waist="Ioskeha Belt +1",
		right_ear="Zennaroi Earring",
        --left_ring="Regal Ring",
        feet="",})
 
    -- Caladbolg(AM Down: High Haste) TP Sets -- /SAM
    sets.TP.Caladbolg.SAM.HighHaste = set_combine(sets.TP.Caladbolg.SAM,{})
    sets.TP.Caladbolg.SAM.MidACC.HighHaste = set_combine(sets.TP.Caladbolg.SAM.MidACC,{})
    sets.TP.Caladbolg.SAM.HighACC.HighHaste = set_combine(sets.TP.Caladbolg.SAM.HighACC,{})
   
    -- Caladbolg(AM Down: SAM Roll) TP Sets -- /SAM
    sets.TP.Caladbolg.SAM.STP = set_combine(sets.TP.Caladbolg.SAM,{})
    sets.TP.Caladbolg.SAM.MidACC.STP = set_combine(sets.TP.Caladbolg.SAM.MidACC,{})
    sets.TP.Caladbolg.SAM.HighACC.STP = set_combine(sets.TP.Caladbolg.SAM.HighACC,{})
 
    -- Caladbolg(AM Down: High Haste + SAM Roll) TP Sets -- /SAM
    sets.TP.Caladbolg.SAM.HighHaste.STP = set_combine(sets.TP.Caladbolg.SAM.STP,{})
    sets.TP.Caladbolg.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.Caladbolg.SAM.MidACC.STP,{})
    sets.TP.Caladbolg.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.Caladbolg.SAM.HighACC.STP,{})
   
    -- Caladbolg(AM Up) TP Sets -- /SAM
    --[ACC: 1150 STP: 61]--
    sets.TP.Caladbolg.SAM.AM = set_combine(sets.TP.Caladbolg.SAM,{
    ammo="Aurgelmir Orb +1",
    head="Sakpata's Helm",
    body={ name="Valorous Mail", augments={'Accuracy+17 Attack+17','"Store TP"+7','DEX+10','Accuracy+7','Attack+13',}},
    hands="Sakpata's Gauntlets",
    legs="Ig. Flanchard +3",
    feet="Sakpata's Leggings",
    neck={ name="Abyssal Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
})
       
    --[ACC: 1184 STP: 63]--    
    sets.TP.Caladbolg.SAM.MidACC.AM = set_combine(sets.TP.Caladbolg.SAM.AM,{})
   
    --[ACC: 1264 STP: 27]--    
    sets.TP.Caladbolg.SAM.HighACC.AM = set_combine(sets.TP.Caladbolg.SAM.MidACC.AM,{
})
   
    -- Caladbolg(AM Up: High Haste) TP Sets -- /SAM
    sets.TP.Caladbolg.SAM.AM.HighHaste = set_combine(sets.TP.Caladbolg.SAM.AM,{})
    sets.TP.Caladbolg.SAM.MidACC.AM.HighHaste = set_combine(sets.TP.Caladbolg.SAM.MidACC.AM,{})
    sets.TP.Caladbolg.SAM.HighACC.AM.HighHaste = set_combine(sets.TP.Caladbolg.SAM.HighACC.AM,{})
 
    -- Caladbolg(AM Up: SAM Roll) TP Sets -- /SAM
    sets.TP.Caladbolg.SAM.AM.STP = set_combine(sets.TP.Caladbolg.SAM.STP,{})
    sets.TP.Caladbolg.SAM.MidACC.AM.STP = set_combine(sets.TP.Caladbolg.SAM.MidACC.AM,{})
    sets.TP.Caladbolg.SAM.HighACC.AM.STP = set_combine(sets.TP.Caladbolg.SAM.HighACC.AM,{})
 
    -- Caladbolg(AM Up: High Haste + SAM Roll) TP Sets --
    sets.TP.Caladbolg.SAM.AM.HighHaste.STP = set_combine(sets.TP.Caladbolg.SAM.HighHaste.STP,{})
    sets.TP.Caladbolg.SAM.MidACC.AM.HighHaste.STP = set_combine(sets.TP.Caladbolg.SAM.MidACC.STP,{})
    sets.TP.Caladbolg.SAM.HighACC.AM.HighHaste.STP = set_combine(sets.TP.Caladbolg.SAM.HighACC.STP,{})
 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------- ANGUTA SETS -----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------    
 
    -- Anguta TP Sets --
    sets.TP.Anguta = {main="Anguta",}
    sets.TP.Anguta.MidACC = set_combine(sets.TP.Anguta,{})
    sets.TP.Anguta.HighACC = set_combine(sets.TP.Anguta.MidACC,{})
 
    -- Anguta(High Haste) TP Sets --
    sets.TP.Anguta.HighHaste = set_combine(sets.TP.Anguta,{})
    sets.TP.Anguta.MidACC.HighHaste = set_combine(sets.TP.Anguta.MidACC,{})
    sets.TP.Anguta.HighACC.HighHaste = set_combine(sets.TP.Anguta.HighACC,{})
 
    -- Anguta(SAM Roll) TP Sets --
    sets.TP.Anguta.STP = set_combine(sets.TP.Anguta,{})
    sets.TP.Anguta.MidACC.STP = set_combine(sets.TP.Anguta.MidACC,{})
    sets.TP.Anguta.HighACC.STP = set_combine(sets.TP.Anguta.HighACC,{})
 
    -- Anguta(High Haste + SAM Roll) TP Sets --
    sets.TP.Anguta.HighHaste.STP = set_combine(sets.TP.Anguta.STP,{})
    sets.TP.Anguta.MidACC.HighHaste.STP = set_combine(sets.TP.Anguta.MidACC.STP,{})
    sets.TP.Anguta.HighACC.HighHaste.STP = set_combine(sets.TP.Anguta.HighACC.STP,{})
 
    ----------------- /sam sets -----------------------------
   
    -- Anguta /SAM TP Sets --
    sets.TP.Anguta.SAM = {main="Anguta",
        ammo="Aurgelmir Orb +1",
    head="Flam. Zucchetto +2",
    Body="Sakpata's Breastplate",
    hands="Sakpata's Gauntlets",
    legs="Ignominy Flanchard +3",
    feet="Flam. Gambieras +2",
    neck="Abyssal Beads +2",
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Hetairoi Ring",
   right_ring="Petrov Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}}
    sets.TP.Anguta.SAM.MidACC = set_combine(sets.TP.Anguta.SAM,{
        neck="Abyssal Beads +2",
        hands="Sakpata's Gauntlets",
        left_ear="Cessance earring",
        left_ring="Chirich Ring",})
    sets.TP.Anguta.SAM.HighACC = set_combine(sets.TP.Anguta.SAM.MidACC,{
        head="Ignominy Burgonet +3",
        body="Ignominy Cuirass +3",
        hands="Ignominy Gauntlets +3",
        legs="Ignominy Flanchard +3",
        left_ring="Regal Ring",
        feet="Flamma Gambieras +2"})
 
    -- Anguta(High Haste) /SAM TP Sets --
    sets.TP.Anguta.SAM.HighHaste = set_combine(sets.TP.Anguta.SAM,{})
    sets.TP.Anguta.SAM.MidACC.HighHaste = set_combine(sets.TP.Anguta.SAM.MidACC,{})
    sets.TP.Anguta.SAM.HighACC.HighHaste = set_combine(sets.TP.Anguta.SAM.HighACC,{})
 
    -- Anguta(SAM Roll) /SAM TP Sets --
    sets.TP.Anguta.SAM.STP = set_combine(sets.TP.Anguta.SAM,{
        ammo="Aurgelmir Orb +1",
    head="Flam. Zucchetto +2",
    Body="Valorous Mail",
    hands="Sakpata's Gauntlets",
    legs="Ignominy Flanchard +3",
    feet="Flam. Gambieras +2",
    neck="Abyssal Beads +2",
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Hetairoi Ring",
    right_ring="Petrov Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}})
    sets.TP.Anguta.SAM.MidACC.STP = set_combine(sets.TP.Anguta.SAM.MidACC,{
        head="Argosy Celata +1",
        hands="Emicho Gauntlets +1",
        legs="Ignominy Flanchard +3",
        neck="Ainia Collar",
        body="",
        left_ear="Cessance Earring",})
    sets.TP.Anguta.SAM.HighACC.STP = set_combine(sets.TP.Anguta.SAM.HighACC,{
        head="Argosy Celata +1",
        hands="Ignominy Gauntlets +3",
        legs="Ignominy Flanchard +3",
        left_ring="Regal Ring",
        neck="Abyssal Beads +2",
        feet="Flamma Gambieras +2"})
 
    -- Anguta(High Haste + SAM Roll) /SAM TP Sets --
    sets.TP.Anguta.SAM.HighHaste.STP = set_combine(sets.TP.Anguta.SAM.STP,{})
    sets.TP.Anguta.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.Anguta.SAM.MidACC.STP,{})
    sets.TP.Anguta.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.Anguta.SAM.HighACC.STP,{})
   
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
 
    -- PDT/MDT Sets --
    sets.PDT = {
        ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Loricate Torque",
    waist="Flume Belt",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring={name="Moonlight Ring",bag="wardrobe4"},
    back="Moonlight Cape"}
       

       
    sets.MDT = set_combine(sets.PDT,{back="Moonlight Cape", waist="Tempus Fugit", right_ring="Shadow Ring",})
                           
    sets.Scarlet = set_combine(sets.PDT,{})
 
    -- Hybrid Set --
    sets.TP.Hybrid = set_combine(sets.PDT,{
        ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
        neck="Loricate Torque",
        waist="Sailfi belt +1",
        left_ear="Cessance Earring",
        right_ear="Cessance Earring",
        left_ring="Defending Ring",
        right_ring={name="Moonlight Ring",bag="wardrobe4"},
        back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}})
       
    sets.TP.Hybrid.Liberator = set_combine(sets.TP.Hybrid,{main="Liberator",ammo="Staunch Tathlum +1",})
    sets.TP.Hybrid.Ragnarok = set_combine(sets.TP.Hybrid,{main="Ragnarok", ammo="Staunch Tathlum +1",})
    sets.TP.Hybrid.Caladbolg = set_combine(sets.TP.Hybrid,{main="Caladbolg", ammo="Staunch Tathlum +1",})
    sets.TP.Hybrid.Apocalypse = set_combine(sets.TP.Hybrid,{main="Apocalypse", ammo="Staunch Tathlum +1",})
    sets.TP.Hybrid.Anguta = set_combine(sets.TP.Hybrid,{main="Anguta", ammo="Staunch Tathlum +1",})
       
    sets.TP.Hybrid.MidACC = set_combine(sets.TP.Hybrid,{
        left_ear="Cessance Earring",
        body="Hjarrandi Breast.",
        hands="Ignominy Gauntlets +3",
        legs="Ignominy Flanchard +3"})
       
    sets.TP.Hybrid.HighACC = set_combine(sets.TP.Hybrid.MidACC,{
        ammo="Aurgelmir Orb +1",
        head="Ignominy Burgonet +3",
        feet="Sulevia's Leggings +2"})
 

 
    -- WS Base Set --
    sets.WS = {
        ammo="Knobkierrie",
        head="Ratri Sallet +1",
        body="Ignominy Cuirass +3",
        hands="Ratri Gadlings +1",
        legs="Fallen's Flanchard +3",
        feet="Ratri Sollerets +1",
        neck="Abyssal Beads +2",
        waist="Sailfi Belt +1",
        left_ear="Moonshade earring",
        right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
        right_ring="Epaminondas's Ring",
        back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
 
    -- Resolution Sets --
    --Description:  Delivers a fivefold attack. Damage varies with TP.
    --Stat Modifier:    73~85% STR fTP: 0.71875 1.5 2.25
 	sets.WS['Judgment'] = {     
        ammo="Knobkierrie",
		head="Ratri Sallet +1",
		body="Ignominy cuirass +3",
		hands="Odyssean gauntlets",
		legs="Fallen's Flanchard +3",
		feet="Flam. Gambieras +2",
		neck="Abyssal Beads +2",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +25',}},
		right_ear="Brutal Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}   
	
	sets.WS.Resolution = {     
        ammo="Knobkierrie",
		head="Flam. Zucchetto +2",
		body="Argosy Hauberk +1",
		hands="Argosy Mufflers +1",
		legs="Ignominy Flanchard +3",
		feet="Flam. Gambieras +2",
		neck="Abyssal Beads +2",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +25',}},
		right_ear="Brutal Earring",
		left_ring="Hetairoi Ring",
		right_ring="Petrov Ring",
		back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}}
   
    sets.WS.Resolution.MidACC = set_combine(sets.WS.Resolution,{
        hands="Ignominy Gauntlets +3",
        back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}})
       
    sets.WS.Resolution.HighACC = set_combine(sets.WS.Resolution.MidACC,{})
   
    -- Torcleaver Sets --
    -- Description: Deals triple damage. Damage varies with TP.
    -- Stat Modifier:   80% VIT fTP:    4.75    7.5 10
    sets.WS.Torcleaver = {
        ammo="Knobkierrie",
		head={ name="Odyssean Helm", augments={'Accuracy+23','Weapon skill damage +4%',}},
		body="Ignominy Cuirass +3",
		hands="Odyssean Gauntlets",
		legs="Fallen's Flanchard +3",
		feet="Sulev. Leggings +2",
		neck="Abyssal Beads +2",
		waist="Fotia Belt",
		right_ear="Thrud Earring",
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ring="Epaminondas's Ring",
		left_ring="Niqmaddu Ring",
		back={ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}}
       
    sets.WS.Torcleaver.MidACC = set_combine(sets.WS.Torcleaver,{
        ammo="Knobkierrie",
        head="Ignominy Burgonet +3",
        left_ear="",}
		)
       
    sets.WS.Torcleaver.HighACC = set_combine(sets.WS.Torcleaver.MidACC,{})
 
    -- Scourge Sets --
    --Relic Aftermath: +5% Critical Hit Rate 15 acc
    --Stat Modifier:    40% STR / 40% VIT   fTP:    3.0
    sets.WS.Scourge = {
        ammo="Knobkierrie",
        head="",
        body="Ignominy Cuirass +3",
        hands="Odyssean Gauntlets",
		legs={ name="Odyssean Cuisses", augments={'Accuracy+21','Weapon skill damage +3%','VIT+7',}},
        feet="Sulevia's Leggings +2",
        neck="Abyssal Beads +2",
        waist="Fotia Belt",
        left_ear="Brutal earring",
        right_ear="Thrud Earring",
        left_ring="Regal Ring",
        right_ring="Petrov Ring",
        back=""}
       
    sets.WS.Scourge.MidACC = set_combine(sets.WS.Scourge,{
        hands="",
        legs="",
        right_ear="Cessance earring",
        left_ear="Cessance Earring",})
       
    sets.WS.Scourge.HighACC = set_combine(sets.WS.Scourge.MidACC,{})   
 
    sets.WS.Shockwave = {
        ammo="Pemphredo Tathlum",
        head="Flam. Zucchetto +2",
		body="Flamma Korazin +2",
		hands="Flam. Manopolas +2",
		legs="Flamma Dirs +2",
		feet="Flam. Gambieras +2",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		right_ear="Digni. Earring",
		left_ear="Cessance Earring",
        left_ring="Regal Ring",
        right_ring="Stikini Ring",
        back="",} 
 
    -- Catastrophe Sets --
    --Stat Modifier:    40% STR / 40% INT   fTP:    2.75
    --Relic Aftermath: 10% Equipment Haste (+102/1024) AG 10% Ability
    sets.WS.Catastrophe = {
        ammo="Knobkierrie",
        head="Ratri Sallet +1",
        body="Ignominy Cuirass +3",
        hands="Ratri Gadlings +1",
        legs="Ratri Cuisses +1",
        feet="Ratri Sollerets +1",
        neck="Abyssal Beads +2",
        waist="Sailfi Belt +1",
        left_ear="Lugra Earring +1",
        right_ear="Thrud Earring",
        right_ring="Epaminondas's Ring",
        left_ring="Niqmaddu Ring",
        back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
       
    --sets.WS.Catastrophe.MidACC = set_combine(sets.WS.Catastrophe,{
     --   left_ear="Cessance Earring",})
       
    sets.WS.Catastrophe.HighACC = set_combine(sets.WS.Catastrophe.MidACC,{})
 
    -- Entropy Sets --
    --Delivers a fourfold attack. Converts some of the damage into MP. Damage varies with TP.
    --Stat Modifier:    73~85% INT fTP: 0.75    1.25    2.0
    sets.WS.Entropy = {
        ammo="Knobkierrie",
        head="Ratri Sallet +1",
        body="Ignominy Cuirass +3",
        hands="Ratri Gadlings +1",
        legs="Fall. Flanchard +3",
        feet="Ratri Sollerets +1",
        neck="Abyssal Beads +2",
        waist="Fotia Belt",
        left_ear="Moonshade earring",
        right_ear="Thrud Earring",
        left_ring="Regal Ring",
        right_ring="Shiva Ring +1",
        back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
       
    sets.WS.Entropy.MidACC = set_combine(sets.WS.Entropy,{
        left_ear="Cessance Earring",})
       
    sets.WS.Entropy.HighACC = set_combine(sets.WS.Entropy.MidACC,{
        ammo="Knobkierrie",
        body="Ignominy Cuirass +3",})
                           
    -- CrossReaper Sets --
    --Delivers a two-hit attack. Damage varies with TP.
    --Stat Modifier:    60% STR / 60% MND fTP:  2.0 4.0 7.0
    sets.WS['Cross Reaper'] = {
        ammo="Knobkierrie",
        head="Ratri Sallet +1",
        body="Ignominy Cuirass +3",
        hands="Ratri Gadlings +1",
        legs="Ratri Cuisses +1",
        feet="Ratri Sollerets +1",
        neck="Abyssal Beads +2",
        waist="Sailfi Belt +1",
        left_ear="Moonshade earring",
        right_ear="Thrud Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Epaminondas's Ring",
        back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
       
    sets.WS['Cross Reaper'].MidACC = set_combine(sets.WS['Cross Reaper'],{
        legs="Ignominy Flanchard +3",
        hands="Ignominy Gauntlets +3",})
       
    sets.WS['Cross Reaper'].HighACC = set_combine(sets.WS['Cross Reaper'].MidACC,{
        head="Ignominy Burgonet +3",
        left_ear="Cessance Earring",})                           
 
    -- Insurgency Sets --
    --Delivers a fourfold attack. Damage varies with TP.
    --Stat Modifier:    20% STR / 20% INT fTP:  0.5 3.25    6.0
    sets.WS.Insurgency = {
        ammo="Knobkierrie",
        head="Ratri Sallet +1",
        body="Ignominy Cuirass +3",
        hands="Argosy Mufflers +1",
        legs="Ignominy Flanchard +3",
        feet="Argosy Sollerets +1",
        neck="Abyssal Beads +2",
        waist="Fotia Belt",
        left_ear="Moonshade earring",
        right_ear="Brutal earring",
        left_ring="Regal Ring",
        right_ring="Petrov Ring",
        back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
       
    sets.WS.Insurgency.MidACC = set_combine(sets.WS.Insurgency,{
        hands="Ignominy Gauntlets +3",
        feet="Ratri Sollerets +1",})
       
    sets.WS.Insurgency.HighACC = set_combine(sets.WS.Insurgency.MidACC,{
        head="Ignominy Burgonet +3",
        left_ear="Cessance Earring",})
   
    -- Quietus Sets --
    --Delivers a triple damage attack that ignores target's defense. Amount ignored varies with TP.
    --Stat Modifier:    60% STR / 60% MND Defense ignored:  10% 30% 50% fTP:    3.0
    sets.WS.Quietus = {
        ammo="Knobkierrie",
        head="Ratri Sallet +1",
        body="Ignominy Cuirass +3",
        hands="Ratri Gadlings +1",
        legs="Ratri Cuisses +1",
        feet="Ratri Sollerets +1",
        neck="Abyssal Beads +2",
        waist="Fotia Belt",
        left_ear="Moonshade earring",
        right_ear="Thrud Earring",
        left_ring="Regal Ring",
        right_ring="Petrov Ring",
        back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
 
    sets.WS.Quietus.MidACC = set_combine(sets.WS.Quietus, {
        left_ear="Cessance Earring",})
       
    sets.WS.Quietus.HighACC = set_combine(sets.WS.Quietus.MidACC, {})
 
    -----------------------------------------------------------------------------------------------------------------
    -- works in motes based, not sure how to get it to work here
    sets.Item = {HolyWater}
    sets.Item['Holy Water'] = {ring1="Blenmot's Ring", ring2="Blenmot's Ring"}
   
    --react sets
    sets.Meva = {
    ammo="Staunch Tathlum +1",
    head="Ratri Sallet +1",
    neck="Warder's Charm",
    left_ear="Hearty Earring",
    right_ear="Eabani Earring",
    left_ring="Defending Ring",
    right_ring="Shadow Ring",
    legs="Ratri Cuisses +1",
    feet="Ratri Sollerets +1",
    hands="Ratri Gadlings +1",
    waist="Asklepian Belt",
    back="",}
    sets.CurePotencyRecieved = {waist="Gishdubar sash", neck="Phalaina Locket", ring1="Kunaji Ring", hands="Buremte Gloves",}
    sets.PhalanxRecieved = {legs=""}
    sets.RefreshRecieved = {waist="Gishdubar sash",} --feet="Inspirited boots"
    sets.CursnaRecieved = {waist="Gishdubar sash", legs="Shabti Cuisses +1", ring1="Eshmun's Ring", ring2="Eshmun's Ring"}
    sets.ResistStun = set_combine(sets.Meva, {right_ear="Arete del Luna", left_ear="Hearty Earring", body="Onca Suit", })
    sets.ProShellRecieved = {ear1="Brachyura Earring",}
    sets.ResistTerror = set_combine(sets.Meva,{feet="Founder's Greaves",})
   
end
 
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
    elseif spell.type == "WeaponSkill" and spell.target.distance > target_distance and player.status == 'Engaged' then -- Cancel WS If You Are Out Of Range --
        cancel_spell()
        add_to_chat(123, spell.name..' Canceled: [Out of Range]')
        return
    end
end
 
function precast(spell,action)
    if spell.type == "WeaponSkill" then
            equipSet = sets.WS
            if equipSet[spell.english] then
                equipSet = equipSet[spell.english]
            end
            if equipSet[AccArray[AccIndex]] then
                equipSet = equipSet[AccArray[AccIndex]]
            end
            if buffactive['Reive Mark'] then -- Equip Ygnas's Resolve +1 During Reive --
                equipSet = set_combine(equipSet,{neck="Ygnas's Resolve +1"})
            end
            if (spell.english == "Entropy" or spell.english == "Resolution" or spell.english == "Insurgency") and (player.tp > 2990 or buffactive.Sekkanoki) then
                if world.time <= (7*60) or world.time >= (17*60) then
                    equipSet = set_combine(equipSet,{ear1=""})
                else
                    equipSet = set_combine(equipSet,{ear1=""})
                end
            end
            equip(equipSet)
    elseif spell.type == "JobAbility" then
        if sets.JA[spell.english] then
            equip(sets.JA[spell.english])
        end
    elseif spell.action_type == 'Magic' then
        if buffactive.silence or spell.target.distance > 16+target_distance then -- Cancel Magic or Ninjutsu If You Are Silenced or Out of Range --
            cancel_spell()
            add_to_chat(123, spell.name..' Canceled: [Silenced or Out of Casting Range]')
            return
        else
            if spell.english == 'Utsusemi: Ni' then
                if buffactive['Copy Image (3)'] then
                    cancel_spell()
                    add_to_chat(123, spell.name .. ' Canceled: [3 Images]')
                    return
                else
                    equip(sets.Precast.FastCast)
                end
            elseif sets.Precast[spell.skill] then
                equip(sets.Precast[spell.skill])
            else
                equip(sets.Precast.FastCast)
            end
        end
    elseif spell.english == 'Spectral Jig' and buffactive.Sneak then
        cast_delay(0.2)
        send_command('cancel Sneak')
    end
    if Twilight == 'Twilight' then
        equip(sets.Twilight)
    end
end
 
function midcast(spell,action)
    equipSet = {}
    if spell.action_type == 'Magic' then
        equipSet = sets.Midcast
        if spell.english:startswith('Absorb') and spell.english ~= "Absorb-TP" then
            equipSet = sets.Midcast.Absorb
            if equipSet[MaccArray[MaccIndex]] then
                equipSet = equipSet[MaccArray[MaccIndex]]
            end
        elseif spell.english:startswith('Drain') or spell.english:startswith('Aspir') or spell.english:startswith('Bio') then
            if world.day == "Darksday" or world.weather_element == "Dark" then -- Equip Hachirin-no-Obi On Darksday or Dark Weather --
                equipSet = set_combine(equipSet,{waist="Hachirin-no-Obi"})
            end
            equipSet =  sets.Midcast.Drain
        elseif spell.english == "Stoneskin" then
            if buffactive.Stoneskin then
                send_command('@wait 1.7;cancel stoneskin')
            end
            equipSet = equipSet.Stoneskin
        elseif spell.english == "Sneak" then
            if spell.target.name == player.name and buffactive['Sneak'] then
                send_command('cancel sneak')
            end
            equipSet = equipSet.Haste
        elseif spell.english:startswith('Utsusemi') then
            if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)']) then
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
            if equipSet[MaccArray[MaccIndex]] then
                equipSet = equipSet[MaccArray[MaccIndex]]
            end
            if equipSet[spell.skill] then
                equipSet = equipSet[spell.skill]
            end
            if equipSet[spell.type] then
                equipSet = equipSet[spell.type]
            end
        end
    elseif equipSet[spell.english] then
        equipSet = equipSet[spell.english]
    end
    if buffactive["Dark Seal"] and DarkSealIndex==0 then -- Equip Aug'd Fall. Burgeonet +3 When You Have Dark Seal Up --
        equipSet = set_combine(equipSet,{head="Fall. Burgeonet +3",})
    end
    if buffactive['Dark Seal'] and buffactive['Nether Void'] and S{"Drain II","Drain III"}:contains(spell.english) and player.tp<600 then
        equipSet = set_combine(equipSet,(sets.MAXDrain))
        add_to_chat(100,'WARNING: Misanthropy is on now *****')
    end
    equip(equipSet)
end

function file_unload(filename)
	send_command('unbind ^f11') -- alt fp for macc
	send_command('unbind f9') -- f9 for accuracy
	send_command('unbind ^f9') -- ctrl f9 for weapon toggle
	send_command('unbind f10') -- f10 toggle pdt
	send_command('unbind f11') -- f11 toggle hybrid
	send_command('unbind f12') -- Auto Update Gear Toggle -- I have no idea what this does, but I put it on f12
	send_command('unbind ^f12')
end
 
function aftercast(spell,action)
 
        if spell.type == "WeaponSkill" then
            send_command('wait 0.2;gs c TP')
        elseif spell.english == "Arcane Circle" then -- Arcane Circle Countdown --
            send_command('wait 260;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;input /echo '..spell.name..': [OFF]')
        elseif spell.english == "Sleep II" then -- Sleep II Countdown --
            send_command('wait 60;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
        elseif spell.english == "Sleep" then -- Sleep Countdown --
            send_command('wait 30;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
        end
        status_change(player.status)
		
		if spell.name == "Last Resort" then
			equip({body="Hjarrandi breastplate",ammo="Yetshila +1",})
		elseif buffactive["Last Resort"] then
			equip({body="Hjarrandi breastplate",ammo="Yetshila +1",})
		end
    end
   
 
function status_change(new,old)
    if Armor == 'PDT' then
        equip(sets.PDT)
    elseif Armor == 'MDT' then
        equip(sets.MDT)
    elseif Armor == 'Scarlet' then
        equip(sets.Scarlet)
    elseif new == 'Engaged' then
        equipSet = sets.TP
        if Armor == 'Hybrid' and equipSet["Hybrid"] then
            equipSet = equipSet["Hybrid"]
        end
        if equipSet[WeaponArray[WeaponIndex]] then
            equipSet = equipSet[WeaponArray[WeaponIndex]]
        end
        if equipSet[player.sub_job] then
            equipSet = equipSet[player.sub_job]
        end
        if equipSet[AccArray[AccIndex]] then
            equipSet = equipSet[AccArray[AccIndex]]
        end

        if buffactive.Aftermath and equipSet["AM"] then
            equipSet = equipSet["AM"]
        end
        if buffactive["Last Resort"] and ((buffactive.Haste and buffactive.March == 2) or (buffactive.Embrava and (buffactive.March == 2 or (buffactive.March and buffactive.Haste) or (buffactive.March and buffactive['Mighty Guard']) or (buffactive['Mighty Guard'] and buffactive.Haste))) or (buffactive[580] and (buffactive.March or buffactive.Haste or buffactive.Embrava or buffactive['Mighty Guard']))) and equipSet["HighHaste"] then
            equipSet = equipSet["HighHaste"]
        end
        if buffactive["Samurai Roll"] and equipSet["STP"] and Samurai_Roll == 'ON' then
            equipSet = equipSet["STP"]
        end
        equip(equipSet)
		if buffactive["Last Resort"] then
			equip({body="Hjarrandi breastplate",ammo="Yetshila +1",})
		end
    else
        equipSet = sets.Idle
        if equipSet[IdleArray[IdleIndex]] then
            equipSet = equipSet[IdleArray[IdleIndex]]
        end
        if equipSet[WeaponArray[WeaponIndex]] then
            equipSet = equipSet[WeaponArray[WeaponIndex]]
        end
        if equipSet[player.sub_job] then
            equipSet = equipSet[player.sub_job]
        end
        if buffactive['Reive Mark'] then -- Equip Ygnas's Resolve +1 During Reive --
            equipSet = set_combine(equipSet,{neck="Ygnas's Resolve +1"})
        end
        if world.area:endswith('Adoulin') then
            equipSet = set_combine(equipSet,{body="Councilor's Garb"})
        end
        equip(equipSet)
    end
    if Twilight == 'Twilight' then
        equip(sets.Twilight)
    end
end
 
function buff_change(buff,gain)
    buff = string.lower(buff)
    if buff == "aftermath: lv.3" then -- AM3 Timer/Countdown --
        if gain then
            send_command('timers create "Aftermath: Lv.3" 180 down;wait 150;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 15;input /echo Aftermath: Lv.3 [WEARING OFF IN 15 SEC.];wait 5;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
        else
            send_command('timers delete "Aftermath: Lv.3"')
            add_to_chat(123,'AM3: [OFF]')
        end
    elseif buff == 'weakness' then -- Weakness Timer --
        if gain then
            send_command('timers create "Weakness" 300 up')
        else
            send_command('timers delete "Weakness"')
        end
    end
    if buff == "sleep" and gain and player.hp > 200 and player.status == "Engaged" then -- Equip Berserker's Torque When You Are Asleep & Have 200+ HP --
        equip({neck="Vim Torque +1"})
    else
        if not midaction() then
            status_change(player.status)
        end
    end
end
 
-- In Game: //gs c (command), Macro: /console gs c (command), Bind: gs c (command) --

function self_command(command)
    if command == 'C1' then -- Accuracy Level Toggle --
        AccIndex = (AccIndex % #AccArray) + 1
        status_change(player.status)
        add_to_chat(158,'Accuracy Level: '..AccArray[AccIndex])
    elseif command == 'C17' then -- Main Weapon Toggle --
        WeaponIndex = (WeaponIndex % #WeaponArray) + 1
        add_to_chat(158,'Main Weapon: '..WeaponArray[WeaponIndex])
        status_change(player.status)
    elseif command == 'C14' then -- Macc Toggle --
        MaccIndex = (MaccIndex % #MaccArray) + 1
        add_to_chat(158,'Macc Level: '..MaccArray[MaccIndex])
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
        elseif command == 'C10' then -- DarkSeal Toggle --
        if DarkSealIndex == 1 then
                        DarkSealIndex = 0
                        add_to_chat(158,'DarkSeal Duration: [On]')
        else
                        DarkSealIndex = 1
                        add_to_chat(158,'DarkSeal Potency: [On]')
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
    elseif command == 'C9' then -- Scarlet Toggle --
        if Armor == 'Scarlet' then
            Armor = 'None'
            add_to_chat(123,'Scarlet Set: [Unlocked]')
        else
            Armor = 'Scarlet'
            add_to_chat(158,'Scarlet Set: [Locked]')
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
        status_change(player.status)
        add_to_chat(158,'Idle Set: '..IdleArray[IdleIndex])
    elseif command == 'TP' then
        add_to_chat(158,'TP Return: ['..tostring(player.tp)..']')
    elseif command:match('^SC%d$') then
        send_command('//' .. sc_map[command])
    end
end
 
function sub_job_change(newSubjob, oldSubjob)
    select_default_macro_book()
end
 
function set_macro_page(set,book)
    if not tonumber(set) then
        add_to_chat(123,'Error setting macro page: Set is not a valid number ('..tostring(set)..').')
        return
    end
    if set < 1 or set > 10 then
        add_to_chat(123,'Error setting macro page: Macro set ('..tostring(set)..') must be between 1 and 10.')
        return
    end
   
    if book then
        if not tonumber(book) then
            add_to_chat(123,'Error setting macro page: book is not a valid number ('..tostring(book)..').')
            return
        end
        if book < 1 or book > 20 then
            add_to_chat(123,'Error setting macro page: Macro book ('..tostring(book)..') must be between 1 and 20.')
            return
        end
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(set))
    else
        send_command('@input /macro set '..tostring(set))
    end
end
 
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(9, 8)
    else
        set_macro_page(10, 8)
    end
end