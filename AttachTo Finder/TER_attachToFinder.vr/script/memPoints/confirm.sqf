#include "ctrlMemP.sqf"

__mainDisplay = findDisplay 170331;
__btnMemP = __mainDisplay displayCtrl 310416;

_notAllowed = ["","People","Vehicles","Cars","Tanks","Helicopter","Planes","No selection points found"];
_selSearch = _trSearch tvText (tvCurSel _trSearch);
_selMemP = _trMemP tvText (tvCurSel _trMemP);
private _retText = "";
if (_selSearch != "" && !(_selSearch in _notAllowed)) then {
	_retText = _selSearch;
} else {
	_selSearch = "None";
	_retText = _selMemP;
};
if (_retText in _notAllowed) then {_retText = "None"};
__btnMemP ctrlSetText _retText;
closeDialog 0;
caseMem = false;
closeDialog 0;

