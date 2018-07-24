#include "ctrlAttach.sqf"

// Terminate camera
excluedObj = excluedObj -[cam];
lastCam = [getPos cam,[vectorDir cam, vectorUp cam]];
cam cameraEffect ["terminate","back"];
camDestroy cam;

// Delete Vars:
gl_updatePos = false;
pObjUpdate = false;
/*
if (typeName pointerObject == "OBJECT") then {
	hideObject pointerObject;
};
*/
// {player setVariable [_x, nil];} forEach ["camera"];
// objSource = objNull;
// {detach _x} forEach attachedObjects pointerObject;
if (deleteMemP && allMemP) then {
	_toDelete = missionNamespace getVariable "memPPointers";
	{deleteVehicle _x} forEach _toDelete;
	missionNamespace setVariable ["memPPointers",nil];
};