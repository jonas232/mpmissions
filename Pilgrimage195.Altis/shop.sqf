
_seller = _this select 0;

_stuff = _seller getVariable ["RYD_JR_myStuff",[]];
_stuffG = _seller getVariable ["RYD_JR_myStuffG",false];
RYD_JR_ActSeller = _seller;

if not (_stuffG) then
	{
	_seller setVariable ["RYD_JR_myStuffG",true];
	_margin = (1 + (random 0.5));
	_seller setVariable ["RYD_JR_myMargin",_margin];
	_stuffW = [];
	_stuffA = [];
	_stuffI = [];
	_chance = 100;
	_parent = configFile >> "CfgWeapons";
	_cnt = count RYD_JR_AllWeapons;

	for "_i" from 1 to _cnt do
		{
		_item = RYD_JR_AllWeapons select (floor (random _cnt));
		if ((random 100) < _chance) then
			{
			_stuffW pushBack [_parent,_item,"W",1];
			
			_mags = configFile >> "CfgWeapons" >> _item >> "magazines";
			
			if (isArray _mags) then
				{
				_mags = getArray _mags;
				
				if ((count _mags) > 0) then
					{
					_stuffA pushBack [(configFile >> "CfgMagazines"),(_mags select 0),"A",(1 + (ceil (random ((10 - (count _mags)) max 2))))]
					};
				};			
			};
			
		_chance = 100/(1 + ((count _stuffW)^3))
		};

	_chance = 100;
	_parent = configFile >> "CfgWeapons";
	_cnt = count RYD_JR_AllItems;

	for "_i" from 1 to _cnt do
		{
		_item = RYD_JR_AllItems select (floor (random _cnt));
		if ((random 100) < _chance) then
			{
			_stuffI pushBack [_parent,_item,"I",1];		
			};
			
		_chance = 100/(1 + ((count _stuffI)^2))
		};
		
	_chance = 100/(1 + ((count _stuffA)^2));
	_parent = configFile >> "CfgMagazines";
	_cnt = count RYD_JR_AllAmmo;

	for "_i" from 1 to _cnt do
		{
		_item = RYD_JR_AllAmmo select (floor (random _cnt));
		if ((random 100) < _chance) then
			{
			_stuffA pushBack [_parent,_item,"A",(1 + (ceil (random 9)))];		
			};
			
		_chance = 100/(1 + ((count _stuffA)^3))
		};

	_stuff append _stuffW;	
	_stuff append _stuffA;
	_stuff append _stuffI;
	
	_seller setVariable ["RYD_JR_myStuff",_stuff]
	};

[_stuff,_seller] call RYD_JR_Shopping;