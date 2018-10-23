_unit = _this select 0;
_killer = _this select 1;

_gp = group _unit;

_side = side _gp;

_pos = getPosASL _unit;

if not (_side in [civilian]) then
	{
	if (RYD_JR_ShowKillMarkers > 0) then
		{
		if ((_killer in ([player,vehicle player,assignedVehicle player] + (units (group player)))) or (RYD_JR_ShowKillMarkers == 2)) then
			{
			_isLOS = true;
			if not (_killer in ([player,vehicle player,assignedVehicle player] + (units (group player)))) then
				{
				_isLOS = false;
				if ((_unit distance player) < (600 min viewDistance)) then
					{
					_isLOS = [getposASL player,getPosASL _unit,1,0.5,vehicle player,_unit] call RYD_JR_LOSCheck
					}
				};
				
			if (_isLOS) then
				{
				_unit setVariable ["RYD_JR_BodyMarked",true];
				[_unit,_pos] spawn RYD_JR_Spark;
				}
			}
		};

	if not (_unit getVariable ["RYD_JR_Warlord",false]) then
		{
		[_unit,true] call RYD_JR_DecimateGear
		};

	if ((({alive _x} count (units _gp)) < 1) and {not (_gp getVariable ["RYD_JR_Reported",false])}) then
		{
		_caller = objNull;
		
			{
			_ldr = leader _x;
			
			if (((_ldr distance player) < 1500) and {(side _x) == (side _gp)}) exitWith 
				{
				_caller = _ldr
				}
			}
		foreach (RYD_JR_allEnemy - [_gp]);
		
		if not (isNull _caller) then
			{
			_tl = _gp getVariable ["RYD_JR_MyTLName",["",civilian]];
			_side0 = _tl select 1;
			_tl = _tl select 0;
			
			if ((_side0 in RYD_JR_Freq) and {"ItemRadio" in (assignedItems player)}) then
				{
				(group _caller) setVariable ["RYD_JR_MyLastAlarmChat",time];
				_gp setVariable ["RYD_JR_Reported",true];
				_who = "Garrison";
				
				if not (_tl isEqualto "") then
					{
					_who = _tl
					};
					
				_where = mapGridPosition (position _unit);
				
				_loc = (nearestLocations [(position _unit), ["NameCityCapital","NameCity","NameVillage","NameLocal","Hill"], 1000]) select 0;
									
				if not (isNil "_loc") then
					{
					_where = text _loc;
					
					if (_where isEqualTo "") then
						{
						_where = mapGridPosition (position _unit)
						}
					};
					
				_sent = RYD_JR_ChattingGroupGone select (floor (random (count RYD_JR_ChattingGroupGone)));
				
				_sent = format ["" + _sent,name _caller,_who,_where];
				
				//_sent = "It's " + (name _caller) + ". We're lost contact with " + _who + _where + ". Over.";
				
				[_sent,_caller] spawn
					{
					_sent = _this select 0;
					_caller = _this select 1;
					
					sleep (30 + (random 30));
					
					_alive = true;
					
					waitUntil
						{
						sleep (5 + (random 5));
						
						switch (true) do
							{
							case (isNil "_caller") : {_alive = false};
							case not ((typeName _caller) isEqualTo (typename objNull)) : {_alive = false};
							case (isNull _caller) : {_alive = false};
							case not (alive _caller) : {_alive = false};
							case (isNull (group _caller)) : {_alive = false};
							case (RYD_JR_Outro) : {_alive = false};
							};
						
						(not (_alive) or {((time - RYD_JR_LastComm) > 10)})
						};				
					
					if not (_alive) exitWith {};
					
					RYD_JR_LastComm = time;
					
					["static1",2.5] spawn RYD_JR_Sound3D;
					sleep 0.02;	
					RYD_JR_Caller customChat [RYD_JR_RadioNeutral,_sent]
					}
				}
			}
		}
	};

if ((_this select 1) in [player,vehicle player]) then
	{
	_val = 0;

	if (_side in [civilian,west]) then
		{
		_val = -10 - (random 10)
		}
	else
		{
		_myKind = _gp getVariable ["RYD_JR_MyKind","inf"];
		
		_val = switch (true) do
			{
			case (_gp in RYD_JR_AllHelis) : {5 + (random 5)};
			case (_myKind isEqualTo "arm") : {4 + (random 4)};
			case (_myKind isEqualTo "mech") : {3 + (random 3)};
			case (_myKind isEqualTo "mot") : {2 + (random 2)};
			case (_myKind isEqualTo "inf") : {1.5 + (random 1.5)};
			default {1 + (random 1)};
			};
		};
					
	_event = [_val,_pos,time];
	
	/*_i = createMarker [str _event,_pos];
	_i setMarkerColor "ColorBlack";
	_i setMarkerShape "ICON";
	_i setMarkerType "mil_dot";
	_i setMarkerSize [0.1,0.1];
	_i setMarkerText (format [" %1-%2-v%3-t%4",_side,faction _unit,round _val,round time]);*/

	RYD_JR_RepEvents pushBack _event;	
		
	if ((random 100) > 90) then
		{
		sleep (random 1);
		RYD_JR_LastChat = time;
		TitleText ["","PLAIN DOWN",0];
		_sht = RYD_JR_KillShouts select (floor (random (count RYD_JR_KillShouts)));
		TitleText [_sht,"PLAIN DOWN", 0];
		sleep 5;
		TitleText ["","PLAIN DOWN",0];
		};

	if (({alive _x} count (units (group player))) > 1) then
		{	
		if ((time - RYD_JR_LastChat) > (30 + (random 30))) then
			{
			if ((random 100) < 50) then
				{	
				if (_val > 0) then
					{
					if ((count RYD_JR_ChattingGoodRep) < 1) then
						{
						RYD_JR_ChattingGoodRep = +RYD_JR_ChattingGoodRep0
						};
						
					_text = RYD_JR_ChattingGoodRep select (floor (random (count RYD_JR_ChattingGoodRep)));

					_units = (units (group player)) - [player];
					_unit = _units select (floor (random (count _units)));
					
					RYD_JR_ChattingGoodRep = RYD_JR_ChattingGoodRep - [_text];
					
					_text = (name _unit) + ": " + _text;
						
					RYD_JR_LastChat = time;
					
					[_text] spawn
						{
						_text = _this select 0;
						sleep (3 + (random 5));
						titleText [_text,"PLAIN DOWN", 2];
						}					
					}
				else
					{
					if ((count RYD_JR_ChattingBadRep) < 1) then
						{
						RYD_JR_ChattingBadRep = +RYD_JR_ChattingBadRep0
						};
						
					_text = RYD_JR_ChattingBadRep select (floor (random (count RYD_JR_ChattingBadRep)));
					
					_units = (units (group player)) - [player];
					_unit = _units select (floor (random (count _units)));
					
					RYD_JR_ChattingBadRep = RYD_JR_ChattingBadRep - [_text];
					
					_text = (name _unit) + ": " + _text;
						
					RYD_JR_LastChat = time;
					
					[_text] spawn
						{
						_text = _this select 0;
						sleep (3 + (random 5));
						titleText [_text,"PLAIN DOWN", 2];
						}
					}
				};
			}
		}
	};
		