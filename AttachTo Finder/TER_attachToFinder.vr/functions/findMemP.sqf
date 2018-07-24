disableSerialization;
_mainDisplay = findDisplay 170331;
_txtMemP = _mainDisplay displayCtrl 310004;
_arrObj = _this select 0;
if (count _arrObj == 0) exitWith {["No memory points", _arrObj] call BIS_fnc_error};
_curSourceObj = objSource;
_standardText = "Nearest memory point: ";
while {!isNull _mainDisplay && _curSourceObj == objSource} do {
	_testArr = [];
	{_testArr pushBack (_x distance pointerObject)} forEach _arrObj;
	_closest = selectMin _testArr;
	_memP = _arrObj select (_testArr find _closest);
	_pointerPos = getPos pointerObject;
	_txtMemP ctrlSetText (_standardText +(_memP getVariable "memP"));
	waitUntil {!(_pointerPos isEqualTo getPos pointerObject)};
	sleep 1;
};