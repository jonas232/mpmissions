#define UPDATE_TIME 0.1
#define DECOY_DISTANCE 10
#define DECOY_SPAWN_DELAY 4
#define DECOY_LIFETIME 12

#define DELETE_DISTANCE 3
#define PLAYER_DISTANCE 6 // Distance in which players are coloring
#define SECONDS_TO_FADE 5

SGS_boxesTicking = [];

SGS_sideColor = {
	params ["_side"];
	private _color = [0,0,0,1];
	switch (_side) do {
		case WEST: {_color = COLOR_BLUE};
		case EAST: {_color = COLOR_RED};
		case RESISTANCE: {_color = COLOR_GREEN};
		case civilian: {_color = COLOR_WHITE};
		case sideUnknown: {_color = COLOR_BASIC};
	};
	_color
};

// Color boxes around when decoy was
SGS_fnc_decoyPaint = {
	params ["_pos","_side"];
	{
		if (count getObjectMaterials _x > 1 && {(getObjectMaterials _x) select 1 == bxMatDEF}) then {
			_x setObjectMaterial [1,bxMatNEW];
		};
		_x setObjectTexture [1,[_side] call SGS_sideColor];
		_x setVariable ["timer", time + DECOY_LIFETIME];
		SGS_boxesTicking pushBackUnique _x;
	} forEach nearestObjects [_pos, ["house"], DECOY_DISTANCE];
};

SGS_fnc_colorBoxes = {
	// 1. Color boxes around players
	private _boxesNearPlayers = [];
	{
		{_boxesNearPlayers pushBackUnique _x} forEach (nearestObjects [_x, ["house"], PLAYER_DISTANCE]);
	} forEach (allUnits select {alive _x && _x getVariable ["vision",true]}); /// AI !!!!!!!!!!!!!!!!!!!!!!!!!!!!

	{
		_x setVariable ["timer",time + SECONDS_TO_FADE];
		SGS_boxesTicking pushBackUnique _x;
		private _player = nearestObject [getPos _x, "Man"];
		if (!isNull _player) then {
			// Paint color according to nearest player
			if (count getObjectMaterials _x > 1 && {(getObjectMaterials _x) select 1 == bxMatDEF}) then {
				_x setObjectMaterial [1,bxMatNEW];
			};
			_x setObjectTexture [1,[side group _player] call SGS_sideColor];
		};
	} forEach _boxesNearPlayers;

	// 2. Process ticking boxes
	{
		if (_x getVariable "timer" <= time) then {
			// Decolorize
			_x setObjectMaterial [1,bxMatDEF];
			_x setObjectTexture [1,COLOR_BASIC];
			SGS_boxesTicking = SGS_boxesTicking - [_x];
		};
	} forEach SGS_boxesTicking;
};

// Handle IR grenade
player addEventHandler ["Fired",{
	if ((_this select 5) != "B_IR_Grenade") exitWith {};
	//SGS_irGrenade = _this select 6;
	[_this select 6] spawn {
		params ["_irGrenade"];
		SGS_irGrenade = _irGrenade;
		// Draw decoy each frame
		private _handler = addMissionEventHandler ["Draw3D", {
			drawIcon3D ["a3\ui_f\data\igui\cfg\cursors\watch_ca.paa", [1,0,0,1], getpos SGS_irGrenade, 1, 1, 0, "DECOY", 0, 0.03, "TahomaB"];
		}];

		sleep DECOY_SPAWN_DELAY;

		// RemoteExec decoy function
		[getPos _irGrenade, side group player] remoteExec ["SGS_fnc_decoyPaint",0];

		sleep DECOY_LIFETIME;
		deletevehicle _irGrenade;
		removeMissionEventHandler ["Draw3D", _handler];
	};
}];

// Check coloring in group
while {true} do {
	sleep UPDATE_TIME;
	[] call SGS_fnc_colorBoxes;
};

