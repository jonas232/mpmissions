private ["_allArty","_civF","_sides","_enemies","_friends","_side","_eSides","_fSides","_getF","_artyGroups","_gp","_isCiv","_knEnemies","_eVeh","_enArmor","_shells","_shell"];

sleep 5;

missionNameSpace setVariable ["RydFFE_FiredShells",[]];

if (isNil "RydFFE_Active") then {RydFFE_Active = true};
if (isNil "RydFFE_Manual") then {RydFFE_Manual = false};
if (isNil "RydFFE_NoControl") then {RydFFE_NoControl = []};
if (isNil "RydFFE_ArtyShells") then {RydFFE_ArtyShells = 1};
if (isNil "RydFFE_Interval") then {RydFFE_Interval = 10};
if (isNil "RydFFE_Debug") then {RydFFE_Debug = false};
if (isNil "RydFFE_FO") then {RydFFE_FO = []};
if (isNil "RydFFE_2PhWithoutFO") then {RydFFE_2PhWithoutFO = false};
if (isNil "RydFFE_OnePhase") then {RydFFE_OnePhase = false};

if (isNil ("RydFFE_Amount")) then {RydFFE_Amount = 6};
//if (isNil ("RydFFE_Disp")) then {RydFFE_Disp = 0.4};
if (isNil ("RydFFE_Acc")) then {RydFFE_Acc = 2};
if (isNil ("RydFFE_Safe")) then {RydFFE_Safe = 100};
if (isNil ("RydFFE_Monogamy")) then {RydFFE_Monogamy = true};
if (isNil ("RydFFE_ShellView")) then {RydFFE_ShellView = false};
if (isNil ("RydFFE_FOAccGain")) then {RydFFE_FOAccGain = 1};
if (isNil ("RydFFE_FOClass")) then {RydFFE_FOClass = 
	[
	"I_Spotter_F",
	"O_spotter_F",
	"B_spotter_F",
	"O_recon_JTAC_F",
	"B_recon_JTAC_F",
	"I_Sniper_F",
	"O_sniper_F",
	"B_sniper_F",
	"I_Soldier_M_F",
	"O_soldier_M_F",
	"B_G_Soldier_M_F",
	"B_soldier_M_F",
	"O_recon_M_F",
	"B_recon_M_F",
	"O_soldierU_M_F",
	"I_UAV_01_F",
	"I_UAV_02_CAS_F",
	"I_UAV_02_F",
	"O_UAV_01_F",
	"O_UAV_02_CAS_F",
	"O_UAV_02_F",
	"B_UAV_01_F",
	"B_UAV_02_CAS_F",
	"B_UAV_02_F"
	]};

if (isNil "RydFFE_Add_SPMortar") then {RydFFE_Add_SPMortar = []};
if (isNil "RydFFE_Add_Mortar") then {RydFFE_Add_Mortar = []};
if (isNil "RydFFE_Add_Rocket") then {RydFFE_Add_Rocket = []};

RydFFE_SPMortar = ["O_MBT_02_arty_F","B_MBT_01_arty_F"] + RydFFE_Add_SPMortar;
RydFFE_Mortar = ["I_Mortar_01_F","O_Mortar_01_F","B_G_Mortar_01_F","B_Mortar_01_F"] + RydFFE_Add_Mortar;
RydFFE_Rocket = ["B_MBT_01_mlrs_F"] + RydFFE_Add_Rocket;

_allArty = RydFFE_SPMortar + RydFFE_Mortar + RydFFE_Rocket;
_civF = ["CIV_F","CIV","CIV_RU","BIS_TK_CIV","BIS_CIV_special"];
_sides = [west,east,resistance];

_enemies = [];
_friends = [];
RydFFE_Fire = false;

if (isNil ("RydFFE_SVRange")) then {RydFFE_SVRange = 3000};

if (RydFFE_ShellView) then {[] spawn Shellview};

while {RydFFE_Active} do
	{
	if (RydFFE_Manual) then {waitUntil {sleep 0.1;((RydFFE_Fire) or not (RydFFE_Manual))};RydFFE_Fire = false};

		{
		_side = _x;

		_eSides = [sideEnemy];
		_fSides = [sideFriendly];

			{
			_getF = _side getFriend _x;
			if (_getF >= 0.6) then
				{
				_fSides pushBack _x
				}
			else
				{
				_eSides pushBack _x
				}
			}
		foreach _sides;

		if (({((side _x) == _side)} count AllGroups) > 0) then
			{
			_artyGroups = RYD_JR_Mortars;
			_enemies = [];
			_friends = [];

				{
				_gp = _x;

				if ((side _gp) == _side) then
					{
					if not (_gp in RydFFE_NoControl) then
						{
							{
							if ((typeOf (vehicle _x)) in _allArty) exitWith
								{
								if not (_gp in _artyGroups) then
									{
									if (((vehicle (leader _gp)) distance (vehicle player)) < 3800) then
										{										
										_artyGroups pushBack _gp
										}
									}
								}
							} 
						foreach (units _gp)
						}
					};

				_isCiv = false;
				if ((faction (leader _gp)) in _civF) then {_isCiv = true};

				if not (_isCiv) then
					{
					if (not (isNull _gp) and (alive (leader _gp))) then
						{
						if not ((side _gp) in _eSides) then 
							/*{
							if not (_gp in _enemies) then 
								{
								if not (_gp in [(group RYD_JR_AI)]) then
									{
									_enemies pushBack _gp;
									}
								}
							}
						else*/
							{
							if ((side _gp) in _fSides) then 
								{
								if not (_gp in _friends) then 
									{
									_lastRej = _gp getVariable ["RYD_JR_ArtyRefused",0];
									
									if ((time - _lastRej) > 120) then
										{
										_friends pushBack _gp;
										if ((typeOf (leader _x)) in RydFFE_FOClass) then
											{
											if ((count RydFFE_FO) > 0) then
												{
												if not (_gp in RydFFE_FO) then
													{
													RydFFE_FO pushBack _gp
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
			foreach (allGroups - ([(group player),(group RYD_JR_AI)] + RYD_JR_cached));

			_knEnemies = [];
			_enemies = [group player];

				{
					{
					_eVeh = vehicle _x;

						{
						if not ((faction (leader _x)) in _civF) then
							{
							if (((count RydFFE_FO) == 0) or (_x in RydFFE_FO)) then
								{
								if ((_x knowsAbout _eVeh) >= 0.05) then 
									{
									if not (_eVeh in _knEnemies) then 
										{
										_eVeh setVariable ["RydFFE_MyFO",(leader _x)];
										_knEnemies pushBack _eVeh
										}
									}
								}
							}
						}
					foreach _friends
					}
				foreach (units _x)
				}
			foreach _enemies;

			_enArmor = [];

				{
				if ((_x isKindOf "Tank") or (_x isKindOf "Wheeled_APC")) then
					{
					if not (_x in _enArmor) then
						{
						_enArmor pushBack _x
						}
					}
				}
			foreach _knEnemies;

			[_artyGroups,RydFFE_ArtyShells] call RYD_ArtyPrep;

			[_artyGroups,_knEnemies,_enArmor,_friends,RydFFE_Debug,RydFFE_Amount] call RYD_CFF
			}
		}
	foreach _sides;

	sleep RydFFE_Interval;

	_shells = missionNameSpace getVariable ["RydFFE_FiredShells",[]];
	
		{
		_shell = _x;
		if (isNil "_shell") then
			{
			_shells set [_foreachIndex,0]
			}
		else
			{
			if (isNull _x) then
				{
				_shells set [_foreachIndex,0]
				}
			}
		}
	foreach _shells;
	
	_shells = _shells - [0];	
	missionNameSpace setVariable ["RydFFE_FiredShells",_shells];
	};



