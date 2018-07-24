#include "ctrlAttach.sqf"

_case = _this select 0;
_ehParams = _this select 1;
switch (_case) do
{
	case "keyMove":
	{
		private _mArr = [0,0,0];
		switch (_ehParams select 1) do
		{
			case 17: {_mArr = [0,0.1,0];}; 	// W
			case 31: {_mArr = [0,-0.1,0];}; 	// S
			case 30: {_mArr = [-0.1,0,0];}; 	// A
			case 32: {_mArr = [0.1,0,0];}; 	// D
			case 16: {_mArr = [0,0,0.1];}; 	// Q
			case 44: {_mArr = [0,0,-0.1];}; 	// Y
			case 57: {["detachPointer"] execVM "script\guiEH.sqf"}; // Space
		};
		if (_ehParams select 2) then {_mArr = _mArr vectorMultiply 10};
		if (_ehParams select 4) then {_mArr = _mArr vectorMultiply 0.1};
		cam setPos (cam modelToWorld _mArr);

	};
	case "select":
	{
		ctrlSetText [310001, "Camera control active: YES"];
		(_mainDisplay displayCtrl 310001) ctrlSetTextColor [0, 1, 0, 1];
		["moving"] call TER_fnc_camSwitch;
	};
	case "unselect":
	{
		ctrlSetText [310001, "Camera control active: NO"];
		(_mainDisplay displayCtrl 310001) ctrlSetTextColor [1, 0, 0, 1];
		["static"] spawn TER_fnc_camSwitch;
	};
	case "btnObj":
	{
		_netId = _lbObj lbData (lbCurSel _lbObj);
		objSource = _netId call BIS_fnc_objectFromNetId;
		{{_x ctrlEnable true} forEach _x} forEach _supArray;
		if (!pointerCollision) then {pointerObject disableCollisionWith _x} forEach (allMissionObjects "All" -[objNull]);
		if (ctrlText _btnPointer == "Detach") then {_btnEnterPos ctrlEnable false;};
		_thisObj = objSource;
		//onEachFrame {
		//	drawLine3D [objSource modelToWorld [0,0,0], pointerObject, [0,1,0,1]];
		//};
		[_mainDisplay,_thisObj,_edPosX,_edPosY,_edPosZ,_edPosArr] spawn {
			disableSerialization;
			params ["_mainDisplay", "_thisObj","_edPosX","_edPosY","_edPosZ","_edPosArr"];
			[_mainDisplay, _thisObj] spawn {
				disableSerialization;
				params ["_mainDisplay","_thisObj"];
				while {_thisObj == objSource && !isObjectHidden pointerObject} do {
					drawLine3D [objSource modelToWorld [0,0,0], pointerObject, [0,1,0,1]];
				};
			};
			while {!isNull _mainDisplay && _thisObj == objSource} do
			{
				_offset = objSource worldToModel getPos pointerObject;
				_offSetRnd = [ [_offset select 0,3] call BIS_fnc_cutDecimals, [_offset select 1,3] call BIS_fnc_cutDecimals, [_offset select 2,3] call BIS_fnc_cutDecimals ];
				_edPosX ctrlSetText str (_offSetRnd select 0);
				_edPosY ctrlSetText str (_offSetRnd select 1);
				_edPosZ ctrlSetText str (_offSetRnd select 2);
				_edPosArr ctrlSetText str _offSetRnd;
				waitUntil { !(_offset isEqualTo (objSource worldToModel getPos pointerObject)) };
			};

		};
	};
	if (!ctrlEnabled _btnExport) exitWith {};
	case "pointer":
	{
		if (_ehParams select 1 == 0) then
		{
			pointerObject hideObject true;
		};
		if (_ehParams select 1 == 1) then
		{
			pointerObject hideObject false;
			_thisObj = objSource;
			while {_thisObj == objSource && !isObjectHidden pointerObject} do {
				drawLine3D [objSource modelToWorld [0,0,0], pointerObject, [0,1,0,1]];
			};
		};
	};
	case "detachPointer":
	{
		// if (!ctrlEnabled _btnPointer) exitWith {};
		if (ctrlText _btnPointer == "Detach") then {
			pObjUpdate = false;
			_btnPointer ctrlSetText "Attach";
			if (ctrlEnabled _btnPointer) then {_btnEnterPos ctrlEnable true;};
		} else {
			_btnPointer ctrlSetText "Detach";
			[] call TER_fnc_updateP;
		};
	};
	case "mZx":
	{
		if (ctrltext _btnPointer == "Detach") exitWith {systemchat "Detach the pointer first"};
		_ctrl = _ehParams select 0;
		_change = round (_ehParams select 1);
		_changeMp = _change *(parseNumber ctrlText _txtSteps);
		_ctrl ctrlSetText str ((parseNumber ctrlText _ctrl) +_changeMp);
		pointerObject setPos (objSource modelToWorld [parseNumber ctrlText _edPosX,parseNumber ctrlText _edPosY,parseNumber ctrlText _edPosZ]);

	};
	case "+X":
	{
		_num = parseNumber ctrlText _txtSteps;
		if (pObjUpdate) then {
			_offset = objSource worldToModel getPos cam;
			cam setPos (objSource modelToWorld (_offset vectorAdd [_num,0,0]));
		} else {
			_offset = objSource worldToModel getPos pointerObject;
			pointerObject setPos (objSource modelToWorld (_offset vectorAdd [_num,0,0]));
		};
	};
	case "-X":
	{

		_num = parseNumber ctrlText _txtSteps;
		if (pObjUpdate) then {
			_offset = objSource worldToModel getPos cam;
			cam setPos (objSource modelToWorld (_offset vectorAdd [-_num,0,0]));
		} else {
			_offset = objSource worldToModel getPos pointerObject;
			pointerObject setPos (objSource modelToWorld (_offset vectorAdd [-_num,0,0]));
		};
	};
	case "enterPos":
	{
		_offset = objSource worldToModel getPos pointerObject;
		_ctrlNumberArr = [parseNumber (ctrlText _edPosX), parseNumber (ctrlText _edPosY),parseNumber (ctrlText _edPosZ)];
		pointerObject setPos (objSource modelToWorld _ctrlNumberArr);
	};
	case "+Y":
	{

		_num = parseNumber ctrlText _txtSteps;
		if (pObjUpdate) then {
			_offset = objSource worldToModel getPos cam;
			cam setPos (objSource modelToWorld (_offset vectorAdd [0,_num,0]));
		} else {
			_offset = objSource worldToModel getPos pointerObject;
			pointerObject setPos (objSource modelToWorld (_offset vectorAdd [0,_num,0]));
		};
	};
	case "-Y":
	{

		_num = parseNumber ctrlText _txtSteps;
		if (pObjUpdate) then {
			_offset = objSource worldToModel getPos cam;
			cam setPos (objSource modelToWorld (_offset vectorAdd [0,-_num,0]));
		} else {
			_offset = objSource worldToModel getPos pointerObject;
			pointerObject setPos (objSource modelToWorld (_offset vectorAdd [0,-_num,0]));
		};
	};
	case "+Z":
	{

		_num = parseNumber ctrlText _txtSteps;
		if (pObjUpdate) then {
			_offset = objSource worldToModel getPos cam;
			cam setPos (objSource modelToWorld (_offset vectorAdd [0,0,_num]));
		} else {
			_offset = objSource worldToModel getPos pointerObject;
			pointerObject setPos (objSource modelToWorld (_offset vectorAdd [0,0,_num]));
		};
	};
	case "-Z":
	{

		_num = parseNumber ctrlText _txtSteps;
		if (pObjUpdate) then {
			_offset = objSource worldToModel getPos cam;
			cam setPos (objSource modelToWorld (_offset vectorAdd [0,0,-_num]));
		} else {
			_offset = objSource worldToModel getPos pointerObject;
			pointerObject setPos (objSource modelToWorld (_offset vectorAdd [0,0,-_num]));
		};
	};
	case "charMem":
	{
		_btnMemP ctrlSetText "None";
	};
	case "posmp":
	{
		_txtSteps ctrlSetText (_lbSteps lbText (lbCurSel _lbSteps));
	};
	case "memPAct":
	{
		_memPSel = ctrlText _btnMemP;
		if (_memPSel == "NONE") then {_memPSel = ctrlText _edOwnMemP};
		if (_memPSel == "") exitWith
		{
			_edmemX ctrlSetText "";
			_edmemY ctrlSetText "";
			_edmemZ ctrlSetText "";
		};
		_sphereR = "Sign_Sphere10cm_F" createVehicle [0,0,0];
		_sphereR setObjectTexture [0,"#(argb,8,8,3)color(1,0,0,1,ca)"];
		_sphereR attachTo [objSource, [0,0,0], _memPSel];
		if (objSource worldToModel getPos _sphereR isEqualTo [0,0,0]) exitWith {
			systemChat ("Memorypoint " +str _memPSel +" not found");
			deleteVehicle _sphereR;
		};
		caseMem = true;
		while {!isNull _mainDisplay && caseMem} do
		{
			_offset = _sphereR worldToModel getPos pointerObject;
			_offSetRnd = [ [_offset select 0,3] call BIS_fnc_cutDecimals, [_offset select 1,3] call BIS_fnc_cutDecimals, [_offset select 2,3] call BIS_fnc_cutDecimals ];
			_edmemX ctrlSetText str (_offSetRnd select 0);
			_edmemY ctrlSetText str (_offSetRnd select 1);
			_edmemZ ctrlSetText str (_offSetRnd select 2);
			waitUntil { !(_offset isEqualTo (_sphereR worldToModel getPos pointerObject)) };
		};
	};
	case "enterMem":
	{
		if (ctrlText _btnPointer == "Attach") then {
			_posXYZ = [parseNumber ctrlText _edmemX,parseNumber ctrlText _edmemY,parseNumber ctrlText _edmemZ];
			_memPSel = ctrlText _btnMemP;
			pointerObject attachTo [objSource, _posXYZ, _memPSel];
			detach pointerObject;
		};
	};
	case "deleteObj":
	{
		_netId = _lbDeleteObj lbData (lbCurSel _lbDeleteObj);
		_selObj = _netId call BIS_fnc_objectFromNetId;
		if (_selObj == objSource) exitWith {systemChat "You can't delete the source object!"};
		if (_selObj == pointerObject) exitWith {systemChat "You can't delete the pointer!"};
		if (_selObj == player) exitWith {systemChat "You can't delete yourself!"};
		_curSelDel = lbCurSel _lbDeleteObj;
		_curSelObj = lbCurSel _lbObj;
		if (_curSelDel < _curSelObj) then {_curSelObj = _curSelObj -1};
		{
			_x lbDelete _curSelDel;
		} forEach [_lbObj, _lbDeleteObj];
		deleteVehicle _selObj;
		_lbObj lbSetCurSel _curSelObj;
	};
	case "nearAtt":
	{
		if (ctrlText _btnAttach == "Attach nearest object") then {
			if (count nearestObjects [getPos pointerObject, [], 20] <= 2) exitWith {systemChat "No object found"};
			_obj = (nearestObjects [getPos pointerObject, [], 20]) select 1;
			// _obj attachTo [pointerObject,[0,0,0]];
			if (_obj == cam) then {detach cam; _obj = (nearestObjects [getPos pointerObject, [], 20]) select 2;};
			_obj enableSimulation false;
			_btnAttach ctrlSetText "Detach object";
			while {ctrlText _btnAttach == "Detach object"} do
			{
				_pointerPos = getPos pointerObject;
				_obj setPos getPos pointerObject;
				_obj setDir (parseNumber ctrlText _edDegrees);
				[_obj,parseNumber ctrlText _edPitchBankP,parseNumber ctrlText _edPitchBankB] call BIS_fnc_setPitchBank;
				_dirPointer = getDir pointerObject;
				_vecDirUp = [vectorDir pointerObject, vectorUp pointerObject];
				waitUntil {!(_pointerPos isEqualTo getPos pointerObject) OR _dirPointer != getDir pointerObject OR !(_vecDirUp isEqualTo [vectorDir pointerObject, vectorUp pointerObject])};
			};

		} else {
			_btnAttach ctrlSetText "Attach nearest object";
			{detach _x; _x enableSimulation true;} forEach attachedObjects pointerObject;
		};

	};
	case "create":
	{
		// code code code bla bla
	};
	case "edVec":
	{
		_ctrl = _ehParams select 0;
		_change = (round (_ehParams select 1)) *(parseNumber ctrlText _txtSteps);
		_prevVal = parseNumber ctrlText _ctrl;
		_newVal = _prevVal + _change;
		_ctrl ctrlSetText str _newVal;
		// Set positions
		switch (true) do
		{
			case (_ctrl in [_edVecDirX,_edVecDirY,_edVecDirZ]): {
				_vecDir = [parseNumber ctrlText _edVecDirX,parseNumber ctrlText _edVecDirY,parseNumber ctrlText _edVecDirZ];
				pointerObject setVectorDir _vecDir;
				[true] call TER_fnc_updateDir;
			};
			case (_ctrl == _edDegrees): {
				_pitchBankFnc = [pointerObject,parseNumber ctrlText _edPitchBankP,parseNumber ctrlText _edPitchBankB];
				pointerObject setDir _newVal;
				_pitchBankFnc call BIS_fnc_setPitchBank;
				[true] call TER_fnc_updateDir;
			};
			case (_ctrl in [_edVecUpX,_edVecUpY,_edVecUpZ]): {
				_vecUp = [parseNumber ctrlText _edVecUpX,parseNumber ctrlText _edVecUpY,parseNumber ctrlText _edVecUpZ];
				pointerObject setVectorUp _vecUp;
				[true] call TER_fnc_updateDir;
			};
			case (_ctrl == _edPitchBankP): {
				if (_newVal > 90) then {_newVal = 90};
				if (_newVal < -90) then {_newVal = -90};
				_ctrl ctrlSetText str _newVal;
				_pitchBankFnc = [pointerObject,parseNumber ctrlText _edPitchBankP,parseNumber ctrlText _edPitchBankB];
				_pitchBankFnc call BIS_fnc_setPitchBank;
				[false] call TER_fnc_updateDir;
			};
			case (_ctrl == _edPitchBankB): {
				if (_newVal > 180) then {_newVal = 180};
				if (_newVal < -180) then {_newVal = -180};
				_ctrl ctrlSetText str _newVal;
				_pitchBankFnc = [pointerObject,parseNumber ctrlText _edPitchBankP,parseNumber ctrlText _edPitchBankB];
				_pitchBankFnc call BIS_fnc_setPitchBank;
				[false] call TER_fnc_updateDir;
			};
		};
	};
	case "dirEnter":
	{
		pointerObject setDir (parseNumber ctrlText _edDegrees);
		_pitchBankFnc = [pointerObject,parseNumber ctrlText _edPitchBankP,parseNumber ctrlText _edPitchBankB];
		_pitchBankFnc call BIS_fnc_setPitchBank;
		[false] call TER_fnc_updateDir;
	};
	case "dirReset":
	{
		pointerObject setVectorDirAndUp [[0,1,0],[0,0,1]];
		pointerObject setDir 0;
		[true] call TER_fnc_updateDir;
	};
	case "settings":
	{
		createDialog "TER_settings";
	};
	case "export":
	{
		_exportCommArr = [];
		_ingameComm = ["// Copied to clipboard:"];
		_newLine = toString [13, 10];
		// Offset
		_offset = "obj1 attachTo " +str [objSource, (parseText ctrlText _edPosArr)] +";";
		{_exportCommArr pushBack _x;} forEach [_offset];
		{_ingameComm pushBack _x;} forEach [lineBreak,_offset];
		_memP = ctrlText _btnMemP;
		if (_memP == "None") then {
			_memP = ctrlText _edOwnMemP};
		_offsetMemPTxt = "";
		if  (_memP != "") then {
			_offsetMemPArray = str [parseNumber ctrlText _edmemX,parseNumber ctrlText _edmemY,parseNumber ctrlText _edmemZ];
			_offsetMemPTxt = "obj1 attachTo ["+str objSource+", " +_offsetMemPArray +", " +str _memP +"];";
			{_exportCommArr pushBack _x;} forEach [_newLine,_offsetMemPTxt];
			{_ingameComm pushBack _x;} forEach [lineBreak,_offsetMemPTxt];
		};
		_vecDir = [parseNumber ctrlText _edVecDirX,parseNumber ctrlText _edVecDirY,parseNumber ctrlText _edVecDirZ];
		_vecUp = [parseNumber ctrlText _edVecUpX,parseNumber ctrlText _edVecUpY,parseNumber ctrlText _edVecUpZ];
		_vecDirUp = [_vecDir,_vecUp];
		_commVecDirUp = "obj1 setVectorDirAndUp " +str _vecDirUp +";";
		{_exportCommArr pushBack _x;} forEach [_newLine,_commVecDirUp];
		{_ingameComm pushBack _x;} forEach [lineBreak,_commVecDirUp];
		_commDegrees = "obj1 setDir " +(ctrlText _edDegrees) +";";
		{_exportCommArr pushBack _x;} forEach [_newLine,_commDegrees];
		{_ingameComm pushBack _x;} forEach [lineBreak,_commDegrees];
		_commPitchBank = "[obj1, " +ctrlText _edPitchBankP +", " +ctrlText _edPitchBankB +"] call BIS_fnc_setPitchBank;";
		{_exportCommArr pushBack _x;} forEach [_newLine,_commPitchBank];
		{_ingameComm pushBack _x;} forEach [lineBreak,_commPitchBank];
		if (!simulationEnabled pointerObject) then {
			_commSim = "obj1 enableSimulationGlobal false;";
			{_exportCommArr pushBack _x;} forEach [_newLine,_commSim];
			{_ingameComm pushBack _x;} forEach [lineBreak,_commSim];
		};
		if (!pointerCollision) then {
			_commCollision = format ["obj1 disableCollisionWith %1;", objSource];
			{_exportCommArr pushBack _x;} forEach [_newLine,_commCollision];
			{_ingameComm pushBack _x;} forEach [lineBreak,_commCollision];
		};
		_outPut = composeText _exportCommArr;
		// _outPut = _offset +_newLine +_offsetMemPTxt +_newLine +_commVecDirUp +_newLine+_commDegrees +_newLine +_commPitchBank +_newLine +_commSim +_newLine +_commCollision;

		_outPutIngame = composeText  _ingameComm;
		// _outPutIngame = composeText [_addText,lineBreak,_offset,lineBreak,_offsetMemPTxt,lineBreak,_commVecDirUp,lineBreak,_commDegrees,lineBreak,_commPitchBank,lineBreak,_commSim,lineBreak,_commCollision];
		_txtExport ctrlSetStructuredText _outPutIngame;
		_txtExport call BIS_fnc_ctrlFitToTextHeight;
		_txtExport ctrlSetPosition [0.27 * safezoneW + safezoneX, 0.052 * safezoneH + safezoneY];
		_txtExport ctrlCommit 0;
		_txtExport ctrlSetBackgroundColor [0,0,0,0.1];
		_txtExport ctrlSetTextColor [0,1,0,1];
		systemChat ("Copied to clipboard at time: " +str time);
		copyToClipboard str _outPut;
		sleep 15;
		_alpha = 1;
		_txtExport setVariable ["thisExport",time];
		_thisTime = time;
		_ctrlText = ctrlText _txtExport;
		while {_alpha > 0 && _ctrlText == ctrlText _txtExport && _thisTime == _txtExport getVariable "thisExport"} do {
			_alpha = _alpha-(1/200);
			_alpha2 = _alpha/10;
			_txtExport ctrlSetTextColor [0,1,0,_alpha];
			_txtExport ctrlSetBackgroundColor [0,0,0,_alpha2];
			sleep 0.001;
		};
		/*for "_i" from 1 to 1000 do {

		};
		*/
		if (_ctrlText != ctrlText _txtExport OR _thisTime != _txtExport getVariable "thisExport") exitWith {};
		_txtExport ctrlSetPosition [-100,-100];
		_txtExport ctrlCommit 0;
		_txtExport ctrlSetText "";
		_txtExport ctrlSetTextColor [0,1,0,1];
	};
};