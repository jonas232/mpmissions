#include "..\settings\ctrlSettings.sqf"

// Color
_curColor = getObjectTextures pointerObject select 0;
_lbPcolor lbAdd "Don't change";
_lbPcolor lbSetCurSel 0;
{
	_ind = _lbPcolor lbAdd (_x select 0);
	_lbPcolor lbSetColor [_ind, _x select 1];
	_lbPcolor lbSetPicture [_ind,"a3\ui_f\data\IGUI\Cfg\imageCornerElement_ca.paa"];
	_lbPcolor lbSetPictureColor [_ind,_x select 1];
	_lbPcolor lbSetPictureColorDisabled [_ind,_x select 1];
	_lbPcolor lbSetPictureColorSelected [_ind,_x select 1];
	
	
} forEach [
	["Red", [1,0,0,1]],
	["Yellow", [1,1,0,1]],
	["Green", [0,1,0,1]],
	["Cyan", [0,1,1,1]],
	["Blue", [0,0,1,1]],
	["Pink", [1,0,1,1]],
	["White", [1,1,1,1]],
	["Custom", [1,1,1,1]]
];

// Size
{_lbPSize lbAdd _x} forEach ["10cm","25cm","100cm","200cm"];
switch (typeOf pointerObject) do {
	case "Sign_Sphere10cm_F": {_lbPSize lbSetCurSel 0};
	case "Sign_Sphere25cm_F": {_lbPSize lbSetCurSel 1};
	case "Sign_Sphere100cm_F": {_lbPSize lbSetCurSel 2};
	case "Sign_Sphere200cm_F": {_lbPSize lbSetCurSel 3};
	default {_lbPsize ctrlEnable false;};
};

// Object
_lbPObjExist lbAdd "Don't change";
_lbPObjExist lbSetCurSel 0;
{
	_ind = _lbPObjExist lbAdd (str _x);
	_tooltip = getText (configfile >> "CfgVehicles" >> typeOf _x >> "displayName");
	_pic = getText (configfile >> "CfgVehicles" >> typeOf _x >> "editorPreview");
	if (_tooltip == "") then {_tooltip = typeOf _x;};
	_lbPObjExist lbSetTooltip [_ind, _tooltip];
	_lbPObjExist lbSetPicture [_ind, _pic];
	_lbPObjExist lbSetPictureColor [_ind , [1,1,1,1]];
	_lbPObjExist lbSetPictureColorSelected [_ind , [1,1,1,1]];
	_lbPObjExist lbSetPictureColorDisabled [_ind , [1,1,1,1]];
	_lbPObjExist lbSetData [_ind, _x call BIS_fnc_netId];
} forEach (nearestObjects [cam, [], 200]);
_cbObjExist cbSetChecked true;
["cbExist",[_cbObjExist,1]] execVM "script\settings\guiEH.sqf";

// Memory Points
if (allMemP) then {_cbShowMemP cbSetChecked true};

// Simulation
if (simulationEnabled pointerObject) then {_cbSim cbSetChecked true};

// Collision
if (pointerCollision) then {_cbCollision cbSetChecked true};

// Exclude
excluedObj = excluedObj -[objNull];
_lbExclude lbAdd "Exclude object";
_lbExclude lbSetCurSel 0;
{
	_curLB = _x;
	{
		_ind = _curLB lbAdd (str _x);
		_tooltip = str composeText [getText (configfile >> "CfgVehicles" >> typeOf _x >> "displayName"),toString [13, 10],typeOf _x];
		_pic = getText (configfile >> "CfgVehicles" >> typeOf _x >> "editorPreview");
		if (_tooltip == "") then {_tooltip = typeOf _x;};
		_curLB lbSetTooltip [_ind, _tooltip];
		_curLB lbSetPicture [_ind, _pic];
		_curLB lbSetPictureColor [_ind , [1,1,1,1]];
		_curLB lbSetPictureColorSelected [_ind , [1,1,1,1]];
		_curLB lbSetPictureColorDisabled [_ind , [1,1,1,1]];
		_curLB lbSetData [_ind, _x call BIS_fnc_netId];
	} forEach ((nearestObjects [player, [], 200]) -excluedObj);
	_curLB lbSetCurSel 0;
} forEach [_lbExclude];
_lbInclude lbAdd "Include object";
_lbInclude lbSetCurSel 0;
{
	_ind = _lbInclude lbAdd (str _x);
	_tooltip = str composeText [getText (configfile >> "CfgVehicles" >> typeOf _x >> "displayName"),toString [13, 10],typeOf _x];
	_pic = getText (configfile >> "CfgVehicles" >> typeOf _x >> "editorPreview");
	if (_tooltip == "") then {_tooltip = typeOf _x;};
	_lbInclude lbSetTooltip [_ind, _tooltip];
	_lbInclude lbSetPicture [_ind, _pic];
	_lbInclude lbSetPictureColor [_ind , [1,1,1,1]];
	_lbInclude lbSetPictureColorSelected [_ind , [1,1,1,1]];
	_lbInclude lbSetPictureColorDisabled [_ind , [1,1,1,1]];
	_lbInclude lbSetData [_ind, _x call BIS_fnc_netId];
} forEach excluedObj;