hard_setLoadout = 
{
	_unit = _this select 0;
	_loadout = _unit getVariable "loadout";
	switch _loadout do 
	{
		case "SAlead": {[_unit] call loadoutSA_lead};
		case "SAmedic": {[_unit] call loadoutSA_medic};
		case "SAGL": {[_unit] call loadoutSA_GL};
		case "SAdemo": {[_unit] call loadoutSA_demo};
		case "SAMG": {[_unit] call loadoutSA_MG};
		case "SArifle": {[_unit] call loadoutSA_rifle};
		case "SArifleAT": {[_unit] call loadoutSA_rifleAT};


	};
};

loadoutSA_lead = // SAlead
{
	_unit = _this select 0;
	

comment "Exported from Arsenal by Poudjik";

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_BG_Guerilla2_1";
for "_i" from 1 to 8 do {_unit addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_epinephrine";};
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_morphine";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addVest "rhsusf_spc_patchless_radio";
for "_i" from 1 to 3 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 9 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Green";};
for "_i" from 1 to 2 do {_unit addItemToVest "ACE_M84";};
for "_i" from 1 to 2 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
_unit addItemToVest "B_IR_Grenade";
_unit addItemToVest "Laserbatteries";
_unit addBackpack "B_Parachute";
_unit addHeadgear "rhsusf_opscore_aor1_pelt_nsw";

comment "Add weapons";
_unit addWeapon "rhs_weap_hk416d10";
_unit addPrimaryWeaponItem "rhsusf_acc_nt4_black";
_unit addPrimaryWeaponItem "rhsusf_acc_anpeq15_bk";
_unit addPrimaryWeaponItem "rhsusf_acc_eotech_552";
_unit addPrimaryWeaponItem "rhsusf_acc_grip2";
_unit addWeapon "asdg_hgun_Pistol_heavy_01_F";
_unit addWeapon "Laserdesignator";


comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";


if (isPlayer _unit) then {_unit linkItem "tf_anprc148jem"} else {_unit linkItem "itemRadio"};




};

loadoutSA_medic = // SAmedic
{
	_unit = _this select 0;
	
comment "Exported from Arsenal by Poudjik";

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "MNP_CombatUniform_Militia_DB";
for "_i" from 1 to 10 do {_unit addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 5 do {_unit addItemToUniform "ACE_epinephrine";};
for "_i" from 1 to 5 do {_unit addItemToUniform "ACE_morphine";};
_unit addVest "rhsusf_spc_corpsman";
for "_i" from 1 to 8 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Green";};
for "_i" from 1 to 2 do {_unit addItemToVest "UK3CB_BAF_9_17Rnd";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 3 do {_unit addItemToVest "SmokeShell";};
_unit addItemToVest "SmokeShellRed";
_unit addBackpack "B_Parachute";
_unit addHeadgear "rhsusf_opscore_aor1_pelt_nsw";

comment "Add weapons";
_unit addWeapon "rhs_weap_hk416d10";
_unit addPrimaryWeaponItem "rhsusf_acc_nt4_black";
_unit addPrimaryWeaponItem "rhsusf_acc_anpeq15_h";
_unit addPrimaryWeaponItem "rhsusf_acc_eotech_552";
_unit addPrimaryWeaponItem "rhsusf_acc_grip2";
_unit addWeapon "UK3CB_BAF_L131A1";
_unit addHandgunItem "muzzle_snds_L";
_unit addWeapon "Binocular";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";

[_unit,"UK3CB_BAF_Insignia_RedCross"] call bis_fnc_setUnitInsignia;


if (isPlayer _unit) then {_unit linkItem "tf_anprc148jem"} else {_unit linkItem "itemRadio"};


};


loadoutSA_GL = // SAGL
{
	_unit = _this select 0;
	
comment "Exported from Arsenal by Poudjik";

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_BG_Guerilla2_2";
for "_i" from 1 to 10 do {_unit addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 5 do {_unit addItemToUniform "ACE_epinephrine";};
for "_i" from 1 to 5 do {_unit addItemToUniform "ACE_morphine";};
_unit addItemToUniform "UK3CB_BAF_9_17Rnd";
_unit addVest "rhsusf_spc_teamleader";
for "_i" from 1 to 2 do {_unit addItemToVest "UK3CB_BAF_9_17Rnd";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {_unit addItemToVest "ACE_M84";};
for "_i" from 1 to 8 do {_unit addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Green";};
for "_i" from 1 to 10 do {_unit addItemToVest "rhs_mag_M441_HE";};
_unit addBackpack "B_Parachute";
_unit addHeadgear "rhsusf_opscore_rg_cover_pelt";

comment "Add weapons";
_unit addWeapon "rhs_weap_m4a1_blockII_M203_d";
_unit addPrimaryWeaponItem "rhsusf_acc_nt4_tan";
_unit addPrimaryWeaponItem "rhsusf_acc_anpeq15side";
_unit addPrimaryWeaponItem "rhsusf_acc_eotech_552_d";
_unit addWeapon "UK3CB_BAF_L131A1";
_unit addHandgunItem "muzzle_snds_L";
_unit addWeapon "Binocular";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";


if (isPlayer _unit) then {_unit linkItem "tf_anprc148jem"} else {_unit linkItem "itemRadio"};

};

loadoutSA_demo = // SAdemo
{
	_unit = _this select 0;
	
comment "Exported from Arsenal by Poudjik";

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_BG_Guerilla2_1";
for "_i" from 1 to 8 do {_unit addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_epinephrine";};
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_morphine";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addVest "rhsusf_spc_patchless_radio";
for "_i" from 1 to 8 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Green";};
for "_i" from 1 to 3 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {_unit addItemToVest "ACE_M84";};
for "_i" from 1 to 2 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
_unit addBackpack "B_Parachute";
_unit addHeadgear "rhsusf_opscore_rg_cover_pelt";
_unit addWeapon "Binocular";

comment "Add weapons";
_unit addWeapon "rhs_weap_hk416d10";
_unit addPrimaryWeaponItem "rhsusf_acc_nt4_black";
_unit addPrimaryWeaponItem "rhsusf_acc_anpeq15";
_unit addPrimaryWeaponItem "rhsusf_acc_eotech_552";
_unit addPrimaryWeaponItem "rhsusf_acc_grip2";
_unit addWeapon "asdg_hgun_Pistol_heavy_01_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";

if (isPlayer _unit) then {_unit linkItem "tf_anprc148jem"} else {_unit linkItem "itemRadio"};

};

loadoutSA_MG = // SAMG
{
	_unit = _this select 0;
	
comment "Exported from Arsenal by Poudjik";

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "MNP_CombatUniform_Militia_DA";
for "_i" from 1 to 5 do {_unit addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 5 do {_unit addItemToUniform "ACE_epinephrine";};
for "_i" from 1 to 5 do {_unit addItemToUniform "ACE_morphine";};
_unit addItemToUniform "50Rnd_570x28_SMG_03";
_unit addItemToUniform "UK3CB_BAF_9_17Rnd";
_unit addVest "rhsusf_spc_mg";
for "_i" from 1 to 2 do {_unit addItemToVest "rhs_200rnd_556x45_T_SAW";};
_unit addBackpack "B_Parachute";
_unit addHeadgear "rhsusf_opscore_paint_pelt_nsw";

comment "Add weapons";
_unit addWeapon "rhs_weap_m249_pip_S_vfg";
_unit addPrimaryWeaponItem "rhsusf_acc_anpeq15side_bk";
_unit addPrimaryWeaponItem "rhsusf_acc_eotech_552";
_unit addWeapon "UK3CB_BAF_L131A1";
_unit addHandgunItem "muzzle_snds_L";
_unit addWeapon "Binocular";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";

if (isPlayer _unit) then {_unit linkItem "tf_anprc148jem"} else {_unit linkItem "itemRadio"};

};

loadoutSA_rifle = // SArifle
{
	_unit = _this select 0;
	
comment "Exported from Arsenal by Poudjik";

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_BG_Guerilla2_3";
for "_i" from 1 to 8 do {_unit addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_epinephrine";};
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_morphine";};
_unit addItemToUniform "UK3CB_BAF_9_17Rnd";
_unit addVest "rhsusf_spc_patchless_radio";
for "_i" from 1 to 2 do {_unit addItemToVest "UK3CB_BAF_9_17Rnd";};
for "_i" from 1 to 8 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Green";};
for "_i" from 1 to 3 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {_unit addItemToVest "ACE_M84";};
_unit addBackpack "B_Parachute";
_unit addHeadgear "rhsusf_opscore_rg_cover_pelt";

comment "Add weapons";
_unit addWeapon "rhs_weap_hk416d10";
_unit addPrimaryWeaponItem "rhsusf_acc_nt4_black";
_unit addPrimaryWeaponItem "rhsusf_acc_anpeq15_bk";
_unit addPrimaryWeaponItem "rhsusf_acc_eotech_552";
_unit addPrimaryWeaponItem "rhsusf_acc_grip2";
_unit addWeapon "UK3CB_BAF_L131A1";
_unit addHandgunItem "muzzle_snds_L";
_unit addWeapon "Binocular";


comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";


if (isPlayer _unit) then {_unit linkItem "tf_anprc148jem"} else {_unit linkItem "itemRadio"};

};

loadoutSA_rifleAT = // SArifleAT
{
	_unit = _this select 0;
	
comment "Exported from Arsenal by Poudjik";

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_BG_Guerilla2_2";
for "_i" from 1 to 8 do {_unit addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_epinephrine";};
for "_i" from 1 to 4 do {_unit addItemToUniform "ACE_morphine";};
_unit addItemToUniform "rhs_m72a7_mag";
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addVest "rhsusf_spc_patchless_radio";
for "_i" from 1 to 10 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Green";};
for "_i" from 1 to 3 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {_unit addItemToVest "ACE_M84";};
for "_i" from 1 to 2 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
_unit addBackpack "B_Parachute";
_unit addHeadgear "rhsusf_opscore_rg_cover_pelt";

comment "Add weapons";
_unit addWeapon "rhs_weap_hk416d10";
_unit addPrimaryWeaponItem "rhsusf_acc_nt4_black";
_unit addPrimaryWeaponItem "rhsusf_acc_anpeq15_bk_h";
_unit addPrimaryWeaponItem "rhsusf_acc_eotech_552";
_unit addPrimaryWeaponItem "rhsusf_acc_grip2";
_unit addWeapon "rhs_weap_m72a7";
_unit addWeapon "asdg_hgun_Pistol_heavy_01_F";
_unit addWeapon "Binocular";


comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";


if (isPlayer _unit) then {_unit linkItem "tf_anprc148jem"} else {_unit linkItem "itemRadio"};

};