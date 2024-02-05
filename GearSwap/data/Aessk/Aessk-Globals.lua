-------------------------------------------------------------------------------------------------------------------
-- Modify the sets table.  Any gear sets that are added to the sets table need to
-- be defined within this function, because sets isn't available until after the
-- include is complete.  It is called at the end of basic initialization in Mote-Include.
-------------------------------------------------------------------------------------------------------------------

function define_global_sets()

    -- Augmented Weapons
    gear.Kali_Idle = {name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}
    gear.Kali_Song = {name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}}

	gear.Kumb_TPB1 = { name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+21','Pet: Phys. dmg. taken -4%','Pet: TP Bonus+200',}}
	gear.Kumb_TPB2 = { name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+23','Pet: Haste+3','Pet: TP Bonus+200',}}
	gear.Kumb_TPB3 = { name="Kumbhakarna", augments={'Pet: Attack+19 Pet: Rng.Atk.+19','Pet: Haste+3','Pet: TP Bonus+200',}}

    gear.Linos_TP = { name="Linos", augments={'Accuracy+13 Attack+13','"Dbl.Atk."+3','Quadruple Attack +3',}}
    gear.Linos_WS = { name="Linos", augments={'Accuracy+17','Weapon skill damage +3%','STR+8',}}

    -- Acro
    gear.Acro_Breath_body = { name="Acro Surcoat", augments={'Pet: Mag. Acc.+22','Pet: Breath+8','HP+49',}}
    gear.Acro_Breath_hands = { name="Acro Gauntlets", augments={'Pet: Mag. Acc.+23','Pet: Breath+8','HP+50',}}
	gear.Acro_Breath_legs = { name="Acro Breeches", augments={'Pet: Mag. Acc.+23','Pet: Breath+8','HP+40',}}
	gear.Acro_Breath_feet = { name="Acro Leggings", augments={'Pet: Mag. Acc.+25','Pet: Breath+8','HP+39',}}

	gear.Acro_Call_Body = { name="Acro Surcoat", augments={'Attack+24','"Call Beast" ability delay -5','Crit. hit damage +2%',}}

    gear.Acro_STP_hands = { name="Acro Gauntlets", augments={'Accuracy+20 Attack+20','"Store TP"+6','STR+7 DEX+7',}}

    -- Adhemar
    gear.Adhemar_B_head = { name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}
    gear.Adhemar_D_head = { name="Adhemar Bonnet +1", augments={'HP+105','Attack+13','Phys. dmg. taken -4',}}

	gear_Adhemar_A_body = { name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    gear.Adhemar_B_body = { name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}}
	gear_Adhemar_D_body = { name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4',}}

    gear.Adhemar_A_hands = { name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    gear.Adhemar_B_hands = { name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}}

    gear.Adhemar_D_legs = { name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}}

    gear.Adhemar_D_feet = { name="Adhe. Gamashes +1", augments={'HP+65','"Store TP"+7','"Snapshot"+10',}}

	-- Argosy
	gear.Argosy_D_head = { name="Argosy Celata +1", augments={'DEX+12','Accuracy+20','"Dbl.Atk."+3',}}

	--Emicho
	gear.Emicho_C_hands = { name="Emi. Gauntlets +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}}
	gear.Emicho_C_legs = { name="Emicho Hose +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}}

    -- Herculean
    gear.Herc_TA_feet = { name="Herculean Boots", augments={'"Triple Atk."+4','CHR+3','Accuracy+15','Attack+13',}}

    gear.Herc_STP_head = {name="Herculean Helm", augments={'"Store TP"+4','CHR+3','Quadruple Attack +2','Accuracy+15 Attack+15','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}
	
	gear.Herc_FC_head = { name="Herculean Helm", augments={'MND+7','Pet: Haste+3','"Fast Cast"+8','Accuracy+5 Attack+5','Mag. Acc.+11 "Mag.Atk.Bns."+11',}}
	gear.Herc_FC_legs = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+13','"Fast Cast"+6','MND+2',}}
	gear.Herc_FC_feet = { name="Herculean Boots", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Fast Cast"+6','STR+10',}}

    gear.Herc_MAB_head = { name="Herculean Helm", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Enmity-4','MND+5','Mag. Acc.+11','"Mag.Atk.Bns."+15',}}
	gear.Herc_MAB_hands = { name="Herculean Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+1%','MND+7','Mag. Acc.+10','"Mag.Atk.Bns."+13',}}
    gear.Herc_MAB_legs = { name="Herculean Trousers", augments={'"Store TP"+4','"Mag.Atk.Bns."+30','Mag. Acc.+15 "Mag.Atk.Bns."+15',}}
    gear.Herc_MAB_feet = {name="Herculean Boots", augments={'"Mag.Atk.Bns."+22','"Fast Cast"+2','Accuracy+10 Attack+10','Mag. Acc.+15 "Mag.Atk.Bns."+15',}}

	gear.Herc_MB_feet = { name="Herculean Boots", augments={'"Mag.Atk.Bns."+23','Magic burst dmg.+7%','STR+1',}}

	gear.Herc_MABWS_legs = { name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +5%','"Mag.Atk.Bns."+15',}}

	gear.Herc_STRWS_head = { name="Herculean Helm", augments={'Accuracy+25 Attack+25','Weapon skill damage +3%','STR+10','Attack+14',}}
	gear.Herc_STRWS_legs = { name="Herculean Trousers", augments={'Mag. Acc.+2','Weapon skill damage +4%','STR+15','"Mag.Atk.Bns."+7',}}

    gear.Herc_DEXWS_body = { name="Herculean Vest", augments={'Weapon skill damage +3%','DEX+15','Attack+15',}}
    gear.Herc_DEXWS_feet = { name="Herculean Boots", augments={'Accuracy+18','Weapon skill damage +3%','DEX+10','Attack+8',}}

    gear.Herc_Idle_head ={name="Herculean Helm", augments={'INT+5','"Mag.Atk.Bns."+19','"Refresh"+2','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}
	
	gear.Herc_Repair_head = { name="Herculean Helm", augments={'Pet: Attack+21 Pet: Rng.Atk.+21','"Repair" potency +8%','Pet: MND+4','Pet: "Mag.Atk.Bns."+11',}}
	gear.Herc_Repair_hands = { name="Herculean Gloves", augments={'Pet: Attack+13 Pet: Rng.Atk.+13','"Repair" potency +8%','Pet: STR+3',}}
	
	gear.Herc_PetRA_head = { name="Herculean Helm", augments={'Pet: Accuracy+27 Pet: Rng. Acc.+27','Pet: "Store TP"+10','Pet: CHR+5',}}
	gear.Herc_PetRA_hands = { name="Herculean Gloves", augments={'Pet: Accuracy+26 Pet: Rng. Acc.+26','Pet: "Store TP"+10','Pet: AGI+6','Pet: "Mag.Atk.Bns."+6',}}
	gear.Herc_PetRA_legs = { name="Herculean Trousers", augments={'Pet: Accuracy+27 Pet: Rng. Acc.+27','Pet: "Store TP"+9','Pet: DEX+5','Pet: Attack+6 Pet: Rng.Atk.+6',}}
	gear.Herc_PetRA_feet = { name="Herculean Boots", augments={'Pet: Accuracy+29 Pet: Rng. Acc.+29','Pet: "Store TP"+5','Pet: DEX+4','Pet: Attack+14 Pet: Rng.Atk.+14','Pet: "Mag.Atk.Bns."+15',}}

	gear.Herc_PetMAB_head = { name="Herculean Helm", augments={'Pet: "Mag.Atk.Bns."+30','Pet: Haste+1','Pet: INT+3','Pet: Attack+2 Pet: Rng.Atk.+2',}}
	gear.Herc_PetMAB_hands = { name="Herculean Gloves", augments={'Pet: "Mag.Atk.Bns."+30','Pet: Haste+4',}}
	
    gear.Herc_TH_head = { name="Herculean Helm", augments={'AGI+5','DEX+3','"Treasure Hunter"+2',}}

	--Lustratio
	gear_Lust_B_legs = { name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}}

	gear.Lust_A_feet = { name="Lustra. Leggings +1", augments={'Attack+20','STR+8','"Dbl.Atk."+3',}}
	gear.Lust_D_feet = { name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}}

    -- Merlinic
    gear.Merl_FC_body = {name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+13','"Fast Cast"+7',}}
    gear.Merl_MB_body = {name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+10%','VIT+5','"Mag.Atk.Bns."+12',}}

	-- Rao
	gear.Rao_D_head = { name="Rao Kabuto +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}
	gear.Rao_D_body = { name="Rao Togi +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}
	gear.Rao_D_hands = { name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}
	gear.Rao_D_legs = { name="Rao Haidate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}
	gear.Rao_D_feet = { name="Rao Sune-Ate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}
	
	-- Ryuo
	gear.Ryuo_A_hands = { name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}}

	gear_Ryou_D_legs = { name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}}

	gear.Ryuo_C_feet = { name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}

    -- Taeon
    gear.Taeon_DW_feet = { name="Taeon Boots", augments={'Accuracy+22','"Dual Wield"+3','DEX+10',}}

    gear.Taeon_FC_body = { name="Taeon Tabard", augments={'"Fast Cast"+5',}}

    gear.Taeon_SNP_head = { name="Taeon Chapeau", augments={'Rng.Acc.+13 Rng.Atk.+13','"Snapshot"+5','"Snapshot"+5',}}
	
	gear.Taeon_Pet_head = { name="Taeon Chapeau", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
	gear.Taeon_Pet_body = { name="Taeon Tabard", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
	gear.Taeon_Pet_hands = { name="Taeon Gloves", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
	gear.Taeon_Pet_legs = { name="Taeon Tights", augments={'Pet: Accuracy+22 Pet: Rng. Acc.+22','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
	gear.Taeon_Pet_feet = { name="Taeon Boots", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
	
	-- Telchine
    gear.Telchine_ENH_head = { name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_body = { name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_hands = { name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_legs = { name="Telchine Braconi", augments={'"Cure" potency +3%','Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_feet = { name="Telchine Pigaches", augments={'Song spellcasting time -7%','Enh. Mag. eff. dur. +10',}}

    -- Valorous
    gear.Valo_STP_legs = { name="Valorous Hose", augments={'Attack+3','"Store TP"+7','MND+8','Accuracy+11',}}

    gear.Valo_TP_body = { name="Valorous Mail", augments={'Accuracy+26','"Dbl.Atk."+5','STR+1',}}
    gear.Valo_TP_legs = { name="Valorous Hose", augments={'Accuracy+18 Attack+18','"Dbl.Atk."+5','DEX+6','Attack+13',}}
	
	gear.Vale_MAB_head = { name="Valorous Mask", augments={'"Mag.Atk.Bns."+24','Enmity+2','"Treasure Hunter"+1','Accuracy+4 Attack+4','Mag. Acc.+15 "Mag.Atk.Bns."+15',}}
	gear.Vale_MAB_feet = { name="Valorous Greaves", augments={'Blood Pact Dmg.+2','"Mag.Atk.Bns."+26','Quadruple Attack +1','Mag. Acc.+16 "Mag.Atk.Bns."+16',}}

    gear.Valo_WSD_head = { name="Valorous Mask", augments={'Attack+23','Weapon skill damage +5%','DEX+3',}}
    gear.Valo_WSD_body = { name="Valorous Mail", augments={'Attack+9','Weapon skill damage +5%','DEX+7','Accuracy+7',}}
	gear.Valo_WSD_hands = { name="Valorous Mitts", augments={'Attack+20','Weapon skill damage +5%','Accuracy+5',}}
    gear.Valo_WSD_feet = { name="Valorous Greaves", augments={'Accuracy+20','Weapon skill damage +4%','VIT+4','Attack+5',}}

	-- Vanya
	gear_Vanya_D_head = { name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}}

	-- Adoulin Capes
	gear.PUP_fTP_Cape = { name="Dispersal Mantle", augments={'STR+2','DEX+1','Pet: TP Bonus+500','"Martial Arts"+13',}}
	
	gear.DNC_Flourish_Cape = { name="Toetapper Mantle", augments={'"Store TP"+2','"Dual Wield"+3','"Rev. Flourish"+30','Weapon skill damage +1%',}}
	
	gear.DRG_Breath_Cape = { name="Updraft Mantle", augments={'STR+1','Pet: Breath+10',}}

    -- Ambuscade Capes
    gear.BRD_DW_Cape = { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}
    gear.BRD_Song_Cape = { name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}}
    gear.BRD_WS1_Cape = { name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	
	gear.BST_PDA_Cape = { name="Artio's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','"Dual Wield"+10','Mag. Evasion+15',}}

	gear.COR_DA_Cape = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
    gear.COR_DW_Cape = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}
    gear.COR_RA_Cape = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Damage taken-5%',}}
	gear.COR_CRT_Cape = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','Crit.hit rate+10','Mag. Evasion+15',}}
    gear.COR_SNP_Cape = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Snapshot"+10',}}
	gear.COR_QD_Cape = { name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}}
	gear.COR_FC_Cape = { name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Mag. Evasion+15',}}
	gear.COR_WS1_Cape = { name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
    gear.COR_WS2_Cape = { name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    gear.COR_WS3_Cape ={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	
    gear.DNC_TP_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Mag. Evasion+15',}}
    gear.DNC_WS1_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	
	gear.DRG_TP_Cape = { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    gear.DRG_JMP_Cape = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	gear.DRG_WS1_Cape = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    gear.DRG_WS2_Cape = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	
	gear.MNK_TP_Cape = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
    gear.MNK_CRT_Cape = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}}
	
	gear.NIN_TP_Cape = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Mag. Evasion+15',}}
    gear.NIN_MAB_Cape = { name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.NIN_FC_Cape = { name="Andartia's Mantle", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Spell interruption rate down-10%',}}
    gear.NIN_WS1_Cape = { name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
    gear.NIN_WS2_Cape = { name="Andartia's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}}
	
	gear.PLD_Enmity_Cape = { name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','Damage taken-5%',}}
	
	gear.PUP_MTP_Cape = { name="Visucius's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
	gear.PUP_Regen_Cape = { name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+10','System: 1 ID: 1247 Val: 4',}}
    gear.PUP_Haste_Cape = { name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}}

    gear.RUN_HPP_Cape = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Parrying rate+5%',}}
    gear.RUN_TP_Cape = { name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.RUN_WS1_Cape = { name="Ogma's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
	
	gear.SAM_TP_Cape = { name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
	gear.SAM_WS1_Cape = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	
	gear.SMN_PMAB_Cape = { name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','Mag. Evasion+15',}}
	gear.SMN_PPHY_Cape = { name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10','Mag. Evasion+15',}}

    gear.THF_TP_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
    gear.THF_SNP_Cape = { name="Toutatis's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Snapshot"+10',}}
    gear.THF_WS1_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
    gear.THF_WS2_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Occ. inc. resist. to stat. ailments+10',}}
	
	gear.WAR_TP_Cape = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}

end