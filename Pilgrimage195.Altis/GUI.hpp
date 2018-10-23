#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

class PIL_RscText
{
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	type = 0;
	style = 0;
	shadow = 1;
	font = "PuristaMedium";
	text = "";
	lineSpacing = 1;
	SizeEx = 0.03;
	ColorBackground[] = {0,0,0,0};
	ColorText[] = {1,1,1,1};
	colorShadow[] = {0, 0, 0, 0.5};
};

class PIL_RscButton
{
	access = 0;
	type = 1;
	text = "";
	colorText[] = {0.8784,0.8471,0.651,0.8};
	colorDisabled[] = {0.4,0.4,0.4,0.3};
	colorBackground[] = {0.15, 0.4, 0.65,0.3};//{0.05, 0.5, 0.75,0.5};
	colorBackgroundDisabled[] = {0.95,0.95,0.95,0.3};
	colorBackgroundActive[] = {0.1, 0.3, 0.7,0.3};//{0.05, 0.5, 0.75,0.2};
	colorFocused[] = {0.1, 0.2, 0.6,0.3};//{0.05, 0.5, 0.75};
	colorShadow[] = {0.04,0.04,0.04,0.1};//{0.023529,0,0.0313725,1};
	colorBorder[] = {0.04,0.04,0.04,0.1};//{0.023529,0,0.0313725,1};
	soundEnter[] = {"\A3\ui_f\data\sound\rscbutton\soundenter" ,0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\rscbutton\soundpush" ,0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\rscbutton\soundclick" ,0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\rscbutton\soundescape" ,0.09,1};
	style = 2;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 2;
	font = "Puristamedium";
	sizeEx = 0.03;
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	borderSize = 0;
	};

class PIL_RscFrame
{
	type = 0;
	idc = -1;
	style = 64;
	shadow = 2;
	colorBackground[] = {0,0,0,0};
	colorText[] = {0.1,0.6,1,1};
	font = "Puristamedium";
	sizeEx = 0.03;
	text = "";
};

class ScrollBar 
	{
 	color[] = {1,1,1,0.6};
	colorActive[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.3};
	thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	shadow = 0;
 	};

class PIL_RscCombo
{
	access = 0;
	type = 4;
	style = 0;
	colorSelect[] = {0.023529,0,0.0313725,1};
	colorText[] = {0.023529,0,0.0313725,1};
	colorBackground[] = {0.75,0.75,0.75,0.9};
	colorScrollbar[] = {0.023529,0,0.0313725,0.9};
	colorSelectBackground[] = {0.6,0.6,0.6,0.85};//{0.8784,0.8471,0.651,1}
	soundSelect[] = {"\A3\ui_f\data\sound\rscbutton\soundclick",0.08,1};
	soundExpand[] = {"\A3\ui_f\data\sound\rscbutton\soundenter",1,1};
	soundCollapse[] = {"\A3\ui_f\data\sound\rscbutton\soundenter",1,1};
	maxHistoryDelay = 1;
	class ComboScrollBar : ScrollBar 
		{
	 	color[] = {0.95,0.95,0.95,0.3};
		colorActive[] = {0.95,0.95,0.95,0.3};
		colorDisabled[] = {0.95,0.95,0.95,0.3};
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		shadow = 0;
	 	};
 
	x = 0;
	y = 0;
	w = 0.12;
	h = 0.035;
	shadow = 0;
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
	color[] = {0,0,0,0.6};
	colorActive[] = {0,0,0,1};
	colorDisabled[] = {0,0,0,0.3};
	font = "Puristamedium";
	sizeEx = 0.03921;
};

class PIL_RscListBox
{
 access = 0;
 type = 5;
 style = 0;
 w = 0.4;
 h = 0.4;
 font = "PuristaMedium";
 sizeEx = 0.04;
 rowHeight = 0;
 colorText[] = {1,1,1,1};
 colorScrollbar[] = {1,1,1,1};
 colorSelect[] = {0,0,0,1};
 colorSelect2[] = {1,0.5,0,1};
 colorSelectBackground[] = {0.6,0.6,0.6,1};
 colorSelectBackground2[] = {0.2,0.2,0.2,1};
 colorBackground[] = {0,0,0,1};
 colorDisabled[] = {0,0,0,0.3};
 maxHistoryDelay = 1.0;
 soundSelect[] = {"",0.1,1};
 period = 1;
 autoScrollSpeed = -1;
 autoScrollDelay = 5;
 autoScrollRewind = 0;
 arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
 arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
 shadow = 0;
 class ListScrollBar : ScrollBar //ListScrollBar is class name required for Arma 3
 {
  color[] = {1,1,1,0.6};
  colorActive[] = {1,1,1,1};
  colorDisabled[] = {0,0,0,0.3};
  thumb = "#(argb,8,8,3)color(1,1,1,1)";
  arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
  arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
  border = "#(argb,8,8,3)color(1,1,1,1)";
  shadow = 0;
 };
};

class PIL_RscPicture
{
	access = 0;
	type = 0;
	idc = -1;
	style = 144;//48
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "TahomaB";
	sizeEx = 0;
	lineSpacing = 0;
	text = "";
	fixedWidth = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.15;
};

class PIL_Slider 
{
	idc = -1; 
	type = 3; 
	style = 1024; 
	x = 0.4; 
	y = 0.2; 
	w = 0.3; 
	h = 0.025; 
	color[] = {0.1,0.6,1,1}; 
	coloractive[] = {0.1,0.6,1,1};
	onSliderPosChanged = "";
};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Rydygier, v1.063, #Syfezo)
////////////////////////////////////////////////////////

class RscDecoy
	{
	IDD = 25000;
	name= "DECOY";
	onLoad = "";
	MovingEnable = 0;
	enableSimulation = true;

	class controls
		{
		class RscBack_Decoy: PIL_RscPicture
			{
			idc = 17980;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 24 * GUI_GRID_W;
			h = 6 * GUI_GRID_H;
			text = "#(argb,8,8,3)color(0.01,0.1,0.3,0.25)";			
			};
			
		class RscFrame_Decoy: PIL_RscFrame
			{
			idc = 17990;
			text = "VALUE";
			x = 8.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 5.5 * GUI_GRID_H;
			sizeEx = 1 * GUI_GRID_H;
			};
			
		class RscSlider_decoy: PIL_Slider 
			{
			idc = 18000;
			x = 9 * GUI_GRID_W + GUI_GRID_X;
			y = 6.75 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			onSliderPosChanged = "ctrlSetText [18001,str ((floor((sliderPosition 18000)/100)) * 100)];";
			};
			
		class RscText_decoy: PIL_RscText 
			{
			idc = 18001;
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8.25 * GUI_GRID_H + GUI_GRID_Y;
			w = 13 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			text = "1000";
			SizeEx = 0.055;
			ColorText[] = {0.9,0.9,1,1};
			colorShadow[] = {0, 0, 0, 0};
			};
			
		class RscButton_Decoy: PIL_RscButton
			{
			idc = -1;
			text = "DECOY";
			x = 25 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 5 * GUI_GRID_H;
			colorText[] = {0.9,0.9,1,1};
			sizeEx = 1.5 * GUI_GRID_H;
			action = "RYD_JR_DecoyCost = ((floor((sliderPosition 18000)/100)) * 100);closeDialog 1";
			};
		};			
	};
	
class RscHealRep
	{
	IDD = 25001;
	name= "HealRep";
	onLoad = "";
	MovingEnable = 0;
	enableSimulation = true;

	class controls
		{
		class RscBack_HR: PIL_RscPicture
			{
			idc = 0;
			x = 10 * GUI_GRID_W + GUI_GRID_X;
			y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 20 * GUI_GRID_W;
			h = 12 * GUI_GRID_H;
			text = "#(argb,8,8,3)color(0.01,0.1,0.3,0.25)";			
			};
			
		class RscText_HR: PIL_RscText 
			{
			idc = 1;
			style = 16;
			SizeEx = 0.04;
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 18 * GUI_GRID_W;
			h = 7 * GUI_GRID_H;
			text = "";
			};
			
		class RscButton1_decoy: PIL_RscButton
			{
			idc = 2;
			text = "YES";
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 13.25 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			colorText[] = {0.9,0.9,1,1};
			sizeEx = 1.5 * GUI_GRID_H;
			action = "closeDialog 1;RYD_JR_ServiceArr spawn RYD_JR_HR";
			};
			
		class RscButton2_Decoy: PIL_RscButton
			{
			idc = 3;
			text = "NO";
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 13.25 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			colorText[] = {0.9,0.9,1,1};
			sizeEx = 1.5 * GUI_GRID_H;
			action = "closeDialog 1";
			};
		};			
	};

class RscPIO
	{
	IDD = 2500;
	name= "PIO";
	onLoad = "";
	MovingEnable = 0;
	enableSimulation = true;
		
	class controls
		{
		class RscBack: PIL_RscPicture
			{
			idc = 1798;
			x = 5 * GUI_GRID_W + GUI_GRID_X;
			y = -2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 30 * GUI_GRID_W;
			h = 29.5 * GUI_GRID_H;
			text = "Pic\GUIBack.paa";//"#(argb,8,8,3)color(0.01,0.1,0.3,0.25)";			
			};
		
		class RscFrame_PIO: PIL_RscFrame
			{
			idc = 1799;
			text = "PILGRIMAGE version 1.95";
			x = 5.5 * GUI_GRID_W + GUI_GRID_X;
			y = -2.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 29 * GUI_GRID_W;
			h = 29 * GUI_GRID_H;
			sizeEx = 1 * GUI_GRID_H;
			};
				
		class LootDens_Frame: PIL_RscFrame
			{
			idc = 1800;
			text = "Loot occurence";
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = -1 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};
			
		class LootDens_Combo: PIL_RscCombo
			{
			idc = 2100;
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Adjust loot occurrence density; 100% - roughly one box per 25 house positions in NORMAL distribution mode;";
			};
			
		class LootVal_Frame: PIL_RscFrame
			{
			idc = 1801;
			text = "Loot distribution";
			x = 16 * GUI_GRID_W + GUI_GRID_X;
			y = -1 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};
			
		class LootVal_Combo: PIL_RscCombo
			{
			idc = 2101;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Adjust loot distribution mode; A - loot may be found randomly in the most enterable buildings; N - weapons rare in civilian houses; R - no loot in civilian buildings. More loot at bodies and strategic areas; NW - no weapons at bodies;";
			};
			
		class AlwaysA_Frame: PIL_RscFrame
			{
			idc = 1802;
			text = "Proper ammo in loot";
			x = 26 * GUI_GRID_W + GUI_GRID_X;
			y = -1 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};	
			
		class AlwaysA_Combo: PIL_RscCombo
			{
			idc = 2102;
			x = 26.5 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "When loot containing a weapon should also provide some proper ammunition";
			};
			
		class GarrDens_Frame: PIL_RscFrame
			{
			idc = 1803;
			text = "Garrisons density";
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};
			
		class GarrDens_Combo: PIL_RscCombo
			{
			idc = 2103;
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Adjust garrisons density - probability of presence tested for each of maximal number (around 150 groups)";
			};
			
		class CPDens_Frame: PIL_RscFrame
			{
			idc = 1804;
			text = "Checkpoints density";
			x = 16 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};
			
		class CPDens_Combo: PIL_RscCombo
			{
			idc = 2104;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Adjust checkpoints density - probability of presence tested for each of maximal number (around 70 groups)";
			};
									
		class HCDens_Frame: PIL_RscFrame
			{
			idc = 1805;
			text = "Hidden camps density";
			x = 26 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};
			
		class HCDens_Combo: PIL_RscCombo
			{
			idc = 2105;
			x = 26.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Adjust hidden camps density - probability of presence tested for each of maximal number (24 groups)";
			};
			
		class SCAD_Frame: PIL_RscFrame
			{
			idc = 1806;
			text = "Civilian population";
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};	
			
		class SCAD_Combo: PIL_RscCombo
			{
			idc = 2106;
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Density of civilian population around the player. Maximal number of civilian units spawned around at a time";
			};
				
		class SCAR_Frame: PIL_RscFrame
			{
			idc = 1807;
			text = "Civilian spread";
			x = 16 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};	
			
		class SCAR_Combo: PIL_RscCombo
			{
			idc = 2107;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Radius around the player, that should be populated with civilians depending on buildings count";
			};
			
		class AIFriend_Frame: PIL_RscFrame
			{
			idc = 1808;
			text = "Companion";
			x = 26 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};	
			
		class AIFriend_Combo: PIL_RscCombo
			{
			idc = 2108;
			x = 26.5 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Switch presence of a second member (medic) in your team";
			};
			
		class Arty_Frame: PIL_RscFrame
			{
			idc = 1809;
			text = "Artillery";
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};
			
		class Arty_Combo: PIL_RscCombo
			{
			idc = 2109;
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = 9 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Switch presence of hostile artillery pieces; MORE AMMO - default number of shells for artillery multiplied by 4";
			};
			
		class AP_Frame: PIL_RscFrame
			{
			idc = 1810;
			text = "Air SAD range";
			x = 16 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};
			
		class AP_Combo: PIL_RscCombo
			{
			idc = 2110;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 9 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "How far chopper can patrol: VL - 12000; L - 7500; M - 4000; S - 1500; D - no choppers on map";
			};
			
		class AmbientC_Frame: PIL_RscFrame
			{
			idc = 1811;
			text = "Ambient combat";
			x = 26 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};	
			
		class AmbientC_Combo: PIL_RscCombo
			{
			idc = 2111;
			x = 26.5 * GUI_GRID_W + GUI_GRID_X;
			y = 9 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Intensity of ambient combat around the player. If enabled - east and resistance are hostile to each other; L - limited amount of spawns per given area";
			};
			
		class NoItems_Frame: PIL_RscFrame
			{
			idc = 1812;
			text = "Difficulty";
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 11 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};
			
		class NoItems_Combo: PIL_RscCombo
			{
			idc = 2112;
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Set difficulty; E - better gear at start; N - default; H - no map markers revealing position of the player; VH - ditto + no map, GPS, radio, compass and watch; I - ditto + no gear at all";
			};	
			
		class MultiHC_Frame: PIL_RscFrame
			{
			idc = 1813;
			text = "Multiple hideouts";
			x = 16 * GUI_GRID_W + GUI_GRID_X;
			y = 11 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};
			
		class MultiHC_Combo: PIL_RscCombo
			{
			idc = 2113;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Switch adding next hideouts instead of moving the only one";
			};
			
		class GCIntel_Frame: PIL_RscFrame
			{
			idc = 1814;
			text = "Circle Intel";
			x = 26 * GUI_GRID_W + GUI_GRID_X;
			y = 11 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};	
			
		class GCIntel_Combo: PIL_RscCombo
			{
			idc = 2114;
			x = 26.5 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Chance for Intel pointing an area containing the body location";
			};

		class KillCross_Frame: PIL_RscFrame
			{
			idc = 1815;
			text = "Mark bodies";
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 14 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};	
			
		class KillCross_Combo: PIL_RscCombo
			{
			idc = 2115;
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Switch marking killed enemies mode";
			};
						
		class LootMarks_Frame: PIL_RscFrame
			{
			idc = 1816;
			text = "3D icons";
			x = 16 * GUI_GRID_W + GUI_GRID_X;
			y = 14 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};
			
		class LootMarks_Combo: PIL_RscCombo
			{
			idc = 2116;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Which 3D icons should be displayed; LLI - 2/3 of loot icons hidden; NLI - all loot icons hidden; CO - visible only civilian sentences";
			};
				
		class Phone_Frame: PIL_RscFrame
			{
			idc = 1817;
			text = "Phone and ADM";
			x = 26 * GUI_GRID_W + GUI_GRID_X;
			y = 14 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};
			
		class Phone_Combo: PIL_RscCombo
			{
			idc = 2117;
			x = 26.5 * GUI_GRID_W + GUI_GRID_X;
			y = 15 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Switch phone calls and ADM Intel offers";
			};
			
		class Daytime_Frame: PIL_RscFrame
			{
			idc = 1818;
			text = "Initial daytime";
			x = 6 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};	
			
		class Daytime_Combo: PIL_RscCombo
			{
			idc = 2118;
			x = 6.5 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Choose initial daytime";
			};
					
		class StartM_Frame: PIL_RscFrame
			{
			idc = 1819;
			text = "Landing area";
			x = 16 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};	
			
		class StartM_Combo: PIL_RscCombo
			{
			idc = 2119;
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Choose part of the coast for landing";
			};
														
		class Caching_Frame: PIL_RscFrame
			{
			idc = 1820;
			text = "Caching mode";
			x = 26 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 8 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			};	
			
		class Caching_Combo: PIL_RscCombo
			{
			idc = 2120;
			x = 26.5 * GUI_GRID_W + GUI_GRID_X;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Switch caching mode (D-R - more FPS; H-S - conservative; try H-S only if D-R won't work properly; B - only Ambient Combat's bodies and wrecks are removed)";
			};
														
		class RscButton_PIO: PIL_RscButton
			{
			idc = -1;
			text = "BEGIN YOUR PILGRIMAGE";
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 23.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 2.5 * GUI_GRID_H;
			colorText[] = {0.9,0.9,1,1};
			sizeEx = 1 * GUI_GRID_H;
			action = "[] call RYD_TakeValues;closeDialog 1";
			};
		};
	};

class RscShop
	{
	IDD = 25002;
	name= "SHOP";
	MovingEnable = 0;
	enableSimulation = false;
	onLoad = "";

	class controlsBackground
		{
		class RscBack_Shop: PIL_RscPicture
			{
			idc = 0;
			x = -2 * GUI_GRID_W + GUI_GRID_X;
			y = -2 * GUI_GRID_H + GUI_GRID_Y;
			w = 44 * GUI_GRID_W;
			h = 29.25 * GUI_GRID_H;
			text = "#(argb,8,8,3)color(0.01,0.1,0.3,0.25)";			
			};
			
		class RscFrame_Shop: PIL_RscFrame
			{
			idc = 1;
			text = "SCAVENGER'S STASH";
			x = -1.5 * GUI_GRID_W + GUI_GRID_X;
			y = -1.75 * GUI_GRID_H + GUI_GRID_Y;
			w = 43 * GUI_GRID_W;
			h = 28.25 * GUI_GRID_H;
			sizeEx = 1 * GUI_GRID_H;
			};
			
		class RscListBox_merch: PIL_RscListBox 
			{
			idc = 2;
			x = -0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 21 * GUI_GRID_W;
			h = 23 * GUI_GRID_H;
			rowHeight = 1.5 * GUI_GRID_H;
			sizeEx = 1 * GUI_GRID_H;
			colorText[] = {0.9,0.9,1,1};
			colorScrollbar[] = {1,1,1,1};
			colorSelect[] = {0.9,0.9,1,1};
			colorSelect2[] = {1,1,1,1};
			colorSelectBackground[] = {0.01,0.1,0.3,0.5};
			colorSelectBackground2[] = {0.01,0.1,0.3,0.75};
			colorBackground[] = {0.01,0.1,0.3,0.25};
			};
												
		class RscBack_Shop_desc: PIL_RscPicture
			{
			idc = 3;
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 0.45 * GUI_GRID_H + GUI_GRID_Y;
			w = 18.25 * GUI_GRID_W;
			h = 10.5 * GUI_GRID_H;
			text = "#(argb,8,8,3)color(0.01,0.1,0.3,0.25)";			
			};
			
		class RscText_Shop_desc: PIL_RscText 
			{
			idc = 4;
			type = 13;
			style = 16+512;
			x = 22.5 * GUI_GRID_W + GUI_GRID_X;
			y = 1 * GUI_GRID_H + GUI_GRID_Y;
			w = 17.25 * GUI_GRID_W;
			h = 9.5 * GUI_GRID_H;
			text = "Here's, what I have...";
			sizeEx = 0.7 * GUI_GRID_H;
			ColorText[] = {0.9,0.9,1,1};
			colorShadow[] = {0, 0, 0, 0};
			
			size = 0.8 * GUI_GRID_H;
			class Attributes 
				{
				font = "PuristaMedium";
				//color = "#000000";
				//align = "left";
				//valign = "middle";
				//shadow = 0;
				//shadowColor = "#ff0000";
				//size = "1.25";
				};
			};
			
		class RscFrame_Shop_desc: PIL_RscFrame
			{
			idc = 5;
			text = "DESCRIPTION";
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 18.25 * GUI_GRID_W;
			h = 11 * GUI_GRID_H;
			sizeEx = 0.8 * GUI_GRID_H;
			};
									
		class RscBack_Shop_preview: RscBack_Shop_desc
			{
			idc = 7;
			y = 11.45 * GUI_GRID_H + GUI_GRID_Y;
			h = 5.5 * GUI_GRID_H;		
			};
			
		class RscText_Shop_preview: PIL_RscPicture 
			{
			idc = 8;
			style = 144 + 2048;
			x = 22.25 * GUI_GRID_W + GUI_GRID_X;
			y = 12 * GUI_GRID_H + GUI_GRID_Y;
			w = 17.75 * GUI_GRID_W;
			h = 4.5 * GUI_GRID_H;
			};
						
		class RscFrame_Shop_preview: RscFrame_Shop_desc
			{
			idc = 9;
			text = "PREVIEW";
			y = 11 * GUI_GRID_H + GUI_GRID_Y;
			h = 6 * GUI_GRID_H;
			};
			
		class RscBack_Shop_price: RscBack_Shop_desc
			{
			idc = 10;
			y = 17.45 * GUI_GRID_H + GUI_GRID_Y;
			h = 2.5 * GUI_GRID_H;		
			};
			
		class RscText_Shop_price: RscText_Shop_desc 
			{
			idc = 11;
			y = 18 * GUI_GRID_H + GUI_GRID_Y;
			h = 1.5 * GUI_GRID_H;
			text = "";
			sizeEx = 1.5 * GUI_GRID_H;
			size = 1.5 * GUI_GRID_H;
			};
						
		class RscFrame_Shop_price: RscFrame_Shop_desc
			{
			idc = 12;
			text = "PRICE";
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			h = 3 * GUI_GRID_H;
			};
			
		class RscBack_Shop_account: RscBack_Shop_desc
			{
			idc = 13;
			y = 20.45 * GUI_GRID_H + GUI_GRID_Y;
			h = 2.5 * GUI_GRID_H;			
			};
			
		class RscText_Shop_account: RscText_Shop_desc 
			{
			idc = 14;
			y = 21 * GUI_GRID_H + GUI_GRID_Y;
			h = 1.5 * GUI_GRID_H;
			text = "";
			sizeEx = 1.5 * GUI_GRID_H;
			size = 1.5 * GUI_GRID_H;
			};
						
		class RscFrame_Shop_account: RscFrame_Shop_desc
			{
			idc = 15;
			text = "ACCOUNT";
			y = 20 * GUI_GRID_H + GUI_GRID_Y;
			h = 3 * GUI_GRID_H;
			};
						
		class RscButton_Shop_buy: PIL_RscButton
			{
			idc = 16;
			text = "BUY";
			x = -0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 23.75 * GUI_GRID_H + GUI_GRID_Y;
			w = 21 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorText[] = {0.9,0.9,1,1};
			sizeEx = 1.5 * GUI_GRID_H;
			soundEnter[] = {"" ,0.09,1};
			soundPush[] = {"" ,0.09,1};
			soundClick[] = {"a3\missions_f_beta\data\sounds\firing_drills\target_pop-up_small.wss",1,1};
			soundEscape[] = {"" ,0.09,1};
			action = "[] call RYD_JR_BuyThis;";
			};
			
		class RscButton_Shop_exit: PIL_RscButton
			{
			idc = 17;
			text = "EXIT";
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 23.75 * GUI_GRID_H + GUI_GRID_Y;
			w = 18.25 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			colorText[] = {0.9,0.9,1,1};
			sizeEx = 1.5 * GUI_GRID_H;
			action = "playSound 'FD_CP_Not_Clear_F';RYD_JR_ShopBox = objNull;closeDialog 1";
			};
		};		
	};