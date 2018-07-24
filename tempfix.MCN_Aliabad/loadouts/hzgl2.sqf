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
for "_i" from 1 to 5 do {_unit addItemToUniform "rhs_30Rnd_762x39mm";};
_unit addVest "MNP_V_OD_GL_Harness";
for "_i" from 1 to 8 do {_unit addItemToVest "rhs_VOG25";};
for "_i" from 1 to 3 do {_unit addItemToVest "rhs_30Rnd_762x39mm";};
_unit addHeadgear "H_ShemagOpen_khk";

comment "Add weapons";
_unit addWeapon "rhs_weap_akms_gp25";

comment "Add items";

comment "Set identity";
_unit setFace "AfricanHead_03";