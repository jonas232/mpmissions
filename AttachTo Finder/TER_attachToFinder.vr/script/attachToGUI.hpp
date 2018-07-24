#define TESTCOMM "systemChat str _this"

class TER_attach
{
    idd = 170331; // 31.03.2017
    movingenable = false;
	OnLoad = "0 =  execVM 'script\onLoadAttach.sqf';";
	onUnload = "0 =  execVM 'script\onUnLoadAttach.sqf';"
   class ControlsBackground
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Terra, v1.063, #Woteno)
		////////////////////////////////////////////////////////

		class IGUIBack_2200: IGUIBack
		{
			idc = 310501;
			x = 0.696875 * safezoneW + safezoneX;
			y = 0.024 * safezoneH + safezoneY;
			w = 0.28875 * safezoneW;
			h = 0.952 * safezoneH;
		};
		class RscFrame_1800: RscFrame
		{
			idc = 1800;
			text = "AttachTo Finder"; //--- ToDo: Localize;
			x = 0.696875 * safezoneW + safezoneX;
			y = 0.024 * safezoneH + safezoneY;
			w = 0.28875 * safezoneW;
			h = 0.952 * safezoneH;
		};
		class RscText_1000: RscText
		{
			idc = 1000;
			text = "Position X:"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.122 * safezoneH + safezoneY;
			w = 0.13125 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1001: RscText
		{
			idc = 1001;
			text = "Position Y:"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.164 * safezoneH + safezoneY;
			w = 0.13125 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1002: RscText
		{
			idc = 1002;
			text = "Position Z:"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.206 * safezoneH + safezoneY;
			w = 0.13125 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscFrame_1801: RscFrame
		{
			idc = 1801;
			x = 0.703437 * safezoneW + safezoneX;
			y = 0.108 * safezoneH + safezoneY;
			w = 0.269062 * safezoneW;
			h = 0.182 * safezoneH;
		};
		class RscFrame_1802: RscFrame
		{
			idc = 1802;
			x = 0.703437 * safezoneW + safezoneX;
			y = 0.29 * safezoneH + safezoneY;
			w = 0.269062 * safezoneW;
			h = 0.182 * safezoneH;
		};
		class RscText_1003: RscText
		{
			idc = 1003;
			text = "Memory Point:"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.304 * safezoneH + safezoneY;
			w = 0.111562 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1005: RscText
		{
			idc = 1005;
			text = "Own memory point:"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.111562 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscFrame_1805: RscFrame
		{
			idc = 1805;
			x = 0.703437 * safezoneW + safezoneX;
			y = 0.052 * safezoneH + safezoneY;
			w = 0.269062 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class frameEdObj: RscFrame
		{
			idc = 1803;
			x = 0.703435 * safezoneW + safezoneX;
			y = 0.472 * safezoneH + safezoneY;
			w = 0.269062 * safezoneW;
			h = 0.182 * safezoneH;
		};
		class frameDir: RscFrame
		{
			idc = 1804;
			x = 0.703437 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.269062 * safezoneW;
			h = 0.182 * safezoneH;
		};
		class RscText_1004: RscText
		{
			idc = 1004;
			text = "Pointer:"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.486 * safezoneH + safezoneY;
			w = 0.0590625 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1006: RscText
		{
			idc = 1006;
			text = "X:"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.43 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1007: RscText
		{
			idc = 1007;
			text = "Y:"; //--- ToDo: Localize;
			x = 0.795313 * safezoneW + safezoneX;
			y = 0.43 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1008: RscText
		{
			idc = 1008;
			text = "Z:"; //--- ToDo: Localize;
			x = 0.880625 * safezoneW + safezoneX;
			y = 0.43 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1010: RscText
		{
			idc = 1010;
			text = "Object:"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.066 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1012: RscText
		{
			idc = 1012;
			text = "Vector Dir:"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.668 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1014: RscText
		{
			idc = 1014;
			text = "Vector Up:"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.752 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1013: RscText
		{
			idc = 1013;
			text = "getPitchBank:"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.794 * safezoneH + safezoneY;
			w = 0.124687 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1015: RscText
		{
			idc = 1015;
			text = "Degrees:"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.71 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1009: RscText
		{
			idc = 1009;
			text = "[X,Y,Z]:"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.248 * safezoneH + safezoneY;
			w = 0.0590625 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscFrame_1808: RscFrame
		{
			idc = 1806;
			text = "Display Control"; //--- ToDo: Localize;
			x = 0.0078125 * safezoneW + safezoneX;
			y = 0.024 * safezoneH + safezoneY;
			w = 0.675937 * safezoneW;
			h = 0.952 * safezoneH;
		};
	};
    class Controls
    {
		// Change Text
		class RscText_1017: RscText
		{
			idc = 310001;
			text = "Camera control active: NO"; //--- ToDo: Localize;
			x = 0.00781252 * safezoneW + safezoneX;
			y = 0.948 * safezoneH + safezoneY;
			w = 0.190312 * safezoneW;
			h = 0.028 * safezoneH;
			colorText[] = {1,0,0,1};
		};
		class stepsPosTxt: RscText
		{
			idc = 310002;
			text = "1"; //--- ToDo: Localize;
			x = 0.933125 * safezoneW + safezoneX;
			y = 0.122 * safezoneH + safezoneY;
			w = 0.0328125 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class exportTxt: RscStructuredText
		{
			idc = 310003;
			x = -100 * safezoneW + safezoneX;
			y = -100 * safezoneH + safezoneY;
			w = 0.4 * safezoneW;
			h = 0.91 * safezoneH;
		};
		class memPTxt: RscText
		{
			idc = 310004;
			x = 0.381875 * safezoneW + safezoneX;
			y = 0.948 * safezoneH + safezoneY;
			w = 0.295312 * safezoneW;
			h = 0.028 * safezoneH;
		};
		// Edits
		class PosXEd: RscEdit
		{
			idc = 310201;
			x = 0.8675 * safezoneW + safezoneX;
			y = 0.122 * safezoneH + safezoneY;
			w = 0.0590625 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseZChanged = "['mZx', _this] execVM 'script\guiEH.sqf'";
			onKeyDown = "if (_this select 1 == 28 OR _this select 1 == 156) then {['enterPos', _this] execVM 'script\guiEH.sqf'}";
		};
		class PosYEd: RscEdit
		{
			idc = 310202;
			x = 0.8675 * safezoneW + safezoneX;
			y = 0.164 * safezoneH + safezoneY;
			w = 0.0590625 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseZChanged = "['mZx', _this] execVM 'script\guiEH.sqf'";
			onKeyDown = "if (_this select 1 == 28 OR _this select 1 == 156) then {['enterPos', _this] execVM 'script\guiEH.sqf'}";
		};
		class PosZEd: RscEdit
		{
			idc = 310203;
			x = 0.8675 * safezoneW + safezoneX;
			y = 0.206 * safezoneH + safezoneY;
			w = 0.0590625 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseZChanged = "['mZx', _this] execVM 'script\guiEH.sqf'";
			onKeyDown = "if (_this select 1 == 28 OR _this select 1 == 156) then {['enterPos', _this] execVM 'script\guiEH.sqf'}";
		};
		class PosXYZED: RscEdit
		{
			idc = 310204;
			x = 0.769063 * safezoneW + safezoneX;
			y = 0.248 * safezoneH + safezoneY;
			w = 0.196875 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class ownMemPointEd: RscEdit
		{
			idc = 310205;
			x = 0.828125 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.137812 * safezoneW;
			h = 0.028 * safezoneH;
			onChar = "['charMem', _this] execVM 'script\guiEH.sqf'";
		};
		class memPosXEd: RscEdit
		{
			idc = 310206;
			x = 0.729688 * safezoneW + safezoneX;
			y = 0.43 * safezoneH + safezoneY;
			w = 0.0590625 * safezoneW;
			h = 0.028 * safezoneH;
			onKeyDown = "if (_this select 1 == 28 OR _this select 1 == 156) then {['enterMem', _this] execVM 'script\guiEH.sqf'}";
		};
		class memPosYEd: RscEdit
		{
			idc = 310207;
			x = 0.815 * safezoneW + safezoneX;
			y = 0.43 * safezoneH + safezoneY;
			w = 0.0590625 * safezoneW;
			h = 0.028 * safezoneH;
			onKeyDown = "if (_this select 1 == 28 OR _this select 1 == 156) then {['enterMem', _this] execVM 'script\guiEH.sqf'}";
		};
		class memPosZEd: RscEdit
		{
			idc = 310208;
			x = 0.906875 * safezoneW + safezoneX;
			y = 0.43 * safezoneH + safezoneY;
			w = 0.0590625 * safezoneW;
			h = 0.028 * safezoneH;
			onKeyDown = "if (_this select 1 == 28 OR _this select 1 == 156) then {['enterMem', _this] execVM 'script\guiEH.sqf'}";
		};
		class degreesEd: RscEdit
		{
			idc = 310211;
			x = 0.795313 * safezoneW + safezoneX;
			y = 0.71 * safezoneH + safezoneY;
			w = 0.118125 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseZChanged = "['edVec', _this] execVM 'script\guiEH.sqf'";
		};
		// START 03042017 1540
		class vectorDirXEd: RscEdit
		{
			idc = 310212;
			text = "0.999"; //--- ToDo: Localize;
			x = 0.795313 * safezoneW + safezoneX;
			y = 0.668 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseZChanged = "['edVec', _this] execVM 'script\guiEH.sqf'";
		};
		class vectorDirYEd: RscEdit
		{
			idc = 310213;
			text = "0.999"; //--- ToDo: Localize;
			x = 0.834688 * safezoneW + safezoneX;
			y = 0.668 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseZChanged = "['edVec', _this] execVM 'script\guiEH.sqf'";
		};
		class vectorDirZEd: RscEdit
		{
			idc = 310214;
			text = "0.999"; //--- ToDo: Localize;
			x = 0.874063 * safezoneW + safezoneX;
			y = 0.668 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseZChanged = "['edVec', _this] execVM 'script\guiEH.sqf'";
		};
		class vecUpXEd: RscEdit
		{
			idc = 310215;
			text = "0.999"; //--- ToDo: Localize;
			x = 0.795313 * safezoneW + safezoneX;
			y = 0.752 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseZChanged = "['edVec', _this] execVM 'script\guiEH.sqf'";
		};
		class vecUpYEd: RscEdit
		{
			idc = 310216;
			text = "0.999"; //--- ToDo: Localize;
			x = 0.834688 * safezoneW + safezoneX;
			y = 0.752 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseZChanged = "['edVec', _this] execVM 'script\guiEH.sqf'";
		};
		class vecUpZEd: RscEdit
		{
			idc = 310217;
			text = "0.999"; //--- ToDo: Localize;
			x = 0.874063 * safezoneW + safezoneX;
			y = 0.752 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseZChanged = "['edVec', _this] execVM 'script\guiEH.sqf'";
		};
		class pitchBankPEd: RscEdit
		{
			idc = 310218;
			x = 0.795313 * safezoneW + safezoneX;
			y = 0.794 * safezoneH + safezoneY;
			w = 0.0590625 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseZChanged = "['edVec', _this] execVM 'script\guiEH.sqf'";
		};
		class pitchBankBEd: RscEdit
		{
			idc = 310219;
			x = 0.854375 * safezoneW + safezoneX;
			y = 0.794 * safezoneH + safezoneY;
			w = 0.0590625 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseZChanged = "['edVec', _this] execVM 'script\guiEH.sqf'";
		};
		// Combos
		class objCombo: RscCombo
		{
			idc = 310101;
			x = 0.755937 * safezoneW + safezoneX;
			y = 0.066 * safezoneH + safezoneY;
			w = 0.13125 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class deleteObjCombo: RscCombo
		{
			idc = 310103;
			x = 0.834688 * safezoneW + safezoneX;
			y = 0.612 * safezoneH + safezoneY;
			w = 0.13125 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class stepsPosCombo: RscCombo
		{
			idc = 310104;
			x = 0.933125 * safezoneW + safezoneX;
			y = 0.164 * safezoneH + safezoneY;
			w = 0.0328125 * safezoneW;
			h = 0.028 * safezoneH;
			onLBSelChanged = "['posmp', _this] execVM 'script\guiEH.sqf'";
		};
		// Checkboxes
		class pointerCB: RscCheckbox
		{
			idc = 310301;
			x = 0.828125 * safezoneW + safezoneX;
			y = 0.486 * safezoneH + safezoneY;
			w = 0.0196875 * safezoneW;
			h = 0.028 * safezoneH;
			onCheckedChanged = "['pointer', _this] execVM 'script\guiEH.sqf'";
		};
/*		class cfgNameCB: RscCheckbox
		{
			idc = 310302;
			x = 0.828125 * safezoneW + safezoneX;
			y = 0.556 * safezoneH + safezoneY;
			w = 0.0196875 * safezoneW;
			h = 0.028 * safezoneH;
		};
*/		// Buttons
		class objBtn: RscButton
		{
			idc = 310401;
			text = "Enter"; //--- ToDo: Localize;
			x = 0.900313 * safezoneW + safezoneX;
			y = 0.066 * safezoneH + safezoneY;
			w = 0.065625 * safezoneW;
			h = 0.028 * safezoneH;
			action = "['btnObj', _this] execVM 'script\guiEH.sqf'";
		};
		class ownMemPointBtn: RscButton
		{
			idc = 310402;
			text = "Enter"; //--- ToDo: Localize;
			x = 0.828125 * safezoneW + safezoneX;
			y = 0.388 * safezoneH + safezoneY;
			w = 0.137812 * safezoneW;
			h = 0.028 * safezoneH;
			action = "['memPAct', _this] execVM 'script\guiEH.sqf'";
		};
/*		class attachBtn: RscButton
		{
			idc = 310403;
			text = "Attach Object:"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.528 * safezoneH + safezoneY;
			w = 0.0984375 * safezoneW;
			h = 0.028 * safezoneH;
			action = "['ownAtt', _this] execVM 'script\guiEH.sqf'";
		};
*/		class attObjBtn: RscButton
		{
			idc = 310403;
			text = "Attach nearest object"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.528 * safezoneH + safezoneY;
			w = 0.255937 * safezoneW;
			h = 0.028 * safezoneH;
			action = "['nearAtt',_this] execVM 'script\guiEH.sqf'";
		};
		class deleteObjBtn: RscButton
		{
			idc = 310404;
			text = "Delete Object:"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.612 * safezoneH + safezoneY;
			w = 0.0984375 * safezoneW;
			h = 0.028 * safezoneH;
			action = "['deleteObj',_this] execVM 'script\guiEH.sqf'";
		};
/*		class deleteBtn: RscButton
		{
			idc = 310404;
			text = "Delete Object:"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.598 * safezoneH + safezoneY;
			w = 0.0984375 * safezoneW;
			h = 0.028 * safezoneH;
			
		};
*/		
		
		class exportBtn: RscButton
		{
			idc = 310405;
			text = "Export commands"; //--- ToDo: Localize;
			x = 0.703437 * safezoneW + safezoneX;
			y = 0.892 * safezoneH + safezoneY;
			w = 0.275625 * safezoneW;
			h = 0.028 * safezoneH;
			action = "['export',_this] execVM 'script\guiEH.sqf'";
		};
		class infoBtn: RscButton
		{
			idc = 310406;
			text = "Credits"; //--- ToDo: Localize;
			x = 0.703437 * safezoneW + safezoneX;
			y = 0.934 * safezoneH + safezoneY;
			w = 0.275625 * safezoneW;
			h = 0.028 * safezoneH;
			action = "createDialog 'TER_credits'";
		};
		class createObjBtn: RscButton
		{
			idc = 310421;
			text = "Create Object"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.57 * safezoneH + safezoneY;
			w = 0.255937 * safezoneW;
			h = 0.028 * safezoneH;
			action = "['create',_this] execVM 'script\guiEH.sqf'";
		};
		class dirEnterBtn: RscButton
		{
			idc = 310422;
			text = "Enter"; //--- ToDo: Localize;
			x = 0.92 * safezoneW + safezoneX;
			y = 0.668 * safezoneH + safezoneY;
			w = 0.0459375 * safezoneW;
			h = 0.028 * safezoneH;
			action = "['dirEnter',_this] execVM 'script\guiEH.sqf'";
		};
		class dirResetBtn: RscButton
		{
			idc = 310423;
			text = "Reset"; //--- ToDo: Localize;
			x = 0.92 * safezoneW + safezoneX;
			y = 0.71 * safezoneH + safezoneY;
			w = 0.0459375 * safezoneW;
			h = 0.028 * safezoneH;
			action = "['dirReset',_this] execVM 'script\guiEH.sqf'";
		};
		// ButtonInv
		class dispCtrlBtn: RscButtonInv
		{
			idc = 310407;
			text = "Display Control"; //--- ToDo: Localize;
			x = 0.0078125 * safezoneW + safezoneX;
			y = 0.024 * safezoneH + safezoneY;
			w = 0.675937 * safezoneW;
			h = 0.952 * safezoneH;
			colorBackground[] = {0,0,0,0};
			onKeyDown = "['keyMove', _this] execVM 'script\guiEH.sqf'";
			onSetFocus = "['select', _this] execVM 'script\guiEH.sqf'";
			onKillFocus = "['unselect', _this] execVM 'script\guiEH.sqf'";
		};
		class detachPointerBtn: RscButton
		{
			idc = 310408;
			text = "Detach"; //--- ToDo: Localize;
			x = 0.8675 * safezoneW + safezoneX;
			y = 0.486 * safezoneH + safezoneY;
			w = 0.091875 * safezoneW;
			h = 0.028 * safezoneH;
			action = "['detachPointer', _this] execVM 'script\guiEH.sqf'"
		};
		class plusXBtn: RscButton
		{
			idc = 310409;
			text = "+"; //--- ToDo: Localize;
			x = 0.775625 * safezoneW + safezoneX;
			y = 0.122 * safezoneH + safezoneY;
			w = 0.0196875 * safezoneW;
			h = 0.028 * safezoneH;
			action = "['+X', _this] execVM 'script\guiEH.sqf'";
		};
		class minusXBtn: RscButton
		{
			idc = 310410;
			text = "-"; //--- ToDo: Localize;
			x = 0.801875 * safezoneW + safezoneX;
			y = 0.122 * safezoneH + safezoneY;
			w = 0.0196875 * safezoneW;
			h = 0.028 * safezoneH;
			action = "['-X', _this] execVM 'script\guiEH.sqf'";
		};
		class RscButton_1605: RscButton
		{
			idc = 310411;
			text = "Enter"; //--- ToDo: Localize;
			x = 0.828125 * safezoneW + safezoneX;
			y = 0.122 * safezoneH + safezoneY;
			w = 0.0328125 * safezoneW;
			h = 0.112 * safezoneH;
			action = "['enterPos', _this] execVM 'script\guiEH.sqf'";
		};
		class plusYBtn: RscButton
		{
			idc = 310412;
			text = "+"; //--- ToDo: Localize;
			x = 0.775625 * safezoneW + safezoneX;
			y = 0.164 * safezoneH + safezoneY;
			w = 0.0196875 * safezoneW;
			h = 0.028 * safezoneH;
			action = "['+Y', _this] execVM 'script\guiEH.sqf'";
		};
		class minusYBtn: RscButton
		{
			idc = 310413;
			text = "-"; //--- ToDo: Localize;
			x = 0.801875 * safezoneW + safezoneX;
			y = 0.164 * safezoneH + safezoneY;
			w = 0.0196875 * safezoneW;
			h = 0.028 * safezoneH;
			action = "['-Y', _this] execVM 'script\guiEH.sqf'";
		};
		class plusZBtn: RscButton
		{
			idc = 310414;
			text = "+"; //--- ToDo: Localize;
			x = 0.775625 * safezoneW + safezoneX;
			y = 0.206 * safezoneH + safezoneY;
			w = 0.0196875 * safezoneW;
			h = 0.028 * safezoneH;
			action = "['+Z', _this] execVM 'script\guiEH.sqf'";
		};
		class minusZBtn: RscButton
		{
			idc = 310415;
			text = "-"; //--- ToDo: Localize;
			x = 0.801875 * safezoneW + safezoneX;
			y = 0.206 * safezoneH + safezoneY;
			w = 0.0196875 * safezoneW;
			h = 0.028 * safezoneH;
			action = "['-Z', _this] execVM 'script\guiEH.sqf'";
		};
		class memPointBtn: RscButton
		{
			idc = 310416;
			text = "None";
			x = 0.828125 * safezoneW + safezoneX;
			y = 0.304 * safezoneH + safezoneY;
			w = 0.137812 * safezoneW;
			h = 0.028 * safezoneH;
			action = "createDialog 'TER_mem'";
		};
		////// 1925
/*		class stepsPosXBtn: RscButton
		{
			idc = 310417;
			text = "0.001"; //--- ToDo: Localize;
			x = 0.926562 * safezoneW + safezoneX;
			y = 0.122 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseButtonDown = "['posmp', _this] execVM 'script\guiEH.sqf'";
		};
		class stepsPosYBtn: RscButton
		{
			idc = 310418;
			text = "0.001"; //--- ToDo: Localize;
			x = 0.926563 * safezoneW + safezoneX;
			y = 0.164 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseButtonDown = "['posmp', _this] execVM 'script\guiEH.sqf'";
		};
		class stepsPosZBtn: RscButton
		{
			idc = 310419;
			text = "0.001"; //--- ToDo: Localize;
			x = 0.926563 * safezoneW + safezoneX;
			y = 0.206 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseButtonDown = "['posmp', _this] execVM 'script\guiEH.sqf'";
		};
*/		
		
		class advSettingsBtn: RscButton
		{
			idc = 310420;
			text = "Advanced Settings"; //--- ToDo: Localize;
			x = 0.703437 * safezoneW + safezoneX;
			y = 0.85 * safezoneH + safezoneY;
			w = 0.275625 * safezoneW;
			h = 0.028 * safezoneH;
			action = "createDialog 'TER_settings'";
		};
    };
};

/* #Bizyfy
$[
	1.063,
	["TER_attach",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"",[1,"",["0.696875 * safezoneW + safezoneX","0.024 * safezoneH + safezoneY","0.28875 * safezoneW","0.952 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[0,"",[0,"#(argb,8,8,3)color(1,1,1,1)",[-1,-1,0,0],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1,"",[0,"#(argb,8,8,3)color(1,1,1,1)",[-1,-1,0,0],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"",[1,"AttachTo Finder",["0.696875 * safezoneW + safezoneX","0.024 * safezoneH + safezoneY","0.28875 * safezoneW","0.952 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"",[1,"Position X:",["0.71 * safezoneW + safezoneX","0.122 * safezoneH + safezoneY","0.13125 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"",[1,"Position Y:",["0.71 * safezoneW + safezoneX","0.164 * safezoneH + safezoneY","0.13125 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"",[1,"Position Z:",["0.71 * safezoneW + safezoneX","0.206 * safezoneH + safezoneY","0.13125 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"",[1,"",["0.8675 * safezoneW + safezoneX","0.122 * safezoneH + safezoneY","0.0590625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1401,"",[1,"",["0.8675 * safezoneW + safezoneX","0.164 * safezoneH + safezoneY","0.0590625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1402,"",[1,"",["0.8675 * safezoneW + safezoneX","0.206 * safezoneH + safezoneY","0.0590625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1801,"",[1,"",["0.703437 * safezoneW + safezoneX","0.108 * safezoneH + safezoneY","0.269062 * safezoneW","0.182 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1802,"",[1,"",["0.703437 * safezoneW + safezoneX","0.29 * safezoneH + safezoneY","0.269062 * safezoneW","0.182 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2100,"",[1,"",["0.828125 * safezoneW + safezoneX","0.304 * safezoneH + safezoneY","0.137812 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"",[1,"Memory Point:",["0.71 * safezoneW + safezoneX","0.304 * safezoneH + safezoneY","0.111562 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1005,"",[1,"Own memory point:",["0.71 * safezoneW + safezoneX","0.346 * safezoneH + safezoneY","0.111562 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1403,"",[1,"",["0.828125 * safezoneW + safezoneX","0.346 * safezoneH + safezoneY","0.137812 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[1,"Enter",["0.828125 * safezoneW + safezoneX","0.388 * safezoneH + safezoneY","0.137812 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1803,"",[1,"",["0.703436 * safezoneW + safezoneX","0.472 * safezoneH + safezoneY","0.269062 * safezoneW","0.168 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1804,"",[1,"",["0.703436 * safezoneW + safezoneX","0.64 * safezoneH + safezoneY","0.269062 * safezoneW","0.182 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1805,"",[1,"",["0.703437 * safezoneW + safezoneX","0.052 * safezoneH + safezoneY","0.269062 * safezoneW","0.056 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1004,"",[1,"Pointer:",["0.71 * safezoneW + safezoneX","0.486 * safezoneH + safezoneY","0.0590625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2800,"",[1,"",["0.828125 * safezoneW + safezoneX","0.486 * safezoneH + safezoneY","0.0196875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1006,"",[1,"X:",["0.71 * safezoneW + safezoneX","0.43 * safezoneH + safezoneY","0.02625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1007,"",[1,"Y:",["0.795313 * safezoneW + safezoneX","0.43 * safezoneH + safezoneY","0.02625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1008,"",[1,"Z:",["0.880625 * safezoneW + safezoneX","0.43 * safezoneH + safezoneY","0.02625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1404,"",[1,"",["0.729688 * safezoneW + safezoneX","0.43 * safezoneH + safezoneY","0.0590625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1405,"",[1,"",["0.815 * safezoneW + safezoneX","0.43 * safezoneH + safezoneY","0.0590625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1406,"",[1,"",["0.906875 * safezoneW + safezoneX","0.43 * safezoneH + safezoneY","0.0590625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1009,"",[1,"[X,Y,Z]:",["0.71 * safezoneW + safezoneX","0.248 * safezoneH + safezoneY","0.0590625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1407,"",[1,"",["0.769063 * safezoneW + safezoneX","0.248 * safezoneH + safezoneY","0.196875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1010,"",[1,"Object:",["0.71 * safezoneW + safezoneX","0.066 * safezoneH + safezoneY","0.0721875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"",[1,"Enter",["0.900313 * safezoneW + safezoneX","0.066 * safezoneH + safezoneY","0.065625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1806,"",[1,"Display Control",["0.0078125 * safezoneW + safezoneX","0.024 * safezoneH + safezoneY","0.675937 * safezoneW","0.952 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"",[1,"Attach Object:",["0.71 * safezoneW + safezoneX","0.528 * safezoneH + safezoneY","0.0984375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1409,"",[1,"",["0.828125 * safezoneW + safezoneX","0.528 * safezoneH + safezoneY","0.13125 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2801,"",[1,"",["0.828125 * safezoneW + safezoneX","0.556 * safezoneH + safezoneY","0.0196875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1011,"",[1,"Config Name",["0.847812 * safezoneW + safezoneX","0.556 * safezoneH + safezoneY","0.07875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2101,"",[1,"",["0.828125 * safezoneW + safezoneX","0.598 * safezoneH + safezoneY","0.13125 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1603,"",[1,"Delete Object:",["0.71 * safezoneW + safezoneX","0.598 * safezoneH + safezoneY","0.0984375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2102,"",[1,"",["0.755937 * safezoneW + safezoneX","0.066 * safezoneH + safezoneY","0.13125 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1012,"",[1,"Vector Dir:",["0.71 * safezoneW + safezoneX","0.654 * safezoneH + safezoneY","0.0721875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1014,"",[1,"Vector Up:",["0.71 * safezoneW + safezoneX","0.738 * safezoneH + safezoneY","0.0721875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1408,"",[1,"",["0.834688 * safezoneW + safezoneX","0.654 * safezoneH + safezoneY","0.124687 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1410,"",[1,"",["0.834688 * safezoneW + safezoneX","0.696 * safezoneH + safezoneY","0.124687 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1411,"",[1,"",["0.834688 * safezoneW + safezoneX","0.738 * safezoneH + safezoneY","0.124687 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1412,"",[1,"",["0.834688 * safezoneW + safezoneX","0.78 * safezoneH + safezoneY","0.124687 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1013,"",[1,"BIS_fnc_getPitchBank:",["0.71 * safezoneW + safezoneX","0.78 * safezoneH + safezoneY","0.124687 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1015,"",[1,"Degrees:",["0.71 * safezoneW + safezoneX","0.696 * safezoneH + safezoneY","0.0721875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1604,"",[1,"Additional information",["0.703437 * safezoneW + safezoneX","0.934 * safezoneH + safezoneY","0.275625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1017,"",[1,"Camera control active: NO",["0.00781252 * safezoneW + safezoneX","0.948 * safezoneH + safezoneY","0.190312 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1608,"",[1,"Export commands",["0.703437 * safezoneW + safezoneX","0.892 * safezoneH + safezoneY","0.275625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1609,"",[1,"Detach",["0.8675 * safezoneW + safezoneX","0.486 * safezoneH + safezoneY","0.091875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1605,"",[1,"Enter",["0.828125 * safezoneW + safezoneX","0.122 * safezoneH + safezoneY","0.0328125 * safezoneW","0.112 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1606,"",[1,"+",["0.775625 * safezoneW + safezoneX","0.122 * safezoneH + safezoneY","0.0196875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1607,"",[1,"-",["0.801875 * safezoneW + safezoneX","0.122 * safezoneH + safezoneY","0.0196875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1610,"",[1,"+",["0.775625 * safezoneW + safezoneX","0.164 * safezoneH + safezoneY","0.0196875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1611,"",[1,"+",["0.775625 * safezoneW + safezoneX","0.206 * safezoneH + safezoneY","0.0196875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1612,"",[1,"-",["0.801875 * safezoneW + safezoneX","0.164 * safezoneH + safezoneY","0.0196875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1613,"",[1,"-",["0.801875 * safezoneW + safezoneX","0.206 * safezoneH + safezoneY","0.0196875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1016,"",[1,"0.001",["0.926562 * safezoneW + safezoneX","0.122 * safezoneH + safezoneY","0.039375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1018,"",[1,"0.001",["0.926563 * safezoneW + safezoneX","0.164 * safezoneH + safezoneY","0.039375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1019,"",[1,"0.001",["0.926563 * safezoneW + safezoneX","0.206 * safezoneH + safezoneY","0.039375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[1,"Advanced Settings",["0.703437 * safezoneW + safezoneX","0.85 * safezoneH + safezoneY","0.275625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
/*
$[
	1.063,
	["TER_attach",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1603,"",[1,"Delete Object:",["0.71 * safezoneW + safezoneX","0.598 * safezoneH + safezoneY","0.0984375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"",[1,"Attach Object:",["0.71 * safezoneW + safezoneX","0.528 * safezoneH + safezoneY","0.0984375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
