#define CT_STATIC			  0
#define CT_BUTTON			  1
#define CT_EDIT				 2
#define CT_SLIDER			  3
#define CT_COMBO				4
#define CT_LISTBOX			 5
#define CT_TOOLBOX			 6
#define CT_CHECKBOXES		 7
#define CT_PROGRESS			8
#define CT_HTML				 9
#define CT_STATIC_SKEW		10
#define CT_ACTIVETEXT		 11
#define CT_TREE				 12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU	  14
#define CT_CONTROLS_GROUP	15
#define CT_SHORTCUTBUTTON	16
#define CT_XKEYDESC			40
#define CT_XBUTTON			 41
#define CT_XLISTBOX			42
#define CT_XSLIDER			 43
#define CT_XCOMBO			  44
#define CT_ANIMATED_TEXTURE 45
#define CT_CHECKBOX			77
#define CT_OBJECT			  80
#define CT_OBJECT_ZOOM		81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK		  98
#define CT_USER				 99
#define CT_MAP				  100
#define CT_MAP_MAIN			101
#define CT_LISTNBOX			102

#define ST_POS				0x0F
#define ST_HPOS			  0x03
#define ST_VPOS			  0x0C
#define ST_LEFT			  0x00
#define ST_RIGHT			 0x01
#define ST_CENTER			0x02
#define ST_DOWN			  0x04
#define ST_UP				 0x08
#define ST_VCENTER		  0x0C

#define ST_TYPE			  0xF0
#define ST_SINGLE			0x00
#define ST_MULTI			 0x10
#define ST_TITLE_BAR		0x20
#define ST_PICTURE		  0x30
#define ST_FRAME			 0x40
#define ST_BACKGROUND	  0x50
#define ST_GROUP_BOX		0x60
#define ST_GROUP_BOX2	  0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE	0x90
#define ST_WITH_RECT		0xA0
#define ST_LINE			  0xB0

#define ST_SHADOW			0x100
#define ST_NO_RECT		  0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE			 ST_TITLE_BAR + ST_CENTER

#define SL_DIR				0x400
#define SL_VERT			  0
#define SL_HORZ			  0x400

#define SL_TEXTURES		 0x10

#define ST_VERTICAL		 0x01
#define ST_HORIZONTAL	  0

#define LB_TEXTURES		 0x10
#define LB_MULTI			 0x20

#define TR_SHOWROOT		 1
#define TR_AUTOCOLLAPSE	2

#define MB_BUTTON_OK		1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER	 4

// Colors:
#define BLACK {0,0,0,1}
#define GREEN {0,1,0,1}
#define D_GREY_BACK {0.3,0.3,0.3,1}


class RscText
{
	access = 0;
	type = 0;
	idc = -1;
	colorBackground[] = {0,0,0,0};
	colorText[] = {0,1,0,1};
	text = "";
	fixedWidth = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 2;
	font = "puristaMedium";
	SizeEx = 0.03921;
	tooltipColorShade[] = BLACK;
	tooltipColorText[] = GREEN;
	tooltipColorBox[] = GREEN;
};
class RscButton
{
	access = 0;
	type = 1;
	text = "";
	colorText[] = {0,1,0,1};
	colorDisabled[] = {1,0,0,1};
	colorBackground[] = {0,0,0,0.5};
	colorBackgroundDisabled[] = {0.3,0.3,0.3,1};
	colorBackgroundActive[] = {1,1,1,1};
	colorFocused[] = {1,1,1,1};
	colorShadow[] = {0.023529,0,0.0313725,1};
	colorBorder[] = {0.023529,0,0.0313725,1};
	soundEnter[] = {"",0.09,1};
	soundPush[] = {"",0,0};
	soundClick[] = {"",0.07,1};
	soundEscape[] = {"",0.09,1};
	style = 2;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 2;
	font = "puristaMedium";
	sizeEx = 0.03921;
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	borderSize = 0;
	tooltipColorShade[] = BLACK;
	tooltipColorText[] = GREEN;
	tooltipColorBox[] = GREEN;
};
class RscButtonInv
{
	access = 0;
	type = 1;
	text = "";
	colorText[] = {0,1,0,0};
	colorDisabled[] = {1,0,0,0};
	colorBackground[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0.3,0.3,0.3,0};
	colorBackgroundActive[] = {1,1,1,0};
	colorFocused[] = {1,1,1,0};
	colorShadow[] = {0.023529,0,0.0313725,0};
	colorBorder[] = {0.023529,0,0.0313725,0};
	soundEnter[] = {"",0.09,0};
	soundPush[] = {"",0,0};
	soundClick[] = {"",0.07,0};
	soundEscape[] = {"",0.09,0};
	style = 2;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 2;
	font = "puristaMedium";
	sizeEx = 0.03921;
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	borderSize = 0;
	tooltipColorShade[] = {0,0,0,0};
	tooltipColorText[] = {0,0,0,0};
	tooltipColorBox[] = {0,0,0,0};
};
class RscPicture
{
	 access = 0;
	 idc = -1;
	 type = CT_STATIC;
	 style = ST_PICTURE;
	 colorBackground[] = {0,0,0,0};
	 colorText[] = {1,1,1,1};
	 font = "puristaMedium";
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
class RscEdit
{
	access = 0; 
	type = CT_EDIT; 
	style = ST_LEFT+ST_FRAME; 
	x = 0; 
	y = 0; 
	h = 0.04; 
	w = 0.2; 
	colorBackground[] = {0,0,0,0.5}; 
	colorText[] = GREEN;
	colorSelection[] = {1,1,1,0.25}; 
	colorDisabled[] = {1, 1, 1, 0.500000};
	font = "puristaMedium"; 
	sizeEx = 0.04; 
	autocomplete = ""; 
	text = "";
	size = 0.2; 
	shadow = 0;
	tooltipColorShade[] = BLACK;
	tooltipColorText[] = GREEN;
	tooltipColorBox[] = GREEN;
};
class RscFrame
{
	 type = CT_STATIC;
	 idc = -1;
	 style = ST_FRAME;
	 shadow = 2;
	 colorBackground[] = {1,1,1,1};
	 colorText[] = {0,1,0,1};
	 font = "puristaMedium";
	 sizeEx = 0.03;
	 text = "";
};
class IGUIBack
{ 
	 type = CT_STATIC;
	 idc = -1;
	 style = ST_CENTER;
	 shadow = 2;
	 colorText[] = {0,1,0,1};
	 font = "puristaMedium";
	 sizeEx = 0.02;
	 colorBackground[] = { 0,0,0, 0.8 }; 
	 text = ""; 

};
class RscCombo
{
	access = 0;
	type = 4;
	colorSelect[] ={0,0,0,1};
	colorText[] = GREEN;
	colorBackground[] ={0,0,0,1};
	colorScrollbar[] ={1,0,01};
	soundSelect[] ={"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1};
	soundExpand[] ={"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1};
	soundCollapse[] ={"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1};
	maxHistoryDelay = 1;
	class ComboScrollBar
	{
		color[] = {1,1,1,0.6};
		colorActive[] ={1,1,1,1};
		colorDisabled[] ={1,1,1,0.3};
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
	style = 16;
	x = 0;
	y = 0;
	w = 0.12;
	h = 0.035;
	shadow = 0;
	colorSelectBackground[] ={1,1,1,0.7};
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
	color[] = {1,1,1,1};
	colorActive[] ={1,0,0,1};
	colorDisabled[] ={1,1,1,0.25};
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	tooltipColorShade[] = BLACK;
	tooltipColorText[] = GREEN;
	tooltipColorBox[] = GREEN;
};
class RscListBox
{
	access = 0;
	type = 5;
	w = 0.4;
	h = 0.4;
	rowHeight = 0;
	colorText[] ={0,1,0,1};
	colorDisabled[] ={1,1,1,0.25};
	colorScrollbar[] ={1,0,0,1};
	colorSelect[] ={0,0,0,1};
	colorSelect2[] ={0,0,0,1};
	colorSelectBackground[] ={0.95,0.95,0.95,1};
	colorSelectBackground2[] ={1,1,1,0.5};
	colorBackground[] ={0,0,0,0.3};
	soundSelect[] ={"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1};
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	class ListScrollBar
	{
		color[] ={1,1,1,0.6};
		colorActive[] ={1,1,1,1};
		colorDisabled[] ={1,1,1,0.3};
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
	style = 16;
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 0;
	colorShadow[] ={0,0,0,0.5};
	color[] ={1,1,1,1};
	period = 1.2;
	maxHistoryDelay = 1;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	tooltipColorShade[] = BLACK;
	tooltipColorText[] = GREEN;
	tooltipColorBox[] = GREEN;
};
class RscCheckbox
{
	idc = -1;
	type = CT_CHECKBOX;
	style = ST_CENTER;
	x = 0;
	y = 0;
	h = 0.04;
	w = 0.2;
	text = "";
	font = "puristaMedium";
	sizeEx = 0.040;
	color[] = {0,1,0,1};
	colorDisabled[] = {0.4,0.4,0.4,1};
	colorText[] = {0,1,0,1};
	colorTextSelect[] = {0,1,0,1};
	colorPressed[] = GREEN;
	colorHover[] = {0,1,0,0.8};
	colorFocused[] = {0,1,0,1};
	colorBackground[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
	colorBackgroundPressed[] = {0,0,0,0};
	colorBackgroundHover[]= {0,0,0,0};
	colorBackgroundFocused[]= {0,0,0,0};
	textureChecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_checked_ca.paa";
	textureUnchecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_unchecked_ca.paa";
	textureDisabledChecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_checked_ca.paa";
	textureDisabledUnchecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_unchecked_ca.paa";
	texturePressedChecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_checked_ca.paa";
	texturePressedUnchecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_unchecked_ca.paa";
	textureHoverChecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_checked_ca.paa";
	textureHoverUnchecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_unchecked_ca.paa";
	textureFocusedChecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_checked_ca.paa";
	textureFocusedUnchecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_unchecked_ca.paa";
	soundEnter[] = { "", 0, 1 };
	soundPush[] = { "", 0, 1 };
	soundClick[] = { "", 0, 1 };
	soundEscape[] = { "", 0, 1 };
	tooltipColorShade[] = BLACK;
	tooltipColorText[] = GREEN;
	tooltipColorBox[] = GREEN;
};
class RscProgress
{
	type = 8;
	style = 0;
	colorFrame[] = {0,1,0,1};
	colorBar[] = {1,1,1,1};
	texture = "#(argb,8,8,3)color(1,1,1,1)";
	w = 1;
	h = 0.03;
};
class RscSlider
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 3;
	style = 1024;
	color[] = GREEN;
	colorActive[] = {1,1,1,1};
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.3;
	h = 0.025;
};
class RscTree
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 12;
	colorBackground[] = {0,0,0,0};
	colorSelect[] = {1,1,1,0.7};
	colorDisabled[] = {1,1,1,0.25};
	colorText[] = {1,1,1,1};
	colorSelectText[] = {0,0,0,1};
	colorBorder[] = {0,0,0,0};
	colorSearch[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
	colorMarked[] = {0.2,0.3,0.7,1};
	colorMarkedText[] = {0,0,0,1};
	colorMarkedSelected[] = {0,0.5,0.5,1};
	multiselectEnabled = 0;
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {0,0,0,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {0,0,0,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	colorArrow[] = {1,1,1,1};
	maxHistoryDelay = 1;
	shadow = 0;
	style = 0;
	font = "RobotoCondensed";
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	expandedTexture = "A3\ui_f\data\gui\rsccommon\rsctree\expandedTexture_ca.paa";
	hiddenTexture = "A3\ui_f\data\gui\rsccommon\rsctree\hiddenTexture_ca.paa";
	x = 0;
	y = 0;
	w = 0.1;
	h = 0.2;
	rowHeight = 0.0439091;
	colorSelectBackground[] = {0,0,0,0.5};
	colorLines[] = {0,0,0,0};
	borderSize = 0;
	expandOnDoubleclick = 1;
	class ScrollBar
	{
		color[] = {1,1,1,0.6};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		width = 0;
		height = 0;
		autoScrollEnabled = 0;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		shadow = 0;
		scrollSpeed = 0.06;
	};
};
class RscActiveText
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 11;
	style = 2;
	color[] = GREEN;
	colorActive[] = {1,1,1,1};
	colorDisabled[] = D_GREY_BACK;
	soundEnter[] = {"",0.1,1};
	soundPush[] = {"",0.1,1};
	soundClick[] = {"",0.1,1};
	soundEscape[] = {"",0.1,1};
	text = "";
	align = "left";
	default = 0;
	idc = -1;
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.035;
	font = "RobotoCondensed";
	shadow = 2;
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	url = "";
	tooltipColorShade[] = BLACK;
	tooltipColorText[] = GREEN;
	tooltipColorBox[] = GREEN;
};
class RscStructuredText
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 13;
	idc = -1;
	style = ST_LEFT;
	colorText[] = GREEN;
	class Attributes
	{
		font = "RobotoCondensed";
		color = "#00FF00";
		colorLink = "#0000FF";
		align = "left";
		shadow = -1;
	};
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.1;
	text = "";
	size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 0;
	tooltipColorShade[] = BLACK;
	tooltipColorText[] = GREEN;
	tooltipColorBox[] = GREEN;
};
class RscHTML
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 9;
	idc = -1;
	style = 0;
	filename = "";
	colorBackground[] = {0,0,0,0.8};
	colorText[] = GREEN;
	colorBold[] = GREEN;
	colorLink[] = {0,0,1,0.75};
	colorLinkActive[] = {0,0,1,1};
	colorPicture[] = {1,1,1,1};
	colorPictureLink[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureBorder[] = {0,0,0,0};
	tooltipColorText[] = GREEN;
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	class H1
	{
		font = "RobotoCondensed";
		fontBold = "RobotoCondensedBold";
		sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
		align = "left";
	};
	class H2
	{
		font = "RobotoCondensed";
		fontBold = "RobotoCondensedBold";
		sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		align = "right";
	};
	class H3
	{
		font = "RobotoCondensed";
		fontBold = "RobotoCondensedBold";
		sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		align = "left";
	};
	class H4
	{
		font = "RobotoCondensed";
		fontBold = "RobotoCondensedBold";
		sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		align = "left";
	};
	class H5
	{
		font = "RobotoCondensed";
		fontBold = "RobotoCondensedBold";
		sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		align = "left";
	};
	class H6
	{
		font = "RobotoCondensed";
		fontBold = "RobotoCondensedBold";
		sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		align = "left";
	};
	class P
	{
		font = "RobotoCondensed";
		fontBold = "RobotoCondensedBold";
		sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		align = "left";
	};
	x = 0;
	y = 0;
	w = 0.1;
	h = 0.1;
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	prevPage = "\A3\ui_f\data\gui\rsccommon\rschtml\arrow_left_ca.paa";
	nextPage = "\A3\ui_f\data\gui\rsccommon\rschtml\arrow_right_ca.paa";
	shadow = 2;
};




