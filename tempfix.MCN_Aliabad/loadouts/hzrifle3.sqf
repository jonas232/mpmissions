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
_unit forceAddUniform "MNP_CombatUniform_M81_Rg";
for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_quikclot";};
_unit addVest "UK3CB_BAF_V_PLCE_Webbing_OLI";
for "_i" from 1 to 5 do {_unit addItemToVest "rhs_30Rnd_762x39mm";};
_unit addItemToVest "rhs_mag_rgd5";
_unit addHeadgear "H_Bandanna_gry";
_unit addGoggles "G_Bandanna_blk";

comment "Add weapons";
_unit addWeapon "rhs_weap_akm";
_unit addPrimaryWeaponItem "rhs_acc_2dpZenit";

comment "Add items";

comment "Set identity";
_unit setFace "AfricanHead_01";