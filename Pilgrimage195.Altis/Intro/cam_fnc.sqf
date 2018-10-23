
RYD_NND_Scene = 
	{//_handle = [camera,start pos,end pos,target,relative pos,commit time,sensor mode,command mode,attach to target,prepare,wait till done,hide transition under black] call RYD_NND_Scene;
	private ["_cam","_sPos","_ePos","_tgt","_relPos","_commit","_sensor","_command","_attach","_prepare","_wait","_black","_rigid","_camTgt","_attTgt","_first"];
	
	_cam = _this select 0;
	_sPos = _this select 1;
	
	if ((count _sPos) < 2) then 
		{
		_sPos = position _cam
		};
		
	_ePos = _this select 2;
	
	if ((count _ePos) < 2) then 
		{
		_ePos = _sPos
		};
		
	_tgt = _this select 3;
	_attTgt = _tgt;
	
	if ((typeName _tgt) in [typename []]) then
		{
		_first = _tgt select 0;
		if ((typeName _first) in [typename objNull]) then
			{
			_attTgt = _first;
			_tgt = _tgt select 1;
			}
		};
	
	_relPos = _this select 4;
	
	if not ((typename _tgt) in [typename objNull]) then
		{
		_relPos = []
		}
	else
		{
		if (isNull _tgt) then
			{
			_relPos = []
			}
		};
		
	_commit = _this select 5;
	
	_sensor = toLower (_this select 6);
	
	if (_sensor in [""]) then 
		{
		_sensor = "visible"
		};
		
	_command = toLower (_this select 7);
	
	_attach = _this select 8;
	
	_prepare = _this select 9;
	
	_wait = _this select 10;
	
	_black = _this select 11;
	
	_rigid = false;
	
	if ((count _this) > 12) then
		{
		_rigid = _this select 12
		};
	
	_camTgt = camTarget _cam;
	
	if (_black) then
		{
		TitleText ["","BLACK OUT",0.5];
		sleep 0.55
		};

	detach _cam;
		
	//_cam camSetSensorType _sensor;
	
	if not (_command in [""]) then
		{
		_cam camCommand _command
		};
	
	switch (_prepare) do
		{
		case (false) :
			{
			if ((_sPos distance _cam) > 0) then
				{
				_cam camSetPos _sPos;
				
				_cam camCommit 0
				};
			
			if ((count _ePos) > 2) then
				{	
				_cam camSetPos _ePos
				};
			
			if not (_camTgt in [_tgt]) then
				{
				if ((typename _tgt) in [typename []]) then
					{
					_cam camSetTarget _tgt
					}
				else
					{
					if not (isNull _tgt) then
						{
						_cam camSetTarget _tgt
						}
					}
				};
				
			if (((count _relPos) > 2) and ((typename _tgt) in [typename objNull])) then
				{
				if not (isNull _tgt) then
					{
					_cam camSetRelPos _relPos
					}
				};

			_cam camCommit _commit
			};
			
		case (true) :
			{
			_cam camPreload ((_commit/5) max 1);
			
			waitUntil {camPreloaded _cam};
					
			if ((_sPos distance _cam) > 0) then
				{
				_cam camSetPos _sPos;
				
				_cam camCommit 0
				};
				
			_cam camPreload ((_commit/5) max 1);
			
			waitUntil {camPreloaded _cam};
				
			if ((count _ePos) > 2) then
				{	
				_cam camPreparePos _ePos
				};
			
			if not (_camTgt in [_tgt]) then
				{
				if ((typename _tgt) in [typename []]) then
					{
					_cam camPrepareTarget _tgt
					}
				else
					{
					if not (isNull _tgt) then
						{
						_cam camPrepareTarget _tgt
						}
					}
				};
				
			if (((count _relPos) > 2) and ((typename _tgt) in [typename objNull])) then
				{
				if not (isNull _tgt) then
					{
					_cam camPrepareRelPos _relPos
					}
				};
				
			_cam camCommitPrepared _commit						
			};
		};
		
	if (_wait) then
		{
		waitUntil
			{
			camCommitted _cam
			};
		};
		
	if (_attach) then
		{
		if ((count _relPos) > 2) then
			{
			if (_rigid) then
				{
				_cam attachTo [_attTgt,_relPos]
				}
			else
				{
				_cam attachTo [_attTgt,_relPos,"",2]
				}
			}
		};
	
	if (_black) then
		{
		TitleText ["","BLACK IN",0.5];
		sleep 0.55
		};
	};
		
RYD_NND_MoveCamRel = 
	{
	private ["_cam","_target","_anchor","_anchor2","_relPos","_speed","_cPos","_tPos","_nPos","_newZ","_attPos","_change","_camPosASL","_tgtPosASL","_dX","_dY","_dZ","_newX","_newY","_newZ"];


	_cam = _this select 0;
	
	//_cam camSetAttachedLookDir [0,0,0];
	//_cam camSetBankIfAttached false;
	
	_target = _this select 1;
	_anchor = _this select 2;
	_anchor2 = _this select 3;
	_relPos = _this select 4;
	_speed = _this select 5;

	_cPos = getPosASL _anchor;
	//_cPos set [2,0];

	_tPos = getPosASL _target;
	//_tPos set [2,0];

	_attPos = _target worldToModel _cPos;

	_anchor2 setPosASL _tPos;
	_anchor attachTo [_anchor2,_attPos];

	_camPosASL = getPosASL _cam;
	_tgtPosASL = ATLtoASL (_anchor2 modelToWorld _relPos);
	
	_dX = (_tgtPosASL select 0) - (_camPosASL select 0);
	_dY = (_tgtPosASL select 1) - (_camPosASL select 1);
	_dZ = (_tgtPosASL select 2) - (_camPosASL select 2);
	
	_newX = _attPos select 0;
	_newY = _attPos select 1;
	_newZ = _attPos select 2;

	for "_i" from 1 to _speed do
		{
		_newX = _newX + (_dX/_speed);
		_newY = _newY + (_dY/_speed);
		_newZ = _newZ + (_dZ/_speed);

		_anchor attachTo [_anchor2,[_newX,_newY,_newZ]];
		sleep 0.01
		};

	};
	
RYD_BIS_fnc_typeText = 
	{
	/*
		Author: Jiri Wainar

		Description:
		Types a structured text on the screen, letter by letter, cursor blinking.

		Parameter(s):
		_this: array containing blocks of text with same structured text formatting

		Remarks:
		* Every text block is an array of text and formatting tag.
		* Blocks don't have to span over whole line.

		Example:

		[
			["CAMP ROGAIN,","<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t>"],
			["RESSUPLY POINT","<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"],
			["10 MINUTES LATER ...","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"]

		] spawn BIS_fnc_typeText;
	*/

	#define DELAY_CHARACTER	0.06;
	#define DELAY_CURSOR	0.04;

	private["_random","_data","_posX","_posY","_rootFormat","_toDisplay"];
	private["_blocks","_block","_blockCount","_blockNr","_blockArray","_blockText","_blockTextF","_blockTextF_","_blockFormat","_formats","_inputData","_processedTextF","_char","_cursorInvis","_blinkCounts","_blinkCount"];

	_data 		= [_this, 0, [], [[]]] call BIS_fnc_param;
	_posX 		= [_this, 1, 0, [123]] call BIS_fnc_param;
	_posY 		= [_this, 2, 0, [123]] call BIS_fnc_param;
	_rootFormat 	= [_this, 3, "<t >%1</t>", [""]] call BIS_fnc_param;
	_random = 0.1;
	if ((count _this) > 4) then {_random = _this select 4};

	_blockCount = count _data;

	_invisCursor = "<t color ='#00000000' shadow = '0'>_</t>";

	//process the input data
	_blocks 	= [];
	_formats 	= [];
	_blinkCounts 	= [];

	{
		_inputData = _x;

		_block 		= [_inputData, 0, "", [""]] call BIS_fnc_param;
		_format 	= [_inputData, 1, "<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>", [""]] call BIS_fnc_param;
		_blinkCount 	= [_inputData, 2, 5, [123]] call BIS_fnc_param;

		//convert strings into array of chars
		_blockArray = toArray _block;
		{_blockArray set [_forEachIndex, toString [_x]]} forEach _blockArray;

		_blocks  = _blocks + [_blockArray];
		_formats = _formats + [_format];
		_blinkCounts = _blinkCounts + [_blinkCount];
	}
	forEach _data;

	//do the printing
	_processedTextF  = "";

	{
		_blockArray  = _x;
		_blockNr     = _forEachIndex;
		_blockFormat = _formats select _blockNr;
		_blockText   = "";
		_blockTextF  = "";
		_blockTextF_ = "";

		{
			_char = _x;

			_blockText = _blockText + _char;

			_blockTextF  = format[_blockFormat, _blockText + _invisCursor];
			_blockTextF_ = format[_blockFormat, _blockText + "_"];

			//print the output
			_toDisplay = format[_rootFormat,_processedTextF + _blockTextF_];
			[_toDisplay, _posX, _posY, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;

			playSound ["clickSoft2",true];//"ReadoutClick";

			uiSleep  (0.06 + (random _random));
			_toDisplay = format[_rootFormat,_processedTextF + _blockTextF];
			[_toDisplay, _posX, _posY, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
			uiSleep  DELAY_CURSOR;
		}
		forEach _blockArray;

		_blinkCount = _blinkCounts select _forEachIndex;

		if (_blinkCount > 0) then
		{
			for "_i" from 1 to _blinkCount do
			{
				_toDisplay = format[_rootFormat,_processedTextF + _blockTextF_];
				[_toDisplay, _posX, _posY, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
				uiSleep  (0.06 + (random _random));
				_toDisplay = format[_rootFormat,_processedTextF + _blockTextF];
				[_toDisplay, _posX, _posY, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
				uiSleep  DELAY_CURSOR;
			};
		};

		//store finished block
		_processedTextF  = _processedTextF + _blockTextF;
	}
	forEach _blocks;
	
	RYD_WS_Typed = true;
	
	sleep 5;

	//clean the screen
	["", _posX, _posY, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
	};
	