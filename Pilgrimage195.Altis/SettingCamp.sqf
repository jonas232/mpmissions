
_vh = _this select 0;

_pos = getPosATL _vh;

_dst = 20;
_pos2 = _pos isFlatEmpty [_dst,-1,0.75,5,0,false,_vh];
_ct = 0;

while {((count _pos2) < 2)} do
	{
	_dst = _dst - 1;
	if (_dst < 10) exitWith {};
	_pos2 = _pos isFlatEmpty [_dst,-1,0.75,5,0,false,_vh]
	};
	
_pos = _pos2;

if ((count _pos) < 2) exitWith {hint "No suitable place nearby."};

_pos set [2,0];

_vh removeAction (_this select 2);

_txt = "Setting the hideout...";
0.5 fadeSound 0;
TitleText [_txt,"BLACK OUT",0.55];

sleep 1;

_cp = [_pos,true] call RYD_JR_Sherwood;

_tgt = _cp select 0;

RYD_JR_CPItems = RYD_JR_CPItems + _cp;

_mark = RYD_JR_PackedMark;
_mark setMarkerPos _pos;
_mark setMarkerAlpha 1;

_tgt setVariable ["RYD_JR_MyCPMark",_mark];

if not (RYD_JR_multiHC) then
	{
	RYD_JR_Base = [_tgt];
	}
else
	{
	RYD_JR_Base pushBack _tgt
	};
	
_aID = _tgt addAction ["<t color='#d0a900'>Pack hideout into vehicle</t>", "PackHideout.sqf", false, 1, false, true, "", "(not (isNull (assignedVehicle player)) and (((assignedVehicle player) distance _target) < 50)  and (_target in RYD_JR_Base) and not ((RYD_JR_inStealth) or (RYD_JR_isResting)))"];
_aID = _tgt addAction ["<t color='#d0a900'>Rest 6 hours and heal yourself (first aid kit or medkit needed)</t>", "rest.sqf", [], 1, false, true, "", "(not ((RYD_JR_inCombat) or (RYD_JR_inStealth) or (RYD_JR_isResting)) and (_target in RYD_JR_Base))"];
	
_base = _tgt;
_park = _base getVariable ["RYD_JR_Parking",_base];
_pos = getPosATL _park;
_dir = getDir _park;

_dst = 10000;
		
sleep 0.04;

if (not (_vh isKindOf "Ship") and (canMove _vh) and ((fuel _vh) > 0)) then
	{
	if not (player in _vh) then
		{
		player moveInAny _vh
		};
		
	_vh setDir _dir;
	_vh setPos _pos;
	}
else
	{
	player setDir _dir;
	player setPos _pos;	
	};
	
0.5 fadeSound 1;
TitleText [_txt,"BLACK IN",0.55];
_txt = "Hideout is set";
sleep 0.6;

RYD_JR_PackedCamp = RYD_JR_DeadMan;

TitleText [_txt,"PLAIN",0.55];