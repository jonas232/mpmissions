#include "..\settings\ctrlSettings.sqf"

// Pointer Size
if (ctrlEnabled _lbPSize) then {
	_case3 = typeOf pointerObject find (_lbPSize lbText (lbCurSel _lbPSize)) == -1;
	if (_case3) then {
		_oldPointer = pointerObject;
		_posOldP = getPos pointerObject;
		_cfgNewPointer = "Sign_Sphere" +(_lbPSize lbText (lbCurSel _lbPSize)) +"_F";
		pointerObject = _cfgNewPointer createVehicle _posOldP;
		pointerObject setPos _posOldP;
		deleteVehicle _oldPointer;
	};
};
// Pointer Color:
_case1 = typeOf pointerObject in ["Sign_Sphere10cm_F","Sign_Sphere25cm_F","Sign_Sphere100cm_F","Sign_Sphere200cm_F"];
_case2 = _lbPcolor lbText (lbCurSel _lbPcolor) != "Don't change";
if (_case1 && _case2) then {
	_red = ctrlText _edPcolorRed;
	_green = ctrlText _edPcolorGreen;
	_blue = ctrlText _edPcolorBlue;
	_alpha = ctrlText _edPcolorAlpha;
	_newColor = [_red,_green,_blue,_alpha];
	_colorText = "#(argb,8,8,3)color(" +_red +"," +_green +"," +_blue +"," +_alpha +",ca)";
	pointerObject setObjectTexture [0,_colorText];
	
	// ["#(argb,8,8,3)color(1,0.6,0.1,1.0,ca)"]
};
// Pointer Object
_case4 = ctrlEnabled _lbPObjExist && _lbPObjExist lbText (lbCurSel _lbPObjExist) != "Don't change";
if (_case4) then {
	_oldPointer = pointerObject;
	_obj = (_lbPObjExist lbData (lbCurSel _lbPObjExist)) call BIS_fnc_objectFromNetId;
	_obj setPos getPos _oldPointer;
	pointerObject = _obj;
	deleteVehicle _oldPointer;
};
_case5 = ctrlEnabled _edpObjCfg && ctrlText _edpObjCfg != "" && ctrlText _edpObjCfg != "Config name";
if (_case5) then {
	_oldPointer = pointerObject;
	_cfgNewPointer = ctrlText _edpObjCfg;
	_newPointer = _cfgNewPointer createVehicle [0,0,0];
	_newPointer setPos getPos _oldPointer;
	pointerObject = _newPointer;
	deleteVehicle _oldPointer;
};
// Memory points
if (cbChecked _cbShowMemP) then {allMemP = true};
if (cbChecked _cbMemPDelete) then {deleteMemP = true}
else {deleteMemP = false};
// Simulation
if (!cbChecked _cbSim) then {pointerObject enableSimulation false}
else {pointerObject enableSimulation true};
// Collision
if (!cbChecked _cbCollision) then {
	{pointerObject disableCollisionWith _x} forEach (allMissionObjects "All");
	pointerCollision = false;
} else {
	{pointerObject enableCollisionWith _x} forEach (allMissionObjects "All");
	pointerCollision = true;
};
// Exclude / Include
_curSelEx = lbCurSel _lbExclude;
_curSelIn = lbCurSel _lbInclude;
if (_lbExclude lbText _curSelEx != "Exclude object") then {
	_obj = (_lbExclude lbData _curSelEx) call BIS_fnc_objectFromNetId;
	excluedObj pushBack _obj;
	_lbExclude lbSetTooltip [_curSelEx,typeOf _obj];
};
if (_lbInclude lbText _curSelIn != "Include object") then {
	_obj = (_lbInclude lbData _curSelIn) call BIS_fnc_objectFromNetId;
	excluedObj = excluedObj - [_obj];
};
closeDialog 0;