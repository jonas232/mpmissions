RYD_JR_Spark = 
	{
	private ["_i","_unit","_alpha","_size","_pos"];

	_unit = _this select 0;
	_pos = _this select 1;

	_i = "markKill" + (str _unit) + (str (getPosATL _unit)) + (str (random 100));

	_i = createMarker [_i,_pos];
	_i setMarkerColor "ColorBlack";
	_i setMarkerShape "ICON";
	_i setMarkerType "mil_destroy";
	_i setMarkerSize [1,1];
	
	_unit setVariable ["RYD_JR_RIP",_i];
	
	_alpha = 1;
	_size = 1;
	while {(_size > 0.4)} do
		{
		sleep 0.2;
		_i setmarkerAlpha _alpha;
		_i setMarkerSize [_size,_size];
		_size = _size - 0.008;
		if (_alpha > 0.45) then {_alpha = _alpha - 0.01};
		};

	//deleteMarker _i;
	};