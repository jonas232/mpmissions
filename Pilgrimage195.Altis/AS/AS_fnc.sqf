RYD_AS_AngTowards = 
	{
	private ["_source0", "_target0", "_rnd0","_dX0","_dY0","_angleAzimuth0","_vert","_vH","_dZ0"];

	_source0 = _this select 0;
	_target0 = _this select 1;
	_rnd0 = _this select 2;
	_vert = false;
	if ((count _this) > 3) then {_vert = _this select 3};

	_dX0 = (_target0 select 0) - (_source0 select 0);
	_dY0 = (_target0 select 1) - (_source0 select 1);
	
	_angleAzimuth0 = 0;
	
	if (_vert) then 
		{
		_dZ0 = (_target0 select 2) - (_source0 select 2);
		_vH = [0,0,0] distance [_dX0,_dY0,0];
		_angleAzimuth0 = (_dZ0 atan2 _vH) + (random (2 * _rnd0)) - _rnd0
		}
	else
		{
		_angleAzimuth0 = (_dX0 atan2 _dY0) + (random (2 * _rnd0)) - _rnd0;
		};
	
	if (_angleAzimuth0 < 0) then {_angleAzimuth0 = _angleAzimuth0 + 360};

	_angleAzimuth0
	};
	
RYD_AS_RandomAroundMM = 
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
	
RYD_AS_FindClosest = 
	{
	private ["_ref","_objects","_closest","_dstMin","_dstAct"];

	_ref = _this select 0;
	_objects = _this select 1;

	_closest = [];

	if ((count _objects) > 0) then 
		{
		_closest = _objects select 0;

		_dstMin = _ref distance _closest;

			{
			_dstAct = _ref distance _x;

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
	
RYD_AS_CreateDecoy = 
	{
	private ["_gun","_class","_pos","_HQ","_gp","_object","_dbg"];
	
	_gun = _this select 0;
	_dbg = _this select 1;
	
	_class = "Sign_Sphere100cm_F";

	_pos = [-1000,-1000,1000];
	_object = _class createVehicle _pos;
	if not (_dbg) then {_object setObjectTexture [0,"#(ARGB,8,8,3)color(1,1,1,0,ca)"]};
	
	_object
	};
	
RYD_AS_FindClosestWithIndex = 
	{
	private ["_ref","_objects","_closest","_dstMin","_dstAct","_index","_clIndex"];

	_ref = _this select 0;
	_objects = _this select 1;

	_closest = objNull;

	if ((count _objects) > 0) then 
		{
		_closest = _objects select 0;
		_index = 0;
		_clIndex = 0;
		_dstMin = _ref distance _closest;

			{
			_dstAct = _ref distance _x;

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
	
RYD_AS_DistOrd = 
	{
	private ["_array","_point","_final","_closest","_ix","_limit"];

	_array = _this select 0;
	_point = _this select 1;
	_limit = _this select 2;

	_final = [];

	while {((count _array) > 0)} do
		{
		_closest = [_point,_array] call RYD_AS_FindClosestWithIndex;
				
		_ix = _closest select 1;
		_closest = _closest select 0;
		
		if ((_closest distance _point) > _limit) exitWith {};
		
		_final pushBack _closest;

		_array set [_ix,0];
		_array = _array - [0]
		};

	_final
	};
	
RYD_AS_LOSCheck = 
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

	_pos1ATL = [_pX1,_pY1,_level1];
	_pos2ATL = [_pX2,_pY2,_level2];

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
	
RYD_AS_isFlanking = 
	{
	private ["_point","_Rpoint","_angle","_diffA","_axis","_isFlanking","_modeB","_diffX","_vert"];	

	_point = _this select 0;
	_rPoint = _this select 1;
	_axis = _this select 2;
	_modeB = false;
	
	if ((count _this) > 3) then {_modeB = _this select 3};
	
	_vert = false;
	
	if ((count _this) > 4) then {_vert = _this select 4};
	
	if ((typeName _point) == "OBJECT") then
		{
		_point = getPosASL _point
		};
		
	if ((typeName _rPoint) == "OBJECT") then
		{
		_rPoint = getPosASL _rPoint
		};

	_angle = [_rPoint,_point,0,_vert] call RYD_AS_AngTowards;
	
	_isFlanking = false;
	
	_diffX = _angle - _axis;
	
	if (_angle < 0) then {_angle = _angle + 360};
	if (_axis < 0) then {_axis = _axis + 360}; 
	
	_diffA = _angle - _axis;

	if (_diffA < 0) then {_diffA = _diffA + 360};

	if ((_diffA > 80) and (_diffA < 280)) then 
		{
		_isFlanking = true
		};
		
	if (_modeB) exitWith {_diffX};

	_isFlanking
	};
	
RYD_AS_inSector = 
	{
	private ["_points","_rPoint","_point","_angle","_diffA","_axis","_sector"];	

	_points = _this select 0;
	_rPoint = _this select 1;
	_axis = _this select 2;
	_sector = _this select 3;
	
	if ((typeName _rPoint) == "OBJECT") then
		{
		_rPoint = getPosATL _rPoint
		};
		
		{
		_point = _x;
		
		if ((typeName _point) == "OBJECT") then
			{
			_point = getPosATL _point
			};
			
		_angle = [_rPoint,_point,0] call RYD_AS_AngTowards;
		

		if (_angle < 0) then {_angle = _angle + 360};
		if (_axis < 0) then {_axis = _axis + 360};  

		_diffA = _angle - _axis;
		
		if (_diffA < 0) then {_diffA = _diffA + 360};

		if ((_diffA > (_sector/2)) and (_diffA < (360 - (_sector/2)))) then 
			{
			_points set [_foreachIndex,0]
			}
		}
	foreach _points;
	
	_points = _points - [0];

	_points
	};
		
RYD_AS_PointToSecDst = 
	{
	private ["_p1","_p2","_pc","_d","_d0","_d1","_d2","_x1","_y1","_x2","_y2","_xc","_yc","_a","_b"];

	_p1 = _this select 0;
	_p2 = _this select 1;
	_pc = _this select 2;

	_d0 = _p1 distance _p2;
	_d1 = _pc distance _p1;
	_d2 = _pc distance _p2;

	_d = _d1;

	switch (true) do
		{
		case (((_d0 * _d0) + (_d1 * _d1)) <= (_d2 * _d2)) : {_d = _d1};
		case (((_d0 * _d0) + (_d2 * _d2)) <= (_d1 * _d1)) : {_d = _d2};
		default
			{
			_x1 = _p1 select 0;
			_y1 = _p1 select 1;

			_x2 = _p2 select 0;
			_y2 = _p2 select 1;

			_xc = _pc select 0;
			_yc = _pc select 1;

			_a = (_y2 - _y1)/(_x2 - _x1);
			_b = _y1 - _x1 * _a;

			_d = abs (((_a/_b) * _xc) + ((-1/_b) * _yc) + 1)/(sqrt (((_a/_b) * (_a/_b)) + (1/(_b * _b))));
			}
		};

	_d
	};
	
RYD_AS_PosTowards2D = 
	{
	private ["_source","_distT","_angle","_dXb","_dYb","_px","_py"];

	_source = _this select 0;
	_angle = _this select 1;
	_distT = _this select 2;

	_dXb = _distT * (sin _angle);
	_dYb = _distT * (cos _angle);

	_px = (_source select 0) + _dXb;
	_py = (_source select 1) + _dYb;

	[_px,_py,0]
	};
		
RYD_AS_FBReport = 
	{
	private ["_gun","_proj","_tgt","_bbr","_p1","_p2","_size","_pos","_dst","_minPos","_minDst","_gunDst","_dX","_dY","_dZ","_relPos","_decoy","_decDst","_mpl","_am","_posTgt","_posGun","_dst2D",
	"_toMinDst","_angle","_point2D","_dzTot","_prop","_zFin"];
	
	_gun = _this select 0;
	_proj = _this select 6;
	
	_tgt = _gun getVariable ["RYD_AS_CT",objNull];
	_decoy = _gun getVariable ["RYD_AS_MyDecoy",objNull];
	
	if (isNull _tgt) exitWith {};
	if (isNull _decoy) exitWith {};
	
	_am = 0;
	
	if (isTouchingGround _tgt) then 
		{
		_am = 0.4
		};
				
	_pos = getPosASL _proj;
	_posGun = (eyepos _gun);
	_posTgt = (eyepos _tgt);
	_posTgt = [_posTgt select 0,_posTgt select 1,(_posTgt select 2) - _am];
	_dst = _pos distance _posTgt;
	_gunDst = _posGun distance _posTgt;
	_decDst = _posGun distance (getPosASL _decoy);
	
	waitUntil
		{
		if not (isNull _tgt) then
			{
			_posTgt = (eyepos _tgt);
			_posTgt = [_posTgt select 0,_posTgt select 1,(_posTgt select 2) - _am]
			};
		
		if not (isNull _proj) then
			{
			_pos = getPosASL _proj
			};
			
		if not (isNull _gun) then
			{
			_posGun = (eyepos _gun)
			};
		
		_dst = _pos distance _posTgt;
		((isNull _proj) or (_dst > _gunDst) or (isNull _tgt) or (isNull _gun))
		};
		
	if ((isNull _tgt) or (isNull _gun)) exitWith {};
	
	_dst2D = 0;
	if not (((_posGun distance _pos) == 0) or ((_posTgt distance _pos) == 0) or ((_pos distance [0,0,0]) == 0)) then
		{
		_dst2D = [_posGun,_pos,_posTgt] call RYD_AS_PointToSecDst
		};
		
	_toMinDst = sqrt ((_gunDst^2) - (_dst2D^2));
	_angle = [_posGun,_pos,0] call RYD_AS_AngTowards;
	_point2D = [_posGun,_angle,_toMinDst] call RYD_AS_PosTowards2D;
	
	_dzTot = (_posGun select 2) - (_pos select 2);
	_prop = _toMinDst/(_posGun distance _pos);
	_zFin = _dzTot*_prop;
	
	_minPos = [_point2D select 0,_point2D select 1,(_posGun select 2) - _zFin];
	_minDst = _minPos distance _posTgt;
		
	if (_minDst > (0.02 * _gunDst)) exitWith {};
		
	_dX = 0;
	_dY = 0;
	_dZ = 0;
	
	if not (isNull _proj) then
		{
		_relPos = [(_minPos select 0) - (_posTgt select 0),(_minPos select 1) - (_posTgt select 1),(_minPos select 2) - (_posTgt select 2)];
		
		_mpl = _decDst/(_gunDst max 0.0001);
		
			{
			_relPos set [_foreachIndex,_x * _mpl]
			}
		foreach _relPos;
		
		_dX = _relPos select 0;
		_dY = _relPos select 1;
		_dZ = _relPos select 2
		};
	
	_shotReps = _gun getVariable ["RYD_AS_ShotReps",[]];
	_shotReps = [[_tgt,[_dX,_dY,_dZ],time]] + _shotReps;
	if ((count _shotReps) > 3) then {_shotReps resize 3};
	_gun setVariable ["RYD_AS_ShotReps",_shotReps];
	};
	
RYD_AS_SelectTarget = 
	{
	private ["_gun","_targets","_eRange","_final","_posASL","_tgt","_LT","_exit","_isLOS","_dir","_sector","_level"];

	_gun = _this select 0;
	_targets = _this select 1;
	_eRange = _this select 2;
	_sector = _this select 3;
	
	_posASL = getPosASL _gun;
	_dir = getDir _gun;
	
	_final = [_targets,_gun,_eRange] call RYD_AS_DistOrd;

	if (_sector < 360) then
		{
		_final = [_final,_gun,_dir,_sector] call RYD_AS_inSector
		};
				
	_others = RYD_AS_Cerberus - [_gun];
	
	if ((count _others) > 0) then
		{
			{
			if ((count _final) < 2) exitWith {};
			_oT = _x getVariable ["RYD_AS_LastTarget",[objNull,0]];
			_oT = _oT select 0;
			
			_final = _final - [_oT]
			}
		foreach _others
		};
	
	if ((count _final) < 1) exitWith {objNull};
	
	_LT = _gun getVariable ["RYD_AS_LastTarget",[objNull,0]];
	_LTime = _LT select 1;
	_LT = _LT select 0;
	
	_exit = false;
	
	_level1 = (ASLtoATL (eyePos _gun)) select 2;
	
	if not (isNull _LT) then
		{
		if (alive _LT) then
			{
			if (_LT in _final) then
				{
				if ((random 6) > (random (time - _LTime))) then
					{
					_level2 = (ASLtoATL (eyePos (vehicle _LT))) select 2;
					_isLOS = [_posASL,getPosASL (vehicle _LT),_level1,_level2,_gun,vehicle _LT] call RYD_AS_LOSCheck;
					
					if (_isLOS) then
						{
						_exit = true
						}
					}
				}
			}
		};
		
	if (_exit) exitWith {_LT};
	
	_gun setVariable ["RYD_AS_LastTarget",[objNull,0]];
		
		{
		_level2 = (ASLtoATL (eyePos (vehicle _x))) select 2;
		_isLOS = [_posASL,getPosASL (vehicle _x),_level1,_level2,_gun,(vehicle _x)] call RYD_AS_LOSCheck;
		
		_x setVariable ["NaWidelcu",_isLOS];

		if not (_isLOS) then
			{
			_final set [_foreachIndex,0]
			}
		}	
	foreach _final;
	
	_final = _final - [0];
	
	if ((count _final) < 1) exitWith {objNull};
	
	_tgt = _final select 0;
	
		{
		_mpl = 1;
		if ([_x,_gun,_dir] call RYD_AS_isFlanking) then {_mpl = 2};
		if ((random (2 * _foreachIndex)) > ((random (count _final)) * _mpl)) exitWith {_tgt = _x}
		}
	foreach _final;
	
	_tgt
	};
	
RYD_AS_Fire = 
	{
	_gun = _this select 0;
	_target = _this select 1;
	_reammo = _this select 2;
	_dispersion = _this select 3;
	_wildFire = _this select 4;
	
	_minDst = _target getVariable ["RYD_AS_Aegis",0];
	
	_target = vehicle _target;
		
	_decoy = _gun getVariable ["RYD_AS_MyDecoy",objNull];
	if (isNil "_decoy") exitWith {};
	if (isNull _decoy) exitWith {};
	
	if (isNull _gun) exitWith {};
	if not (alive _gun) exitWith {};
	if (isNull (gunner _gun)) exitWith {};
	if not (alive (gunner _gun)) exitWith {};
	if not (canFire _gun) exitWith {};
	if not (someAmmo _gun) exitWith {};
	
	_pos = eyepos _target;
	_am = 0;
	
	if (isTouchingGround _target) then 
		{
		_am = 0.4
		};
		
	_pos = [_pos select 0,_pos select 1,(_pos select 2) - _am];
		
	_hgt = _pos select 2;
	
	_vel = velocity _target;
	_speedT = [0,0,0] distance _vel;
	if (_speedT == 0) then {_speedT = 0.0001};

	_ammo = getText (configFile >> "CfgMagazines" >> (currentMagazine _gun) >> "ammo");
	_ammoSpeed = getNumber (configFile >> "CfgAmmo" >> _ammo >> "typicalSpeed");
	_dst = _gun distance _target;
	
	_dir = _gun weaponDirection (primaryWeapon _gun);
	_dirH = (_dir select 0) atan2 (_dir select 1);

	_diff = [_target,_gun,_dirH,true] call RYD_AS_isFlanking;
	
	_vH = [0,0,0] distance [_dir select 0,_dir select 1,0];
	_dirV = (_dir select 2) atan2 _vH;

	_diffV = [_target,_gun,_dirV,true,true] call RYD_AS_isFlanking;
		
	if (_diff > 180) then
		{
		_diff = abs (360 - _diff)
		};
		
	if (_diffV > 180) then
		{
		_diffV = abs (360 - _diffV)
		};
			
	_amn = 0.033;

	_pause = abs (_amn * _diff) * (1 min (60/_speedT));
		
	_pauseV = 0;
		
	_lvl = _hgt;

	_pos = [(_pos select 0) + ((_vel select 0) * _pause),(_pos select 1) + ((_vel select 1) * _pause),(_lvl + ((_vel select 2) * _pauseV))];
	
	_diff = [_pos,_gun,_dirH + _diff,true] call RYD_AS_isFlanking;
	_diffV = [_pos,_gun,_dirV + _diffV,true] call RYD_AS_isFlanking;
	
	if (_diff > 180) then
		{
		_diff = abs (360 - _diff)
		};
		
	if (_diffV > 180) then
		{
		_diffV = abs (360 - _diffV)
		};
	
	_pause = abs (_pause + (_amn * _diff)) + (_dst/(_ammoSpeed + 1));
	_pauseV = (_dst/(_ammoSpeed + 1)) * (1 max (_speedT/70));
	
	if (_speedT < 10) then {_pause = _pause + ((_speedT/30) min 0.12)};
	
	_pos = [(_pos select 0) + ((_vel select 0) * _pause),(_pos select 1) + ((_vel select 1) * _pause),(_lvl + ((_vel select 2) * _pauseV))];
	
	if (RYD_AS_SmartTargeting) then
		{
		_shotRep = _gun getVariable ["RYD_AS_ShotReps",[]];
					
		if ((count _shotRep) > 2) then
			{
			_sr1 = _shotRep select 0;
			_sr2 = _shotRep select 1;
			_sr3 = _shotRep select 2;

			_tgt1 = _sr1 select 0;
			_tgt2 = _sr2 select 0;
			_tgt3 = _sr3 select 0;
			
			if not ((_tgt1 == _tgt2) and (_tgt1 == _tgt3)) exitWith {};
			
			_tf = _sr1 select 2;
			
			if ((time - _tf) < 2) then
				{
				_miss1 = _sr1 select 1;
				_miss2 = _sr2 select 1;
				_miss3 = _sr3 select 1;

				_avX = ((_miss1 select 0) + (_miss2 select 0) + (_miss3 select 0))/3;
				_avY = ((_miss1 select 1) + (_miss2 select 1) + (_miss3 select 1))/3;
				_avZ = ((_miss1 select 2) + (_miss2 select 2) + (_miss3 select 2))/3;
				
				_amX = _avX;
				_amY = _avY;
				_amZ = _avZ;
				
				_gun setVariable ["RYD_AS_GX",_amX];
				_gun setVariable ["RYD_AS_GY",_amY];
				_gun setVariable ["RYD_AS_GZ",_amZ];
				
				_gun setVariable ["RYD_AS_ShotReps",[]];
				}
			};
			
		_amX = _gun getVariable ["RYD_AS_GX",0];
		_amY = _gun getVariable ["RYD_AS_GY",0];
		_amZ = _gun getVariable ["RYD_AS_GZ",0];
							
		_pos = [(_pos select 0) - _amX,(_pos select 1) - _amY,(_pos select 2) - _amZ];
		};
					
	_dst = _gun distance _pos;
	
	if (_dispersion > 1) then {_dispersion = 1};
	if (_dispersion < 0) then {_dispersion = 0};
		
	_disp = _dispersion * 10;	
	_disp = (_disp * _dst)/100;
	
	_vert = (_pos select 2) max ((getTerrainHeightASL [_pos select 0,_pos select 1]) + 0.35);
					
	_pos = [_pos,_minDst,_disp max _minDst] call RYD_AS_RandomAroundMM;
	
	_posG = getPosASL _gun;
	_posT = getPosASL _target;
	
	_dst2D = [_posG select 0,_posG select 1,0] distance [_posT select 0,_posT select 1,0];
	_dst3D = (_gun distance _target);
	
	_VDCoeff = 0;
	if (_dst3D > 0) then {_VDCoeff = _dst2D/_dst3D};
	_pos = [_pos select 0,_pos select 1,_vert + (((((random (_disp max _minDst)) - ((_disp max _minDst)/2)) * _VDCoeff)) max (_minDst * _VDCoeff))];

	_decoy setPosASL _pos;
	_watchTgt = _decoy;
	
	if not ((typeOf _gun) in RYD_AS_NormalAim) then 
		{
		_watchTgt = (_decoy modelToWorld [0,0,-0.7])
		};

	(gunner _gun) doWatch _watchTgt;
	
	_ct = time;
	_wait = 2;

	if not (_wildFire) then
		{
		waitUntil 
			{
			sleep 0.01;
			(((_gun aimedAtTarget [_decoy]) > 0) or ((time - _ct) > _wait))
			};
		};
					
	if (isNull _decoy) exitWith {};
	
	if (isNull _gun) exitWith {};
	if not (alive _gun) exitWith {};
	if (isNull (gunner _gun)) exitWith {_gun setVariable ["RYD_AS_LastTarget",[objNull,0]]};
	if not (alive (gunner _gun)) exitWith {_gun setVariable ["RYD_AS_LastTarget",[objNull,0]]};
	if not (canFire _gun) exitWith {_gun setVariable ["RYD_AS_LastTarget",[objNull,0]]};
	if not (someAmmo _gun) exitWith {_gun setVariable ["RYD_AS_LastTarget",[objNull,0]]};
		
	if (((_gun aimedAtTarget [_decoy]) > 0) or (_wildFire)) then
		{
		_gun setVariable ["RYD_AS_LastTarget",[_target,time]];
		_gun fireAtTarget [_decoy];
		if (_reammo) then {_gun setVehicleAmmo 1};
		};
		
	_gun setVariable ["RYD_AS_FireDone",true];
	};
	
RYD_AS_Debug3D = 
	{
	
		{
		if ((typeName _x) in [typename objNull]) then
			{
			if not (isNil "_x") then
				{
				if not (isNull _x) then
					{
					if (alive _x) then
						{
						_pos = visiblePosition _x;
						_nw = _x getVariable ["NaWidelcu",false];
						_bbr = boundingBoxReal _x;
						_p1 = _bbr select 0;
						_p2 = _bbr select 1;
						_maxHeight = abs ((_p2 select 2) - (_p1 select 2));
						_pos = [_pos select 0,_pos select 1,(_pos select 2) + _maxHeight + 0.25];
						
						_cl = [1,0,0,1];
						if not (_nw) then {_cl = [0,0,1,1]};
						
						drawIcon3D ["", _cl, _pos, 0, 0, 0, "X", 1, 0.05, "PuristaMedium"];
						};
					}
				}
			}
		}
	foreach RYD_AS_Hostiles;
	
		{
		if ((typeName _x) in [typename objNull]) then
			{
			if not (isNil "_x") then
				{
				if not (isNull _x) then
					{
					if (alive _x) then
						{
						_pos = visiblePosition _x;
						_nw = _x aimedAtTarget [_x getVariable ["RYD_AS_MyDecoy",objNull]];
						_nw = _nw > 0;
					
						_bbr = boundingBoxReal _x;
						_p1 = _bbr select 0;
						_p2 = _bbr select 1;
						_maxHeight = abs ((_p2 select 2) - (_p1 select 2));
						_pos = [_pos select 0,_pos select 1,(_pos select 2) + _maxHeight - 0.5];
						
						_cl = [1,0,0,1];
						if not (_nw) then {_cl = [0,0,1,1]};
						
						_txt = str ([_x getVariable ["RYD_AS_GX",0],_x getVariable ["RYD_AS_GY",0],_x getVariable ["RYD_AS_GZ",0]]);
						
						drawIcon3D ["", _cl, _pos, 0, 0, 0, _txt, 1, 0.05, "PuristaMedium"];
						}
					}
				}
			}
		}
	foreach RYD_AS_Cerberus
	};