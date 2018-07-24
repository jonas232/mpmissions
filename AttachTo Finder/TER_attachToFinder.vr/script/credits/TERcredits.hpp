////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Terra, v1.063, #Xafupy)
////////////////////////////////////////////////////////
#define TESTCOMM "systemChat str _this"
#define test(ARG) systemChat ARG
// onKeyDown = "['case', _this] execVM 'script\memPoints\guiEH.sqf'";

class TER_credits
{
    idd = 170406; // 06.04.2017
    movingenable = false;
	OnLoad = "0 =  [] execVM 'script\credits\onLoadCredits.sqf';";
	//onUnload = "0 =  execVM 'script\memPoints\onUnLoadMemP.sqf';"
   class ControlsBackground
	{
		class IGUIBack_2200: IGUIBack
		{
			idc = 2200;
			x = 0.2375 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.525 * safezoneW;
			h = 0.322 * safezoneH;
		};
		class RscFrame_1800: RscFrame
		{
			idc = 1800;
			text = "Credits"; //--- ToDo: Localize;
			x = 0.2375 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.525 * safezoneW;
			h = 0.322 * safezoneH;
		};
		class RscFrame_1801: RscFrame
		{
			idc = 1801;
			x = 0.244063 * safezoneW + safezoneX;
			y = 0.178 * safezoneH + safezoneY;
			w = 0.511875 * safezoneW;
			h = 0.112 * safezoneH;
		};
		class RscFrame_1802: RscFrame
		{
			idc = 1802;
			x = 0.244062 * safezoneW + safezoneX;
			y = 0.29 * safezoneH + safezoneY;
			w = 0.511875 * safezoneW;
			h = 0.112 * safezoneH;
		};
		class RscFrame_1803: RscFrame
		{
			idc = 1803;
			x = 0.244062 * safezoneW + safezoneX;
			y = 0.402 * safezoneH + safezoneY;
			w = 0.511875 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class RscText_1002: RscText
		{
			idc = 1002;
			text = "Author: Terra"; //--- ToDo: Localize;
			x = 0.250625 * safezoneW + safezoneX;
			y = 0.192 * safezoneH + safezoneY;
			w = 0.091875 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1004: RscText
		{
			idc = 1004;
			text = "ArmA3 Unit:"; //--- ToDo: Localize;
			x = 0.26375 * safezoneW + safezoneX;
			y = 0.248 * safezoneH + safezoneY;
			w = 0.091875 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1005: RscText
		{
			idc = 1005;
			text = "BIS Forum:"; //--- ToDo: Localize;
			x = 0.26375 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.091875 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1003: RscText
		{
			idc = 1003;
			text = "DREAD_fnc_copyConfigClass"; //--- ToDo: Localize;
			x = 0.250625 * safezoneW + safezoneX;
			y = 0.304 * safezoneH + safezoneY;
			w = 0.164062 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1006: RscText
		{
			idc = 1006;
			text = "Author: dreadedentity"; //--- ToDo: Localize;
			x = 0.26375 * safezoneW + safezoneX;
			y = 0.332 * safezoneH + safezoneY;
			w = 0.164062 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1007: RscText
		{
			idc = 1007;
			text = "Topic:"; //--- ToDo: Localize;
			x = 0.26375 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.164062 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1010: RscText
		{
			idc = 1010;
			text = "Date: 06.04.2017"; //--- ToDo: Localize;
			x = 0.650937 * safezoneW + safezoneX;
			y = 0.416 * safezoneH + safezoneY;
			w = 0.0984375 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscText_1011: RscText
		{
			idc = 1011;
			text = "Version 1.0"; //--- ToDo: Localize;
			x = 0.47375 * safezoneW + safezoneX;
			y = 0.416 * safezoneH + safezoneY;
			w = 0.065625 * safezoneW;
			h = 0.028 * safezoneH;
		};
	};
    class Controls
    {
		class linkBISProfileTxt: RscStructuredText
		{
			idc = 40001;
			tooltip = "https://forums.bistudio.com/profile/1139559-7erra/"; //--- ToDo: Localize;
			x = 0.349063 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.269062 * safezoneW;
			h = 0.028 * safezoneH;
			colorText[] = {0,0,1,1};
		};
		class linkL16Txt: RscStructuredText
		{
			idc = 40002;
			tooltip = "http://www.vlehrbrig16.de/"; //--- ToDo: Localize;
			x = 0.349063 * safezoneW + safezoneX;
			y = 0.248 * safezoneH + safezoneY;
			w = 0.150937 * safezoneW;
			h = 0.028 * safezoneH;
			colorText[] = {0,0,1,1};
		};
		class linkDreadTxt: RscStructuredText
		{
			idc = 40003;
			tooltip = "https://forums.bistudio.com/profile/797731-dreadedentity/"; //--- ToDo: Localize;
			x = 0.42125 * safezoneW + safezoneX;
			y = 0.332 * safezoneH + safezoneY;
			w = 0.28875 * safezoneW;
			h = 0.028 * safezoneH;
			colorText[] = {0,0,1,1};
		};
		class linkTopicTxt: RscStructuredText
		{
			idc = 40004;
			text = "Link to topic"; //--- ToDo: Localize;
			x = 0.42125 * safezoneW + safezoneX;
			y = 0.36 * safezoneH + safezoneY;
			w = 0.07375 * safezoneW;
			h = 0.028 * safezoneH;
			colorText[] = {0,0,1,1};
			tooltip = "https://forums.bistudio.com/forums/topic/187668-code-snippet-extracting-full-classes-from-config/"; //--- ToDo: Localize;
		};
		class closeBtn: RscButton
		{
			idc = 41001;
			text = "Close"; //--- ToDo: Localize;
			x = 0.250625 * safezoneW + safezoneX;
			y = 0.416 * safezoneH + safezoneY;
			w = 0.065625 * safezoneW;
			h = 0.028 * safezoneH;
			action = "closeDialog 0";
		};
    };
};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
/* #Pybyfy
/* #Tuqyci
/* #Kovefo
/* #Nimoqu
$[
	1.063,
	["TER_credits",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1800,"",[1,"Credits",["0.2375 * safezoneW + safezoneX","0.15 * safezoneH + safezoneY","0.525 * safezoneW","0.322 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1801,"",[1,"",["0.244063 * safezoneW + safezoneX","0.178 * safezoneH + safezoneY","0.511875 * safezoneW","0.112 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1802,"",[1,"",["0.244062 * safezoneW + safezoneX","0.29 * safezoneH + safezoneY","0.511875 * safezoneW","0.112 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1803,"",[1,"",["0.244062 * safezoneW + safezoneX","0.402 * safezoneH + safezoneY","0.511875 * safezoneW","0.056 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"",[1,"Author: Terra",["0.250625 * safezoneW + safezoneX","0.192 * safezoneH + safezoneY","0.091875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1004,"",[1,"ArmA3 Unit:",["0.26375 * safezoneW + safezoneX","0.248 * safezoneH + safezoneY","0.091875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1005,"",[1,"BIS Forum:",["0.26375 * safezoneW + safezoneX","0.22 * safezoneH + safezoneY","0.091875 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"linkL16Txt",[1,"http://www.vlehrbrig16.de/",["0.349063 * safezoneW + safezoneX","0.248 * safezoneH + safezoneY","0.150937 * safezoneW","0.028 * safezoneH"],[0,0,1,1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"linkBISProfileTxt",[1,"https://forums.bistudio.com/profile/1139559-7erra/",["0.349063 * safezoneW + safezoneX","0.22 * safezoneH + safezoneY","0.269062 * safezoneW","0.028 * safezoneH"],[0,0,1,1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"",[1,"DREAD_fnc_copyConfigClass",["0.250625 * safezoneW + safezoneX","0.304 * safezoneH + safezoneY","0.164062 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1006,"",[1,"Author: dreadedentity",["0.26375 * safezoneW + safezoneX","0.332 * safezoneH + safezoneY","0.164062 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1007,"",[1,"Topic:",["0.26375 * safezoneW + safezoneX","0.36 * safezoneH + safezoneY","0.164062 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1008,"linkDreadTxt",[1,"https://forums.bistudio.com/profile/797731-dreadedentity/",["0.42125 * safezoneW + safezoneX","0.332 * safezoneH + safezoneY","0.28875 * safezoneW","0.028 * safezoneH"],[0,0,1,1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1009,"linkTopicTxt",[1,"Link to topic",["0.42125 * safezoneW + safezoneX","0.36 * safezoneH + safezoneY","0.07875 * safezoneW","0.028 * safezoneH"],[0,0,1,1],[-1,-1,-1,-1],[-1,-1,-1,-1],"https://forums.bistudio.com/forums/topic/187668-code-snippet-extracting-full-classes-from-config/","-1"],[]],
	[2200,"",[1,"",["0.2375 * safezoneW + safezoneX","0.15 * safezoneH + safezoneY","0.525 * safezoneW","0.322 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1010,"",[1,"Date: 07.04.2017",["0.650937 * safezoneW + safezoneX","0.416 * safezoneH + safezoneY","0.0984375 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[2,"Close",["1 * GUI_GRID_W + GUI_GRID_X","9.5 * GUI_GRID_H + GUI_GRID_Y","5 * GUI_GRID_W","1 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1011,"",[1,"Version 1.0",["0.47375 * safezoneW + safezoneX","0.416 * safezoneH + safezoneY","0.065625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/


////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Terra, v1.063, #Nizuka)
////////////////////////////////////////////////////////

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Terra, v1.063, #Cabale)
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////



////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Terra, v1.063, #Pewile)
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
