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
_unit forceAddUniform "MNP_CombatUniform_Militia_B";
for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_quikclot";};
_unit addItemToUniform "rhs_30Rnd_762x39mm";
_unit addVest "V_HarnessOGL_gry";
for "_i" from 1 to 6 do {_unit addItemToVest "rhs_VOG25";};
for "_i" from 1 to 6 do {_unit addItemToVest "rhs_30Rnd_762x39mm";};

comment "Add weapons";
_unit addWeapon "rhs_weap_akm_gp25";

comment "Add items";

comment "Set identity";
_unit setFace "AfricanHead_01";