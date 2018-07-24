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
_unit forceAddUniform "MNP_CombatUniform_Rebel_B";
for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_quikclot";};
for "_i" from 1 to 3 do {_unit addItemToUniform "rhs_30Rnd_762x39mm";};
_unit addVest "rhs_vydra_3m";
_unit addItemToVest "rhs_mag_rgd5";
for "_i" from 1 to 4 do {_unit addItemToVest "rhs_30Rnd_762x39mm";};
_unit addBackpack "rhs_rpg_empty";
for "_i" from 1 to 4 do {_unit addItemToBackpack "rhs_rpg7_PG7VL_mag";};
_unit addHeadgear "H_Bandanna_khk";
_unit addGoggles "rhs_scarf";

comment "Add weapons";
_unit addWeapon "rhs_weap_akms";
_unit addWeapon "rhs_weap_rpg7";

comment "Add items";

comment "Set identity";
_unit setFace "AfricanHead_02";