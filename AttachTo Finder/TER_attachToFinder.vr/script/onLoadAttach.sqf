#include "ctrlAttach.sqf"

_supEdArray = [(_lbArray -[_lbObj]),_edArray,_cbArray,(_btnArray-[_btnObjEnter,_btnInv,_btnInfo])];
{{_x ctrlEnable false} forEach _x} forEach _supEdArray;
// Camera
cam = "camcurator" camCreate (player modelToWorld [0,-5,5]);
excluedObj pushBack cam;
showCinemaBorder false;
cam cameraEffect ["INTERNAL", "BACK"];

cam camSetFocus [-1, -1];
cam camCommit 0;
// Listbox "Object", "Delete Object"
{
	_curLB = _x;
	{
		_ind = _curLB lbAdd (str _x);
		_tooltip = str composeText [getText (configfile >> "CfgVehicles" >> typeOf _x >> "displayName"),toString [13, 10],typeOf _x];
		_pic = getText (configfile >> "CfgVehicles" >> typeOf _x >> "editorPreview");
		// if (_tooltip == "") then {_tooltip = typeOf _x;};
		_curLB lbSetTooltip [_ind, _tooltip];
		_curLB lbSetPicture [_ind, _pic];
		_curLB lbSetPictureColor [_ind , [1,1,1,1]];
		_curLB lbSetPictureColorSelected [_ind , [1,1,1,1]];
		_curLB lbSetPictureColorDisabled [_ind , [1,1,1,1]];
		_curLB lbSetData [_ind, _x call BIS_fnc_netId];
	} forEach (nearestObjects [player, [], 200]) -excluedObj;
	_curLB lbSetCurSel 0;
} forEach [_lbObj, _lbDeleteObj];
[true] call TER_fnc_updateDir;

{_lbSteps lbAdd str _x} forEach [1,0.1,0.01,0.001];
_lbSteps lbSetCurSel 0;
if (!isObjectHidden pointerObject) then {_cbPointer cbSetChecked true;};

if (!firstTime) exitWith {
	// lastCam = [getPos cam,[vectorDir cam, vectorUp cam]];
	cam setPos (lastCam select 0);
	cam setVectorDirAndUp (lastCam select 1);
};
_cbPointer cbSetChecked true;
[pointerObject] spawn TER_fnc_updateP;
_camDir = getDir player;
_posPlayer = getPos player;
cam camSetTarget player;
cam setDir _camDir;
cam camCommit 0;
pointerObject hideObject false;
pointerObject setPos (cam modelToWorld [0,5,0]);
pointerObject setVectorDirAndUp [[0,0,0],[0,0,0]];
pointerObject setDir 0;
firstTime = false;


