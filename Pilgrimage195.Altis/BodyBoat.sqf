_boat = [(_this select 0),RYD_JR_boats] call RYD_JR_FindClosest;

//_boat = RYD_JR_Boat;

if (isNull _boat) exitWith {hint "No boat near"};

has_body_boat = true;
RYD_JR_Outro = true;

_txt = "Loading the body...";
0.5 fadeSound 0;
TitleText [_txt,"BLACK OUT",0.55];

sleep 1;

deleteVehicle RYD_JR_Brother;

if (RYD_JR_AIFriend) then
	{
	if not (isNull AIBuddy) then
		{
		if (alive AIBuddy) then
			{
			AIBuddy moveInCargo _boat
			}
		}
	};
	
RYD_JR_Fame = 0;
RYD_JR_Glory = 0;
RYD_JR_Infamy = 0;
	
	{
	_vl = _x select 0;
	RYD_JR_Fame = RYD_JR_Fame + (abs _vl);
	if (_vl > 0) then
		{
		RYD_JR_Glory = RYD_JR_Glory + _vl
		}
	else
		{
		RYD_JR_Infamy = RYD_JR_Infamy + _vl
		}
	}
foreach RYD_JR_RepEvents;

	{
	switch (true) do
		{
		case (isNil {_x}) : {RYD_JR_ReleasedPOW set [_foreachIndex,0]};
		case not ((typeName _x) isEqualTo (typeName objNull)) : {RYD_JR_ReleasedPOW set [_foreachIndex,0]};
		case (isNull _x) : {RYD_JR_ReleasedPOW set [_foreachIndex,0]};
		case not (alive _x) : {RYD_JR_ReleasedPOW set [_foreachIndex,0]};
		}
	}
foreach RYD_JR_ReleasedPOW;

RYD_JR_ReleasedPOW = RYD_JR_ReleasedPOW - [0];

_alivePOW = "";
_add = "";

	{
	if (_foreachIndex > 0) then {_add = ", "};
	_alivePOW = _alivePOW + _add + (name _x);
	}
foreach RYD_JR_ReleasedPOW;

if (isNull (driver _boat)) then
	{
	player moveInDriver _boat;
	}
else
	{
	player moveInCargo _boat
	};

0.5 fadeSound 1;
TitleText [_txt,"BLACK IN",0.55];

sleep 0.6;
	
TitleText ["It's done. Now, my brother, I'll take you home.","PLAIN DOWN", 2];

enableSentences false;
enableRadio false;

sleep 5;

2 fadeSound 0;
TitleText ["", "BLACK OUT", 2];

RYD_JR_isPlaying = true;
//LeadTrack01_F_EPA
_handle = ["Sareri",339] spawn
	{
	terminate RYD_JR_mHandle;
	
	1 fadeMusic 0;
		
	sleep 1.5; 
	
	playMusic (_this select 0);
	
	3 fadeMusic 0.4;
	
	//sleep 0.5;
						
	sleep (_this select 1);
	
	RYD_JR_LastPlay = time;
	RYD_JR_isPlaying = false;
	};

sleep 3;

	{
	_x allowDamage false;
	_x setCaptive true
	}
foreach (units (group player));

M_cam = "camera" camCreate [2668.46,12383.7,5];
M_cam setDir 50;
M_cam cameraEffect ["internal", "BACK"];
M_cam camCommit 0;

_sPos = visiblePositionASL M_cam;

an1 setPosASL _sPos;
an2 setPosASL _sPos;

an1 setDir 50;
an2 setDir 50;

M_cam attachTo [an1,an1 worldToModel (visiblePositionASL M_cam)];

M_cam cameraEffect ["internal","back"];

setDate [2030, 6, 24, 5, 0];
0 setOvercast 0.51;
forceWeatherChange;

sleep 2;

TitleText ["", "BLACK IN", 1];
	
3 fadeSound 0.2;
3 fadeMusic 1;

sleep 5;

_handle = [M_cam,an1,an1,an2,[0,0,50],600] spawn RYD_NND_MoveCamRel;

sleep 10;

6 fadeSound 0;

["THE END<br/><br/>(Press SPACE for debriefing)", 0, 0.5, 4, 1, 0, 0] call BIS_fnc_dynamicText;

sleep 2;

creditsDone = false;

Credits_handle = [] spawn
	{
	_tme = time;
	["PILGRIMAGE", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["Design<br/><br/>RYDYGIER", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["Mission scripts<br/><br/>RYDYGIER", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["Arma 3<br/><br/>BOHEMIA INTERACTIVE", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["Additional music:", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["SAVINA YANNATOU<br/><br/>Sareri Hovin Mernem", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["My thanks to:", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["All, who supported Pilgrimage MANW entry", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["All playthrough youtubers<br/><br/>especially LEADMINER21, TITUS GROAN and SCOTT (Royal Gamers UK)", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["Special thanks to all feedback providers, especially most active:", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["NEOFIT", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["DOC. CALIBAN", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["TORTUOSIT", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["ALKY_LEE", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["LAW-GIVER", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["PVT. PARTZ", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["TEOLEO", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["KOMMIEKAT", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["ALEX72", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["FRAGMENTPRUTS", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["KHUGAN", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["ALPHA-KILO", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["EBARSTAD", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["GIORGYGR", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["ROBALO", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["RSOFTOKZ", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["-LORDSOTH-", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["BOUBEN", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["DIGITALCENTURION", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;	
	["TORSKEE", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["MAJOR-STIFFY", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["A2012V", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["OMAC", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["VAFANA", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["TETET", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	["...and to so many people supporting this project in any way", 0, 0.35, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	_lasT = format ["and of course thank YOU %1 for playing!",profileName];
	[_lasT, 0, 0.5, 4, 1, 0, 0] call BIS_fnc_dynamicText;
	//["Press SPACE for debriefing", 0, 1, 8, 1, 0, 0] call BIS_fnc_dynamicText;

	waitUntil {sleep 0.1; (not RYD_JR_isPlaying)};
	
	creditsDone = true;
	};
	
_eh = (findDisplay 46) displayAddEventHandler ["KeyDown", "if not ((_this select 1) in [57]) exitWith {};terminate Credits_handle;creditsDone = true"];
	
waitUntil
	{
	sleep 0.1;
	
	(creditsDone)
	};
	
_ppBlur = ppEffectCreate ["DynamicBlur", 1];
_ppBlur ppEffectAdjust [0.08];

_ppGrain = ppEffectCreate ["FilmGrain", 2];
_ppGrain ppEffectAdjust [0.1, 2.05, 0.23, 0.11, 0, true];

_ppChrom = ppEffectCreate ["chromAberration", 3];
_ppChrom ppEffectAdjust [0.005,0.005,true];

_ppGrain ppEffectEnable true;
_ppBlur ppEffectEnable true;
_ppChrom ppEffectEnable true;

_ppGrain ppEffectCommit 2;
_ppBlur ppEffectCommit 2;
_ppChrom ppEffectCommit 2;
	
(findDisplay 46) displayRemoveEventHandler ["KeyDown", _eh];

5 fadeMusic 0;

sleep 2;

_ppBlur ppEffectAdjust [5];
_ppBlur ppEffectCommit 3; 

sleep 3;

_statList = 
	[
	"Total FF gained: ",
	(str RYD_JR_FuelFundGain),
	"<br/>",
	"Total FF spent: ",
	(str RYD_JR_FuelFundSpent),	
	"<br/>",
	"Final account: ",
	(str RYD_JR_FuelFund),
	"<br/>",
	"People asked: ",
	(str RYD_JR_Asked),
	"<br/>",
	"Prisoners interrogated: ",
	(str RYD_JR_Interrogated),
	"<br/>",
	"Data sources checked: ",
	(str RYD_JR_Searched),
	"<br/>",
	"Kilometers fast travelled: ",
	(str ((round ((RYD_JR_FTDistance/1000) * 10))/10)),
	"<br/>",
	"Holy places checked out: ",	
	(str ({((count _x) == 3)} count RYD_JR_allHolyPlaces)),
	"<br/>",
	"Rescued prisoners: ",
	_alivePOW,
	"<br/>",
	"Fame: ",	
	(str (round RYD_JR_Fame)),
	"<br/>",
	"Glory: ",	
	(str (round RYD_JR_Glory)),
	"<br/>",
	"Infamy: ",	
	(str (round RYD_JR_Infamy))
	];
	
_stats = "";

	{
	_stats = _stats + _x
	}
foreach _statList;

missionNameSpace setVariable ["RYD_JR_stats",_stats];

_rating = rating RYD_JR_Alex;
if (_rating > 100000) then {RYD_JR_Alex addRating -100000};

["END1",true,true,false] call BIS_fnc_endMission;