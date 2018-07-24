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
_unit forceAddUniform "MNP_CombatUniform_NKR_Sh";
for "_i" from 1 to 2 do {_unit addItemToUniform "ACE_quikclot";};
for "_i" from 1 to 3 do {_unit addItemToUniform "hlc_45Rnd_762x39_t_rpk";};
_unit addVest "V_Chestrig_rgr";
for "_i" from 1 to 8 do {_unit addItemToVest "rhs_VOG25";};
for "_i" from 1 to 3 do {_unit addItemToVest "hlc_75Rnd_762x39_m_rpk";};
_unit addItemToVest "rhs_mag_rgd5";
_unit addBackpack "rhs_sidor";
for "_i" from 1 to 2 do {_unit addItemToBackpack "hlc_75Rnd_762x39_m_rpk";};
_unit addHeadgear "H_Shemag_olive";

comment "Add weapons";
_unit addWeapon "hlc_rifle_rpk";


comment "Set identity";
_unit setFace "AfricanHead_03";
