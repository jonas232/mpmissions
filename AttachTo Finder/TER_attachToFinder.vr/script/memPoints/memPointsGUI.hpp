#define TESTCOMM "systemChat str _this"
#define test(ARG) systemChat ARG
// onKeyDown = "['case', _this] execVM 'script\memPoints\guiEH.sqf'";

class TER_mem
{
    idd = 170401; // 01.04.2017
    movingenable = false;
	OnLoad = "0 =  [true] execVM 'script\memPoints\onLoadMemP.sqf';";
	onUnload = "0 =  execVM 'script\memPoints\onUnLoadMemP.sqf';"
   class ControlsBackground
	{
		class IGUIBack_2200: IGUIBack
		{
			idc = 2200;
			x = 0.276875 * safezoneW + safezoneX;
			y = 0.178 * safezoneH + safezoneY;
			w = 0.44625 * safezoneW;
			h = 0.644 * safezoneH;
		};
		class RscFrame_1800: RscFrame
		{
			idc = 1800;
			text = "Memory points"; //--- ToDo: Localize;
			x = 0.276875 * safezoneW + safezoneX;
			y = 0.178 * safezoneH + safezoneY;
			w = 0.44625 * safezoneW;
			h = 0.644 * safezoneH;
		};
		class RscText_1000: RscText
		{
			idc = 1000;
			text = "Search memorypoint:"; //--- ToDo: Localize;
			x = 0.559062 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.13125 * safezoneW;
			h = 0.028 * safezoneH;
		};
		class RscFrame_1801: RscFrame
		{
			idc = 1801;
			x = 0.29 * safezoneW + safezoneX;
			y = 0.206 * safezoneH + safezoneY;
			w = 0.255937 * safezoneW;
			h = 0.546 * safezoneH;
		};
		class RscFrame_1802: RscFrame
		{
			idc = 1802;
			x = 0.545937 * safezoneW + safezoneX;
			y = 0.206 * safezoneH + safezoneY;
			w = 0.164062 * safezoneW;
			h = 0.42 * safezoneH;
		};
		class RscFrame_1803: RscFrame
		{
			idc = 1803;
			x = 0.545937 * safezoneW + safezoneX;
			y = 0.626 * safezoneH + safezoneY;
			w = 0.164062 * safezoneW;
			h = 0.07 * safezoneH;
		};
		class RscFrame_1804: RscFrame
		{
			idc = 1804;
			x = 0.545937 * safezoneW + safezoneX;
			y = 0.696 * safezoneH + safezoneY;
			w = 0.164062 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
    class Controls
    {
		class RscButton_1600: RscButton
		{
			idc = 140001;
			text = "Select"; //--- ToDo: Localize;
			x = 0.29 * safezoneW + safezoneX;
			y = 0.766 * safezoneH + safezoneY;
			w = 0.065625 * safezoneW;
			h = 0.028 * safezoneH;
			action = "execVM 'script\memPoints\confirm.sqf'";
		};
		class RscButton_1601: RscButton
		{
			idc = 140002;
			text = "Cancel"; //--- ToDo: Localize;
			x = 0.644375 * safezoneW + safezoneX;
			y = 0.766 * safezoneH + safezoneY;
			w = 0.065625 * safezoneW;
			h = 0.028 * safezoneH;
			action = "closeDialog 0";
		};
		class treeMemP: RscTree
		{
			idc = 140101;
			x = 0.29 * safezoneW + safezoneX;
			y = 0.206 * safezoneH + safezoneY;
			w = 0.255937 * safezoneW;
			h = 0.546 * safezoneH;
		};
		class findBtn: RscButton
		{
			idc = 140004;
			text = "Find Memorypoints"; //--- ToDo: Localize;
			x = 0.559062 * safezoneW + safezoneX;
			y = 0.64 * safezoneH + safezoneY;
			w = 0.137812 * safezoneW;
			h = 0.042 * safezoneH;
			action = "['find', _this] execVM 'script\memPoints\guiEH.sqf'";
		};
		class searchEd: RscEdit
		{
			idc = 140201;
			x = 0.559062 * safezoneW + safezoneX;
			y = 0.262 * safezoneH + safezoneY;
			w = 0.137812 * safezoneW;
			h = 0.028 * safezoneH;
			onKeyDown = "['search', _this] execVM 'script\memPoints\guiEH.sqf'";
		};
		class resetBtn: RscButton
		{
			idc = 140004;
			text = "Reset"; //--- ToDo: Localize;
			x = 0.559062 * safezoneW + safezoneX;
			y = 0.71 * safezoneH + safezoneY;
			w = 0.137812 * safezoneW;
			h = 0.028 * safezoneH;
			action = "['reset'] execVM 'script\memPoints\guiEH.sqf'";
		};
		class treeSearch: RscTree
		{
			idc = 140102;
			x = 0.5525 * safezoneW + safezoneX;
			y = 0.304 * safezoneH + safezoneY;
			w = 0.150937 * safezoneW;
			h = 0.308 * safezoneH;
		};
    };
};

/* #Sykaxa
$[
	1.063,
	["TER_memP",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"",[1,"",["0.276875 * safezoneW + safezoneX","0.178 * safezoneH + safezoneY","0.44625 * safezoneW","0.644 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"",[1,"Memory points",["0.276875 * safezoneW + safezoneX","0.178 * safezoneH + safezoneY","0.44625 * safezoneW","0.644 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[1,"Select",["0.29 * safezoneW + safezoneX","0.766 * safezoneH + safezoneY","0.065625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"",[1,"Cancel",["0.644375 * safezoneW + safezoneX","0.766 * safezoneH + safezoneY","0.065625 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2201,"treeMemP",[1,"",["0.29 * safezoneW + safezoneX","0.206 * safezoneH + safezoneY","0.255937 * safezoneW","0.546 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"findBtn",[1,"Find Memorypoints",["0.559062 * safezoneW + safezoneX","0.64 * safezoneH + safezoneY","0.137812 * safezoneW","0.042 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"searchEd",[1,"",["0.559062 * safezoneW + safezoneX","0.262 * safezoneH + safezoneY","0.137812 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1603,"resetBtn",[1,"Reset",["0.565625 * safezoneW + safezoneX","0.71 * safezoneH + safezoneY","0.137812 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"",[1,"Search memorypoint:",["0.559062 * safezoneW + safezoneX","0.22 * safezoneH + safezoneY","0.13125 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1802,"",[1,"",["0.545937 * safezoneW + safezoneX","0.206 * safezoneH + safezoneY","0.164062 * safezoneW","0.42 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1803,"",[1,"",["0.545937 * safezoneW + safezoneX","0.626 * safezoneH + safezoneY","0.164062 * safezoneW","0.07 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1804,"",[1,"",["0.545937 * safezoneW + safezoneX","0.696 * safezoneH + safezoneY","0.164062 * safezoneW","0.056 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2202,"treeSearch",[2,"",["24 * GUI_GRID_W + GUI_GRID_X","5.5 * GUI_GRID_H + GUI_GRID_Y","11.5 * GUI_GRID_W","11 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]

/* #Vijeka
$[
	1.063,
	["TER_memP",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1602,"findBtn",[1,"Find Memorypoints",["0.559062 * safezoneW + safezoneX","0.64 * safezoneH + safezoneY","0.137812 * safezoneW","0.042 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"searchEd",[1,"",["0.559062 * safezoneW + safezoneX","0.262 * safezoneH + safezoneY","0.137812 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1603,"resetBtn",[1,"Reset",["0.565625 * safezoneW + safezoneX","0.71 * safezoneH + safezoneY","0.137812 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"",[1,"Search memorypoint:",["0.559062 * safezoneW + safezoneX","0.22 * safezoneH + safezoneY","0.13125 * safezoneW","0.028 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1802,"",[1,"",["0.545937 * safezoneW + safezoneX","0.206 * safezoneH + safezoneY","0.164062 * safezoneW","0.42 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1803,"",[1,"",["0.545937 * safezoneW + safezoneX","0.626 * safezoneH + safezoneY","0.164062 * safezoneW","0.07 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1804,"",[1,"",["0.545937 * safezoneW + safezoneX","0.696 * safezoneH + safezoneY","0.164062 * safezoneW","0.056 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2202,"treeSearch",[2,"",["24 * GUI_GRID_W + GUI_GRID_X","5.5 * GUI_GRID_H + GUI_GRID_Y","11.5 * GUI_GRID_W","11 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Terra, v1.063, #Vijeka)
////////////////////////////////////////////////////////
