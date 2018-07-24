// [car, truck] execvm "tow.sqf"

private ["_car", "_tow"];
private ["_carPos", "_towPos", "_time", "_startpos", "_endpos", "_animData"];

_car = _this select 0; // the car to be towed (vehicle)
_tow = _this select 1; // the tow truck (vehicle)

// need to disable simulation so it doesn't explode.
_car enableSimulation false;

_carPos = getPosASL _car;
_towPos = getPosASL _tow;

// calculate playback animation time based on distance
_time = ((_car distance _tow) / 10);
//_time = 5;

// adjust start and end position for playback if required
_startpos = [_carPos select 0, _carPos select 1, (_carPos select 2) + 0];
_endpos   = [_towPos select 0, _towPos select 1, (_towPos select 2) + 2];

// create the unit play animation data
_animData = [
 [0, _startpos, getDir _car],
 // add more positions here ...
 [_time, _endpos, getDir _tow]
];

// play the tow animation and wait for it to complete
[_car, _animData, [_tow, "tow_anim_done"], true, true, 0, 0] spawn BIS_fnc_UnitPlaySimple;

waitUntil { _tow getVariable "tow_anim_done" };

// attach car to tow truck 
_car attachTo [_tow, [0,0,2]]