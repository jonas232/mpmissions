// ["case"] spawn TER_fnc_camSwitch;
disableSerialization;
params ["_case"];
_camPos = getPos cam;
_camUp = vectorUp cam;
_camDir = vectorDir cam;
_dirAndUp = [_camDir,_camUp];

switch (_case) do
{
	case "moving": 
	{ 
		pObjUpdate = false;
		cam cameraEffect ["terminate","back"];
		camDestroy cam;
		cam = "camcurator" camCreate _camPos;
		[pointerObject] spawn TER_fnc_updateP;
	};
	case "static": 
	{ 
		pObjUpdate = false;
		cam cameraEffect ["terminate","back"];
		camDestroy cam;
		cam = "camera" camCreate _camPos;
		showCinemaBorder false;
		cam cameraEffect ["INTERNAL", "BACK"];
		cam camSetFocus [-1, -1];
		cam setVectorDirAndUp _dirAndUp;
		cam camCommit 0;
	};
};
showCinemaBorder false;
cam cameraEffect ["INTERNAL", "BACK"];
cam camSetFocus [-1, -1];
cam setVectorDirAndUp _dirAndUp;
cam camCommit 0;
