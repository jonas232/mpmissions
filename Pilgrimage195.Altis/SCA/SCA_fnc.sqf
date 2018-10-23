RYD_SCA_Fired = 
	{
	private ["_unit","_dst"];
	
	_unit = _this select 0;
	
	if ((time - (RYD_SCA_LastFire select 0)) > 2) then
		{

			{
			_dst = _x distance _unit;
			
			if ((random 450) > _dst) then
				{
				_x setVariable ["RYD_SCA_inPanic",time];
				_x forceSpeed -1;
				_x doWatch _unit;
				if ((random 1) < 0.3) then
					{
					_x setUnitPos "MIDDLE"
					}
				};

			}
		foreach RYD_SCA_NearCivilians;

		RYD_SCA_LastFire = [time,_unit];
		};
		
	true
	};	

RYD_SCA_Spawn = 
	{
	private ["_cnt","_side","_posTaken","_spawnPos","_type","_gp","_civ","_ct","_positions0","_hostile","_positions","_posAct","_tkn"];
	
	_cnt = _this select 0;
	
	//if ((count _this) > 1) then {_side = _this select 1};
	
	_posTaken = missionnameSpace getVariable ["PosTaken",[]];
	_positions = [];
	
	RYD_SCA_Spawning = true;
	
	_positions0 = RYD_SCA_Positions;
	
		{
		_posAct = _x;
		_tkn = false;

			{
			if (_x isEqualTo _posAct) exitWith {_tkn = true}
			}
		foreach _posTaken;

		if not (_tkn) then
			{
			_positions pushBack _posAct
			}
		}
	foreach _positions0;
	
	if ((count _positions) < 1) exitWith {RYD_SCA_Spawning = false};
	
	for "_i" from 1 to _cnt do
		{
		_side = civilian;
		_hostile = false;

		if (RYD_SCA_HostileToSpawn > 0) then
			{
			_side = resistance;												
			_count = {(side _x) == _side} count allGroups;
			if (_count > RYD_JR_GLimit) exitWith {_side = civilian};
			_hostile = true;
			RYD_SCA_HostileToSpawn = (RYD_SCA_HostileToSpawn - 1) max 0
			}
		else
			{
			if (RYD_SCA_FriendlyToSpawn > 0) then
				{
				_side = west;						
				_count = {(side _x) == _side} count allGroups;
				if (_count > RYD_JR_GLimit) exitWith {_side = civilian};
				RYD_SCA_FriendlyToSpawn = (RYD_SCA_FriendlyToSpawn - 1) max 0
				}
			};	
		
		_posTaken = missionnameSpace getVariable ["PosTaken",[]];		
		_ix = floor (random (count _positions));
		_spawnPos = +(_positions select _ix);

		_posTaken pushBack _spawnPos;
		missionNamespace setVariable ["PosTaken",_posTaken];
		
		_type = RYD_SCA_CivilianClasses select (floor (random (count RYD_SCA_CivilianClasses)));

		_gp = createGroup _side;
		_civ = _gp createUnit [_type,_spawnPos, [], 0, "NONE"];

		if not (isNull _civ) then
			{
			_reputation = [true,_civ] call RYD_JR_CalculateRep;

			_civ setVariable ["RYD_JR_Reputation",_reputation];
			
			switch (true) do
				{	
				case (_reputation < -50) :
					{
					if ((random 100) < (((-50 - _reputation) min 50) max 5)) then
						{
						RYD_SCA_HostileToSpawn = RYD_SCA_HostileToSpawn + 1;
						}
					};
					
				case (_reputation > 50) :
					{
					if ((random 100) < (((_reputation - 50) min 50) max 5)) then
						{
						RYD_SCA_FriendlyToSpawn = RYD_SCA_FriendlyToSpawn + 1
						}
					}
				};		
			
			removeUniform _civ;
			removeAllWeapons _civ;
			
			if ((toLower (headGear _civ)) in ["h_racinghelmet_1_f","h_racinghelmet_2_f","h_racinghelmet_3_f","h_racinghelmet_4_f","h_cap_marshal"]) then
				{
				removeHeadgear _civ
				};			
			
			_civ addUniform (RYD_SCA_Clothes select (floor (random (count RYD_SCA_Clothes))));
			removeAllAssignedItems _civ;		
			
			_positions set [_ix,0];
			_positions = _positions - [0];
			
			RYD_SCA_Civilians pushBack _civ;
			
			if not (_side isEqualTo civilian) then
				{
				_civ setVariable ["RYD_SCA_Armed",true];
				_weap = RYD_SCA_CivWeapons select (floor (random (count RYD_SCA_CivWeapons)));
				_mags = configFile >> "CfgWeapons" >> _weap >> "magazines";
				
				if ((isArray _mags) and {(count (getArray _mags)) > 0}) then
					{
					_mags = getArray _mags;
					_mag = _mags select 0;
					
					_civ addMagazines [_mag, 3 + (floor (random 6))];
					_civ addWeapon _weap;
					
						{
						_civ setSkill [_x,0.01 + (random 0.05)];
						}
					foreach ["aimingShake","spotDistance","spotTime","reloadSpeed"];
					
					if (_hostile) then
						{
						_civ setVariable ["RYD_SCA_Hostile",true]
						}
					};
					
				_wp = _gp addWaypoint [(position _civ), 50];
				_wp setWaypointType "SAD";
				_wp setWaypointBehaviour "SAFE";
				_wp setWaypointCombatMode "RED";
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointTimeout [10,30,600];
				
				_wp = _gp addWaypoint [(position _civ), 0];
				_wp setWaypointType "CYCLE";							
				}
			else
				{
				_civ setSkill 0;			
				_gp setBehaviour "CARELESS";
				};
		 
			_civ setSpeaker format ["Male0%1GRE",ceil (random 5)];			
			_civ setVariable ["RYD_SCA_MyHome",_spawnPos];
			
			if (RYD_JR_Debug) then
				{				
				_cl = switch (_side) do
					{
					case (west) : {"colorBlue"};
					case (resistance) : {"colorRed"};
					default {"colorYellow"};
					};
				
				_m = "VMark_" + (str _spawnPos) + (str (random 100));
				_m = createMarker [_m,_spawnPos];
				_m setMarkerColor _cl;
				_m setMarkerShape "ICON";
				_m setMarkerType "mil_triangle";
				_m setMarkerSize [0.5,0.5];
				
				_civ setVariable ["RYD_SCA_MyMark",_m];
				};
			
			_civ setDir (random 360);
			
			sleep 0.2;
			}
		else
			{
			deleteGroup _gp
			};
			
		if ((count _positions) < 1) exitWith {}
		};
		
	RYD_SCA_Spawning = false;
	};
	
RYD_SCA_RandomAround = 
	{//based on Muzzleflash' function
	private ["_pos","_xPos","_yPos","_a","_dir","_angle","_mag","_nX","_nY","_temp"];

	_pos = _this select 0;
	_a = _this select 1;

	_xPos = _pos select 0;
	_yPos = _pos select 1;

	_dir = random 360;

	_mag = sqrt ((random _a) * _a);
	_nX = _mag * (sin _dir);
	_nY = _mag * (cos _dir);

	_pos = [_xPos + _nX, _yPos + _nY,_pos select 2];  

	_pos	
	};
	
RYD_SCA_BPos = 
	{
	private ["_pos","_Bldngs","_posTaken","_posAll","_posAllB","_Bldg","_posAct","_ct","_tkn","_all","_ix","_isRoof","_limit"];
	
	_pos = _this select 0;
	_Bldngs = _this select 1;
	_limit = _this select 2;
	
	_posTaken = (missionnameSpace getVariable ["PosTaken",[]]);
	_posAll = [];

		{
		_all = [];
		_posAllB = [];
		_Bldg = _x;

		if not (isNull _Bldg) then
			{
			_posAct = _Bldg buildingpos 0;
			_ct = 0;

			while {((_posAct distance [0,0,0]) > 1)} do 
				{
				_all pushBack _posAct;
				_ct = _ct + 1;
				if (_ct > 100) exitWith {};
				_posAct = _Bldg buildingpos _ct;
				};
				
			while {((count _posAllB) < 3)} do
				{
				_ix = floor (random (count _all));
				_posAct = _all select _ix;
				
				_tkn = false;

					{
					if (_x isEqualTo _posAct) exitWith {_tkn = true}
					}
				foreach _posTaken;

				if not (_tkn) then
					{
					_isRoof = [ATLtoASL _posAct,4] call RYD_SCA_RoofOver;
					if (_isRoof) then
						{
						_posAllB pushBack _posAct
						}
					};
				
				_all set [_ix,0];
				_all = _all - [0];
				
				if ((count _all) < 1) exitWith {};
				}
			};
					
			{
			_posAll pushBack _x
			}
		foreach _posAllB;
		
		if ((count _posAll) > _limit) exitWith {}
		}
	foreach _Bldngs;
	
	
	_posAll
	};
	
RYD_SCA_AllFromSide = 
	{
	private ["_side","_class","_scope","_isMan","_units","_gm"];
	
	_units = [];
	
	_vehs = configFile >> "CfgVehicles";
	
	for "_i" from 0 to ((count _vehs) - 1) do
		{
		_class = _vehs select _i;
		
		if (isClass _class) then
			{
			_class = configName _class;
			_scope = getNumber (_vehs >> _class >> "scope");
			
			if (_scope > 1) then
				{
				_side = getNumber (_vehs >> _class >> "side");
				
				if (_side == 3) then
					{
					_isMan = (_vehs >> _class >> "isMan");
					
					if (isNumber _isMan) then
						{
						_isMan = getNumber _isMan;
						
						if (_isMan in [1]) then
							{
							_dlc = _vehs >> _class >> "DLC";
							if (not (isText _dlc) or {not ((toLower (getText _dlc)) isEqualTo "kart")}) then
								{
								_units pushBack _class
								}
							}
						}
					}
				}
			}
		};

	_units
	};
	
RYD_SCA_RoofOver = 
	{
	private ["_pos","_cam","_target","_pX","_pY","_pZ","_pos1","_pos2","_level","_roofed"];

	_pos = _this select 0;
	_level = _this select 1;

	_pX = _pos select 0;
	_pY = _pos select 1;
	_pZ = (_pos select 2) + 1;

	_pos1 = [_pX,_pY,_pZ];
	_pos2 = [_pX,_pY,_pZ + _level];

	_cam = objNull;

	if ((count _this) > 2) then {_cam = _this select 2};

	_target = objNull;

	if ((count _this) > 3) then {_target = _this select 3};

	_roofed = lineintersects [_pos1, _pos2,_cam,_target]; 

	_roofed
	};
	
RYD_SCA_LOSCheck = 
	{
	private ["_pos1","_pos2","_tint","_lint","_isLOS","_cam","_target","_pX1","_pY1","_pX2","_pY2","_pos1ATL","_pos2ATL"];

	_pos1 = _this select 0;
	_pos2 = _this select 1;

	_pX1 = _pos1 select 0;
	_pY1 = _pos1 select 1;

	_pX2 = _pos2 select 0;
	_pY2 = _pos2 select 1;

	_pos1ATL = [_pX1,_pY1,1.5];
	_pos2ATL = [_pX2,_pY2,1.5];

	_cam = objNull;

	if ((count _this) > 2) then {_cam = _this select 2};

	_target = objNull;

	if ((count _this) > 3) then {_target = _this select 3};

	_tint = terrainintersect [_pos1ATL, _pos2ATL]; 
	_lint = lineintersects [_pos1, _pos2,_cam,_target]; 

	_isLOS = true;

	if ((_tint) or (_lint)) then {_isLOS = false};

	_isLOS
	};
	
RYD_SCA_GaussB = 
	{
	private ["_valMin","_valMax","_acc","_cnt","_rndmzd","_value"];

	_valMin = 0;
	_valMax = _this select 0;
	_acc = 12;

	if ((count _this) > 1) then {_valMin = _this select 1};
	if ((count _this) > 2) then {_acc = _this select 2};

	if (_acc <= 0) then {_acc = 100};

	_rndmzd = 0;
	_cnt = 0;

	while {(_cnt < _acc)} do
		{
		_rndmzd = _rndmzd + ((random _valMax)/_acc);
		_cnt = _cnt + 1
		};

	_value = _valMin + _rndmzd;
	_value
	};
	