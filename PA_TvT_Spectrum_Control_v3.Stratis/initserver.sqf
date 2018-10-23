//----------------------------------------------------------------------------------
// CATCH JIP AND PUNISH HIM FOR BEING ASSHOLE
//----------------------------------------------------------------------------------
/*
addMissionEventHandler
["PlayerConnected",
	{
		if !(_this select 3) exitwith {};
		_name1 = (_this select 2);
		[_name1] spawn
		{
			params ["_name1"];
			_players = [];
			waitUntil
			{
			    _players = allPlayers select {name _x == _name1 && alive _x};
			    count _players > 0
			};
			{_x setDamage 1} forEach _players;
		};
	}
];*/
COLOR_BLUE = "#(argb,8,8,3)color(0,0.1,1,1)";
COLOR_DEFAULT = "#(argb,8,8,3)color(0.9,0.1,0,1)";
COLOR_RED = "#(argb,8,8,3)color(1,0,0,1)";
COLOR_GREEN = "#(argb,8,8,3)color(0,1,0,1)";
COLOR_WHITE = "#(argb,8,8,3)color(1,0,1,1)";
COLOR_BLACK = "#(argb,8,8,3)color(0,0,0,0)";
COLOR_BASIC = "#(argb,8,8,3)color(1.0,1.0,1.0,1.0,co)";

P1 = [p1_1,p1_2,p1_3,p1_4,p1_5];
P2 = [p2_1,p2_2,p2_3,p2_4,p2_5];
P3 = [p3_1,p3_2,p3_3,p3_4,p3_17];//p3_5,p3_6,p3_7,p3_8,p3_9,p3_10,p3_11,p3_12,p3_13,p3_14,p3_15,p3_16
P4 = [p4_1,p4_2,p4_3,p4_4,p4_17];//p4_5,p4_6,p4_7,p4_8,p4_9,p4_10,p4_11,p4_12,p4_13,p4_15,p4_16,p4_18
P5 = [p5_1,p5_2,p5_3,p5_4,p5_5];
//----------------------------------------------------------------------------------
// POINTS FOR KILLS
//----------------------------------------------------------------------------------
addMissionEventHandler
["EntityKilled",
	{
		if (side group (_this select 0) == side group (_this select 1)) exitwith
		{
			// if he killed himself or he was executed by game
			if ((_this select 0) == (_this select 1)) exitwith {};
			// remove 2 points for TK
			(_this select 1) setvariable ["SGS_Money",((_this select 1) getVariable "SGS_Money") - 2,true];
			["-2","Friendly fire"] remoteExec ["fn_givePointNotification",(_this select 1)];
		};
		//hint format ["%1",_this select 1];
		// add 2 point if he had just pistol
		if (currentWeapon (_this select 1) == (handgunWeapon (_this select 1))) exitwith
		{
			(_this select 1) setvariable ["SGS_Money",((_this select 1) getVariable "SGS_Money") + 3,true];
			["+3","Pistol kill"] remoteExec ["fn_givePointNotification",(_this select 1)];
		};
		// add 1 point for killing enemy as default
		(_this select 1) setvariable ["SGS_Money",((_this select 1) getVariable "SGS_Money") + 2,true];
		["+2","Enemy kill"] remoteExec ["fn_givePointNotification",(_this select 1)];
	}
];

//decoy=false;publicvariable "decoy";
//----------------------------------------------------------------------------------
// SETNULL SCORE FOR ALL TEAMS
//----------------------------------------------------------------------------------

blueScore = 0;
greenScore = 0;
redScore = 0;
whiteScore = 0;
publicvariable "blueScore";
publicvariable "greenScore";
publicvariable "redScore";
publicvariable "whiteScore";

//----------------------------------------------------------------------------------
// RUN MAIN FLOW OF THE GAME
//----------------------------------------------------------------------------------
[] execFSM "handle_rounds.fsm";
//----------------------------------------------------------------------------------
// MAKE ALL SIDES ENEMIES
//----------------------------------------------------------------------------------
_allSides = [west, east, resistance, civilian];
{
    _side = _x;
    {
        if (_x != _side) then {
            _side setFriend [_x, 0];
        };
    } forEach _allSides;
} forEach _allSides;