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
_txtMemP = _mainDisplay displayCtrl 310004;
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
////////