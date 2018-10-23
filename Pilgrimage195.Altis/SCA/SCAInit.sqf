call compile preprocessfile "SCA\SCA_fnc.sqf";

RYD_SCA_CivilianClasses = [] call RYD_SCA_AllFromSide;

RYD_SCA_CivilianClasses = RYD_SCA_CivilianClasses - ["C_journalist_F","C_scientist_F","C_man_pilot_F","C_Driver_1_F","C_Driver_2_F","C_Driver_3_F","C_Driver_4_F","C_Marshal_F"];

RYD_SCA_Clothes = 
	[
	"U_Competitor",
	"U_C_HunterBody_grn",
	"U_C_Poloshirt_blue",
	"U_C_Poloshirt_burgundy",
	"U_C_Poloshirt_redwhite",
	"U_C_Poloshirt_salmon",
	"U_C_Poloshirt_stripped",
	"U_C_Poloshirt_tricolour",
	"U_C_Poor_1",
	"U_IG_Guerilla2_2",
	"U_IG_Guerilla2_3",
	"U_IG_Guerilla3_1",
	"U_IG_Guerilla3_2",
	"U_NikosBody",
	//"U_OrestesBody",
	"U_Rangemaster",
	"U_C_Journalist",
	"U_NikosAgedBody",
	"U_Marshal"
	];
	
RYD_SCA_Positions = [];
RYD_SCA_Buildings = [];
RYD_SCA_Civilians = [];

RYD_SCA_NearCivilians = [];
RYD_SCA_HostileToSpawn = 0;
RYD_SCA_FriendlyToSpawn = 0;

RYD_SCA_CivWeapons = 
	[
	"hgun_ACPC2_F",
	"hgun_P07_F",
	"",
	"",
	"",
	"",
	"",
	""
	];


RYD_SCA_LastPlayerPos = [0,0,0];
RYD_SCA_Spawning = false;
RYD_SCA_LastFire = [-1000,objNull];

RYD_SCA_LastCivCount = 0;

_civHQ = createCenter civilian;

	{
	_x addEventHandler ["Fired",{nul = _this call RYD_SCA_Fired}];
	}
foreach RYD_JR_Recruitable + [player];
