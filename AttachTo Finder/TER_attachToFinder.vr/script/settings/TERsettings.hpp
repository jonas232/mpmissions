#define TESTCOMM "systemChat str _this"
#define test(ARG) systemChat ARG
#define COLORBTN "['colorBtn',_this] execVM 'script\settings\guiEH.sqf'"

class TER_settings
{
	idd = 170404; // 04.04.2017
	movingenable = false;
	OnLoad = "0 =  [] execVM 'script\settings\onLoadSettings.sqf';";
	onUnload = "0 =  execVM 'script\settings\onUnLoadSettings.sqf';";
	class ControlsBackground
	{
		class IGUIBack_2200: IGUIBack
		{
			idc = 2200;
			x = 0.2375 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.525 * safezoneW;
			h = 0.7 * safezoneH;
		};
		class RscFrame_1800: RscFrame
		{
			idc = 1800;
			text = "Settings"; //--- ToDo: Localize;
			x = 0.2375 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.525 * safezoneW;
			h = 0.7 * safezoneH;
		};
		class RscText_1000: RscText
		{
			idc = 1000;
			text = "Pointer color:"; //--- ToDo: Localize;
			x = 0.250625 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.091875 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1001: RscText
		{
			idc = 1001;
			text = "Red"; //--- ToDo: Localize;
			x = 0.519688 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.0328125 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1002: RscText
		{
			idc = 1002;
			text = "Green"; //--- ToDo: Localize;
			x = 0.559062 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.034 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1003: RscText
		{
			idc = 1003;
			text = "Blue"; //--- ToDo: Localize;
			x = 0.598437 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.0328125 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1004: RscText
		{
			idc = 1004;
			text = "Alpha"; //--- ToDo: Localize;
			x = 0.637812 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.0328125 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class pColorFrame: RscFrame
		{
			idc = 1801;
			x = 0.244062 * safezoneW + safezoneX;
			y = 0.178 * safezoneH + safezoneY;
			w = 0.511875 * safezoneW;
			h = 0.084 * safezoneH;
		};
		class pSizeFrame: RscFrame
		{
			idc = 1802;
			x = 0.244062 * safezoneW + safezoneX;
			y = 0.262 * safezoneH + safezoneY;
			w = 0.511875 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class RscText_1005: RscText
		{
			idc = 1005;
			text = "Pointer size:"; //--- ToDo: Localize;
			x = 0.250625 * safezoneW + safezoneX;
			y = 0.276 * safezoneH + safezoneY;
			w = 0.07875 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class pObjFrame: RscFrame
		{
			idc = 1803;
			x = 0.244062 * safezoneW + safezoneX;
			y = 0.318 * safezoneH + safezoneY;
			w = 0.511875 * safezoneW;
			h = 0.154 * safezoneH;
		};
		class RscText_1007: RscText
		{
			idc = 1007;
			text = "Pointer object:"; //--- ToDo: Localize;
			x = 0.250625 * safezoneW + safezoneX;
			y = 0.332 * safezoneH + safezoneY;
			w = 0.07875 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1006: RscText
		{
			idc = 1006;
			text = "Existing object"; //--- ToDo: Localize;
			x = 0.395 * safezoneW + safezoneX;
			y = 0.374 * safezoneH + safezoneY;
			w = 0.0853125 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1008: RscText
		{
			idc = 1008;
			text = "New object"; //--- ToDo: Localize;
			x = 0.591875 * safezoneW + safezoneX;
			y = 0.374 * safezoneH + safezoneY;
			w = 0.065625 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1009: RscText
		{
			idc = 1009;
			text = "OR"; //--- ToDo: Localize;
			x = 0.52625 * safezoneW + safezoneX;
			y = 0.374 * safezoneH + safezoneY;
			w = 0.02625 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscFrame_1804: RscFrame
		{
			idc = 1804;
			x = 0.244062 * safezoneW + safezoneX;
			y = 0.178 * safezoneH + safezoneY;
			w = 0.111562 * safezoneW;
			h = 0.602 * safezoneH;
		};
		class RscText_1010: RscText
		{
			idc = 1010;
			text = "Show all memory"; //--- ToDo: Localize;
			x = 0.250625 * safezoneW + safezoneX;
			y = 0.486 * safezoneH + safezoneY;
			w = 0.0984375 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1011: RscText
		{
			idc = 1011;
			text = "points:"; //--- ToDo: Localize;
			x = 0.250625 * safezoneW + safezoneX;
			y = 0.514 * safezoneH + safezoneY;
			w = 0.0984375 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class memPFrame: RscFrame
		{
			idc = 1805;
			x = 0.244062 * safezoneW + safezoneX;
			y = 0.472 * safezoneH + safezoneY;
			w = 0.511875 * safezoneW;
			h = 0.084 * safezoneH;
		};
/*		class RscText_1012: RscText
		{
			idc = 1012;
			text = "Yes"; //--- ToDo: Localize;
			x = 0.381875 * safezoneW + safezoneX;
			y = 0.514 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1013: RscText
		{
			idc = 1013;
			text = "No"; //--- ToDo: Localize;
			x = 0.381875 * safezoneW + safezoneX;
			y = 0.542 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscFrame_1806: RscFrame
		{
			idc = 1806;
			x = 0.244062 * safezoneW + safezoneX;
			y = 0.584 * safezoneH + safezoneY;
			w = 0.511875 * safezoneW;
			h = 0.196 * safezoneH;
		};
*/		class RscText_1014: RscText
		{
			idc = 1014;
			text = "Delete pointers after dialog is closed"; //--- ToDo: Localize;
			x = 0.532812 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.21 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1015: RscText
		{
			idc = 1015;
			text = "Only for spheres"; //--- ToDo: Localize;
			x = 0.526251 * safezoneW + safezoneX;
			y = 0.276 * safezoneH + safezoneY;
			w = 0.177187 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class frameSim: RscFrame
		{
			idc = 1806;
			x = 0.244062 * safezoneW + safezoneX;
			y = 0.556 * safezoneH + safezoneY;
			w = 0.511875 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class RscText_1016: RscText
		{
			idc = 1016;
			text = "Enable Simulation:"; //--- ToDo: Localize;
			x = 0.250625 * safezoneW + safezoneX;
			y = 0.57 * safezoneH + safezoneY;
			w = 0.0984375 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class frameCollision: RscFrame
		{
			idc = 1807;
			x = 0.244062 * safezoneW + safezoneX;
			y = 0.612 * safezoneH + safezoneY;
			w = 0.511875 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class RscText_1012: RscText
		{
			idc = 1012;
			text = "Enable Collision:"; //--- ToDo: Localize;
			x = 0.250625 * safezoneW + safezoneX;
			y = 0.626 * safezoneH + safezoneY;
			w = 0.0984375 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class frameInclude: RscFrame
		{
			idc = 1808;
			x = 0.244062 * safezoneW + safezoneX;
			y = 0.668 * safezoneH + safezoneY;
			w = 0.511875 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class RscText_1013: RscText
		{
			idc = 1013;
			text = "Exclude Object:"; //--- ToDo: Localize;
			x = 0.250625 * safezoneW + safezoneX;
			y = 0.682 * safezoneH + safezoneY;
			w = 0.0984375 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class frameRest: RscFrame
		{
			idc = 1809;
			x = 0.244062 * safezoneW + safezoneX;
			y = 0.724 * safezoneH + safezoneY;
			w = 0.511875 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
	class Controls
	{
		// Combo
		class pColorCombo: RscCombo
		{
			idc = 30001;
			x = 0.36875 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.137812 * safezoneW;
			h = 0.028 * safezoneH;
			onLBSelChanged = "['colorLB',_this] execVM 'script\settings\guiEH.sqf'"
		};
		class pSizeCombo: RscCombo
		{
			idc = 30002;
			x = 0.36875 * safezoneW + safezoneX;
			y = 0.276 * safezoneH + safezoneY;
			w = 0.137812 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class pObjExistEd: RscCombo
		{
			idc = 30003;
			x = 0.36875 * safezoneW + safezoneX;
			y = 0.332 * safezoneH + safezoneY;
			w = 0.1575 * safezoneW;
			h = 0.028 * safezoneH;
			onLBSelChanged = "['pObjLb',_this] execVM 'script\settings\guiEH.sqf'"
		};
		class excludeCombo: RscCombo
		{
			idc = 30004;
			x = 0.36875 * safezoneW + safezoneX;
			y = 0.682 * safezoneH + safezoneY;
			w = 0.1575 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class includeCombo: RscCombo
		{
			idc = 30005;
			x = 0.585312 * safezoneW + safezoneX;
			y = 0.682 * safezoneH + safezoneY;
			w = 0.1575 * safezoneW;
			h = 0.028 * safezoneH;
		};
		// Edit
		class pColorRedEd: RscEdit
		{
			idc = 31001;
			text = "0.99"; //--- ToDo: Localize;
			x = 0.519688 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseZChanged = "['mZColor',_this] execVM 'script\settings\guiEH.sqf'";
			onKeyDown = COLORBTN;
		};
		class pColorGreenEd: RscEdit
		{
			idc = 31002;
			text = "0.99"; //--- ToDo: Localize;
			x = 0.559062 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseZChanged = "['mZColor',_this] execVM 'script\settings\guiEH.sqf'";
			onKeyDown = COLORBTN;
		};
		class pColorBlueEd: RscEdit
		{
			idc = 31003;
			text = "0.99"; //--- ToDo: Localize;
			x = 0.598437 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseZChanged = "['mZColor',_this] execVM 'script\settings\guiEH.sqf'";
			onKeyDown = COLORBTN;
		};
		class pColorAlphaEd: RscEdit
		{
			idc = 31004;
			text = "0.99"; //--- ToDo: Localize;
			x = 0.637812 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.028 * safezoneH;
			onMouseZChanged = "['mZColor',_this] execVM 'script\settings\guiEH.sqf'";
			onKeyDown = COLORBTN;
		};
		class pObjCfgEd: RscEdit
		{
			idc = 31005;
			text = "Config name"; //--- ToDo: Localize;
			x = 0.565625 * safezoneW + safezoneX;
			y = 0.332 * safezoneH + safezoneY;
			w = 0.177187 * safezoneW;
			h = 0.028 * safezoneH;
			onKeyDown = "['edObj',_this] execVM 'script\settings\guiEH.sqf'";
		};
		// Picture
		class pColorColorPic: IGUIBack
		{
			idc = 32001;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.056 * safezoneH;
			colorBackground[] = {1,1,1,1};
		};/*
		class pObjSquarePic: RscPicture
		{
			idc = 32002;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.670625 * safezoneW + safezoneX;
			y = 0.374 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.112 * safezoneH;
		};*/
		class pObj169Pic: RscPicture
		{
			idc = 32003;
			text = "";
			x = 0.664063 * safezoneW + safezoneX;
			y = 0.374 * safezoneH + safezoneY;
			w = 0.07875 * safezoneW;
			h = 0.084 * safezoneH;
		};
		// Buttons
		/*class pColorEnterBtn: RscButton
		{
			idc = 33001;
			text = "Enter"; //--- ToDo: Localize;
			x = 0.71 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.0328125 * safezoneW;
			h = 0.028 * safezoneH;
		};*/
		class applyBtn: RscButton
		{
			idc = 33002;
			text = "Apply Settings"; //--- ToDo: Localize;
			x = 0.244062 * safezoneW + safezoneX;
			y = 0.808 * safezoneH + safezoneY;
			w = 0.0984375 * safezoneW;
			h = 0.028 * safezoneH;
			action = "[] execVM 'script\settings\apply.sqf'";
		};
		class cancelBtn: RscButton
		{
			idc = 33003;
			text = "Cancel"; //--- ToDo: Localize;
			x = 0.6575 * safezoneW + safezoneX;
			y = 0.808 * safezoneH + safezoneY;
			w = 0.0984375 * safezoneW;
			h = 0.028 * safezoneH;
			action = closeDialog 0;
		};
		class resetBtn: RscButton
		{
			idc = 33004;
			text = "Reset Settings"; //--- ToDo: Localize;
			x = 0.4475 * safezoneW + safezoneX;
			y = 0.808 * safezoneH + safezoneY;
			w = 0.105 * safezoneW;
			h = 0.028 * safezoneH;
			action = "['reset',_this] execVM 'script\settings\guiEH.sqf'";
		};
		// Checkboxes
		class pObjExistCB: RscCheckbox
		{
			idc = 34001;
			x = 0.36875 * safezoneW + safezoneX;
			y = 0.374 * safezoneH + safezoneY;
			w = 0.0196875 * safezoneW;
			h = 0.028 * safezoneH;
			onCheckedChanged = "['cbExist',_this] execVM 'script\settings\guiEH.sqf'";
		};
		class pObjCfgCB: RscCheckbox
		{
			idc = 34002;
			x = 0.565625 * safezoneW + safezoneX;
			y = 0.374 * safezoneH + safezoneY;
			w = 0.0196875 * safezoneW;
			h = 0.028 * safezoneH;
			onCheckedChanged = "['cbExist',_this] execVM 'script\settings\guiEH.sqf'";
		};
		class memPDeleteCB: RscCheckbox
		{
			idc = 34005;
			x = 0.513125 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0196875 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class showMemPCB: RscCheckbox
		{
			idc = 34006;
			x = 0.36875 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0196875 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class simCB: RscCheckbox
		{
			idc = 34007;
			x = 0.36875 * safezoneW + safezoneX;
			y = 0.57 * safezoneH + safezoneY;
			w = 0.0196875 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class collisionCB: RscCheckbox
		{
			idc = 34008;
			x = 0.36875 * safezoneW + safezoneX;
			y = 0.626 * safezoneH + safezoneY;
			w = 0.0196875 * safezoneW;
			h = 0.028 * safezoneH;
		};
	};
};

/*
/* #Jiheku
/* #Hybeco
$[
	1.063,
	["TER_settings",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"",[1,"",["0.2375 * safezoneW + safezoneX","0.15 * safezoneH + safezoneY","0.525 * safezoneW","0.7 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"",[1,"Settings",["0.2375 * safezoneW + safezoneX","0.15 * safezoneH + safezoneY","0.525 * safezoneW","0.7 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"",[1,"Pointer color:",["0.250625 * safezoneW + safezoneX","0.192 * safezoneH + safezoneY","0.091875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2100,"pColorCombo",[1,"",["0.36875 * safezoneW + safezoneX","0.192 * safezoneH + safezoneY","0.137812 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"pColorRedEd",[1,"0.999",["0.519688 * safezoneW + safezoneX","0.192 * safezoneH + safezoneY","0.039375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1401,"pColorGreenEd",[1,"0.999",["0.559062 * safezoneW + safezoneX","0.192 * safezoneH + safezoneY","0.039375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1402,"pColorBlueEd",[1,"0.999",["0.598437 * safezoneW + safezoneX","0.192 * safezoneH + safezoneY","0.039375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1403,"pColorAlphaEd",[1,"0.999",["0.637812 * safezoneW + safezoneX","0.192 * safezoneH + safezoneY","0.039375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"",[1,"Red",["0.519688 * safezoneW + safezoneX","0.22 * safezoneH + safezoneY","0.0328125 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"",[1,"Green",["0.559062 * safezoneW + safezoneX","0.22 * safezoneH + safezoneY","0.0328125 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"",[1,"Blue",["0.598437 * safezoneW + safezoneX","0.22 * safezoneH + safezoneY","0.0328125 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1004,"",[1,"Alpha",["0.637812 * safezoneW + safezoneX","0.22 * safezoneH + safezoneY","0.0328125 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1200,"pColorColorPic",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.71 * safezoneW + safezoneX","0.192 * safezoneH + safezoneY","0.039375 * safezoneW","0.056 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1801,"pColorFrame",[1,"",["0.244062 * safezoneW + safezoneX","0.178 * safezoneH + safezoneY","0.511875 * safezoneW","0.084 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1802,"pSizeFrame",[1,"",["0.244062 * safezoneW + safezoneX","0.262 * safezoneH + safezoneY","0.511875 * safezoneW","0.056 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1005,"",[1,"Pointer size:",["0.250625 * safezoneW + safezoneX","0.276 * safezoneH + safezoneY","0.07875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"applyBtn",[1,"Apply Settings",["0.244062 * safezoneW + safezoneX","0.808 * safezoneH + safezoneY","0.0984375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"cancelBtn",[1,"Cancel",["0.6575 * safezoneW + safezoneX","0.808 * safezoneH + safezoneY","0.0984375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2101,"pSizeCombo",[1,"",["0.36875 * safezoneW + safezoneX","0.276 * safezoneH + safezoneY","0.137812 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1803,"pObjFrame",[1,"",["0.244062 * safezoneW + safezoneX","0.318 * safezoneH + safezoneY","0.511875 * safezoneW","0.154 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1007,"",[1,"Pointer object:",["0.250625 * safezoneW + safezoneX","0.332 * safezoneH + safezoneY","0.07875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2102,"pObjExistEd",[1,"",["0.36875 * safezoneW + safezoneX","0.332 * safezoneH + safezoneY","0.1575 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1404,"pObjCfgEd",[1,"Config name",["0.565625 * safezoneW + safezoneX","0.332 * safezoneH + safezoneY","0.177187 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1006,"",[1,"Existing object",["0.395 * safezoneW + safezoneX","0.374 * safezoneH + safezoneY","0.0853125 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1008,"",[1,"New object",["0.591875 * safezoneW + safezoneX","0.374 * safezoneH + safezoneY","0.065625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1009,"",[1,"OR",["0.52625 * safezoneW + safezoneX","0.374 * safezoneH + safezoneY","0.02625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2800,"pObjExistCB",[1,"",["0.36875 * safezoneW + safezoneX","0.374 * safezoneH + safezoneY","0.0196875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2801,"pObjCfgCB",[1,"",["0.565625 * safezoneW + safezoneX","0.374 * safezoneH + safezoneY","0.0196875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1804,"",[1,"",["0.244062 * safezoneW + safezoneX","0.178 * safezoneH + safezoneY","0.111562 * safezoneW","0.602 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1010,"",[1,"Show all memory",["0.250625 * safezoneW + safezoneX","0.486 * safezoneH + safezoneY","0.0984375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1011,"",[1,"points:",["0.250625 * safezoneW + safezoneX","0.514 * safezoneH + safezoneY","0.0984375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1805,"memPFrame",[1,"",["0.244062 * safezoneW + safezoneX","0.472 * safezoneH + safezoneY","0.511875 * safezoneW","0.084 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1806,"frameSim",[1,"",["0.244062 * safezoneW + safezoneX","0.556 * safezoneH + safezoneY","0.511875 * safezoneW","0.056 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1014,"",[1,"Delete pointers after dialog is closed",["0.532812 * safezoneW + safezoneX","0.5 * safezoneH + safezoneY","0.21 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2804,"memPDeleteCB",[1,"",["0.513125 * safezoneW + safezoneX","0.5 * safezoneH + safezoneY","0.0196875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1015,"",[1,"Only for spheres",["0.526251 * safezoneW + safezoneX","0.276 * safezoneH + safezoneY","0.177187 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1202,"pObj169Pic",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.664063 * safezoneW + safezoneX","0.374 * safezoneH + safezoneY","0.07875 * safezoneW","0.084 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1016,"",[1,"Enable Simulation:",["0.250625 * safezoneW + safezoneX","0.57 * safezoneH + safezoneY","0.0984375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1807,"frameCollision",[1,"",["0.244062 * safezoneW + safezoneX","0.612 * safezoneH + safezoneY","0.511875 * safezoneW","0.056 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2802,"showMemPCB",[1,"",["0.36875 * safezoneW + safezoneX","0.5 * safezoneH + safezoneY","0.0196875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2803,"simCB",[1,"",["0.36875 * safezoneW + safezoneX","0.57 * safezoneH + safezoneY","0.0196875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1012,"",[1,"Enable Collision:",["0.250625 * safezoneW + safezoneX","0.626 * safezoneH + safezoneY","0.0984375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2805,"collisionCB",[1,"",["0.36875 * safezoneW + safezoneX","0.626 * safezoneH + safezoneY","0.0196875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1808,"frameInclude",[1,"",["0.244062 * safezoneW + safezoneX","0.668 * safezoneH + safezoneY","0.511875 * safezoneW","0.056 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1013,"",[1,"Exclude Object:",["0.250625 * safezoneW + safezoneX","0.682 * safezoneH + safezoneY","0.0984375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2103,"excludeCombo",[1,"",["0.36875 * safezoneW + safezoneX","0.682 * safezoneH + safezoneY","0.1575 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2104,"includeCombo",[1,"",["0.585312 * safezoneW + safezoneX","0.682 * safezoneH + safezoneY","0.1575 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"resetBtn",[1,"Reset Settings",["0.4475 * safezoneW + safezoneX","0.808 * safezoneH + safezoneY","0.105 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1809,"frameRest",[1,"",["0.244062 * safezoneW + safezoneX","0.724 * safezoneH + safezoneY","0.511875 * safezoneW","0.056 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/


/*
