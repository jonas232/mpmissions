// ATTACHMENTS - PRIMARY
_attach1 = "rhsusf_acc_anpeq15side_bk";	// IR Laser
_attach2 = "rhsusf_acc_anpeq15side_bk";	// Flashlight

_silencer1 = "rhsusf_acc_SFMB556";	// 5.56 suppressor
_silencer2 = "hlc_muzzle_snds_AUG";	// 6.5 suppressor

_scope1 = "rhsusf_acc_eotech_xps3";	// Holosight
_scope2 = "optic_MRCO";			// MRCO Scope - 1x - 6x
_scope3 = "optic_SOS";			// SOS Scope - 18x - 75x

_bipod1 = "bipod_01_F_blk";		// Default bipod
_bipod2 = "bipod_01_F_blk";		// Black bipod



this forceAddUniform "rhs_uniform_FROG01_wd";
this addItemToUniform "ACE_fieldDressing";
this addItemToUniform "ACE_bloodIV";
this addItemToUniform "ACE_bloodIV_500";
this addItemToUniform "ACE_bodyBag";
this addItemToUniform "ACE_epinephrine";
this addItemToUniform "ACE_morphine";
this addVest "rhsusf_mbav_rifleman";
this addItemToVest "UK3CB_BAF_SmokeShell";
this addItemToVest "UK3CB_BAF_SmokeShellGreen";
this addItemToVest "UK3CB_BAF_SmokeShellRed";
for "_i" from 1 to 2 do {this addItemToVest "ACE_HandFlare_Green";};
for "_i" from 1 to 2 do {this addItemToVest "ACE_HandFlare_Red";};
for "_i" from 1 to 2 do {this addItemToVest "ACE_HandFlare_White";};
this addItemToVest "HandGrenade";
this addItemToVest "rhs_mag_mk84";
this addItemToVest "MiniGrenade";
this addBackpack "B_Kitbag_cbr";
this addItemToBackpack "ACE_wirecutter";
this addItemToBackpack "ACE_Sandbag_empty";
this addItemToBackpack "MineDetector";
this addItemToBackpack "ACE_microDAGR";
this addItemToBackpack "ACE_Flashlight_XL50";
this addItemToBackpack "ACE_Clacker";
this addItemToBackpack "ACE_IR_Strobe_Item";
this addItemToBackpack "ACE_Fortify";
this addItemToBackpack "ACE_EntrenchingTool";
this addItemToBackpack "ACE_DefusalKit";
this addItemToBackpack "ACE_EarPlugs";
this addItemToBackpack "ACE_DeadManSwitch";
this addItemToBackpack "ACE_Cellphone";
this addItemToBackpack "ACE_CableTie";
this addItemToBackpack "ACE_Banana";
this addHeadgear "rhsusf_opscore_ut_pelt";
this addGoggles "rhsusf_oakley_goggles_blk";
this linkItem "tf_anprc152_1";
this linkItem "ACE_NVG_Gen4";

this forceAddUniform "rhs_uniform_FROG01_wd";
this addItemToUniform "rhs_mag_30Rnd_556x45_M855_Stanag";
this addItemToUniform "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red";
for "_i" from 1 to 3 do {this addItemToUniform "rhsusf_mag_17Rnd_9x19_FMJ";};
this addHeadgear "rhsusf_opscore_ut_pelt_cam";
this addGoggles "rhsusf_oakley_goggles_clr";

this addWeapon "rhs_weap_m27iar_grip";
this addPrimaryWeaponItem "hlc_muzzle_snds_AUG";
this addPrimaryWeaponItem "rhsusf_acc_anpeq15side_bk";
this addPrimaryWeaponItem "optic_MRCO";
this addPrimaryWeaponItem "bipod_01_F_blk";
this addWeapon "rhsusf_weap_glock17g4";
this addWeapon "lerca_1200_black";

this linkItem "tf_microdagr";
this linkItem "tf_anprc152";

this forceAddUniform "rhs_uniform_FROG01_wd";
for "_i" from 1 to 3 do {this addItemToUniform "rhsusf_mag_17Rnd_9x19_FMJ";};
this addItemToUniform "rhs_mag_30Rnd_556x45_M855_Stanag";
this addVest "V_PlateCarrier1_rgr";
for "_i" from 1 to 2 do {this addItemToVest "rhs_mag_30Rnd_556x45_M855_Stanag";};
this addItemToVest "rhs_mag_M441_HE";
this addItemToVest "rhs_mag_M433_HEDP";
this addHeadgear "rhsusf_opscore_ut_pelt_nsw";
this addGoggles "rhsusf_oakley_goggles_ylw";

this addWeapon "rhs_weap_m4a1_blockII_M203_bk";
this addPrimaryWeaponItem "rhsusf_acc_SFMB556";
this addPrimaryWeaponItem "rhsusf_acc_anpeq15side_bk";
this addPrimaryWeaponItem "rhsusf_acc_eotech_xps3";
this addWeapon "rhsusf_weap_glock17g4";
this addWeapon "lerca_1200_black";

this addItemToBackpack "Titan_AT";
this addItemToBackpack "Titan_AP";

this addWeapon "launch_O_Titan_short_F";

comment "Exported from Arsenal by j0nas";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "rhs_uniform_FROG01_wd";
this addVest "V_Chestrig_rgr";
this addHeadgear "rhsusf_hgu56p_visor_usa";
this addGoggles "G_Bandanna_oli";

comment "Add weapons";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "tf_anprc152_1";
this linkItem "ItemGPS";

comment "Set identity";
this setFace "WhiteHead_22_sa";
this setSpeaker "ace_novoice";
