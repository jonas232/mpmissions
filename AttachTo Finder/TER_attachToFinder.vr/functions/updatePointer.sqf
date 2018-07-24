// [pointerObject] spawn TER_fnc_updateP;
disableSerialization;
_mainDisplay = findDisplay 170331;
_cbPointer = _mainDisplay displayCtrl 310301;
_btnPointer = _mainDisplay displayCtrl 310408;
_btnEnterPos = _mainDisplay displayCtrl 310411;

_edDegrees = _mainDisplay displayCtrl 310211;
_edVecDirX = _mainDisplay displayCtrl 310212;
_edVecDirY = _mainDisplay displayCtrl 310213;
_edVecDirZ = _mainDisplay displayCtrl 310214;
_edVecUpX = _mainDisplay displayCtrl 310215;
_edVecUpY = _mainDisplay displayCtrl 310216;
_edVecUpZ = _mainDisplay displayCtrl 310217;
_edPitchBankP = _mainDisplay displayCtrl 310218;
_edPitchBankB = _mainDisplay displayCtrl 310219;

_offset = (cam worldToModel getPos pointerObject);
pObjUpdate = true;
if (cbChecked _cbPointer && pObjUpdate && ctrlText _btnPointer == "Detach") then {_btnEnterPos ctrlEnable false};
/*
[_mainDisplay] spawn
{
	_thisObj = objSource;
	while {!isNull _mainDisplay && _thisObj == objSource && !isObjectHidden pointerObject} do {
		drawLine3D [objSource modelToWorld [0,0,0], pointerObject, [0,1,0,1]];
	};
};
*/
while {cbChecked _cbPointer && pObjUpdate && ctrlText _btnPointer == "Detach"} do
{
	_camPos = getPos cam;
	pointerObject setPos (cam modelToWorld _offset);
	pointerObject setDir (parseNumber ctrlText _edDegrees);
	[pointerObject,parseNumber ctrlText _edPitchBankP,parseNumber ctrlText _edPitchBankB] call BIS_fnc_setPitchBank;
	_dirCam = getDir cam;
	_vecDirUp = [vectorDir cam, vectorUp cam];
	waitUntil {!(_camPos isEqualTo getPos cam) OR _dirCam != getDir cam OR !(_vecDirUp isEqualTo [vectorDir cam, vectorUp cam])};
};
