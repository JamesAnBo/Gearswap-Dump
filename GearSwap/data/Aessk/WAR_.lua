--Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua','Mote-Ulility.lua','Organizer-lib')
end

function user_setup()
    --Options: Override default values
    state.OffenseMode:options('DD','Dual','HtH')
    state.WeaponskillMode:options('Normal', 'ATKCAP', 'DT')
    state.HybridMode:options('Normal','Hybrid','HPTank')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal','MainTank','Weakened')
    state.PhysicalDefenseMode:options('')
	
	state.Warp = M(false, "Warp Ring")
	state.WeaponLock = M(false, 'Weapon Lock')
	state.WeaponSet = M{['description']='Weapon Set', 'Chango', 'Naegling', 'ShiningOne', 'Loxotic', 'Conqueror', 'Farsha', 'Ukonvasara', 'Dolichenus', 'Bravura', 'Ragnarok', 'Montante', 'Nandaka', 'Drepanum', 'Karambit', 'Xoanon', 'Ullr'} 
	state.MeleeSet = M{['description']='Melee Set', 'Hybrid', 'Leaden', 'Savage', 'Ranged', 'DT', }
    select_default_macro_book()
	set_lockstyle()
end

function binds_on_load()
--F9-F12
    send_command('bind f9 gs c cycle OffenseMode')
    send_command('bind f10 gs c cycle HybridMode')
    send_command('bind f11 gs c cycle IdleMode')
    send_command('bind f12 gs c update user')
-- CTRL F9-F12
    send_command('bind ^f9 gs c cycle WeaponskillMode')
-- ALT F9-12
    send_command('bind !f9 gs c cycle CastingMode')
    send_command('bind !f10 gs c cycle RangedMode')
    send_command('bind !f12 gs c cycle Kiting') 
-- Windows 	
	send_command('bind @e gs c cycle WeaponSet')
    send_command('bind @r gs c cycle MeleeSet')
-- Numpad
	send_command('bind ^numpad1 gs c set WeaponSet Chango; wait .5; gs c set OffenseMode DD; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal; wait .5; input /lockstyleset 81')
    send_command('bind ^numpad2 gs c set WeaponSet Naegling; wait .5; gs c set OffenseMode DD; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal; wait .5; input /lockstyleset 82')
	send_command('bind ^numpad3 gs c set WeaponSet ShiningOne; wait .5; gs c set OffenseMode DD; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal; wait .5; input /lockstyleset 90')
	send_command('bind ^numpad4 gs c set WeaponSet Loxotic; wait .5; gs c set OffenseMode DD; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal; wait .5; input /lockstyleset 99')
	send_command('bind ^numpad5 gs c set WeaponSet Conqueror; wait .5; gs c set OffenseMode DD; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal; wait .5; input /lockstyleset 85')
	send_command('bind ^numpad6 gs c set WeaponSet Farsha; wait .5; gs c set OffenseMode Dual; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal; wait .5; input /lockstyleset 84')
	send_command('bind ^numpad7 gs c set WeaponSet Ukonvasara; wait .5; gs c set OffenseMode DD; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal; wait .5; input /lockstyleset 86')
	send_command('bind ^numpad8 gs c set WeaponSet Dolichenus; wait .5; gs c set OffenseMode Dual; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal; wait .5; input /lockstyleset 84')
	send_command('bind ^numpad9 gs c set WeaponSet Bravura; wait .5; gs c set OffenseMode DD; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal; wait .5; input /lockstyleset 90')
	send_command('bind ^numpad0 gs c set WeaponSet Ragnarok; wait .5; gs c set OffenseMode DD; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal; wait .5; input /lockstyleset 87')
	send_command('bind !numpad0 gs c set WeaponSet Montante; wait .5; gs c set OffenseMode DD; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal; wait .5; input /lockstyleset 87')
	send_command('bind ^numpad* gs c set WeaponSet Nandaka; wait .5; gs c set OffenseMode DD; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal; wait .5; input /lockstyleset 87')
	send_command('bind ^numpad- gs c set WeaponSet Drepanum; wait .5; gs c set OffenseMode DD; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal; wait .5; input /lockstyleset 90')
	send_command('bind ^numpad+ gs c set WeaponSet Karambit; wait .5; gs c set OffenseMode HtH; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal; wait .5; input /lockstyleset 90')
	send_command('bind !numpad1 gs c set OffenseMode DD; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal')
	send_command('bind !numpad2 gs c set OffenseMode Dual; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal')
	send_command('bind !numpad3 gs c set HybridMode Normal; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal')
	send_command('bind !numpad4 gs c set HybridMode Hybrid; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal')
	send_command('bind !numpad5 gs c set HybridMode HPTank; wait .5; gs c set IdleMode MainTank; wait .5; gs c set WeaponskillMode DT')
	send_command('bind !numpad6 gs c set WeaponskillMode Normal')
	send_command('bind !numpad7 gs c set WeaponskillMode ATKCAP')
	send_command('bind !numpad8 gs c set WeaponSet Xoanon; wait .5; gs c set OffenseMode Dual; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal; wait .5; input /lockstyleset 84')
	send_command('bind !numpad9 gs c set WeaponSet Ullr; wait .5; gs c set OffenseMode DD; wait .5; gs c set IdleMode Normal; wait .5; gs c set WeaponskillMode Normal; wait .5; input /lockstyleset 86')	
	
	send_command('bind !numpad- input /ja "Mighty Strikes" <me>')
	send_command('bind !numpad+ input /ja "Brazen Rush" <me>') 
	
end


function user_unload()
    send_command('unbind ^`')
    send_command('unbind ^c')
    send_command('unbind ^s')
    send_command('unbind ^f')
    send_command('unbind !`')
    send_command('unbind @`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^[')
    send_command('unbind ^]')
    send_command('unbind ^,')
    send_command('unbind @c')
    send_command('unbind @q')
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @r')
	send_command('unbind ^numpad1')
	send_command('unbind ^numpad2')
	send_command('unbind ^numpad3')
	send_command('unbind ^numpad4')
	send_command('unbind ^numpad5')
	send_command('unbind ^numpad6')
	send_command('unbind ^numpad7')
	send_command('unbind ^numpad8')
	send_command('unbind ^numpad9')
	send_command('unbind ^numpad0')
    send_command('unbind ^numlock')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
	send_command('unbind ^numpad+')
    send_command('unbind ^numpad0')
	send_command('unbind !numpad1')
	send_command('unbind !numpad2')
	send_command('unbind !numpad3')
	send_command('unbind !numpad4')
	send_command('unbind !numpad5')
	send_command('unbind !numpad6')
	send_command('unbind !numpad7')
	send_command('unbind !numpad8')
	send_command('unbind !numpad9')
	send_command('unbind !numpad0')
    send_command('unbind !numpad-')
	send_command('unbind !numpad+')

    send_command('unbind #`')
    send_command('unbind #1')
    send_command('unbind #2')
    send_command('unbind #3')
    send_command('unbind #4')
    send_command('unbind #5')
    send_command('unbind #6')
    send_command('unbind #7')
    send_command('unbind #8')
    send_command('unbind #9')
    send_command('unbind #0')

end
 
 
 --Define sets and vars used by this job file.
function init_gear_sets()	

	organizer_items = {
	RelicToy="Bravura",
	RelicToy2="Ragnarok",
	EmpyreanToy1="Ukonvasara",
	EmpyreanToy2="Farsha",
	Resolution="Montante +1",
	PunchyMcPunchers="Karambit",
	WTFisMyProblem="Nandaka",
	Emo="Drepanum",
	MATKAXE="Malevolence",
	Board="Blurred Shield +1",
	HPHead="Souv. Schaller +1",
	EnmityBody="Souv. Cuirass +1",
	HPHands="Souv. Handsch. +1",
	EnmityLegs="Souv. Diechlings +1",
	EnmityFeet="Souveran Schuhs +1",
	shihei="Shihei",
	tabi="Shinobi-Tabi",
	tengui="Sanjaku-Tenugui",}
		
	--Precast sets--	Changes your armor before a JA is used for the JA bonus.
    sets.precast.JA['Berserk'] = {main="Conqueror", feet={ name="Agoge Calligae +3", augments={'Enhances "Tomahawk" effect'}}, body="Pumm. Lorica +3", back="Cichol's Mantle"}
	
	sets.precast.JA['Warcry'] = {head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}}}
    
	sets.precast.JA['Aggressor'] = {body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect'}}, head="Pummeler's Mask +3"}
    
	sets.precast.JA['Blood Rage'] = {body="Boii Lorica +1"}
    
	sets.precast.JA['Retaliation'] = {feet="Boii Calligae +1", hands="Pumm. Mufflers +3"}
    
	sets.precast.JA['Restraint'] = {hands="Boii Mufflers +1"}
    
	sets.precast.JA['Mighty Strikes'] = {hands={ name="Agoge Mufflers +3", augments={'Enhances "Mighty Strikes" effect',}}}
    
	sets.precast.JA["Warrior's Charge"] = {legs="Agoge Cuisses +3"}
    
	sets.precast.JA['Provoke'] = {
		ammo="Sapience Orb",
		head="Pummeler's Mask +3",
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands="Pumm. Mufflers +3",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Goading Belt",
		left_ear="Friomisi Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Apeile Ring",
		right_ring="Apeile Ring +1",
		back="Moonlight Cape",}
		
	--Meta	
	sets.Chango = {
		main={name="Chango", priority=1},
		sub="Utu Grip"}
	sets.Naegling = {
		main="Naegling", 
		sub="Blurred Shield +1"}
	sets.ShiningOne = {
		main={name="Shining One", priority=1},
		sub="Utu Grip"}
	sets.Loxotic = {
		main="loxotic Mace +1",
		sub="Blurred Shield +1"}

	
	--Funsies
	sets.Conqueror = {
		main={name="Conqueror", priority=1}, 
		sub="Utu Grip"}
	sets.Ukonvasara = {
		main={name="Ukonvasara", priority=1},
		sub="Utu Grip"}
	sets.Bravura = {
		main={name="Bravura", priority=1},
		sub="Utu Grip"}
	sets.Ragnarok = {
		main={name="Ragnarok", priority=1},
		sub="Utu Grip"}
	sets.Montante = {
		main={name="Montate +1", priority=1},
		sub="Utu Grip"}
	sets.Dolichenus = {
		main="Dolichenus", 
		sub="Sangarius +1"}
	sets.Farsha = {
		main="Farsha", 
		sub="Malevolence"}
	sets.Nandaka = {
		main={name="Nandaka", priority=1},
		sub={name="Utu Grip", priority=2}}
	sets.Drepanum = {
		main={name="Drepanum", priority=1},
		sub={name="Utu Grip", priority=2}}
	sets.Karambit ={
		main="Karambit"}
	sets.Xoanon = {
		main={name="Xoanon", priority=1},
		sub={name="Utu Grip", priority=2}}
	sets.Ullr ={
		main="Dolichenus",
		sub="Blurred Shield +1",
		range="Ullr"}
    
	sets.precast.FC = {
        head="Pummeler's Mask +3",
		head="Sakpata's Helm",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Baetyl Pendant",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Defending Ring",
		right_ring="Weather. Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}}
		
    --Midcast Sets--	
	sets.midcast.Flash = {
		neck="Unmoving Collar +1",
        head="Pummeler's Mask +3",
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands="Pumm. Mufflers +3",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Warder's Charm +1",
        Ring1="Apeile Ring",
		Ring2="Apeile Ring +1",
        ear1="Enchntr. Earring +1",}
    
	--Resting sets--	If you /heal you will change into this armor.
    sets.resting = {}
	
	--HPP < 20%--	Under 20% HP it will change to Reraise armor.
    sets.Twilight = {head="Twilight Helm", body="Twilight Mail"}
    Twilight = 'false'
	
	--Idle Set--	
    sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Schere Earring",
		right_ear="Dedition Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}}
		
	--Idle Main Tank-- Same as bove.
    sets.idle.MainTank = {
		ammo="Staunch Tathlum +1",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body="Hjarrandi Breast.",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs="Sakpata's Cuisses",
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={name="Moonlight Ring",bag="wardrobe1"},
		right_ring={name="Moonlight Ring",bag="wardrobe4"},
		back="Moonlight Cape",}
	
	--Idle Set Weakened-- 
	sets.idle.Weakened = {
		ammo="Staunch Tathlum +1",
		head="Twilight Helm",
		body="Twilight Mail",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={name="Moonlight Ring",bag="wardrobe1"},
		right_ring={name="Moonlight Ring",bag="wardrobe4"},
		back="Moonlight Cape",}
	
	--Idle Set Town--	
    sets.idle.Town = {
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={name="Moonlight Ring",bag="wardrobe1"},
		right_ring={name="Moonlight Ring",bag="wardrobe4"},
		back="Moonlight Cape",}
    
	--Engaged DD--	
	sets.engaged.Normal = {
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body={ name="Tatena. Harama. +1", augments={'Path: A',}},
		hands={ name="Tatena. Gote +1", augments={'Path: A',}},
		legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
		feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
		neck={ name="Vim Torque +1", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Schere Earring",
		right_ear="Dedition Earring",
		left_ring={name="Moonlight Ring",bag="wardrobe1"},
		right_ring={name="Moonlight Ring",bag="wardrobe4"},
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}}
		
	--Dual Wield--
	sets.engaged.Dual = {
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body={ name="Tatena. Harama. +1", augments={'Path: A',}},
		hands={ name="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}},
		legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
		feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
		neck={ name="Vim Torque +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Suppanomimi",
		right_ear="Dedition Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring +1",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}}
	
	--Dual Wield Hybrid--
	sets.engaged.Dual.Hybrid = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head="Sakpata's Helm",
		body="Volte Jupon",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Schere Earring",
		right_ear="Brutal Earring",
		left_ring="Niqmaddu Ring", 
		right_ring={name="Moonlight Ring",bag="wardrobe4"},
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}}
	
	sets.engaged.HtH = {
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body={ name="Tatena. Harama. +1", augments={'Path: A',}},
		hands={ name="Tatena. Gote +1", augments={'Path: A',}},
		legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
		feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Mache Earring +1",
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring +1",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}}
				
	--Engaged Hybrid-- 100% Double Attack, 3% Quad Attack, 50% DT
	sets.engaged.Hybrid = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head="Sakpata's Helm",
		body="Sacro Breastplate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Schere Earring",
		right_ear="Brutal Earring",
		left_ring="Niqmaddu Ring", 
		right_ring={name="Moonlight Ring",bag="wardrobe4"},
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}}
		
	--Engaged FullDT-- HP: 4026, Haste 26%
	sets.engaged.HPTank = {
		ammo="Staunch Tathlum +1",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body="Hjarrandi Breast.",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs="Sakpata's Cuisses",
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={name="Moonlight Ring",bag="wardrobe1"},
		right_ring={name="Moonlight Ring",bag="wardrobe4"},
		back="Moonlight Cape",}
		

		     
    --Weaponskill sets--
    sets.precast.WS = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
	
	--WS DT--
	sets.precast.WS.DT = set_combine(sets.precast.WS, { 
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		right_ear="Odnowa Earring +1", augments={'Path: A',},
		left_ring={name="Moonlight Ring",bag="wardrobe1"},
		right_ring={name="Moonlight Ring",bag="wardrobe4"},
		back="Moonlight Cape",})
		
		----------GREAT AXE----------
	
	--Upheaval--
	sets.precast.WS['Upheaval'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}}
		
	--Upheaval ATKCAP--
	sets.precast.WS['Upheaval'].ATKCAP = set_combine(sets.precast.WS['Upheaval'], { 
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",})
		
	--Ukko's Fury-- 
	sets.precast.WS["Ukko's Fury"] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
	    neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
		
	--King's Justice--
	sets.precast.WS["King's Justice"] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
		
	--Metatron Torment--
	sets.precast.WS['Metatron Torment'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
		
	--Steel Cyclone--
	sets.precast.WS['Steel Cyclone'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
	
	--Fell Cleave--
	sets.precast.WS['Fell Cleave'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
        
	--Full Break--
	sets.precast.WS['Full Break'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
		
	--Raging Rush--
	sets.precast.WS['Raging Rush'] = {
		ammo="Yetshila +1",
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		legs={ name="Zoar Subligar +1", augments={'Path: A',}},
		feet="Boii Calligae +1",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		right_ear="Thrud Earring",
		left_ring="Begrudging Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}}}
		
		----------GREAT SWORD----------    
	
	--Resolution--
    sets.precast.WS['Resolution'] = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head="Flam. Zucchetto +2",
		body={ name="Tatena. Harama. +1", augments={'Path: A',}},
		hands={ name="Tatena. Gote +1", augments={'Path: A',}},
		legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
		feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}}
		
	--Scourge--
	sets.precast.WS['Scourge'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}}
    
	--Ground Strike--
	sets.precast.WS['Ground Strike'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage 10%',}}}
		
	--Herculean Slash--
	sets.precast.WS["Herculean Slash"] ={
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%','"Regen"+5',}}}
	
		----------AXE----------  	

	--Ruinator--
	sets.precast.WS["Ruinator"] = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}}
		
	--Cloudsplitter--
	sets.precast.WS["Cloudsplitter"] = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Rufescent Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%','"Regen"+5',}}}
		
	--Bora Axe--
	sets.precast.WS["Bora Axe"] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}}

	--Decimation--
	sets.precast.WS["Decimation"] = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}}
		
	--Mistral Axe--
	sets.precast.WS["Mistral Axe"] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
	
	--Rampage--
	sets.precast.WS["Rampage"] = {
		ammo="Yetshila +1",
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
		body="Hjarrandi Breast.",
		hands={ name="Valorous Mitts", augments={'Accuracy+11','Crit. hit damage +5%','VIT+10','Attack+5',}},
		legs={ name="Zoar Subligar +1", augments={'Path: A',}},
		feet="Boii Calligae +1",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring +1",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}}}
	
		----------SWORD----------  
	
	--Requiscat--
	sets.precast.WS['Requiscat'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Rufescent Ring",
		right_ring="Stikini Ring +1",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
		
	--Sanguine Blade--
	sets.precast.WS['Sanguine Blade'] = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head="Pixie Hairpin +1",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Rufescent Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%','"Regen"+5',}}}
	
	--Savage Blade--
	sets.precast.WS['Savage Blade'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
	    neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Rufescent Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
		
	--Savage Blade ATKCAP--
	sets.precast.WS['Savage Blade'].ATKCAP = set_combine(sets.precast.WS['Savage Blade'], { 
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",})
		
	--Vorpal Blade--
	sets.precast.WS['Vorpal Blade'] = {
		ammo="Yetshila +1",
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		legs={ name="Zoar Subligar +1", augments={'Path: A',}},
		feet="Boii Calligae +1",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Begrudging Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}}}
		
		
	--Seraph Blade--
	sets.precast.WS['Seraph Blade'] = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Rufescent Ring",
		right_ring="Weather. Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%','"Regen"+5',}}}
	
		----------DAGGER----------  
	
	--Exenterator--
	sets.precast.WS["Exenterator"] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage 10%',}}}

	--Aeolian Edge--
	sets.precast.WS["Aeolian Edge"] = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Rufescent Ring",
		right_ring="Weather. Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}}

	--Evisceration--
	sets.precast.WS["Evisceration"] = {
		ammo="Yetshila +1",
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		legs={ name="Zoar Subligar +1", augments={'Path: A',}},
		feet="Boii Calligae +1",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Begrudging Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}}}

		----------POLEARM----------  

	--Stardiver--
	sets.precast.WS['Stardiver'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
	    neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}}
	
	--Impulse Drive: -- 
	sets.precast.WS['Impulse Drive'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
	    neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
		
	--Raiden Thrust--
	sets.precast.WS["Raiden Thrust"] = {	
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Rufescent Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%','"Regen"+5',}}}
	
		----------HAND-TO-HAND----------
		
	--Tornado Kick--
	sets.precast.WS['Tornado Kick'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
	    neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
		
	--Asuran Fists--
	sets.precast.WS['Asuran Fists'] = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head="Flam. Zucchetto +2",
		body={ name="Tatena. Harama. +1", augments={'Path: A',}},
		hands={ name="Tatena. Gote +1", augments={'Path: A',}},
		legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
		feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
		
	--Raging Fists--
	sets.precast.WS['Raging Fists'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
	    neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
	
	--Backhand Blow--
	sets.precast.WS['Backhand Blow'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
	    neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
	
		----------SCYTHE----------

	--Entropy--
	sets.precast.WS['Entropy'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
		
	--Infernal Scythe--
	sets.precast.WS["Infernal Scythe"] = {	
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head="Pixie Hairpin +1",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Rufescent Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%','"Regen"+5',}}}
	
	--Spiral Hell--
	sets.precast.WS['Spiral Hell'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
	    neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
		
	--Shadow Of Death--
	sets.precast.WS["Shadow Of Death"] = {	
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head="Pixie Hairpin +1",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Rufescent Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%','"Regen"+5',}}}
		
		----------STAFF----------
	--Shattersoul--	
	sets.precast.WS['Shattersoul'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
	    neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
		
	--Cataclysm--	
	sets.precast.WS['Cataclysm'] = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head="Pixie Hairpin +1",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Archon Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%','"Regen"+5',}}}
		
	--Retribution--	
	sets.precast.WS['Retribution'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
	    neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
	
	--Spirit Taker--	
	sets.precast.WS['Spirit Taker'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
	
	--Earth Crusher--	
	sets.precast.WS['Earth Crusher'] = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Rufescent Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%','"Regen"+5',}}}
		
		----------CLUB----------
		
	--Realmrazer--	
	sets.precast.WS['Realmrazer'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
		
	--Flash Nova--	
	sets.precast.WS['Flash Nova'] = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Rufescent Ring",
		right_ring="Weather. Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%','"Regen"+5',}}}
		
	--Black Halo--	
	sets.precast.WS['Black Halo'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
		
	--Hexa Strike--	
	sets.precast.WS['Hexa Strike'] = {
		ammo="Yetshila +1",
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		legs={ name="Zoar Subligar +1", augments={'Path: A',}},
		feet="Boii Calligae +1",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Begrudging Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}}}
		
	--Judgment--	
	sets.precast.WS['Judgment'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
		
		----------ARCHERY----------
		
	--Empyreal Arrow--	
	sets.precast.WS['Empyreal Arrow'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
		
	--Mighty Strikes WS Set--
     	sets.MS_WS = {
		ammo="Yetshila +1", 
		feet="Boii Calligae +1",}
	
	--Set rings for warp.
	sets.Warp = {
		left_ring="Warp Ring",
		right_ring="Dim. Ring (Dem)",}
end
  
		----------FUNCTIONS----------
  
function job_update(cmdParams, eventArgs)
    equip(sets[state.WeaponSet.current])
	equip(sets[state.MeleeSet.current])
	handle_equipping_gear(player.status)
end

function display_current_job_state(eventArgs)
local msg = 'Melee'
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''

    msg = msg .. '[ Offense/Ranged: '..state.OffenseMode.current

    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end

    msg = msg .. '/' ..state.RangedMode.current

    msg = msg .. ' (' ..state.WeaponSet.current .. ') ]'
	
	msg = msg .. ' (' ..state.MeleeSet.current .. ') ]'

    if state.WeaponskillMode.value ~= 'Normal' then
        msg = msg .. '[ WS: '..state.WeaponskillMode.current .. ' ]'
    end

    if state.DefenseMode.value ~= 'None' then
        msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
    end

    eventArgs.handled = true
end

moonshade_WS = S{"Upheaval", "Ukko's Fury", "King's Justice", "Metatron Torment", "Steel Cyclone", "Full Break", "Raging Rush", "Resolution", "Scourge", "Ground Strike", "Ruinator", "Bora Axe", "Mistral Axe", "Requiscat", "Savage Blade", "Vorpal Blade", "Exenterator", "Evisceration", "Stardiver", "Sonic Thrust", "ImpulseDrive", "Tornado Kick", "Asuran Fists", "Raging Fists", "Backhand Blow", "Entropy", "Spiral Hell", "Shattersoul", "Retribution", "Shell Crusher", "Realmrazer", "Black Halo", "Hexa Strike", "Judgment", "Empyreal Arrow",}
moonshade_MATK = S{"Herculean Slash", "Cloudsplitter", "Sanguine Sword", "Seraph Blade", "Aeolian Edge", "Raiden Thrust", "Infernal Scythe", "Shadow Of Death", "Cataclysm", "Earth Crusher", "Flash Nova", "Seraph Strike",}

function job_post_precast(spell, action, spellMap, eventArgs)
		if spell.type == 'WeaponSkill' then
        if world.time >= (17*60) or world.time <= (7*60) then
           equip({left_ear={ name="Lugra Earring +1", augments={'Path: A',}}})
        end
		if  moonshade_WS:contains(spell.english) and player.tp<2750 then  
            equip({left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}}})
		elseif moonshade_WS:contains(spell.english) and player.tp>2750 then  
            equip({left_ear={ name="Lugra Earring +1", augments={'Path: A',}}})
		elseif 	 moonshade_MATK:contains(spell.english) and player.tp<2750 then  
            equip({left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}}})
		elseif moonshade_MATK:contains(spell.english) and player.tp>2750 then  
            equip({left_ear="Crematio Earring"})
        end
	    if buffactive['Mighty Strikes'] then 
        if sets.precast.WS[spell] then
            equipSet = sets.precast.WS[spell]
            equipSet = set_combine(equipSet,sets.MS_WS)
            equip(equipSet)
        else
            equipSet = sets.precast.WS
            equipSet = set_combine(equipSet,sets.MS_WS)
            equip(equipSet)
            end
        end
    end
end

function job_precast(spell, action, spellMap, eventArgs)
        equip(sets[state.WeaponSet.current])
	end

function job_aftercast(spell, action, spellMap, eventArgs)
        equip(sets[state.WeaponSet.current])
	end
	
windower.register_event('hpp change', function(new, old)
    if new<=20 then
        equip({head="Twilight Helm",body="Twilight Mail"})
        disable('head','body')
    else
        enable('head','body')
    end
end)

function customize_idle_set(idleSet)

	if state.Warp.current == 'on' then
		equip(sets.Warp)
		disable('ring1')
		disable('ring2')
		disable('waist')
	else
		enable('ring1')
		enable('ring2')
		enable('waist')
	end
    return idleSet
end

function customize_melee_set(meleeSet)
	if state.OffenseMode.value == 'Dual' then
		if state.HybridMode.value == 'Hybrid' then
			meleeSet = equip(sets.engaged.Hybrid.Dual)
		end
	end
 
	return meleeSet
end


function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 1)
    else
        set_macro_page(1, 1)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 81')
end