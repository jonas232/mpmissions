RYD_JR_LastChat = time;

_dataHolder = _this select 0;
_paid = _this select 3;

_circum = _paid select 2;
_side = _paid select 1;
_paid = _paid select 0;

switch (_circum) do
	{
	case ("ask") : {RYD_JR_Asked = RYD_JR_Asked + 1};
	case ("int") : {RYD_JR_Interrogated = RYD_JR_Interrogated + 1};
	case ("search") : {RYD_JR_Searched = RYD_JR_Searched + 1};
	};

_dhPos = position _dataHolder;

_dhPos set [2,0];

if (_paid) then
	{
	RYD_JR_FuelFund = RYD_JR_FuelFund - 2000;
	RYD_JR_FuelFundSpent = RYD_JR_FuelFundSpent + 2000;
	
	_event = [0.1 + (random 0.1),getPosATL player,time];
	RYD_JR_RepEvents pushBack _event;
	};

_dataHolder setVariable ["RYD_JR_Actioned",false];

_moreIntel = _dataHolder getVariable ["RYD_JR_MoreIntel",false];

TitleText ["Let's see...","PLAIN DOWN", 2];

_isCiv = false;

_player = isPlayer _dataHolder;

if ((_dataHolder in RYD_JR_NearCivs) or (_player)) then
	{
	if not (_dataHolder getVariable ["RYD_JR_Captive",false]) then
		{
		_isCiv = true;
		}
	};
	
if ((_isCiv) and not (_player)) then
	{
	RYD_JR_Informers pushBack _dhPos;
	_id = _dataHolder getVariable ["RYD_JR_AskAction",-1];
	_dataHolder removeAction _id;
	_id = _dataHolder getVariable ["RYD_JR_PayAction",-1];
	_dataHolder removeAction _id;
	}
else
	{
	_dataHolder removeAction (_this select 2);
	};

if not ((_dataHolder in RYD_JR_Doctors) or {(_dataHolder in RYD_JR_Mechanics) or {(_dataHolder in RYD_JR_Sellers)}}) then
	{
	RYD_JR_NearCivs = RYD_JR_NearCivs - [_dataHolder]
	};

_pos = getPosATL _dataHolder;
_pos set [2,0];

_reputation = (((_dataHolder getVariable ["RYD_JR_Reputation",0]) min 150) max -150)/100;

if (_dataHolder getVariable ["RYD_JR_RemoveItem",false]) then
	{
	deleteVehicle _dataHolder
	};
	
sleep (3 + (random 2));

if ((_player) and ((count RYD_JR_Treasures) > 0)) exitWith
	{
	_ix = floor (random (count RYD_JR_Treasures));
	_pos = RYD_JR_Treasures select _ix;
	_pos = [(_pos select 0) - 200 + (random 400),(_pos select 1) - 200 + (random 400)];
	RYD_JR_Treasures set [_ix,0];
	RYD_JR_Treasures = RYD_JR_Treasures - [0];
	_ct = 0;
	
	while {surfaceIsWater _pos} do
		{
		_pos = [(_pos select 0) - 200 + (random 400),(_pos select 1) - 200 + (random 400)];
		_ct = _ct + 1;
		if (_ct > 100) exitWith {}
		};
	
	_i = "TMark_" + (str _pos);
	_i = createMarker [_i,_pos];
	_i setMarkerColor "Color4_FD_F";
	_i setMarkerShape "ICON";
	_i setMarkerType "hd_unknown";
	_i setMarkerSize [0.8,0.8];
	_i setMarkertext " Crash site";
	
	_text = "Hmm... According to this somehwere in that area crashed a helicopter with valuable cargo. \nIt may be worth to check.";
	
	if ((_pos distance player) > 5000) then
		{
		_text = _text + ".. Although this is pretty far."
		};
	
	TitleText [_text,"PLAIN DOWN", 2];
	};

_text = "Hmm. Nothing useful.";

_task = false;
_eGrp = grpNull;

_strongholdTip = false;

if (((_isCiv) and {not (_player)}) or {_circum in ["int","search"]}) then
	{
	if ((0.125 + (random 0.125) + (random 0.125)) < _reputation) then
		{
		if ((_paid) or {(has_body) or {((random 100) > 80)}}) then
			{
			switch ((((random 100) > 25) or {_circum in ["int","search"]}) and {(count RYD_JR_ShownStrongholds) < 4}) do
				{
				case (true) :
					{
					_sToShow = [];
					_aToShow = [];
					_anyS = false;
					_posCap = [];
					
						{
						_strh = _x;
						if (({_strh isEqualTo _x} count RYD_JR_ShownStrongholds) < 1) then
							{
							_anyS = true;
							_sToShow pushBack _x
							}
						}
					foreach RYD_JR_ActualStrongholds;

					_anyA = false;
					
						{
						_airf = _x;
						if (({_airf isEqualTo _x} count RYD_JR_ShownStrongholds) < 1) then
							{
							_anyA = true;
							_aToShow pushBack _x
							}
						}
					foreach RYD_JR_ActualAirfields;
					
					//if not ((_anyS) or {_anyA}) exitWith {};

					_markT = "c_air";
					_textM = " Airfield";
					_markS = "AfMark_";
					_toShow = +_aToShow;

					if ((((random 100) < 50) or {not _anyA}) and {_anyS}) then
						{
						_toShow = +_sToShow;
						_markT = "loc_Bunker";
						_markS = "StMark_";
						_textM = " Stronghold";
						};
					
					_toShowPos = _toShow select (floor (random (count _toShow)));
					
					_chance = ((4000/(_toShowPos distance _dhPos)) max 0.5) min 0.95;

					if ((random 1) < _chance) then
						{
						_strongholdTip = true;
						
						if ((_textM isEqualTo " Stronghold") and {RYD_JR_Difficulty < 2}) then
							{
							_cap = ([_toShowPos,RYD_JR_CaptivesPos] call RYD_JR_FindClosestWithIndex) select 0;
							_cap = [_cap,10] call RYD_JR_RandomAround;
							
							_i = "POW" + (str _cap);
							_i = createMarker [_i,_cap];
							_i setMarkerColor "ColorBLUFOR";
							_i setMarkerShape "ICON";
							_i setMarkerType "mil_join";
							_i setMarkerSize [0.5,0.5];
							_i setMarkertext " POW";							
							};
						
						_i = _markS + (str _toShowPos);
						_i = createMarker [_i,_toShowPos];
						_i setMarkerColor "colorRed";
						_i setMarkerShape "ICON";
						_i setMarkerType _markT;
						_i setMarkerSize [1,1];
						_i setMarkertext _textM;
						
						RYD_JR_ShownStrongholds pushBack _toShowPos;
						
						_text = "Warlord's big base, you say? Interesting. Could you point it on my map? Great. Thanks a lot!";
						
						if (_circum in ["int","search"]) then
							{
							_text = "Warlord's big base at this coords, huh? Good to know."
							}
						};
					};
						
				case (false) :
					{
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
					
					if ((count _vehs) < 1) exitWith {};

					_strongholdTip = true;

					_veh = ([_dhPos,_vehs] call RYD_JR_FindClosestWithIndex) select 0;
					
					_chance = ((1000/(_veh distance _dhPos)) max 0.15) min 0.95;

					if ((random 1) < _chance) then
						{	
						RYD_JR_LocatedVehs pushBack _veh;
						//RYD_JR_LocatedVehsN = RYD_JR_LocatedVehsN + 1;
						
						_pos = [(getPosATL _veh),100] call RYD_JR_RandomAround;
						_pos resize 2;						
											
						_i = "CarMark_" + (str _pos);
						_i = createMarker [_i,_pos];
						_i setMarkerColor "Color3_FD_F";
						_i setMarkerShape "ICON";
						_i setMarkerType "c_car";
						_i setMarkerSize [1,1];
						
						_text = "Abandoned vehicle, you say? Interesting. Could you point it on my map? Great. Thanks a lot!"	
						};			
					}
				}
			}
		}
	};
	
if (_dataHolder getVariable ["RYD_JR_Warlord",false]) then
	{
		{
		_strh = _x;
		if (({_strh isEqualTo _x} count RYD_JR_ShownStrongholds) < 1) then
			{
			_i = "StMark_" + (str _x);
			_i = createMarker [_i,_x];
			_i setMarkerColor "colorRed";
			_i setMarkerShape "ICON";
			_i setMarkerType "loc_Bunker";
			_i setMarkerSize [1,1];
			_i setMarkertext " Stronghold";
			
			RYD_JR_ShownStrongholds pushBack _strh;
			};
		}
	foreach RYD_JR_ActualStrongholds;
	
		{
		_airf = _x;
		if (({_airf isEqualTo _x} count RYD_JR_ShownStrongholds) < 1) then
			{
			_i = "AfMark_" + (str _x);
			_i = createMarker [_i,_x];
			_i setMarkerColor "colorRed";
			_i setMarkerShape "ICON";
			_i setMarkerType "c_air";
			_i setMarkerSize [1,1];
			_i setMarkertext " Airfield";
			
			RYD_JR_ShownStrongholds pushBack _airf;
			}			
		}
	foreach RYD_JR_ActualAirfields;
	};

if ((_strongholdTip) or (has_body)) exitWith
	{
	TitleText [_text,"PLAIN DOWN", 2];
	};

if ((_isCiv) and not (_player) and (RYD_JR_GCIntel > 0) and not (_moreIntel)) then
	{
	if (((random 2) + _reputation) < 0) exitWith {};
	if ((random 100) < (RYD_JR_GCIntel + _reputation)) then
		{	
		_closestE = [(position _dataHolder),(RYD_JR_allEnemy - RYD_JR_ActualTargets)] call RYD_JR_FindClosest;
		
		RYD_JR_ActualTargets pushBack _closestE;
		
		_unit = leader _closestE;
		
		if (alive _unit) then
			{
			if ((_unit distance _dataHolder) < 4000) then
				{
				if not (_unit in RYD_JR_NearCivs) then
					{
					RYD_JR_NearCivs pushBack _unit;
					RYD_JR_NearTargets pushBack _unit;
					_task = true;
					
					_dName = "";
					
					_dClass = configFile >> "CfgVehicles" >> (typeOf (vehicle _unit)) >> "displayName";
					
					if (isText _dClass) then
						{
						_dName = format [" (%1)",(getText _dClass)]
						};
					
					_pos = [(getPosATL _unit),250] call RYD_JR_RandomAround;
					_pos resize 2;
					
					_i = "KillMark_" + (str _pos);
					_i = createMarker [_i,_pos];
					_i setMarkerColor "colorRed";
					_i setMarkerShape "ICON";
					_i setMarkerType "hd_destroy";
					_i setMarkerText ("Kill: " + (name _unit) + _dName);
					
					_unit setVariable ["RYD_JR_MyKillMark",_i];
					_unit setVariable ["RYD_JR_MyKillDone",false];
					
					_ehIx = _unit addEventHandler ["Killed",{nul = _this call RYD_JR_KillIntel}];	
					_unit setVariable ["RYD_JR_HDEH",_ehIx];
					
					_text = format ["Informer: %1I'll tell you what I know if you prove you're on our side. Kill %2 first, then I'll send you the information, and maybe some money. But it depends on how well you perform the task. That bastard should be somewhere in the area, I've marked the spot on your map.%1",'"',name _unit];
					
					if ((random 100) < 30) then
						{
						RYD_JR_Alex setVariable ["RYD_JR_ItemReward",true]
						}
					}
				}
			}
		}
	};
	
if (_task) exitWith
	{
	TitleText [_text,"PLAIN DOWN", 2];
	};

if not ((10 + (_reputation * 3.5)) < (random 10)) then
	{
	if not ((_moreIntel) or (_player)) then
		{
		_chance = 30;
		if (_isCiv) then 
			{
			_chance = 50 + (_reputation * 5);
			if (_paid) then
				{
				_chance = 85 + (_reputation * 5)
				}
			};
			
		if (_dataHolder getVariable ["RYD_JR_Warlord",false]) then {_chance = 100};

		if ((random 100) < _chance) then
			{
			_dataGiven = false;
			if (_isCiv) then
				{
				if ((random 100) < 70) then
					{
					_dir = random 360;
					_misC = 10 - (_reputation * 3.5);
					if (_paid) then {_misC = _misC/2};			
					if ((random 100) > _misC) then
						{
						_dir = [getPosATL player,getPosATL RYD_JR_Brother,20] call RYD_JR_AngTowards;
						if (_dir < 0) then {_dir = _dir + 360};
						};
					
					_dirN = [_dir] call RYD_JR_WindRose;
					_text = format ["So you're saying, I should check %2%1 from here%2? OK, thanks a lot.",_dirN,'"'];
					
					_dataGiven = true;
					}
				};
			
			if not (_dataGiven) then
				{
				_text = "Oh! Interesting... Now I can exclude some places.";
							
				_ct = 0;
					
					{
					if ((count _x) == 2) then
						{
						if ((_pos distance (_x select 0)) < (1500 + (random 2500))) then
							{
							_ct = _ct + 1;
							_x set [2,true];
							(_x select 1) setMarkerColor "ColorRed";
							(_x select 1) setMarkerType "hd_objective";
							(_x select 1) setMarkerAlpha 1;							
							}
						}
					}
				foreach RYD_JR_allHolyPlaces;
				
				if (_ct < 1) then {_text = "Hmm. Nothing useful."} else {saveGame};
				
				if (((random 100) > 50) or (_dataHolder getVariable ["RYD_JR_Warlord",false])) then
					{
					if not (_text in ["Hmm. Nothing useful."]) then
						{
						_text = _text + "..\n Even some useful Intel about recent enemy presence. How nice.";
						}
					else
						{
						_text = "Hmm. At least some useful Intel about recent enemy presence."
						};
									
					_amnt = ceil ((random 2) + (random 2) + (random 2));
					
					if (_dataHolder getVariable ["RYD_JR_Warlord",false]) then
						{
						_amnt = ceil ((random 4) + (random 4) + (random 4));
						};
					
					for "_j" from 1 to _amnt do
						{
						[] call RYD_JR_EnemyDataMark
						}
					}
				}
			}
		}
	else
		{
		if ((_player) and {RYD_JR_Alex getVariable ["RYD_JR_ItemReward",false]}) exitWith
			{
			RYD_JR_Alex setVariable ["RYD_JR_ItemReward",false];
			
			_mapDefPos = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
			_expression = "(forest + trees) * (1 - meadow - houses - sea)";
			
			_value = [];
			_ct = 0;
			
			while {(count _value) < 1} do
				{
				_ct = _ct + 1;
				_value = selectBestPlaces [_mapDefPos,RYD_JR_mapSize,_expression,200,1];
				if (_ct > 50) exitWith {}
				};
				
			if ((count _value) < 1) exitWith
				{
				_text = "What the hell? Nothing useful in this! Bastard cheated me!";
				};

			_pos = (_value select 0) select 0;
			
			[nil,nil,nil,_pos] call RYD_JR_CreateBox;
			
			_pos = [_pos,30] call RYD_JR_RandomAround;
						
			_text = "Now, what's this supposed to be? Some hidden stash location? Something valuable, I hope...";
			
			_i = "StashMark_" + (str _pos);
			_i = createMarker [_i,_pos];
			_i setMarkerColor "ColorBlack";
			_i setMarkerShape "ICON";
			_i setMarkerType "mil_triangle";
			_i setMarkerSize [1,1];
			_i setMarkerText " Hidden stash";
			};
		
		saveGame;
		
		_text = "Wow! That's interesting indeed! According to this, I'm looking for a place somewhere within this circle.";
		
		_mpl = 1;
		_tresh = 0;
			
		while {(((random 1) min (random 1)) > _tresh)} do
			{
			_tresh = _tresh + 0.1
			};
				
		_mpl = _mpl + _tresh;
		
		_rds = 7500/_mpl;
		_pos = [(getPosATL RYD_JR_Brother),_rds] call RYD_JR_RandomAround;
		_ct = 0;
		
		while {(surfaceIsWater _pos)} do
			{
			_pos = [(getPosATL RYD_JR_Brother),_rds] call RYD_JR_RandomAround;
			_ct = _ct + 1;
			if (_ct > 50) exitWith {}
			};
		
		_pos resize 2;
		
		_i = "EnemyMark_" + (str _pos);
		_i = createMarker [_i,_pos];
		_i setMarkerColor "Color3_FD_F";
		_i setMarkerShape "ELLIPSE";
		_i setMarkerBrush "Solid";
		_i setMarkerSize [_rds,_rds];
		_i setMarkerAlpha 0.3;
		
		if ((_dataHolder getVariable ["RYD_JR_EvenMoreIntel",false]) or ((random 100) > 70)) then
			{
			_text = _text + "..\n Even some useful Intel about recent enemy presence. How nice.";
			
			_amnt = ceil ((random 4) + (random 4) + (random 4));
			if not (_dataHolder getVariable ["RYD_JR_EvenMoreIntel",false]) then
				{
				_amnt = ceil ((random 2) + (random 2) + (random 2));
				};
			
			for "_j" from 1 to _amnt do
				{
				[] call RYD_JR_EnemyDataMark
				};
			};
		};
	};
	
if (not (_side in RYD_JR_Freq) and {not (_side == civilian)}) then
	{
	_text = _text + " Wait, what's that? Their radio frequency?";
	RYD_JR_Freq pushBack _side;
	};
	
if (_circum isEqualTo "int") then
	{
	if ((random 100) > 30) then
		{
		_text = _text + " And now what. Some money for your miserable life? Who am I to refuse...";
		
		_rank = rankId _dataHolder;
		
		_sum = (((_rank max 1)^2) + 2) * 100;
		_sum = ceil ((random (_sum/2)) + (random (_sum/2)));
		
		_txt = format ["Account: +%1 ff.",_sum];

		RYD_JR_FuelFund = RYD_JR_FuelFund + _sum;
		RYD_JR_FuelFundGain = RYD_JR_FuelFundGain + _sum;

		["sonar",3] spawn RYD_JR_Sound3D;
		
		sleep 0.02;
		
		RYD_JR_Caller customChat [RYD_JR_RadioPhone, _txt];
		}
	};
	
TitleText [_text,"PLAIN DOWN", 2];