disableSerialization;
_mainDisplay = findDisplay 170404;
// Combo 		3000x
// Edit 		3100x
// Picture 		3200x
// Button 		3300x
// Checkboxes 	3400x
//////////////////////
// Combo 3000x
_lbPcolor = _mainDisplay displayCtrl 30001;
_lbPsize = _mainDisplay displayCtrl 30002;
_lbPObjExist = _mainDisplay displayCtrl 30003;
_lbExclude = _mainDisplay displayCtrl 30004;
_lbInclude = _mainDisplay displayCtrl 30005;
_lbArray = [_lbInclude,_lbExclude,_lbPObjExist,_lbPSize,_lbPcolor];
// Edit 3100x
_edPcolorRed = _mainDisplay displayCtrl 31001;
_edPcolorGreen = _mainDisplay displayCtrl 31002;
_edPcolorBlue = _mainDisplay displayCtrl 31003;
_edPcolorAlpha = _mainDisplay displayCtrl 31004;
_edpObjCfg = _mainDisplay displayCtrl 31005;
_edArray = [_edpObjCfg,_edPcolorAlpha,_edPcolorBlue,_edPcolorGreen,_edPcolorRed];
// Picture 3200x
_picColor = _mainDisplay displayCtrl 32001;
_picPreview11 = _mainDisplay displayCtrl 32002;
_picPreview169 = _mainDisplay displayCtrl 32003;
_picArray = [_picPreview169,_picPreview11,_picColor];
// Button 3300x
_btnColorEnter = _mainDisplay displayCtrl 33001;
_btnApply = _mainDisplay displayCtrl 33002;
_btnCancel = _mainDisplay displayCtrl 33003;
_btnReset = _mainDisplay displayCtrl 33004;
_btnArray = [_btnReset,_btnCancel,_btnApply,_btnColorEnter];
// Checkboxes 3400x
_cbObjExist = _mainDisplay displayCtrl 34001;
_cbObjCfg = _mainDisplay displayCtrl 34002;
_cbMemPDelete = _mainDisplay displayCtrl 34005;
_cbShowMemP = _mainDisplay displayCtrl 34006;
_cbSim = _mainDisplay displayCtrl 34007;
_cbCollision = _mainDisplay displayCtrl 34008;
_cbArray = [_cbCollision,_cbSim,_cbMemPDelete,_cbShowMemP,_cbObjCfg,_cbObjExist];

_allArray = [_lbArray,_edArray,_picArray,_btnArray,_cbArray];
///////////////////////////////////////////////////////////////////////////////////////////