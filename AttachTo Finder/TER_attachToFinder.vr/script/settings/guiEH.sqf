#include "..\settings\ctrlSettings.sqf"

_case = _this select 0;
_ehParams = _this select 1;
switch (_case) do 
{
	case "colorLB": 
	{
		_sel = _ehParams select 1;
		if (_lbPcolor lbText _sel == "Don't change") exitWith 
		{
			{_x ctrlSetText "-1"} forEach [_edPcolorRed,_edPcolorGreen,_edPcolorBlue,_edPcolorAlpha];
		};
		_color = _lbPcolor lbColor (_ehParams select 1);
		_edPcolorRed ctrlSetText str ([_color select 0, 2] call BIS_fnc_cutDecimals);
		_edPcolorGreen ctrlSetText str ([_color select 1, 2] call BIS_fnc_cutDecimals);
		_edPcolorBlue ctrlSetText str ([_color select 2, 2] call BIS_fnc_cutDecimals);
		_edPcolorAlpha ctrlSetText str ([_color select 3, 2] call BIS_fnc_cutDecimals);
		_red = parseNumber ctrlText _edPcolorRed;
		_green = parseNumber ctrlText _edPcolorGreen;
		_blue = parseNumber ctrlText _edPcolorBlue; 
		_alpha = parseNumber ctrlText _edPcolorAlpha;
		_picColor ctrlSetBackgroundColor [_red,_green,_blue,_alpha];
	};
	case "mZColor":
	{
		_ctrl = _ehParams select 0;
		_change = round (_ehParams select 1);
		_lbPcolor lbSetCurSel (lbsize _lbPcolor -1);
		_ctrl ctrlSetText str ((parseNumber ctrlText _ctrl) +_change *0.01);
		
		if (parseNumber ctrlText _ctrl > 1) then {_ctrl ctrlSetText "1"};
		if (parseNumber ctrlText _ctrl < 0) then {_ctrl ctrlSetText "0"};
		_red = parseNumber ctrlText _edPcolorRed;
		_green = parseNumber ctrlText _edPcolorGreen;
		_blue = parseNumber ctrlText _edPcolorBlue; 
		_alpha = parseNumber ctrlText _edPcolorAlpha;
		_newcolorArr = [_red,_green,_blue,_alpha];
		_picColor ctrlSetBackgroundColor _newcolorArr;
		// Custom color
		_ind = lbCurSel _lbPcolor;
		_lbPcolor lbSetColor [_ind, _newcolorArr];
		_lbPcolor lbSetPictureColor [_ind,_newcolorArr];
		_lbPcolor lbSetPictureColorDisabled [_ind,_newcolorArr];
		_lbPcolor lbSetPictureColorSelected [_ind,_newcolorArr];
	};
	case "colorBtn":
	{
		_ctrl = _ehParams select 0;
		_key = _ehParams select 1;
		if !(_key in [28,156]) exitWith {};
		_lbPcolor lbSetCurSel (lbsize _lbPcolor -1);
		_red = parseNumber ctrlText _edPcolorRed;
		_green = parseNumber ctrlText _edPcolorGreen;
		_blue = parseNumber ctrlText _edPcolorBlue; 
		_alpha = parseNumber ctrlText _edPcolorAlpha;
		_newcolorArr = [_red,_green,_blue,_alpha];
		_picColor ctrlSetBackgroundColor _newcolorArr;
		// Custom color
		_ind = lbCurSel _lbPcolor;
		_lbPcolor lbSetColor [_ind, _newcolorArr];
		_lbPcolor lbSetPictureColor [_ind,_newcolorArr];
		_lbPcolor lbSetPictureColorDisabled [_ind,_newcolorArr];
		_lbPcolor lbSetPictureColorSelected [_ind,_newcolorArr];
	};
	case "cbExist":
	{
		_ctrl = _ehParams select 0;
		if (_ctrl == _cbObjExist) then {
			_cbObjCfg cbSetChecked false; 
			_edpObjCfg ctrlEnable false;
			_lbPObjExist ctrlEnable true;
			_pic = _lbPObjExist lbPicture (lbCurSel _lbPObjExist);
			_picPreview169 ctrlSetText _pic;
		} else {
			_cbObjExist cbSetChecked false; 
			_lbPObjExist ctrlEnable false; 
			_edpObjCfg ctrlEnable true;
			_pic = getText (configfile >> "CfgVehicles" >> ctrlText _edpObjCfg >> "editorPreview");
			_picPreview169 ctrlSetText _pic;
		};
	};
	case "pObjLb":
	{
		_pic = _lbPObjExist lbPicture (lbCurSel _lbPObjExist);
		_picPreview169 ctrlSetText _pic;
	};
	case "edObj":
	{
		_ctrl = _ehParams select 0;
		_pic = getText (configfile >> "CfgVehicles" >> ctrlText _ctrl >> "editorPreview");
		_picPreview169 ctrlSetText _pic;
	};
	case "reset":
	{
		_oldPointer = pointerObject;
		_newPointer = "Sign_Sphere10cm_F" createVehicle [0,0,0];
		_newPointer setObjectTexture [0,"#(argb,8,8,3)color(1,0.6,0.1,1.0,ca)"];
		_newPointer setPos getPos _oldPointer;
		pointerObject = _newPointer;
		deleteVehicle _oldPointer;
		allMemP = false;
		pointerCollision = true;
		excluedObj = [pointerObject,player];
		closeDialog 0;
		sleep 0.01;
		createDialog "TER_settings";
	};
};
