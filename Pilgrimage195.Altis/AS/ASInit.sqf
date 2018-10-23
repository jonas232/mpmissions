call compile preprocessfile "AS\AS_fnc.sqf";
	
_artillery = _this select 0;
_targets = _this select 1;
_engageRange = _this select 2;
_sector = _this select 3;
_dispersion = _this select 4;
_reammo = _this select 5;
_interval = _this select 6;
_wildFire = _this select 7;
_dbg = _this select 8;

if not (isNil "RYD_AS_Termopile") then {_wildFire = RYD_AS_Termopile};
RYD_AS_Cerberus = _artillery;
RYD_AS_Hostiles = _targets;
RYD_AS_DbgText = "A";
if (_wildFire) then {RYD_AS_DbgText = "THIS IS SPARTA!"};

RYD_AS_NormalAim = ["B_HMG_01_A_F","B_HMG_01_F","O_HMG_01_A_F","O_HMG_01_F","I_HMG_01_A_F","I_HMG_01_F","B_HMG_01_high_F","O_HMG_01_high_F","I_HMG_01_high_F"];
	
	{
	_gun = _x;
	{_gun disableAI _x} foreach ["MOVE","ANIM","TARGET","AUTOTARGET"];
	_gun setCombatMode "BLUE";
	_decoy = [_gun,_dbg] call RYD_AS_CreateDecoy;
	_gun setVariable ["RYD_AS_MyDecoy",_decoy];
	} 
foreach _artillery;

if (_dbg) then {addMissionEventHandler ["Draw3D",RYD_AS_Debug3D]};

RYD_AS_Active = true;
RYD_AS_Pause = true;

while {RYD_AS_Active} do
	{
	waitUntil
		{
		sleep 0.1;
		
		not (RYD_AS_Pause)
		};
			
	if not (isNil "RYD_AS_Targets") then {_targets = RYD_AS_Targets;RYD_AS_Hostiles = _targets};
	if (isNil "RYD_AS_SmartTargeting") then {RYD_AS_SmartTargeting = false};
	_targets = _targets - [0];
	
		{
		_tgt = _x;
		switch (true) do
			{
			case (isNil "_tgt") : {_targets set [_foreachIndex,0]};
			case not ((typeName _tgt) in [typename objNull]) : {_targets set [_foreachIndex,0]};
			case (isNull _tgt) : {_targets set [_foreachIndex,0]};
			case not (alive _tgt) : {_targets set [_foreachIndex,0]};
			}
		}
	foreach _targets;
	
	_targets = _targets - [0];
		
		{
		_gun = _x;
		switch (true) do
			{
			case (isNil "_gun") : {_artillery set [_foreachIndex,0]};
			case not ((typeName _gun) in [typename objNull]) : {_artillery set [_foreachIndex,0]};
			case (isNull _gun) : {_artillery set [_foreachIndex,0]};
			case not (alive _gun) : {_artillery set [_foreachIndex,0]};
			case (isNull (gunner _gun)) : {_artillery set [_foreachIndex,0]};
			case not (alive (gunner _gun)) : {_artillery set [_foreachIndex,0]};
			case (RYD_AS_SmartTargeting) : 
				{
				if not (_gun getVariable ["RYD_AC_FEHAdded",false]) then
					{
					_gun setVariable ["RYD_AC_FEHAdded",true];
					_gun addEventHandler ["Fired",{nul = _this spawn RYD_AS_FBReport}]
					}
				}
			}
		}
	foreach _artillery;
	
	_artillery = _artillery - [0];
		
	RYD_AS_Cerberus = _artillery;
	
	//if ((count _targets) < 1) exitWith {};
	if ((count _artillery) < 1) exitWith {};
	
	if ((count _targets) > 0) then
		{
			{
			if not (_x getVariable ["RYD_AS_Disabled",false]) then
				{
				if (_x getVariable ["RYD_AS_FireDone",true]) then
					{
					_x setVariable ["RYD_AS_FireDone",false];
						
					if (_x getVariable ["RYD_AS_Mobile",false]) then
						{
						_x forceSpeed -1;
						_x enableAI "ANIM";
						_x enableAI "MOVE"
						}
					else
						{
						_x forceSpeed 0;
						_x disableAI "ANIM";
						_x disableAI "MOVE"
						};
					
					[_x,+_targets,_engageRange,_sector,_dispersion,_reammo,_interval,_wildFire] spawn
						{
						_gun = _this select 0;
						_targets = _this select 1;
						_engageRange = _this select 2;
						_sector = _this select 3;
						_dispersion = _this select 4;
						_reammo = _this select 5;
						_interval = _this select 6;
						
						_wildFire = _gun getVariable ["RYD_AS_Termopile",_this select 7];
						
						sleep (_interval + (random (_interval/2)));

						_tgt = [_gun,_targets,_engageRange,_sector] call RYD_AS_SelectTarget;

						if not (isNull _tgt) then
							{
							_gun setVariable ["RYD_AS_CT",_tgt];
							[_gun,_tgt,_reammo,_dispersion,_wildFire] spawn RYD_AS_Fire
							}
						else
							{
							(gunner _gun) doWatch objNull;
							_gun setVariable ["RYD_AS_LastTarget",[objNull,0]];
							_gun setVariable ["RYD_AS_FireDone",true]
							}
						}
					}
				}
			}
		foreach _artillery;
		}
	};
