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
_unit forceAddUniform "MNP_CombatUniform_NKC_Sh";
_unit addItemToUniform "rhs_100Rnd_762x54mmR_green";
_unit addVest "V_HarnessO_brn";
_unit addItemToVest "rhs_mag_rgd5";
for "_i" from 1 to 2 do {_unit addItemToVest "rhs_100Rnd_762x54mmR";};
_unit addItemToVest "rhs_100Rnd_762x54mmR_green";
_unit addHeadgear "H_Bandanna_gry";
_unit addGoggles "G_Bandanna_blk";

comment "Add weapons";
_unit addWeapon "rhs_weap_pkm";

comment "Add items";

comment "Set identity";
_unit setFace "AfricanHead_03";