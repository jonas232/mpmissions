_all = false;
_scriptCalled = false;
params ["_str", "_toFind", "_subsitution", "_all", "_scriptCalled"];
private _returnString = "";
_char = count _toFind;
_no = _str find _toFind;
if (_no == -1) then {_returnString = _str}
else 
{
	_splitStr = _str splitString "";
	_splitStr deleteRange [(_no +1), _char -1];
	_splitStr set [_no, _subsitution];
	_returnString = _splitStr joinString "";
};
_returnString