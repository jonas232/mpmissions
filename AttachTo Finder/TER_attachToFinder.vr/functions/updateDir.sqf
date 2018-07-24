// [case, ] call TER_fnc_updateDir;
// all params are cases
disableSerialization;
_mainDisplay = findDisplay 170331;

_edDegrees = _mainDisplay displayCtrl 310211;
_edVecDirX = _mainDisplay displayCtrl 310212;
_edVecDirY = _mainDisplay displayCtrl 310213;
_edVecDirZ = _mainDisplay displayCtrl 310214;
_edVecUpX = _mainDisplay displayCtrl 310215;
_edVecUpY = _mainDisplay displayCtrl 310216;
_edVecUpZ = _mainDisplay displayCtrl 310217;
_edPitchBankP = _mainDisplay displayCtrl 310218;
_edPitchBankB = _mainDisplay displayCtrl 310219;

_edVecDir = [_edVecDirX,_edVecDirY,_edVecDirZ];
_edVecUp = [_edVecUpX,_edVecUpY,_edVecUpZ];
_edPitchBank = [_edPitchBankP,_edPitchBankB];
params ["_updateAll","_vecDirC","_degC","_vecUpC","_pitchBankC"];
if (_updateAll) then 
{
	_pitchBank = pointerObject call BIS_fnc_getPitchBank;
	_pitchBankRnd = [ [_pitchBank select 0,3] call BIS_fnc_cutDecimals, [_pitchBank select 1,3] call BIS_fnc_cutDecimals];
	(_edPitchBank select 0) ctrlSetText str (_pitchBankRnd select 0);
	(_edPitchBank select 1) ctrlSetText str (_pitchBankRnd select 1);
};
_vecDir = vectorDir pointerObject;
_vecDirRnd = [ [_vecDir select 0,3] call BIS_fnc_cutDecimals, [_vecDir select 1,3] call BIS_fnc_cutDecimals, [_vecDir select 2,3] call BIS_fnc_cutDecimals];
(_edVecDir select 0) ctrlSetText str (_vecDirRnd select 0);
(_edVecDir select 1) ctrlSetText str (_vecDirRnd select 1);
(_edVecDir select 2) ctrlSetText str (_vecDirRnd select 2);

_deg = [getDir pointerObject,3] call BIS_fnc_cutDecimals;
_edDegrees ctrlSetText str (_deg);

_vecUp = vectorUp pointerObject;
_vecUpRnd = [ [_vecUp select 0,3] call BIS_fnc_cutDecimals, [_vecUp select 1,3] call BIS_fnc_cutDecimals, [_vecUp select 2,3] call BIS_fnc_cutDecimals];
(_edVecUp select 0) ctrlSetText str (_vecUpRnd select 0);
(_edVecUp select 1) ctrlSetText str (_vecUpRnd select 1);
(_edVecUp select 2) ctrlSetText str (_vecUpRnd select 2);
if (count attachedObjects pointerObject > 0) then {
	_attObj = attachedObjects pointerObject select 0;
	_attObj setVectorDirAndUp [_vecDirRnd, _vecUpRnd];
	_attObj setPos getPos pointerObject;
};
/*
