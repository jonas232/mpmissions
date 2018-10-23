_veh = assignedVehicle player;

_nV = (position _veh) nearEntities [["Air","LandVehicle"], 20];
_nV = _nV - [_veh];

if (({(count (crew _x)) < 1} count _nV) < 1) exitWith {hint "There is no any abandoned vehicle near"};

RYD_JR_AmmoSearch = true;

_txt = "Searching near vehicles...";
0.5 fadeSound 0;
TitleText [_txt,"BLACK OUT",0.55];

sleep 1;

_type = typeOf _veh;

_weapons = [];

_wps = configFile >> "CfgVehicles" >> _type >> "weapons";

if (isClass _wps) then
	{
	_weapons = _weapons + (getArray _wps)
	};

_turretsClass = configFile >> "CfgVehicles" >> _type >> "Turrets";

if (isClass _turretsClass) then
	{
	for "_i" from 0 to ((count _turretsClass) - 1) do
		{
		_class = _turretsClass select _i;
		
		if (isClass _class) then
			{
			_class = configName _class;
			
			_tWeapons = _turretsClass >> _class >> "weapons";
						
			if (isArray _tWeapons) then
				{
				_tWeapons = getArray _tWeapons;				
				_weapons = _weapons + _tWeapons
				}
			}
		}
	};
	
_weapClass = configFile >> "CfgWeapons";
	
_neededMags = [];

	{
	_mags = _weapClass >> _x >> "magazines";
	if (isArray _mags) then
		{
		_mags = getArray _mags;
		_neededMags = _neededMags + _mags
		}
	}
foreach _weapons;

_avMags = [];

	{
	_vh = _x;
	_ma = magazinesAmmo _vh;
	if ((count _ma) > 0) then
		{
		_avMags set [(count _avMags),[_ma,_vh]];
		}
	}
foreach _nV;

_ct = 0;

	{
	_mags = _x select 0;
	_vh = _x select 1;
	
		{
		_mag = _x;
		_name = _mag select 0;

		if (_name in _neededMags) then
			{
			_veh addMagazine _mag;
			_vh removeMagazine _name;
			_ct = _ct + 1
			}
		}
	foreach _mags
	}
foreach _avMags;

0.5 fadeSound 1;
TitleText [_txt,"BLACK IN",0.55];

if (_ct < 1) then 
	{
	_txt = "You didn't found any useful magazines"
	}
else
	{
	_txtL = "magazines";
	if (_ct == 1) then {_txtL = "magazine"};
	_txt = format ["You gathered %1 useful %2",_ct,_txtL];
	};
	
sleep 0.6;

TitleText [_txt,"PLAIN",0.55];

RYD_JR_AmmoSearch = false;
