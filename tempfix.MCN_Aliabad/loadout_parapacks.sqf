hard_setLoadout_parapacks = 
{
	_unit = _this select 0;
	_loadout = _unit getVariable "loadout";
	switch _loadout do 
	{
		case "SAlead": {[_unit] call loadoutSA_lead_parapacks};
		case "SAmedic": {[_unit] call loadoutSA_medic_parapacks};
		case "SAGL": {[_unit] call loadoutSA_GL_parapacks};
		case "SAdemo": {[_unit] call loadoutSA_demo_parapacks};
		case "SAMG": {[_unit] call loadoutSA_MG_parapacks};
		case "SArifle": {[_unit] call loadoutSA_rifle_parapacks};
		case "SArifleAT": {[_unit] call loadoutSA_rifleAT_parapacks};


	};
};

loadoutSA_lead_parapacks = // SAlead
{
	_unit = _this select 0;
	
	comment "Exported from Arsenal by Poudjik";

comment "Remove existing items";

removeBackpack _unit;

if (isPlayer _unit) then {_unit addbackpack "tf_rt1523g"} else {_unit addbackpack "tf_rt1523g"};

_unit linkItem "ItemMap";
_unit linkItem "rhsusf_ANPVS_14";


};

loadoutSA_medic_parapacks = // SAmedic
{
	_unit = _this select 0;
	
removeBackpack _unit;

_unit addBackpack "B_Kitbag_rgr";
for "_i" from 1 to 4 do {_unit addItemToBackpack "ACE_CableTie";};
for "_i" from 1 to 30 do {_unit addItemToBackpack "ACE_fieldDressing";};
for "_i" from 1 to 30 do {_unit addItemToBackpack "ACE_bloodIV_500";};
for "_i" from 1 to 20 do {_unit addItemToBackpack "ACE_epinephrine";};
for "_i" from 1 to 20 do {_unit addItemToBackpack "ACE_morphine";};

_unit linkItem "ItemMap";
_unit linkItem "rhsusf_ANPVS_14";

};

loadoutSA_GL_parapacks = // SAGL
{
	_unit = _this select 0;
	
removeBackpack _unit;

_unit addBackpack "B_Kitbag_rgr";
_unit addItemToBackpack "ACE_Clacker";
for "_i" from 1 to 4 do {_unit addItemToBackpack "ACE_CableTie";};
_unit addItemToBackpack "FHQ_optic_MicroCCO_low_tan";
_unit addItemToBackpack "rhsusf_weap_MP7A1_desert";
for "_i" from 1 to 4 do {_unit addItemToBackpack "rhsusf_mag_40Rnd_46x30_FMJ";};

_unit linkItem "ItemMap";
_unit linkItem "rhsusf_ANPVS_14";


};

loadoutSA_demo_parapacks = // SAdemo
{
	_unit = _this select 0;
	
removeBackpack _unit;

_unit addBackpack "B_Kitbag_rgr";
_unit addItemToBackpack "ACE_Clacker";
for "_i" from 1 to 4 do {_unit addItemToBackpack "ACE_CableTie";};
_unit addItemToBackpack "FHQ_optic_MicroCCO_low_tan";
_unit addItemToBackpack "rhsusf_weap_MP7A1_desert";
_unit addItemToBackpack "rhs_weap_M320";
for "_i" from 1 to 4 do {_unit addItemToBackpack "rhsusf_mag_40Rnd_46x30_FMJ";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "30Rnd_556x45_Stanag_Tracer_Green";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "1Rnd_HE_Grenade_shell";};
_unit addItemToBackpack "DemoCharge_Remote_Mag";

_unit linkItem "ItemMap";
_unit linkItem "rhsusf_ANPVS_14";

};

loadoutSA_MG_parapacks = // SAMG
{
	_unit = _this select 0;
	
removeBackpack _unit;

_unit addBackpack "B_Carryall_khk";
_unit addItemToBackpack "muzzle_snds_570";
_unit addItemToBackpack "SMG_03C_black";
for "_i" from 1 to 2 do {_unit addItemToBackpack "50Rnd_570x28_SMG_03";};

_unit linkItem "ItemMap";
_unit linkItem "rhsusf_ANPVS_14";


};

loadoutSA_rifle_parapacks = // SArifle
{
	_unit = _this select 0;
	
removeBackpack _unit;

_unit addBackpack "B_TacticalPack_blk";
_unit addItemToBackpack "ACE_Clacker";
for "_i" from 1 to 4 do {_unit addItemToBackpack "ACE_CableTie";};
_unit addItemToBackpack "FHQ_optic_MicroCCO_low_tan";
_unit addItemToBackpack "rhsusf_weap_MP7A1_desert";
for "_i" from 1 to 4 do {_unit addItemToBackpack "rhsusf_mag_40Rnd_46x30_FMJ";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "30Rnd_556x45_Stanag_Tracer_Green";};
_unit addItemToBackpack "DemoCharge_Remote_Mag";
_unit addItemToBackpack "rhs_200rnd_556x45_T_SAW";

_unit linkItem "ItemMap";
_unit linkItem "rhsusf_ANPVS_14";



};

loadoutSA_rifleAT_parapacks = // SArifleAT
{
	_unit = _this select 0;
	
removeBackpack _unit;
_unit addBackpack "B_TacticalPack_blk";
_unit addItemToBackpack "ACE_Clacker";
for "_i" from 1 to 4 do {_unit addItemToBackpack "ACE_CableTie";};
_unit addItemToBackpack "FHQ_optic_MicroCCO_low_tan";
_unit addItemToBackpack "rhsusf_weap_MP7A1_desert";
for "_i" from 1 to 4 do {_unit addItemToBackpack "rhsusf_mag_40Rnd_46x30_FMJ";};
_unit addItemToBackpack "DemoCharge_Remote_Mag";
_unit addHeadgear "rhsusf_opscore_rg_cover_pelt";

_unit linkItem "ItemMap";
_unit linkItem "rhsusf_ANPVS_14";



};

////////////////////////////////////////////////////////////////////////////////////////////
//  blaffer note: continue removing all lines not about backpacks
//  and add _parapacks to the function name
////////////////////////////////////////////////////////////////////////////////////////////

