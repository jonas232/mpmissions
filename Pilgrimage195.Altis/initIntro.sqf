introEnd = false;
goBoat = false;

0 fadeMusic 0;
0 fadeSound 0;
enableSentences false;
enableRadio false;

call compile preprocessFile "Intro\cam_fnc.sqf";

RYD_JR_Brother1 setDir 22;
RYD_JR_Brother1 setPos [3116.69,12561.7,0.5];
suit1 setDir 110;
suit1 setPos (RYD_JR_Brother1 modelToWorld [0.6,0.1,0]);

_ppos = RYD_JR_Brother1 modelToWorld [0,0,1.5];
_camPos = RYD_JR_Brother1 modelToWorld [0.8,-2.2,0.7];

an1 setPos _camPos;

_an2Pos = position an2;
_an2Pos set [2,8];
an2 setPos _an2Pos;

civ1 setDir 247.027;
civ1 setPos [3385.06,13015.4,5];
civ1 doWatch truck1;

showCinemaBorder false;
showHUD false;
camUseNVG false;

_cam = "camera" camCreate _camPos;
_cam cameraEffect ["internal","back"];

_handle = [_cam,_camPos,_camPos,an2,[],0,"","",false,false,true,false] call RYD_NND_Scene;
_cam camSetFocus [400, 1];
_cam camSetFov 0.05;
_cam camCommit 0;

_ppBlur = ppEffectCreate ["DynamicBlur", 1];
_ppBlur ppEffectEnable true;
_ppBlur ppEffectAdjust [5];
_ppBlur ppEffectCommit 0; 

_ppColor = ppEffectCreate ["colorCorrections", 3];
_ppColor ppEffectEnable true;
_ppColor ppEffectAdjust [1.0, 1.0, -0.35,[1.0, 1.0, 1.0, 0.0], [1.0, 0.8, 0.5, 0.1],[1, 1, 1, 0]];
//_ppColor ppEffectAdjust [ 1, 1, 0, [0, 0, 0, 0],[1, 1, 1, -0.1],[0.2, 0.59, 0.11, 0]];

goBoat = true;

sleep 3;
2 fadeSound 0.2;
3 fadeMusic 0.4;

sleep 4;

_ppColor ppEffectCommit 0;

TitleText ["", "BLACK IN", 1.5];

_ppBlur ppEffectAdjust [0.1];
_ppBlur ppEffectCommit 2; 

sleep 8;

_cam camSetFocus [1,1];
_cam camSetFov 1;
_cam camCommit 6;

_ppBlur ppEffectAdjust [0];
_ppBlur ppEffectCommit 6;

sleep 12;

1.5 fadeSound 0;

sleep 1;

for "_i" from 1 to 0.15 step -0.05 do
	{
	setAccTime _i;
	sleep 0.01
	};

_briefing = "Alex. Greetings from Altis. I'm on the island. It's chaos. People are scared, many have left. I can still hear distant shots and explosions. Perhaps you were right, but I'll complete my search. I need to act fast, before more people die, but if it's already unleashed... I don't know. Just, what we feared. Your brother.";

RYD_WS_Typed = false;

	[
		[
			[_briefing,"<t font='EtelkaMonospaceProBold' align='left' size='0.6' color='#000000' shadow='0'>%1</t>",nil]
		],
		
		0.45,
		-0.1,
		"<t align='left' size='0.6' color='#000000' shadow='0'>%1</t>"

	] 
spawn RYD_BIS_fnc_typeText;

waitUntil
	{
	sleep 0.1;
	RYD_WS_Typed
	};
		
playMusic "Sareri";
	
uiSleep 10;

TitleText ["", "BLACK OUT", 1.5];

_ppBlur ppEffectAdjust [10];
_ppBlur ppEffectCommit 2;

uiSleep 10;

setAccTime 1;

sleep 1;

_ppBlur ppEffectAdjust [0];
_ppBlur ppEffectCommit 0; 
_ppColor ppEffectEnable false;

_camPos = [7847.87,18005.7,1];
_anPos = +_camPos;
_anPos set [2,100];
an2 setPosATL _anPos;

_handle = [_cam,_camPos,_camPos,an2,[],0,"","",false,false,true,false] call RYD_NND_Scene;

_cam camSetFocus [100, 0];
_cam camSetFov 1.5;
_cam camCommit 0;

//[7847.87,18005.7,0.495773]\n23.2185"

skipTime 11;

sleep 2;

hbOn = false;
RYD_hbpause = 1.19;
RYD_hbadd = 0.1;

_handle = [] spawn
	{
	_pause = RYD_hbpause;
	
	while {true} do
		{
		hbOn = true;
		playSound ["hbeat",true];
		sleep _pause;
		hbOn = false;
		sleep RYD_hbadd;
		RYD_hbadd = RYD_hbadd + 0.1;
		}
	};
	
_handle2 = [_ppColor,_ppBlur] spawn
	{
	_ppColor = _this select 0;
	_ppBlur = _this select 1;
	
	_ppColor ppEffectAdjust [1, 1, 0,[1, 1, 1, 0], [1, 1, 1, 1],[1, 1, 1, 1]];
	_ppColor ppEffectCommit 0; 
	_ppColor ppEffectEnable true;
	
	while {true} do
		{
		waitUntil {not hbOn};
			
		_ppColor ppEffectAdjust [0.6, 1, -0.2,[1, 0.05, 0.025, 0.3], [1, 1, 1, 0.5],[1, 1, 1, 0.5]];
		_ppColor ppEffectCommit RYD_hbpause;
		
		_ppBlur ppEffectAdjust [5];
		_ppBlur ppEffectCommit RYD_hbpause; 
	
		waitUntil {hbOn};	
		
		_ppColor ppEffectAdjust [1, 1, 0,[1, 1, 1, 0], [1, 1, 1, 1],[1, 1, 1, 1]];
		_ppColor ppEffectCommit RYD_hbadd;
		
		_ppBlur ppEffectAdjust [0];
		_ppBlur ppEffectCommit RYD_hbadd; 		
		}
	};
	
3 fadeSound 1;

sleep 1;

TitleText ["", "BLACK IN", 1];

sleep 5;

_briefing = "Alex. Things went wrong. It was too dangeros. I should hve listened to you. Now is too late. Hurtsnot muh time lft. I am bleeding out fast. I found theplce but ths damn thing shot me, lsennbro tak careof mother I lv";

RYD_WS_Typed = false;

	[
		[
			[_briefing,"<t font='EtelkaMonospaceProBold' align='left' size='0.6' color='#000000' shadow='0'>%1</t>",nil]
		],
		
		0,
		0,
		"<t align='left' size='0.6' color='#000000' shadow='0'>%1</t>",
		0.4

	] 
spawn RYD_BIS_fnc_typeText;

waitUntil
	{
	sleep 0.1;
	RYD_WS_Typed
	};
	
3 fadeMusic 0;
	
sleep 2;

terminate _handle;

hbon = false;

sleep 3;

terminate _handle2;

_ppColor ppEffectAdjust [0, 1, -1,[1, 0.05, 0.025, 0.3], [1, 1, 1, 0.5],[1, 1, 1, 0.5]];
_ppColor ppEffectCommit 6;

_ppBlur ppEffectAdjust [10];
_ppBlur ppEffectCommit 6;

sleep 6;

TitleText ["", "BLACK OUT", 1];

sleep 3;

2 fadeSound 0;

sleep 3;

introEnd = true;