disableSerialization;
_mainDisplay = findDisplay 170331;
//// Controls:
// Text:		31000x
// LB: 			31010x
// Edit:		31020x
// CB:			31030x
// Button:		31040x
// Background: 	31050x
// Slider: 		31060x
// Tree:		31070x
// Active Text:	31080x
//////////////////////
// Text:		31000x
_txtCamCtrl = _mainDisplay displayCtrl 310001;
_txtSteps = _mainDisplay displayCtrl 310002;
_txtExport = _mainDisplay displayCtrl 310003;
// LB: 			31010x
_lbObj = _mainDisplay displayCtrl 310101;
_lbDeleteObj = _mainDisplay displayCtrl 310103;
_lbSteps = _mainDisplay displayCtrl 310104;
_lbArray = [_lbSteps,_lbObj,_lbDeleteObj];
// Edit:		31020x
_edPosX = _mainDisplay displayCtrl 310201;
_edPosY = _mainDisplay displayCtrl 310202;
_edPosZ = _mainDisplay displayCtrl 310203;
_edPosArr = _mainDisplay displayCtrl 310204;
_edOwnMemP = _mainDisplay displayCtrl 310205;
_edmemX = _mainDisplay displayCtrl 310206;
_edmemY = _mainDisplay displayCtrl 310207;
_edmemZ = _mainDisplay displayCtrl 310208;
_edAttObj = _mainDisplay displayCtrl 310209;
_edDegrees = _mainDisplay displayCtrl 310211;
_edVecDirX = _mainDisplay displayCtrl 310212;
_edVecDirY = _mainDisplay displayCtrl 310213;
_edVecDirZ = _mainDisplay displayCtrl 310214;
_edVecUpX = _mainDisplay displayCtrl 310215;
_edVecUpY = _mainDisplay displayCtrl 310216;
_edVecUpZ = _mainDisplay displayCtrl 310217;
_edPitchBankP = _mainDisplay displayCtrl 310218;
_edPitchBankB = _mainDisplay displayCtrl 310219;

_edArray = [_edPitchBankB,_edPitchBankP,_edVecUpZ,_edVecUpY,_edVecUpX,_edVecDirZ,_edVecDirY,_edVecDirX,_edPosX, _edPosY, _edPosZ, _edPosArr, _edOwnMemP, _edmemX, _edmemY, _edmemZ, _edAttObj, _edDegrees];
// CB:			31030x
_cbPointer = _mainDisplay displayCtrl 310301;
_cbArray = [_cbPointer];
// Button:		31040x
_btnObjEnter = _mainDisplay displayCtrl 310401;
_btnMemEnter = _mainDisplay displayCtrl 310402;
_btnAttach = _mainDisplay displayCtrl 310403;
_btnDelete = _mainDisplay displayCtrl 310404;
_btnExport = _mainDisplay displayCtrl 310405;
_btnInfo = _mainDisplay displayCtrl 310406;
_btnInv = _mainDisplay displayCtrl 310407;
_btnPointer = _mainDisplay displayCtrl 310408;
_btnPlusX = _mainDisplay displayCtrl 310409;
_btnMinusX = _mainDisplay displayCtrl 310410;
_btnEnterPos = _mainDisplay displayCtrl 310411;
_btnPlusY = _mainDisplay displayCtrl 310412;
_btnMinusY = _mainDisplay displayCtrl 310413;
_btnPlusZ = _mainDisplay displayCtrl 310414;
_btnMinusZ = _mainDisplay displayCtrl 310415;
_btnMemP = _mainDisplay displayCtrl 310416;
_btnSettings = _mainDisplay displayCtrl 310420; // Blaze it
_btnCreate = _mainDisplay displayCtrl 310421;
_btnDirEnter = _mainDisplay displayCtrl 310422;
_btnDirReset = _mainDisplay displayCtrl 310423;
_btnArray = [_btnDirReset,_btnDirEnter,_btnCreate,_btnObjEnter,_btnMemEnter,_btnAttach,_btnDelete,_btnExport,_btnInfo,_btnInv,_btnPointer,_btnPlusX,_btnMinusX,_btnEnterPos,_btnPlusY,_btnMinusY,_btnPlusZ,_btnMinusZ,_btnMemP,_btnSettings];
// Background 31050x
_bBack = _mainDisplay displayCtrl 310501;
// All arrays
_supArray = [_lbArray,_edArray,_cbArray,_btnArray];
////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////
// 											Dialog 													//
//////////////////////////////////////////////////////////////////////////////////////////////////////
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
	[1803,"frameEdObj",[1,"",["0.703435 * safezoneW + safezoneX","0.472 * safezoneH + safezoneY","0.269062 * safezoneW","0.182 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1804,"frameDir",[1,"",["0.703437 * safezoneW + safezoneX","0.654 * safezoneH + safezoneY","0.269062 * safezoneW","0.182 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
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
	[1602,"attObjBtn",[1,"Attach nearest Object",["0.71 * safezoneW + safezoneX","0.528 * safezoneH + safezoneY","0.255937 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1409,"",[1,"",["0.828125 * safezoneW + safezoneX","0.528 * safezoneH + safezoneY","0.13125 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2801,"",[1,"",["0.828125 * safezoneW + safezoneX","0.556 * safezoneH + safezoneY","0.0196875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1011,"",[1,"Config Name",["0.847812 * safezoneW + safezoneX","0.556 * safezoneH + safezoneY","0.07875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2101,"deleteObjEd",[1,"",["0.834688 * safezoneW + safezoneX","0.612 * safezoneH + safezoneY","0.13125 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1603,"deleteObjBtn",[1,"Delete Object:",["0.71 * safezoneW + safezoneX","0.612 * safezoneH + safezoneY","0.0984375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2102,"",[1,"",["0.755937 * safezoneW + safezoneX","0.066 * safezoneH + safezoneY","0.13125 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1012,"",[1,"Vector Dir:",["0.71 * safezoneW + safezoneX","0.668 * safezoneH + safezoneY","0.0721875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1014,"",[1,"Vector Up:",["0.71 * safezoneW + safezoneX","0.752 * safezoneH + safezoneY","0.0721875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1410,"degreesEd",[1,"",["0.795313 * safezoneW + safezoneX","0.71 * safezoneH + safezoneY","0.118125 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1013,"",[1,"getPitchBank:",["0.71 * safezoneW + safezoneX","0.794 * safezoneH + safezoneY","0.124687 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1015,"",[1,"Degrees:",["0.71 * safezoneW + safezoneX","0.71 * safezoneH + safezoneY","0.0721875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
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
	[1614,"",[1,"Advanced Settings",["0.703437 * safezoneW + safezoneX","0.85 * safezoneH + safezoneY","0.275625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1615,"createObjBtn",[1,"Create Object",["0.71 * safezoneW + safezoneX","0.57 * safezoneH + safezoneY","0.255937 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1616,"dirEnterBtn",[1,"Enter",["0.92 * safezoneW + safezoneX","0.668 * safezoneH + safezoneY","0.0459375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"",[1,"",["0.8675 * safezoneW + safezoneX","0.122 * safezoneH + safezoneY","0.0590625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1016,"",[1,"0.001",["0.926562 * safezoneW + safezoneX","0.122 * safezoneH + safezoneY","0.039375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1408,"vectorDirXEd",[1,"0.999",["0.795313 * safezoneW + safezoneX","0.668 * safezoneH + safezoneY","0.039375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"vectorDirYEd",[1,"0.999",["0.834688 * safezoneW + safezoneX","0.668 * safezoneH + safezoneY","0.039375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1401,"vectorDirZEd",[1,"0.999",["0.874063 * safezoneW + safezoneX","0.668 * safezoneH + safezoneY","0.039375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1402,"vecUpXEd",[1,"0.999",["0.795313 * safezoneW + safezoneX","0.752 * safezoneH + safezoneY","0.039375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1403,"vecUpYEd",[1,"0.999",["0.834688 * safezoneW + safezoneX","0.752 * safezoneH + safezoneY","0.039375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1404,"vecUpZEd",[1,"0.999",["0.874063 * safezoneW + safezoneX","0.752 * safezoneH + safezoneY","0.039375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1411,"pitchBankPEd",[1,"",["0.795313 * safezoneW + safezoneX","0.794 * safezoneH + safezoneY","0.0590625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1405,"pitchBankBEd",[1,"",["0.854375 * safezoneW + safezoneX","0.794 * safezoneH + safezoneY","0.0590625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1617,"dirResetBtn",[1,"Reset",["0.92 * safezoneW + safezoneX","0.71 * safezoneH + safezoneY","0.0459375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"exportTxt",[1,"",["0.276874 * safezoneW + safezoneX","0.0660001 * safezoneH + safezoneY","0.400312 * safezoneW","0.896 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
	[1018,"memPTxt",[1,"Nearest memory point:",["0.381875 * safezoneW + safezoneX","0.948 * safezoneH + safezoneY","0.295312 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]

$[
	1.063,
	["TER_attach",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1100,"exportTxt",[1,"",["0.276874 * safezoneW + safezoneX","0.0660001 * safezoneH + safezoneY","0.400312 * safezoneW","0.896 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
/* #Wyfute
$[
	1.063,
	["TER_attach",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1100,"exportTxt",[1,"",["0.276874 * safezoneW + safezoneX","0.0660001 * safezoneH + safezoneY","0.400312 * safezoneW","0.896 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Terra, v1.063, #Wyfute)
////////////////////////////////////////////////////////

class exportTxt: RscStructuredText
{
	idc = 1100;
	x = 0.276874 * safezoneW + safezoneX;
	y = 0.0660001 * safezoneH + safezoneY;
	w = 0.400312 * safezoneW;
	h = 0.896 * safezoneH;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
