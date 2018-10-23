_tgt = _this select 0;

_veh = assignedVehicle player;

if (isNull _veh) exitWith {hint "You don't have a vehicle."};

RYD_JR_PackedCamp = _veh;

_txt = "Packing the hideout...";
0.5 fadeSound 0;
TitleText [_txt,"BLACK OUT",0.55];

_cpItems = _tgt getVariable ["RYD_JR_MyCP",[]];

RYD_JR_CPItems = RYD_JR_CPItems - _cpItems;

_mark = _tgt getVariable ["RYD_JR_MyCPMark",""];
_box1 = _cpItems select 5;
_box2 = _cpItems select 8;

_boxes = [_box1,_box2];

_cpItems = _cpItems - _boxes;

RYD_JR_PackedCPLoot = _boxes;
RYD_JR_PackedMark = _mark;

sleep 1;

RYD_JR_Base = RYD_JR_Base - [_tgt];
RYD_JR_Camps = RYD_JR_Camps - [_tgt];

	{
	deleteVehicle _x
	}
foreach _cpItems;

	{
	_x hideObject true;
	_x enableSimulation false
	}
foreach _boxes; 

_mark setMarkerAlpha 0;

0.5 fadeSound 1;
TitleText [_txt,"BLACK IN",0.55];
_txt = "Hideout is packed";
sleep 0.6;
TitleText [_txt,"PLAIN",0.55];

if (isNull _veh) exitWith {};

_aID = _veh addAction ["<t color='#d0a900'>Unpack hideout</t>", "SettingCamp.sqf", false, 1, false, true, "", "((alive _target) and not (RYD_JR_inStealth))"];