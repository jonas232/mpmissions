_handle = execVM "functions.sqf";
waitUntil {scriptdone _handle};
FnDone = TRUE;
//----------------------------------------------------------------------------------
// SET ALL IMPORTANT VARIABLES
//----------------------------------------------------------------------------------
INVISIBLE_TIME = 5;
//SGS_KaufmenuOpen = false;
NewCycle = false;
bxMatDEF = "a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_emmisive.rvmat";//"a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_basic.rvmat";//;//
bxMatNEW = "a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat";

P1 = [p1_1,p1_2,p1_3,p1_4,p1_5];
P2 = [p2_1,p2_2,p2_3,p2_4,p2_5];
P3 = [p3_1,p3_2,p3_3,p3_4,p3_17];//p3_5,p3_6,p3_7,p3_8,p3_9,p3_10,p3_11,p3_12,p3_13,p3_14,p3_15,p3_16
P4 = [p4_1,p4_2,p4_3,p4_4,p4_17];//p4_5,p4_6,p4_7,p4_8,p4_9,p4_10,p4_11,p4_12,p4_13,p4_15,p4_16,p4_18
P5 = [p5_1,p5_2,p5_3,p5_4,p5_5];
//----------------------------------------------------------------------------------
// DEFINED BASIC COLORS
//----------------------------------------------------------------------------------
COLOR_BLUE = "#(argb,8,8,3)color(0,0.1,1,1)";
COLOR_DEFAULT = "#(argb,8,8,3)color(0.9,0.1,0,1)";
COLOR_RED = "#(argb,8,8,3)color(1,0,0,1)";
COLOR_GREEN = "#(argb,8,8,3)color(0,1,0,1)";
COLOR_WHITE = "#(argb,8,8,3)color(1,0,1,1)";
COLOR_BLACK = "#(argb,8,8,3)color(0,0,0,0)";
COLOR_BASIC = "#(argb,8,8,3)color(1.0,1.0,1.0,1.0,co)";

//----------------------------------------------------------------------------------
// MAKE NOIR NIGHT
//----------------------------------------------------------------------------------
skiptime 10;
//----------------------------------------------------------------------------------
// CREATE MARKERS OF ALL OBJECT TO MAP (THX KAREL)
//----------------------------------------------------------------------------------
{_x call bis_fnc_boundingBoxMarker} foreach (allMissionObjects "VR_Block_base_F");

//----------------------------------------------------------------------------------
// ACTIVATE KAUF MENU
//----------------------------------------------------------------------------------
waituntil {!(isNull (findDisplay 46))};
SGS_KaufMenu = (findDisplay 46) displayAddEventHandler ["KEYDOWN", {if (_this select 1 == 48) then{[] spawn fn_BuyingMenu;}}];
