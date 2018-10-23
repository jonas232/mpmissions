setviewdistance 200;
// SET DEDAULT VALUES OF WEAPONS
SGS_WP0_COST = 2;
SGS_WP1_COST = 4;
SGS_WP2_COST = 6;
SGS_WP3_COST = 8;
SGS_WP4_COST = 10;

//COLORIZED BLOCK
[] execVM "colorNew.sqf";

/*
	//EXEC DECOY SCRIPT
	//[] execvm "decoy.sqf";
*/

// disable rabbits and snakes
enableEnvironment [false,false];
player creatediarysubject ["SGS_Spectrum", localize "STR_A3_EndGame_RulesTips"];
// Tips
player creatediaryrecord ["SGS_Spectrum",[localize "str_a3_firingdrills_tips0",
	"<br/>
	VIDEO <br/>
	1) Make sure that your full screen anti-aliasng is ON.<br/>
	2) Disable BLOOM , ROTATION  and RADIAL BLUR, for rest your eyes.<br/>
	"
]];
// Rules
player creatediaryrecord ["SGS_Spectrum",[localize "str_a3_firing_drills_diary_rec2_title",
	"<br/>
	BASIC <br/>
	1) This mode always pits four teams which are trying to synchronize portals in arena.<br/>
	2) Match ends when one of the teams reach 100th point (Server param, can be adujested)	<br/>
	3) You can buy new weapon only in respawn area by presing [B]<br/>
	4) If you enter opponents respawn area, you will be executed<br/>
	5) Teamkill is ON.<br/>
	6) If you throw away your uniform. You will be execute.<br/>
	7) If you are injured a lot, holdaction for healing will appear. (No first AidKit needed)<br/>
	8) When you drop your VR uniform you will be execute!<br/>
	<br/>
	ECONOMY<br/>
	You can get points for:<br/>
	1) killing players from other team (+2 or +3 by pistol)<br/>
	2) synchronizing with portals (+2 points) <br/>
	3) after each respawn (+1 point)<br/>
	<br/>
	TEAM SCORE<br/>
	Every 20 seconds your team will earn the same number of points as number of owns portals.<br/>
	Hint: Synchronize your color in portal (Use hold action inside portal). Synchronization process itself takes five second.<br/>
	<br/>
	SPECTRUM MECHANICS<br/>
	1) Your uniform will colorize closest VR block to the same color as yours.<br/>
	2) Decoy (IR Grenade) - You can throw decoy which will colorize closest block for few sseconds to your color.(fake your movement).<br/>
	"
]];
// Give money for warmup
if (isnil "s1") then {player setvariable ["SGS_Money",10]} else {player setvariable ["SGS_Money",1]};
if (didJIP) then
{
	player setvariable ["SGS_Money",0];
	if !(isnil "s1") then
	{
		[] spawn fn_UI_counter;
		[] spawn fn_removePrimaryStuff;
	};
};

[] spawn
{
	waituntil {!isnil "FnDone"};

	[] spawn fn_Nametags;
	[] spawn fn_musicon;

	waituntil {!isnil "S1"};
	While {true} do
	{
		waituntil {!ROUND_RUNNING};
		[] spawn fn_holdActions;
		waituntil {ROUND_RUNNING};
		sleep 1;
	};
};

[] spawn
{
	sleep 5;
	while {true} do
	{
		sleep 1;
		if (uniform player == "") then {forceRespawn player};
	};
};
