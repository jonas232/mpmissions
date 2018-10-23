RYD_JR_MainLoop =
	{	
	_flareMags = ["Laserbatteries","60Rnd_CMFlareMagazine","120Rnd_CMFlareMagazine","240Rnd_CMFlareMagazine","60Rnd_CMFlare_Chaff_Magazine","120Rnd_CMFlare_Chaff_Magazine","240Rnd_CMFlare_Chaff_Magazine","192Rnd_CMFlare_Chaff_Magazine","168Rnd_CMFlare_Chaff_Magazine","300Rnd_CMFlare_Chaff_Magazine"];
	_ownVehs = [RYD_JR_Boat];
	_lastChat = 0;
	_initAllEnemy = +_this;
	
	_mk = "";
		
	//sleep 5;
	
	RYD_JR_Footsteps = [[getPosATL player,getDir player,0,time,[player] call RYD_JR_ContentWeight]];
	
	_radius = 200;
	_allLoot = 0;
	_allSpots = 0;
	_allVehs = 0;
	_enTStamp = 0;
	_vTStamp = 0;
	_lootedHouses = [];
	_callNo = 0;
	_asTime = time;
	_firstC = true;
	
	_campNot = -400;
	_enemyNot = -400;
	_stp = time;
	
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
	
	_maincycle = 0;

	while {true} do
		{
		_maincycle = _maincycle + 1;
		
		if (isNil "RYD_JR_FuelFund") then 
			{
			RYD_JR_FuelFund = RYD_JR_LastFuelFund
			}
		else
			{
			if not ((typeName RYD_JR_FuelFund) in [typeName 0]) then 
				{
				RYD_JR_FuelFund = RYD_JR_LastFuelFund
				}
			else
				{
				RYD_JR_LastFuelFund = RYD_JR_FuelFund
				}		
			};
		
		//if (isNull player) exitWith {};
		//diag_log "--1";
		
		_lightF = (sqrt (1 + sunOrMoon)) - 1;
		
		_morning = 8 - _lightF;
		_evening = 19 + _lightF;
		
		_cnt = 0;
		_stp = time;
		_vhP = vehicle player;
		_pos = getPosATL _vhP;
		
			{
			switch (true) do
				{
				case (isNil {_x}) : {RYD_JR_Footsteps set [_foreachIndex,0]};
				case (({not (isNil {_x})} count _x) < 5) : {RYD_JR_Footsteps set [_foreachIndex,0]};
				case ((time - (_x select 3)) > (2400 + (_x select 4) + (random 600) + (random 600))) : {RYD_JR_Footsteps set [_foreachIndex,0]};
				case ((rain^2) > (random (8 + ((_x select 4)/300)))) : {RYD_JR_Footsteps set [_foreachIndex,0]};
				}
			}
		foreach RYD_JR_Footsteps;
		
		RYD_JR_Footsteps = RYD_JR_Footsteps - [0];
		RYD_JR_ShopBoxes = RYD_JR_ShopBoxes - [objNull];

		if (dayTime > _morning) then
			{
			if (dayTime < _evening) then
				{
				if (isTouchingGround _vhP) then
					{
					_lastStep = [_pos,getDir _vhP,0,time];
					
					if ((count RYD_JR_Footsteps) > 0) then
						{
						_lastStep = RYD_JR_Footsteps select ((count RYD_JR_Footsteps) - 1);
						}
					else
						{
						RYD_JR_Footsteps = [_lastStep]
						};
					
					if (((_lastStep select 0) distance _pos) > 50) then
						{
						if not (isOnRoad _vhP) then
							{
							if not ((toUpper (surfaceType _pos)) in ["#GDTCONCRETE","#CONCRETE","#GDTROCK"]) then
								{
								_spdF = [0,0,0] distance (velocity _vhP);
								
								if (_spdF > 15) then
									{
									_spdF = (abs (speed _vhP))/3.6
									};	
									
								if (_spdF > 0) then
									{
									_mass = 2400;
									if (RYD_JR_Alex == (vehicle RYD_JR_Alex)) then
										{
										_mass = [player] call RYD_JR_ContentWeight
										};
										
									_newStep = [_pos,getDir _vhP,_spdF,time,_mass];

									RYD_JR_Footsteps pushBack _newStep;
									
									if (RYD_JR_Debug) then
										{
										_cl = "colorPink";
										_i = "fMark_" + (str _pos);
										_i = createMarker [_i,_pos];
										_i setMarkerColor _cl;
										_i setMarkerShape "ICON";
										_i setMarkerType "mil_dot";
										_i setMarkerSize [0.5,0.5];
										}
									}
								}
							}
						}
					}
				}
			};
						
		//diag_log "--1.2";
		_radius = 200;
		
		if (RYD_JR_SCAActive) then
			{
			_radius = RYD_JR_SCARadius
			};
		
		_minus = nearestObjects [_pos,["PowerLines_Wires_base_F","Lamps_base_F","Piers_base_F","Land_NavigLight"],_radius];
		
		_blds = _pos nearObjects ["House",_radius];
		
		_blds = _blds - _minus;
		
		if (RYD_JR_SCAActive) then
			{
			_sideP = side player;

			_center = position player;
			_ppASL = getPosASL player;
			
			_inFight = false;
			
				{
				_ldr = leader _x;
				
				if ((_sideP getFriend (side _ldr)) < 0.6) then
					{
					if ((_center distance _ldr) < 600) then
						{
						if ((_ldr knowsAbout player) > 1) exitWith
							{
							_inFight = true;
							};
						
						if (_inFight) exitWith {}
						};
						
					if (_inFight) exitWith {}
					};
					
				if (_inFight) exitWith {}
				}
			foreach (allGroups - RYD_JR_cached);
				
			_mk = "";
			
			if not (RYD_SCA_Spawning) then
				{
				RYD_SCA_NearCivilians = _center nearEntities ["Civilian",(RYD_JR_SCARadius * 1.1) + ((40 max (RYD_JR_SCARadius * 0.1)) min 100)];
				};
				
			_posTaken = missionnameSpace getVariable ["PosTaken",[]];
					
				{
				_mk = _x getVariable ["RYD_SCA_MyMark",""];
				_toDel = false;
				_dead = false;
				
				switch (true) do
					{
					case (isNil {_x}) : {_toDel = true};
					case (isNull _x) : {_toDel = true};
					case not (alive _x) : {_dead = true};
					};
					
				if (_toDel) then
					{
					RYD_SCA_Civilians set [_foreachIndex,0]
					}
				else
					{
					if ((group _x) getVariable ["RYD_JR_Decoyed",false]) exitWith {};
					
					if ((_x distance _center) > (RYD_JR_SCARadius * 1.1)) then
						{
						_home = _x getVariable ["RYD_SCA_MyHome",[]];
						
							{
							if (_home isEqualTo _x) exitWith {_posTaken set [_foreachIndex,0]}
							}
						foreach _posTaken;							
						
						_toDel = true;
						deleteMarker _mk;
						_gp = group _x;
						deleteVehicle _x;
						deleteGroup _gp;
						
						RYD_SCA_Civilians set [_foreachIndex,0]
						};
						
					if ((_dead) or (({not (isNull _x)} count RYD_SCA_NearCivilians) > RYD_JR_SCADensity)) then
						{
						if ((_x distance _center) > ((RYD_JR_SCARadius/4) max 50)) then
							{
							_isLOS = [_ppASL,getPosASL _x] call RYD_SCA_LOSCheck;
							if not (_isLOS) then
								{
								_home = _x getVariable ["RYD_SCA_MyHome",[]];
								
									{
									if (_home isEqualTo _x) exitWith {_posTaken set [_foreachIndex,0]}
									}
								foreach _posTaken;									
								
								_toDel = true;
								deleteMarker _mk;
								_gp = group _x;
								deleteVehicle _x;
								deleteGroup _gp;
								RYD_SCA_Civilians set [_foreachIndex,0]
								}
							}
						}
					};
					
				if not ((_toDel) or {(_dead) or {(_x getVariable ["RYD_SCA_Armed",false])}}) then
					{
					_ripmark = _x getVariable "RYD_JR_RIPmark";
					if (isNil "_ripmark") then 
						{
						_KilledEH = _x addEventHandler ["Killed", {nul = _this spawn KilledMark}];
						_x setVariable ["RYD_JR_RIPmark",_KilledEH];
						};
						
					_unit = _x;
					
					_reputation = _unit getVariable ["RYD_JR_Reputation",0];	
					
					_lastRep = _x getVariable ["RYD_JR_RepUpdate",-1];
					_lastFire = RYD_SCA_LastFire select 0;
					if (((time - _lastRep) > 120) or {((time - _lastFire) < 20)}) then
						{
						_unit setVariable ["RYD_JR_RepUpdate",time];
						_reputation = [true,_unit] call RYD_JR_CalculateRep;

						_unit setVariable ["RYD_JR_Reputation",_reputation]
						};
					
					_myPos = position _x;
					_psASL = getPosASL _unit;
					_movePos = _myPos;
					_speed = abs (speed _x);
								
					_tgt = _x getVariable ["RYD_SCA_MyTarget",0];
					_home = _x getVariable ["RYD_SCA_MyHome",position _x];
					_panic = _x getVariable ["RYD_SCA_inPanic",-1000];
					_inPanic = false;
					_atHome = ((_speed < 0.1) and ((_x distance _home) < 1));
					_onRoad = isOnRoad _x;
					
					_chance = 0.3/(1 + (_speed/4));
										
					if (dayTime < 4) then
						{
						_chance = 0.05
						}
					else
						{
						switch (true) do
							{
							case (_inFight) :
								{
								_chance = 0.1
								};
							
							case (dayTime < _morning) : 
								{
								_chance = 0.5 - ((_morning - dayTime)/10)
								};
								
							case (dayTime > _evening) : 
								{
								_chance = 0.5 - ((dayTime - _evening)/10)
								};
							}
						};
						
					if ((random 1) < _chance) then
						{
						if ((time - _panic) < (random 60)) then
							{
							_inPanic = true;
							_x forceSpeed -1
							}
						else
							{
							_x setUnitPos "UP";
							_x setUnitPos "AUTO";
							_x setVariable ["RYD_SCA_inPanic",-1000]
							}
						};
									
					_chance = ((_chance/(1 + rain)) max 0.01);
					
					if ((dayTime < _morning) or (dayTime > _evening) or (_inFight)) then
						{
						if not ((_atHome) or (_tgt > 0)) then
							{
							_chance = 1 - _chance
							}
						};
															
					if ((random 1) < _chance) then
						{
						_chance = rain + 0.0125;
						
						if (_inFight) then {_chance = _chance + 1};
									
						if ((random 1.5) > _chance) then
							{
							if not (_inPanic) then
								{
								_x forceSpeed (1 + ([1.4,0,2] call RYD_SCA_GaussB))
								};
							}
						else
							{
							_x forceSpeed -1
							};
														
						_movePos = RYD_SCA_Positions select (floor (random (count RYD_SCA_Positions)));
						_movePos0 = +_movePos;

						_chance = 0.25;
						
						if (dayTime < 4) then
							{
							_chance = 0.95
							}
						else
							{
							switch (true) do
								{
								case (_inFight) :
									{
									_chance = 0.5
									};	
																
								case (dayTime < _morning) : 
									{
									_chance = 0.5 + ((_morning - dayTime)/10)
									};
									
								case (dayTime > _evening) : 
									{
									_chance = 0.5 + ((dayTime - _evening)/10)
									};
								}
							};
						
						_chance = (_chance + (rain/2)) min 0.99;
							
						if ((random 1) < _chance) then
							{
							_movePos = _home;
							_x setVariable ["RYD_SCA_MyTarget",1];
							}
						else
							{
							_x setVariable ["RYD_SCA_MyTarget",0];
							_chance = (0.85/(1 + (rain * 10)));
							
							_fAdd = 0;
							
							if ((_inFight) or (_inPanic)) then
								{
								_chance = 0.1;
								_fAdd = 0.95
								};
							
							if ((random 1) < _chance) then
								{
								_chance = 0.25;
								
								if ((random 1) < _chance) then
									{
									_pos = [_myPos,30,RYD_JR_SCARadius/4] call RYD_JR_RandomAroundMM;
									_pos = _pos isFlatEmpty [2,100 min (RYD_JR_SCARadius/2),0.4,1,0,false,_x];
									if ((count _pos) < 1) then {_movePos = _myPos} else {_movePos = ASLtoATL _pos};
									
									_ct = 0;
									
									while {(isOnRoad _movePos)} do
										{
										_pos = [_myPos,30,RYD_JR_SCARadius/4] call RYD_JR_RandomAroundMM;
										_pos = _pos isFlatEmpty [2,100 min (RYD_JR_SCARadius/2),0.4,1,0,false,_x];
										if ((count _pos) < 1) then {_movePos = _myPos} else {_movePos = ASLtoATL _pos};
										_ct = _ct + 1;
										if (_ct > 5) exitWith {_movePos = _movePos0}
										}
									}
								else
									{
									if (not (_onRoad) or ((random 1) < 0.25)) then
										{
										_movePos = _myPos
										}
									}
								}
							else
								{
								if (((random 1) + 0.05) < (rain + _fAdd)) then
									{
									_movePos = [_x,RYD_SCA_Positions] call RYD_JR_FindClosest;
									}
								}	
							};
						};
						
					_tgt = _unit getVariable ["RYD_SCA_MyTarget",0];
					
					_sitChance = 0.1;
					
					if ((_tgt > 0) and (_atHome)) then
						{
						switch (true) do
							{
							case (dayTime < 4) : 
								{
								_sitChance = 0.8
								};
							
							case (dayTime < _morning) : 
								{
								_sitChance = 0.1 + ((_morning - dayTime)/10)
								};
								
							case (dayTime > _evening) : 
								{
								_sitChance = 0.1 + ((dayTime - _evening/10))
								};
							};						
						
						if ((random 1) < _sitChance) then
							{
							[_unit] spawn
								{
								_unit = _this select 0;
								
								sleep (random 8);
								
								if (isNil "_unit") exitWith {};
								if (isNull _unit) exitWith {};
								if not (alive _unit) exitWith {};
								
								_unit playAction "SitDown"
								}
							}
						}
					else
						{
						if ((_movePos distance _unit) > 1) then
							{
							[_unit,_movePos] spawn
								{
								_unit = _this select 0;
								_movePos = _this select 1;
								sleep (random 8);
								
								if (isNil "_unit") exitWith {};
								if (isNull _unit) exitWith {};
								if not (alive _unit) exitWith {};
								
								_unit doMove _movePos;
								};
							};
						
						if (_speed < 0.1) then
							{
							if ((_movePos distance _unit) < 1) then
								{
								_add = 0.5;
								
								if (_atHome) then {_add = 0.2};
								
								_civs = +RYD_SCA_Civilians;
														
								_closest = [_unit,(_civs + (units (group player)) + AllDead) - [_unit,0]] call RYD_JR_FindClosest;
								
								_dst = _unit distance _closest;
								
								_maxDst = 15;
								if (isPlayer _closest) then
									{
									_maxDst = 100
									};
								
								if (_dst < _maxDst) then
									{
									if (isPlayer _closest) then {_add = _add/3};
									
									_pSpd = [0,0,0] distance (velocity _closest);

									if ((random 1) > (_add/(1 + (_pSpd/10) + ((_maxDst - _dst)/100)))) then
										{							
										if ((_unit knowsAbout _closest) > (1 + _add)) then
											{
											[_unit,_closest] spawn
												{
												_unit = _this select 0;
												_closest = _this select 1;

												sleep (random 8);
												
												if (isNil "_unit") exitWith {};
												if (isNull _unit) exitWith {};
												if not (alive _unit) exitWith {};
												
												_unit doWatch _closest
												}	
											}
										}					
									}
								}
							}
						};
					
					if (RYD_JR_Debug) then
						{	
						_mk setMarkerPos _myPos
						};
						
					if not (_inPanic) then
						{
						if ((_unit getVariable ["RYD_JR_Commented",-1]) < 0) then
							{
							if ((player distance _unit) < 30) then
								{
								_chance = ((sqrt (abs (_reputation * 10))) + 50) min 95;
								_naked = ({(uniform _x) in [""]} count (units (group player))) > 0;
								_rnd = (random 100);
								//diag_log format ["Reputation: %1 chance: %2",_reputation,_chance];
								
								if ((_chance > _rnd) or {(_naked) or {(not (_unit getVariable ["RYD_JR_ColaborationView",false]) and {(count RYD_JR_Delation) < 2})}}) then
									{
									_isFront = not ([player,_unit,getDir _unit] call RYD_JR_IsFlanking);
									if (_isFront) then
										{
										_isLOS = [getPosASL _unit,getPosASL player] call RYD_SCA_LOSCheck;
										if ((_isLOS) and {(_chance > _rnd) or {(_naked)}}) then
											{
											[_unit,_reputation,_naked] spawn
												{
												_unit = _this select 0;
												_reputation = _this select 1;
												_naked = _this select 2;
												
												_slp = 8;
												
												sleep (random _slp);
												
												if (isNil "_unit") exitWith {};
												if (isNull _unit) exitWith {};
												if not (alive _unit) exitWith {};
												
												_unit doWatch player;
												
												if ((_reputation < 0) or (_naked)) then
													{
													if ((((abs _reputation) min 75) > (random 100)) or (_naked)) then
														{
														_home = _unit getVariable ["RYD_SCA_MyHome",position _unit];
														_unit forceSpeed -1;
														_unit doMove _home
														}
													}
												else
													{
													if ((_reputation min 75) > (random 100)) then
														{
														_unit doMove (position _unit)
														}
													};
												
												_pool = +RYD_JR_CivilComment_Neutral;
												
												_unit setVariable ["RYD_JR_Commented",time];
												
												if (_reputation < -50) then {_pool = +RYD_JR_CivilComment_Hateful};
												if (_reputation < -20) then {_pool = _pool + RYD_JR_CivilComment_Negative};
												if (_reputation > 50) then {_pool = +RYD_JR_CivilComment_Enthusiastic};															
												if (_reputation > 20) then {_pool = _pool + RYD_JR_CivilComment_Positive};

												if (_naked) then {_pool = ["Pervert!","Aaaah!","What the f...","Exhibitionist!"]};
												
												_sentence = _pool select (floor (random (count _pool)));

												//diag_log format ["comment2: %1",[_unit,_sentence]];
												RYD_JR_Commenting set [(count RYD_JR_Commenting),[_unit,_sentence,_reputation]];
												}
											};
											
										if (_isLOS) then
											{
											if (not (_unit getVariable ["RYD_JR_ColaborationView",false]) and {(count RYD_JR_Delation) < 2}) then
												{
												_unit setVariable ["RYD_JR_ColaborationView",true];
												_chance = (((80 + (_reputation/3)) max 40) min 95);
												_rnd = random 100;
												
												if (_rnd > _chance) then
													{
													_loc = "";
													_locs = nearestLocations [(position _unit), ["NameCityCapital","NameCity","NameVillage","NameLocal","Hill"], 600];
													if ((count _locs) > 0) then
														{
														_loc = _locs select 0
														};
													
													if not (_loc isEqualTo "") then
														{
														RYD_JR_Delation = [position _loc,time]
														}
													else
														{
														RYD_JR_Delation = [position player,time] 
														};
														
														{
														if ((((RYD_JR_Delation select 0) distance (_x select 0)) < 1000) and {((RYD_JR_Delation select 1) - (_x select 1)) < 3600}) exitWith {RYD_JR_Delation = []};
														}
													foreach RYD_JR_PastDelations;
													
													if not (RYD_JR_Delation isEqualTo []) then
														{
														RYD_JR_PastDelations pushBack RYD_JR_Delation
														}
													}
												}
											}
										}
									}									
								}
							else
								{
								if not (_unit getVariable ["RYD_JR_ColaborationFoot",false]) then
									{								
									if (({((_unit distance (_x select 0)) < 600) and {(time - (_x select 3)) < 600}} count RYD_JR_Footsteps) > 0) then
										{
										_unit setVariable ["RYD_JR_ColaborationFoot",true];
										_chance = (((98 + (_reputation/70)) max 95) min 99.6);
										_rnd = random 100;
										
										if (_rnd > _chance) then
											{
											_clFoot = [_unit,RYD_JR_Footsteps] call RYD_JR_FindClosestF;
											
											RYD_JR_ReportedSteps pushBack _clFoot
											}										
										}
									}
								}
							}
						};
					}
				else
					{
					if ((_x getVariable ["RYD_SCA_Armed",false]) and {not ((_toDel) or {_dead})}) then
						{
						if ((_x knowsAbout player) > 2) then
							{
							if (not (_x getVariable ["RYD_JR_Colaboration",false]) and {(count RYD_JR_Delation) < 2}) then
								{
								_x setVariable ["RYD_JR_Colaboration",true];

								_loc = "";
								_locs = nearestLocations [(position _x), ["NameCityCapital","NameCity","NameVillage","NameLocal","Hill"], 600];
								if ((count _locs) > 0) then
									{
									_loc = _locs select 0
									};
								
								if not (_loc isEqualTo "") then
									{
									RYD_JR_Delation = [position _loc,time]
									}
								else
									{
									RYD_JR_Delation = [position player,time]
									};
									
									{
									if ((((RYD_JR_Delation select 0) distance (_x select 0)) < 1000) and {((RYD_JR_Delation select 1) - (_x select 1)) < 3600}) exitWith {RYD_JR_Delation = []};
									}
								foreach RYD_JR_PastDelations;
								
								if not (RYD_JR_Delation isEqualTo []) then
									{
									RYD_JR_PastDelations pushBack RYD_JR_Delation
									}
								}							
							}
						}
					}
				}
			foreach RYD_SCA_Civilians;
			
			_posTaken = _posTaken - [0];
	
			missionnameSpace setVariable ["PosTaken",_posTaken];
			//diag_log "--1.3";		
			RYD_SCA_Civilians = RYD_SCA_Civilians - [0];
			
				{
				removeAllAssignedItems _x;
				}
			foreach RYD_SCA_Civilians;
			
			//_cntCiv = count RYD_SCA_Civilians;
							
			_cntCiv = {not (isNull _x)} count RYD_SCA_NearCivilians;
			
			if (_cntCiv < RYD_JR_SCADensity) then		
				{
				if not (RYD_SCA_Spawning) then
					{
					if (((_center distance RYD_SCA_LastPlayerPos) > (RYD_JR_SCARadius/2)) or (RYD_SCA_LastCivCount > _cntCiv)) then
						{
						RYD_SCA_LastPlayerPos = _center;
						RYD_SCA_LastCivCount = _cntCiv;
						
							{
							if ((_x distance player) > (RYD_JR_SCARadius * 1.1)) then
								{
								RYD_SCA_Positions set [_foreachIndex,0]
								}
							}
						foreach RYD_SCA_Positions;
					
						RYD_SCA_Positions = RYD_SCA_Positions - [0];
						
							{
							if ((_x distance player) > (RYD_JR_SCARadius * 1.1)) then
								{
								RYD_SCA_Buildings set [_foreachIndex,0]
								}
							}
						foreach RYD_SCA_Buildings;
					
						RYD_SCA_Buildings = RYD_SCA_Buildings - [0];
						
						_bs = +_blds;
						
						_minus2 = nearestObjects [_center,RYD_JR_BetterLootBuildings,_radius];
						
						_bs = _bs - (_minus2 + RYD_SCA_Buildings);
						
						_cnt = count _bs;
												
							{
							if (((_x buildingpos 0) distance [0,0,0]) < 1) then
								{
								_bs set [_foreachIndex,0]
								}				
							}
						foreach _bs;
										
						_bs = _bs - [0];
						
						for "_a" from 0 to ((count _bs) - 1) do 
							{
							_ix = floor (random (count _bs));
							_bd = _bs select _ix;
							_bs set [_ix,0];
							_bs = _bs - [0];
							
							if not (_bd in RYD_SCA_Buildings) then
								{
								RYD_SCA_Buildings pushBack _bd
								};
									
							if ((count RYD_SCA_Buildings) > (RYD_JR_SCADensity * 5)) exitWith {};
							if ((count _bs) < 1) exitWith {};
							};
						
						_posCount = count RYD_SCA_Positions;
						
						if (_posCount < (RYD_JR_SCADensity * 15)) then
							{
							_addPos = (RYD_JR_SCADensity * 15) - _posCount;
							
							_bps = [_center,RYD_SCA_Buildings,_addPos] call RYD_SCA_BPos;

							RYD_SCA_Positions = RYD_SCA_Positions + _bps;
							};
						
						_cntBs = count RYD_SCA_Buildings;
						
						_addCount = (floor (_cntBs * (((((400/RYD_JR_SCARadius)^2)/5) min 3) max 0.2)) min ((RYD_JR_SCADensity - _cntCiv) max 0));

						//_addCount = (floor ((_cntBs * 80)/RYD_JR_SCARadius)) - _cntCiv;
							
						_posCount = count RYD_SCA_Positions;
						
						if ((_addCount min _posCount) > 0) then
							{
							_posTaken = missionnameSpace getVariable ["PosTaken",[]];
							
								{
								_mk = _x getVariable ["RYD_SCA_MyMark",""];
								_toDel = false;
								_dead = false;
								
								switch (true) do
									{
									case (isNil {_x}) : {_toDel = true};
									case (isNull _x) : {_toDel = true};
									case not (alive _x) : {_dead = true};
									};
									
								if (_toDel) then
									{									
									RYD_SCA_Civilians set [_foreachIndex,0]
									}
								else
									{
									if ((_x distance _center) > (RYD_JR_SCARadius * 1.1)) then
										{
										_home = _x getVariable ["RYD_SCA_MyHome",[]];
										
											{
											if (_home isEqualTo _x) exitWith {_posTaken set [_foreachIndex,0]}
											}
										foreach _posTaken;										
										
										_toDel = true;
										deleteMarker _mk;
										_gp = group _x;
										deleteVehicle _x;
										deleteGroup _gp;
										
										RYD_SCA_Civilians set [_foreachIndex,0]
										};
										
									if ((_dead) or (({not (isNull _x)} count RYD_SCA_NearCivilians) > RYD_JR_SCADensity)) then
										{
										if ((_x distance _center) > ((RYD_JR_SCARadius/4) max 50)) then
											{
											_isLOS = [_ppASL,getPosASL _x] call RYD_SCA_LOSCheck;
											if not (_isLOS) then
												{
												_home = _x getVariable ["RYD_SCA_MyHome",[]];
												
													{
													if (_home isEqualTo _x) exitWith {_posTaken set [_foreachIndex,0]}
													}
												foreach _posTaken;	
												
												_toDel = true;
												deleteMarker _mk;
												_gp = group _x;
												deleteVehicle _x;
												deleteGroup _gp;
												RYD_SCA_Civilians set [_foreachIndex,0]
												}
											}
										}
									}
								}
							foreach RYD_SCA_Civilians;

							_posTaken = _posTaken - [0];
	
							missionnameSpace setVariable ["PosTaken",_posTaken];
							
							RYD_SCA_Civilians = RYD_SCA_Civilians - [0];
												
							[((_addCount min _posCount) min RYD_JR_SCADensity)] spawn RYD_SCA_Spawn;
							}
						}
					}
				}		
			};
			
			{
			switch (true) do
				{
				case (isNil {_x}) : {RYD_JR_Trackers set [_foreachIndex,0]};
				case (isNull _x) : {RYD_JR_Trackers set [_foreachIndex,0]};
				case (({alive _x} count (units _x)) < 1) : {deleteGroup _x;RYD_JR_Trackers set [_foreachIndex,0]};
				}
			}
		foreach RYD_JR_Trackers;
		//diag_log "--1.1";
		RYD_JR_Trackers = RYD_JR_Trackers - [0];
		
			{
			switch (true) do
				{
				case (isNil {_x}) : {RYD_JR_AllMobile set [_foreachIndex,0]};
				case (isNull _x) : {RYD_JR_AllMobile set [_foreachIndex,0]};
				case (({alive _x} count (units _x)) < 1) : {deleteGroup _x;RYD_JR_AllMobile set [_foreachIndex,0]};
				}
			}
		foreach RYD_JR_AllMobile;
		
		RYD_JR_AllMobile = RYD_JR_AllMobile - [0];
		
			{
			switch (true) do
				{
				case (isNil {_x}) : {RYD_JR_BusyPatrols set [_foreachIndex,0]};
				case (isNull _x) : {RYD_JR_BusyPatrols set [_foreachIndex,0]};
				case (({alive _x} count (units _x)) < 1) : {deleteGroup _x;RYD_JR_BusyPatrols set [_foreachIndex,0]};
				}
			}
		foreach RYD_JR_BusyPatrols;
		
		RYD_JR_BusyPatrols = RYD_JR_BusyPatrols - [0];
		
		if ((count RYD_JR_Footsteps) > 0) then
			{
			
				{
				if not (_x getVariable ["RYD_JR_Chasing",false]) then
					{
					_trackers = _x;
					_ldr = leader _x;
					
					_clFoot = [_ldr,RYD_JR_Footsteps] call RYD_JR_FindClosestF;
					
					if ((count _clFoot) < 1) exitWith {};
										
					_tDst = (_clFoot select 0) distance _ldr;
					
					if ((_tDst > 100) and {(count RYD_JR_ReportedSteps) > 0}) then
						{
						_clFoot = [_ldr,RYD_JR_ReportedSteps] call RYD_JR_FindClosestF;
						_dDst = _ldr distance (_clFoot select 0);

						if (_dDst < 3000) then
							{
							
							
								{
								if (_x isEqualTo _clFoot) then
									{
									RYD_JR_ReportedSteps set [_foreachIndex,0]
									}
								}
							foreach RYD_JR_ReportedSteps;
							RYD_JR_ReportedSteps = RYD_JR_ReportedSteps - [0];
							_tDst = 0.1
							}
						};					
					
					_mass = _clFoot select 4;
					
					if (_tDst < 100) then
						{
						_tSkill = _ldr skillFinal "SpotDistance";
						
						if (((_tSkill * 0.75) + 0.01 + (_mass/2400)) > (random (_tDst/20))) then
							{
							_x setVariable ["RYD_JR_Chasing",true];
							
							_pos = _clFoot select 0;
							_dir = _clFoot select 1;
							_speed = _clFoot select 2;
							_tme = _clFoot select 3;
							
							_clFoot set [3,-36000];
							
							_dst = _speed * (time - _tme);
							
							_curPos = [_pos,_dir,_dst] call RYD_JR_PosTowards2D;
							
							_chaseDst = _ldr distance _curPos;
							
							_footTime = _chaseDst/3.5;
							
							_predDst = _speed * _footTime;
													
							_predPos = [_curPos,_dir,_predDst] call RYD_JR_PosTowards2D;
							
							while {((surfaceIsWater _predPos) and {(_predDst > 10)})} do
								{
								_predDst = _predDst * 0.75;
								_predPos = [_curPos,_dir,_predDst] call RYD_JR_PosTowards2D;
								};
							
							_predDest = [_predPos,RYD_JR_allCities + RYD_JR_allVillages + RYD_JR_allLocal] call RYD_JR_FindClosest;
										
							if (RYD_JR_Debug) then
								{
								_cl = "colorRed";
								_i = "lMark_" + (str _predPos);
								_i = createMarker [_i,_predPos];
								_i setMarkerColor _cl;
								_i setMarkerShape "ICON";
								_i setMarkerType "mil_dot";
								_i setMarkerSize [0.85,0.85];
								_i setMarkerText ("Chase:" + (text _predDest))
								};
								
							_calledArmor = grpNull;
							
							_allMobile = +RYD_JR_AllMobile;
							
							if (RYD_JR_ACIntense > 0) then
								{
									{
									if not ((side _x) == (side _ldr)) then
										{
										_allMobile set [_foreachIndex,0]
										}
									}
								foreach _allMobile;
								
								_allMobile = _allMobile - [0];
								};
							
							_mobile = _allMobile - RYD_JR_BusyPatrols;
							
							_patrol = [position _predDest,_mobile] call RYD_JR_FindClosest;
							
							if (((vehicle (leader _patrol)) distance player) < 4000) then
								{
								RYD_JR_PatrolCalled = true;
								
								_calledArmor = _patrol;
								
								[_patrol,[position _predDest,10,200] call RYD_JR_RandomAroundMM,_trackers] spawn RYD_JR_Response
								};
								
							_calledHeli = grpNull;
								
							if (RYD_JR_APRangeM > 0) then
								{
								_avHeli = [];
								
									{
									_alive = true;
									switch (true) do
										{
										case (isNil {_x}) : {RYD_JR_AllHelis set [_foreachIndex,0];_alive = false};
										case (isNull _x) : {RYD_JR_AllHelis set [_foreachIndex,0];_alive = false};
										case (({(alive _x)} count (units _x)) < 1) : {deleteGroup _x;RYD_JR_AllHelis set [_foreachIndex,0];_alive = false};
										};
												
									if (_alive) then
										{
										_mh = _x getVariable ["RYD_JR_MyHeli",objNull];
										
										switch (true) do
											{
											case (isNil {_mh}) : {RYD_JR_AllHelis set [_foreachIndex,0]};
											case (isNull _mh) : {RYD_JR_AllHelis set [_foreachIndex,0]};
											case not (alive _mh) : {RYD_JR_AllHelis set [_foreachIndex,0]};
											};
										}
									}
								foreach RYD_JR_AllHelis;
								
								RYD_JR_AllHelis = RYD_JR_AllHelis - [0];
															
								_avHeli = RYD_JR_AllHelis - RYD_JR_BusyHelis;
								_avHeli = +_avHeli;
								
								if ((RYD_JR_ACIntense == 0) or ((side _ldr) == east)) then
									{
									if ((count _avHeli) > 0) then
										{
										_pPos = position _predDest;

										_heli = [_pPos,_avHeli] call RYD_JR_FindClosest;
										_mh = _heli getVariable ["RYD_JR_MyHeli",objNull];
										
										_dst = _pPos distance _mh;
										
										_maxD = 10500;
										
										switch (RYD_JR_APRangeM) do
											{
											case (1.2) : {_maxD = 6000};
											case (0.5) : {_maxD = 2500};
											case (0.25) : {_maxD = 0};
											};
										
										_chance = 1500 + ((((random 2500) + (random 2500) + (random 2500) + (random 2500)) * RYD_JR_APRangeM) min _maxD);

										if (_chance > _dst) then
											{
											RYD_JR_BusyHelis pushBack _heli;
											_calledHeli = _heli;
											[_mh,[_pPos,200] call RYD_JR_RandomAround,_trackers] call RYD_JR_AirResponse;
											};
										};
									};
								};																		
							
							_gp = _trackers;
							
							[_gp] call RYD_JR_WPDel;
							
								{
								_x forceSpeed -1;
								_x doMove (position _x)
								}
							foreach (units _gp);
							
							_wp = _gp addWaypoint [position _predDest, 0];
							_wp setWaypointType "SAD";
							_wp setWaypointBehaviour "AWARE";
							_wp setWaypointCombatMode "RED";
							_wp setWaypointSpeed "NORMAL";
							
							_gp setCurrentWaypoint _wp;

							_wp = _gp addWaypoint [_predPos, 0];
							_wp setWaypointType "SAD";
							_wp setWaypointBehaviour "AWARE";
							_wp setWaypointCombatMode "RED";
							_wp setWaypointSpeed "NORMAL";
							
							_wp setWaypointStatements ["true","(group this) setVariable ['RYD_JR_Chasing',false]"];
												
							_wp = _gp addWaypoint [position _predDest, 0];
							_wp setWaypointType "CYCLE";
							_wp setWaypointBehaviour "AWARE";
							_wp setWaypointCombatMode "RED";
							_wp setWaypointSpeed "NORMAL";

							if ((time - RYD_JR_LastReport) < 60) exitWith {};

							if (((side _gp) in RYD_JR_Freq) and {"ItemRadio" in (assignedItems player)}) then
								{
								_caller = leader _gp;
								
								if ((player distance _caller) < 6000) then
									{
									RYD_JR_LastReport = time;
																		
									_loc = "";
									_locs = nearestLocations [_pos, ["NameCityCapital","NameCity","NameVillage","NameLocal","Hill"], 600];
									if ((count _locs) > 0) then
										{
										_loc = _locs select 0
										};
									
									_where = mapGridPosition _pos;
									if not (_loc isEqualTo "") then
										{
										_where = text _loc;
										
										if (_where isEqualTo "") then
											{
											_where = mapGridPosition _pos;
											}
										};									
									
									_supLoc = text _predDest;
									
									if (_supLoc isEqualTo "") then
										{
										_supLoc = mapGridPosition (position _predDest)
										};
										
									_kmDst = (round (_chaseDst/100))/10;
										
									_addS = " click from us";
									if (_kmDst >= 2) then 
										{
										_addS = " clicks from us"
										}
									else
										{
										if (_kmDst < 0.5) then
											{
											_kmDst = "";
											_addS = "near our position"
											};									
										};
									
									_sent = (name _caller) + (format [" reporting. Enemy was passing by " + _where + ". Approximate movement direction: %1 at speed: %2. Probably %3%5, heading towards %4. Following the trail, requesting any support available in the predicted area. Over.",
									(round (_dir/10)) * 10,
									(round ((_speed * 3.6)/10))*10,
									_kmDst,
									_supLoc,
									_addS
									]);
									
									[_sent,_caller,_calledHeli,_calledArmor] spawn
										{
										_sent = _this select 0;
										_caller = _this select 1;
										_calledHeli = _this select 2;
										_calledArmor = _this select 3;
										
										_alive = true;
										
										waitUntil
											{
											sleep (10 + (random 10));
											
											switch (true) do
												{
												case (isNil "_caller") : {_alive = false};
												case not ((typeName _caller) isEqualTo (typename objNull)) : {_alive = false};
												case (isNull _caller) : {_alive = false};
												case not (alive _caller) : {_alive = false};
												case (isNull (group _caller)) : {_alive = false};
												case (RYD_JR_Outro) : {_alive = false};
												};
											
											(not (_alive) or {((time - RYD_JR_LastComm) > 15)})
											};				
										
										if not (_alive) exitWith {};
										
										RYD_JR_LastComm = time;						
										
										["static1",2.5] spawn RYD_JR_Sound3D;
										sleep 0.02;
										
										RYD_JR_Caller customChat [RYD_JR_RadioAlarm,_sent];
										
										if not (isNull _calledHeli) then
											{
											_calledHeli setVariable ["RYD_JR_Called",true]
											};
											
										if not (isNull _calledArmor) then
											{
											_calledArmor setVariable ["RYD_JR_Called",true]
											};
										}
									}
								}
							}
						}
					}
				}
			foreach RYD_JR_Trackers
			};
					
		if ((count RYD_JR_Delation) > 1) then
			{
			_delation = RYD_JR_Delation select 0;
			_delation set [2,0];
			
			_freeTrackers = [];
			
				{
				if not (_x getVariable ["RYD_JR_Chasing",false]) then
					{
					_freeTrackers pushBack _x
					}
				}
			foreach RYD_JR_Trackers;
			
			_tracker = ([_delation,_freeTrackers] call RYD_JR_FindClosestWithIndex) select 0;
			_ldr = leader _tracker;
			_cPos = position _ldr;
			
			if ((_cPos distance _delation) < 3000) then
				{
				_gp = _tracker;
				
				_gp setVariable ["RYD_JR_Chasing",true];
				
				[_gp] call RYD_JR_WPDel;
				
					{
					_x forceSpeed -1;
					_x doMove (position _x)
					}
				foreach (units _gp);
								
				_delatPos = [_delation,10,300] call RYD_JR_RandomAroundMM;
				
				_wp = _gp addWaypoint [_delatPos, 0];
				_wp setWaypointType "SAD";
				_wp setWaypointBehaviour "AWARE";
				_wp setWaypointCombatMode "RED";
				_wp setWaypointSpeed "NORMAL";
				_wp setWaypointTimeOut [40,60,80];
				
				_gp setCurrentWaypoint _wp;
				
				_delatPos2 = [_cPos,10,300] call RYD_JR_RandomAroundMM;

				_wp = _gp addWaypoint [_delatPos2, 0];
				_wp setWaypointType "SAD";
				_wp setWaypointBehaviour "AWARE";
				_wp setWaypointCombatMode "RED";
				_wp setWaypointSpeed "NORMAL";
				_wp setWaypointTimeOut [40,60,80];
				
				_wp setWaypointStatements ["true","(group this) setVariable ['RYD_JR_Chasing',false]"];
									
				_wp = _gp addWaypoint [_delatPos, 0];
				_wp setWaypointType "CYCLE";
				_wp setWaypointBehaviour "AWARE";
				_wp setWaypointCombatMode "RED";
				_wp setWaypointSpeed "NORMAL";
				
				if ((time - RYD_JR_LastReport) < 60) exitWith {};
				
				if (((side _gp) in RYD_JR_Freq) and {"ItemRadio" in (assignedItems player)}) then
					{
					_caller = leader _gp;
					
					if ((player distance _caller) < 6000) then
						{
						RYD_JR_LastReport = time;
																		
						_loc = "";
						_locs = nearestLocations [_delation, ["NameCityCapital","NameCity","NameVillage","NameLocal","Hill"], 600];
						if ((count _locs) > 0) then
							{
							_loc = _locs select 0
							};
						
						_supLoc = mapGridPosition _delation;
						if not (_loc isEqualTo "") then
							{
							_supLoc = text _loc;
							if (_supLoc isEqualTo "") then
								{
								_supLoc = mapGridPosition _delation;
								}
							};
							
						if (RYD_JR_Debug) then
							{
							_i = "DelMark_" + (str _delatPos);
							_i = createMarker [_i,_delatPos];
							_i setMarkerColor "colorBrown";
							_i setMarkerShape "ICON";
							_i setMarkerType "mil_dot";
							_i setMarkerSize [0.6,0.6];
							_i setMarkerText (format ["L:%1-N:%2-DST:%3",_loc,_supLoc,(_delatPos distance _caller)]);
							};
							
						_add = switch (RYD_JR_HuntStage) do
							{												
							case (2) :
								{
								". It may be this supposed troublemaking outlander."
								};
								
							case (3) :
								{
								". According to the description, it's again that fucker, Alex."
								};
								
							case (4) :
								{
								". No doubt, infamous 'Sweeper' Laskaris himself! The bounty will be ours, we're rich!"
								};
								
							default
								{
								"."
								}
							};
							
						
						_sent = (name _caller) + (format [" reporting. Enemy presence was reported at " + _supLoc + ". We're investigating this%1 Over.",_add]);
						
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
									case (RYD_JR_Outro) : {_alive = false};
									};
								
								(not (_alive) or {((time - RYD_JR_LastComm) > 8)})
								};				
							
							if not (_alive) exitWith {};
							
							RYD_JR_LastComm = time;						
							
							["static1",2.5] spawn RYD_JR_Sound3D;
							sleep 0.02;
							
							RYD_JR_Caller customChat [RYD_JR_RadioAlarm,_sent]
							}
						}
					}				
				}
			};
		
		RYD_JR_Delation = [];
				
		_houses = [];
		_plPos = getPosATL (vehicle player);
		//diag_log "--1.4";
			{
			if not (isNull _x) then
				{
				if ((_x distance _plPos) < 200) then
					{
					if not (isArray (configFile >> "CfgVehicles" >> (typeof _x) >> "compatibleWires")) then
						{
						if not (RYD_JR_RealLoot) then
							{
							_houses pushBack _x
							}
						else
							{
							if (_x in RYD_JR_Strongholds) then
								{
								_houses pushBack _x
								}
							else
								{
								if ((typeOf _x) in RYD_JR_BetterLootBuildings) then
									{
									_houses pushBack _x
									}
								}
							}
						};
					}
				}
			}
		foreach _blds;
					
			{
			_lootSpots = _x getVariable "RYD_JR_LootPlace";
			if (isNil "_lootSpots") then
				{
				_bPos = _x buildingPos 0;
				_lootSpots = [];
				_ct = 0;
				
				while {not ((_bPos select 0) == 0)} do
					{
					_lootSpots pushBack _bPos;
					_ct = _ct + 1;
					if (_ct > 100) exitWith {};
					_bPos = _x buildingPos _ct;
					};
				
				_allSpots = _allSpots + (count _lootSpots);
									
				_x setVariable ["RYD_JR_LootPlace",_lootSpots]
				};
				
			if ((count _lootSpots) < 1) then 
				{
				_houses set [_foreachIndex,0]
				}
			}
		foreach _houses;
		
		_houses = _houses - [0];
		
		_houses = _houses - _lootedHouses;
		
		_houses = [_houses] call RYD_JR_RandomOrd;
		
		//diag_log "--2";
		
			{
			_loot = _x getVariable "RYD_JR_Loot";
			_isMilitary = (typeOf _x) in RYD_JR_BetterLootBuildings;
			
			if (_isMilitary) then
				{
				_x setVariable ["RYD_JR_Luck",0.1];
				};
				
			if (RYD_JR_RealLoot) then
				{
				_x setVariable ["RYD_JR_Luck",0.5 * RYD_JR_CargoDensityM];
				
				if (_x in RYD_JR_Strongholds) then
					{
					_x setVariable ["RYD_JR_Luck",RYD_JR_CargoDensityM];
					}
				};
							
			if (isNil "_loot") then
				{
				_loot = [];
				_lootedHouses pushBack _x;
				
				if ((random 100) < 33) then
					{
					RYD_JR_SomeHouses pushBack _x
					};

				_factor = (_allSpots/(_allLoot max 0.01)) * RYD_JR_CargoDensityM;
				_luck = _x getVariable ["RYD_JR_Luck",0.01];
				if (RYD_JR_CargoDensityM == 0) then {_luck = 0};
								
				if ((_factor > 25) or ((random 1) < _luck)) then
					{
					if ((random 1) > ((1 - (random _luck) - (_factor/1000)) min 0.1)) then
						{
						_posTaken = missionnameSpace getVariable ["PosTaken",[]];
						_lootSpots = _x getVariable ["RYD_JR_LootPlace",[]];
						_ct = 0;
						
						while {((_ct == 0) or not ((random (_ct + 1)) > (random (1/(_ct + 2)))))} do
							{
							_ix = floor (random (count _lootSpots));
							_lootSpot = _lootSpots select _ix;
							
							_tkn = false;							
							
								{
								if (((typename _lootSpot) in [(typename [])]) and {((typename _x) in [(typename [])])}) then
									{
									if ((_lootSpot distance _x) < 2) exitWith {_tkn = true};
									};
									
								if (_tkn) exitWith {}
								}
							foreach _posTaken;
							
							_lootSpots set [_ix,0];
							_lootSpots = _lootSpots - [0];

							if not (_tkn) then
								{
								_loot pushBack _lootSpot;
								_ct = _ct + 1;
								};
							
							if ((count _lootSpots) < 1) exitWith {}
							};
							
						_hlds = [_loot,_isMilitary] call RYD_JR_AddLoot;
						
						RYD_JR_AllHolders = RYD_JR_AllHolders + _hlds;
						
						missionNamespace setVariable ["PosTaken",_postaken + _loot];
						
						_allLoot = _allLoot + (count _loot);
						_x setVariable ["RYD_JR_LootPlace",_lootSpots];
						RYD_JR_AllLootHouses set [(count RYD_JR_AllLootHouses),[_x,_hlds]];
						
						if (RYD_JR_Debug) then
							{						
								{
								_i = "HMark_" + (str _x);
								_i = createMarker [_i,_x];
								_i setMarkerColor "colorRed";
								_i setMarkerShape "ICON";
								_i setMarkerType "mil_dot";
								_i setMarkerSize [0.15,0.15];
								}
							foreach _loot
							}
						}
					};
					
				_x setVariable ["RYD_JR_Loot",_loot]; 
				}
			}
		foreach _houses;
		
			{			
			switch (true) do
				{
				case (isNil {_x}) : {RYD_JR_AllHolders set [_foreachIndex,0]};
				case (isNull _x) : {RYD_JR_AllHolders set [_foreachIndex,0]};
				}
			}
		foreach RYD_JR_AllHolders;
				
		RYD_JR_AllHolders = RYD_JR_AllHolders - [0];
		
			{
			switch (true) do
				{
				case (isNil {_x}) : {RYD_JR_AllStuff set [_foreachIndex,0]};
				case (isNull _x) : {RYD_JR_AllStuff set [_foreachIndex,0]};
				}
			}
		foreach RYD_JR_AllStuff;
				
		RYD_JR_AllStuff = RYD_JR_AllStuff - [0];
		
		//diag_log "--3";

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
		
		_uavC = getConnectedUav player;		
				
			{
			_rad = 2000;
			
			switch (true) do
				{
				//case (_x in RYD_JR_AllStuff) : {_rad = 1500};
				//case (_x in RYD_JR_AllHolders) : {_rad = 500};
				case (_x getVariable ["RYD_JR_Chasing",false]) : {_rad = 50000};
				case (_x getVariable ["RYD_JR_Decoyed",false]) : {_rad = 50000};
				case (_x in RYD_JR_AllMobile) : {_rad = 4000};
				};
				
			_ldr0 = (leader _x);
			_sub0 = (units _x) - [_ldr0];
			_ldr = vehicle _ldr0;
			_ldrV = assignedVehicle _ldr0;
	
			if (isNull _ldrV) then {_ldrV = _ldr};
			
			_drv = assignedDriver _ldrV;
			_gun = assignedGunner _ldrV;
			_com = assignedCommander _ldrV;
			
			if (isNull _drv) then {_drv = driver _ldrV};
			if (isNull _gun) then {_gun = gunner _ldrV};
			if (isNull _com) then {_com = commander _ldrV};
			
			_assCL = assignedCargo _ldrV;
			_ldrCrew = ([_drv,_gun,_com,_ldrV] + _assCL);
			_ldrCrewMen = (_ldrCrew - [_ldrV,_ldr0]) + [_ldr0];
			_sub0 = _sub0 - _ldrCrew;
				
			_pos = getPosATL _ldr;
			
			if (RYD_JR_Debug) then
				{
				_mk = _x getVariable ["mymarker",""];
				_mk setMarkerPos _pos;
				//_mk setMarkerText (str (side _ldr0)) + "_" + (str (((expectedDestination _ldr0) select 0) distance (position _ldr0)));
				};
				
			switch (_x in RYD_JR_cached) do
				{
				case (false) :
					{
					_timeStamp = _x getVariable ["RYD_JR_TS",-110];
					
					if ((time - _timeStamp) > 120) then
						{
						_cDst = _pos distance player;
						
						if not (isNull _uavC) then
							{
							_cDst = _cDst min (_pos distance _uavC)
							};
						
						if (_cDst > _rad) then
							{						
							switch (RYD_JR_CachingMode) do
								{
								case (1) :
									{
									_sub = [];
									_vehs = [];
									_added = [];
									
										{
										_sVeh = vehicle _x;
										_assVeh = assignedVehicle _x;
										if (isNull _assVeh) then {_assVeh = _sVeh};
										
										if (_assVeh == _x) then
											{
											if not (_x in _sub) then
												{
												_sub set [count _sub,_x];
												};
											};
											
										if not (_assVeh == _x) then
											{
											if not (_assVeh in _added) then
												{
												_crew = [];
												_assCargo = [];
												_drv = assignedDriver _assVeh;
												_gun = assignedGunner _assVeh;
												_com = assignedCommander _assVeh;
												
												if (isNull _drv) then {_drv = driver _assVeh};
												if (isNull _gun) then {_gun = gunner _assVeh};
												if (isNull _com) then {_com = commander _assVeh};
												
													{
													_crew set [count _crew,_x]
													}
												foreach [_drv,_gun,_com];
												
													{
													_driverOut = false;
													_type = typeOf _x;
													_sPos = getPosATL _x;
													_sDir = getDir _x;
													_sDam = damage _x;
													_sCargo = [];
													_data = [[],_type,_sPos,_sDir,_sDam,_x getVariable ["RYD_JR_Stopped",false],_x getVariable ["RYD_JR_Watched",[]],unitPos _x,_x getVariable ["RYD_JR_Sitting",false],_sCargo,_driverOut,_x getVariable ["RYD_JR_MyRemovedGear",[]],_x in _assVeh,_x];											
													_assCargo pushBack _data;
													}
												foreach (assignedCargo _assVeh);
												
												_added pushBack _assVeh;
												_vehs set [(count _vehs),[_assVeh,_crew,_assCargo]];
												}
											}
										}
									foreach _sub0;
																		
									_gp = _x;

									_x allowFleeing 0;
									
										{
										_x enableSimulation false;
										_x hideObject true
										}
									foreach _ldrCrew;

									_ldr0 enableSimulation false;
									_ldr0 hideObject true;
									
									_gpData = [];

										{
										_isMan = [];
										_driverOut = false;
										_type = typeOf _x;
										_sPos = getPosATL _x;
										_sDir = getDir _x;
										_sDam = damage _x;
										_sCargo = [];

										_data = [_isMan,_type,_sPos,_sDir,_sDam,_x getVariable ["RYD_JR_Stopped",false],_x getVariable ["RYD_JR_Watched",[]],unitPos _x,_x getVariable ["RYD_JR_Sitting",false],_sCargo,_driverOut,_x getVariable ["RYD_JR_MyRemovedGear",[]]];											
										_gpData pushBack _data;

										deleteVehicle _x;	
										}
									foreach _sub;

										{
										_asV = _x select 0;
										_driverOut = false;
										
										if not ((assignedDriver _asV) in _asV) then
											{
											_driverOut = true
											};
										
										_isMan = [];
										
											{
											_isMan set [(count _isMan),[typeOf _x,damage _x,_x getVariable ["RYD_JR_MyRemovedGear",[]]]];
											deleteVehicle _x
											}
										foreach (_x select 1);
										
											{
											_isMan pushBack _x;
											deleteVehicle (_x select 13)
											}
										foreach (_x select 2);										
										
										_type = typeOf _asV;
										_sPos = getPosATL _asV;
										_sDir = getDir _asV;
										_sDam = damage _asV;
										
										_sCargo = [getWeaponCargo _asV,getMagazineCargo _asV,getItemCargo _asV];
											
										_data = [_isMan,_type,_sPos,_sDir,_sDam,_asV getVariable ["RYD_JR_Stopped",false],_asV getVariable ["RYD_JR_Watched",[]],unitPos _asV,_asV getVariable ["RYD_JR_Sitting",false],_sCargo,_driverOut,[]];											
										_gpData pushBack _data;
										deleteVehicle _asV
										}
									foreach _vehs;
																		
									_x setVariable ["RYD_JR_GroupData",_gpData];
									};
									
								case (2) :
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
									foreach (units _x);
									};
								};
							
							if (RYD_JR_Debug) then
								{
								_mk setMarkerColor "ColorRed";
								};
							
							RYD_JR_cached pushBack _x;
							}
						}
					};
					
				case (true) :
					{
					_cDst = _pos distance player;
					
					if not (isNull _uavC) then
						{
						_cDst = _cDst min (_pos distance _uavC)
						};
					
					if (_cDst < _rad) then
						{
						switch (RYD_JR_CachingMode) do
							{
							case (1) :
								{						
								_grp = _x;
								
									{
									_x enableSimulation true;
									_x hideObject false
									}
								foreach _ldrCrew;

								_ldr0 enableSimulation true;
								_ldr0 hideObject false;
								
								//_ldrCrewMen allowGetIn true;
								//_ldrCrewMen orderGetIn true;

									/*{
									_x moveInCargo _ldrV
									}
								foreach _assCL;*/
														
								_gpData = _grp getVariable ["RYD_JR_GroupData",[]];
								
									{
									_vh = objNull;
									_crw = _x select 0;
									_isMan = ((count _crw) == 0);
									
									switch (_isMan) do
										{
										case (true) :
											{
											_vh = _grp createUnit [(_x select 1),(_x select 2),[], 0, "NONE"];
											_aID = _vh addAction ["<t color='#d0a900'>Sell content</t>", RYD_JR_SellCargo, false, 1, false, true, "", "not (alive _target)"];

											_vh setPosATL (_x select 2);

											if (_x select 5) then
												{
												doStop _vh;
												_vh forceSpeed 0
												};	
												
											_vh setUnitPos (_x select 7);
											_vh setDir (_x select 3);
											
											_pos = _x select 6;
											
											if ((count _pos) < 2) then
												{
												_pos = [(_x select 2),(_x select 3),10] call RYD_JR_PosTowards2D;
												};
											
											_vh doWatch _pos;
											_vh setDamage (_x select 4);
											
												{
												_vh unlinkItem _x
												}
											foreach (_x select 11);
											};
																														
										case (false) :
											{
											_vh = createVehicle [(_x select 1),(_x select 2), [], 0, "NONE"];
											createVehicleCrew _vh;
											
												{
												_aID = _x addAction ["<t color='#d0a900'>Sell content</t>", RYD_JR_SellCargo, false, 1, false, true, "", "not (alive _target)"];
												}
											foreach (crew _vh);
											
											_drv = driver _vh;
											_gun = gunner _vh;
											_com = commander _vh;
											
											if (((_crw select 0) select 0) in [""]) then 
												{
												deleteVehicle _drv
												} 
											else 
												{
												_drv setDamage ((_crw select 0) select 1);
												
													{
													_drv unlinkItem _x
													}
												foreach ((_crw select 0) select 2)
												};
												
											if (((_crw select 1) select 0) in [""]) then 
												{
												deleteVehicle _gun
												} 
											else 
												{
												_gun setDamage ((_crw select 1) select 1);
												
													{
													_gun unlinkItem _x
													}
												foreach ((_crw select 1) select 2)
												};
												
											if (((_crw select 2) select 0) in [""]) then 
												{
												deleteVehicle _com
												} 
											else 
												{
												_com setDamage ((_crw select 2) select 1);
												
													{
													_com unlinkItem _x
													}
												foreach ((_crw select 2) select 2)
												};
											
											_pos = [(_x select 2),(_x select 3),50] call RYD_JR_PosTowards2D;
											_vh setDir (_x select 3);
											_vh setPos (_x select 2);
											_vh setDamage (_x select 4);
											
											if (_x select 5) then
												{
												doStop _vh;
												};
											
											[_gun] doWatch _pos;
											
											(crew _vh) joinSilent _grp;
											
											(crew _vh) orderGetIn true;
																						
											clearWeaponCargo _vh;
											clearMagazineCargo _vh;
											clearItemCargo _vh;
											
												{
												_stuff = _x select 0;
												_am = _x select 1;
												switch (_foreachIndex) do
													{
													case (0) : {_vh addWeaponCargo [_stuff,_am]};
													case (1) : {_vh addMagazineCargo [_stuff,_am]};
													case (2) : {_vh addItemCargo [_stuff,_am]}
													}
												}
											foreach (_x select 9);
											
											if (_x select 10) then {[(driver _vh)] orderGetIn false};
											
											for "_i" from 3 to ((count _crw) - 1) do
												{
												_assC = _crw select _i;
												_vhc = _grp createUnit [(_assC select 1),(_assC select 2),[], 0, "NONE"];
												_aID = _vhc addAction ["<t color='#d0a900'>Sell content</t>", RYD_JR_SellCargo, false, 1, false, true, "", "not (alive _target)"];

												_vhc setPosATL (_assC select 2);

												if (_assC select 5) then
													{
													doStop _vhc;
													_vhc forceSpeed 0
													};	
													
												_vhc setUnitPos (_assC select 7);
												_vhc setDir (_assC select 3);
												
												_pos = _assC select 6;
												
												if ((count _pos) < 2) then
													{
													_pos = [(_assC select 2),(_assC select 3),10] call RYD_JR_PosTowards2D;
													};
												
												_vhc doWatch _pos;
												_vhc setDamage (_assC select 4);
												
													{
													_vhc unlinkItem _x
													}
												foreach (_assC select 11);
												
												_vhc assignAsCargo _vh;
												
												[_vhc] allowGetIn true;
												[_vhc] orderGetIn true;
												
												if ((_assC select 12) or (true)) then
													{
													_vhc moveInCargo _vh
													}											
												}
											};
										};
																																					
									if (_x select 8) then
										{
										_vh switchAction "SitDown";
										}
									}
								foreach _gpData;
														
									{
									_ripmark = _x getVariable "RYD_JR_RIPmark";
									if (isNil "_ripmark") then 
										{
										_KilledEH = _x addEventHandler ["Killed", {nul = _this spawn KilledMark}];
										_x setVariable ["RYD_JR_RIPmark",_KilledEH];
										}
									}
								foreach (units _grp);
																
								_grp allowFleeing 0.1;
								};
								
							case (2) :
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
												_x enableSimulation true;
												_x hideObject false
												}
											foreach (crew _vh)
											};
										
										_vh enableSimulation true;
										_vh hideObject false
										}
									}
								foreach (units _x);
								};
							};
						
						_x setVariable ["RYD_JR_TS",time];
						
						if (RYD_JR_Debug) then
							{
							_mk setMarkerColor "ColorBlue";
							};
												
						RYD_JR_cached = RYD_JR_cached - [_x];
						}
					}
				}
			}
		foreach (RYD_JR_allEnemy - (RYD_JR_AllCaptives + RYD_JR_AllHelis));
		
		//diag_log "--4";
				
			{
			_ldr = leader _x;
			
			if ((player distance _ldr) < 300) then
				{
				_initC = _x getVariable ["RYD_JR_GroupCount",1];
				_actC = {alive _x} count (units _x);
				_fact = _actC/_initC;
				
				_mod = 1;
				
				_assVh = assignedVehicle _ldr;
				
				if not (isNull _assVh) then
					{
					if (canFire _assVh) then
						{
						_mags = magazines _assVh;
						if ((count (_mags - _flareMags)) > 0) then
							{
							_mod = 0.5
							}
						}
					};
					
				_assVh = assignedVehicle RYD_JR_Alex;
				
				if not (isNull _assVh) then
					{
					if (canFire _assVh) then
						{
						_mags = magazines _assVh;
						if ((count (_mags - _flareMags)) > 0) then
							{
							_mod = _mod * 1.25
							}
						}
					};
				
				if (_fact < 0.51) then
					{
					if ((_fact) < (random (0.6 * _mod))) then
						{
						RYD_JR_AllCaptives pushBack _x
						}
					else
						{
						_x setVariable ["RYD_JR_GroupCount",({alive _x} count (units _x))];
						}
					}
				}
			}
		foreach (RYD_JR_AllEnemy - RYD_JR_cached);
		
		RYD_JR_AllEnemy = RYD_JR_AllEnemy - RYD_JR_AllCaptives;
		
			{
			switch (true) do
				{
				case (isNil {_x}) : {RYD_JR_AllCaptives set [_foreachIndex,0]};
				case ((typeName _x) in [(typeName "")]) : {RYD_JR_AllCaptives set [_foreachIndex,0]};
				case (isNull _x) : {RYD_JR_AllCaptives set [_foreachIndex,0]};
				case (({alive _x} count (units _x)) < 1) : {deleteGroup _x;RYD_JR_AllCaptives set [_foreachIndex,0]};
				}
			}
		foreach RYD_JR_AllCaptives;
		
		RYD_JR_AllCaptives = RYD_JR_AllCaptives - [0];
				
			{
			_surr = _x getVariable ["RYD_JR_Surrendered",false];
			
			if not (_surr) then
				{
				[_x] call RYD_JR_Surrender;
				};
				
			if ((player distance (leader _x)) > 2000) then
				{
					{
					if (alive _x) then
						{
						deleteVehicle _x
						}
					}
				foreach (units _x);
				
				deletegroup _x;
				
				RYD_JR_AllCaptives set [_foreachIndex,0]
				}
			}
		foreach RYD_JR_AllCaptives;
		
		RYD_JR_AllCaptives = RYD_JR_AllCaptives - [0];
		
		//diag_log "--5";
		
			{
			switch (true) do
				{
				case (isNil {_x}) : {RYD_JR_Boats set [_foreachIndex,0]};
				case (isNull _x) : {RYD_JR_Boats set [_foreachIndex,0]};
				case not (alive _x) : {RYD_JR_Boats set [_foreachIndex,0]};
				}
			}
		foreach RYD_JR_Boats;
		
		RYD_JR_Boats = RYD_JR_Boats - [0];
		
			{
			switch (true) do
				{
				case (isNil {_x}) : {RYD_JR_AllEV set [_foreachIndex,0]};
				case (isNull _x) : {RYD_JR_AllEV set [_foreachIndex,0]};
				case not (alive _x) : {RYD_JR_AllEV set [_foreachIndex,0]};
				}
			}
		foreach RYD_JR_AllEV;
		
		RYD_JR_AllEV = RYD_JR_AllEV - [0];
		
		_ass = [];
		
			{
			_ass set [(count _ass),assignedVehicle _x];
			}
		foreach (units (group player));
			
			{
			switch (true) do
				{
				case (isNil {_x}) : {RYD_JR_EmptyVehs set [_foreachIndex,1]};
				case (isNull _x) : {RYD_JR_EmptyVehs set [_foreachIndex,1]};
				case not (alive _x) : {RYD_JR_EmptyVehs = RYD_JR_EmptyVehs - [_x]};
				case ((player knowsAbout _x) == 0) : {RYD_JR_EmptyVehs = RYD_JR_EmptyVehs - [_x]};
				case ((_x distance player) < 20) : {RYD_JR_EmptyVehs = RYD_JR_EmptyVehs - [_x]};
				case (_x in _ass) : {RYD_JR_EmptyVehs = RYD_JR_EmptyVehs - [_x]};
				}			
			}
		foreach RYD_JR_EmptyVehs;
		
		RYD_JR_EmptyVehs = RYD_JR_EmptyVehs - [1];
					
			{
			if not (_x in RYD_JR_EmptyVehs) then
				{
				if ((player knowsAbout _x) > 0) then
					{
					if ((_x distance player) > 20) then
						{
						if not (_x in _ass) then
							{
							RYD_JR_EmptyVehs pushBack _x
							}
						}
					}
				}
			}
		foreach RYD_JR_AllEV;
		
		_pgVehs = [RYD_JR_Brother];
		
			{
			_vh = assignedVehicle _x;
			
			if not (isNull _vh) then
				{
				if not (_vh in _pgVehs) then
					{
					_pgVehs pushBack _vh
					}
				}
			
			}
		foreach (units (group player));
		
		_toCache = (AllDead + RYD_JR_AllHolders + RYD_JR_AllStuff + (RYD_JR_AllEV - (RYD_JR_EmptyVehs + _pgVehs)));
	
			{
			_pos = getPosATL _x;
			
			_rad = 2000;
			
			switch (true) do
				{
				case (_x in RYD_JR_AllStuff) : {_rad = 1500};
				case (_x in RYD_JR_AllHolders) : {_rad = 500};
				};
			
			switch (_x in RYD_JR_cached) do
				{
				case (false) :
					{
					_timeStamp = _x getVariable ["RYD_JR_TS",-115];
					
					if ((time - _timeStamp) > 120) then
						{
						_cDst = _pos distance player;
						
						if not (isNull _uavC) then
							{
							_cDst = _cDst min (_pos distance _uavC)
							};
						
						if (_cDst > _rad) then
							{
							_x enableSimulation false;
							_x hideObject true;

							RYD_JR_cached pushBack _x;
							}
						}
					};
					
				case (true) :
					{
					_cDst = _pos distance player;
					
					if not (isNull _uavC) then
						{
						_cDst = _cDst min (_pos distance _uavC)
						};
					
					if (_cDst < _rad) then
						{
						_x enableSimulation true;
						_x hideObject false;
						
						_x setVariable ["RYD_JR_TS",time];
						
						RYD_JR_cached = RYD_JR_cached - [_x];
						}
					}
				}
			}
		foreach _toCache;
		
		//diag_log "--6";
		
		//diag_log format ["%2 cached %1 ",time,count RYD_JR_cached];

		if not (RYD_JR_AISpotted) then
			{
			if ((player distance RYD_JR_AI) < 600) then
				{
				_isLOS = (player knowsAbout RYD_JR_AI) > 2;
				if not (_isLOS) then
					{
					_isLOS = [getPosASL player,getPosASL RYD_JR_AI,1,1,player,RYD_JR_AI] call RYD_JR_LOSCheck
					};
					
				if (_isLOS) then
					{
					_text = "Fuck! So this is true. It is active.";
					
					if not (alive RYD_JR_AI) then
						{
						_text = "Fuck! So this was true. Although it is scrap already...";
						};
					
					RYD_JR_AISpotted = true;
					TitleText [_text,"PLAIN DOWN", 1];
					}
				}
			};
		
		if not (has_body) then
			{
			if ((player distance RYD_JR_Brother) < 50) then
				{
				_isLOS = [getPosASL player,getPosASL RYD_JR_Brother,1.5,1.5,player,RYD_JR_Brother] call RYD_JR_LOSCheck;
				
				if (_isLOS) then
					{
					saveGame;
					
					has_body = true;
					RYD_JR_LastChat = time;
					TitleText ["Shit! That is him! Now I must load the body into a vehicle and drive back to my boat...","PLAIN DOWN", 1];
					
					if not (RYD_JR_NoMarkers) then
						{
						(RYD_JR_holyP select 1) setMarkerColor "ColorGreen";
						(RYD_JR_holyP select 1) setMarkerType "hd_objective";
						(RYD_JR_holyP select 1) setMarkerAlpha 1;
						};
						
					RYD_JR_Brother setVariable ["RYD_JR_Captive",true];
					RYD_JR_NearCivs pushBack RYD_JR_Brother;
					
					RYD_JR_isPlaying = true;
					
					RYD_JR_mHandle = ["EventTrack01_F_EPA",29] spawn
						{
						terminate RYD_JR_mHandle;
						
						1 fadeMusic 0;
						
						sleep 1.5;
						
						playMusic (_this select 0);
						
						3 fadeMusic 0.4;
						
						sleep (_this select 1);
				
						RYD_JR_isPlaying = false;
						RYD_JR_LastPlay = time
						}
					}
				};
				
			if not (has_body) then
				{
							
					{
					if ((count _x) == 2) then
						{
						if ((player distance (_x select 0)) < 30) then
							{
							_x set [2,true];
							
							[(_x select 1)] spawn
								{
								
								_mark = _this select 0;
								
								sleep 10;
								
								saveGame;
								
								sleep (random 10);
								
								if not (RYD_JR_NoMarkers) then
									{									
									_mark setMarkerColor "ColorRed";
									_mark setMarkerType "hd_objective";
									_mark setMarkerAlpha 1;
									};
								
								_text = format ["No, he is not here. I still have %1 places to check though...",({((count _x) == 2)} count RYD_JR_allHolyPlaces) + 1];
								TitleText [_text,"PLAIN DOWN", 3];
								}
							}
						}
					}
				foreach RYD_JR_allHolyPlaces;
				};
			};
			
		RYD_JR_inStealth = not (isNull (player findNearestEnemy player));
		
		//diag_log "--7";

		if not (RYD_JR_isPlaying) then
			{
			_waiting = 300 + (random 450) + (random 450) + (random 450) + (random 450);
			if (((RYD_JR_inStealth) and ((random 100) > 50)) or ((RYD_JR_inCombat) and ((random 100) > 25))) then
				{
				_waiting = _waiting/3
				};
			
			if ((time - RYD_JR_LastPlay) < _waiting) exitWith {};
			RYD_JR_isPlaying = true;

			if ((count RYD_JR_safeTracksC) == 0) then {RYD_JR_safeTracksC = +RYD_JR_safeTracks};
			if ((count RYD_JR_stealthTracksC) == 0) then {RYD_JR_stealthTracksC = +RYD_JR_stealthTracks};
			if ((count RYD_JR_combatTracksC) == 0) then {RYD_JR_combatTracksC = +RYD_JR_combatTracks};
			
			_track = [];
			
			switch (true) do
				{
				case (RYD_JR_inCombat) : 
					{
					_ix = floor (random (count RYD_JR_combatTracksC));
					_track = RYD_JR_combatTracksC select _ix;
					RYD_JR_combatTracksC set [_ix,0];
					RYD_JR_combatTracksC = RYD_JR_combatTracksC - [0]
					};
					
				case (RYD_JR_inStealth) : 
					{
					_ix = floor (random (count RYD_JR_stealthTracksC));
					_track = RYD_JR_stealthTracksC select _ix;
					RYD_JR_stealthTracksC set [_ix,0];
					RYD_JR_stealthTracksC = RYD_JR_stealthTracksC - [0]
					};
					
				default 
					{
					_ix = floor (random (count RYD_JR_safeTracksC));
					_track = RYD_JR_safeTracksC select _ix;
					RYD_JR_safeTracksC set [_ix,0];
					RYD_JR_safeTracksC = RYD_JR_safeTracksC - [0]
					};
				};
							
			RYD_JR_mHandle = +_track spawn
				{
				0 fadeMusic 0;
				3 fadeMusic 0.4;
								
				sleep 0.5; 
				
				if (_this in [0]) exitWith {RYD_JR_isPlaying = false;RYD_JR_LastPlay = 0};
								
				playMusic (_this select 0);
				
				sleep (_this select 1);
				
				RYD_JR_isPlaying = false;
				RYD_JR_LastPlay = time
				}
			};
					
			{
			switch (true) do
				{
				case (isNil {_x}) : {RYD_JR_AllLootHouses set [_foreachIndex,0]};
				case (isNil {_x select 0}) : {RYD_JR_AllLootHouses set [_foreachIndex,0]};
				case (isNull (_x select 0)) : {RYD_JR_AllLootHouses set [_foreachIndex,0]};
				}
			}
		foreach RYD_JR_AllLootHouses;
		
		RYD_JR_AllLootHouses = RYD_JR_AllLootHouses - [0];
		
		//diag_log "--8";
				
			{
			_hs = _x select 0;
			_hs setVariable ["RYD_JR_MyLoot",_x select 1];
			if not (_hs in RYD_JR_LootHouses) then
				{
				if not (_hs getVariable ["RYD_JR_Checked",false]) then
					{
					_dst = player distance _hs;
					if (_dst < 100) then
						{
						RYD_JR_LootHouses pushBack _hs
						}
					}
				}
			}
		foreach RYD_JR_AllLootHouses;
		
			{
			_hs = _x;
			if not ((player distance _hs) < 100) then
				{
				RYD_JR_LootHouses set [_foreachIndex,1];
				}
			else
				{
				if (_hs getVariable ["RYD_JR_Checked",false]) then
					{
					RYD_JR_LootHouses set [_foreachIndex,1]
					}
				else
					{
					_empty = true;
					
					_hlds = _hs getVariable ["RYD_JR_MyLoot",[]];
					
						{
						if (_x getVariable ["RYD_JR_RemoveItem",false]) exitWith {_empty = false};
						_mg = count ((getMagazineCargo _x) select 1);
						if (_mg > 0) exitWith {_empty = false};
						_wp = count ((getWeaponCargo _x) select 1);
						if (_wp > 0) exitWith {_empty = false};
						_ip = count ((getItemCargo _x) select 1);
						if (_ip > 0) exitWith {_empty = false};
						//if not (_empty) exitWith {}
						}
					foreach _hlds;
					
					if (_empty) then
						{
						RYD_JR_LootHouses set [_foreachIndex,1];
						}
					}
				}
			}
		foreach RYD_JR_LootHouses;
		
		RYD_JR_LootHouses = RYD_JR_LootHouses - [1];
		//RYD_AS_Pause = false;
		//diag_log "--9";
		
		if (alive RYD_JR_AI) then
			{
			if not (RYD_JR_noAI) then
				{
				if (RYD_AS_Pause) then
					{
					if ((player distance RYD_JR_AI) < 600) then
						{					
						[(group RYD_JR_AI)] call RYD_JR_WPdel;
						RYD_JR_AI doMove (position RYD_JR_AI);
						doStop RYD_JR_AI;
			
						if (RYD_JR_UGVHacked) then
							{
							RYD_AS_Targets = [];
							_pot = (position RYD_JR_AI) nearEntities ["CAManBase",1000];
							
								{
								if ((side _x) in [east,resistance]) then
									{
									RYD_AS_Targets pushBack _x
									}
								}
							foreach _pot;
							}
						else
							{
							RYD_AS_Targets = (position RYD_JR_AI) nearEntities ["CAManBase",1000];
							};
							
						//RYD_AS_Targets = RYD_AS_Targets - [player];
						
						if not (RYD_JR_AIRogued) then
							{
							RYD_JR_AIRogued = true;
							RYD_JR_AI addRating -100000;
							RYD_JR_AI setCaptive false;
							};
							
						RYD_AS_Pause = false;
						}
					}
				else
					{
					_add = [];
					_pot = (position RYD_JR_AI) nearEntities ["CAManBase",600];
					
					if (RYD_JR_UGVHacked) then
						{
						RYD_AS_Targets = [];
						
							{
							if ((side _x) in [east,resistance]) then
								{
								_add pushBack _x
								}
							}
						foreach _pot
						}
					else
						{
						_add = _pot
						};
					
					RYD_AS_Targets = (RYD_AS_Targets - _add) + _add;

					//RYD_AS_Targets = RYD_AS_Targets - [player];
					_tgts = [];
					
						{
						if (simulationEnabled _x) then
							{
							_tgts pushBack _x
							}
						}
					foreach RYD_AS_Targets;
					
					RYD_AS_Targets = _tgts;

					if (({alive _x} count RYD_AS_Targets) < 1) exitWith 
						{
						RYD_AS_Pause = true;
						RYD_AS_Targets = [];

						RYD_JR_AI doMove (position RYD_JR_AI);
						[(group RYD_JR_AI),(position RYD_JR_AI),"MOVE","STEALTH","BLUE","LIMITED","WEDGE",["true",""],true,50,1000,5,3,2,true] call RYD_JR_SADPatrol;
						};
					 
					_tgt = [RYD_JR_AI,RYD_AS_Targets] call RYD_JR_FindClosest;
					
					_dst = _tgt distance RYD_JR_AI;

					if (_dst > 1000) exitWith 
						{
						RYD_AS_Pause = true;
						RYD_AS_Targets = [];
						RYD_JR_AI doMove (position RYD_JR_AI);
						[(group RYD_JR_AI),(position RYD_JR_AI),"MOVE","STEALTH","BLUE","LIMITED","WEDGE",["true",""],true,50,1000,5,3,2,true] call RYD_JR_SADPatrol;				
						};
						
					if ((RYD_JR_AI distance _tgt) > 100) then
						{
						_lt = RYD_JR_AI getVariable ["RYD_JR_LT",objNull];
						if (((abs (speed RYD_JR_AI)) < 1) or not (_tgt == _lt)) then
							{
							RYD_JR_AI doMove (position _tgt);
							RYD_JR_AI setVariable ["RYD_JR_LT",_lt]
							}
						}
					else
						{
						_isLOS = [getPosASL RYD_JR_AI,getPosASL _tgt,1,1,RYD_JR_AI,(vehicle _tgt)] call RYD_JR_LOSCheck;
						
						if not (_isLOS) then
							{
							_lt = RYD_JR_AI getVariable ["RYD_JR_LT",objNull];
							if (((abs (speed RYD_JR_AI)) < 1) or not (_tgt == _lt)) then
								{
								RYD_JR_AI doMove (position _tgt);
								RYD_JR_AI setVariable ["RYD_JR_LT",_lt]
								}
							};					
						//RYD_JR_AI doMove (position RYD_JR_AI)
						}
					}
				}
			else
				{
				if not (RYD_JR_stopAI) then
					{
					RYD_JR_AI setCaptive false;
					[(group RYD_JR_AI)] call RYD_JR_WPdel;
					RYD_JR_AI doMove (position RYD_JR_AI);
					doStop RYD_JR_AI;
					RYD_JR_stopAI = true
					};
				}
			};
			
		//diag_log "--10";
		
		_assI = assignedItems player;
		
		if ("ItemRadio" in _assI) then
			{
			if (((count RYD_JR_Conversations) > 0) and not ((has_body) or not (RYD_JR_Phone))) then
				{
				if ((time - RYD_JR_LastTalk) > (1200 + (random 600) + (random 600) + (random 600) + (random 600))) then
					{
					if ((not ((RYD_JR_inStealth) or (RYD_JR_isResting)) or not (RYD_JR_callRejected)) and not (RYD_JR_callPending)) then
						{
						if ((time - RYD_JR_LastComm) < 10) exitWith {};
						
						RYD_JR_LastComm = time;
						RYD_JR_LastTalk = time;
						RYD_JR_LastChat = time;
						_callNo = _callNo + 1;
						_ix = floor (random (count RYD_JR_Conversations));
						_conversation = RYD_JR_Conversations select _ix;
						RYD_JR_callPending = true;
						_tme = 15 + (random 15);
						_caller = _conversation select 2;
						
						RYD_JR_cHandle = [_tme,_caller] spawn RYD_JR_CellRing;
						
						if not (RYD_JR_inStealth) then
							{
							_convArr = _conversation select 0;
							_official = _conversation select 1;
							RYD_JR_Conversations set [_ix,0];
							RYD_JR_Conversations = RYD_JR_Conversations - [0];
							
							[_convArr,_official,_caller] spawn
								{
								_conv = _this select 0;
								_official = _this select 1;
								_caller = _this select 2;
								
								_snt = 1;
								
								_greetArr = RYD_JR_CInitTalk;
								if (_official) then
									{
									_greetArr = RYD_JR_CInitTalkOff
									};
									
								_greet = _greetArr select (floor (random (count _greetArr)));
								
								sleep (2 + (random 15));
									
								terminate RYD_JR_cHandle;
								
								sleep (1 + (random 2));
								
								["short",0.2] spawn RYD_JR_Sound3D;
									
								sleep 0.02;
								
								RYD_JR_Caller customChat [RYD_JR_Conv,_greet];
									
								_transcr = _greet;
									
								_transcr = _transcr + "<br />";
								
								_snt = _snt + 1;
								
								sleep (1 + (random 1));
									
									{
									_sent = _x;
									_addP = false;
									_sntC = false;
									
									if ((typeName _sent) == (typeName [])) then
										{
										_sent = _sent select 0;
										
										_sntC = true;
										
										_addP = true
										};
									
									_pause = (count (toArray _sent))/8;
																									
									if ((RYD_JR_inStealth) or (RYD_JR_isResting)) then
										{
										_setBack = false;
										_interrupt = RYD_JR_Interrupts select (floor (random (count RYD_JR_Interrupts)));
										
										RYD_JR_Caller customChat [RYD_JR_Conv,_interrupt];
										
										if ((_snt/2) == (floor (_snt/2))) then
											{
											_setBack = true;
											_snt = _snt + 1
											};
										
										_transcr = _transcr + _interrupt;
																				
										_transcr = _transcr + "<br />";
										
										waitUntil
											{
											sleep 10;
											
											not (RYD_JR_inStealth)
											};
											
										["short",0.2] spawn RYD_JR_Sound3D;
									
										sleep 0.02;
										
										_sent2 = "Alex: OK. I can talk again.";
											
										RYD_JR_Caller customChat [RYD_JR_Conv,_sent2];
											
										_transcr = _transcr + _sent2;	
											
										_transcr = _transcr + "<br />";
										
										if (_setBack) then
											{
											_snt = _snt + 1
											};
										
										sleep (5 + (random 5))
										};
										
									sleep (_pause + (random (_pause/10)));
									
									["short",0.2] spawn RYD_JR_Sound3D;
									
									sleep 0.02;
																							
									RYD_JR_Caller customChat [RYD_JR_RadioPhone,_sent];
									
									if ((_snt/2) == (floor (_snt/2))) then
										{
										_sent = "<font color='#C0C0C0'>" + _sent + "</font>";
										};
										
									if (_sntC) then
										{
										_snt = _snt + 1
										};
										
									_transcr = _transcr + _sent;
										
									_transcr = _transcr + "<br />";							
									
									if (_addP) then
										{
										sleep (_pause/2);
										}
									else
										{
										sleep (0.1 + (random 1))
										}
									}
								foreach _conv;
								
								sleep (3 + (random 2));
								
								["endTalk",1.25] spawn RYD_JR_Sound3D;
								
								RYD_JR_callPending = false;
								
								RYD_JR_CallNo = RYD_JR_CallNo + 1;
								
								_title = format ["Conversation #%1 (%2)",RYD_JR_CallNo,_caller];
								
								_transcr = format [_transcr];
								player createDiaryRecord ["phoneC", [_title,_transcr]];
								}				
							}
						else
							{
							RYD_JR_callRejected = true;
							[] spawn
								{
								sleep (1 + (random 1));
								
								_com = RYD_JR_Complaints select (floor (random (count RYD_JR_Complaints)));
								
								TitleText [_com,"PLAIN DOWN", 1];
								
								sleep (1 + (random 4));
								
								RYD_JR_RingO say3D "break";
									
								sleep 0.5;

								detach RYD_JR_SoundO;
								deleteVehicle RYD_JR_RingO;

								terminate RYD_JR_cHandle;
								
								RYD_JR_Caller customChat [RYD_JR_RadioPhone,"CALL REJECTED"];
								
								sleep (1 + (random 1));
								
								TitleText ["","PLAIN DOWN", 0];
								
								RYD_JR_callPending = false
								}
							};
						};
					};
					
				if not (RYD_JR_inStealth) then
					{
					RYD_JR_callRejected = false
					};
				};
			};
				
		//diag_log "--11";
		
		if (RYD_JR_ADM) then
			{
			if (_maincycle > 2) then
				{
				if ("ItemMap" in _assI) then
					{
					if ("ItemRadio" in _assI) then
						{
						if not (RYD_JR_EnData) then
							{	
							_allE = count RYD_JR_allEnemy;
							
							if (_allE < 1) exitWith {};
							
							_locE = RYD_JR_LocatedGroupsN;
							
							_chance = ((_allE - _locE)/_allE)/2;
							
							if (((random 100) < _chance) and {(time - RYD_JR_LastComm) > 10}) then
								{
								_enTStamp = time;
								RYD_JR_EnData = true;
								
								[] spawn
									{
									RYD_JR_LastComm = time;
									
									["sonar",3] spawn RYD_JR_Sound3D;
									
									sleep 0.02;
									
									RYD_JR_Caller customChat [RYD_JR_RadioADMn,"Item 'Recent hostile presence location on Altis (unknown, acc. 500m)' available for 600 ff. About 60 seconds left."];
									}
								}
							}
						else
							{
							if (((time - _enTStamp) > 60) and {(time - RYD_JR_LastComm) > 10}) then 
								{
								if ((random 100) > 50) then {RYD_JR_LocatedGroupsN = RYD_JR_LocatedGroupsN + 1};
								RYD_JR_EnData = false;
								[] spawn
									{
									RYD_JR_LastComm = time;
									
									["sonar",3] spawn RYD_JR_Sound3D;
									
									sleep 0.02;
									
									RYD_JR_Caller customChat [RYD_JR_RadioADMn,"Item 'Recent hostile presence location on Altis (unknown, acc. 500m)' is no longer available."];
									}
								};
							};
					
						if not (RYD_JR_VehData) then
							{
							_allV = count RYD_JR_AllEV;
							
							if (_allV < 1) exitWith {};
							
							_locV = RYD_JR_LocatedVehsN;
							
							_chance = ((_allV - _locV)/_allV)/2;
							
							if (((random 100) < _chance) and {(time - RYD_JR_LastComm) > 10}) then
								{
								_vTStamp = time;
								RYD_JR_VehData = true;
								
								[] spawn 
									{
									RYD_JR_LastComm = time;
									
									["sonar",3] spawn RYD_JR_Sound3D;
									
									sleep 0.02;
									
									RYD_JR_Caller customChat [RYD_JR_RadioADMn,"Item 'Abandoned vehicle: location on Altis (unknown, acc. 100m)' available for 1200 ff. About 60 seconds left."];
									}
								}
							}
						else
							{
							if (((time - _vTStamp) > 60) and {(time - RYD_JR_LastComm) > 10}) then 
								{
								if ((random 100) > 50) then {RYD_JR_LocatedVehsN = RYD_JR_LocatedVehsN + 1};
								RYD_JR_VehData = false;
								[] spawn 
									{
									RYD_JR_LastComm = time;
									
									["sonar",3] spawn RYD_JR_Sound3D;
									
									sleep 0.02;
									
									RYD_JR_Caller customChat [RYD_JR_RadioADMn,"Item 'Abandoned vehicle: location on Altis (unknown, acc. 100m)' is no longer available."];
									}
								};
							};
						};
					};
				};
			};
			
		//diag_log "--12";
		
		if not (true in [RYD_JR_inStealth]) then
			{
			_hint = "";
			_hint2 = "";
			_pPos = getPosATL player;
			if ((time - _campNot) > 600) then
				{
				_clCamp = [_pPos,RYD_JR_Camps - RYD_JR_Base] call RYD_JR_FindClosest;
				_dst = _clCamp distance _pPos;

				if (_dst > 50) then
					{
					if (_dst < 500) then
						{
						if ((random 1) < (50/_dst)) then
							{
							_campNot = time;
							_dir = [_pPos,getPosATL _clCamp,20] call RYD_JR_AngTowards;
							if (_dir < 0) then {_dir = _dir + 360};
							_dirN = [_dir] call RYD_JR_WindRose;

							_hint = "You sense the smell of smoke coming from the " + _dirN + "... "
							}
						}
					}
				};
				
			if ((time - _enemyNot) > 600) then
				{
				_clEnemy = [_pPos,RYD_JR_allEnemy] call RYD_JR_FindClosest;
				_dst = (vehicle (leader _clEnemy)) distance _pPos;

				if (_dst > 100) then
					{
					if (_dst < 1000) then
						{
						if ((random 1) < (100/_dst)) then
							{
							_enemyNot = time;
							_dir = [_pPos,getPosATL (vehicle (leader _clEnemy)),20] call RYD_JR_AngTowards;
							if (_dir < 0) then {_dir = _dir + 360};
							_dirN = [_dir] call RYD_JR_WindRose;

							if (_clEnemy in RYD_JR_AllMobile) then
								{
								if ((_dst < 500) and ((random 100) < 50)) then
									{
									_hint2 = "You just heard an engine sound coming from the " + _dirN + "..."
									}
								else
									{
									_hint2 = "You see tracks from a vehicle heading somewhere towards the " + _dirN + "..."
									}
								}
							else
								{
								_common = "You see a foot trail leading somewhere towards the %1, ";
								_cnt = count (units _clEnemy);
								_cntMin = (round (_cnt/1.5));
								_cntMin = _cntMin + (round (random (_cnt - _cntMin)));
								_cntMax = round (_cnt * 1.5);
								_cntMax = _cntMax - (round (random (_cntMax - _cnt)));
								
								if (_cntMax < 1) exitWith {};
								
								_mn = "probably %2 to %3 men...";
								
								if ((_cntMin >= _cntMax) or (_cntMin <= 0)) then
									{
									if (_cntMax > 1) then
										{
										_mn = "probably up to %3 men..."
										}
									else
										{
										_mn = "probably one man..."
										}
									};
									
								_hint2 = format [(_common + _mn),_dirN,_cntMin,_cntMax];
								};							
							}
						}
					}
				};
				
			_hint = _hint + _hint2;

			if not (_hint in [""]) then
				{
				[_hint] spawn
					{
					_hint = _this select 0;
					
					TitleText [_hint,"PLAIN",3];
					
					sleep 10;
					
					TitleText ["","PLAIN",0];
					}
				}	
			};
						
			{
			_alive = true;
			
			switch (true) do
				{
				case (isNil {_x}) : {RYD_JR_BusyPatrols set [_foreachIndex,0];_alive = false};
				case (isNull _x) : {RYD_JR_BusyPatrols set [_foreachIndex,0];_alive = false};
				case (({alive _x} count (units _x)) < 1) : {deleteGroup _x;RYD_JR_BusyPatrols set [_foreachIndex,0];_alive = false};
				};
				
			if not (_alive) then {RYD_JR_PatrolCalled = false}		
			}
		foreach RYD_JR_BusyPatrols;
		
		RYD_JR_BusyPatrols = RYD_JR_BusyPatrols - [0];
		
		//diag_log "--13";
		
		if ("ItemRadio" in _assI) then
			{
			if (true) then
				{
				_enemy = RYD_JR_allEnemy - RYD_JR_AllCaptives;
				_close = [];
				_calm = [];
				
					{
					_ldr = leader _x;
					_en = _ldr findNearestEnemy _ldr;
					
					if (((_ldr distance player) <  1500) and {(side _ldr) in RYD_JR_Freq}) then
						{
						if not (isNull _en) then
							{
							_lc = _x getVariable ["RYD_JR_MyLastCloseChat",-600];
							if ((time - _lc) > 600) then
								{
								_re = _x getVariable ["RYD_JR_MyReportedEnemies",[]];
								
								if not (_en in _re) then
									{
									_x setVariable ["RYD_JR_MyLastCloseChat",time];
									_re pushBack _en;
									_x setVariable ["RYD_JR_MyReportedEnemies",_re];
									_close pushBack [_ldr,_ldr getHideFrom _en,vehicle _en]
									}
								}
							}
						else
							{
							_lc = _x getVariable ["RYD_JR_MyLastCalmChat",-600];
							_la = _x getVariable ["RYD_JR_MyLastAlarmChat",-600];
							if (((time - _lc) > 600) and {(time - _la) > 600}) then
								{
								if ((random 100) < 25) then
									{
									_x setVariable ["RYD_JR_MyLastCalmChat",time];
									_calm pushBack _ldr
									}
								}
							}
						}
					}
				foreach _enemy;
				
				if ((count _close) > 0) then
					{					
					_lastChat = time - 30;
					
					_caller = _close select (floor (random (count _close)));
					_who = _caller select 2;
					_where = _caller select 1;
					_caller = _caller select 0;
					
					(group _caller) setVariable ["RYD_JR_MyLastAlarmChat",time];
					
					_sent = RYD_JR_AlexCompromised select (floor (random (count RYD_JR_AlexCompromised)));
					
					_name = "presence";
					
					if not (_who isKindOf "Man") then
						{
						_dn = configFile >> "CfgVehicles" >> (typeOf _who) >> "displayName";
						if (isText _dn) then
							{
							_name = getText _dn
							}
						};
					
					_loc = "";
					_locs = nearestLocations [_where, ["NameCityCapital","NameCity","NameVillage","NameLocal","Hill"], 1000];
					if ((count _locs) > 0) then
						{
						_loc = _locs select 0
						};
					
					if not (_loc isEqualTo "") then
						{
						_loc = text _loc;
						if (_loc isEqualTo "") then
							{
							_loc = mapGridPosition _where
							}
						}
					else
						{
						_loc = mapGridPosition _where
						};

					_sent = "CONTACT! This is " + (name _caller) + ". Hostile " + _name + " detected at "  + _loc + ". " + _sent + " Over.";
					
					[_sent,_caller] spawn
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
								case (RYD_JR_Outro) : {_alive = false};
								};
							
							(not (_alive) or {((time - RYD_JR_LastComm) > 6)})
							};				
						
						if not (_alive) exitWith {};
						
						RYD_JR_LastComm = time;						
						
						["static1",2.5] spawn RYD_JR_Sound3D;
						sleep 0.02;	
						RYD_JR_Caller customChat [RYD_JR_RadioAlarm,_sent]
						}
					}
				else
					{
					if ((count _calm) > 0) then
						{
						if ((random (time - _lastChat)) > ((random 30) + (random 30) + (random 30) + (random 30))) then
							{
							_lastChat = time;
							
							_caller = _calm select (floor (random (count _calm)));
							_sent = RYD_JR_CalmChat select (floor (random (count RYD_JR_CalmChat)));
							
							_sent = (name _caller) + " reporting. " + _sent + " Out.";

							[_sent,_caller] spawn
								{
								_sent = _this select 0;
								_caller = _this select 1;
								
								sleep (random 10);
								
								_alive = true;
								
								waitUntil
									{
									sleep (10 + (random 10));
									
									switch (true) do
										{
										case (isNil "_caller") : {_alive = false};
										case not ((typeName _caller) isEqualTo (typename objNull)) : {_alive = false};
										case (isNull _caller) : {_alive = false};
										case not (alive _caller) : {_alive = false};
										case (isNull (group _caller)) : {_alive = false};
										case (RYD_JR_Outro) : {_alive = false};
										};
									
									(not (_alive) or {((time - RYD_JR_LastComm) > 15)})
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
				}
			};
			
		if (RYD_JR_inCombat) then
			{
			if not (captive player) then
				{				
				if not (RYD_JR_PatrolCalled) then
					{
					_pPos = vehicle player;
					
					_caller = [_pPos,(RYD_JR_allEnemy - RYD_JR_AllCaptives)] call RYD_JR_FindClosest;
					
					_enemy = (RYD_JR_AllMobile - [_caller]);
									
					if (RYD_JR_ACIntense > 0) then
						{
						_enemy = switch (side _caller) do
							{
							case (east) : {(RYD_JR_AllMobileE - [_caller])};
							default {(RYD_JR_AllMobileI - [_caller])}
							}
						};
						
					_enemy = _enemy - RYD_JR_BusyPatrols;
					
					if ((count _enemy) < 1) exitWith {};			
							
					_patrol = [position player,_enemy] call RYD_JR_FindClosest;
					
					if (((vehicle (leader _patrol)) distance player) < 4000) then
						{
						RYD_JR_PatrolCalled = true;
												
						[_patrol,[position player,10,200] call RYD_JR_RandomAroundMM,_caller] spawn RYD_JR_Response;
						
						if (((side _caller) in RYD_JR_Freq) and {"ItemRadio" in (assignedItems player)}) then
							{
							_caller setVariable ["RYD_JR_MyLastAlarmChat",time];
																		
							_caller = leader _caller;
							
							_where = mapGridPosition _caller;
							
							_en = _caller findNearestEnemy _caller;
							
							if not (isNull _en) then
								{
								_where = _caller getHideFrom _en;
								_where = mapGridPosition _where
								};
							
							_sent = (name _caller) + " reporting a direct threat. Requesting immediate support at " + _where + ". Over.";
													
							[_sent,_caller,_patrol] spawn
								{
								_sent = _this select 0;
								_caller = _this select 1;
								_patrol = _this select 2;
								
								sleep (random 10);
								
								_alive = true;
								
								waitUntil
									{
									sleep (2 + (random 2));
									
									switch (true) do
										{
										case (isNil "_caller") : {_alive = false};
										case not ((typeName _caller) isEqualTo (typename objNull)) : {_alive = false};
										case (isNull _caller) : {_alive = false};
										case not (alive _caller) : {_alive = false};
										case (isNull (group _caller)) : {_alive = false};
										case (RYD_JR_Outro) : {_alive = false};
										};
									
									(not (_alive) or {((time - RYD_JR_LastComm) > 8)})
									};				
								
								if not (_alive) exitWith {};
								
								RYD_JR_LastComm = time;
								
								["static1",2.5] spawn RYD_JR_Sound3D;
								sleep 0.02;													
								RYD_JR_Caller customChat [RYD_JR_RadioAlarm,_sent];
								
								_patrol setVariable ["RYD_JR_Called",true];
								}
							}
						}
					};
					
				if (RYD_JR_APRangeM > 0) then
					{
					_avHeli = [];
					
						{
						_alive = true;
						switch (true) do
							{
							case (isNil {_x}) : {RYD_JR_AllHelis set [_foreachIndex,0];_alive = false};
							case (isNull _x) : {RYD_JR_AllHelis set [_foreachIndex,0];_alive = false};
							case (({(alive _x)} count (units _x)) < 1) : {deleteGroup _x;RYD_JR_AllHelis set [_foreachIndex,0];_alive = false};
							};
									
						if (_alive) then
							{
							_mh = _x getVariable ["RYD_JR_MyHeli",objNull];
							
							switch (true) do
								{
								case (isNil {_mh}) : {RYD_JR_AllHelis set [_foreachIndex,0]};
								case (isNull _mh) : {RYD_JR_AllHelis set [_foreachIndex,0]};
								case not (alive _mh) : {RYD_JR_AllHelis set [_foreachIndex,0]};
								};
							}
						}
					foreach RYD_JR_AllHelis;
					
					RYD_JR_AllHelis = RYD_JR_AllHelis - [0];
						
						{
						_dst = (player distance (leader _x));
						if (((_x knowsAbout (vehicle player)) > 0) and (_dst < 1500)) then
							{
							if not (_x in RYD_JR_BusyHelis) then
								{
								_mh = _x getVariable ["RYD_JR_MyHeli",objNull];
								RYD_JR_BusyHelis pushBack _x;
								[_mh,[position (vehicle player),100] call RYD_JR_RandomAround,_x] call RYD_JR_AirResponse;
								}
							}
						else
							{
							_lc = _x getVariable ["RYD_JR_LastCall",-1800];
							if (((time - _lc) > (600 + (random 600) + (random 600))) or (_dst < 600)) then
								{
								_avHeli pushBack _x
								}
							}
						}
					foreach (RYD_JR_AllHelis - RYD_JR_BusyHelis);
					
					if ((count _avHeli) > 0) then
						{
						_pPos = vehicle player;
						_enemy = RYD_JR_allEnemy;
						
						if (RYD_JR_ACIntense > 0) then
							{
							
								{
								if not (_x in RYD_JR_allEnemy) then {RYD_JR_East set [_foreachIndex,0]}
								}
							foreach RYD_JR_East;
							
							RYD_JR_East = RYD_JR_East - [0];
							
							_enemy = RYD_JR_East
							};
						
						_caller = [_pPos,(_enemy - RYD_JR_AllCaptives)] call RYD_JR_FindClosest;
						
						if (isNull _caller) exitWith {};
												
						_called = _caller getVariable ["RYD_JR_myCall",false];
											
						if not (_called) then
							{
							_knA = _caller knowsAbout (vehicle player);

							if (_knA > 0) then
								{
								if not (_caller in RYD_JR_AllHelis) then
									{
									_caller setVariable ["RYD_JR_myCall",true];
									};
								
								_heli = [_pPos,_avHeli] call RYD_JR_FindClosest;
								_mh = _heli getVariable ["RYD_JR_MyHeli",objNull];
								
								_dst = (leader _caller) distance _mh;
								
								_maxD = 10500;
								
								switch (RYD_JR_APRangeM) do
									{
									case (1.2) : {_maxD = 6000};
									case (0.5) : {_maxD = 2500};
									case (0.25) : {_maxD = 0};
									};
								
								_chance = 1500 + ((((random 2500) + (random 2500) + (random 2500) + (random 2500)) * RYD_JR_APRangeM) min _maxD);

								if (_chance > _dst) then
									{
									RYD_JR_BusyHelis pushBack _heli;
																		
									[_mh,[position _pPos,200] call RYD_JR_RandomAround,_caller] call RYD_JR_AirResponse;

									if (((side _caller) in RYD_JR_Freq) and {("ItemRadio" in (assignedItems player)) and {not (_caller in RYD_JR_AllHelis)}}) then
										{
										_caller setVariable ["RYD_JR_MyLastAlarmChat",time];
																		
										_caller = leader _caller;
																				
										_where = mapGridPosition _caller;
										
										_en = _caller findNearestEnemy _caller;
										
										if not (isNull _en) then
											{
											_where = _caller getHideFrom _en;
											_where = mapGridPosition _where
											};
										
										_sent = (name _caller) + " reporting enemy contact. Requesting immediate air support at " + _where + ". Over.";
										
										[_sent,_caller,_heli] spawn
											{
											_sent = _this select 0;
											_caller = _this select 1;
											_heli = _this select 2;
											
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
													case (RYD_JR_Outro) : {_alive = false};
													};
												
												(not (_alive) or {((time - RYD_JR_LastComm) > 6)})
												};				
											
											if not (_alive) exitWith {};
											
											RYD_JR_LastComm = time;
																						
											["static1",2.5] spawn RYD_JR_Sound3D;
											sleep 0.02;												
											RYD_JR_Caller customChat [RYD_JR_RadioAlarm,_sent];
											
											_heli setVariable ["RYD_JR_Called",true];
											}
										}
									};
								}
							}
						};
					};
				};
			};
			
			{			
			switch (true) do
				{
				case (isNil {_x}) : {RYD_JR_ToAsk set [_foreachIndex,0]};
				case not ((typeName _x) in [typeName objNull]) : {RYD_JR_ToAsk set [_foreachIndex,0]};
				case (isNull _x) : {RYD_JR_ToAsk set [_foreachIndex,0]};
				case not (alive _x) : {RYD_JR_ToAsk set [_foreachIndex,0]};
				}	
			}
		foreach RYD_JR_ToAsk;
			
		RYD_JR_ToAsk = RYD_JR_ToAsk - [0];
		
			{			
			switch (true) do
				{
				case (isNil {_x}) : {RYD_JR_Mechanics set [_foreachIndex,0]};
				case not ((typeName _x) in [typeName objNull]) : {RYD_JR_Mechanics set [_foreachIndex,0]};
				case (isNull _x) : {RYD_JR_Mechanics set [_foreachIndex,0]};
				case not (alive _x) : {RYD_JR_Mechanics set [_foreachIndex,0]};
				}	
			}
		foreach RYD_JR_Mechanics;
			
		RYD_JR_Mechanics = RYD_JR_Mechanics - [0];
		
			{			
			switch (true) do
				{
				case (isNil {_x}) : {RYD_JR_Doctors set [_foreachIndex,0]};
				case not ((typeName _x) in [typeName objNull]) : {RYD_JR_Doctors set [_foreachIndex,0]};
				case (isNull _x) : {RYD_JR_Doctors set [_foreachIndex,0]};
				case not (alive _x) : {RYD_JR_Doctors set [_foreachIndex,0]};
				}	
			}
		foreach RYD_JR_Doctors;
			
		RYD_JR_Doctors = RYD_JR_Doctors - [0];
		
			{			
			switch (true) do
				{
				case (isNil {_x}) : {RYD_JR_Sellers set [_foreachIndex,0]};
				case not ((typeName _x) in [typeName objNull]) : {RYD_JR_Sellers set [_foreachIndex,0]};
				case (isNull _x) : {RYD_JR_Sellers set [_foreachIndex,0]};
				case not (alive _x) : {RYD_JR_Sellers set [_foreachIndex,0]};
				}	
			}
		foreach RYD_JR_Sellers;
			
		RYD_JR_Sellers = RYD_JR_Sellers - [0];
			
		if ((count RYD_JR_ToAsk) < 6) then
			{
				{
				_gp = _x;
				if ((side _gp) in [civilian]) then
					{
					if (({alive _x} count (units _gp)) > 0) then
						{
						_ldr = leader _gp;
						if (_ldr == (vehicle _ldr)) then
							{
								{
								_checked = _x getVariable ["RYD_JR_CivChecked",false];
								
								if not (_checked) then
									{
									if ((_x distance player) < 100) then
										{
										_x setVariable ["RYD_JR_CivChecked",true];
										
										_reputation = _x getVariable "RYD_JR_Reputation";
										
										if (isNil "_reputation") then
											{	
											_reputation = [true,_x] call RYD_JR_CalculateRep
											};
										
										if ((random 100) < 15 + (((_reputation/10) max -10) min 10)) then
											{
											_unit = _x;
											
											if not (_unit getVariable ["RYD_SCA_Hostile",false]) then
												{
												if (({((_x distance _unit)) < 500} count RYD_JR_Informers) < 6) then
													{
													if ((count RYD_JR_ToAsk) < 6) then
														{
														RYD_JR_ToAsk pushBack _unit;
														//RYD_JR_Informers set [(count RYD_JR_Informers),position _x];
														_acTxt = "<t color='#d0a900'>Ask about your brother</t>";
														_acTxt2 = "<t color='#d0a900'>Pay for information about your brother (2000 ff)</t>";
														if (has_body) then
															{
															_acTxt = "<t color='#d0a900'>Ask about anything interesting</t>";
															_acTxt2 = "<t color='#d0a900'>Pay for any interesting information (2000 ff)</t>";
															};
															
														_aID = _x addAction [_acTxt, "IntelCheck.sqf", [false,civilian,"ask"], 1, false, true, "", "(((player distance _target) < 8) and (alive _target))"];
														_x setVariable ["RYD_JR_AskAction",_aID];
														_aID = _x addAction [_acTxt2, "IntelCheck.sqf", [true,civilian,"ask"], 1, false, true, "", "(((player distance _target) < 8) and (alive _target) and not (RYD_JR_FuelFund < 2000))"];
														_x setVariable ["RYD_JR_PayAction",_aID];
														_x setVariable ["RYD_JR_Actioned",true];

														_service = ((random 100) < (25 + (((_reputation/5) max -25) min 25)));
														_rnd = random 100;
														
														if (_service) then
															{
															switch (true) do
																{
																case ((({(_x distance _unit) < 1000} count RYD_JR_Sellers) < 1) and {(_rnd < 15) or {(({(_x distance _unit) < 1000} count (RYD_JR_Doctors)) > 0) and {(({(_x distance _unit) < 1000} count (RYD_JR_Mechanics)) > 0)}}}) :
																	{
																	RYD_JR_Sellers pushBack _unit;
																	_unit setVariable ["RYD_JR_MyIcon","\A3\ui_f\data\map\mapcontrol\Tourism_CA.paa"];

																	_acTxt = "<t color='#d0a900'>Buy stuff</t>";
																	_aID = _x addAction [_acTxt, "Shop.sqf", [], 1, false, true, "", "(((player distance _target) < 8) and {(alive _target) and {not ((RYD_JR_inStealth) or {RYD_JR_inCombat})}})"];
																	};
																
																case ((({(_x distance _unit) < 1000} count RYD_JR_Mechanics) < 1) and {(_rnd < 30) or {(({(_x distance _unit) < 1000} count (RYD_JR_Doctors)) > 0) and {(({(_x distance _unit) < 1000} count (RYD_JR_Sellers)) > 0)}}}) :
																	{
																	RYD_JR_Mechanics pushBack _unit;
																	_unit setVariable ["RYD_JR_MyIcon","\A3\ui_f\data\map\markers\nato\n_maint.paa"];

																	_acTxt = "<t color='#d0a900'>Pay for fixing your current vehicles</t>";
																	_aID = _x addAction [_acTxt, RYD_JR_FixMyVeh, [], 1, false, true, "", "(((player distance _target) < 8) and {(alive _target) and {not ((RYD_JR_inStealth) or {RYD_JR_inCombat})}})"];
																	};
																	
																case (({(_x distance _unit) < 1000} count RYD_JR_Doctors) < 1) :
																	{
																	RYD_JR_Doctors pushBack _unit;
																	_unit setVariable ["RYD_JR_MyIcon","\A3\ui_f\data\map\mapcontrol\Hospital_CA.paa"];

																	_acTxt = "<t color='#d0a900'>Pay for medical attention</t>";
																	_aID = _x addAction [_acTxt, RYD_JR_HealUs, [], 1, false, true, "", "(((player distance _target) < 8) and {(alive _target) and {not ((RYD_JR_inStealth) or {RYD_JR_inCombat})}})"];
																	};
																};
															};
														
														if (RYD_JR_GCIntel > 0) then
															{
															if ((random 100) < (0.1 * RYD_JR_GCIntel)) then
																{
																_x setVariable ["RYD_JR_MoreIntel",true];
																}
															};
															
														if not (_x in RYD_JR_NearCivs) then
															{
															RYD_JR_NearCivs pushBack _x;
															}
														}
													}
												}
											}
										}
									}
								else
									{
									if (_x getVariable ["RYD_JR_Actioned",false]) then
										{
										if ((_x distance player) < 100) then
											{
											if not (_x in RYD_JR_NearCivs) then
												{
												RYD_JR_NearCivs pushBack _x;
												}
											}
										}
									}
								}
							foreach (units _gp)
							}
						}
					}
				}
			foreach (AllGroups - (RYD_JR_AllEnemy + [group RYD_JR_Brother]))
			};
		
		//diag_log "--14";

			{
			switch (true) do
				{
				case (isNil {_x}) : {RYD_JR_NearCivs set [_foreachIndex,0]};
				case (isNull _x) : {RYD_JR_NearCivs set [_foreachIndex,0]};
				case (not (alive _x) and not (_x in [RYD_JR_Brother])) : {RYD_JR_NearCivs set [_foreachIndex,0]};
				};
			}
		foreach RYD_JR_NearCivs;
		
		RYD_JR_NearCivs = RYD_JR_NearCivs - [0];
		
		//diag_log "--14a";
		
			{				
			if ((player distance _x) > 250) then
				{
				if not (_x in RYD_JR_NearTargets) then
					{
					if not (_x getVariable ["RYD_JR_Captive",false]) then
						{
						RYD_JR_NearCivs set [_foreachIndex,0];
						}
					}
				}		
			}
		foreach RYD_JR_NearCivs;
		
		RYD_JR_NearCivs = RYD_JR_NearCivs - [0];
		
		//diag_log "--14b";
		
		_pos = getPosATL (vehicle player);
		
		if (RYD_JR_ACIntense > 0) then
			{
			[] call RYD_JR_GraveDigger;
			
			_spawnAmount = {(_x distance _pos) < 2600} count RYD_JR_ACSpawns;

			if (_spawnAmount < ((floor (10 * (RYD_JR_ACIntense^0.75))) max 10)) then
				{
				if ((time - RYD_JR_LoadTime) > 600) then
					{
					//diag_log "--14c";
					
					_nearLocs = [];
					_dstSum = 0;
					
						{						
						_posL = position _x;
						_posL set [2,0];
						_dstAct = _pos distance _posL;
						if (_dstAct < 3000) then
							{
							_nearLocs pushBack _x;
							_dstSum = _dstSum + _dstAct
							}
						}
					foreach (RYD_JR_allCities + RYD_JR_allVillages);
					
					_cntLocs = count _nearLocs;
					
					if (_cntLocs < (random 3)) exitWith {};
					
					_dstAv = 0;
					
					if (_cntLocs > 0) then
						{
						_dstAv = _dstSum/_cntLocs
						};
					
					_urbanization = ((1000 * ((count _nearLocs)/(1000 + (2 * _dstAv)))) min 1.5) max 0.1;
					_wait = ((120 + (random 90) + (random 90))/_urbanization);

					if ((count RYD_JR_AllSpawnedGps) < RYD_JR_ACIntense) then
						{
						if ((time - RYD_JR_LastSpawn) > _wait) then
							{
							RYD_JR_LastSpawn = time;
							
							_sChance = ((50 + ((1.5 - (_urbanization^2)) * 20))/(1 + (RYD_JR_ACIntense/(20 + ((1.5 - _urbanization) * 5)))));
							
							if ((random 100) > _sChance) then
								{
								//diag_log "--14d";
								[((RYD_JR_ACIntense - (floor ((1.5 - _urbanization) * 3))) max 1),-1,((dayTime < _morning) or (dayTime > _evening))] call RYD_JR_Warmonger
								}
							}
						};
					
					if (((RYD_JR_LastCityBattle select 1) distance _pos) > 1000) then
						{
						if ((time - (RYD_JR_LastCityBattle select 0)) > (3000 + (random 600) + (random 600))) then
							{
							if ((random 100) > (98 - RYD_JR_ACIntense)) then
								{
								if ((count RYD_JR_AllSpawnedGps) < 10) then
									{
									_radC = -1;
									_city = locationNull;

										{
										_size = size _x;
										_radM = (_size select 0) min (_size select 1);
										
										_posL = position _x;
										_posL set [2,0];
										if ((_pos distance _posL) < _radM) exitWith
											{
											_radC = (_size select 0) max (_size select 1);
											_city = _x;
											}
										}
									foreach ((RYD_JR_allCities + RYD_JR_allVillages) - RYD_JR_AfterBattle);
									
									_noBattle = false;
									
									if not (isNull _city) then
										{
										if ((random 100) > 25) then
											{
											RYD_JR_AfterBattle pushBack _city;
											};
											
										if ((random 100) > 10) then
											{
											_noBattle = true
											}
										};
										
									if (_noBattle) exitWith {};

									if (_radC > 0) then
										{
										RYD_JR_LastCityBattle = [time,_pos];
										[(((2 * RYD_JR_ACIntense) min 8) max 4),_radC,((dayTime < _morning) or (dayTime > _evening))] call RYD_JR_Warmonger
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
			[] call RYD_JR_GraveDiggerLight;
			};

		if not ((RYD_JR_inStealth) or (RYD_JR_callPending)) then
			{
			if (({alive _x} count (units (group player))) > 1) then
				{
				if ((time - RYD_JR_LastChat) > 120) then
					{
					RYD_JR_LastChat = time;
					if ((random 100) > 80) then
						{
						_text = "";
						_city = locationNull;
						_unit = objNull;

						if ((random 100) > 50) then
							{
								{
								_size = size _x;
								_radM = (_size select 0) min (_size select 1);
								
								_posL = position _x;
								_posL set [2,0];
								if ((_pos distance _posL) < _radM) exitWith
									{
									_city = _x;
									}
								}
							foreach (RYD_JR_allCities + RYD_JR_allVillages)
							};
							
						if not (isNull _city) then
							{
							_unit = nearestObject [player, "Civilian"];
							switch (true) do
								{
								case (isNull _unit) : {_city = locationNull};
								case not (alive _unit) : {_city = locationNull};
								}
							};
						
						if not (isNull _city) then
							{
							_reputation = [true,_unit] call RYD_JR_CalculateRep;
							_pool = RYD_JR_Chatting_City;

							switch (true) do
								{
								case (_reputation > 30) : {_pool = RYD_JR_Chatting_City_HiRep};
								case (_reputation > 10) : {_pool = _pool + RYD_JR_Chatting_City_HiRep};
								case (_reputation < -30) : {_pool = RYD_JR_Chatting_City_LowRep};
								case (_reputation < -10) : {_pool = _pool + RYD_JR_Chatting_City_LowRep};
								};								
							
							_text = _pool select (floor (random (count _pool)));
							
							_units = (units (group player)) - [player];
							_unit = _units select (floor (random (count _units)));
							
							_text = (name _unit) + ": " + _text;
							
							_text = format [_text,text _city]
							}
						else
							{
							if ((count RYD_JR_Chatting) < 1) then
								{
								RYD_JR_Chatting = +RYD_JR_Chatting0
								};
								
							_text = RYD_JR_Chatting select (floor (random (count RYD_JR_Chatting)));
							
							_units = (units (group player)) - [player];
							_unit = _units select (floor (random (count _units)));
							
							RYD_JR_Chatting = RYD_JR_Chatting - [_text];
							
							_text = (name _unit) + ": " + _text;
							};
							
						titleText [_text,"PLAIN DOWN", 2];
						}
					}
				}
			}
		else
			{
			RYD_JR_LastChat = time
			};
			
		if (RYD_JR_ShowKillMarkers == 2) then
			{
				{
				if (_x isKindOf "CAManBase") then
					{
					if not (_x getVariable ["RYD_JR_BodyMarked",false]) then
						{
						if ((player distance _x) < (600 min viewDistance)) then
							{
							_isLOS = [getposASL player,getPosASL _x,1,0.5,vehicle player,_x] call RYD_JR_LOSCheck;
							if (_isLOS) then
								{
								_x setVariable ["RYD_JR_BodyMarked",true];
								[_x,getPosASL _x] spawn RYD_JR_Spark;
								}
							}
						}
					}
				}
			foreach (allDeadMen - [RYD_JR_Brother])
			};

		if (({alive _x} count (units (group player))) > 1) then
			{			
			if ((time - RYD_JR_LastChat) > 30) then
				{
				_assV = assignedVehicle RYD_JR_Alex;
					
				if (not (isNull _assV) and {not (_assV in _ownVehs) and {not (_assV isKindOf "StaticWeapon")}}) then
					{
					_ownVehs pushBack _assV;
					
					if ((count RYD_JR_ChattingNewVeh) < 1) then
						{
						RYD_JR_ChattingNewVeh = +RYD_JR_ChattingNewVeh0
						};
						
					_text = RYD_JR_ChattingNewVeh select (floor (random (count RYD_JR_ChattingNewVeh)));
					
					_units = (units (group player)) - [player];
					_unit = _units select (floor (random (count _units)));
					
					RYD_JR_ChattingNewVeh = RYD_JR_ChattingNewVeh - [_text];
					
					_text = (name _unit) + ": " + _text;
						
					RYD_JR_LastChat = time;
					titleText [_text,"PLAIN DOWN", 2];
					};
				}
			};
			
		if (RYD_JR_AS) then
			{
			if ((time - _asTime) > 1200) then
				{
				if (not (RYD_JR_inStealth) and not (RYD_JR_inCombat)) then
					{
					savegame;
					_asTime = time
					}
				}
			};


		if (RYD_JR_HuntStage < 4) then
			{
			_repo = 0;
			
				{
				_vl = _x select 0;
				_repo = _repo + (abs _vl)
				}
			foreach RYD_JR_RepEvents;
			
			switch (RYD_JR_HuntStage) do
				{				
				case (1) :
					{
					if (_repo > 60) then
						{
						RYD_JR_Trackers = RYD_JR_Trackers + RYD_JR_Trackers2;
						RYD_JR_HuntStage = 2
						}
					};
					
				case (2) :
					{
					if (_repo > 100) then
						{
						RYD_JR_Trackers = RYD_JR_Trackers + RYD_JR_Trackers3;
						RYD_JR_HuntStage = 3
						}
					};
					
				case (3) :
					{
					if (_repo > 140) then
						{
						RYD_JR_Trackers = RYD_JR_Trackers + RYD_JR_Trackers4;
						RYD_JR_HuntStage = 4
						}
					};
				};
			};
				
		//diag_log "--15";

		//diag_log format ["CYCLE TIME: %1",time - _stp];
		_firstC = false;
		
		if (has_body_boat) exitWith {};	
		
		sleep 10;
		
		waitUntil
			{
			sleep 0.1;
			
			not (RYD_JR_DecoyPending)
			};
		};
		
	//diag_log "------END OF MAIN LOOP------"
	};