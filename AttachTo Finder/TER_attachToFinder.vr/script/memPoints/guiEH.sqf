#include "ctrlMemP.sqf"

_case = _this select 0;
_ehParams = _this select 1;

switch (_case) do
{
	case "search":
	{
		tvClear _trSearch;
		_gArr = ["None","People","Vehicles"];
		_hArr = ["Cars", "Tanks", "Helicopter", "Planes"];
		{_trSearch tvAdd [[], _x];} forEach _gArr;
		{_trSearch tvAdd [[2], _x];} forEach _hArr;
		_trSearch tvExpand [];
		for "_g" from 0 to (_trMemP tvCount []) do
		{
			for "_h" from 0 to (_trMemP tvCount [_g]) do
			{
				if ((_trMemP tvText [_g,_h]) in _gArr) then {systemChat (_trMemP tvText [_g,_h])};
				if (toLower (_trMemP tvText [_g,_h]) find toLower (ctrlText _edSearch) != -1 && !((_trMemP tvText [_g,_h]) in _gArr)) then 
				{_trSearch tvAdd [[_g], (_trMemP tvText [_g,_h])]};
				for "_i" from 0 to (_trMemP tvCount [_g,_h]) do
				{
					if (toLower (_trMemP tvText [_g,_h,_i]) find toLower (ctrlText _edSearch) != -1 && !((_trMemP tvText [_g,_h, _i]) in _hArr)) then 
					{_trSearch tvAdd [[_g,_h], (_trMemP tvText [_g,_h,_i])]};
				};
			};
		};
		tvExpandAll _trSearch;
		// if (_trSearch tvCount [2] > 4) then {for "_i" from 4 to ((_trSearch tvCount [2])) do {_trSearch tvDelete [2,_i-1]}};
		
		
	};
	case "find":
	{
		tvClear _trMemP;
		_selName = selectionNames objSource;
		if (count _selName == 0) exitWith {_trMemP tvAdd [[], "No selection points found"]};
		private _arrObj = [];
		{
			// _selPos = objSource selectionPosition _x;
			// _selPosRnd = [[_selPos select 0,2] call BIS_fnc_cutDecimals, [_selPos select 1,2] call BIS_fnc_cutDecimals, [_selPos select 2,2] call BIS_fnc_cutDecimals];
			_obj = "Sign_Sphere10cm_F" createVehicle [0,0,0];
			_obj attachTo [objSource, [0,0,0], _x];
			_expOff = objSource worldToModel getPos _obj;
			if (!(_expOff isEqualTo [0,0,0])) then {
				_trMemP tvAdd [[], _x];
				if (!allMemP) then {deleteVehicle _obj}
				else {
					_arrObj pushBack _obj;
					_obj setVariable ["memPObj",true];
					_obj setVariable ["memP",_x];
				};
			} else {
				deleteVehicle _obj;
			};
		} forEach _selName;
		if (allMemP) then {
			missionNamespace setVariable ["memPPointers",_arrObj];
			[_arrObj] spawn TER_fnc_findMemP;
		};
		if (_trMemP tvCount [] == 0) then {_trMemP tvAdd [[], "No selection points found"]};
		
	};
	case "reset":
	{
		tvClear _trMemP;
		[false] execVM "script\memPoints\onLoadMemP.sqf";
	};

};