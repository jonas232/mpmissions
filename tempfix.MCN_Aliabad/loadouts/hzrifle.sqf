if (!isServer) exitWith {};
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
_unit forceAddUniform "MNP_CombatUniform_NKC_Rg";
for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_quikclot";};
_unit addVest "UK3CB_BAF_V_PLCE_Webbing_OLI";
_unit addItemToVest "rhs_mag_rgd5";
for "_i" from 1 to 6 do {_unit addItemToVest "rhs_30Rnd_762x39mm";};
_unit addHeadgear "H_ShemagOpen_khk";

comment "Add weapons";
_unit addWeapon "rhs_weap_akms";
_unit addPrimaryWeaponItem "rhs_acc_2dpZenit";

comment "Add items";

comment "Set identity";
_unit setFace "AfricanHead_02";