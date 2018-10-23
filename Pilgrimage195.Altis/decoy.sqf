RYD_JR_DecoyPending = true;

_pos = player modelToWorld [0,1.5,0];

if (surfaceIsWater _pos) exitWith 
	{
	hint "Decoy can't be placed on the water.";
	RYD_JR_DecoyPending = false
	};
	
RYD_JR_DecoyCost = 0;

_dl = createDialog "RscDecoy";

waitUntil {dialog};

sliderSetRange [18000, 1000, RYD_JR_FuelFund min 22500];	
sliderSetSpeed [18000, 1000, 1000];

waitUntil {not dialog};

_amount = RYD_JR_DecoyCost;

if (_amount < 1000) exitWith 
	{
	RYD_JR_DecoyPending = false
	};
	
RYD_JR_FuelFund = RYD_JR_FuelFund - RYD_JR_DecoyCost;
RYD_JR_FuelFundSpent = RYD_JR_FuelFundSpent + RYD_JR_DecoyCost;

_sides = RYD_JR_Freq;

_decoyed = [];

_maxDst = (((sqrt _amount) * 10) min 1500) max 10;
_delRisk = (RYD_JR_HuntStage - 1);

	{
	_ldr = leader _x;
	_side = side _x;
	_dst = _ldr distance _pos;
	
	_delated = false;
		
	if ((_side in [east,resistance]) and {_delRisk > 0}) then
		{
		if (_dst < 3000) then
			{		
			if ((random 100) < _delRisk) exitWith
				{
				RYD_JR_Delation = [position player,time];
				
					{
					if ((((RYD_JR_Delation select 0) distance (_x select 0)) < 1000) and {((RYD_JR_Delation select 1) - (_x select 1)) < 3600}) exitWith {RYD_JR_Delation = []};
					}
				foreach RYD_JR_PastDelations;
				
				if not (RYD_JR_Delation isEqualTo []) then
					{
					RYD_JR_PastDelations pushBack RYD_JR_Delation;
					_delated = true
					};
				}
			};
		};
			
	if (_delated) exitWith {};
	
	if ((_side in _sides) and {not (captive _ldr)}) then
		{		
		if (not (_x in RYD_JR_cached) and {(_dst < _maxDst)}) then
			{
			if (isNull (assignedVehicle _ldr)) then
				{
				if (({((damage _x) < 0.1) and {(canStand _x)}} count (units _x)) > 0) then
					{
					_busy = (_x getVariable ["RYD_JR_Decoyed",false]) or {(_x getVariable ["RYD_JR_Chasing",false]) or {(_x in RYD_JR_BusyPatrols)}};
					
					if not (_busy) then
						{
						_chance = 1 - (_dst/_maxDst);
						
						if ((random 1) < _chance) then
							{							
							_x setVariable ["RYD_JR_Decoyed",true];
							_x setVariable ["RYD_JR_DecoyedPos",position _ldr];
														
							_decoyed pushBack _x;
							
							[_x,_pos] spawn
								{
								_gp = _this select 0;
								_pos = _this select 1;
								
								sleep (20 + (random 10));
								
								[_gp,[_pos,0,10] call RYD_JR_RandomAroundMM,_gp,true] spawn RYD_JR_Response;
								}
							}
						}
					}
				}
			}
		}
	}
foreach allGroups;

sleep 0.5;

_txt = format ["FF decoy for %1 is placed.\nBroadcasting the coordinates... ",RYD_JR_DecoyCost];

TitleText [_txt,"PLAIN DOWN",1];

sleep 5;

_txt = format ["Done",RYD_JR_DecoyCost];

TitleText [_txt,"PLAIN DOWN",1];

["sonar",3] spawn RYD_JR_Sound3D;

sleep 5;

TitleText ["","PLAIN DOWN",0];

_i = "";

if ((count _decoyed) > 0) then
	{
	_txt = format [" Enticed groups: %1",count _decoyed];
	_i = "decoyMark_" + (str _pos);
	_i = createMarker [_i,_pos];
	_i setMarkerColor "colorOrange";
	_i setMarkerShape "ICON";
	_i setMarkerType "mil_warning";
	_i setMarkerSize [0.9,0.9];
	_i setMarkerText _txt;
	};
	
[_i,_decoyed] spawn
	{
	_i = _this select 0;
	_decoyed = _this select 1;
	
	waitUntil
		{
		sleep 10;
		
		_cnt = ({(not (isNull _x)) and {_x getVariable ["RYD_JR_Decoyed",false]}} count _decoyed);
		_txt = format [" Enticed groups: %1",_cnt];
		_i setMarkerText _txt;
		
		not (_cnt > 0)
		};

	deleteMarker _i
	};

RYD_JR_DecoyPending = false;

//RYD_JR_FuelFund

/*
_center = markerPos "PatrolMarker";
_size = markerSize "PatrolMarker";
_sX = _size select 0;
_sY = _size select 1;
_amnt = 3 + (random 3);

_positions = [];

for "_i" from 1 to _amnt do
	{
	_pos = [(_center select 0) - _sX + (random (2 * _sX)),(_center select 1) - _sY + (random (2 * _sY)),0];
	_positions pushBack _pos;
	_wp = PatrolGroup addWaypoint [_pos, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointTimeout [10, 15, 20];
	
	if (_i == 1) then
		{
		PatrolGroup setCurrentWaypoint _wp
		};
	};
	
_wp = PatrolGroup addWaypoint [(_positions select 0), 0];
_wp setWaypointType "CYCLE";*/