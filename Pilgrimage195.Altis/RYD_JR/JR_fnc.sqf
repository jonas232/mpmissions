RYD_JR_FindClosestWithIndex = 
	{
	private ["_ref","_objects","_closest","_dstMin","_dstAct","_index","_clIndex","_clst","_act"];

	_ref = _this select 0;
	_objects = +(_this select 1);
	
		{
		if ((typename _x) in [(typename 0),(typename "")]) then
			{
			_objects set [_foreachIndex,0]
			}
		}
	foreach _objects;
	
	_objects = _objects - [0];

	_closest = objNull;
	_clIndex = 0;

	if ((count _objects) > 0) then 
		{
		_closest = _objects select 0;
		_clst = _closest;
		if ((typeName _clst) == (typename grpNull)) then {_clst = vehicle (leader _clst)};
		_index = 0;
		_clIndex = 0;
		_dstMin = _ref distance _clst;

			{
			_act = _x;
			if ((typeName _act) == (typename grpNull)) then {_act = vehicle (leader _act)};
			_dstAct = _ref distance _act;

			if (_dstAct < _dstMin) then
				{
				_closest = _x;
				_dstMin = _dstAct;
				_clIndex = _index
				};

			_index = _index + 1
			}
		foreach _objects
		};

	[_closest,_clIndex]
	};

RYD_JR_DistOrd = 
	{
	private ["_array","_point","_final","_closest","_ix","_clst","_ct","_am"];

	_array = _this select 0;
	_point = _this select 1;

	_final = [];
	
	_am = count _array;
	_ct = 0;

	while {(({not ((typeName _x) in [(typeName "")])} count _array) > 0)} do
		{
		_closest = [_point,_array] call RYD_JR_FindClosestWithIndex;
		_ix = _closest select 1;
		_closest = _closest select 0;
		_clst = _closest;
		if ((typeName _clst) == (typename grpNull)) then {_clst = vehicle (leader _clst)};

		_final pushBack _closest;

		_array set [_ix,0];
		_array = _array - [0];
		
		_ct = _ct + 1;
		
		if (_ct > (_am + 1)) exitWith {}
		};

	_final
	};

RYD_JR_AngTowards = 
	{
	private ["_source0", "_target0", "_rnd0","_dX0","_dY0","_angleAzimuth0"];

	_source0 = _this select 0;
	_target0 = _this select 1;
	_rnd0 = _this select 2;

	_dX0 = (_target0 select 0) - (_source0 select 0);
	_dY0 = (_target0 select 1) - (_source0 select 1);

	_angleAzimuth0 = (_dX0 atan2 _dY0) + (random (2 * _rnd0)) - _rnd0;

	_angleAzimuth0
	};

RYD_JR_RandomAround = 
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

	_pos = [_xPos + _nX, _yPos + _nY,0];  

	_pos	
	};
	
RYD_JR_RandomAroundMM = 
	{//based on Muzzleflash' function
	private ["_pos","_xPos","_yPos","_a","_b","_dir","_angle","_mag","_nX","_nY","_temp"];

	_pos = _this select 0;
	_a = _this select 1;
	_b = _this select 2;
	
	_b = _b - _a;

	_xPos = _pos select 0;
	_yPos = _pos select 1;

	_dir = random 360;

	_mag = _a + (sqrt ((random _b) * _b));
	_nX = _mag * (sin _dir);
	_nY = _mag * (cos _dir);

	_pos = [_xPos + _nX, _yPos + _nY,0];  

	_pos	
	};

RYD_JR_RandomOrd = 
	{
	private ["_array","_final","_random","_select","_am","_ct"];

	_array = _this select 0;

	_final = [];
	_am = count _array;
	_ct = 0;

	while {((count _array) > 0)} do
		{
		_ct = _ct + 1;
		_select = floor (random (count _array));
		_random = _array select _select;
		_final pushBack _random;

		_array set [_select,0];
		_array = _array - [0];
		
		if (_ct > _am + 1) exitWith {}
		};

	_final
	};
	
RYD_JR_NearestCross = 
	{
	private ["_crosses","_pos","_chosen","_dist","_distC"];
	_crosses = _this select 0;
	_pos = _this select 1;

	_chosen = _crosses select 0;
	_distC = (getPosASL _chosen) distance _pos;

		{
		_dist = (getPosASL _x) distance _pos;
		if (_dist <_distC) then {_chosen = _x;_distC = _dist} 
		}
	foreach _crosses;
	
	_chosen
	};

RYD_JR_CrossroadsNear = 
	{
	private ["_pos","_radius","_roads","_cross"];

	_pos = _this select 0;
	_radius = _this select 1;

	_roads = _pos nearRoads _radius;
	_cross = [];

		{
		if (count (roadsConnectedTo _x) > 2) then {_cross pushBack _x};
		}
	foreach _roads;

	_cross
	};
	
RYD_JR_CigaretteTime = 
	{
	_gp = _this select 0;
		
	_cTime = _gp getVariable ["RYD_JR_CTime",[0,0]];
		
	sleep ((_cTime select 0) + (random (_cTime select 1)));
	
	(units _gp) allowGetIn true;
	(units _gp) orderGetIn true;
	if not (isPlayer (leader _gp)) then {{(assignedVehicle _x) setFuel 1} foreach (units _gp)};
	
	_ct = time;
	
	waituntil
		{
		sleep 5;
		(((({(_x == (vehicle _x))} count (units _gp)) == 0) or ((time - _ct) > 60)) and (isNull ((leader _gp) findNearestEnemy (leader _gp))))
		};
		
		{
		if ((vehicle _x) == _x) then
			{
			_x moveInCargo (assignedVehicle _x)
			}
		}
	foreach (units _gp);
	
	_gp setCurrentWaypoint [_gp,(currentWaypoint _gp) + 1];
	};

RYD_JR_RoadPatrol = 
	{
	private ["_uG","_type","_beh","_CM","_speed","_form","_stat","_cyclic","_radius","_minTO","_addTO","_deleteAll","_Centrum","_nC","_points","_cross","_pos","_WPs","_points2","_next","_wp","_locs","_ct"];
	_uG = _this select 0;

	_type = "UNLOAD";
	//if not (canFire (assignedVehicle (leader _uG))) then {_type = "GETOUT"};
	if ((count _this) > 1) then {_type = _this select 1};
	_beh = "SAFE";
	if ((count _this) > 2) then {_beh = _this select 2};
	_CM = "YELLOW";
	if ((count _this) > 3) then {_CM = _this select 3};
	_speed = "LIMITED";
	if ((count _this) > 4) then {_speed = _this select 4};
	_form = "COLUMN";
	if ((count _this) > 5) then {_form = _this select 5};
	_stat = ["true",""];
	if ((count _this) > 6) then {_stat = _this select 6};
	_cyclic = true;
	if ((count _this) > 7) then {_cyclic = _this select 7};
	_radius = 1000;
	if ((count _this) > 8) then {_radius = _this select 8};
	_minTO = 60;
	if ((count _this) > 9) then {_minTO = _this select 9};
	_addTO = 120;
	if ((count _this) > 10) then {_minTO = _this select 10};
	_deleteAll = true;
	if ((count _this) > 11) then {_deleteAll = _this select 11};
	
	_uG setVariable ["RYD_JR_CTime",[_minTO,_addTO]];

	if (_deleteAll) then 
		{
		_ct = count (waypoints _uG);
		while {((count (waypoints _uG)) > 0)} do
			{
			deleteWaypoint ((waypoints _uG) select (count (waypoints _uG) - 1));
			_ct = _ct - 1;
			if (_ct < -2) exitWith {}
			}
		}
	else
		{
		deleteWaypoint ((waypoints _uG) select 0);
		};

	_Centrum = getPosATL (vehicle (leader _uG));

	_WPs = [];

	_locs = nearestLocations [_Centrum, ["NameVillage","NameCity","NameCityCapital"], _radius];
	
	while {((count _locs) < 4) and (_radius < 6000)} do
		{
		_radius = _radius + 1000;
		_locs = nearestLocations [_Centrum, ["NameVillage","NameCity","NameCityCapital"], _radius]
		};
	
	if ((count _locs) < 1) exitWith {_WPs};
	
		{
		if ((tolower (text _x)) in ["sagonisi"]) exitWith {_locs set [_foreachIndex, 0]}
		}
	foreach _locs;
	
	_locs = _locs - [0];
	
	_ref = [_Centrum,_locs] call RYD_JR_FindClosest;
	_locs = _locs - [_ref];
	_nC = [_ref];
	_ct = count _locs;
	
	while {(count _locs) > 0} do
		{
		_ref = [_ref,_locs] call RYD_JR_FindClosest;
		_locs = _locs - [_ref];
		_nC pushBack _ref;
		_ct = _ct - 1;
		if (_ct < -2) exitWith {}
		};
	
	if ((count _nC) > 0) then
		{
		_points = [];

			{
			_cross = objNull;
			_nCross = [(position _x),500] call RYD_JR_CrossroadsNear;
			if ((count _nCross) > 0) then
				{
				_cross = [[(position _x),500] call RYD_JR_CrossroadsNear,(position _x)] call RYD_JR_NearestCross;
				};
				
			_pos = position _x;
			if not (isNull _cross) then {_pos = position _cross};
			_points pushBack _pos
			}
		foreach _nC;

		_points2 = +_points;

			{
			_next = _points2 select 0;
			_points2 set [0,0];
			_points2 = _points2 - [0];
			
			_wp = _uG addWaypoint [_next, 0];
			_wp setWaypointType _type;
			_wp setWaypointBehaviour _beh;
			_wp setWaypointCombatMode _CM;
			_wp setWaypointSpeed _speed;
			_wp setWaypointFormation _form;
			_wp setWaypointStatements ["true","nul = [(group this)] spawn RYD_JR_CigaretteTime"];
			//_wp setWayPointTimeOut [10,15,20];
			
			_wp = _uG addWaypoint [_next, 0];
			_wp setWaypointType "DISMISS";
			_wp setWaypointBehaviour "AWARE";
			_wp setWaypointCombatMode _CM;
			_wp setWaypointSpeed _speed;
			_wp setWaypointFormation _form;
			_wp setWaypointStatements ["false",""];
			//_wp setWayPointTimeOut [_minTO,(_minTO +_addTO)/2, _addTO];

			_WPs pushBack _wp;
			}
		foreach _points;

		if (_cyclic) then 
			{
			_wp = _uG addWaypoint [(_points select 0), 0];
			_wp setWaypointType "CYCLE";
			_wp setWaypointBehaviour _beh;
			_wp setWaypointCombatMode _CM;
			_wp setWaypointSpeed _speed;
			_wp setWaypointFormation _form;
			//_wp setWaypointStatements _stat;

			_WPs pushBack _wp;
			};

		//_uG setCurrentWaypoint (_WPs select 0)
		};

	_WPs
	};
		
RYD_JR_SADPatrol = 
	{
	private ["_unit","_uG","_protected","_type","_beh","_CM","_speed","_form","_stat","_cyclic","_rMin","_rMax","_acc","_minA","_maxA","_deleteAll","_points","_points2","_WPs","_wp","_playerCentric","_ct","_am"];

	_unit = ObjNull;
	_uG = GrpNull;

	if ((typeName (_this select 0)) == 'OBJECT') then 
		{
		_unit = _this select 0;
		_uG = group _unit;
		} 
	else 
		{
		_uG = _this select 0;
		_unit = leader (_uG)
		};
		
	_protected = _this select 1;
	_type  = "SAD";
	if ((count _this) > 2) then {_type = _this select 2};
	_beh = "AWARE";
	if ((count _this) > 3) then {_beh = _this select 3};
	_CM = "YELLOW";
	if ((count _this) > 4) then {_CM = _this select 4};
	_speed = "NORMAL";
	if ((count _this) > 5) then {_speed = _this select 5};
	_form = "FILE";
	if ((count _this) > 6) then {_form = _this select 6};
	_stat = ["true","if not (isPlayer this) then {{(assignedVehicle _x) setFuel 1} foreach thislist};"];
	if ((count _this) > 7) then {_stat = _this select 7};
	_cyclic = true;
	if ((count _this) > 8) then {_cyclic = _this select 8};
	_rMin = 300;
	if ((count _this) > 9) then {_rMin = _this select 9};
	_rMax = 600;
	if ((count _this) > 10) then {_rMax = _this select 10};
	_acc = 0;
	if ((count _this) > 11) then {_acc = _this select 11};
	_minA = 2;
	if ((count _this) > 12) then {_minA = _this select 12};
	_maxA = 5;
	if ((count _this) > 13) then {_maxA = _this select 13};
	_deleteAll = true;
	if ((count _this) > 14) then {_deleteAll = _this select 14};
	_playerCentric = false;
	if ((count _this) > 15) then {_playerCentric = _this select 15};
	
	if (_playerCentric) then
		{
		_unit = player
		};

	if (_deleteAll) then 
		{
		_am = count (waypoints _uG);
		_ct = 0;
		while {((count (waypoints _uG)) > 0)} do
			{
			deleteWaypoint ((waypoints _uG) select (count (waypoints _uG) - 1));
			_ct = _ct + 1;
			if (_ct > (_am + 1)) exitWith {}
			}
		}
	else
		{
		deleteWaypoint ((waypoints _uG) select 0);
		};

	_points = [_protected];
	_points2 = [_unit,_rMin,_rMax,_minA,_maxA] call RYD_JR_RandomPointsAroundB;
	_points = _points + _points2;
	_WPs = [];

		{
		_wp = _uG addWaypoint [_x, _acc];
		_wp setWaypointType _type;
		_wp setWaypointBehaviour _beh;
		_wp setWaypointCombatMode _CM;
		_wp setWaypointSpeed _speed;
		_wp setWaypointFormation _form;
		_wp setWaypointStatements _stat;

		_WPs pushBack _wp;
		}
	foreach _points;

	if (_cyclic) then 
		{
		_wp = _uG addWaypoint [(_points select 0), _acc];
		_wp setWaypointType "CYCLE";
		_wp setWaypointBehaviour _beh;
		_wp setWaypointCombatMode _CM;
		_wp setWaypointSpeed _speed;
		_wp setWaypointFormation _form;
		_wp setWaypointStatements _stat;

		_WPs pushBack _wp;
		};

	_uG setCurrentWaypoint (_WPs select 0);

	_WPs
	};
		
RYD_JR_RandomPointsAroundB = 
	{
	private ["_sourceP","_radiusMin","_radiusMax","_min","_above","_points","_minPC","_point","_posX","_posY","_pos","_ct"];
	
	_sourceP = [];

	if ((typeName (_this select 0)) == 'OBJECT') then 
		{
		_sourceP = getPosASL (_this select 0);
		} 
	else 
		{
		_sourceP = _this select 0;
		};

	_radiusMin = _this select 1;
	_radiusMax = _this select 2;
	_min = _this select 3;
	_above = _this select 4;

	_points = [];
	_minPC = _min + (round (random _above));
	_ct = 0;
	
	//for "_j" from 1 to _minPC do
	while {((count _points) < _minPC)} do
		{
		_point = [_sourceP,_radiusMin,_radiusMax] call RYD_JR_RandomAroundMM;
		_posX = _point select 0;
		_posY = _point select 1;
		_pos = [_posX,_posY];
		
		_pos = [_pos,0,_radiusMin/3,2,0,(_radiusMin/6) max 2,0] call BIS_fnc_findSafePos;

		_points pushBack _pos;
		_ct = _ct + 1;
		if (_ct > (_minPC + 1)) exitWith {}
		};

	_points
	};
	
RYD_JR_CreateBox = 
	{
	_pos = _this select 3;
	_stash = true;
	
	if ((count _pos) < 2) then
		{
		_stash = false;
		_pos = (vehicle player) modelToWorld [0,2,0];
		};
		
	_pos set [2,0.02];
			
	if (_stash) then
		{
		[[_pos],true,-1] call RYD_JR_AddLoot
		}
	else
		{
		_holder = createVehicle ["Box_IND_Support_F", _pos, [], 0, "NONE"];

		RYD_JR_BoxCreated = [_holder];
		_holder setDir ((getDir player) + 90);
		
		clearItemCargo _holder;
		clearWeaponCargo _holder;
		clearMagazineCargo _holder;
		
		_aID = _holder addAction ["<t color='#d0a900'>Sell content</t>", "SellCargoB.sqf", true, 1, false, true, "", ""];
		}
	};
		
RYD_JR_AddLoot = 
	{
	private ["_places","_pos","_intelC","_holderType","_holder","_rnd","_amnt","_am","_stuff","_allStuff","_stuffArr","_anchor","_holders","_aID","_txt","_val","_betterLoot","_stoper","_chance","_addAmmo","_wpC","_ammoC","_im"];

	_places = _this select 0;
	_betterLoot = _this select 1;
	_intelC = 10;
	if ((count _this) > 2) then {_intelC = _this select 2};
		
	_holders = [];
	_stuff = "";
	_holderType = "Box_IND_Support_F";
			
		{
		_rnd = random 100;
		if (_betterLoot) then
			{
			_rnd = _rnd/1.25
			};

		if (_rnd < _intelC) then
			{
			_holderType = RYD_JR_IntelItems select (floor (random (count RYD_JR_IntelItems)));
			_holder = createVehicle [_holderType, _x, [], 0, "CAN_COLLIDE"];
			_stoper = time;
			
			waitUntil 
				{
				_holder setPos _x;
				(((_holder distance _x) < 50) or ((time - _stoper) > 1))
				};
				
			_holders pushBack _holder;

			_holder setDir (random 360);
			
			_aID = _holder addAction ["<t color='#d0a900'>Check the Intel about your brother's death</t>", "IntelCheck.sqf", [false,civilian,"search"], 1, false, true, "", "((player distance _target) < 3)"];
			_holder setVariable ["RYD_JR_RemoveItem",true];
		
		
			if (RYD_JR_GCIntel > 0) then
				{
				if ((random 100) < (0.1 * RYD_JR_GCIntel)) then
					{
					_holder setVariable ["RYD_JR_MoreIntel",true];
					}
				};
								
			}
		else
			{
			_holderType = "Box_IND_Support_F";
			_holder = createVehicle [_holderType, _x, [], 0, "CAN_COLLIDE"];
			_stoper = time;
			
			waitUntil 
				{
				_holder setPos _x;
				(((_holder distance _x) < 50) or ((time - _stoper) > 1))
				};
				
			_holders pushBack _holder;

			_holder setDir (random 360);
			
			_val = 0;

			clearItemCargo _holder;
			clearWeaponCargo _holder;
			clearMagazineCargo _holder;

			_rnd = random 100;
			if (_intelC < 0) then
				{
				_rnd = 100
				};
				
			_amnt = [0,1];
			
			_chance = 30;
			_addAmmo = 0;
			_ammoC = 24;
			_wpC = 4;
			
			if ((RYD_JR_RealLoot) or (_intelC < 0)) then
				{
				_betterLoot = true;
				_chance = 0;
				_addAmmo = 3;
				_ammoC = (24 * RYD_JR_CargoDensityM) max 2;
				_wpC = 4 * RYD_JR_CargoDensityM
				};
			
			if ((_betterLoot) or {RYD_JR_Abundant}) then
				{
				switch (true) do
					{
					case ((_rnd > _chance) and {_betterLoot}) : {_amnt = [(floor (random _wpC)) max 1,(ceil (random _ammoC)) + _addAmmo,floor (random 2)]};
					case (_rnd > 90) : {_amnt = [1,ceil (random 12),0]};
					case (_rnd > 45) : {_amnt = [0,ceil (random 12),0]};
					case (_rnd > 25): 
						{
						_amnt = [0,0,1];
						if ((random 100) > 75) then
							{
							_amnt set [1,ceil (random 6)]
							}
						};
						
					default 
						{
						_amnt = [1,0,0];
						if (RYD_JR_AlwaysAmmo) then
							{
							_amnt set [1,ceil (random 2)]
							}
						};
					};
				}
			else
				{
				switch (true) do
					{
					case (_rnd > 98) : {_amnt = [1,ceil (random 12),0]};
					case (_rnd > 90) : {_amnt = [0,ceil (random 12),0]};
					case (_rnd > 5): 
						{
						_amnt = [0,0,1];
						if ((random 100) > 99) then
							{
							_amnt set [1,ceil (random 6)]
							}
						};
						
					default 
						{
						_amnt = [0,0,1 + (floor (random 3))]
						};
					};				
				};
			
				{
				_am = _amnt select _foreachIndex;
				
				if (_am > 0) then
					{
					_allStuff = _x;
				
					if (_foreachIndex == 1) then
						{
						if ((_amnt select 0) > 0) then
							{
							_stuffArr = configFile >> "CfgWeapons" >> _stuff >> "magazines";
							
							if (isArray _stuffArr) then
								{
								_stuffArr = getArray _stuffArr;
								
								if ((count _stuffArr) > 0) then
									{
									_allStuff = _stuffArr
									}
								}
							}
						};
						
					_stuff = _allStuff select (floor (random (count _allStuff)));

					switch (_foreachIndex) do
						{
						case (0) : {_holder addWeaponCargo [_stuff,_am]};
						case (1) : {_holder addMagazineCargo [_stuff,_am]};
						case (2) : {_holder addItemCargo [_stuff,_am]}
						}
					}
				}
			foreach [RYD_JR_AllWeapons,RYD_JR_AllAmmo,RYD_JR_AllItems];

			_aID = _holder addAction ["<t color='#d0a900'>Sell content</t>", "SellCargo.sqf", true, 1, false, true, "", ""];
			_holder setVariable ["RYD_JR_MyPlace",_x];
			}
		}
	foreach _places;
	
		{
		_holder = _holders select _foreachIndex;
		_intel = _holder getVariable ["RYD_JR_RemoveItem",false];
		if not (_intel) then
			{
			_holder setPos _x;
			}
		else
			{
			_pos = +_x;
			_pos set [2,(_pos select 2) + 0.5];
			_holder setPos _pos;
			}
		}
	foreach _places;
			
	_holders
	};
	
RYD_JR_AddLootSingle = 
	{
	private ["_holder","_rnd","_amnt","_am","_stuff","_allStuff","_stuffArr","_betterLoot","_chance","_addAmmo","_ammoC","_wpC"];

	_holder = _this select 0;
	_betterLoot = _this select 1;

	clearItemCargo _holder;
	clearWeaponCargo _holder;
	clearMagazineCargo _holder;

	_rnd = random 100;
	_amnt = [0,1];
	
	_chance = 30;
	_addAmmo = 0;
	_ammoC = 24;
	_wpC = 4;
	
	if (RYD_JR_RealLoot) then
		{
		_chance = 0;
		_addAmmo = 3;
		_ammoC = (24 * RYD_JR_CargoDensityM) max 2;
		_wpC = 4 * RYD_JR_CargoDensityM
		};
	
	switch (true) do
		{
		case ((_betterLoot) and (_rnd > _chance)) : {_amnt = [(floor (random _wpC)) max 1,(ceil (random _ammoC)) + _addAmmo,floor (random 2)]};
		case (_rnd > 90) : {_amnt = [1,ceil (random 12),0]};
		case (_rnd > 45) : {_amnt = [0,ceil (random 12),0]};
		case (_rnd > 25): 
			{
			_amnt = [0,0,1];
			if ((random 100) > 75) then
				{
				_amnt set [1,ceil (random 6)]
				}
			};
			
		default 
			{
			_amnt = [1,0,0];
			if (RYD_JR_AlwaysAmmo) then
				{
				_amnt set [1,ceil (random 2)]
				}
			};
		};

		{
		_am = _amnt select _foreachIndex;
		
		if (_am > 0) then
			{
			_allStuff = _x;
		
			if (_foreachIndex == 1) then
				{
				if ((_amnt select 0) > 0) then
					{
					_stuffArr = configFile >> "CfgWeapons" >> _stuff >> "magazines";
					
					if (isArray _stuffArr) then
						{
						_stuffArr = getArray _stuffArr;
						
						if ((count _stuffArr) > 0) then
							{
							_allStuff = _stuffArr
							}
						}
					}
				};
				
			_stuff = _allStuff select (floor (random (count _allStuff)));

			switch (_foreachIndex) do
				{
				case (0) : {_holder addWeaponCargo [_stuff,_am]};
				case (1) : {_holder addMagazineCargo [_stuff,_am]};
				case (2) : {_holder addItemCargo [_stuff,_am]}
				}
			}
		}
	foreach [RYD_JR_AllWeapons,RYD_JR_AllAmmo,RYD_JR_AllItems];
		
	true
	};
	
RYD_JR_AddLootCustom = 
	{
	private ["_place","_holderType","_loot","_holder","_wps","_mags","_items","_stuff","_allStuff","_ix","_am","_mags","_mag"];

	_place = _this select 0;
	_holderType = _this select 1;
	_loot = _this select 2;
	
	_wps = _loot select 0;
	_mags = _loot select 1;
	_items = _loot select 2;
	
	_holder = createVehicle [_holderType, _place, [], 0, "NONE"];
	
	clearWeaponCargo _holder;
	clearMagazineCargo _holder;
	clearItemCargo _holder;
	clearBackpackCargo _holder;
	
		{
		_allStuff = _x;		
		_ix = _foreachIndex;
	
			{
			_stuff = _x select 0;
			_am = _x select 1;

			if (_am > 0) then
				{
				switch (_ix) do
					{
					case (0) : 
						{
						_holder addWeaponCargo [_stuff,_am];

						_mags = configFile >> "CfgWeapons" >> _stuff >> "magazines";
						
						if (isArray _mags) then
							{
							_mags = getArray _mags;
							
							if ((count _mags) > 0) then
								{
								_mag = _mags select (floor (random (count _mags)));
								_holder addMagazineCargo [_mag,_am * 12]
								}
							}					
						};
						
					case (1) : {_holder addMagazineCargo [_stuff,_am]};
					case (2) : {_holder addItemCargo [_stuff,_am]}
					}
				}
			}
		foreach _allStuff
		}
	foreach _loot;
	
	_holder setPos _place;
		
	_holder
	};
	
RYD_JR_ContentWeight = 
	{
	private ["_holder"];//,"_cw","_wpnC","_vhC","_mgC","_glC","_itemC","_items","_amnts","_info","_wgt","_wpn","_item"];
	
	_holder = _this select 0;
	/*_cw = 0;
	
	_wpnC = configFile >> "CfgWeapons";
	_vhC = configFile >> "CfgVehicles";
	_mgC = configFile >> "CfgMagazines";
	_glC = configFile >> "CfgGlasses";
	
		{
		_itemC = getItemCargo _x;

		_items = _itemC select 0;
		_amnts = _itemC select 1;
		
			{
			_info = _wpnC >> _x >> "WeaponSlotsInfo";
			if (isClass _info) then
				{
				_wgt = _info >> "mass";
				if (isNumber _wgt) then
					{
					_cw = _cw + ((getNumber _wgt) * (_amnts select _foreachIndex))
					}
				}
			else
				{
				_info = _wpnC >> _x >> "ItemInfo";
				if (isClass _info) then
					{
					_wgt = _info >> "mass";
					if (isNumber _wgt) then
						{
						_cw = _cw + ((getNumber _wgt) * (_amnts select _foreachIndex))
						}					
					}
				else
					{
					_wgt = _glC >> _x >> "mass";
					if (isNumber _wgt) then
						{
						_cw = _cw + ((getNumber _wgt) * (_amnts select _foreachIndex))
						}
					else
						{
						_wgt = _vhC >> _x >> "mass";
						if (isNumber _wgt) then
							{
							_cw = _cw + ((getNumber _wgt) * (_amnts select _foreachIndex))
							}						
						}
					}
				}
			}
		foreach _items;	
		}
	foreach [uniformContainer _holder,vestContainer _holder,backPackContainer _holder];		
	
		{
		if not (_x isEqualTo "") then
			{
			_info = _wpnC >> _x >> "WeaponSlotsInfo";
			if (isClass _info) then
				{
				_wgt = _info >> "mass";
				if (isNumber _wgt) then
					{
					_cw = _cw + (getNumber _wgt)
					}
				}
			else
				{
				_info = _wpnC >> _x >> "ItemInfo";
				if (isClass _info) then
					{
					_wgt = _info >> "mass";
					if (isNumber _wgt) then
						{
						_cw = _cw + (getNumber _wgt)
						}					
					}
				else
					{
					_wgt = _glC >> _x >> "mass";
					if (isNumber _wgt) then
						{
						_cw = _cw + (getNumber _wgt)
						}
					else
						{
						_wgt = _vhC >> _x >> "mass";
						if (isNumber _wgt) then
							{
							_cw = _cw + (getNumber _wgt)
							}						
						}
					}
				}
			}
		}
	foreach (assignedItems _holder) + [headGear _holder,uniform _holder,vest _holder,goggles _holder,backPack _holder];
	
		{
		_wpnArr = _x;
		
		_wpn = _wpnArr select 0;

		_wgt = _wpnC >> _wpn >> "WeaponSlotsInfo" >> "mass";

		if (isNumber _wgt) then
			{
			_cw = _cw + (getNumber _wgt)
			};
			
		for "_i" from 1 to ((count _wpnArr) - 1) do
			{
			_item = _wpnArr select _i;
			
			if ((typeName _item) in [typeName []]) then
				{
				_wgt = _mgC >> (_item select 0) >> "mass";
				
				if (isNumber _wgt) then
					{
					_cw = _cw + (getNumber _wgt)
					}
				}
			else
				{
				if not (_item isEqualTo "") then
					{
					_wgt = _wpnC >> _item >> "ItemInfo" >> "mass";
					
					if (isNumber _wgt) then
						{
						_cw = _cw + (getNumber _wgt)
						}
					}
				}
			}			
		}
	foreach (weaponsItems _holder);
	
		{
		_wgt = _mgC >> (_x select 0) >> "mass";
		if (isNumber _wgt) then
			{
			_cw = _cw + (getNumber _wgt)
			}
		}
	foreach (magazinesAmmo _holder);*/
		
	//_cw
	
	loadAbs _holder
	};
	
RYD_JR_SellCargo = 
	{
	_holder = _this select 0;
	_removeH = _this select 3;
	
	if (_removeH) then
		{
		_holder removeAction (_this select 2);
		};
	
	_val = 0;
	
	_wps = [];
	_ammo = [];
	_items = [];
		
	if not (_holder in allDeadMen) then
		{
		_holders = [_holder];
		
			{
			_holders pushBack (_x select 1)
			}
		foreach (everyContainer _holder);
		
			{
			_items pushBack (typeOf _x)
			}
		foreach (everyBackpack _holder);
		
			{
			_hldr = _x;
			
			_itemC = getItemCargo _hldr;
			
				{
				for "_i" from 1 to ((_itemC select 1) select _foreachIndex) do
					{
					_items pushBack _x
					}
				}
			foreach (_itemC select 0);	
			
				{
				_wpnArr = _x;
				
				_wpn = _wpnArr select 0;
				
				if not (_wpn in _items) then
					{
					_wps pushBack (_wpnArr select 0);
					};
					
				for "_i" from 1 to ((count _wpnArr) - 1) do
					{
					_item = _wpnArr select _i;
					
					if ((typeName _item) in [typeName []]) then
						{
						_ammo pushBack _item
						}
					else
						{
						if not (_item isEqualTo "") then
							{
							_items pushBack _item
							}
						}
					}	
				}
			foreach (weaponsItemsCargo _hldr);
			
				{
				_ammo pushBack _x
				}
			foreach (magazinesAmmoCargo _hldr)
			}
		foreach _holders;
		}
	else
		{
			{
			_itemC = getItemCargo _x;
			
				{
				for "_i" from 1 to ((_itemC select 1) select _foreachIndex) do
					{
					_items pushBack _x
					}
				}
			foreach (_itemC select 0);	
			}
		foreach [uniformContainer _holder,vestContainer _holder,backPackContainer _holder];		
		
			{
			if not (_x isEqualTo "") then
				{
				_items pushBack _x
				}
			}
		foreach ((assignedItems _holder) + [headGear _holder,goggles _holder,uniform _holder,vest _holder, backPack _holder]);
		
			{
			_wpnArr = _x;
			_wpn = _wpnArr select 0;
			
			if not (_wpn in _items) then
				{
				_wps pushBack (_wpnArr select 0);
				};
				
			for "_i" from 1 to ((count _wpnArr) - 1) do
				{
				_item = _wpnArr select _i;
				
				if ((typeName _item) in [typeName []]) then
					{
					_ammo pushBack _item
					}
				else
					{
					if not (_item isEqualTo "") then
						{
						_items pushBack _item
						}
					}
				}		
			}
		foreach (weaponsItems _holder);
		
			{
			_ammo pushBack _x
			}
		foreach (magazinesAmmo _holder);
		};
		
	_weapons = [];
	_weaponsA = [];
	
		{
		_wpn = _x;
		if not (_wpn in _weapons) then
			{
			_weapons pushBack _wpn;
			_cnt = {_wpn isEqualTo _x} count _wps;
			
			_weaponsA pushBack _cnt
			}
		}
	foreach _wps;
	
	_ammunition = [];
	_ammunitionA = [];
	_ammunitionC = [];
	
		{
		if ((typeName _x) in [typeName []]) then
			{
			if ((count _x) > 1) then
				{
				_mag = _x select 0;
				if not (_mag in _ammunition) then
					{
					_ammunition pushBack _mag;
					_cnt = {_mag isEqualTo (_x select 0)} count _ammo;
					
					_ammunitionA pushBack _cnt;
					
					_bCnt = 0;
					
						{
						if ((_x select 0) isEqualTo _mag) then
							{
							_bCnt = _bCnt + (_x select 1)
							}
						}
					foreach _ammo;
					
					_ammunitionC pushBack _bCnt
					}
				}
			/*else
				{
				hint format ["mag wrong content: %1",_x];
				diag_log format ["mag wrong content: %1",_x];
				}*/
			}
		/*else
			{
			hint format ["mag wrong content: %1",_x];
			diag_log format ["mag wrong type: %1",_x];
			}*/
		}
	foreach _ammo;
	
	_other = [];
	_otherA = [];
	
		{
		_itm = _x;

		if not (_itm in _other) then
			{
			_other pushBack _itm;
			_cnt = {_itm isEqualTo _x} count _items;
			
			_otherA pushBack _cnt
			}
		}
	foreach _items;

	_desc = "";
	_fx = "";
	
	_vehClass = configFile >> "CfgVehicles";
	_weapClass = configFile >> "CfgWeapons";
	_ammoClass = configFile >> "CfgMagazines";
	_bulletClass = configFile >> "CfgAmmo";
	
		{
		_amt = _weaponsA select _foreachIndex;
		if (_foreachIndex > 0) then {_fx = "_"};

		_val = [_x,_amt,_val] call RYD_JR_WeaponValuation;
			
		_name = "Various";
		if (isText (_weapClass >> _x >> "DisplayName")) then
			{
			_name = getText (_weapClass >> _x >> "DisplayName");
			};
			
		if (_name in [""]) then {_name = "Various"};
		_desc = _desc + _fx + _name + "_" + (str _amt);
		}
	foreach _weapons;
		
	_fx = "";
	
		{
		_mCnt = _ammunitionA select _foreachIndex;
		_bCnt = _ammunitionC select _foreachIndex;
		
		if (_foreachIndex > 0) then {_fx = "_"} else 
			{
			if not (_desc in [""]) then {_desc = _desc + "_"}
			};
			
		_val = [_x,_bCnt,_val] call RYD_JR_AmmoValuation;
			
		_name = "Various";
		if (isText (_ammoClass >> _x >> "DisplayName")) then
			{
			_name = getText (_ammoClass >> _x >> "DisplayName");
			};
			
		if (_name in [""]) then {_name = "Various"};
		_desc = _desc + _fx + _name + "_" + (str _mCnt);
		}
	foreach _ammunition;
		
	_fx = "";
	
		{
		_amt = _otherA select _foreachIndex;
		
		if (_foreachIndex > 0) then {_fx = "_"} else 
			{
			if not (_desc in [""]) then {_desc = _desc + "_"}
			};
					
		_val = [_x,_amt,_val] call RYD_JR_ItemValuation;
					
		_name = "Various";
		if (isText (_weapClass >> _x >> "DisplayName")) then
			{
			_name = getText (_weapClass >> _x >> "DisplayName");
			}
		else
			{
			if (isText (_vehClass >> _x >> "DisplayName")) then
				{
				_name = getText (_vehClass >> _x >> "DisplayName");
				}
			};
			
		if (_name in [""]) then {_name = "Various"};
		_desc = _desc + _fx + _name + "_" + (str (_otherA select _foreachIndex));
		}
	foreach _other;

	if not (_holder in allDeadMen) then
		{	
		clearItemCargo _holder;
		clearWeaponCargo _holder;
		clearMagazineCargo _holder;
		clearBackpackCargo _holder
		}
	else
		{
		removeHeadgear _holder;
		removeGoggles _holder;
		removeAllContainers _holder;
		removeAllWeapons _holder;
		removeAllAssignedItems _holder;
		};
	
	if (_removeH) then
		{
		_posTaken = missionnameSpace getVariable ["PosTaken",[]];
		_lootSpot = _holder getVariable ["RYD_JR_MyPlace",[0,0,0]];

			{
			if (_lootSpot isEqualTo _x) exitWith {_posTaken set [_foreachIndex,0]}
			}
		foreach _posTaken;

		_posTaken = _posTaken - [0];
		
		missionnameSpace setVariable ["PosTaken",_posTaken];
		
		deleteVehicle _holder;
		};
	
	RYD_JR_DM_Count = RYD_JR_DM_Count + 1;
	
	sleep 0.5;
	
	["sonar",3] spawn RYD_JR_Sound3D;
	
	sleep 0.02;
	//diag_log format ["ADMclient - auctioneer: Item '%1' on auction Gattamelata#%2_rapid. Waiting for bidders...",_desc,RYD_JR_DM_Count];
	RYD_JR_Caller customChat [RYD_JR_RadioADMa,format ["Item '%1' on auction Gattamelata#%2_rapid. Waiting for bidders...",_desc,RYD_JR_DM_Count]];
	
	[_val,_desc] spawn
		{
		_val = _this select 0;
		_desc = _this select 1;
				
		_val = round (_val * (0.85 + (random 0.3)));
		
		_val = _val * RYD_JR_CargoValueM;
		
		_val = (ceil (_val/10)) * 10;
		
		sleep (5 + (random 55));
		
		waitUntil
			{
			sleep 2;
			
			(((time - RYD_JR_LastComm) > 10) or {RYD_JR_Outro})
			};
		
		if (RYD_JR_Outro) exitWith {};
		
		RYD_JR_LastComm = time;
		RYD_JR_FuelFund = RYD_JR_FuelFund + _val;
		RYD_JR_FuelFundGain = RYD_JR_FuelFundGain + _val;
		
		["sonar",3] spawn RYD_JR_Sound3D;
		
		sleep 0.02;
		
		RYD_JR_Caller customChat [RYD_JR_RadioADMa,format ["Item '%4' sold for %1 ff. Auction Gattamelata#%3_rapid closed. Your current account: %2 ff.",_val,RYD_JR_FuelFund,RYD_JR_DM_Count,_desc]];
		};
	};
			
RYD_JR_Garrison = 
	{
	_stoper = time;	

	_garrison = _this select 0;
	_garrVehAb = false;
	
	//missionnamespace setvariable ["PosTaken",[]];

	for [{_a = 0},{_a < (count _garrison)},{_a = _a + 1}] do
		{
		_unitG = _garrison select _a;
		_garrisoned = _unitG getVariable ("Garrisoned" + (str _unitG));
		if (isNil "_garrisoned") then {_garrisoned = false};
		
		if not (_garrisoned) then
			{
			[_unitG] call RYD_JR_WPdel;

			_unitG setVariable ["Garrisoned" + (str _unitG),true];

			_pos = getPosATL (vehicle (leader _unitG));
			_units = [];

			_UL = leader _unitG;
			_AV = assignedVehicle _UL;

			if ((_garrVehAb) and not (isPlayer (leader _unitG))) then
				{
				//{unassignVehicle _x} foreach (units _unitG);
				(units _unitG) orderGetIn false;
				//(units _unitG) allowGetin false;
				sleep 5
				};

			if (not (isNull _AV) and not (_garrVehAb)) exitWith
				{
				_frm = "DIAMOND";
				if (isPlayer (leader _unitG)) then {_frm = formation _unitG};
				_wp = [_unitG,position (leader _unitG),"SENTRY","AWARE","YELLOW","NORMAL",["true","deletewaypoint [(group this), 0];"],false,0,[0,0,0],_frm] call RYD_JR_WPadd
				};

			_units = (units _unitG) - [leader _unitG]; 

			if not (isPlayer _UL) then
				{
				_list = _pos nearObjects ["StaticWeapon", 300];
				_staticWeapons = [];

					{
					if ((_x emptyPositions "gunner") > 0) then 
						{
						_staticWeapons = _staticWeapons + [_x];	
						};
					} 
				forEach _list;

					{
					if ((count _units) > 0) then 
						{
						_unit = (_units select ((count _units) - 1));

						if ((random 1) > 0.1) then
							{
							_unit assignAsGunner _x;
							[_unit] orderGetIn true;
							
							_units resize ((count _units) - 1)
							}
						}
					} 
				forEach _staticWeapons;

				_Bldngs = _pos nearObjects ["HouseBase",300];
				_posTaken = missionnamespace getvariable ["PosTaken",[]];
				_posAll = [];
				_posAll0 = [];

					{
					_Bldg = _x;
					if ((_Bldg distance _UL) > 300) then {_Bldg = ObjNull};

					if not (isNull _Bldg) then
						{
						_posAct = _Bldg buildingpos 0;
						_ct = 0;

						while {((_posAct distance [0,0,0]) > 0)} do 
							{
							_tkn = false;
							_sum = (_posAct select 0) + (_posAct select 1);

								{
								if ((typeName _x) == (typeName [])) then
									{
									if (((_x select 0) + (_x select 1)) == _sum) exitWith {_tkn = true}
									}
								}
							foreach _posTaken;

							if not (_tkn) then
								{
								_posAll set [(count _posAll),[_posAct,_Bldg]]
								};
							
							_ct = _ct + 1;
							_posAct = _Bldg buildingpos _ct;
							if (_ct > 100) exitWith {}
							}
						}
					}
				foreach _Bldngs;

				_posAll0 = +_posAll;

					{
					if ((random 100) > 20) then
						{
						_ix = 0;
						if not ((count _posAll) == 0) then
							{
							_ix = floor (random (count _posAll));
							_posS = _posAll select _ix;
							_bld = _posS select 1;
							_posS = _posS select 0;
							_ct = 0;

							_posTaken = missionNamespace getVariable ["PosTaken",[]];
							
							_tkn = false;
							
								{
								if ((_posS distance _x) < 2) exitWith {_tkn = true}
								}
							foreach _posTaken;
							
							while {((_tkn) and (_ct < 20))} do
								{
								_ix = floor (random (count _posAll));
								_posS = _posAll select _ix;
								_bld = _posS select 1;
								_posS = _posS select 0;
								
									{
									if ((_posS distance _x) < 2) exitWith {_tkn = true}
									}
								foreach _posTaken;
								
								_ct = _ct + 1
								};

							if not (_tkn) then
								{
								if not ((_posS distance _pos) > 350) then
									{
									_posAll set [_ix,0];
									_posAll = _posAll - [0];
									_ix  = count _posTaken;
									_posTaken pushBack _posS;
									missionNamespace setVariable ["PosTaken",_posTaken];
									[_x,_posS,_bld] call RYD_JR_GarrS;
									_units = _units - [_x]
									}
								}
							}
						}
					}
				foreach _units;

				_patrolPos = [];

					{
					_pA = _x select 0;
					if ((typeName _pA) == (typeName [])) then
						{
						_isGood = true;
						if ((_pA select 2) > 16) then
							{
							_isGood = false
							};
							
						if (_isGood) then
							{								
							for "_i" from 0 to ((count _patrolPos) - 1) do
								{
								_pPos = _patrolPos select _i;
								_dst = _pPos distance _pA;
								if (_dst > 0.1) then
									{
									if (_dst < 16) then 
										{
										_isGood = false
										}
									};
								}
							};
							
						if (_isGood) then
							{
							_patrolPos pushBack _pA;
							}
						}
					}
				foreach _posAll0;

				if ((count _patrolPos) > 1) then 
					{
					[_unitG,_patrolPos] call RYD_JR_GarrP
					}
				else
					{
					_frm = "DIAMOND";
					if (isPlayer (leader _unitG)) then {_frm = formation _unitG};
					_wp = [_unitG,position (leader _unitG),"SENTRY","AWARE","YELLOW","NORMAL",["true","deletewaypoint [(group this), 0];"],false,0,[0,0,0],_frm] call RYD_JR_WPadd;
					}
				}
			}
		};
	};
	
RYD_JR_GarrP = 
	{
	private ["_gp","_points","_nHouse","_frm","_wp","_ct","_posAll","_posAct"];

	_gp = _this select 0;
	_points = _this select 1;

		{
		_nHouse = _x nearestObject "House";
		_posAll = [];
		
		_posAct = _nHouse buildingpos 0;
		_ct = 0;

		while {((_posAct distance [0,0,0]) > 0)} do 
			{
			_posAll pushBack _posAct;
				
			_ct = _ct + 1;
			_posAct = _nHouse buildingpos _ct;
			if (_ct > 100) exitWith {}
			};

		_frm = "DIAMOND";
		if (isPlayer (leader _gp)) then {_frm = formation _gp};

		_wp = [[_gp],_x,"MOVE","AWARE","YELLOW","LIMITED",["true",""],false,0,[10,15,20],_frm] call RYD_JR_WPadd;

		//_i = [_x,(random 1000),"markPatrol","ColorOrange","ICON","mil_box","Patrol","",[0.3,0.3]] call RYD_JR_Mark;

		if ((count _posAll) > 0) then
			{
			_wp waypointAttachVehicle _nHouse;
			//sleep 0.05;
			_wp setWaypointHousePosition (floor (random (count _posAll)))
			}
		}
	foreach _points;

	_wp = [[_gp],_points select 0,"CYCLE","AWARE","YELLOW","LIMITED",["true",""],false,0,[10,15,20],_frm] call RYD_JR_WPadd;
	};

RYD_JR_GarrS = 
	{
	private ["_unit","_pos","_timer","_alive","_dst","_gar","_i","_vel","_sum","_posLast","_dst2","_bld","_taken","_tkn","_pA","_sum"];

	_unit = _this select 0;
	_pos = _this select 1;
	_bld = _this select 2;
	
	_pos set [2,(_pos select 2) + 0.5];
	
	/*_unit doMove _pos;

	//_i = [_pos,_unit,"markPos","ColorBrown","ICON","mil_box","Pos","",[0.3,0.3]] call RYD_JR_Mark;

	_timer = 0;
	_alive = true;

	_posLast = getPosASL _unit;

	waitUntil 
		{
		_dst = 0;
		if not (isNull _unit) then {_dst = _unit distance _pos};
		sleep 0.1;
		_dst2 = 0;
		if not (isNull _unit) then {_dst2 = _unit distance _pos};
		if (isNull _unit) then {_alive = false};
		if not (alive _unit) then {_alive = false};
		if (_dst2 >= _dst) then {_timer = _timer + 1};

		((unitReady _unit) or (_timer > 240) or not (_alive))
		};

	if not (_alive) exitWith {};*/
	
	if (RYD_JR_Debug) then
		{
		_i = "gMark_" + (str _pos);
		_i = createMarker [_i,_pos];
		_i setMarkerColor "colorWhite";
		_i setMarkerShape "ICON";
		_i setMarkerType "mil_box";
		_i setMarkerSize [0.25,0.25];
		_i setmarkerText (str (_pos select 2))
		};
	
	_unit setPos _pos;
	doStop _unit;
	_unit setVariable ["RYD_JR_Stopped",true];
	
	_dir = getDir _bld;
	
	_uPosASL = getPosASL _unit;
	_watchPos = [];
	_unitP = "UP";

	for "_i" from _dir to (_dir + 270) step 90 do
		{
		_cPosASL = [_uPosASL,_i,5] call RYD_JR_PosTowards2D;
		_isLOS = [_cPosASL,_cPosASL,1.5,20,_unit,objNull] call RYD_JR_LOSCheck;
		
		if (_isLOS) then
			{
			_isLOS = [_uPosASL,_cPosASL,1.5,1.5,_unit,objNull] call RYD_JR_LOSCheck;
			
			if (_isLOS) then
				{
				_watchPos = ASLtoATL _cPosASL
				}
			}
		};
		
	if ((count _watchPos) < 2) then
		{
		_unitP = "MIDDLE";
		_exits = [];
		_exitAct = _bld buildingExit 0;
		_ct = 0;

		while {((_exitAct distance [0,0,0]) > 0)} do 
			{
			_isLOS = [_uPosASL,ATLtoASL _exitAct,1.5,1.5,_unit,objNull] call RYD_JR_LOSCheck;
			if (_isLOS) then
				{
				_exits pushBack _exitAct;
				};
				
			_ct = _ct + 1;
			_exitAct = _Bld buildingExit _ct;
			if (_ct > 100) exitWith {}
			};
			
		if ((count _exits) > 0) then
			{
			_closestExit = [_uPosASL,_exits] call RYD_JR_FindClosest;
			_watchPos = _closestExit
			}
		};
		
	if ((count _watchPos) < 2) then
		{
		_unitP = "MIDDLE";
		_chosenDir = random 360;
		_maxDst = 1;
		_dir = getDir _bld;
		for "_i" from _dir to (_dir + 270) step 90 do
			{
			_isLOS = true;
			_dst = 1;
			
			while {_isLOS} do
				{
				_cPosASL = [_uPosASL,_i,_dst] call RYD_JR_PosTowards2D;
				_isLOS = [_uPosASL,_cPosASL,1.5,1.5,_unit,objNull] call RYD_JR_LOSCheck;
				_dst = _dst + 1;
				if (_dst > 50) exitWith {};
				};
				
			if (_dst > _maxDst) then
				{
				_maxDst = _dst;
				_chosenDir = _i;
				};
				
			_watchPos = ASLtoATL ([_uPosASL,_chosenDir,5] call RYD_JR_PosTowards2D);
			};
		};
		
	_watchDir = [_uPosASL,_watchPos,5] call RYD_JR_AngTowards;
	
	_unit setVariable ["RYD_JR_Watched",_watchPos];
		
	_unit setUnitPos _unitP;
	_unit setDir _watchDir;
	_unit doWatch _watchPos;
	_unit forceSpeed 0;
	
	_unit setPosATL _pos;


	/*_alive = true;

	waitUntil 
		{
		sleep 30;
		switch (true) do
			{
			case (isNull (group _unit)) : {_alive = false};
			case (isNull _unit) : {_alive = false};
			case (alive _unit) : {_alive = false};
			case not ((group _unit) getVariable [("Garrisoned" + (str (group _unit))),false]) : {_alive = false};
			};
			
		not (_alive)
		};

	_taken = missionnamespace getVariable ["PosTaken",[]];
	
	_tkn = -1;
	
	_sum = (_pos select 0) + (_pos select 1);
	
		{
		if ((typeName _x) == (typeName [])) then
			{
			if (((_x select 0) + (_x select 1)) == _sum) exitWith {_tkn = _foreachIndex}
			}
		}
	foreach _taken;
	
	if (_tkn >= 0) then
		{
		_taken set [_tkn,0];
		_taken = _taken - [0];
		missionnamespace setVariable ["PosTaken",_taken];
		}*/
	};
		
RYD_JR_FindClosest = 
	{
	private ["_ref","_objects","_closest","_dstMin","_dstAct","_obj"];

	_ref = _this select 0;
	_objects = _this select 1;

	_closest = objNull;

	if ((count _objects) > 0) then 
		{
		_closest = _objects select 0;
		_obj = _closest;

		if ((typeName _obj) == (typeName grpNull)) then
			{
			_obj = vehicle (leader _obj);
			}
		else
			{
			if ((typeName _obj) == (typeName locationNull)) then
				{
				_obj = position _obj;
				};
			};
	
		_dstMin = _ref distance _obj;

			{
			_obj = _x;
			if ((typeName _obj) == (typeName grpNull)) then
				{
				_obj = vehicle (leader _obj);
				}
			else
				{
				if ((typeName _obj) == (typeName locationNull)) then
					{
					_obj = position _obj;
					};
				};
				
			_dstAct = _ref distance _obj;

			if (_dstAct < _dstMin) then
				{
				_closest = _x;
				_dstMin = _dstAct
				}
			}
		foreach _objects
		};

	_closest
	};
	
RYD_JR_FindClosestF = 
	{
	private ["_ref","_objects","_closest","_dstMin","_dstAct","_obj"];

	_ref = _this select 0;
	_objects = _this select 1;

	_closest = [];

	if ((count _objects) > 0) then 
		{
		_closest = _objects select 0;
		_obj = _closest;
			
		_dstMin = _ref distance (_obj select 0);

			{
			_obj = _x;
				
			_dstAct = _ref distance (_obj select 0);

			if (_dstAct < _dstMin) then
				{
				_closest = _x;
				_dstMin = _dstAct
				}
			}
		foreach _objects
		};

	_closest
	};

RYD_JR_WPdel = 
	{//[_gp] call RYD_JR_WPdel
	private ['_gp','_ct','_am'];

	_gp = _this select 0;
	_ct = 0;
	_am = count (waypoints _gp);

	while {((count (waypoints _gp)) > 0)} do
		{
		 deleteWaypoint ((waypoints _gp) select (count (waypoints _gp) - 1));
		 _ct = _ct + 1;
		 if (_ct > (_am + 1)) exitWith {}
		}
	};

RYD_JR_WPadd = 
	{//[_gp,_pos,_tp,_beh,_CM,_spd,_sts,_crr,_rds,_TO,_frm] call RYD_JR_WPadd;
	private 
		[
		"_gp","_pos","_tp","_beh","_CM","_spd","_sts","_crr","_rds","_TO","_frm","_wp","_vh",
		"_topArr","_fFactor","_posX","_posY","_isWater","_wpn","_addedpath","_assVeh","_wps",
		"_isAir","_sPoint","_dst","_dstFirst","_mPoints","_num","_actDst","_angle","_mPoint",
		"_topPoints","_sPosX","_sPosY","_sUrban","_sForest","_sHills","_sFlat","_sSea",
		"_sGr","_count","_friendly","_opt","_j","_samplePos","_sRoads,","_lastDistance",
		"_dstCheck","_pfAll","_sRoads"
		];

	_pfAll = true;

	_gp = _this select 0;

	if ((typeName _gp) == "ARRAY") then {_pfAll = false;_gp = _gp select 0};

	_pos = _this select 1;

	_tp = "MOVE";
	if ((count _this) > 2) then {_tp = _this select 2};

	_beh = "AWARE";
	if ((count _this) > 3) then {_beh = _this select 3};

	_CM = "YELLOW";
	if ((count _this) > 4) then {_CM = _this select 4};

	_spd = "NORMAL";
	if ((count _this) > 5) then {_spd = _this select 5};

	if (RydGARR_Rush) then 
		{
		if (_spd == "LIMITED") then
			{
			_spd = "NORMAL"
			};

		if (_beh == "SAFE") then
			{
			_beh = "AWARE"
			}
		};

	_sts = ["true","deletewaypoint [(group this), 0]"];
	if ((count _this) > 6) then {_sts = _this select 6};

	_crr = true;
	if ((count _this) > 7) then {_crr = _this select 7};

	_rds = 0;
	if ((count _this) > 8) then {_rds = _this select 8};

	_TO = [0,0,0];
	if ((count _this) > 9) then {_TO = _this select 9};

	_frm = formation _gp;
	if ((count _this) > 10) then {_frm = _this select 10};

	if ((typeName _pos) == (typeName objNull)) then {_pos = position _pos};

	if (isNull _gp) exitWith {diag_log format ["wp error grupa: %1 typ: %3 pos: %2",_gp,_pos,typeOf (vehicle (leader _gp))]};
	if not ((typeName _pos == (typeName []))) exitWith {diag_log format ["wp error grupa: %1 typ: %3 pos: %2",_gp,_pos,typeOf (vehicle (leader _gp))]};
	if ((count _pos) < 2) exitWith {diag_log format ["wp error grupa: %1 typ: %3 pos: %2",_gp,_pos,typeOf (vehicle (leader _gp))]};
	if ((_pos select 0) == 0) exitWith {diag_log format ["wp error grupa: %1 typ: %3 pos: %2",_gp,_pos,typeOf (vehicle (leader _gp))]};

	_addedpath = false;

	if (isPlayer (leader _gp)) then {_pfAll = false};

	if ((RydGARR_PathFinding > 0) and (_pfAll)) then
		{
		_assVeh = assignedVehicle (leader _gp);
		if (isNull _assVeh) then
			{
				{
				_vh = assignedVehicle _x;
				if not (isNull _vh) exitWith {_assVeh = _vh};
				_vh = vehicle _x;
				if not (_vh == _x) exitWith {_assVeh = _vh}
				}
			foreach (units _gp)
			};

		if not (isNull _assVeh) exitWith {};//!

		_isAir = false;
		if not (isNull _assVeh) then
			{
			if (_assVeh isKindOf "Air") then {_isAir = true}
			};

		if not (_isAir) then
			{
			_sPoint = getPosATL (vehicle (leader _gp));

			_wps = waypoints _gp;

			if not ((count _wps) == 0) then
				{
				_sPoint = waypointPosition (_wps select ((count _wps) - 1))
				};

			_dst = _sPoint distance _pos;

			_lastDistance = _dst;

			if (_dst > RydGARR_PathFinding) then
				{
				_dstFirst = _dst;
				_mPoints = [];

				while {(_dst > RydGARR_PathFinding)} do
					{
					_dst = floor (_dst/2)
					};

				_dst = _dst * 2;

				_num = floor (_dstFirst/_dst);

				if (_num >= 2) then
					{
					_actDst = 0;
					_angle = [_sPoint,_pos,0] call RYD_JR_AngTowards;

					for "_i" from 1 to _num do
						{
						_actDst = _actDst + _dst;
						_mPoint = [_sPoint,_angle,_actDst] call RYD_JR_PosTowards2D;
						_mPoints pushBack _mPoint;
						};

					_topPoints = [];

						{
						_sPosX = _x select 0;
						_sPosY = _x select 1;

						_count = 10;

						_friendly = -1000000;
						_opt = _x;
						_samplePos = _x;

						for "_i" from 1 to _count do
							{
							_samplePos = [_sPosX + ((random RydGARR_PathFinding) - (RydGARR_PathFinding/2)),_sPosY + ((random RydGARR_PathFinding) - (RydGARR_PathFinding/2))];

							_topArr = [_samplePos,1] call RYD_JR_TerraCognita;

							_sUrban = _topArr select 0;
							_sForest = _topArr select 1;
							_sHills = _topArr select 2;
							_sFlat = _topArr select 3;
							_sSea = _topArr select 4;
							_sGr = _topArr select 5;

							_sUrban = round (_sUrban*100);
							_sForest = round (_sForest*100);
							_sHills = round (_sHills*100);
							_sFlat = round (_sFlat*100);
							_sSea = round (_sSea*100);
							_sGr = round _sGr;

							_sRoads = count (_samplePos nearRoads 100);

							_fFactor = _sUrban + _sForest + _sGr - _sFlat - _sHills;

							if (not (isNull _assVeh) and (_assVeh isKindOf "LandVehicle")) then
								{
								_fFactor = _sFlat + _sHills + _sRoads - _sUrban - _sForest - _sGr
								};

							if (_fFactor > _friendly) then
								{
								_opt = _samplePos;
								_friendly = _fFactor
								}
							};
						
						_posX = _opt select 0;
						_posY = _opt select 1;

						_isWater = surfaceIsWater [_posX,_posY];

						
						_dstCheck = [_posX,_posY] distance _pos;

						if ((not (_isWater)) and (true)) then
							{
							_topPoints set [(count _topPoints),[_posX,_posY,0]];
							_lastDistance = _dstCheck;
							}
						}
					foreach _mPoints;

					if ((count _topPoints) > 0) then
						{
						_wpn = 0;
							{
							//if (RydBB_Debug) then {_j = [_x,_gp,(str (random 1000)),"ColorPink","ICON","DOT",(str _wpn),"",[0.25,0.25]] call RYD_JR_Mark};
							_wpn = _wpn + 1;
							_wp = _gp addWaypoint [_x, 0];
							_wp setWaypointType "MOVE";
							_wp setWaypointBehaviour _beh;
							_wp setWaypointCombatMode _CM;
							_wp setWaypointSpeed _spd;
							_wp setWaypointStatements ["true","deletewaypoint [(group this), 0]"];
							_wp setWaypointTimeout [0,0,0];
							_wp setWaypointFormation _frm;
							if ((_crr) and (_wpn == 1)) then {_gp setCurrentWaypoint _wp};
							}
						foreach _topPoints
						};
					_addedpath = true;
					}
				}
			}
		};

	_wp = _gp addWaypoint [_pos, _rds];
	_wp setWaypointType _tp;
	_wp setWaypointBehaviour _beh;
	_wp setWaypointCombatMode _CM;
	_wp setWaypointSpeed _spd;
	_wp setWaypointStatements _sts;
	_wp setWaypointTimeout _TO;
	_wp setWaypointFormation _frm;
	if not (_addedpath) then {if (_crr) then {_gp setCurrentWaypoint _wp}};

	_wp
	};

RYD_JR_PosTowards2D = 
	{
	private ["_source","_distT","_angle","_dXb","_dYb","_px","_py","_pz"];

	_source = _this select 0;
	_angle = _this select 1;
	_distT = _this select 2;

	_dXb = _distT * (sin _angle);
	_dYb = _distT * (cos _angle);

	_px = (_source select 0) + _dXb;
	_py = (_source select 1) + _dYb;

	_pz = _source select 2;

	[_px,_py,_pz]
	};
	
RYD_JR_LOSCheck = 
	{
	private ["_pos1","_pos2","_isLOS","_cam","_target","_pX1","_pY1","_pX2","_pY2","_pos1ATL","_pos2ATL","_level1","_level2"];

	_pos1 = _this select 0;
	_pos2 = _this select 1;
	_level1 = _this select 2;
	_level2 = _this select 3;

	_pX1 = _pos1 select 0;
	_pY1 = _pos1 select 1;

	_pX2 = _pos2 select 0;
	_pY2 = _pos2 select 1;
	
	_pos1 = [_pX1,_pY1,(_pos1 select 2) + _level1];
	_pos2 = [_pX2,_pY2,(_pos2 select 2) + _level2];

	_pos1ATL = ASLtoATL _pos1;
	_pos2ATL = ASLtoATL _pos2;

	_cam = objNull;

	if ((count _this) > 4) then {_cam = _this select 4};

	_target = objNull;

	if ((count _this) > 5) then {_target = _this select 5};

	_isLOS = not (terrainintersect [_pos1ATL, _pos2ATL]);
	
	if (_isLOS) then
		{ 
		_isLOS = not (lineintersects [_pos1, _pos2,_cam,_target]); 
		};

	_isLOS
	};
	
RYD_JR_SpawnGroupSafe = 
	{//based on BIS_fnc_spawnGroup by BI Studio (Joris-Jan van 't Land (modified by Thomas Ryan))
	private ["_pos","_side","_count","_chars","_ranks","_positions","_item","_types","_safePos","_rP","_rnd","_ct","_typesC","_del","_types","_grp","_ourVehs","_type","_relPos","_itemPos","_unit",
	"_newGrp","_am","_maxRank","_rank","_out","_vh","_eP","_unit","_eD","_eG","_eC","_crw","_imp","_ic","_checked","_azimuth","_pItems"];
		
	_pos = _this select 0;
	_side = _this select 1;
	
	_count = {(side _x) == _side} count allGroups;
	if (_count > RYD_JR_GLimit) exitWith {grpNull};

	_chars = _this select 2;
	
	_ranks = [];
	_positions = [[0,0,0]];
	_types = [];
	
	for "_ia" from 0 to ((count _chars) - 1) do 
		{
		_item = _chars select _ia;
		
		if (isClass _item) then 
			{
			_types set [(count _types),getText(_item >> "vehicle")];
			_ranks set [(count _ranks),getText(_item >> "rank")];
			
			if (_ia > 0) then
				{
				_safePos = [_pos,0,160,10,0,4,0] call BIS_fnc_findSafePos;
				_rP = [(_safePos select 0) - (_pos select 0),(_safePos select 1) - (_pos select 1),0.5];
				_positions pushBack _rP
				}
			};
		};
	
	if (({_x in RYD_JR_Tanks} count _types) > 0) then
		{				
		_rnd = 1;
		
		if ((random 100) > 90) then
			{
			_rnd = _rnd + (floor (random 3))
			};
			
		_rnd = _rnd min ({_x in RYD_JR_Tanks} count _types);
		
		_ct = 0;
		_typesC = count _types;
		
		while {({_x in RYD_JR_Tanks} count _types) > _rnd} do
			{
			_del = -1;
			
				{
				if (_x in RYD_JR_Tanks) exitWith {_del = _foreachIndex}
				}
			foreach _types;
			
			if not (_del < 0) then
				{
				_types set [_del,0];
				_types = _types - [0]
				};
			
			_ct = _ct + 1;
			if (_ct > _typesC) exitWith {}
			};
		};
	
	_grp = createGroup _side;
	_ourVehs = [];
	_azimuth = 0;

	for "_ib" from 0 to ((count _types) - 1) do
		{
		_type = _types select _ib;

		if ((count _positions) > 0) then 
			{
			_relPos = _positions select _ib;
			_itemPos = [(_pos select 0) + (_relPos select 0), (_pos select 1) + (_relPos select 1)];
			} 
		else 
			{
			_itemPos = _pos;
			};

		if (getNumber(configFile >> "CfgVehicles" >> _type >> "isMan") == 1) then 
			{	
			_unit = _grp createUnit [_type, _itemPos, [], 0, "FORM"];
			[_unit,false] call RYD_JR_DecimateGear;
			_unit setDir _azimuth
			} 
		else 
			{
			_unit = ([_itemPos, _azimuth, _type, _grp] call BIS_fnc_spawnVehicle) select 0;
			_ourVehs pushBack _unit;
			};

		if ((count _ranks) > 0) then 
			{
			[_unit,_ranks select _ib] call bis_fnc_setRank;
			};
		};
		
	_newGrp = createGroup _side;
	_ct = 0;
	_am = {alive _x} count (units _grp);
	while {(({alive _x} count (units _grp)) > 0)} do 
		{
		_maxRank = -1;
		_unit = objnull;
		
			{
			_rank = rankid _x;
			if (_rank > _maxRank) then 
				{
				_maxRank = _rank;
				_unit = _x
				};
			} 
		foreach units _grp;
		
		[_unit] joinsilent _newGrp;
		
		_ct = _ct + 1;
		if (_ct > (_am + 1)) exitWith {}
		};
		
	_newGrp selectleader (units _newGrp select 0);
	deletegroup _grp;
	
		{
		if ((random 100) < 80) then
			{
			_pItems = assignedItems _x;
			
			if not (({(toLower _x) in ["nvgoggles","nvgoggles_indep","nvgoggles_opfor"]} count _pItems) > 0) then
				{
				_pItems = primaryWeaponItems _x;
				if not (({(toLower _x) in ["acc_flashlight","acc_pointer_ir"]} count _pItems) > 0) then
					{
					if (({(toLower _x) isEqualTo "acc_pointer_ir"} count _pItems) > 0) then
						{
						_x removePrimaryWeaponItem "acc_pointer_ir";
						};
					
					_x addPrimaryWeaponItem "acc_flashlight"
					}
				}
			}
		}
	foreach (units _newGrp);
	
	_newGrp setVariable ["RYD_JR_OurVehs",_ourVehs];
		
	if ((count _ourVehs) > 0) then
		{
		_out = [];

			{
			if (_x == (vehicle _x)) then
				{
				_out pushBack _x
				}
			}
		foreach (units _newGrp);
		
		_imp = [+_out] call RYD_JR_SelectImportant;
				
		_unit = objNull;
		_eD = 0;
		_eG = 0;
		_eC = 0;
		
		if ((count _out) > 0) then
			{			
				{
				_vh = _x;
				
				_eD = _vh emptyPositions "Driver";
				_eG = _vh emptyPositions "Gunner";
				_eC = _vh emptyPositions "Commander";
				
				_vh setVariable ["RYD_JR_InitCrew",[_eD,_eG,_eC]];
				
				if (_eD > 0) then
					{
					if (_imp > 0) then
						{
						_unit = _imp select 0;
						_imp = _imp - [_unit];
						_out = _out - [_unit];
						}
					else
						{
						_unit = _out select 0;
						_out = _out - [_unit];						
						};
						
					_unit moveInDriver _vh				
					};
					
				if not ((count _out) > 0) exitWith {};
				
				if (_eG > 0) then
					{
					if ((count _imp) > 0) then
						{
						_unit = _imp select 0;
						_imp = _imp - [_unit];
						_out = _out - [_unit];
						}
					else
						{
						_unit = _out select 0;
						_out = _out - [_unit];						
						};
						
					_unit moveInGunner _vh				
					};
				
				if not ((count _out) > 0) exitWith {};
				
				if (_eC > 0) then
					{
					if ((count _imp) > 0) then
						{
						_unit = _imp select 0;
						_imp = _imp - [_unit];
						_out = _out - [_unit];
						}
					else
						{
						_unit = _out select 0;
						_out = _out - [_unit];						
						};
						
					_unit moveInCommander _vh				
					};
				
				if not ((count _out) > 0) exitWith {};
				
				_eP = _vh emptyPositions "Cargo";
				_ct = _eP;

				while {(_eP > 0)} do
					{
					if ((count _imp) > 0) then
						{
						_unit = _imp select 0;
						_imp = _imp - [_unit];
						_out = _out - [_unit];
						}
					else
						{
						_unit = _out select (floor (random (count _out)));
						_out = _out - [_unit];						
						};
					
					_unit moveInCargo _vh;
					
					if not ((count _out) > 0) exitWith {};
					
					_eP = _vh emptyPositions "Cargo";
					_ct = _ct - 1;
					if (_ct < -2) exitWith {}		
					};
					
				if not ((count _out) > 0) exitWith {};
				}
			foreach _ourVehs;
				
			if ((count _imp) > 0) then
				{
					{
					_vh = _x;
					
					_iC = _vh getVariable ["RYD_JR_InitCrew",[0,0,0]];
					_eD = _iC select 0;
					_eG = _iC select 1;
					_eC = _iC select 2;
										
					if (_eG == 0) then
						{
						_crw = gunner _vh;
						if not (isNull _crw) then
							{
							if not (_crw == (leader _newGrp)) then
								{
								_unit = _imp select 0;
								_imp = _imp - [_unit];
								deleteVehicle _crw;
								_unit moveInGunner _vh
								}
							}					
						};
						
					if not ((count _imp) > 0) exitWith {};

					if (_eC == 0) then
						{
						_crw = commander _vh;
						if not (isNull _crw) then
							{
							if not (_crw == (leader _newGrp)) then
								{
								_unit = _imp select 0;
								_imp = _imp - [_unit];
								deleteVehicle _crw;
								_unit moveInCommander _vh
								}
							}							
						};
						
					if not ((count _imp) > 0) exitWith {};
					
					if (_eD == 0) then
						{
						_crw = driver _vh;
						if not (isNull _crw) then
							{
							if not (_crw == (leader _newGrp)) then
								{
								_unit = _imp select 0;
								_imp = _imp - [_unit];
								deleteVehicle _crw;
								_unit moveInDriver _vh;
								_newGrp addVehicle _vh 
								}
							}					
						};
						
					if not ((count _imp) > 0) exitWith {};
					}
				foreach _ourVehs
				};
			
				{
				if (_x == (vehicle _x)) then
					{
					deleteVehicle _x
					}
				}
			foreach (units _newGrp)
			};
		};
				
	_newGrp setVariable ["RYD_JR_GroupCount",{alive _x} count (units _newGrp)];
	
	[_newGrp] call RYD_JR_WPdel;
	
	if (RYD_JR_Debug) then
		{
		_ic = "EMark_" + (str _newGrp);
		_ic = createMarker [_ic,position (leader _newGrp)];
		_ic setMarkerColor "colorBlue";
		_ic setMarkerShape "ICON";
		_ic setMarkerType "mil_triangle";
		_ic setMarkerSize [0.6,0.6];
		_newGrp setVariable ["mymarker",_ic];
		//_i setMarkerText (str (side _ldr)) + "_" + (str (expectedDestination _ldr));
		};
		
	_newGrp setVariable ["RYD_JR_MyKind",_this select 4];
		
	if (isNil {_this select 3}) then
		{	
		_checked = [];
		
			{
			_vh = vehicle _x;
			
			if not (_vh in _checked) then
				{
				_checked pushBack _vh;
				
				if not (_vh == _x) then
					{
						{
						_x enableSimulation false;
						_x hideObject true
						}
					foreach (crew _vh)
					};
				
				_vh enableSimulation false;
				_vh hideObject true
				}
			}
		foreach (units _newGrp);
		};

	_newGrp
	};
	
RYD_JR_SelectImportant = 
	{
	private ["_units","_important"];
	
	_units = _this select 0;
	
	if ((count _units) < 1) exitWith {[]};

	_important = [leader (group (_units select 0))];
		
	_units = _units - [(leader (group (_units select 0)))];
	
		{
		if not (isNull (unitBackPack _x)) then
			{
			_important pushBack _x
			};
		}
	foreach _units;
	
	_important
	};
	
RYD_JR_Icons3D = 
	{
	//[] call RYD_JR_DisablePlayerCentering;
	
	if ((time - RYD_JR_LoadTime) < 15) exitWith {};
	
		{
		if not (isNil {_x}) then
			{
			if not (isNull _x) then
				{
				if (alive _x) then
					{
					_dst = (player distance _x) max 1;
					
					if (_dst > 20) then
						{
						_kn = player knowsAbout _x;
						if not (_kn > 0) exitWith {};
						_pos = visiblePosition _x;
						_pos set [2,1.5];
						
						_alpha = (100/_dst) min 1;
						
						//_alpha = (_kn/2) min 1;
						
						_txt = "";
						
						if (_kn > 1) then {_txt = getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName")};
						if (_dst < 50) then 
							{
							_alpha = (_dst/50)^1.5
							};
							
						_cl = [0.05,0.35,0.8,_alpha];
						
						drawIcon3D ["\A3\ui_f\data\map\groupicons\selector_selectable_ca.paa",_cl,_pos,1,1,0,_txt,1,0.035,"PuristaMedium"];
						}
					}
				}
			}
		}
	foreach RYD_JR_EmptyVehs;
	
	if not (RYD_JR_ShowLootMarkers in [-1,0]) then
		{
			{
			if not (isNil {_x}) then
				{
				if not (_x in [1]) then
					{
					if not (isNull _x) then
						{
						if (not (RYD_JR_ShowLootMarkers in [1]) or (_x in RYD_JR_SomeHouses)) then
							{
							if not (_x getVariable ["RYD_JR_Checked",false]) then
								{
								_dst = _x distance player;
								
								_bb = boundingBoxReal _x;
								_bbMax = _bb select 1;
								_zMax = _bbMax select 2;
								_xMax = _bbMax select 0;
								_yMax = _bbmax select 1;
								_dim = _xMax min _yMax;
								
								if (_dst < _dim) exitWith {_x setVariable ["RYD_JR_Checked",true];hint "Building checked"};
								
								_pos = visiblePosition _x;
								_pos set [2,(_pos select 2) + (_zMax * 2)];
								_alpha = (10/_dst) min 1;

								_cl = [0.8,0.6,0.2,_alpha];

								drawIcon3D ["\A3\ui_f\data\map\markers\military\warning_CA.paa",_cl,_pos,1,1,0,"",1,0.035,"PuristaMedium"];
								}
							}
						}
					}
				}
			}
		foreach RYD_JR_LootHouses;
		};
		
		{
		if not (isNil {_x}) then
			{
			if ((typeName _x) in [(typeName objNull)]) then
				{
				if not (isNull _x) then
					{
					if ((alive _x) or (_x in [RYD_JR_Brother])) then
						{
						_dst = _x distance player;
						_mDst = 1500;
						
						_pow = _x getVariable "RYD_JR_Captive";
						if (isNil "_pow") then {_pow = false};
						
						if (_pow) then
							{
							_mDst = 500
							};
						
						if (_dst < _mDst) then
							{
							_pos = visiblePositionASL (vehicle _x);
							_pos set [2,(_pos select 2) + 3];
							_alpha = (25/_dst) min 1;
							_size = ((100/_dst) min 0.75) max 0.25;

							_cl = [0.1,0.3,0.8,_alpha];
							
							if (_x in RYD_JR_NearTargets) then
								{
								_cl = [0.8,0.3,0.1,(_alpha max 0.2)];
								_size = _size max 0.35
								};
								
							if (_pow) then
								{
								if (_x == RYD_JR_Brother) then
									{
									_size = ((100/_dst) min 1) max 0.5;
									_cl = [0.8,0.8,0.8,(_alpha max 0.5)];
									}
								else
									{
									_cl = [0.4,0.8,0.9,(_alpha max 0.2)];
									_size = _size max 0.35
									};
									
															
								};

							drawIcon3D [_x getVariable ["RYD_JR_myIcon","\A3\ui_f\data\map\markers\military\warning_CA.paa"],_cl,ASLtoATL _pos,_size,_size,0,"",1,0.035,"PuristaMedium"];
							}
						}
					}
				}
			}
		}
	foreach RYD_JR_NearCivs;
	
		{
		if not (isNil {_x}) then
			{
			if ((typeName _x) in [(typeName objNull)]) then
				{
				if not (isNull _x) then
					{
					if ((alive _x) or (_x in [RYD_JR_Brother])) then
						{
						_dst = _x distance player;
						_mDst = 500;
						
						if (_dst < _mDst) then
							{
							_pos = visiblePositionASL (vehicle _x);
							_pos set [2,(_pos select 2) + 1];
							_alpha = (25/_dst) min 1;
							_size = ((100/_dst) min 0.75) max 0.25;

							_cl = [0.8,0.6,0.2,_alpha];

							drawIcon3D [_x getVariable ["RYD_JR_myIcon","\A3\ui_f\data\map\markers\military\start_CA.paa"],_cl,ASLtoATL _pos,_size,_size,0,"",1,0.035,"PuristaMedium"];
							}
						}
					}
				}
			}
		}
	foreach RYD_JR_ShopBoxes;
	
		{
		if not (isNil {_x}) then
			{
			if ((typeName _x) in [(typeName objNull)]) then
				{
				if not (isNull _x) then
					{
					if ((alive _x) and {not ((_x in RYD_JR_MyPeople) or {(_x in RYD_JR_ReleasedPOW)})}) then
						{
						_dst = _x distance player;
						_mDst = 500;
						
						if (_dst < _mDst) then
							{
							_pos = visiblePositionASL (vehicle _x);
							_pos set [2,(_pos select 2) + 3];
							_alpha = (25/_dst) min 1;
							_size = ((100/_dst) min 0.75) max 0.25;

							_cl = [0.1,0.8,0.3,(_alpha max 0.2)];
							_size = _size max 0.35;

							drawIcon3D [_x getVariable ["RYD_JR_myIcon","\A3\ui_f\data\map\markers\military\warning_CA.paa"],_cl,ASLtoATL _pos,_size,_size,0,"",1,0.035,"PuristaMedium"];
							}
						}
					}
				}
			}
		}
	foreach RYD_JR_Recruitable;
	
		{
		_unit = _x select 0;
		
		if not (isNil {_unit}) then
			{
			if ((typeName _unit) in [(typeName objNull)]) then
				{
				if not (isNull _unit) then
					{
					if (alive _unit) then
						{
						_text = _x select 1;
						_pos = visiblePositionASL (vehicle _unit);
						_pos set [2,(_pos select 2) + 2.4];
						_dst = _unit distance player;
						_size = ((50/_dst) min 0.75) max 0.25;
						_reputation = _x select 2;
						_cl = [0.5,0.8,0.8,0.9];

						switch (true) do
							{
							case (_reputation < -50) : {_cl = [0.8,0.2,0.1,0.9]};
							case (_reputation < -20) : {_cl = [0.8,0.5,0.3,0.9]};
							case (_reputation > 50) : {_cl = [0.1,0.8,0.2,0.9]};															
							case (_reputation > 20) : {_cl = [0.3,0.8,0.5,0.9]};
							};
				
						drawIcon3D ["#(argb,8,8,3)color(0,0,0,0)",_cl,ASLtoATL _pos,_size,_size,0,_text,1,0.035,"TahomaB"];
						
						_age = (time - (_unit getVariable ["RYD_JR_Commented",0]));
						
						if (_age > 20) then
							{
							RYD_JR_Commenting set [_foreachIndex,0]
							}
						}
					else
						{
						RYD_JR_Commenting set [_foreachIndex,0]
						}
					}
				else
					{
					RYD_JR_Commenting set [_foreachIndex,0]
					}
				}
			else
				{
				RYD_JR_Commenting set [_foreachIndex,0]
				}
			}
		else
			{
			RYD_JR_Commenting set [_foreachIndex,0]
			}		
		}
	foreach RYD_JR_Commenting;
	
	RYD_JR_Commenting = RYD_JR_Commenting - [0];
	};
	
RYD_JR_Icons3Dc = 
	{
	//[] call RYD_JR_DisablePlayerCentering;
	
	if ((time - RYD_JR_LoadTime) < 15) exitWith {};
		
		{
		_unit = _x select 0;
		
		if not (isNil {_unit}) then
			{
			if ((typeName _unit) in [(typeName objNull)]) then
				{
				if not (isNull _unit) then
					{
					if (alive _unit) then
						{
						_text = _x select 1;
						_pos = visiblePositionASL (vehicle _unit);
						_pos set [2,(_pos select 2) + 2.4];
						_dst = _unit distance player;
						_size = ((50/_dst) min 0.75) max 0.25;
						_reputation = _x select 2;
						_cl = [0.5,0.8,0.8,0.9];

						switch (true) do
							{
							case (_reputation < -50) : {_cl = [0.8,0.2,0.1,0.9]};
							case (_reputation < -20) : {_cl = [0.8,0.5,0.3,0.9]};
							case (_reputation > 50) : {_cl = [0.1,0.8,0.2,0.9]};															
							case (_reputation > 20) : {_cl = [0.3,0.8,0.5,0.9]};
							};
				
						drawIcon3D ["#(argb,8,8,3)color(0,0,0,0)",_cl,ASLtoATL _pos,_size,_size,0,_text,1,0.035,"TahomaB"];
						
						_age = (time - (_unit getVariable ["RYD_JR_Commented",0]));
						
						if (_age > 20) then
							{
							RYD_JR_Commenting set [_foreachIndex,0]
							}
						}
					else
						{
						RYD_JR_Commenting set [_foreachIndex,0]
						}
					}
				else
					{
					RYD_JR_Commenting set [_foreachIndex,0]
					}
				}
			else
				{
				RYD_JR_Commenting set [_foreachIndex,0]
				}
			}
		else
			{
			RYD_JR_Commenting set [_foreachIndex,0]
			}		
		}
	foreach RYD_JR_Commenting;
	
	RYD_JR_Commenting = RYD_JR_Commenting - [0];
	};
	
RYD_JR_LazyTravelAction = 
	{
	hint format ["Waiting for map click. Fuel fund: %1 ff",RYD_JR_FuelFund];
	
	LTMarker = "LTMarker";
	LTMarker = createMarker [LTMarker,position player];
	LTMarker setMarkerColor "colorBlack";
	LTMarker setMarkerShape "ELLIPSE";
	LTMarker setMarkerBrush "SolidBorder";
	LTMarker setMarkerSize [((RYD_JR_FuelFund max 0) min RYD_JR_mapSize),((RYD_JR_FuelFund max 0) min RYD_JR_mapSize)];
	LTMarker setMarkerAlpha 0.25;
	
	openMap true;
	
	RYD_JR_LT = true;
	RYD_JR_LT2 = true;
	
	waitUntil
		{
		sleep 0.1;
		(not (visibleMap) or not (RYD_JR_LT2))
		};
		
	if (not (visibleMap) and (RYD_JR_LT2)) exitWith 
		{
		hint "Hitch-hiking cancelled";
		deleteMarker LTMarker;
		RYD_JR_LT = false;
		RYD_JR_LT2 = false;
		};
	};
	
RYD_JR_LazyTravel = 
	{
	switch (true) do
		{
		case (RYD_JR_HT) : 
			{
			if (RYD_JR_inStealth) exitWith {hint 'Enemy is too close - travel impossible.'};
			
			RYD_JR_TravelPos = [_pos,RYD_JR_Base] call RYD_JR_FindClosest;
			
			openMap false;
			};

		case (RYD_JR_LT) : 
			{
			if (RYD_JR_inStealth) exitWith {hint 'Enemy is too close - hitch-hiking impossible.'};
			if (surfaceIsWater _pos) exitWith {hint 'Destination must be on land.'};
			if ((_pos distance player) > RYD_JR_FuelFund) exitWith {hint 'Not enough funds. Select position inside dark circle.'};
			_nR = _pos nearRoads 100;
			if (count _nR < 1) exitWith {hint 'Too far from road.'};
			
			_travelpos = _pos;

			_veh = vehicle player;
			_vPos = getPosATL _veh;
			_asVeh = (assignedVehicle player);
			_size = 3;
			_dir = getDir _veh;
			
			if ((_asVeh isKindOf 'Ship') or (_asVeh isKindOf 'Air')) then
				{
				_asVeh = objNull
				};
				
			switch (isNull _asVeh) do
				{
				case (false) : 
					{
					_cl = [_pos,_nR] call RYD_JR_FindClosest;
					_next = roadsConnectedTo _cl;
					_ct = count _next;
					
					while {(count _next) > 1} do
						{
						_cl2 = [_vPos,_next] call RYD_JR_FindClosest;
						_next = _next - [_cl2];
						_ct = _ct - 1;
						if (_ct < -2) exitWith {}
						};
						
					_next = _next select 0;
					
					_travelPos = position _cl;
					_dir = [_travelPos,position _next,3] call RYD_JR_AngTowards
					};
					
				case (true) : {_travelPos = [_pos,0,60,_size,0,3,0] call BIS_fnc_findSafePos};
				};
				
			_travelPos set [2,0];
			_cost = _travelPos distance player;	
			if (_cost > (RYD_JR_FuelFund + 100)) exitWith {hint 'Suitable position not found. A more open space needed.'};
			RYD_JR_LT2 = false;
			
			[_asVeh,_travelPos,_cost,_dir] spawn RYD_JR_HH;
			};
			
		case (_shift) :
			{
			if not (RYD_JR_NoMarkers) then
				{
				_gp = group player;
				_pos = [_pos select 0,_pos select 1];
				_aPos = getPosATL player;
				_aPos resize 2;

				((waypoints _gp) select 0) setWaypointPosition [_aPos,0];

				_wp = _gp addWaypoint [_pos,0];
				_wp setWaypointType 'MOVE';
				_wp setWaypointStatements ['true','deleteWaypoint [(group this),0]']
				}			
			}
		};
		
	true
	};

RYD_JR_HH = 
	{
	_asVeh = _this select 0;
	_travelPos = _this select 1;
	_cost = round (_this select 2);
	_dir = _this select 3;

	RYD_JR_FTDistance = RYD_JR_FTDistance + _cost;
	RYD_JR_FuelFundSpent = RYD_JR_FuelFundSpent + (_cost min RYD_JR_FuelFund);
	RYD_JR_FuelFund = (RYD_JR_FuelFund - _cost) max 0; 
	
	openMap false;
	deleteMarker LTMarker;

	_txt = "Hitch-hiking...";
	0.5 fadeSound 0;
	TitleText [_txt,"BLACK OUT",0.55];
	
	sleep 0.6;
	
		{
		switch (true) do
			{
			case (isNil {_x}) : {RYD_JR_MyPeople set [_foreachIndex,0]};
			case (isNull _x) : {RYD_JR_MyPeople set [_foreachIndex,0]};
			case not (alive _x) : {RYD_JR_MyPeople set [_foreachIndex,0]};
			}
		}
	foreach RYD_JR_MyPeople;
	
	RYD_JR_MyPeople = RYD_JR_MyPeople - [0];
	
	_vehs = [];
	_vp = assignedVehicle player;
	_dt = player distance _vp;
	if ((_vp isKindOf "Ship") or (_dt > 250)) then 
		{
		_vp = objNull
		};
		
	if not (isNull _vp) then
		{
		if not (player in _vp) then
			{
			player moveInAny _vp
			}
		}
	else
		{
		_vp = vehicle player;
		
		if (_vp isKindOf "Ship") then 
			{
			_vp = player;
			}
		};
	
		{
		_vh = assignedVehicle _x;
		_dt = _x distance _vh;
		if ((_vh isKindOf "Ship") or (_dt > 250)) then 
			{
			_vh = objNull
			};
		
		if not (isNull _vh) then
			{
			if not (_vh in _vehs) then
				{
				_vehs pushBack _vh
				};
				
			if not (_x in _vh) then
				{
				_x moveInAny _vh
				}
			}
		else
			{
			_vh = vehicle _x;
			if (_vh isKindOf "Ship") then 
				{
				_vh = _x;
				};
			
			if not (_vh in _vehs) then
				{
				_vehs pushBack _vh
				}
			}
		}
	foreach RYD_JR_MyPeople;
		
	_vehs = _vehs - [_vp];
	_lastV = _vp;
	
	_vp setDir _dir;
	_vp setPos _travelPos;
		
		{
		if not (_x isKindOf "Ship") then
			{
			_x setDir _dir;
			_gap = ((sizeOf (typeOf _lastV)) + (sizeOf (typeOf _x)))/1.5;
			_cPos = [position _lastV,_dir + 180,_gap] call RYD_JR_PosTowards2D;
			_cPos = [_cPos,2] call RYD_JR_RandomAround;

			if not (_x isKindOf "Man") then
				{
				_ct = 0;
				
				while {not (isOnRoad _cPos)} do
					{
					_cPos = [_travelPos,_gap,30] call RYD_JR_RandomAroundMM;
					_ct = _ct + 1;
					if (_ct > 20) exitWith {};
					}
				};

			_lastV = _x;
			_x setPos _cPos;
			}		
		}
	foreach _vehs;
	
	sleep 0.1;
		
	0.5 fadeSound 1;
	TitleText [_txt,"BLACK IN",0.55];
	
	_txt = format ["You've arrived at your chosen location. Total fuel cost: %1 funds left: %2",_cost,RYD_JR_FuelFund];
	
	sleep 1;
	
	TitleText [_txt,"PLAIN",5];
	
	sleep 5;
	
	TitleText ["","PLAIN",0];
	
	RYD_JR_LT = false;
	};
	
RYD_JR_Wait = 
	{
	if (RYD_JR_inStealth) exitWith {hint "You can't wait - enemies nearby."};
	
	RYD_JR_isWaiting = true;
	_txt = "Waiting...";
	0.5 fadeSound 0;
	TitleText [_txt,"BLACK OUT",0.55];
	sleep 1;
	skipTime 1;
	0.5 fadeSound 1;
	TitleText [_txt,"BLACK IN",0.55];
	_txt = "One hour later...";
	sleep 0.6;
	TitleText [_txt,"PLAIN",0.55];
	
	RYD_JR_isWaiting = false;
	};
	
RYD_JR_WaitSix = 
	{
	if (RYD_JR_inStealth) exitWith {hint "You can't wait - enemies nearby."};
	
	RYD_JR_isWaiting = true;
	_txt = "Waiting...";
	0.5 fadeSound 0;
	TitleText [_txt,"BLACK OUT",0.55];
	sleep 1;
	skipTime 6;
	0.5 fadeSound 1;
	TitleText [_txt,"BLACK IN",0.55];
	_txt = "Six hours later...";
	sleep 0.6;
	TitleText [_txt,"PLAIN",0.55];
	
	RYD_JR_isWaiting = false;
	};
	
RYD_JR_Inspect = 
	{
	_items = items player;
	_items2 = [];
	
		{
		_items2 pushBack (toLower _x)
		}
	foreach _items;
	
	_items = _items2;
	
	_hasTK = "toolkit" in _items;
	
	if not (((RYD_JR_Difficulty < 3) or {(_hasTK)}) or {((fuel _veh) < 1)}) exitWith 
		{
		TitleText [_txt,"BLACK IN",0.55];
		
		_txt = "Inspection ineffective";
		
		sleep 1;
		
		TitleText [_txt,"PLAIN",3];

		sleep 3;

		TitleText ["","PLAIN",0];
		};
	
	RYD_JR_FuelFundSpent = RYD_JR_FuelFundSpent + (1000 min RYD_JR_FuelFund);
	RYD_JR_FuelFund = (RYD_JR_FuelFund - 1000) max 0;
	
	_veh = assignedVehicle player;

	_rep = "";

	if ((RYD_JR_Difficulty < 3) or {(_hasTK)}) then
		{
		_totDam = 0;
		
		_damParts = (getAllHitPointsDamage _veh) select 2;
		
			{
			_totDam = _totDam + _x
			}
		foreach _damParts;
		
		if ((_totDam > 0) or not (canMove _veh) or not (canFire _veh)) then
			{
			_rep = " Repairing...";
			};
			
		_mpl = 1;
		if (_hasTK) then {_mpl = 2};
			
		if not (RYD_JR_Difficulty < 2) then
			{	
			//_veh setDamage (((damage _veh) - ((0.1 + (random 0.2)) * _mpl)) max 0);
			
				{
				_veh setHitIndex [_foreachIndex,(((_veh getHitIndex _foreachIndex) - ((0.1 + (random 0.2)) * _mpl)) max 0)];
				}
			foreach _damParts
			}
		else
			{
			if (_hasTK) then {_mpl = 5};
			//_veh setDamage (((damage _veh) - ((0.01 + (random 0.02)) * _mpl)) max 0);
			
				{
				_veh setHitIndex [_foreachIndex,(((_veh getHitIndex _foreachIndex) - ((0.01 + (random 0.02)) * _mpl)) max 0)];
				}
			foreach _damParts
			}
		};
		
	_ref = "";

	if ((fuel _veh) < 1) then
		{
		_ref = " Refueling...";
		_veh setFuel (((fuel _veh) + (0.01 + (random 0.01))) min 1)
		};

	_txt = format ["Inspecting...%1%2",_rep,_ref];

	TitleText [_txt,"BLACK OUT",0.55];

	sleep 0.7;

	TitleText [_txt,"BLACK IN",0.55];
	
	_txt = "Inspection complete";
	
	sleep 1;
	
	TitleText [_txt,"PLAIN",3];

	sleep 3;

	TitleText ["","PLAIN",0];
	};
	
RYD_JR_WindRose = 
	{
	private ["_dir","_dirName"];
	
	_dir = _this select 0;
	
	_dirName = "";
	
	switch (true) do
		{
		case ((_dir >= 337.5) or (_dir < 22.5)) : {_dirName = "north"};
		case ((_dir < 67.5) and (_dir >= 22.5)) : {_dirName = "north-east"};
		case ((_dir < 112.5) and (_dir >= 67.5)) : {_dirName = "east"};
		case ((_dir < 157.5) and (_dir >= 112.5)) : {_dirName = "south-east"};
		case ((_dir < 202.5) and (_dir >= 157.5)) : {_dirName = "south"};
		case ((_dir < 247.5) and (_dir >= 202.5)) : {_dirName = "south-west"};
		case ((_dir < 292.5) and (_dir >= 247.5)) : {_dirName = "west"};
		case ((_dir < 337.5) and (_dir >= 292.5)) : {_dirName = "north-west"};
		};
		
	_dirName
	};
	
RYD_JR_HitReport = 
	{
	if ((count _this) < 2) exitWith {["",100]};
	
	_tgt = _this select 0;
	
	if not ((typeName _tgt) in [typeName objNull]) exitWith {["",100]};
	if (isNull _tgt) exitWith {["",100]};
	
	_shooter = _this select 1;
	
	if not ((typeName _shooter) in [typeName objNull]) exitWith {["",100]};
	if (isNull _shooter) exitWith {["",100]};

	_dst = (round (_tgt distance _shooter)) max 10;
	_vel = (abs ([0,0,0] distance (velocity _tgt))) max 0;

	_evaluation = _dst * (1 + _vel);

	_selection = "kill";

	_hp = _tgt getVariable "RYD_JR_HDEH";
	
	if not (isNil "_hp") then
		{
		_tgt removeEventHandler ["Killed",_hp];
		};
		
	_tgt setVariable ["RYD_JR_HDEH",nil];
	
	_evaluation = _evaluation * 2;
		
	_ifHidden = "";
	_knows = (group _tgt) knowsAbout _shooter;

	if (_knows < 1.5) then 
		{
		_ifHidden = " by surprise";
		_evaluation = _evaluation * 1.5
		};
		
	_evaluation = ceil _evaluation;
	
	_dstDescr = "Close distance ";
	_sign = ".";
	
	switch (true) do
		{
		case ((_dst > 250) and (_dst < 500)) : {_dstDescr = "Medium distance "};
		case ((_dst > 500) and (_dst < 750)) : {_dstDescr = "Far "};
		case ((_dst >= 750) and (_dst < 1200)) : {_dstDescr = "Very far "};
		case (_dst >= 1200) : {_dstDescr = "Extremely far ";_sign = "!"};
		};
		
	_evaluation = (ceil (_evaluation/100)) * 100;
	
	_txt = format ["%1%2%5%3\n %4 meters%3\nEvaluation: %6",_dstDescr,_selection,_sign,_dst,_ifHidden,_evaluation];
	
	[_txt,_evaluation]
	};
	
RYD_JR_KillIntel = 
	{	
	if ((count _this) < 2) exitWith {};
	
	_unit = _this select 0;
	
	if (isNil "_unit") exitWith {};
	if (isNull _unit) exitWith {};
	
	_arr = _this call RYD_JR_HitReport;
	
	if (isNil "_arr") then {_arr = ["",100]};
	if ((count _arr) < 2) exitWith {};
	
	if (alive _unit) exitWith {};
	
	_gp = group _unit;
	
	_killer = _this select 1;
	
	if (isNil "_killer") exitWith {};
	if (isNull _killer) exitWith {};
		
	_mk = _unit getVariable ["RYD_JR_MyKillMark",""];
	
	deleteMarker _mk;
	
	RYD_JR_ActualTargets = RYD_JR_ActualTargets - [_gp];
	RYD_JR_NearTargets = RYD_JR_NearTargets - [_unit];
		
	if not (isPlayer _killer) exitWith
		{
		RYD_JR_LastChat = time;
		TitleText ["Criminal, you had to kill, is dead already. Therefore offer has expired.","PLAIN DOWN", 2];
		};
		
	_txt = _arr select 0;
	_sum = _arr select 1;
	
	if (isNil "_sum") then {_sum = 100};
	if not ((typeName _sum) in [typeName 0]) then {_sum = 100};
	
	[_txt,_sum] spawn RYD_JR_KillResult	
	};
	
RYD_JR_KillResult = 
	{
	_txt = _this select 0;
	_sum = _this select 1;
	
	RYD_JR_LastChat = time;
	
	sleep (2 + (random 3));
	
	TitleText [_txt,"PLAIN DOWN", 1];
	
	sleep 10;
			
	TitleText ["OK. Target eliminated. Soon I should receive that information and my payment.","PLAIN DOWN", 2];
	
	_event = [5 + (random 5),getPosATL player,time];
	RYD_JR_RepEvents pushBack _event;
		
	sleep (10 + (random 20));
	
	["sonar",3] spawn RYD_JR_Sound3D;
	
	sleep 0.02;
	
	_txt = format ["You have new email. Account: +%1 ff.",_sum];

	RYD_JR_FuelFund = RYD_JR_FuelFund + _sum;
	RYD_JR_FuelFundGain = RYD_JR_FuelFundGain + _sum;
	
	RYD_JR_Caller customChat [RYD_JR_RadioPhone,_txt];
	
	_aID = player addAction ["<t color='#d0a900'>Check e-mail</t>", "IntelCheck.sqf", [false,civilian,"ask"], 1, false, true, "", "(alive _target)"];
	};
	
RYD_JR_EnemyData = 
	{
	RYD_JR_FuelFund = RYD_JR_FuelFund - 600;
	RYD_JR_FuelFundSpent = RYD_JR_FuelFundSpent + 600;
	
	sleep 0.5;
		
	["sonar",3] spawn RYD_JR_Sound3D;
	
	sleep 0.02;
	
	RYD_JR_Caller customChat [RYD_JR_RadioADMa,format ["Item 'Recent hostile presence location on Altis (unknown, acc. 500m)' bought for 600 ff. Map updated. Your current account: %1 ff.",RYD_JR_FuelFund]];

	[] call RYD_JR_EnemyDataMark
	};
	
RYD_JR_EnemyDataMark = 
	{
		{
		switch (true) do
			{
			case (isNil {_x}) : {RYD_JR_allEnemy set [_foreachIndex,0]};
			case (isNull _x) : {RYD_JR_allEnemy set [_foreachIndex,0]};
			case (({alive _x} count (units _x)) < 1) : {deleteGroup _x;RYD_JR_allEnemy set [_foreachIndex,0]};
			}
		}
	foreach RYD_JR_allEnemy;
	
	RYD_JR_allEnemy = RYD_JR_allEnemy - [0];
	
	_enemy = RYD_JR_allEnemy - RYD_JR_LocatedGroups;

	_gp = _enemy select (floor (random (count _enemy)));
	
	RYD_JR_LocatedGroups pushBack _gp;
	RYD_JR_LocatedGroupsN = RYD_JR_LocatedGroupsN + 1;
	
	_pos = [(getPosATL (vehicle (leader _gp))),250] call RYD_JR_RandomAround;
	_pos resize 2;
	
	_i = "EnemyMark_" + (str _pos);
	_i = createMarker [_i,_pos];
	_i setMarkerColor "colorRed";
	_i setMarkerShape "ELLIPSE";
	_i setMarkerBrush "FDiagonal";
	_i setMarkerSize [250,250];	
	};
	
RYD_JR_VehicleData = 
	{
	RYD_JR_FuelFund = RYD_JR_FuelFund - 1200;
	RYD_JR_FuelFundSpent = RYD_JR_FuelFundSpent + 1200;
	
	sleep 0.5;
	
	["sonar",3] spawn RYD_JR_Sound3D;
	
	sleep 0.02;
	
	RYD_JR_Caller customChat [RYD_JR_RadioADMa,format ["Item 'Abandoned vehicle: location on Altis (unknown, acc. 100m)' bought for 1200 ff. Map updated. Your current account: %1 ff.",RYD_JR_FuelFund]];
	
		{
		switch (true) do
			{
			case (isNil {_x}) : {RYD_JR_AllEV set [_foreachIndex,0]};
			case not ((typeName _x) isEqualTo (typeName objNull)) : {RYD_JR_AllEV set [_foreachIndex,0]};
			case (isNull _x) : {RYD_JR_AllEV set [_foreachIndex,0]};
			case not (alive _x) : {RYD_JR_AllEV set [_foreachIndex,0]};
			case (_x == (assignedVehicle player)) : {RYD_JR_AllEV set [_foreachIndex,0]};
			}
		}
	foreach RYD_JR_AllEV;
	
	RYD_JR_AllEV = RYD_JR_AllEV - [0];
	
	_vehs = RYD_JR_AllEV - RYD_JR_LocatedVehs;

	_veh = _vehs select (floor (random (count _vehs)));
	
	if (RYD_JR_Difficulty < 2) then
		{
		_veh = ([(position player),_vehs] call RYD_JR_FindClosestWithIndex) select 0;
		};
		
	RYD_JR_LocatedVehs pushBack _veh;
	RYD_JR_LocatedVehsN = RYD_JR_LocatedVehsN + 1;
	
	_pos = [(getPosATL _veh),100] call RYD_JR_RandomAround;
	_pos resize 2;
		
	_i = "CarMark_" + (str _pos);
	_i = createMarker [_i,_pos];
	_i setMarkerColor "Color3_FD_F";
	_i setMarkerShape "ICON";
	_i setMarkerType "c_car";
	_i setMarkerSize [1,1];
	};
	
RYD_JR_Sound3D = 
	{
	_snd = _this select 0;
	_wait = _this select 1;
	
	if not (isNull RYD_JR_SoundO) then
		{
		detach RYD_JR_SoundO;
		deleteVehicle RYD_JR_SoundO
		};
	
	RYD_JR_SoundO = "EmptyDetector" createVehicle position player;
	RYD_JR_SoundO attachTo [player,[0,0,1]];
	
	RYD_JR_SoundO say3D _snd;
	sleep _wait;
	detach RYD_JR_SoundO;
	deleteVehicle RYD_JR_SoundO
	};
	
RYD_JR_CellRing = 
	{
	_tme = _this select 0;
	_caller = _this select 1;
	
	RYD_JR_RingO = "EmptyDetector" createVehicle position player;
	
	RYD_JR_RingO attachTo [player,[0,0,1]];
	
	RYD_JR_Caller customChat [RYD_JR_RadioPhone,format ["%1 is calling...",_caller]];
	
	_stoper = time;
	
	waitUntil
		{
		RYD_JR_RingO say3D "ring";
		
		sleep 3;
		
		((isNull RYD_JR_RingO) or {((time - _stoper) > _tme)})
		};
		
	RYD_JR_callPending = false
	};
	
RYD_JR_CPSetup =
	{
	private ["_pos","_gp","_cp","_veh","_center","_cDir","_posS","_class","_unit","_dir","_wPos","_classArr","_side","_staticW","_nR","_cR","_rC","_mPos","_fe","_clR","_nextR","_camo","_cnt","_stuffArr","_stuff",
		"_addDir","_LOSpos","_isLOS","_ct"];
	
	_pos = _this select 0;
	_side = _this select 1;
	
	_staticW = ["O_HMG_01_high_F","O_GMG_01_high_F"];
	
	if (_side == resistance) then
		{	
		_staticW = ["I_HMG_01_high_F","I_GMG_01_high_F"];
		};
	
	_cp = [];
	
	_nR = _pos nearRoads 60;
	_cR = objNull;
	_center = objNull;
	_cDir = 0;
	_rC = [];

		{
		_rC = roadsConnectedTo _x;
		if ((count _rC) > 2) exitWith {_cR = _x};
		}
	foreach _nR;
	
	_mPos = getPosATL _cR;

	_pos = [_mPos,30,60] call RYD_JR_RandomAroundMM;
	_fe = (count (_pos isFlatEmpty [12,0,1.5,10,0,false,objNull])) > 0;
	_ct = 0;

	while {((isOnRoad _pos) or not (_fe) or ((count (_pos nearRoads 20)) > 0))} do
		{
		_ct = _ct + 1;
		if (_ct > 48) exitWith {};
		_pos = [_mPos,30 + (_ct/8),60 + (_ct/4)] call RYD_JR_RandomAroundMM;
		_fe = (count (_pos isFlatEmpty [12,0,1.5,10,0,false,objNull])) > 0;
		};
		
	if not ((isOnRoad _pos) or not (_fe) or ((count (_pos nearRoads 20)) > 0)) then
		{
		_clR = [_pos,_rC] call RYD_JR_FindClosest;
		
		_rct = (roadsConnectedTo _clR) - [_cR];
		
		if ((count _rct) < 1) exitWith {};
		
		_nextR = _rct select 0;
		
		_dir = (abs ([getPosATL _clR,getPosATL _nextR,0] call RYD_JR_AngTowards)) + 90;
		
		_camo = "CamoNet_OPFOR_open_F";
		if (_side == resistance) then
			{
			_camo = "CamoNet_INDP_open_F"
			};
			
		_veh = createVehicle [_camo, _pos, [], 0, "NONE"];
		
		_cp pushBack _veh;
		
		_center = _veh;
		_cDir = _dir;
			
		_veh setDir _dir;
		_pos = getPos _veh;
		_pos set [2,-0.01];
		_veh setPos _pos;
		_veh setVectorUP (surfaceNormal [_pos select 0,_pos select 1]);
		};
				
	_gp = grpNull;
	
	if not (isNull _center) then
		{

			{
			if (_foreachIndex in [0,1]) then
				{
				_posS = _center modelToWorld (_x select 1);
				//_fe = (count (_posS isflatempty [2,0,0.5,2,0,false,_center])) > 0;
				_fe = not (isOnRoad _posS);
				
				if (_fe) then
					{
					_classArr = (_x select 0) select 0;
					if (_side == east) then
						{
						_classArr = (_x select 0) select 1
						};
						
					_class = _classArr select (floor (random (count _classArr)));
					
					if (isNull _gp) then
						{
						_gp = createGroup _side; 
						};
						
					_unit = _gp createUnit [_class, _posS, [], 0, "NONE"];
					
					[_unit,false] call RYD_JR_DecimateGear;
					
					_dir = ((_x select 2) + _cDir);
					_wPos = [_posS,_dir,10] call RYD_JR_PosTowards2D;
					_wPos set [2,1.5];
					
					_unit setDir _dir;
					_unit doWatch _wPos;
					_unit setVariable ["RYD_JR_Watched",_wPos];
					
					[_gp] call RYD_JR_WPdel;
					}
				}
			else
				{
				if (_foreachIndex == ((count RYD_JR_CPStuff) - 1)) then
					{
					_posS = _center modelToWorld (_x select 1);
					//_fe = (count (_posS isFlatEmpty [1,0,0.1,1,0,false,_center])) > 0;
					_fe = not (isOnRoad _posS);
					
					if (_fe) then
						{		
						_classArr = (_x select 0) select 0;
						if (_side == east) then
							{
							_classArr = (_x select 0) select 1
							};
							
						_posS = [_posS,0,40,4,0,4,0] call BIS_fnc_findSafePos;
						
						_class = _classArr select (floor (random (count _classArr)));
						_veh = createVehicle [_class, _posS, [], 0, "NONE"];
						//_cp pushBack _veh;
						_dir = ((_x select 2) + _cDir);						
						_veh setDir _dir;
						
						_posS set [2,0.1];
		
						_veh setPos _posS;
						_veh setVectorUP (surfaceNormal [_posS select 0,_posS select 1]);
						
						clearItemCargo _veh;
						clearWeaponCargo _veh;
						clearMagazineCargo _veh;
						
						if not (RYD_JR_RealLoot) then
							{					
							_cnt = ceil ((floor (random 2)) - 1.85);
							
							if (_cnt > 0) then
								{
								_stuff = RYD_JR_AllWeapons select (floor (random (count RYD_JR_AllWeapons)));
								_veh addWeaponCargo [_stuff,_cnt];
								
								_stuffArr = configFile >> "CfgWeapons" >> _stuff >> "magazines";
								
								if (isArray _stuffArr) then
									{
									_stuffArr = getArray _stuffArr;
									
									if ((count _stuffArr) > 0) then
										{
										_stuff = _stuffArr select (floor (random (count _stuffArr)));
										
										_veh addMagazineCargo [_stuff,ceil (random 6)]
										}
									}
								}
							else
								{
								_cnt = ceil ((floor (random 12)) - 6);
								
								if (_cnt > 0) then
									{
									_stuff = RYD_JR_AllAmmo select (floor (random (count RYD_JR_AllAmmo)));
										
									_veh addMagazineCargo [_stuff,_cnt]								
									}
								};
								
							_cnt = ceil ((floor (random 4)) - 1.75);
							
							if (_cnt > 0) then
								{
								for "_i" from 1 to _cnt do
									{
									_stuff = RYD_JR_AllItems select (floor (random (count RYD_JR_AllAmmo)));
										
									_veh addItemCargo [_stuff,1]									
									}
								}
							}
						else
							{
							[_veh,true] call RYD_JR_AddLootSingle
							};
						
						createVehicleCrew _veh;
						
							{
							[_x,false] call RYD_JR_DecimateGear;
							}
						foreach (crew _veh);
												
						_wPos = [_posS,_dir,10] call RYD_JR_PosTowards2D;
						_wPos set [2,1.5];
						
						if (isNull _gp) then
							{
							_gp = group _veh
							}
						else
							{
							(crew _veh) joinSilent _gp;
							};
						
							{
							_x doWatch _wPos;
							_x setVariable ["RYD_JR_Watched",_wPos];
							}
						foreach (crew _veh);
						
						//_gp addVehicle _veh;
						
						[(driver _veh)] orderGetIn false 

						}		
					}
				else
					{
					_posS = _center modelToWorld (_x select 1);
					//_fe = (count (_posS isFlatEmpty [3,0,0.5,3,0,false,_center])) > 0;
					_fe = not (isOnRoad _posS);
					
					if (_fe) then
						{
						_classArr = _x select 0;
							
						_class = _classArr select 0;

						if (_foreachIndex == 13) then
							{
							if (RYD_JR_RealLoot) then
								{
								_class = _classArr select 1
								}
							};
						
						_veh = createVehicle [_class, _posS, [], 0, "CAN_COLLIDE"];
												
						_cp pushBack _veh;
						_dir = ((_x select 2) + _cDir);						
						_veh setDir _dir;
						
						_posS set [2,-0.01];
						
						_veh setPos _posS;
						_veh setVectorUP (surfaceNormal [_posS select 0,_posS select 1]);
						
						
						if (_foreachIndex == 13) then
							{
							if (RYD_JR_RealLoot) then
								{
								[_veh,true] call RYD_JR_AddLootSingle;
								_aID = _veh addAction ["<t color='#d0a900'>Sell content</t>", "SellCargo.sqf", false, 1, false, true, "", ""];
								_veh allowDamage false;
								_veh setAmmoCargo (0.3 + (random 0.3))
								}
							}
						}							
					}
				}
			}
		foreach RYD_JR_CPStuff;

			{
			_nRpos = position _x;
			_nextR = (roadsConnectedTo _x) - [_cR];
			
			if ((count _nextR) < 1) then 
				{
				_nextR = (_nRpos nearRoads 100) - [_cR]
				};
				
			if ((count _nextR) < 1) exitWith {}; 

			_nextR = ((roadsConnectedTo (_nextR select 0)));
			if ((count _nextR) > 1) then {_nextR = _nextR - [_cR,_x]};

			if ((count _nextR) < 1) then 
				{
				_nearR = (_nRpos nearRoads 100) - [_cR,_x];
				_nextR = [_nRpos,_nearR] call RYD_JR_FindClosest
				}
			else
				{
				_nextR = _nextR select 0
				};
				
			_dir = random 360;
			
			if not ((isNil "_x") or {(isNil "_nextR") or {(isNull _x) or {(isNull _nextR)}}}) then
				{
				_dir = [getPosATL _x,getPosATL _nextR,0] call RYD_JR_AngTowards
				};
		
			_ct = 0;
			_addDir = 90;
			if ((random 100) < 50) then {_addDir = -90};
			
			_pos = [(getPosATL _nextR),_dir + _addDir,6] call RYD_JR_PosTowards2D;
			_LOSpos = ATLtoASL ([_pos,_dir,10] call RYD_JR_PosTowards2D);
			_isLOS = [ATLtoASL _pos,_LOSpos,1.5,1.5] call RYD_JR_LOSCheck;
			_fe = (count (_pos isflatempty [3,0,0.15,3,0,false,objNull])) > 0;
			
			while {((isOnRoad _pos) or not (_isLOS) or not (_fe))} do
				{
				_ct = _ct + 1;
				if (_ct > 48) exitWith {};
				_pos = [(getPosATL _nextR),4 + (_ct/8),8 + (_ct/4)] call RYD_JR_RandomAroundMM;
				_LOSpos = ATLtoASL ([_pos,_dir,10] call RYD_JR_PosTowards2D);
				_isLOS = [ATLtoASL _pos,_LOSpos,1.5,1.5] call RYD_JR_LOSCheck;
				_fe = (count (_pos isFlatEmpty [3,0,0.15,3,0,false,objNull])) > 0;
				};
			
			if not ((isOnRoad _pos) or not (_isLOS) or not (_fe)) then
				{
				_veh = createVehicle ["Land_BagFence_Round_F", _pos, [], 0, "NONE"];
				_cp pushBack _veh;
				_veh setDir (_dir + 180);
				_pos = getPos _veh;
				_pos set [2,-0.01];
				_veh setPos _pos;
				_veh setVectorUP (surfaceNormal [_pos select 0,_pos select 1]);
				
				_pos = _veh modelToWorld [0,0.5,0];
				_pos set [2,0];
				
				_LOSpos set [2,1.5];

				if ((random 100) > 40) then
					{
					_class = _staticW select (floor (random 2));
					
					_veh = createVehicle [_class, _pos, [], 0, "NONE"];
					
					_veh setDir _dir;
					_veh setPos _pos;
					_veh setVectorUP (surfaceNormal [_pos select 0,_pos select 1]);
					
					createVehicleCrew _veh;
					
						{
						[_x,false] call RYD_JR_DecimateGear;
						}
					foreach (crew _veh);
				
					if (isNull _gp) then
						{
						_gp = group _veh
						}
					else
						{
						(crew _veh) joinSilent _gp;
						};
						
					//_gp addVehicle _veh;
					
						{
						_x doWatch _LOSpos;
						_x setVariable ["RYD_JR_Watched",_LOSpos];
						}
					foreach (crew _veh);
					}
				else
					{
					_stuff = RYD_JR_CPStuff select 1;
					
					_classArr = (_stuff select 0) select 0;
					if (_side == east) then
						{
						_classArr = (_stuff select 0) select 1
						};
						
					_class = _classArr select (floor (random (count _classArr)));
										
					if (isNull _gp) then
						{
						_gp = createGroup _side; 
						};
						
					_unit = _gp createUnit [_class, _pos, [], 0, "NONE"];
					
					[_unit,false] call RYD_JR_DecimateGear;
					
					_unit setDir _dir;
					
					_unit doWatch _LOSpos;
					_unit setVariable ["RYD_JR_Watched",_LOSpos];
					doStop _unit;
					_unit setVariable ["RYD_JR_Stopped",true];
					
					[_gp] call RYD_JR_WPdel;
					}
				}
			}
		foreach _rC;
		}
	else
		{
		_pos = [_mPos,10,60] call RYD_JR_RandomAroundMM;
		_fe = (count (_pos isFlatEmpty [6,0,1.5,6,0,false,objNull])) > 0;
		_ct = 0;

		while {not (_fe)} do
			{
			_ct = _ct + 1;
			if (_ct > 48) exitWith {};
			_pos = [_mPos,30 + (_ct/8),60 + (_ct/4)] call RYD_JR_RandomAroundMM;
			_fe = (count (_pos isFlatEmpty [6,0,1.5,6,0,false,objNull])) > 0;
			};
			
		if (_fe) then
			{
			_stuff = RYD_JR_CPStuff select ((count RYD_JR_CPStuff) - 1);
			
			_classArr = (_stuff select 0) select 0;
			if (_side == east) then
				{
				_classArr = (_stuff select 0) select 1
				};
				
			//_posS = [_posS,0,20,5,0,5,0] call BIS_fnc_findSafePos;
			
			_class = _classArr select (floor (random (count _classArr)));
			_veh = createVehicle [_class, _pos, [], 0, "NONE"];
			//_cp pushBack _veh;
			_dir = random 360;						
			_veh setDir _dir;
			
			_pos set [2,0.1];

			_veh setPos _pos;
			_veh setVectorUP (surfaceNormal [_pos select 0,_pos select 1]);
			
			clearItemCargo _veh;
			clearWeaponCargo _veh;
			clearMagazineCargo _veh;
			
			_cnt = ceil ((floor (random 2)) - 1.85);
			
			if (_cnt > 0) then
				{
				_stuff = RYD_JR_AllWeapons select (floor (random (count RYD_JR_AllWeapons)));
				_veh addWeaponCargo [_stuff,_cnt];
				
				_stuffArr = configFile >> "CfgWeapons" >> _stuff >> "magazines";
				
				if (isArray _stuffArr) then
					{
					_stuffArr = getArray _stuffArr;
					
					if ((count _stuffArr) > 0) then
						{
						_stuff = _stuffArr select (floor (random (count _stuffArr)));
						
						_veh addMagazineCargo [_stuff,ceil (random 6)]
						}
					}
				}
			else
				{
				_cnt = ceil ((floor (random 12)) - 6);
				
				if (_cnt > 0) then
					{
					_stuff = RYD_JR_AllAmmo select (floor (random (count RYD_JR_AllAmmo)));
						
					_veh addMagazineCargo [_stuff,_cnt]								
					}
				};
				
			_cnt = ceil ((floor (random 4)) - 1.75);
			
			if (_cnt > 0) then
				{
				for "_i" from 1 to _cnt do
					{
					_stuff = RYD_JR_AllItems select (floor (random (count RYD_JR_AllAmmo)));
						
					_veh addItemCargo [_stuff,1]									
					}
				};

			createVehicleCrew _veh;
			
				{
				[_x,false] call RYD_JR_DecimateGear;
				}
			foreach (crew _veh);
			
			if (isNull _gp) then
				{
				_gp = group _veh
				}
			else
				{
				(crew _veh) joinSilent _gp;
				};
				
			//_gp addVehicle _veh;

			[(driver _veh)] orderGetIn false
			};		
		};
	
	RYD_JR_CPGroups pushBack _gp;
	
	_cp
	};
	
RYD_JR_CampFire_Smoke = 
	{
	_campF = _this select 0;
	
	while {not (isNull _campF)} do
		{
		_pos = getPosATL _campF;

		_smoke = "#particlesource" createVehicle _pos;
		_smoke setParticleParams [
			["\a3\Data_f\ParticleEffects\Universal\Universal", 16, 7, 48,0],
			"", 
			"Billboard", 
			20, 
			20, 
			[0,0,0.3],
			[0,0,0.3], 
			3,1.2,1,0.25, 
			[1,1,5,6], 
			[[0.9,0.9,0.9,0],[0.9,0.9,0.9,0.06],[0.95,0.95,0.95,0.012],[1,1,1,0.01]], 
			[0.25,0.125,0.1], 
			0.75, 
			0.2, 
			"", 
			"", 
			_campF,
			0,
			true,
			0,
			[[0,0,0,0]]
			];
			
		_smoke setParticleRandom [10, [0.2, 0.2, 0.1], [0.3, 0.3, 0.025], 0.25, 0.125, [0.01, 0.01, 0.01, 0.1], 0, 0, 10];
		_smoke setDropInterval 0.1; 		
				
		waitUntil
			{
			
			};
		}
	};
	
RYD_JR_CampfireSmoke = 
	{
	while {true} do
		{
		sleep 5;
		RYD_JR_CurrentCampfires = RYD_JR_CurrentCampfires - [objNull];
		
			{
			if not (isNull _x) then
				{
				_smoke = _x getVariable ["RYD_JR_mySmoke",objNull];
				
				if (inflamed _x) then
					{					
					if (isNull _smoke) then
						{
						_pos = getPosATL _x;
						_smoke = "#particlesource" createVehicle _pos;
						_smoke setParticleParams [
							["\a3\Data_f\ParticleEffects\Universal\Universal", 16, 7, 48,0],
							"", 
							"Billboard", 
							20, 
							20, 
							[0,0,0.3],
							[0,0,0.3], 
							3,1.2,1,0.25, 
							[1,1,5,6], 
							[[0.9,0.9,0.9,0],[0.9,0.9,0.9,0.06],[0.95,0.95,0.95,0.012],[1,1,1,0.01]], 
							[0.25,0.125,0.1], 
							0.75, 
							0.2, 
							"", 
							"", 
							_x,
							0,
							true,
							0,
							[[0,0,0,0]]
							];
							
						_smoke setParticleRandom [10, [0.2, 0.2, 0.1], [0.3, 0.3, 0.025], 0.25, 0.125, [0.01, 0.01, 0.01, 0.1], 0, 0, 10];
						_smoke setDropInterval 0.1;

						_x setVariable ["RYD_JR_mySmoke",_smoke]
						}
					}
				else
					{
					deleteVehicle _smoke
					};
				}
			}
		foreach RYD_JR_CurrentCampfires
		}
	};
	
/*RYD_JR_CampfireSmoke = 
	{
	_campF = _this select 0;
	
	sleep 0.1;
	
	_smoke = objNull;
	
	while {not (isNull _campF)} do
		{
		_pos = getPosATL _campF;

		_smoke = "#particlesource" createVehicle _pos;
		_smoke setParticleParams [
			["\a3\Data_f\ParticleEffects\Universal\Universal", 16, 7, 48,0],
			"", 
			"Billboard", 
			20, 
			20, 
			[0,0,0.3],
			[0,0,0.3], 
			3,1.2,1,0.25, 
			[1,1,5,6], 
			[[0.9,0.9,0.9,0],[0.9,0.9,0.9,0.06],[0.95,0.95,0.95,0.012],[1,1,1,0.01]], 
			[0.25,0.125,0.1], 
			0.75, 
			0.2, 
			"", 
			"", 
			_campF,
			0,
			true,
			0,
			[[0,0,0,0]]
			];
			
		_smoke setParticleRandom [10, [0.2, 0.2, 0.1], [0.3, 0.3, 0.025], 0.25, 0.125, [0.01, 0.01, 0.01, 0.1], 0, 0, 10];
		_smoke setDropInterval 0.1; 		
				
		waitUntil
			{
			sleep 5;
			
			((isNull _campF) or {not (inflamed _campF)})
			};
		
		deleteVehicle _smoke;
		if (isNull _campF) exitWith {};
		
		waitUntil
			{
			sleep 5;
			
			((isNull _campF) or {(inflamed _campF)})
			};		
		};
		
	deleteVehicle _smoke
	};*/
	
RYD_JR_Sherwood = 
	{
	private ["_pos","_gp","_cp","_veh","_center","_cDir","_posS","_class","_unit","_dir","_wPos","_classArr","_reloc","_boxes"];
	
	_pos = _this select 0;
	
	_reloc = false;
	
	_boxes = [];
	
	if ((count _this) > 1) then 
		{
		_reloc = _this select 1;
		};
		
	if (_reloc) then
		{
		_boxes = RYD_JR_PackedCPLoot;
		};

	_gp = grpNull;
	_cp = [];
	
	_veh = createVehicle ["FirePlace_burning_F", _pos, [], 0, "CAN_COLLIDE"];
	
	//if not (RYD_JR_isBlastcore) then
		//{
		RYD_JR_CurrentCampfires pushBack _veh;
		//[_veh] spawn RYD_JR_CampfireSmoke
		//};
	
	_cp pushBack _veh;
	_center = _veh;
	_center allowDamage false;
	
	_cDir = random 360;
	
	_veh setDir _cDir;
	_pos = getPos _veh;

	//_pos set [2,-0.001];
	_veh setPos _pos;

	_veh setVectorUP (surfaceNormal [_pos select 0,_pos select 1]);
		
		{
		if (_foreachIndex in [0,1,2]) then
			{
			if (_reloc) exitWith {};
			if ((count (units _gp)) < (random 10)) then
				{
				_posS = _center modelToWorld (_x select 1);
				_class = _x select 0;
				_class = _class select (floor (random (count _class))); 
				
				if (isNull _gp) then
					{
					_gp = createGroup resistance; 
					};
					
				_unit = _gp createUnit [_class, _posS, [], 0, "NONE"];
				
				[_unit,false] call RYD_JR_DecimateGear;
				
				_dir = ((_x select 2) + _cDir);
				_wPos = [_posS,_dir,10] call RYD_JR_PosTowards2D;
				_wPos set [2,1.5];
				
				_unit setDir _dir;
				_unit doWatch _wPos;
				_unit setVariable ["RYD_JR_Watched",_wPos];
				doStop _unit;
				_unit setVariable ["RYD_JR_Stopped",true];
				
				[_gp] call RYD_JR_WPdel;
				
				if ((random 100) > 40) then
					{
					_unit switchAction "SitDown";
					_unit getVariable ["RYD_JR_Sitting",true]
					}
				}
			}
		else
			{
			_posS = _center modelToWorld (_x select 1);
			_dir = ((_x select 2) + _cDir);
			
			_veh = objNull;
			
			if (not (_foreachIndex in [7,10]) or not (_reloc)) then
				{
				_classArr = _x select 0;
					
				_class = _classArr select (floor (random (count _classArr)));
				
				_veh = createVehicle [_class, _posS, [], 0, "CAN_COLLIDE"];
										
				_cp pushBack _veh;						
				_veh setDir _dir;
				
				_posS set [2,-0.01];
				
				_veh setPos _posS;
				_veh setVectorUP (surfaceNormal [_posS select 0,_posS select 1]);
				};
			
			switch (_foreachIndex) do
				{
				case (7) : 
					{
					if (_reloc) then
						{
						_veh = _boxes select 0;
						_veh hideObject false;
						_veh enableSimulation true;
						
						_cp pushBack _veh;						
						_veh setDir _dir;
						
						_posS set [2,-0.01];
						
						_veh setPos _posS;
						_veh setVectorUP (surfaceNormal [_posS select 0,_posS select 1]);						
						}
					else
						{
						_veh setAmmoCargo (0.3 + (random 0.3))
						};
						
					_veh allowDamage false;
					};
					
				case (8) : {_center setVariable ["RYD_JR_Parking",_veh]};
				
				//case (9) : {_aID = _veh addAction ["<t color='#d0a900'>Switch light</t>", "SwitchLamp.sqf", [], 1, false, true, "","(alive _target)"];};
				
				case (10) :
					{					
					if (_reloc) then
						{
						_veh = _boxes select 1;
						_veh hideObject false;
						_veh enableSimulation true;
						
						_cp pushBack _veh;						
						_veh setDir _dir;
						
						_posS set [2,-0.01];
						
						_veh setPos _posS;
						_veh setVectorUP (surfaceNormal [_posS select 0,_posS select 1]);	
						}
					else
						{
						clearItemCargo _veh;
						clearWeaponCargo _veh;
						clearMagazineCargo _veh;
						_aID = _veh addAction ["<t color='#d0a900'>Sell content</t>", "SellCargo.sqf", false, 1, false, true, "", "RYD_JR_HCSell"];
						
						if (RYD_JR_RealLoot) then
							{
							[_veh,true] call RYD_JR_AddLootSingle
							};
						};
						
					_veh allowDamage false;
					}
				}
			}				
		}
	foreach RYD_JR_CampStuff;
	
	_gp setBehaviour "SAFE";
	
	RYD_JR_CPGroups pushBack _gp;
	RYD_JR_Camps pushBack _center;
	_center setVariable ["RYD_JR_MyCP",_cp];
	
	_cp
	};
	
RYD_JR_HideoutTravel = 
	{
	_vh = assignedVehicle player;
	_vhp = _vh;
	
	_base = RYD_JR_Base select 0;
	_park = _base getVariable ["RYD_JR_Parking",_base];
	_pos = getPosATL _park;
	_dir = getDir _park;
	
	RYD_JR_HT = true;
		
	_dst = player distance _pos;
	
	if (not (RYD_JR_multiHC) and (_dst < 100)) exitWith {hint "You are too close";RYD_JR_HT = false};
		
	if (RYD_JR_multiHC) then
		{
		openMap true;
				
		hint "Choose hideout";
		
		waitUntil
			{
			sleep 0.1;
			not (visibleMap)
			}	
		};
				
	if not (isNil "RYD_JR_TravelPos") then
		{
		_base = RYD_JR_TravelPos;
		_park = _base getVariable ["RYD_JR_Parking",_base];
		_pos = getPosATL _park;
		_dir = getDir _park;
		RYD_JR_TravelPos = nil;
		}
	else
		{
		if (RYD_JR_multiHC) then
			{
			RYD_JR_HT = false;
			}
		};
		
	if not (RYD_JR_HT) exitWith {hint "Travel cancelled"};
	
	RYD_JR_HT = false;
				
	_txt = "Returning to the hideout...";
	0.5 fadeSound 0;
	TitleText [_txt,"BLACK OUT",0.55];
	
	sleep 0.6;
	
	_div = 15000;
		
		{
		switch (true) do
			{
			case (isNil {_x}) : {RYD_JR_MyPeople set [_foreachIndex,0]};
			case (isNull _x) : {RYD_JR_MyPeople set [_foreachIndex,0]};
			case not (alive _x) : {RYD_JR_MyPeople set [_foreachIndex,0]};
			}
		}
	foreach RYD_JR_MyPeople;
	
	RYD_JR_MyPeople = RYD_JR_MyPeople - [0];
	
	_vehs = [];
	_vp = assignedVehicle player;
	_dt = player distance _vp;
	if ((_vp isKindOf "Ship") or not (canMove _vp) or not ((fuel _vp) > 0) or (_dt > 250)) then 
		{
		_vp = objNull
		};
		
	if not (isNull _vp) then
		{
		if not (player in _vp) then
			{
			player moveInAny _vp
			}
		}
	else
		{
		_vp = vehicle player;
		
		if ((_vp isKindOf "Ship") or not (canMove _vp) or not ((fuel _vp) > 0)) then 
			{
			_vp = player;
			_div = 5000
			}
		};
	
		{
		_vh = assignedVehicle _x;
		_dt = _x distance _vh;
		if ((_vh isKindOf "Ship") or not (canMove _vh) or not ((fuel _vh) > 0) or (_dt > 250)) then 
			{
			_vh = objNull
			};
		
		if not (isNull _vh) then
			{
			if not (_vh in _vehs) then
				{
				_vehs pushBack _vh
				};
			
			if not (_x in _vh) then
				{
				_x moveInAny _vh
				}
			}
		else
			{
			_vh = vehicle _x;
			if ((_vh isKindOf "Ship") or not (canMove _vh) or not ((fuel _vh) > 0)) then 
				{
				_vh = _x;
				_div = 5000
				};
			
			if not (_vh in _vehs) then
				{
				_vehs pushBack _vh
				}
			}
		}
	foreach RYD_JR_MyPeople;
	
	_vehs = _vehs - [_vp];
	_lastV = _vp;

	_nE = _pos nearEntities [["AllVehicles"],5];
	_nE = _nE - [_park,_vhp,player];

	if ((count _nE) > 0) then
		{
		_size = (sizeOf (typeOf _vh))/2;
		_pos = [_pos,0,32,_size,0,_size/1.5,0] call BIS_fnc_findSafePos;
		};
	
	skipTime (_dst/_div);
	
	_vp setDir _dir;
	_vp setPos _pos;
		
		{
		if not (_x isKindOf "Ship") then
			{
			_x setDir _dir;
			_gap = ((sizeOf (typeOf _lastV)) + (sizeOf (typeOf _x)))/1.5;
			_cPos = [position _lastV,_dir,_gap] call RYD_JR_PosTowards2D;
			_cPos = [_cPos,2] call RYD_JR_RandomAround;
			
			_lastV = _x;

			_size = (sizeOf (typeOf _x))/2;
			_cPos = [_cPos,0,64,_size,0,_size/1.5,0] call BIS_fnc_findSafePos;
			
			_x setPos _cPos
			}		
		}
	foreach _vehs;
	
	RYD_JR_FTDistance = RYD_JR_FTDistance + _dst;
	
	sleep 10;
		
	0.5 fadeSound 1;
	TitleText [_txt,"BLACK IN",0.55];
	
	_txt = "You've arrived back at camp.";
	
	sleep 1;
	
	TitleText [_txt,"PLAIN",5];
	
	sleep 5;
	
	TitleText ["","PLAIN",0]
	};

RYD_JR_RestHeal = 
	{
	RYD_JR_isResting = true;

	_items = items player;

	_text = "Resting...";

	if (({_x in ["FirstAidKit","Medikit"]} count _items) > 0) then
		{
			{
			switch (true) do
				{
				case (isNil {_x}) : {RYD_JR_Mercs set [_foreachIndex,0]};
				case (isNull _x) : {RYD_JR_Mercs set [_foreachIndex,0]};
				case not (alive _x) : {RYD_JR_Mercs set [_foreachIndex,0]};
				}
			}
		foreach RYD_JR_Mercs;
		
		RYD_JR_Mercs = RYD_JR_Mercs - [0];
		
		if (({(damage _x) > 0} count (units (group player))) > 0) then
			{
			_text = _text + " Wound treatment...";
			player setDamage 0;
			if (RYD_JR_AIFriend) then
				{
				if not (isNull AIBuddy) then
					{
					if (alive AIBuddy) then
						{
						if ((AIBuddy distance player) < 200) then
							{
							AIBuddy setDamage 0
							}
						}
					}
				};
								
				{
				if ((_x distance player) < 200) then
					{
					_x setDamage 0
					}
				}
			foreach RYD_JR_Mercs;
				
			if not ("Medikit" in _items) then {player removeItem "FirstAidKit"}
			}
		};

	TitleText [_text,"BLACK OUT",1];

	sleep 1;

	skipTime 6;

	TitleText [_text,"BLACK IN",1];

	sleep 1;

	TitleText ["","PLAIN",0];

	RYD_JR_isResting = false;
	};
	
RYD_JR_Surrender = 
	{
	private ["_gp","_units","_mags"];
	
	_gp = _this select 0;
	
	if not ((typeName _gp) in [(typeName grpNull)]) exitWith {};
	
	_gp setVariable ["RYD_JR_Surrendered",true];
	
	_gp setBehaviour "CARELESS";
	_gp setCombatMode "BLUE";
	_gp setSpeedMode "LIMITED";
	
	_units = units _gp;
	
	_units orderGetIn false;
	_units allowGetIn false;

		{
		_reputation = [false,_x] call RYD_JR_CalculateRep;
		_x setVariable ["RYD_JR_Reputation",_reputation];									
		
		_aID = _x addAction ["<t color='#d0a900'>Release the captive</t>", "Leave.sqf", [], 1, false, true, "", "(alive _target)"];
		if ((random 100) < 100) then
			{
			_aID = _x addAction ["<t color='#d0a900'>Interrogate about your brother's death</t>", "IntelCheck.sqf", [false,side _x,"int"], 1, false, true, "", "(((player distance _target) < 3) and (alive _target))"];
			
			if (RYD_JR_GCIntel > 0) then
				{			
				if ((random 100) < (0.1 * RYD_JR_GCIntel)) then
					{
					_x setVariable ["RYD_JR_MoreIntel",true];
					}
				}
			};
		
		[_x] spawn
			{
			_unit = _this select 0;
			
			unassignVehicle _unit;
			_unit setCaptive true;
												
			_unit setVariable ["RYD_JR_Captive",true];
			
			waitUntil 
				{
				sleep 0.5;
				
				(_unit == (vehicle _unit))
				};
			
			_unit setUnitPos "UP";
			_unit forceSpeed 1.5;
			
			_unit doMove (position player);
			
			if (RYD_JR_Difficulty > 0) then
				{
				[_unit,true,0.25] call RYD_JR_DecimateGear
				};

			sleep (1 + (random 2));

			_weapons = weapons _unit;
			_mags = magazinesAmmoFull _unit;
			
			_gwh = createVehicle ["GroundWeaponHolder", (position _unit), [], 0, "NONE"];
			
			/*for "_a" from 0 to ((count _weapons) - 1) do
				{
				_weapon = _weapons select _a;
				_unit action ["dropWeapon", _gwh, _weapon] 
				};*/
				
			removeAllWeapons _unit;
			{_unit removeMagazine _x} forEach (magazines _unit);
			
				{
				_gwh addWeaponCargo [_x,1]
				}
			foreach _weapons; 
			
				{
				_mg = _x select 0;
				_gwh addMagazineCargo [_mg,1]
				}
			foreach _mags; 
				
			sleep (1 + (random 2));
					
			//_gwh = "GroundWeaponHolder" createVehicle position _unit;
			
				/*{
				_unit action ["dropMagazine", _gwh, _x];
				}
			foreach (magazines _unit);*/
			
			//sleep (1 + (random 2));
			
			if not (isNull (unitBackpack _unit)) then
				{
				_unit action ["DropBag", _gwh, typeOf (unitBackpack _unit)];
				};
				
			sleep (1 + (random 2));
			
			
			doStop _unit;
			_unit forceSpeed 0;
			_unit allowFleeing 0;
			_unit PlayAction "Surrender";
			
			RYD_JR_POW pushBack _unit;
			RYD_JR_NearCivs pushBack _unit;
			}
		}
	foreach (units _gp)
	};
			
RYD_JR_RestorePath = 
	{
	_gp = _this select 0;
	
	_decoyed = _gp getVariable ["RYD_JR_Decoyed",false];
	_ldr = leader _gp;
	
	waitUntil
		{
		sleep 5;
		
		(not (_decoyed) or {isNull (_ldr findNearestEnemy _ldr)})
		};
		
	if (_decoyed) then
		{
		_pos = _gp getVariable ["RYD_JR_DecoyedPos",position _ldr];
		_wp = _gp addWaypoint [_pos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointCombatMode "YELLOW";
		_wp setWaypointSpeed "NORMAL";
		_wp setWaypointStatements ["true","(group this) setVariable ['RYD_JR_Decoyed',false]"];
		_gp setCurrentWaypoint _wp;
		
		waitUntil
			{
			sleep 5;
			
			not (_gp getVariable ["RYD_JR_Decoyed",false])
			}
		};
	
	_wps = _gp getVariable ["RYD_JR_GpWps",[]];
	
		{
		_wp = _gp addWaypoint [(_x select 0), 0];
		_wp setWaypointType (_x select 1);
		_wp setWaypointBehaviour (_x select 2);
		_wp setWaypointCombatMode (_x select 3);
		_wp setWaypointSpeed (_x select 4);
		_wp setWaypointFormation (_x select 5);
		_wp setWaypointStatements (_x select 6);
		_wp setWaypointTimeout (_x select 7)
		}
	foreach _wps;
	
	RYD_JR_BusyPatrols = RYD_JR_BusyPatrols - [_gp];
	
	if (_decoyed) exitWith {};
	
	_caller = leader _gp;
	
	if (((side _caller) in RYD_JR_Freq) and {"ItemRadio" in (assignedItems player)}) then
		{	
		if ((player distance _caller) < 1500) then
			{			
			_sent = (name _caller) + "'s patrol completed supporting task. We're resuming routine itinerary, out.";
						
			[_sent,_caller] spawn
				{
				_sent = _this select 0;
				_caller = _this select 1;
				
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
						case (isNull (assignedVehicle _caller)) : {_alive = false};
						case not (alive (assignedVehicle _caller)) : {_alive = false};
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
		};
	
	[] spawn 
		{
		sleep (120 + (random 240));
		
		RYD_JR_PatrolCalled = false
		}
	};
	
RYD_JR_Response = 
	{
	private ["_gp","_pos","_wp","_wps","_wpsArr","_count","_ct","_caller","_sent","_caller0","_decoy","_dst","_ldr"];
	
	_gp = _this select 0;
	_pos = _this select 1;
	_caller0 = _this select 2;
	
	_decoy = false;
	_ldr = leader _gp;
	
	if ((count _this) > 3) then
		{
		_decoy = _this select 3
		};
	
	if (_gp in RYD_JR_BusyPatrols) exitWith {};
	RYD_JR_BusyPatrols pushBack _gp;

	_wps = waypoints _gp;
		
	_wpsArr = [];
	
		{
		_wpC = 
			[
			waypointPosition _x,
			waypointType _x,
			waypointBehaviour _x,
			waypointCombatMode _x,
			waypointSpeed _x,
			waypointFormation _x,
			waypointStatements _x,
			waypointTimeout _x
			];
		
		_wpsArr pushBack _wpC
		}
	foreach _wps;
	
	_gp setVariable ["RYD_JR_GpWps",_wpsArr];
	
	_count = (count (waypoints _gp)) - 1;
	_ct = _count;
	
	while {(_count >= 0)} do
		{
		deleteWaypoint ((waypoints _gp) select _count);
		_count = (count (waypoints _gp)) - 1;
		_ct = _ct - 1;
		if (_ct < -2) exitWith {}
		};
	
	if (_decoy) then
		{
		
			{
			_x forceSpeed -1;
			_x doMove (position _x);
			_x setUnitPos "AUTO";
			_x doWatch objNull
			}
		foreach (units _gp);
		}
	else
		{
		(units _gp) allowGetIn true;
		(units _gp) orderGetIn true;
		if not (isPlayer (leader _gp)) then {(assignedVehicle (leader _gp)) setFuel 1};
	
		_ct = time;
		
		waituntil
			{
			sleep 5;

			((({(_x == (vehicle _x))} count (units _gp)) == 0) or ((time - _ct) > 60))
			};
			
			{
			if ((vehicle _x) == _x) then
				{
				_x moveInCargo (assignedVehicle _x)
				}
			}
		foreach (units _gp);
		};
	
	if (RYD_JR_Debug) then
		{
		_i = "resMark_" + (str _pos);
		_i = createMarker [_i,_pos];
		_i setMarkerColor "colorOrange";
		_i setMarkerShape "ICON";
		_i setMarkerType "mil_triangle";
		_i setMarkerSize [0.9,0.9];
		_i setMarkertext "Armor Response"
		};
		
	_wp = _gp addWaypoint [_pos, 0];
		
	_type = "SAD";
	_bh = "SAFE";
	if (_decoy) then
		{
		//_type = "MOVE";
		_bh = "AWARE";
		_wp setWaypointTimeout [30, 60, 90];
		};
	
	_wp setWaypointType _type;
	_wp setWaypointBehaviour _bh;
	_wp setWaypointCombatMode "RED";
	_wp setWaypointSpeed "FULL";
	
	_gp setVariable ["RYD_JR_ResponseWP",_wp];
		
	_wp setWaypointStatements ["true","deleteWaypoint ((group this) getVariable ['RYD_JR_ResponseWP',[]]);[(group this)] spawn RYD_JR_RestorePath"];
	
	_caller = leader _gp;

	if ((((side _caller) in RYD_JR_Freq) and {("ItemRadio" in (assignedItems player)) and {not (_gp isEqualTo _caller0)}}) or {_decoy}) then
		{
		if ((player distance _caller) < 4500) then
			{
			(group _caller) setVariable ["RYD_JR_MyLastAlarmChat",time];
												
			_sent = (name _caller) + "'s patrol reports. Hold on, we're on the way, out.";
			
			if (_decoy) then
				{
				_dst = (ceil ((_caller distance _pos)/100)) * 100;
							
				_sent = format ["Wow! Did you heard that? We'll be rich! It's only %1 meters from us! Let's go! We have to be first there!",_dst]
				};

			[_sent,_caller,_decoy] spawn
				{
				_sent = _this select 0;
				_caller = _this select 1;			
				_decoy = _this select 2;
				
				sleep (random 10);
				
				_alive = true;
				
				waitUntil
					{
					sleep (3 + (random 3));
					
					switch (true) do
						{
						case (isNil "_caller") : {_alive = false};
						case not ((typeName _caller) isEqualTo (typename objNull)) : {_alive = false};
						case (isNull _caller) : {_alive = false};
						case not (alive _caller) : {_alive = false};
						case (isNull (group _caller)) : {_alive = false};
						case ((isNull (assignedVehicle _caller)) and {not _decoy}) : {_alive = false};
						case (not (alive (assignedVehicle _caller)) and {not _decoy}): {_alive = false};
						case (RYD_JR_Outro) : {_alive = false};
						};
					
					(not (_alive) or {((time - RYD_JR_LastComm) > 10) and {((group _caller) getVariable ["RYD_JR_Called",false]) or {_decoy}}})
					};				
				
				if not (_alive) exitWith {};
				
				(group _caller) setVariable ["RYD_JR_Called",false];
				
				RYD_JR_LastComm = time;
				
				["static1",2.5] spawn RYD_JR_Sound3D;
				sleep 0.02;												
				RYD_JR_Caller customChat [RYD_JR_RadioNeutral,_sent]
				}
			};
		};
	};
	
RYD_JR_AirResponse = 
	{
	private ["_vh","_gp","_units","_pos","_wp","_caller","_sent","_caller0","_eta","_etaR","_rest","_dummy","_add","_space","_add2"];
	
	_vh = _this select 0;
	_pos = _this select 1;
	_caller0 = _this select 2;

	_gp = group _vh;
	_units = units _gp;

	_units orderGetIn true;
	
	_wp = _gp addWaypoint [_pos, 0];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointSpeed "FULL";
	
	_gp setVariable ["RYD_JR_ResponseWP",_wp];
	
	_gp setCurrentWaypoint _wp;
	
	_wp setWaypointStatements ["true","deleteWaypoint ((group this) getVariable ['RYD_JR_ResponseWP',[]]);[(vehicle this)] spawn RYD_JR_Land"];
	
	_vh flyInHeight 100;
	
	_caller = leader _gp;
	
	if (((side _caller) in RYD_JR_Freq) and {"ItemRadio" in (assignedItems player) and {not (_caller0 isEqualTo _gp)}}) then
		{
		if ((player distance _caller) < 15000) then
			{
			(group _caller) setVariable ["RYD_JR_MyLastAlarmChat",time];
			
			_eta = 0.15 + (round ((((_vh distance _pos)/1000) * 0.3) * 10))/10;
			_etaR = floor _eta;
			_rest = (round ((_eta - _etaR) * 6)) * 10;
			_eta = _etaR;
			
			_dummy = "";		
			_add = " minutes";
			_space = " ";
			if (_eta < 2) then 
				{
				_add = " minute";
				if (_eta < 1) then
					{
					_add = "";
					_space = "";
					_eta = ""
					}
				};
				
			_add2 = " seconds";
			
			if (_rest < 10) then
				{
				_add2 = "";
				_rest = "";
				_space = "";
				
				if (_eta < 1) then
					{
					_dummy = "momentarily"
					}
				};
													
			_sent = (name _caller) + (format ["'s bird here. Hold on, aerial support inbound, ETA: %1%2%6%3%4%5. Out.",_eta,_add,_rest,_add2,_dummy,_space]);
			
			[_sent,_caller,_caller0] spawn
				{
				_sent = _this select 0;
				_caller = _this select 1;
				
				sleep (random 10);
				
				_alive = true;
				
				waitUntil
					{
					sleep (1 + (random 1));
					
					switch (true) do
						{
						case (isNil "_caller") : {_alive = false};
						case not ((typeName _caller) isEqualTo (typename objNull)) : {_alive = false};
						case (isNull _caller) : {_alive = false};
						case not (alive _caller) : {_alive = false};
						case (isNull (group _caller)) : {_alive = false};
						case (isNull (assignedVehicle _caller)) : {_alive = false};
						case not (alive (assignedVehicle _caller)) : {_alive = false};
						case (RYD_JR_Outro) : {_alive = false};
						};
					
					(not (_alive) or {((time - RYD_JR_LastComm) > 6) and {(group _caller) getVariable ["RYD_JR_Called",false]}})
					};				
				
				if not (_alive) exitWith {};

				(group _caller) setVariable ["RYD_JR_Called",false];
				
				RYD_JR_LastComm = time;
				
				["static1",2.5] spawn RYD_JR_Sound3D;
				sleep 0.02;												
				RYD_JR_Caller customChat [RYD_JR_RadioNeutral,_sent]
				}
			};
		};
	
	if (RYD_JR_Debug) then
		{
		_i = "resMark_" + (str _pos);
		_i = createMarker [_i,_pos];
		_i setMarkerColor "colorOrange";
		_i setMarkerShape "ICON";
		_i setMarkerType "mil_dot";
		_i setMarkerSize [0.9,0.9];
		_i setMarkertext "Air Response"
		};	
		
	};
	
RYD_JR_Land = 
	{
	_vh = _this select 0;
		
	_gp = group _vh;
	
	_lz = _vh getVariable ["RYD_JR_MyLZ",position _vh];
	
	_wp = _gp addWaypoint [_lz, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "CARELESS";
	_wp setWaypointCombatMode "YELLOW";
	_wp setWaypointSpeed "FULL";
	
	_gp setVariable ["RYD_JR_ResponseWP",_wp];
	
	_gp setCurrentWaypoint _wp;
	
	_wp setWaypointStatements ["true","{(vehicle _x) land 'LAND'} foreach (units (group this));deleteWaypoint ((group this) getVariable ['RYD_JR_ResponseWP',[]]);(group this) setVariable ['RYD_JR_LastCall',time];(vehicle this) setFuel 1;(vehicle this) setVehicleAmmo 1;RYD_JR_BusyHelis = RYD_JR_BusyHelis - [(group this)];(group this) setBehaviour 'AWARE';(group this) setCombatMode 'YELLOW'"];
	
	_caller = leader _gp;
	
	if (((side _caller) in RYD_JR_Freq) and {"ItemRadio" in (assignedItems player)}) then
		{
		if ((player distance _caller) < 15000) then
			{											
			_sent = (name _caller) + " completed Seek and Destroy run. We're RTB, out.";
			
			[_sent,_caller] spawn
				{
				_sent = _this select 0;
				_caller = _this select 1;
				
				sleep (random 10);
				
				_alive = true;
				
				waitUntil
					{
					sleep (3 + (random 3));
					
					switch (true) do
						{
						case (isNil "_caller") : {_alive = false};
						case not ((typeName _caller) isEqualTo (typename objNull)) : {_alive = false};
						case (isNull _caller) : {_alive = false};
						case not (alive _caller) : {_alive = false};
						case (isNull (group _caller)) : {_alive = false};
						case (isNull (assignedVehicle _caller)) : {_alive = false};
						case not (alive (assignedVehicle _caller)) : {_alive = false};
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
	};
	
RYD_JR_Airfield = 
	{
	private ["_pos","_groups","_type","_gp","_posS","_vh","_Bldngs","_posTaken","_posAll","_Bldg","_posAct","_ct","_bPos","_bld","_angle","_dst","_checkPos","_LOSpos","_isLOS","_fe",
	"_class","_size","_minefieldsAmount","_buffor","_mineT","_mfPos","_nR","_amnt","_mk","_hp","_types","_mPos","_toClear"];
	
	_pos = _this select 0;
	
	_Bldngs = _pos nearObjects ["HouseBase",300];
	
	_posAll = [];
	_toClear = [];

		{
		_Bldg = _x;

		if not (isNull _Bldg) then
			{
			_posAct = _Bldg buildingpos 0;
			_ct = 0;

			while {((_posAct distance [0,0,0]) > 0)} do 
				{
				_posAll set [(count _posAll),[_posAct,_Bldg]];
				_ct = _ct + 1;
				if (_ct > 100) exitWith {};
				_posAct = _Bldg buildingpos _ct;
				}
			}
		}
	foreach _Bldngs;
	
	if (RYD_JR_APRangeM > 0) then
		{
		_type = RYD_JR_Choppers select (floor (random (count RYD_JR_Choppers)));
		_vh = createVehicle [_type, _pos, [], 0, "NONE"];
		createVehicleCrew _vh;
		
			{
			[_x,false] call RYD_JR_DecimateGear;
			}
		foreach (crew _vh);
		
		_gp = (group _vh);
		
		RYD_JR_allEnemy pushBack _gp;
		RYD_JR_AllHelis pushBack _gp;
		
		_hp = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "CAN_COLLIDE"];
		_hp allowDamage false;
		
		_vh setVariable ["RYD_JR_MyLZ",position _hp];
		_gp setVariable ["RYD_JR_MyHeli",_vh];
		};
	
	_groups = RYD_JR_BBGuardGroups;
	
	_type = _groups select (floor (random (count _groups)));
	
	_posS = [_pos,50,200,3,0,10,0] call BIS_fnc_findSafePos;
		
	_gp = [_posS,_type select 0,_type select 1,nil,nil] call RYD_JR_SpawnGroupSafe;
			
	RYD_JR_allEnemy pushBack _gp;	
	RYD_JR_AllGarrisons pushBack _gp;
	_toClear pushBack _gp;

	for "_i" from 1 to 2 do
		{
		_groups = RYD_JR_BBGuardGroups;
		
		_type = _groups select (floor (random (count _groups)));
		
		_posS = [_pos,50,200,3,0,10,0] call BIS_fnc_findSafePos;
			
		_gp = [_posS,_type select 0,_type select 1,nil,nil] call RYD_JR_SpawnGroupSafe;
		
		RYD_JR_allEnemy pushBack _gp;
		_toClear pushBack _gp;
		
		[_gp,_posS,"MOVE","AWARE","YELLOW","LIMITED","STAG COLUMN",["true",""],true,50,300,5,3,2,true] call RYD_JR_SADPatrol;
			
		_posS = [_pos,50,300,6,0,6,0] call BIS_fnc_findSafePos;
		
		_type = RYD_JR_Armored select (floor (random (count RYD_JR_Armored)));
		_vh = createVehicle [_type, _posS, [], 0, "NONE"];
		createVehicleCrew _vh;
		
			{
			[_x,false] call RYD_JR_DecimateGear;
			}
		foreach (crew _vh);
		
		RYD_JR_allEnemy pushBack (group _vh);
		_toClear pushBack (group _vh);
		};
	
	_gp = createGroup east;
	
	_posS = [_pos,50,200,3,0,10,0] call BIS_fnc_findSafePos;
	
	_unit = _gp createUnit ["O_officer_F", _posS, [], 0, "NONE"];
	
	_unit setVariable ["RYD_JR_Warlord",true];

	if not (RYD_JR_GCIntel == 0) then
		{
		_unit setVariable ["RYD_JR_MoreIntel",true];
		_unit setVariable ["RYD_JR_EvenMoreIntel",true];
		};
	
	RYD_JR_allEnemy pushBack _gp;	
	_toClear pushBack _gp;
	
		{
		_unit setSkill [_x,1];
		}
	foreach ["general","aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding"];
	
	if ((count _posAll) > 0) then
		{
		_bPos = _posAll select (floor (random (count _posAll)));
		_bld = _bPos select 1;
		_bPos = _bPos select 0;
		
		_tkn = false;
		
		_posTaken = missionnameSpace getVariable ["PosTaken",[]];
		
			{
			if ((_x distance _bPos) < 2) exitWith {_tkn = true}
			}
		foreach _posTaken;
		
		if not (_tkn) then
			{
			_posTaken pushBack _bPos;
			missionnamespace setVariable ["PosTaken",_posTaken];
			
			[_unit,_bPos,_bld] call RYD_JR_GarrS;
			}
		};
			
	_angle = random 360;
	_dst = 30;
	
	for "_i" from 1 to 4 do
		{
		_dst = 100;
		_checkPos = [_pos,_angle,_dst] call RYD_JR_PosTowards2D;
		
		_LOSpos = ATLtoASL ([_checkPos,_angle,50] call RYD_JR_PosTowards2D);
		_isLOS = [ATLtoASL _checkPos,_LOSpos,1.5,1.5] call RYD_JR_LOSCheck;
		_fe = (count (_checkPos isflatempty [3,0,0.5,3,0,false,objNull])) > 0;
		
		_ct = 0;
		
		while {(not (_isLOS) or not (_fe) or (isOnRoad _checkPos))} do
			{
			_ct = _ct + 1;
			if (_ct > 50) exitWith {};
			_dst = _dst + 5;
			_checkPos = [_pos,_angle,_dst] call RYD_JR_PosTowards2D;
			_checkPos = [_checkPos,0,_ct/2] call RYD_JR_RandomAroundMM;
			_LOSpos = ATLtoASL ([_checkPos,_angle,50] call RYD_JR_PosTowards2D);
			_isLOS = [ATLtoASL _checkPos,_LOSpos,1.5,1.5] call RYD_JR_LOSCheck;
			_fe = (count (_checkPos isFlatEmpty [3,0,0.5,3,0,false,objNull])) > 0;
			};
			
		if ((_isLOS) and (_fe) and not (isOnRoad _checkPos)) then
			{
			_vh = createVehicle ["Land_BagFence_Round_F", _checkPos, [], 0, "NONE"];
			_vh setDir (_angle + 180);
			_posS = getPos _vh;
			_posS set [2,-0.01];
			_vh setPos _posS;
			_vh setVectorUP (surfaceNormal [_posS select 0,_posS select 1]);
			
			RYD_JR_AllStuff pushBack _vh;
			
			_posS = _vh modelToWorld [0,0.5,0];
			_posS set [2,0];
			
			_LOSpos set [2,1.5];

			_class = RYD_JR_Static select (floor (random (count RYD_JR_Static)));
			
			_vh = createVehicle [_class, _posS, [], 0, "NONE"];
			
			_vh setDir _angle;
			_vh setPos _posS;
			_vh setVectorUP (surfaceNormal [_posS select 0,_posS select 1]);
			
			createVehicleCrew _vh;
			
				{
				[_x,false] call RYD_JR_DecimateGear;
				}
			foreach (crew _vh);

			(crew _vh) joinSilent _gp;
			
				{
				_x doWatch _LOSpos;
				_x setVariable ["RYD_JR_Watched",_LOSpos];
				}
			foreach (crew _vh);
			};

		_angle = _angle + 90
		};
		
	_size = 300;
	_minefieldsAmount = 2 + (ceil (random 2));
	_buffor = 60;

	_mineT = 
		[
		"APERSBoundingMine",
		"APERSBoundingMine",
		"APERSMine",
		"APERSMine",
		"APERSMine",
		"APERSMine",
		"APERSTripMine",
		"APERSTripMine",
		"ATMine",
		"ATMine"
		];
		
	_mineTS = 
		[
		"UnderwaterMineAB",
		"UnderwaterMine",
		"UnderwaterMinePDM"
		];
	
	for "_i" from 1 to _minefieldsAmount do
		{
		_mfPos = [_pos,_size + _buffor,_size + 2 * _buffor] call RYD_JR_RandomAroundMM;
		_nR = _mfPos nearRoads 100;
		_ct = 0;
		
		while {((count _nR) > 0)} do
			{
			if (_ct > 100) exitWith {};
			_ct = _ct + 1;
			_mfPos = [_pos,_size + _buffor,_size + 2 * _buffor] call RYD_JR_RandomAroundMM;
			_nR = _mfPos nearRoads 100;
			};
			
		if (RYD_JR_Debug) then
			{
			_mk = "MineFMark_" + (str _mfPos);
			_mk = createMarker [_mk,_mfPos];
			_mk setMarkerColor "colorYellow";
			_mk setMarkerShape "ICON";
			_mk setMarkerType "mil_dot";
			_mk setMarkerSize [0.6,0.6];
			};
		
		_amnt = 10 + (round (random 20));
				
		for "_j" from 1 to _amnt do
			{
			_types = _mineT;
			
			_mPos = [_mfPos,50] call RYD_JR_RandomAround;
			
			if (surfaceIsWater _mPos) then
				{
				if (((ASLtoATL _mPos) select 2) > 1.5) then
					{
					_types = _mineTS
					}
				else
					{
					_mPos set [2,-((ASLtoATL _mPos) select 2)]
					}
				};
		
			_type = _types select (floor (random (count _types)));
			
			_mine = createMine [_type, _mPos, [], 0];
			_mine setDir (random 360); 
			
			_posS = position _mine;
			
			if (RYD_JR_Debug) then
				{
				_mk = "MineFMark_" + (str _posS);
				_mk = createMarker [_mk,_posS];
				_mk setMarkerColor "colorYellow";
				_mk setMarkerShape "ICON";
				_mk setMarkerType "mil_dot";
				_mk setMarkerSize [0.3,0.3];
				};
			
			east revealMine _mine;
			
			if not (RYD_JR_ACIntense > 0) then
				{
				resistance revealMine _mine;
				};
			
			civilian revealMine _mine;
			sideFriendly revealMine _mine;
			};
		};
		
	if (RYD_JR_Debug) then
		{
		_i = "BBMark_" + (str _pos);
		_i = createMarker [_i,_pos];
		_i setMarkerColor "colorBrown";
		_i setMarkerShape "ICON";
		_i setMarkerType "mil_box";
		_i setMarkerSize [0.8,0.8];
		};
		
	_toClear
	};
	
RYD_JR_BigCamp = 
	{
	private ["_pos","_groups","_type","_gp","_posS","_vh","_Bldngs","_posTaken","_posAll","_Bldg","_posAct","_ct","_bPos","_bld","_angle","_dst","_checkPos","_LOSpos","_isLOS","_fe",
	"_class","_size","_minefieldsAmount","_buffor","_mineT","_mfPos","_nR","_amnt","_mk","_types","_mPos","_mk","_ix","_posAll0","_toClear"];
	
	_pos = _this select 0;
	
	_Bldngs = _pos nearObjects ["HouseBase",300];
	_posAll = [];
	_toClear = [];

		{
		_Bldg = _x;

		if not (isNull _Bldg) then
			{
			_posAct = _Bldg buildingpos 0;
			_ct = 0;

			while {((_posAct distance [0,0,0]) > 0)} do 
				{
				_posAll set [(count _posAll),[_posAct,_Bldg]];
				_ct = _ct + 1;
				if (_ct > 100) exitWith {};
				_posAct = _Bldg buildingpos _ct;
				}
			}
		}
	foreach _Bldngs;

	_posS = [_pos,0,20,6,0,6,0] call BIS_fnc_findSafePos;
	
	_gp = createGroup west;
	
	_type = RYD_JR_CaptivesClasses select (floor (random (count RYD_JR_CaptivesClasses)));
	
	_unit = _gp createUnit [_type, _posS, [], 0, "NONE"];
		
	RYD_JR_Recruitable pushBack _unit;
		
	RYD_JR_CaptivesClasses = RYD_JR_CaptivesClasses - [_type];
	
		{
		_unit setSkill [_x,0.2 + (random 0.4) + (random 0.4)];
		}
	foreach ["general","aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding"];
		
	_aID = _unit addAction ["<t color='#d0a900'>Release and hire for 10000 ff</t>", "Recruit.sqf", [], 1, false, true, "", "(alive _target)"];
	_aID = _unit addAction ["<t color='#d0a900'>Send away</t>", "Leave.sqf", [], 1, false, true, "", "not (isPlayer _target) and (alive _target)"];
	
	_unit setBehaviour "CARELESS";
	_unit allowFleeing 0;
	
	_unit setCaptive true;
	
	removeAllAssignedItems _unit;
	removeHeadgear _unit;
	removeBackpack _unit;
	removeVest _unit;
	
	removeAllWeapons _unit;

		{
		_unit removeMagazine _x
		}
	foreach (magazines _unit);
	
	if (({((_x select 0) select 2) < 4} count _posAll) > 0) then
		{
		_posAll0 = +_posAll;
		_ix = floor (random (count _posAll0));
		_bPos = _posAll0 select _ix;
		
		while {(((_bPos select 0) select 2) > 4)} do
			{
			_posAll0 set [_ix,0];
			_posAll0 = _posAll0 - [0];
			_ix = floor (random (count _posAll0));
			_bPos = _posAll0 select _ix;
			if ((count _posAll0) < 1) exitWith {}
			};
		
		_bld = _bPos select 1;
		_bPos = _bPos select 0;
		
		_tkn = false;
		_posTaken = missionnameSpace getVariable ["PosTaken",[]];
		
			{
			if ((_x distance _bPos) < 2) exitWith {_tkn = true};
			}
		foreach _posTaken;
		
		if not (_tkn) then
			{
			_posTaken pushBack _bPos;
			missionnamespace setVariable ["PosTaken",_posTaken];
			
			_unit setPos _bPos;
			};
		};
		
	if (RYD_JR_Debug) then
		{
		_mk = "cMark_" + (str (position _unit));
		_mk = createMarker [_mk,(position _unit)];
		_mk setMarkerColor "ColorBlue";
		_mk setMarkerShape "ICON";
		_mk setMarkerType "mil_triangle";
		_mk setMarkerSize [0.7,0.7];
		_mk setMarkerText "C";
		};
	
	_unit switchAction "SitDown";
	_unit forceSpeed 0;
	
	RYD_JR_CaptivesPos pushBack (position _unit);
		
	_groups = RYD_JR_BBGuardGroups;
	
	_type = _groups select (floor (random (count _groups)));
		
	_gp = [_pos,_type select 0,_type select 1,nil,nil] call RYD_JR_SpawnGroupSafe;
			
	RYD_JR_allEnemy pushBack _gp;	
	RYD_JR_AllGarrisons pushBack _gp;
	_toClear pushBack _gp;
	
	_posS = [_pos,0,100,3,0,10,0] call BIS_fnc_findSafePos;
	
	_groups = RYD_JR_BBGuardGroups;
	
	_type = _groups select (floor (random (count _groups)));
		
	_gp = [_posS,_type select 0,_type select 1,nil,nil] call RYD_JR_SpawnGroupSafe;
	
	RYD_JR_allEnemy pushBack _gp;	
	_toClear pushBack _gp;
	
	[_gp,_posS,"MOVE","AWARE","YELLOW","LIMITED","DIAMOND",["true",""],true,30,200,5,3,2,true] call RYD_JR_SADPatrol;
		
	_posS = [_pos,0,40,6,0,6,0] call BIS_fnc_findSafePos;
	
	_type = RYD_JR_Armored select (floor (random (count RYD_JR_Armored)));
	_vh = createVehicle [_type, _posS, [], 0, "NONE"];
	createVehicleCrew _vh;
	
		{
		[_x,false] call RYD_JR_DecimateGear;
		}
	foreach (crew _vh);
	
	RYD_JR_allEnemy pushBack (group _vh);
	_toClear pushBack (group _vh);
	
	_gp = createGroup east;
	
	_unit = _gp createUnit ["O_officer_F", _pos, [], 0, "NONE"];
	
	_unit setVariable ["RYD_JR_Warlord",true];

	if not (RYD_JR_GCIntel == 0) then
		{
		_unit setVariable ["RYD_JR_MoreIntel",true];
		_unit setVariable ["RYD_JR_EvenMoreIntel",true];
		};
	
	RYD_JR_allEnemy pushBack _gp;
	_toClear pushBack _gp;
	
		{
		_unit setSkill [_x,1];
		}
	foreach ["general","aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding"];
		
	if ((count _posAll) > 0) then
		{
		_bPos = _posAll select (floor (random (count _posAll)));
		_bld = _bPos select 1;
		_bPos = _bPos select 0;
		
		_tkn = false;
		_posTaken = missionnameSpace getVariable ["PosTaken",[]];
		
			{
			if ((_x distance _bPos) < 2) exitWith {_tkn = true}
			}
		foreach _posTaken;
		
		if not (_tkn) then
			{
			_posTaken pushBack _bPos;
			missionnamespace setVariable ["PosTaken",_posTaken];

			[_unit,_bPos,_bld] call RYD_JR_GarrS;
			}
		};
	
	_angle = random 360;
	_dst = 30;
	
	for "_i" from 1 to 4 do
		{
		_dst = 30;
		_checkPos = [_pos,_angle,_dst] call RYD_JR_PosTowards2D;
		
		_LOSpos = ATLtoASL ([_checkPos,_angle,50] call RYD_JR_PosTowards2D);
		_isLOS = [ATLtoASL _checkPos,_LOSpos,1.5,1.5] call RYD_JR_LOSCheck;
		_fe = (count (_checkPos isflatempty [3,0,0.5,3,0,false,objNull])) > 0;
		
		_ct = 0;
		
		while {(not (_isLOS) or not (_fe) or (isOnRoad _checkPos))} do
			{
			_ct = _ct + 1;
			if (_ct > 50) exitWith {};
			_dst = _dst + 5;
			_checkPos = [_pos,_angle,_dst] call RYD_JR_PosTowards2D;
			_checkPos = [_checkPos,0,_ct/2] call RYD_JR_RandomAroundMM;
			_LOSpos = ATLtoASL ([_checkPos,_angle,50] call RYD_JR_PosTowards2D);
			_isLOS = [ATLtoASL _checkPos,_LOSpos,1.5,1.5] call RYD_JR_LOSCheck;
			_fe = (count (_checkPos isFlatEmpty [3,0,0.5,3,0,false,objNull])) > 0;
			};
			
		if ((_isLOS) and (_fe)) then
			{
			_vh = createVehicle ["Land_BagFence_Round_F", _checkPos, [], 0, "NONE"];
			_vh setDir (_angle + 180);
			_posS = getPos _vh;
			_posS set [2,-0.01];
			_vh setPos _posS;
			_vh setVectorUP (surfaceNormal [_posS select 0,_posS select 1]);
			
			RYD_JR_AllStuff pushBack _vh;
			
			_posS = _vh modelToWorld [0,0.5,0];
			_posS set [2,0];
			
			_LOSpos set [2,1.5];

			_class = RYD_JR_Static select (floor (random (count RYD_JR_Static)));
			
			_vh = createVehicle [_class, _posS, [], 0, "NONE"];
			
			_vh setDir _angle;
			_vh setPos _posS;
			_vh setVectorUP (surfaceNormal [_posS select 0,_posS select 1]);
			
			createVehicleCrew _vh;

			(crew _vh) joinSilent _gp;
			
				{
				_x doWatch _LOSpos;
				_x setVariable ["RYD_JR_Watched",_LOSpos];
				[_x,false] call RYD_JR_DecimateGear;
				}
			foreach (crew _vh);
			};

		_angle = _angle + 90
		};
		
	_size = 300;
	_minefieldsAmount = 4 + (ceil (random 4));
	_buffor = 60;

	_mineT = 
		[
		"APERSBoundingMine",
		"APERSBoundingMine",
		"APERSMine",
		"APERSMine",
		"APERSMine",
		"APERSMine",
		"APERSTripMine",
		"APERSTripMine",
		"ATMine",
		"ATMine"
		];
		
	_mineTS = 
		[
		"UnderwaterMineAB",
		"UnderwaterMine",
		"UnderwaterMinePDM"
		];
	
	for "_i" from 1 to _minefieldsAmount do
		{
		_mfPos = [_pos,_size + _buffor,_size + 2 * _buffor] call RYD_JR_RandomAroundMM;
		_nR = _mfPos nearRoads 100;
		_ct = 0;
		
		while {((count _nR) > 0)} do
			{
			if (_ct > 100) exitWith {};
			_ct = _ct + 1;
			_mfPos = [_pos,_size + _buffor,_size + 2 * _buffor] call RYD_JR_RandomAroundMM;
			_nR = _mfPos nearRoads 100;
			};
			
		if (RYD_JR_Debug) then
			{
			_mk = "MineFMark_" + (str _mfPos);
			_mk = createMarker [_mk,_mfPos];
			_mk setMarkerColor "colorYellow";
			_mk setMarkerShape "ICON";
			_mk setMarkerType "mil_dot";
			_mk setMarkerSize [0.6,0.6];
			};
		
		_amnt = 10 + (round (random 20));
				
		for "_j" from 1 to _amnt do
			{
			_types = _mineT;
			
			_mPos = [_mfPos,50] call RYD_JR_RandomAround;
			
			if (surfaceIsWater _mPos) then
				{
				if (((ASLtoATL _mPos) select 2) > 1.5) then
					{
					_types = _mineTS
					}
				else
					{
					_mPos set [2,-((ASLtoATL _mPos) select 2)]
					}
				};
						
			_type = _types select (floor (random (count _types)));
			
			_mine = createMine [_type, _mPos, [], 0];
			_mine setDir (random 360);
			
			_posS = position _mine;
			
			if (RYD_JR_Debug) then
				{
				_mk = "MineFMark_" + (str _posS);
				_mk = createMarker [_mk,_posS];
				_mk setMarkerColor "colorYellow";
				_mk setMarkerShape "ICON";
				_mk setMarkerType "mil_dot";
				_mk setMarkerSize [0.3,0.3];
				};
			
			east revealMine _mine;
			
			if not (RYD_JR_ACIntense > 0) then
				{
				resistance revealMine _mine;
				};
				
			civilian revealMine _mine;
			sideFriendly revealMine _mine;
			};
		};
		
	if (RYD_JR_Debug) then
		{
		_i = "BBMark_" + (str _pos);
		_i = createMarker [_i,_pos];
		_i setMarkerColor "colorBrown";
		_i setMarkerShape "ICON";
		_i setMarkerType "mil_box";
		_i setMarkerSize [0.8,0.8];
		};
		
	_toClear
	};
	
RYD_JR_Warmonger = 
	{
	private ["_int","_am","_sides","_side1","_side2","_rdsM","_rnd","_side","_gps","_pos","_posL","_isWater","_isLOS","_ct","_type","_spawnPos","_gp","_units","_mk","_vh","_vhs","_ldr","_radC",
	"_spawnDstMin","_spawnDstMax","_isNight","_gpKind","_strongUnits","_closestStrong","_strongPos","_toClear0","_toClear","_good","_bad","_vl","_chance"];
	
	_int = _this select 0;
	_radC = _this select 1;
	_isNight = _this select 2;
	
	_am = ceil (random _int);
	
	if (_radC > 0) then
		{
		_am = _int
		};
			
	_sides = [resistance,east];
	_side1 = _sides select (floor (random 2));
	_sides = _sides - [_side1];
	_side2 = _sides select 0;
	
	_posP = getPosATL (vehicle player);
	_pos = _posP;
	
	if (_radC > 0) then
		{
		_pos = position ((nearestLocations [_pos, ["NameVillage","NameCity","NameCityCapital"],_radC]) select 0);
		_pos set [2,0];
		};
	
	_rdsM = (((1 + (_int - 4)/10) min 1.5) max 1);
	
	//diag_log "--w1";
	
	_spawnDstMin = 600/_rdsM;
	_spawnDstMax = 1200/_rdsM;
	
	if (_radC > 0) then
		{
		_spawnDstMin = (_radC * 1.5) min 400;
		_spawnDstMax = (_radC * 3) min 800;
		};

	for "_ij" from 1 to _am do
		{	
		_posL = [_pos,_spawnDstMin,_spawnDstMax] call RYD_JR_RandomAroundMM;
		_isWater = surfaceIsWater _posL;
		
		if not (_isWater) then
			{
			_isLOS = [(ATLtoASL _posP),(ATLtoASL _posL),1.5,1.5] call RYD_JR_LOSCheck;
			
			_ct = 0;
			
			while {(_isLOS)} do
				{
				_ct = _ct + 1;
				if (_ct > 100) exitWith {};
				
				_posL = [_pos,700,1300] call RYD_JR_RandomAroundMM;
				_isWater = surfaceIsWater _posL;
				
				if (_isWater) exitWith {};

				_isLOS = [(ATLtoASL _posP),(ATLtoASL _posL),1.5,1.5] call RYD_JR_LOSCheck			
				};
				
			if (_isWater) exitWith {};
				
			//diag_log "--w2";

			if not (_isLOS) then
				{	
				_rnd = random 100;
				
				_side = _side1;
				
				if ((_ij/2) == (floor (_ij/2))) then
					{
					_side = _side2
					};
				
				_gps = RYD_JR_AllInfGroupsI;
				
				if (_side == east) then
					{
					_gps = RYD_JR_AllInfGroupsE
					};
					
				_gpKind = "inf";

				switch (true) do
					{
					case (_rnd > 98) : 
						{
						switch (_side) do
							{
							case (resistance) : {_gps = RYD_JR_AllArmGroupsI;_gpKind = "arm"};
							case (east) : {_gps = RYD_JR_AllArmGroupsE;_gpKind = "arm"};
							}
						};
						
					case (_rnd > 90) : 
						{
						switch (_side) do
							{
							case (resistance) : {_gps = RYD_JR_AllMechGroupsI;_gpKind = "mech"};
							case (east) : {_gps = RYD_JR_AllMechGroupsE;_gpKind = "mech"};
							}
						};
						
					case (_rnd > 75) : 
						{
						switch (_side) do
							{
							case (resistance) : {_gps = RYD_JR_AllMotGroupsI;_gpKind = "mot"};
							case (east) : {_gps = RYD_JR_AllMotGroupsE;_gpKind = "mot"};
							}
						}
					};		
			
				//diag_log "--w3";
				
				_spawnPos = [_posL,0,100,6,0,3,0] call BIS_fnc_findSafePos;

				_spawnPos set [2,0];
				
				_type = _gps select (floor (random (count _gps)));
				
				//diag_log "--w4";

				_gp = [_spawnPos,_type select 0,_type select 1,[],_gpKind] call RYD_JR_SpawnGroupSafe;
				
				if (isNull _gp) exitWith {};
				
				if (RYD_JR_LimitedAC) then
					{
					RYD_JR_ACSpawns pushBack _spawnPos;
					};
				
				_ldr = leader _gp;
				
				_aID = _ldr addAction ["<t color='#d0a900'>Check the intel about your brother's death</t>", "IntelCheck.sqf", [false,side _ldr,"search"], 1, false, true, "", "(((player distance _target) < 3) and not (alive _target))"];
				
				_units = units _gp;
				
				if (RYD_JR_Debug) then
					{
					_mk = "sMark_" + (str _spawnPos);
					_mk = createMarker [_mk,_spawnPos];
					_mk setMarkerColor "colorRed";
					_mk setMarkerShape "ICON";
					_mk setMarkerType "mil_dot";
					_mk setMarkerSize [0.6,0.6];
					_mk setMarkerText (str _side);
					_gp setVariable ["RYD_JR_MarkS",_mk];
					};
				
				RYD_JR_AllSpawnedGps pushBack _gp;
				RYD_JR_AllSpawnedAIs = RYD_JR_AllSpawnedAIs + _units;
				
				_vhs = [];
				
					{
					_KilledEH = _x addEventHandler ["Killed", {nul = _this spawn KilledMark}];
					_x setVariable ["RYD_JR_RIPmark",_KilledEH];
					_aID = _x addAction ["<t color='#d0a900'>Sell content</t>", RYD_JR_SellCargo, false, 1, false, true, "", "not (alive _target)"];
					
					_vh = vehicle _x;
					
					if not (_vh == _x) then
						{
						if not (_vh in _vhs) then
							{
							_vhs pushBack _vh
							}
						}
					}
				foreach _units;
				
				_gp setVariable ["RYD_JR_MyVehs",_vhs];
				
				//diag_log "--w5";
				
				_patrolDstFirstMin = 600/_rdsM;
				_patrolDstFirstMax = 2000/_rdsM;
				
				_patrolDstMin = 200/_rdsM;
				_patrolDstMax = 2000/_rdsM;
				
				_amPMin = 3;
				_addP = 2;
				
				if (_radC > 0) then
					{
					_patrolDstFirstMin = 50;
					_patrolDstFirstMax = 150;
					
					_patrolDstMin = 50;
					_patrolDstMax = 150;
					
					_amPMin = 2;
					_addP = 0;
					};

				[_gp,[_pos,_patrolDstFirstMin,_patrolDstFirstMax] call RYD_JR_RandomAroundMM,"SAD","AWARE","YELLOW","NORMAL","WEDGE",["true",""],true,_patrolDstMin,_patrolDstMax,0,_amPMin,_addP,true,true] call RYD_JR_SADPatrol;
				
				if ((_gpKind isEqualTo "inf") and {(random 100) > 75}) then
					{
					if (({(side _x) == _side} count allGroups) < 144) then
						{
						_gp setVariable ["RYD_JR_NotDel",true];
						_heliC = "I_Heli_Transport_02_F";
						if (_side == east) then
							{
							_heliC = "O_Heli_Transport_04_covered_F"
							};
							
						_dir = random 360;
						
						_spawnP = [_pos,_dir + 180,(((viewDistance + 100) max 5000) min 10000) * (1 + (random 1))] call RYD_JR_PosTowards2D;
						
						if (RYD_JR_Debug) then
							{
							_mk = "shMark_" + (str _spawnP);
							_mk = createMarker [_mk,_spawnP];
							_mk setMarkerColor "colorRed";
							_mk setMarkerShape "ICON";
							_mk setMarkerType "mil_box";
							_mk setMarkerSize [0.6,0.6];
							_mk setMarkerText (_heliC);
							};						
						
						_flyP = [_pos,_dir,(((viewDistance + 100) max 5000) min 10000)] call RYD_JR_PosTowards2D;
						
						if (RYD_JR_Debug) then
							{
							_mk = "fhMark_" + (str _flyP);
							_mk = createMarker [_mk,_flyP];
							_mk setMarkerColor "colorGreen";
							_mk setMarkerShape "ICON";
							_mk setMarkerType "mil_box";
							_mk setMarkerSize [0.6,0.6];
							_mk setMarkerText (_heliC);
							};
						
						_spawnP set [2,40];
						_flyP set [2,40];
							
						_heli = createVehicle [_heliC, _spawnP, [], 0, "FLY"];
						createVehicleCrew _heli;
						_hGp = group (assignedDriver _heli);
						//_hGp setVariable ["RYD_JR_myEjectPos",_pos];
						
						_heli setDir _dir;
						
							{
							_x assignAsCargo _heli;
							_x moveInCargo _heli
							}
						foreach (units _gp);
						
						_spd = (getNumber (configFile >> "cfgVehicles" >> _heliC >> "maxspeed") + getNumber (configFile >> "cfgVehicles" >> _heliC >> "landingSpeed" ))/7.2;
						_heli setVelocity [(sin _dir) * _spd,(cos _dir) * _spd,0];
						
						_wp = _hGp addWaypoint [_flyP,0];
						_wp setWaypointType "MOVE";
						_wp setWaypointStatements ["(player distance this) > (viewDistance min 5000)","[this] call RYD_JR_DelVeh"];
						_heli setBehaviour "CARELESS";
						_heli setCombatMode "YELLOW";
						_heli flyInHeight 60;
						
						[_heli,_posL,_gp] spawn
							{
							_heli = _this select 0;
							_pos = _this select 1;
							_gp = _this select 2;
							
							waitUntil
								{
								_dst1 = _heli distance _pos;
								sleep 1;
								_dst2 = _heli distance _pos;
								
								((_dst2 > _dst1) and {_dst2 < 1000})
								};
								
							_gp setVariable ["RYD_JR_NotDel",nil];
								
							_dir = getDir _heli;
								
								{
								unassignVehicle _x;
								//_x action ["EJECT", _heli];
								
								_x allowDamage false;
								
								_x setPos (_heli modelToWorld [(random 4) - (random 4),-4,-2]);
								
								_vel = velocity _heli;
								
								_x setVelocity [(_vel select 0)/2,(_vel select 1)/2,-1];
								
								_x disableCollisionWith _heli;
								
								waitUntil
									{
									sleep 0.01;
									(_x == (vehicle _x))
									};
								
								[_x,_heli,_dir] spawn
									{
									_unit = _this select 0;
									_heli = _this select 1;
									_dir = _this select 2;
									
									waitUntil
										{
										sleep (0.15 + (random 0.5));
										((_heli distance _unit) > 25)
										};
									
									_chute = createVehicle ["Steerable_Parachute_F", position _unit, [], (_dir + 175 + (random 10)), "FLY"];
									_chute disableCollisionWith _heli;
									_chute setPos (position _unit);
									_vel = velocity _unit;
									_unit moveInDriver _chute;
									_chute setVelocity _vel;
									
									_unit allowDamage true;
									};
									
								sleep (0.75 + (random 0.25));
								}
							foreach (units _gp);
							}
						};
						
					};
				
				if (_isNight) then
					{
					if (_radC > 0) then
						{
						if ((random 100) > -50) then
							{
							[_posL] spawn
								{
								_pos = _this select 0;
								
								_pos = [_pos,60] call RYD_JR_RandomAround;
								_pos set [2,245 + (random 10)];
								
								sleep (2 + (random 10));
								
								_amnt = 1 + (floor (random 3));
								
								for "_i" from 1 to _amnt do
									{
									_flare = RYD_JR_Flares select (floor (random (count RYD_JR_Flares)));
									
									sleep (2 + (random 2));
									
									_flare = createVehicle [_flare, _pos, [], 0, "CAN_COLLIDE"];
									_flare setVelocity [2 - (random 4),2 - (random 4),9 + (random 2)]; 
									}	
								}
							}
						}
					};
				
				//_wp = [_gp,_spawnPos,"DISMISS","SAFE","YELLOW","NORMAL",["true",""]] call RYD_JR_WPadd;
				};
			};
						
		if (not (RYD_JR_ACIntense > (count RYD_JR_AllSpawnedGps)) and (_radC < 0)) exitWith {};
		};
	
	_strongUnits = 0;
	
	if ((random 100) < 99.5) then
		{
		_closestStrong = [_pos,RYD_JR_StrongPos] call RYD_JR_FindClosestF;
		
		_strongPos = _closestStrong select 0;
		_toClear0 = _closestStrong select 1;
		
		_toClear = {not (isNil {_x}) and {not (isNull _x) and {not (({alive _x} count (units _x)) < 1)}}} count _toClear0;
		
			{
			if (not (isNil {_x}) and {not (isNull _x) and {not (({alive _x} count (units _x)) < 1)}}) then
				{
				if (((leader _x) distance _strongPos) < 1200) then
					{
					_strongUnits = _strongUnits + 1
					}
				}
			}
		foreach _toClear0
		};
				
	if (_strongUnits < 2) then
		{
		_good = 0;
		_bad = 0;
		
			{
			_vl = _x select 0;
			switch (true) do
				{
				case (_vl > 0) : {_good = _good + _vl};
				case (_vl < 0) : {_bad = _bad + (abs _vl)};
				}
			}
		foreach RYD_JR_RepEvents;
		
		_chance = ((_good/(_good + _bad)) min 0.95) max 0.1;
				
		if (((random 1) < _chance) and {(random _good) > ((random 10) + (random 10) + (random 10) + (random 10) + (random 10))}) then
			{
			_posL = [_pos,_spawnDstMin,_spawnDstMax] call RYD_JR_RandomAroundMM;
			_isWater = surfaceIsWater _posL;
			
			if not (_isWater) then
				{
				_isLOS = [(ATLtoASL _posP),(ATLtoASL _posL),1.5,1.5] call RYD_JR_LOSCheck;
				
				_ct = 0;
				
				while {(_isLOS)} do
					{
					_ct = _ct + 1;
					if (_ct > 100) exitWith {};
					
					_posL = [_pos,700,1300] call RYD_JR_RandomAroundMM;
					_isWater = surfaceIsWater _posL;
					
					if (_isWater) exitWith {};

					_isLOS = [(ATLtoASL _posP),(ATLtoASL _posL),1.5,1.5] call RYD_JR_LOSCheck			
					};
					
				if (_isWater) exitWith {};
					
				if not (_isLOS) then
					{				
					_side = west;
					
					_gps = RYD_JR_AllFIAGroups;
					
					_spawnPos = [_posL,0,100,6,0,3,0] call BIS_fnc_findSafePos;

					_spawnPos set [2,0];
					
					_type = _gps select (floor (random (count _gps)));

					_gp = [_spawnPos,_type select 0,_type select 1,[],"fia"] call RYD_JR_SpawnGroupSafe;
					
					if (isNull _gp) exitWith {};
					
					if (RYD_JR_LimitedAC) then
						{
						RYD_JR_ACSpawns pushBack _spawnPos;
						};
						
					_units = units _gp;
					
					if (RYD_JR_Debug) then
						{
						_mk = "sMark_" + (str _spawnPos);
						_mk = createMarker [_mk,_spawnPos];
						_mk setMarkerColor "colorRed";
						_mk setMarkerShape "ICON";
						_mk setMarkerType "mil_dot";
						_mk setMarkerSize [0.6,0.6];
						_mk setMarkerText (str _side);
						_gp setVariable ["RYD_JR_MarkS",_mk];
						};
					
					RYD_JR_AllSpawnedGps pushBack _gp;
					RYD_JR_AllSpawnedAIs = RYD_JR_AllSpawnedAIs + _units;
					
					_vhs = [];
					
						{
						_KilledEH = _x addEventHandler ["Killed", {nul = _this spawn KilledMark}];
						_x setVariable ["RYD_JR_RIPmark",_KilledEH];
						_aID = _x addAction ["<t color='#d0a900'>Sell content</t>", RYD_JR_SellCargo, false, 1, false, true, "", "not (alive _target)"];
						
						_vh = vehicle _x;
						
						if not (_vh == _x) then
							{
							if not (_vh in _vhs) then
								{
								_vhs pushBack _vh
								}
							}
						}
					foreach _units;
					
					_gp setVariable ["RYD_JR_MyVehs",_vhs];
					
					_patrolDstFirstMin = 600/_rdsM;
					_patrolDstFirstMax = 2000/_rdsM;
					
					_patrolDstMin = 200/_rdsM;
					_patrolDstMax = 2000/_rdsM;
					
					_amPMin = 3;
					_addP = 2;
					
					if (_radC > 0) then
						{
						_patrolDstFirstMin = 50;
						_patrolDstFirstMax = 150;
						
						_patrolDstMin = 50;
						_patrolDstMax = 150;
						
						_amPMin = 2;
						_addP = 0;
						};

					[_gp,[_pos,_patrolDstFirstMin,_patrolDstFirstMax] call RYD_JR_RandomAroundMM,"SAD","AWARE","YELLOW","NORMAL","WEDGE",["true",""],true,_patrolDstMin,_patrolDstMax,0,_amPMin,_addP,true,true] call RYD_JR_SADPatrol;
					};
				};
			};
		};

	//RYD_JR_LastSpawn = time;	
	};
	
RYD_JR_DelVeh = 
	{
	private ["_veh","_gp"];
	
	_veh = vehicle (_this select 0);

	_gp = group _veh;
	
		{
		if not (isPlayer _x) then
			{
			deleteVehicle _x
			}
		}
	foreach (crew _veh);
	
	if (not (player in _veh) or {_veh isEqualTo (assignedVehicle player)}) then
		{
		deleteVehicle _veh
		};
		
	deleteGroup _gp;
	};
	
RYD_JR_GraveDigger = 
	{
	private ["_sandGlass","_vh","_checked","_exist","_stuff","_vhs","_vh","_ass","_mk"];
	
		{
		if (_x in RYD_JR_AllSpawnedAIs) then
			{
			_sandGlass = _x getVariable "RYD_JR_MementoMori";
			if (isNil {_sandGlass}) then
				{
				_x setVariable ["RYD_JR_MementoMori",time]
				}
			else
				{
				if ((time - _sandGlass) > 600) then
					{
					if ((_x distance player) > 1200) then
						{
						_stuff = (position _x) nearObjects ["WeaponHolder",20];
						//_stuff = _stuff - RYD_JR_AllHolders;
					
							{
							deleteVehicle _x
							}
						foreach _stuff;
						
						_mk = _x getVariable ["RYD_JR_RIP",""];
						deleteMarker _mk;
						
						deleteVehicle _x
						}
					else
						{
						if (({not (alive _x)} count RYD_JR_AllSpawnedAIs) > 30) then
							{
							if ((_x distance player) > 600) then
								{
								_stuff = (position _x) nearObjects ["WeaponHolder",20];
								//_stuff = _stuff - RYD_JR_AllHolders;
							
									{
									deleteVehicle _x
									}
								foreach _stuff;
								
								_mk = _x getVariable ["RYD_JR_RIP",""];
								deleteMarker _mk;
								
								deleteVehicle _x
								}
							else
								{
								if (({not (alive _x)} count RYD_JR_AllSpawnedAIs) > 40) then
									{
									if ((_x distance player) > 300) then
										{
										_stuff = (position _x) nearObjects ["WeaponHolder",20];
										//_stuff = _stuff - RYD_JR_AllHolders;
									
											{
											deleteVehicle _x
											}
										foreach _stuff;
										
										_mk = _x getVariable ["RYD_JR_RIP",""];
										deleteMarker _mk;
										
										deleteVehicle _x
										}
									else
										{
										if (({not (alive _x)} count RYD_JR_AllSpawnedAIs) > 50) then
											{
											if ((_x distance player) > 100) then
												{
												_stuff = (position _x) nearObjects ["WeaponHolder",20];
												//_stuff = _stuff - RYD_JR_AllHolders;
											
													{
													deleteVehicle _x
													}
												foreach _stuff;
												
												_mk = _x getVariable ["RYD_JR_RIP",""];
												deleteMarker _mk;
												
												deleteVehicle _x
												}
											else
												{
												if (({not (alive _x)} count RYD_JR_AllSpawnedAIs) > 60) then
													{
													_stuff = (position _x) nearObjects ["WeaponHolder",20];
													//_stuff = _stuff - RYD_JR_AllHolders;
												
														{
														deleteVehicle _x
														}
													foreach _stuff;
													
													_mk = _x getVariable ["RYD_JR_RIP",""];
													deleteMarker _mk;
													
													deleteVehicle _x
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		else
			{
			_sandGlass = _x getVariable "RYD_JR_MementoMori";
			if (isNil {_sandGlass}) then
				{
				_x setVariable ["RYD_JR_MementoMori",time]
				}
			else
				{
				if ((time - _sandGlass) > 1800) then
					{
					if ((_x distance player) > 2500) then
						{
						_stuff = (position _x) nearObjects ["WeaponHolder",20];
					
							{
							deleteVehicle _x
							}
						foreach _stuff;
						
						if not (RYD_JR_KeepMyBodies) then
							{
							_mk = _x getVariable ["RYD_JR_RIP",""];
							deleteMarker _mk;
							
							deleteVehicle _x
							}
						}
					}
				}
			}
		}
	foreach (AllDead - [RYD_JR_Brother]);
	
	//diag_log "--g1";
	
		{
		_vh = vehicle (leader _x);
		
		if (((_vh distance player) > 2500) and {not (_x getVariable ["RYD_JR_NotDel",false])}) then
			{
			_checked = [];
			
				{
				_vh = assignedVehicle _x;
				
				if (isNull _vh) then
					{
					_vh = vehicle _x;
					};
				
				if not (_vh in _checked) then
					{
					_checked pushBack _vh;
					
					if not (_vh == _x) then
						{
							{
							deleteVehicle _x
							}
						foreach (crew _vh)
						};
						
					deleteVehicle _vh
					}
				}
			foreach (units _x);
			
			_mrk = _x getVariable ["RYD_JR_MarkS",""];
			deleteMarker _mrk;
									
			deleteGroup _x
			}
		}
	foreach RYD_JR_AllSpawnedGps;
	
	//diag_log "--g2";
	
		{
		_exist = true;
		
		switch (true) do
			{
			case (isNull _x) : {_exist = false};
			case (({alive _x} count (units _x)) < 1) : {_exist = false};
			};
			
		if not (_exist) then
			{
			if (_x in RYD_JR_AllSpawnedGps) then
				{
				_vhs = _x getVariable "RYD_JR_MyVehs";
				
				if not (isNil "_vhs") then
					{
					RYD_JR_AllSpawnedVehs = RYD_JR_AllSpawnedVehs + _vhs
					};
				};
							
			deleteGroup _x
			}
		}
	foreach AllGroups;
	
		{
		switch (true) do
			{
			case (isNil {_x}) : {RYD_JR_AllSpawnedVehs set [_foreachIndex,0]};
			case (isNull _x) : {RYD_JR_AllSpawnedVehs set [_foreachIndex,0]};
			case not (alive _x) : {RYD_JR_AllSpawnedVehs set [_foreachIndex,0]};
			};
		}
	foreach RYD_JR_AllSpawnedVehs;
	
	RYD_JR_AllSpawnedVehs = RYD_JR_AllSpawnedVehs - [0];
	
		{
		_vh = _x;
		if ((_vh distance player) > 2500) then
			{
			_ass = false;
			
				{
				if (_vh == (assignedVehicle _x)) exitWith {_ass = true}
				}
			foreach (units (group player));
			
			if not (_ass) then
				{
				deleteVehicle _x;
				};

			(RYD_JR_AllSpawnedVehs - [RYD_JR_vh]) set [_foreachIndex ,0]
			}
		}
	foreach (RYD_JR_AllSpawnedVehs - [RYD_JR_vh]);
	
	RYD_JR_AllSpawnedVehs = RYD_JR_AllSpawnedVehs - [0];
	
		{
		switch (true) do
			{
			case (isNil {_x}) : {RYD_JR_AllSpawnedGps set [_foreachIndex,0]};
			case (isNull _x) : {RYD_JR_AllSpawnedGps set [_foreachIndex,0]};
			default
				{
				if (RYD_JR_Debug) then
					{
					_mrk = _x getVariable ["RYD_JR_MarkS",""];
					_mrk setMarkerPos (getPosATL (leader _x))
					}
				}
			}
		}
	foreach RYD_JR_AllSpawnedGps;
	
	RYD_JR_AllSpawnedGps = RYD_JR_AllSpawnedGps - [0];
	
	//diag_log "--g3";
	
		{
		switch (true) do
			{
			case (isNil {_x}) : {RYD_JR_AllSpawnedAIs set [_foreachIndex,0]};
			case (isNull _x) : {RYD_JR_AllSpawnedAIs set [_foreachIndex,0]};
			}
		}
	foreach RYD_JR_AllSpawnedAIs;
	
	RYD_JR_AllSpawnedAIs = RYD_JR_AllSpawnedAIs - [0];
	
		{
		if ((_x distance player) > 500) then
			{
			deleteVehicle _x
			}
		}
	foreach RYD_JR_ShopBoxes;
	RYD_JR_ShopBoxes = RYD_JR_ShopBoxes - [objNull];
	};
	
RYD_JR_GraveDiggerLight = 
	{
	private ["_sandGlass","_stuff","_mk"];

		{
		_sandGlass = _x getVariable "RYD_JR_MementoMori";
		if (isNil {_sandGlass}) then
			{
			_x setVariable ["RYD_JR_MementoMori",time]
			}
		else
			{
			if ((time - _sandGlass) > 1800) then
				{
				if ((_x distance player) > 2500) then
					{
					_stuff = (position _x) nearObjects ["WeaponHolder",20];
				
						{
						deleteVehicle _x
						}
					foreach _stuff;
					
					if not (RYD_JR_KeepMyBodies) then
						{
						_mk = _x getVariable ["RYD_JR_RIP",""];
						deleteMarker _mk;
						
						deleteVehicle _x
						}
					}
				}
			}
		}
	foreach (AllDead - [RYD_JR_Brother]);

	
		{
		if (({alive _x} count (units _x)) < 1) then
			{
			deleteGroup _x
			}
		}
	foreach AllGroups;
	
		{
		if ((_x distance player) > 500) then
			{
			deleteVehicle _x
			}
		}
	foreach RYD_JR_ShopBoxes;
	RYD_JR_ShopBoxes = RYD_JR_ShopBoxes - [objNull];
	};
	
RYD_JR_GraveDiggerForced = 
	{
	private ["_stuff","_mk","_vhs","_vh","_ass"];
	
		{
		_stuff = (position _x) nearObjects ["WeaponHolder",20];
	
			{		
			deleteVehicle _x
			}
		foreach _stuff;
		
		_mk = _x getVariable ["RYD_JR_RIP",""];
		deleteMarker _mk;
		
		deleteVehicle _x
		}
	foreach (AllDead - [RYD_JR_Brother]);
	
		{
		switch (true) do
			{
			case (isNil {_x}) : {RYD_JR_AllSpawnedVehs set [_foreachIndex,0]};
			case (isNull _x) : {RYD_JR_AllSpawnedVehs set [_foreachIndex,0]};
			case not (alive _x) : {RYD_JR_AllSpawnedVehs set [_foreachIndex,0]};
			};
		}
	foreach RYD_JR_AllSpawnedVehs;
	
	RYD_JR_AllSpawnedVehs = RYD_JR_AllSpawnedVehs - [0];
	
		{
		_vh = _x;
		if ((_vh distance player) > 2500) then
			{
			_ass = false;
			
				{
				if (_vh == (assignedVehicle _x)) exitWith {_ass = true}
				}
			foreach (units (group player));
			
			if not (_ass) then
				{
				deleteVehicle _x;
				};

			(RYD_JR_AllSpawnedVehs - [RYD_JR_vh]) set [_foreachIndex ,0]
			}
		}
	foreach (RYD_JR_AllSpawnedVehs - [RYD_JR_vh]);
	
	RYD_JR_AllSpawnedVehs = RYD_JR_AllSpawnedVehs - [0];
	
		{
		if (({alive _x} count (units _x)) < 1) then
			{
			if (_x in RYD_JR_AllSpawnedGps) then
				{
				_vhs = _x getVariable "RYD_JR_MyVehs";
				
				if not (isNil "_vhs") then
					{
					RYD_JR_AllSpawnedVehs = RYD_JR_AllSpawnedVehs + _vhs
					};
				};			
			
			deleteGroup _x
			}
		}
	foreach AllGroups;
	};
	
RYD_JR_DecimateGear = 
	{
	private ["_unit","_death","_mod","_chance","_am","_mgs","_mag","_removed","_hg","_mpl"];
	
	_unit = _this select 0;
	_death = _this select 1;
	_mod = 0;
	if ((count _this) > 2) then {_mod = _this select 2};
	
	_wD = _unit getVariable ["RYD_JR_WD",false];
	if (_wD) exitWith {};

	_removed = [];
	_mpl = 1 - _mod;
	if (RYD_JR_RealLoot) then
		{
		_mpl = (1 - _mod)/(1 + (RYD_JR_CargoDensityM/2))
		};
	
	switch (_death) do
		{
		case (false) :
			{
			if ((random 100) < 10) then
				{
				_hg = headGear _unit;

				if not (_hg in [""]) then
					{
					_removed pushBack _hg;
					_unit unlinkItem _hg
					}
				};

				{
				_chance = 25 * _mpl;
				if (_x in ["itemMap","itemGPS"]) then 
					{
					_chance = 85 * _mpl
					}
				else
					{
					if (_x in ["itemMap","itemGPS","NVGoggles","NVGoggles_OPFOR","NVGoggles_INDEP","Binocular","Rangefinder"]) then 
						{
						_chance = 95 * _mpl
						}
					};
				
				if ((random 100) < _chance) then
					{
					_removed pushBack _x;
					_unit unlinkItem _x
					}
				}
			foreach (assignedItems _unit);

			_unit setVariable ["RYD_JR_MyRemovedGear",_removed]
			};
		
		case (true) :
			{
			_unit setVariable ["RYD_JR_WD",true];
			_am = count (magazines _unit);

			for "_i" from 1 to _am do
				{
				_mgs = magazines _unit;
				_mag = _mgs select (floor (random (count _mgs)));
				if not (((count _mgs) * _mpl) > ((random 2) + (random 2) + (random 2))) exitWith {};
				_unit removeMagazine _mag
				};
				
			if (RYD_JR_noWeapons) then
				{
					{
					_unit removeWeaponGlobal _x
					}
				foreach (weapons _unit)
				}
			};
		};	
	};
	
RYD_JR_AutoSave = 
	{
	switch (RYD_JR_AS) do
		{
		case (true) : {RYD_JR_AS = false;hint "Periodic autosave disabled"};
		case (false) : {RYD_JR_AS = true;hint "Periodic autosave enabled"};
		};
	};
	
RYD_JR_FatigueSwitch = 
	{
	switch (RYD_JR_Fatigue) do
		{
		case (true) : 
			{
			RYD_JR_Fatigue = false;
			
				{
				_x enableStamina false;
				_x enableFatigue false
				} 
			forEach (units (group player));
			
			hint "Fatigue effects disabled"
			};
			
		case (false) : 
			{
			RYD_JR_Fatigue = true;
			
				{
				_x enableStamina true;
				_x enableFatigue true
				} 
			forEach (units (group player));
			
			hint "Fatigue effects enabled"
			};
		};
	};
	
RYD_JR_CalculateRep = 
	{
	private ["_isCiv","_unit","_val","_vl","_dst","_age","_pos","_clEvents"];
	
	_isCiv = _this select 0;
	_unit = _this select 1;
	
	_val = 0;
	
		{
		_vl = _x select 0;
		_pos = _x select 1;
		_dst = (_unit distance _pos) max 1;
		_age = time - (_x select 2);
		
		_vl = (sqrt((_age min 3600)/(100 + _dst))) * _vl * ((1 + (random 20))/(10 + (random 10)));
		
		_clEvents = ({(_pos distance (_x select 1)) < 500} count RYD_JR_RepEvents);
		
		_wasHeard = (abs (_vl * 0.03 * (sqrt (_clEvents max 1))));
		
		//diag_log format ["val: %1 cl: %2 wH: %3",_vl,_clEvents,_wasHeard];
			
		if ((_wasHeard min 0.85) > (random 1)) then
			{
			if (_age > 3600) then
				{
				_vl = _vl * (((3600/_age)^0.5) max 0.1)
				};
			
			if (_isCiv) then
				{
				_val = _val + _vl
				}
			else
				{
				_val = _val + (abs _vl)
				}
			}
		}
	foreach RYD_JR_RepEvents;
	
	//diag_log format ["-------------Reputation: %1",_val];
	
	_val
	};
	
RYD_JR_IsFlanking = 
	{
	private ["_point","_Rpoint","_angle","_diffA","_axis","_isFlanking"];	

	_point = _this select 0;
	_rPoint = _this select 1;
	_axis = _this select 2;

	_angle = [getPosATL _rPoint,getPosATL _point,10] call RYD_JR_AngTowards;

	_isFlanking = false;

	if (_angle < 0) then {_angle = _angle + 360};
	if (_axis < 0) then {_axis = _axis + 360};  

	_diffA = _angle - _axis;

	if (_diffA < 0) then {_diffA = _diffA + 360};

	if ((_diffA > 45) and (_diffA < 315)) then 
		{
		_isFlanking = true
		};

	_isFlanking
	};
	
RYD_JR_DisablePlayerCentering = 
	{
	if (visibleMap) then
		{
		if not (RYD_JR_PCDisabled) then
			{
			RYD_JR_PCDisabled = true;
			disableSerialization;
			((findDisplay 12) displayCtrl 1202) ctrlShow false;
			}
		}
	else
		{
		if (RYD_JR_PCDisabled) then
			{
			RYD_JR_PCDisabled = false;
			}
		};
	};
	
RYD_JR_FixMyVeh = 
	{	
	_vehs = [];
	_damages = [];
	_dams = 0;
	_fuels = 0;
	
		{
		_veh = assignedVehicle _x;
		_dam = 0;
		_damArr = if (isNull _veh) then
			{
			[]
			}
		else
			{
			(getAllHitPointsDamage _veh) select 2
			};
		
			{
			_dam = _dam + _x
			}
		foreach _damArr;
		
		_fuel = fuel _veh;
			
		if (not (isNull _veh) and {((_veh distance player) < 500) and {(_dam > 0) or {(_fuel < 1)}}}) then
			{
			_damages pushBack _dam;
			_fuel = 1 - _fuel;
			
			switch (true) do
				{
				case (_veh isKindOf "Rubber_duck_base_F") :
					{
					_dam = _dam * 0.75
					};					
								
				case (_veh isKindOf "Boat_Armed_01_base_F") :
					{
					_dam = _dam * 1.5
					};						
				
				case (_veh isKindOf "Air") :
					{
					_dam = _dam * 5;
					_fuel = _fuel * 10;
					};
					
				case (_veh isKindOf "Wheeled_APC_F") :
					{
					_dam = _dam * 2;
					_fuel = _fuel * 5;
					};
					
				case (_veh isKindOf "APC_Tracked_01_base_F") :
					{
					_dam = _dam * 3;
					_fuel = _fuel * 5;
					};
				
				case (_veh isKindOf "MBT_02_base_F") :
					{
					_dam = _dam * 5;
					_fuel = _fuel * 10;
					};

				case (_veh isKindOf "Tank") :
					{
					_dam = _dam * 5;
					_fuel = _fuel * 10;
					};
					
				case (_veh isKindOf "StaticWeapon") :
					{
					_dam = _dam * 1.5;
					_fuel = 0;
					};

				default
					{
					
					}
				};
			
			_dams = _dams + _dam;
			_fuels = _fuels + _fuel;			
			
			_vehs pushBack _veh
			}
		}
	foreach (units (group player));
	
	if ((count _vehs) == 0) exitWith
		{
		hint "No vehicles requiring repairs in 500 meters radius."
		};
		
	_cost = round ((_dams + _fuels) * 100);
	
	if ((floor _cost) == 0) exitWith
		{
		hint "Nothing to repair."
		};
	
	if (RYD_JR_FuelFund < _cost) exitWith
		{
		hint format ["Not enough funds. %1 FF required.",_cost]
		};
	
	RYD_JR_ServiceArr = [false,_cost,_vehs];
	
	createDialog "RscHealRep";
	
	waitUntil {dialog};
	
	_txt = if ((count _vehs) == 1) then
		{
		"All right, this vehicle indeed requires some repairs."
		}
	else
		{
		(format ["All right, I see these %1 vehicles indeed require some repairs.",(count _vehs)])
		};
		
	_txt = _txt + (format [" This will cost you %1 FF.",_cost]);
		
	if (_fuels > 0) then
		{
		_txt = _txt + " Price includes refueling."
		};
		
	_txt = _txt + " Deal?";
	
	ctrlSetText [1,_txt];
	};
	
RYD_JR_HealUs = 
	{
	_units = [];
	_dams = 0;

		{
		_dam = 0;
		_damArr = (getAllHitPointsDamage _x) select 2;
		
			{
			_dam = _dam + _x
			}
		foreach _damArr;

			
		if (((_x distance player) < 100) and {(_dam > 0)}) then
			{
			_dams = _dams + _dam;
			_units pushBack _x;
			};
		}
	foreach (units (group player));
	
	if ((count _units) == 0) exitWith
		{
		hint "No units requiring healing in 100 meters radius."
		};
		
	_cost = (round ((sqrt _dams) * 1000));
	
	if ((floor _cost) == 0) exitWith
		{
		hint "No one to heal."
		};
	
	if (RYD_JR_FuelFund < _cost) exitWith
		{
		hint format ["Not enough funds. %1 FF required.",_cost]
		};
	
	RYD_JR_ServiceArr = [true,_cost,_units];
	
	createDialog "RscHealRep";
	
	waitUntil {dialog};
	
	_txt = if ((count _units) == 1) then
		{
		"All right, indeed some medical attention is required."
		}
	else
		{
		(format ["All right, I see %1 of you indeed require medical attention.",(count _units)])
		};
		
	_txt = _txt + (format [" This will cost you %1 FF. Deal?",_cost]);
	
	ctrlSetText [1,_txt];
	};
	
RYD_JR_HR = 
	{
	_isHeal = _this select 0;
	_cost = _this select 1;
	_subjects = _this select 2;
	
	_txt = if (_isHeal) then
		{
		"Medical assistance in progress..."
		}
	else
		{
		"Repairs in progress..."
		};

	TitleText [_txt,"BLACK OUT",0.55];

	sleep 1;

		{
		_x setDamage 0
		}
	foreach _subjects;
	
	sleep 1;

	TitleText [_txt,"BLACK IN",0.55];
	
	_txt = if (_isHeal) then
		{
		"Medical assistance complete."
		}
	else
		{
		"Repairs complete."
		};
	
	sleep 1;
	
	TitleText [_txt,"PLAIN",3];

	sleep 3;

	TitleText ["","PLAIN",0];	
	};
	
RYD_JR_OwnedDLC = 
	{
	params ["_configPath"];
	
	private _ownedDLC = getDLCs 1;
	_ownedDLC pushBack -1;
	
	private _dlc = configSourceMod _configPath;
	private _appId = configFile >> "CfgMods" >> _dlc >> "appId";

	_appId = if (isNumber _appId) then
		{
		(getNumber _appId)
		}
	else
		{
		-1
		};
	
	(_appId in _ownedDLC)
	};
	
RYD_JR_Shopping = 
	{
	params ["_stuff","_seller"];
	
	createDialog "RscShop";

	waitUntil {dialog};
	
	ctrlEnable [16, false];

	private _text = str RYD_JR_FuelFund;
	_text = parseText _text;

	((findDisplay 25002) displayCtrl 14) ctrlSetStructuredText _text;

	RYD_JR_ShopItems = [];
	_margin = _seller getVariable ["RYD_JR_myMargin",0.1];

		{
		private _name = (_x select 0) >> (_x select 1) >> "displayName";
		if (isText _name) then
			{
			_name = ((getText _name) + " " + (str (_x select 3)));
			private _index = lbAdd [2,_name];
			lbSetTooltip [2,_index,_name];
			private _pic = (_x select 0) >> (_x select 1) >> "picture";
			if (isText _pic) then
				{
				lbSetPicture [2,_index, (getText _pic)];
				lbSetPictureColor [2, _index, [1,1,1,1]];
				lbSetPictureColorSelected [2, _index, [1,1,1,1]];
				};
				
			_val = switch (_x select 2) do
				{
				case ("W") :
					{
					([(_x select 1),1,0] call RYD_JR_WeaponValuation)
					};
					
				case ("A") :
					{
					if (isNumber (configFile >> "CfgMagazines" >> (_x select 1) >> "Count")) then
						{
						([(_x select 1),(getNumber (configFile >> "CfgMagazines" >> (_x select 1) >> "Count")),0] call RYD_JR_AmmoValuation)
						}
					else
						{
						0
						}
					};
					
				default
					{
					([(_x select 1),1,0] call RYD_JR_ItemValuation)
					}
				};
				
			_val = (round ((_val * RYD_JR_CargoValueM) * (1 + _margin)) max 1);
			if (_val > 100) then
				{
				_val = (round (_val/10)) * 10
				};
				
			RYD_JR_ShopItems pushBack [_index,(_x select 1),(_x select 0),_val,(_x select 2),(_x select 3),_seller];
			};
		}
	foreach _stuff;
	
	RYD_JR_actSeller = _seller;
	RYD_JR_actStuff = _stuff;

	((findDisplay 25002) displayCtrl 2) ctrlAddEventhandler ["LBSelChanged",RYD_JR_Selected];
	};
	
RYD_JR_BuyThis = 
	{
	private _ix = RYD_JR_selItem select 0;
	private _class = RYD_JR_selItem select 1;
	private _val = RYD_JR_selItem select 3;
	private _type = RYD_JR_selItem select 4;
	private _amt = RYD_JR_selItem select 5;
	private _seller = RYD_JR_selItem select 6;
	private _name = getText ((RYD_JR_selItem select 2) >> (RYD_JR_selItem select 1) >> "displayName");
	private _nAmt = _amt - 1;

	RYD_JR_FuelFund = RYD_JR_FuelFund - _val;
	RYD_JR_FuelFundSpent = RYD_JR_FuelFundSpent + _val;
	
	if (_val > RYD_JR_FuelFund) then
		{
		ctrlEnable [16, false]
		};
	
	private _text = str RYD_JR_FuelFund;
	_text = parseText _text;

	((findDisplay 25002) displayCtrl 14) ctrlSetStructuredText _text;
	
	if (_nAmt > 0) then
		{
		((findDisplay 25002) displayCtrl 2) lbSetText [_ix, (_name + " " + (str _nAmt))];
		lbSetTooltip [2,_ix,(_name + " " + (str _nAmt))];
		(RYD_JR_ShopItems select _ix) set [5,_nAmt];
		(RYD_JR_actStuff select _ix) set [3,_nAmt]
		}
	else
		{
		ctrlEnable [16, false];
		
		RYD_JR_ShopItems set [_ix,0];
		RYD_JR_actStuff set [_ix,0];
		
		RYD_JR_ShopItems = RYD_JR_ShopItems - [0];
		RYD_JR_actStuff = RYD_JR_actStuff - [0];
		
		_seller setVariable ["RYD_JR_myStuff",RYD_JR_actStuff];
		
		((findDisplay 25002) displayCtrl 4) ctrlSetStructuredText (parseText "Here's, what I have...");
		((findDisplay 25002) displayCtrl 8) ctrlSetText "";
		((findDisplay 25002) displayCtrl 11) ctrlSetStructuredText (parseText "");	
		
		lbDelete [2,_ix];
		lbSetCurSel [2,-1];
		
			{
			if not (_foreachIndex < _ix) then
				{
				_x set [0,((_x select 0) - 1)]
				}
			}
		foreach RYD_JR_ShopItems;
		};
		
	if ((isNil "RYD_JR_ShopBox") or {(isNull RYD_JR_ShopBox)}) then
		{
		//_pos = _seller modelToWorld [0,0.5,0];
		_pos = [(position _seller),(_seller getDir player),(((_seller distance player)/2) max 1.5)] call RYD_JR_PosTowards2D;
		_add = 0;
		while {((_pos distance player) < 1.5) or {((_pos distance _seller) < 1.5) or {({(_pos distance _x) < 1.5} count RYD_JR_ShopBoxes) > 0}}} do
			{
			_pos = [_pos,(1.5 + _add),(2.5 + _add)] call RYD_JR_RandomAroundMM;
			
			_add = _add + 0.1;
			if (_add > 10) exitWith {};
			};
		
		_pos set [2,0.2];
		
		RYD_JR_ShopBox = createVehicle ["Box_IND_Grenades_F", _pos, [], 0, "CAN_COLLIDE"];
		RYD_JR_ShopBox allowDamage false;
		RYD_JR_ShopBox setDir ((getDir _seller) + 90);
		
		_pos set [2,((getPosASL _seller) select 2) + 0.2];
		RYD_JR_ShopBox setPosASL _pos;
		
		RYD_JR_ShopBoxes pushBack RYD_JR_ShopBox;
		
		clearItemCargo RYD_JR_ShopBox;
		clearWeaponCargo RYD_JR_ShopBox;
		clearMagazineCargo RYD_JR_ShopBox;
		
		_aID = RYD_JR_ShopBox addAction ["<t color='#d0a900'>Sell content</t>", "SellCargoB.sqf", true, 1, false, true, "", ""];
		
		RYD_JR_ShopBox addEventHandler ["ContainerClosed",RYD_JR_ClosedEmpty];
		};
		
	switch (_type) do
		{
		case ("W") :
			{
			RYD_JR_ShopBox addWeaponCargo [_class,1]
			};
			
		case ("A") :
			{
			RYD_JR_ShopBox addMagazineCargo [_class,1]
			};
			
		case ("I") :
			{
			RYD_JR_ShopBox addItemCargo [_class,1]
			};
		};
	};
	
RYD_JR_ClosedEmpty =
	{
	params ["_holder"];
	
	if (((count (weaponCargo _holder)) + (count (magazineCargo _holder)) + (count (itemCargo _holder))) < 1) then
		{
		RYD_JR_ShopBoxes = RYD_JR_ShopBoxes - [_holder,objNull];
		deleteVehicle _holder
		};
	};
	
RYD_JR_WeaponValuation = 
	{
	params ["_stuff","_amt","_val"];
	
	private _vehClass = configFile >> "CfgVehicles";
	private _weapClass = configFile >> "CfgWeapons";
	private _ammoClass = configFile >> "CfgMagazines";
	private _bulletClass = configFile >> "CfgAmmo";

	private _type = [_stuff] call BIS_fnc_itemType;
	private _val = 0;
	
	switch (true) do
		{
		case ("MissileLauncher" in _type) : {_val = _val + (2400 * _amt)};
		case ("RocketLauncher" in _type) : {_val = _val + (2000 * _amt)};
		case ("Launcher" in _type) : {_val = _val + (2000 * _amt)};
		case ("SniperRifle" in _type) : {_val = _val + (1500 * _amt)};
		case ("MachineGun" in _type) : {_val = _val + (1000 * _amt)};
		case ("AssaultRifle" in _type) : {_val = _val + (700 * _amt)};
		case ("Rifle" in _type) : {_val = _val + (600 * _amt)};
		case ("SubmachineGun" in _type) : {_val = _val + (400 * _amt)};
		case ("Handgun" in _type) : {_val = _val + (100 * _amt)};
		
		case ("Binocular" in _type) : 
			{
			private _addVal = 10;
			
			private _vModes = _weapClass >> _stuff >> "visionMode";
			
			if (isArray _vModes) then
				{
				private _vModes = getArray _vModes;
				private _vModesLow = [];
				
					{
					_vModesLow pushBack (tolower _x)
					}
				foreach _vModes;
				
				private _vModes = _vModesLow;

				if ("nvg" in _vModes) then {_addVal = _addVal + 500};
				if ("ti" in _vModes) then {_addVal = _addVal + 800};
				};
				
			private _zoom = _weapClass >> _stuff >> "opticsZoomMin";
			
			if (isNumber _zoom) then
				{
				private _zoom = getNumber _zoom;
				
				_addVal = _addVal + 10/(0.0001 + _zoom)
				};
			
			_val = _val + (_addVal * _amt)
			};
			
		case ("LaserDesignator" in _type) : 
			{
			_val = _val + (2000 * _amt)
			};			
		
		default {_val = _val + (100 * _amt)}
		};
		
	private _addVal = 0;
	
	if (isArray (_weapClass >> _stuff >> "muzzles")) then
		{
		private _mVal = 80 * (((count (getArray (_weapClass >> _stuff >> "muzzles"))) - 1));
		_addVal = _addVal + _mVal
		};
	
	if (isArray (_weapClass >> _stuff >> "magazines")) then
		{
		private _mags = getArray (_weapClass >> _stuff >> "magazines");
		if ((count _mags) > 0) then
			{
			private _mag = _mags select 0;
			private _magC = _ammoClass >> _mag;
			private _iSpeed = 0;
			private _count = 0;
			
			if (isClass _magC) then
				{
				if (isNumber (_magC >> "initSpeed")) then
					{
					_iSpeed = getNumber (_magC >> "initSpeed")
					};
					
				if (isNumber (_magC >> "count")) then
					{
					_count = getNumber (_magC >> "count")
					}
				};			
			
			if (isText (_ammoClass >> _mag >> "ammo")) then
				{
				private _bullet = getText (_ammoClass >> _mag >> "ammo");
				private _bulletC = _bulletClass >> _bullet;
				if (isClass _bulletC) then
					{
					private _hit = 0;
					
					if (isNumber (_bulletC >> "hit")) then
						{
						_hit = getNumber (_bulletC >> "hit")
						};			
					
					private _iHit = 0;
					
					if (isNumber (_bulletC >> "indirectHit")) then
						{
						_iHit = getNumber (_bulletC >> "indirectHit")
						};			

					private _iHitR = 0;
					
					if (isNumber (_bulletC >> "indirectHitRange")) then
						{
						_iHitR = getNumber (_bulletC >> "indirectHitRange")
						};				
								
					private _cal = 0;
					
					if (isNumber (_bulletC >> "caliber")) then
						{
						_cal = getNumber (_bulletC >> "caliber")
						};
					
					if (_type in ["MissileLauncher","RocketLauncher","Launcher"]) then
						{
						_addVal = _addVal + (round ((_hit + (_iHit * _iHitR)) * _amt))
						}
					else
						{
						_addVal = _addVal + (round (((_cal * 100) + (_iSpeed/8) + (_count min 100)) * _amt));
						}				
					};
				};
			};
		};
		
	(_val + _addVal)
	};
	
RYD_JR_AmmoValuation = 
	{
	params ["_stuff","_bCnt","_val"];
	
	private _ammoClass = configFile >> "CfgMagazines";
	private _bulletClass = configFile >> "CfgAmmo";
	
	private _count = 0;
	if (isNumber (_ammoClass >> _stuff >> "Count")) then
		{
		_count = getNumber (_ammoClass >> _stuff >> "Count")
		};
		
	private _cnt = _bCnt/_count;
		
	private _mass = 0;
	if (isNumber (_ammoClass >> _stuff >> "mass")) then
		{
		_mass = getNumber (_ammoClass >> _stuff >> "mass")
		};
		
	private _ammoName = "";
	if (isText (_ammoClass >> _stuff >> "ammo")) then
		{
		_ammoName = getText (_ammoClass >> _stuff >> "ammo")
		};
								
	if (_count in [1,3]) then
		{
		private _mpl = 1;
		if ((toLower _ammoName) isEqualTo "g_40mm_he") then {_mpl = 10};
		private _vl = getNumber (_ammoClass >> _stuff >> "value");
		
		_val = _val + ((_mass * _vl * _count) * _mpl * _cnt)
		}
	else
		{
		private _hit = 0;
		
		if (isNumber (_bulletClass >> _ammoName >> "hit")) then
			{
			_hit = getNumber (_bulletClass >> _ammoName >> "hit")
			};			
		
		private _iHit = 0;
		
		if (isNumber (_bulletClass >> _ammoName >> "indirectHit")) then
			{
			_iHit = getNumber (_bulletClass >> _ammoName >> "indirectHit")
			};			

		private _iHitR = 0;
		
		if (isNumber (_bulletClass >> _ammoName >> "indirectHitRange")) then
			{
			_iHitR = getNumber (_bulletClass >> _ammoName >> "indirectHitRange")
			};				
		
		private _tSpeed = 0;
		
		if (isNumber (_bulletClass >> _ammoName >> "typicalSpeed")) then
			{
			_tSpeed = getNumber (_bulletClass >> _ammoName >> "typicalSpeed")
			};	
					
		private _cal = 0;
		
		if (isNumber (_bulletClass >> _ammoName >> "caliber")) then
			{
			_cal = getNumber (_bulletClass >> _ammoName >> "caliber")
			};	

		_val = _val + (((_mass ^ 0.85) * _count * ((1 + _hit + _iHitR + _iHit)/100)) * ((1 + _tSpeed)/1000) * (sqrt (1 + _cal)) * _cnt * 0.5)
		};
		
	_val
	};
	
RYD_JR_ItemValuation =
	{
	params ["_stuff","_amt","_val"];
	
	private _weapClass = configFile >> "CfgWeapons";
	private _vehClass = configFile >> "CfgVehicles";
	
	private _type = [_stuff] call BIS_fnc_itemType;
			
	switch (true) do
		{
		case ("AccessoryMuzzle" in _type) : 
			{
			private _addVal = 92;
			private _iInfo = _weapClass >> _stuff >> "ItemInfo" >> "AmmoCoef";
			
			if (isClass _iInfo) then
				{
				private _aF = _iInfo >> "audibleFire";
				private _aFT = _iInfo >> "audibleFireTime";
				private _vF = _iInfo >> "visibleFire";
				private _vFT = _iInfo >> "visibleFireTime";
				
				if (({isNumber _x} count [_aF,_aFT,_vF,_vFT]) == 4) then
					{
					_aF = getNumber _aF;
					_aFT = getNumber _aFT;
					_vF = getNumber _vF;
					_vFT = getNumber _vFT;
					
					_addVal = _addVal + (1/((0.00001 + (_aF * _aFT * _vF * _vFT))^0.65))						
					}
				};
			
			
			_val = _val + (_addVal * _amt)
			};
			
		case ("AccessoryPointer" in _type) : 
			{
			_val = _val + (60 * _amt)
			};
			
		case ("AccessorySights" in _type) : 
			{
			private _addVal = 75;
			private _oModes = _weapClass >> _stuff >> "ItemInfo" >> "OpticsModes";
			
			if (isClass _oModes) then
				{
				private _cntOM = count _oModes;
				
				_addVal = _addVal + (25 * _cntOM);
				
				for "_i" from 0 to (_cntOM - 1) do
					{
					private _om = _oModes select _i;
					
					if (isClass _om) then
						{
						_om = configName _om;
						
						private _minZero = _oModes >> _om >> "distanceZoomMin";
						private _maxZero = _oModes >> _om >> "distanceZoomMax";
						
						if ((isNumber _minZero) and {isNumber _maxZero}) then
							{
							_minZero = getNumber _minZero;
							_maxZero = getNumber _maxZero;
							
							_addVal = _addVal + (((2 * _maxZero) - _minZero)/10)
							};
							
						private _discreteFov = _oModes >> _om >> "discretefov";
						
						if (isArray _discreteFov) then
							{
							_discreteFov = getArray _discreteFov;
							
							_addVal = _addVal + (25 * (count _discreteFov));
							};
							
						private _discreteDst = _oModes >> _om >> "discreteDistance";
						
						if (isArray _discreteDst) then
							{
							_discreteDst = getArray _discreteDst;
							
							_addVal = _addVal + (10 * (count _discreteDst));
							};
						
						private _zoom = _oModes >> _om >> "opticsZoomMin";
						if (isNumber _zoom) then
							{
							_zoom = getNumber _zoom;
							
							_addVal = _addVal + (7.5/_zoom)
							};
							
						private _vModes = _oModes >> _om >> "visionMode";
						if (isArray _vModes) then
							{
							_vModes = getArray _vModes;
							private _vModesLow = [];
							
								{
								_vModesLow pushBack (tolower _x)
								}
							foreach _vModes;
							
							_vModes = _vModesLow;
							
							if ("normal" in _vModes) then {_addVal = _addVal + 100};
							if ("nvg" in _vModes) then {_addVal = _addVal + 500};
							if ("ti" in _vModes) then {_addVal = _addVal + 800};
							};
						}
					}
				};
			
			
			_val = _val + ((_addVal/1.5) * _amt)
			};
			
		case ("AccessoryBipod" in _type) : 
			{
			_val = _val + (200 * _amt)
			};
			
		case ("Binocular" in _type) : 
			{
			private _addVal = 10;
			
			private _vModes = _weapClass >> _stuff >> "visionMode";
			
			if (isArray _vModes) then
				{
				_vModes = getArray _vModes;
				private _vModesLow = [];
				
					{
					_vModesLow pushBack (tolower _x)
					}
				foreach _vModes;
				
				_vModes = _vModesLow;

				if ("nvg" in _vModes) then {_addVal = _addVal + 500};
				if ("ti" in _vModes) then {_addVal = _addVal + 800};
				};
				
			private _zoom = _weapClass >> _stuff >> "opticsZoomMin";
			
			if (isNumber _zoom) then
				{
				_zoom = getNumber _zoom;
				
				_addVal = _addVal + 10/(0.0001 + _zoom)
				};
			
			_val = _val + (_addVal * _amt)
			};
			
		case ("FirstAidKit" in _type) : 
			{
			_val = _val + (30 * _amt)
			};
			
		case ("GPS" in _type) : 
			{
			_val = _val + (100 * _amt)
			};
			
		case ("LaserDesignator" in _type) : 
			{
			_val = _val + (2000 * _amt)
			};
			
		case ("Map" in _type) : 
			{
			_val = _val + (20 * _amt)
			};
			
		case ("Medikit" in _type) : 
			{
			_val = _val + (400 * _amt)
			};
			
		case ("MineDetector" in _type) : 
			{
			_val = _val + (400 * _amt)
			};
			
		case ("NVGoggles" in _type) : 
			{
			_val = _val + (500 * _amt)
			};
			
		case ("Radio" in _type) : 
			{
			_val = _val + (100 * _amt)
			};
			
		case ("Toolkit" in _type) : 
			{
			_val = _val + (400 * _amt)
			};
			
		case ("UAVTerminal" in _type) : 
			{
			_val = _val + (800 * _amt)
			};
			
		case ("Watch" in _type) : 
			{
			_val = _val + (40 * _amt)
			};
			
		case ("Glasses" in _type) : 
			{
			private _addVal = 20;
			
			if (_stuff in ["G_Tactical_Clear","G_Tactical_Black"]) then
				{
				_addVal = 200
				};
			
			_val = _val + (_addVal * _amt)
			};
			
		case ("Headgear" in _type) : 
			{
			private _addVal = 5;
			
			private _ar = _weapClass >> _stuff >> "ItemInfo" >> "HitpointsProtectionInfo" >> "Head" >> "Armor";
			
			if (isNumber _ar) then
				{
				_ar = getNumber _ar;
				
				_addVal = _addVal + _ar
				};
				
			_ar = _weapClass >> _stuff >> "ItemInfo" >> "HitpointsProtectionInfo" >> "Face" >> "Armor";
			
			if (isNumber _ar) then
				{
				_ar = getNumber _ar;
				
				_addVal = _addVal + _ar
				};
			
			private _pT = _weapClass >> _stuff >> "ItemInfo" >> "HitpointsProtectionInfo" >> "Head" >> "passThrough";
			
			if (isNumber _pT) then
				{
				_pT = getNumber _pT;
				
				_addVal = _addVal/((_pT max 0.25)^3)
				};
			
			_val = _val + (_addVal * _amt)
			};
			
		case ("Vest" in _type) : 
			{
			private _addVal = 90;
			
			private _armCfg = _weapClass >> _stuff >> "ItemInfo" >> "HitpointsProtectionInfo";
			
			private _pT_abd = _armCfg >> "Abdomen" >> "passThrough";
			private _pT_arm = _armCfg >> "Arms" >> "passThrough";
			private _pT_che = _armCfg >> "Chest" >> "passThrough";
			private _pT_dia = _armCfg >> "Diaphragm" >> "passThrough";
			private _pT_nec = _armCfg >> "Neck" >> "passThrough";
			//_pT_bod = _armCfg >> "Body" >> "passThrough";
			
			private _aR_abd = _armCfg >> "Abdomen" >> "Armor";
			private _aR_arm = _armCfg >> "Arms" >> "Armor";
			private _aR_che = _armCfg >> "Chest" >> "Armor";
			private _aR_dia = _armCfg >> "Diaphragm" >> "Armor";
			private _aR_nec = _armCfg >> "Neck" >> "Armor";
			//_aR_bod = _armCfg >> "Body" >> "Armor";
			
			private _pT = 0;
			private _ar = 0;
			
				{
				private _vl = _x select 0;
				if (isNumber _vl) then
					{
					_vl = getNumber _vl;
					_pT = _pT + (_vl * (_x select 2));
					}
				else
					{
					_pT = _pT + (_x select 2);
					};
					
				_vl = _x select 1;
				
				if (isNumber _vl) then
					{
					_vl = getNumber _vl;
					_ar = _ar + (_vl * (_x select 2));
					}					
				}
			foreach [[_pT_abd,_aR_abd,0.25],[_pT_arm,_aR_arm,0.15],[_pT_che,_aR_che,0.5],[_pT_dia,_aR_dia,0.05],[_pT_nec,_aR_nec,0.05]];
				
			private _addVal = _addVal + (10/((_pT max 0.25)^3)) + (40 * _ar);
			
			private _cap = _weapClass >> _stuff >> "ItemInfo" >> "containerClass";
			
			if (isText _cap) then
				{
				_cap = getText _cap;
				
				_cap = _vehClass >> _cap >> "maximumLoad";
				
				if (isNumber _cap) then
					{
					_cap = getNumber _cap;
					
					_addVal = _addVal + _cap
					};
				};

			_val = _val + ((_addVal/6) * _amt)
			};
			
		case ("Uniform" in _type) : 
			{
			private _addVal = 110;
			
			private _cap = _weapClass >> _stuff >> "ItemInfo" >> "containerClass";
			
			if (isText _cap) then
				{
				_cap = getText _cap;
				
				_cap = _vehClass >> _cap >> "maximumLoad";
				
				if (isNumber _cap) then
					{
					_cap = getNumber _cap;
					
					_addVal = _addVal + _cap
					};
				};
								
			_val = _val + (_addVal * _amt)
			};
			
		case ("Backpack" in _type) : 
			{
			private _addVal = 140;
			
			private _cap = _vehClass >> _stuff >> "maximumLoad";
			
			if (isNumber _cap) then
				{
				_cap = getNumber _cap;
				_addVal = _addVal + (_cap * 2)
				};				
			
			_val = _val + (_addVal * _amt)
			};
			
		default 
			{
			_val = _val + (10 * _amt)
			}
		};
			
	_val
	};
	
RYD_JR_Selected = 
	{
	params ["_ctrl","_ix"];
	
	RYD_JR_selItem = RYD_JR_ShopItems select _ix;
	private _parent = RYD_JR_selItem select 2;
	private _class = RYD_JR_selItem select 1;
	private _val = RYD_JR_selItem select 3;
		
	private _text = _parent >> _class >> "Library" >> "libTextDesc";
	if (not (isText _text) or {((getText _text) in [""," "])}) then
		{
		_text = _parent >> _class >> "descriptionShort"
		};
		
	if (isText _text) then
		{
		_text = getText _text;
		_text = parseText _text;

		((findDisplay 25002) displayCtrl 4) ctrlSetStructuredText _text;
		};
		
	private _pic = _parent >> _class >> "picture";
		
	if (isText _pic) then
		{
		((findDisplay 25002) displayCtrl 8) ctrlSetText (getText _pic);
		};

	_text = str _val;
	_text = parseText _text;

	((findDisplay 25002) displayCtrl 11) ctrlSetStructuredText _text;
	
	if (_val > RYD_JR_FuelFund) then
		{
		ctrlEnable [16, false]
		}
	else
		{
		ctrlEnable [16, true]
		};
	};