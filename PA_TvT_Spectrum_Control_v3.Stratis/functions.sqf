fn_startpos =
{
    if !(hasInterface) exitwith {};
    private _pos = objNUll;
    switch (side group player) do
    {
        case WEST:
        {
            _pos = startBP3;
        };
        case EAST:
        {
            _pos = startRP3;
        };
        case INDEPENDENT:
        {
            _pos = startGP3;
        };
        case CIVILIAN:
        {
            _pos = startCP3;
        };
    };
    {_x SetDir (getdir _pos);_x setposASL getposASL (missionNamespace getVariable (format ["start%1",_x]))} foreach [player];
};
//----------------------------------------------------------------------------------
// WARMUP TIMER
//----------------------------------------------------------------------------------

fn_WU_hint =
{
    sleep 1;
    _dick = time + ("SGS_WarmUp" call BIS_fnc_getParamValue);
    while {_dick > 0} do
    {
        //[format ["WARM UP will ends in: %1 seconds",floor (_dick - time)]] remoteexec ["hintsilent",0];
        //hintsilent format ["WARM UP ends in: %1 seconds",floor _dick];
        _title  = "<t color='#FFFFFF' size='1' font = 'PuristaBold' shadow='2' shadowColor='#000000' align='center'>WARM-UP ENDS IN:</t>";
        _title2  = format ["<t color='#FFA500'  font = 'PuristaMedium' size='2' shadow='2' shadowColor='#000000' align='center'><br/>%1</t>",floor _dick];
        hintSilent parsetext (_title+ _title2);
        _dick = _dick - 1;
        sleep 1;
    };
};

//----------------------------------------------------------------------------------
// NAMETAGS
//----------------------------------------------------------------------------------
fn_Nametags =
{
    if !(hasInterface) exitwith {};

    addMissionEventHandler ["Draw3D",
    {

        {
            _tagcolor = [];
            switch (side group _x) do
            {
                case west: { _tagcolor = [0,0.6,1,1]};
                case east: { _tagcolor = [1,0,0,1]};
                case independent: { _tagcolor = [0,1,0,1]};
                case civilian: { _tagcolor = [1,0,1,1]};
            };
            _dist = (_X distance player) / 10;
            _tagcolor set [3, 1 - _dist];
            drawIcon3D ["", _tagcolor, [(visiblePositionasl _x select 0), (visiblePositionasl _x select 1), (visiblepositionasl _x select 2)-3], 1.5, 1.5, 0, name _x, 2, 0.04, "PuristaBold" ];
        } foreach (allunits - [player]) select {alive _x};
    }];
};
//----------------------------------------------------------------------------------
// SEND POINT TO PLAYER
//----------------------------------------------------------------------------------
fn_givepoints =
{
    hint str (_this select 0);
    if !(hasInterface) exitwith {};
    player setvariable ["SGS_Money", ((player getVariable "SGS_Money") + (_this select 0) min 20)];
};
// ["+2","Enemy kill"] spawn fn_givePointNotification;
fn_givePointNotification =
{
    Playsound "addItemOK";
    params ["_count","_reason"];
    [parseText format ["<t font='PuristaBold' size='1.6' color='#FFA500' >%1</t><br />%2",_count,_reason], true, nil, 7, 0.7, 0] spawn BIS_fnc_textTiles
};
//----------------------------------------------------------------------------------
// REMOVE WEAPON WITH MAGAZINES
//----------------------------------------------------------------------------------
fn_removePrimaryStuff =
{
    if !(hasInterface) exitwith {};
    if (primaryweapon player == "") exitwith {};
    _Magtype = (primaryWeaponMagazine player) select 0;
    player removeWeapon (primaryweapon player);
    {player removeMagazine _Magtype} forEach magazines player;
};
/*
fn_showScoreHint =
{
    hint format ["FOR WIN YOU NEED 100 POINTS\n\nBlue:%1\nRed:%2\nGreen:%3\nPurple:%4",bluescore,redscore,greenscore,whitescore];
};
*/
//----------------------------------------------------------------------------------
// HOLD ACTION DOBLECHECK
//----------------------------------------------------------------------------------
fn_holdActions =
{
    if !(hasInterface) exitwith {};
    removeallActions player;

    _bulshit =
    [
        player,
        "heal wounds",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",
        "damage player > 0.6 || (player gethit 'Legs') > 0.5",
        "true",
        {},
        {},
        {
            player setdamage 0;
        },
        {},
        [],
        3,
        500,
        false,
        false
    ] call BIS_fnc_holdActionAdd;

    // ADD SYNCHRONIZE ABILITY

    [
        player,
        "Synchronize Portal",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
        "true && portal_1 getvariable 'portal' != side _target && _target distance portal_1 < 1.3",
        "true",
        {//code start
        },
        { //code progress
           // if ((_this select 4) == 1) then {[_target] remoteexec ["fn_colorizePortal",0];};
        },
        { // finished
            Portal_1 setvariable ["portal",side _target,true];

            switch (side group _target) do
            {
                case WEST:
                {
                    {
                        [_x, [0,COLOR_BLUE]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P1;
                    ["BLUE TEAM SYNCHRONIZED PORTAL","#4169E1"] remoteexec ["fn_Notification",0];
                };
                case EAST:
                {
                    {
                        [_x, [0,COLOR_RED]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P1;
                    ["RED TEAM SYNCHRONIZED PORTAL","#FF0000"] remoteexec ["fn_Notification",0];
                };
                case resistance:
                {
                    {
                        [_x, [0,COLOR_GREEN]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P1;
                    ["GREEN TEAM SYNCHRONIZED PORTAL","#32CD32"] remoteexec ["fn_Notification",0];
                };
                case civilian:
                {
                    {
                        [_x, [0,COLOR_WHITE]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P1;
                    ["PURPLE TEAM SYNCHRONIZED PORTAL","#800080"] remoteexec ["fn_Notification",0];
                };
            };
            _target setvariable ["SGS_Money",(_target getvariable ["SGS_money",0]) + 2];
            ["+2","Synchronization"] spawn fn_givePointNotification;
            //[] remoteexec ["fn_uncolorizePortal",0];
        },
        { // interupted
            //[] remoteexec ["fn_uncolorizePortal",0];
        },
        [],
        5,
        10000,
        false,
        false
    ] call BIS_fnc_holdActionAdd;

    [
        player,
        "Synchronize Portal",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
        "true && portal_2 getvariable 'portal' != side _target && _target distance portal_2 < 1.3",
        "true",
        {//code start
        },
        { //code progress
           // if ((_this select 4) == 1) then {[_target] remoteexec ["fn_colorizePortal",0];};
        },
        { // finished
            Portal_2 setvariable ["portal",side _target,true];

            switch (side group _target) do
            {
                case WEST:
                {
                    {
                        [_x, [0,COLOR_BLUE]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P2;
                    ["BLUE TEAM SYNCHRONIZED PORTAL","#4169E1"] remoteexec ["fn_Notification",0];
                };
                case EAST:
                {
                    {
                        [_x, [0,COLOR_RED]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P2;
                    ["RED TEAM SYNCHRONIZED PORTAL","#FF0000"] remoteexec ["fn_Notification",0];
                };
                case resistance:
                {
                    {
                        [_x, [0,COLOR_GREEN]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P2;
                    ["GREEN TEAM SYNCHRONIZED PORTAL","#32CD32"] remoteexec ["fn_Notification",0];
                };
                case civilian:
                {
                    {
                        [_x, [0,COLOR_WHITE]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P2;
                    ["PURPLE TEAM SYNCHRONIZED PORTAL","#800080"] remoteexec ["fn_Notification",0];
                };
            };
            _target setvariable ["SGS_Money",(_target getvariable ["SGS_money",0]) + 2];
            ["+2","Synchronization"] spawn fn_givePointNotification;
            //[] remoteexec ["fn_uncolorizePortal",0];
        },
        { // interupted
            //[] remoteexec ["fn_uncolorizePortal",0];
        },
        [],
        5,
        10000,
        false,
        false
    ] call BIS_fnc_holdActionAdd;

        [
        player,
        "Synchronize Portal",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
        "true && portal_3 getvariable 'portal' != side _target && _target distance portal_3 < 1.3",
        "true",
        {//code start
        },
        { //code progress
           // if ((_this select 4) == 1) then {[_target] remoteexec ["fn_colorizePortal",0];};
        },
        { // finished
            Portal_3 setvariable ["portal",side _target,true];

            switch (side group _target) do
            {
                case WEST:
                {
                    {
                        [_x, [0,COLOR_BLUE]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P3;
                    ["BLUE TEAM SYNCHRONIZED PORTAL","#4169E1"] remoteexec ["fn_Notification",0];
                };
                case EAST:
                {
                    {
                        [_x, [0,COLOR_RED]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P3;
                    ["RED TEAM SYNCHRONIZED PORTAL","#FF0000"] remoteexec ["fn_Notification",0];
                };
                case resistance:
                {
                    {
                        [_x, [0,COLOR_GREEN]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P3;
                    ["GREEN TEAM SYNCHRONIZED PORTAL","#32CD32"] remoteexec ["fn_Notification",0];
                };
                case civilian:
                {
                    {
                        [_x, [0,COLOR_WHITE]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P3;
                    ["PURPLE TEAM SYNCHRONIZED PORTAL","#800080"] remoteexec ["fn_Notification",0];
                };
            };
            _target setvariable ["SGS_Money",(_target getvariable ["SGS_money",0]) + 2];
            ["+2","Synchronization"] spawn fn_givePointNotification;
            //[] remoteexec ["fn_uncolorizePortal",0];
        },
        { // interupted
            //[] remoteexec ["fn_uncolorizePortal",0];
        },
        [],
        5,
        10000,
        false,
        false
    ] call BIS_fnc_holdActionAdd;

        [
        player,
        "Synchronize Portal",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
        "true && portal_4 getvariable 'portal' != side _target && _target distance portal_4 < 1.3",
        "true",
        {//code start
        },
        { //code progress
           // if ((_this select 4) == 1) then {[_target] remoteexec ["fn_colorizePortal",0];};
        },
        { // finished
            Portal_4 setvariable ["portal",side _target,true];

            switch (side group _target) do
            {
                case WEST:
                {
                    {
                        [_x, [0,COLOR_BLUE]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P4;
                    ["BLUE TEAM SYNCHRONIZED PORTAL","#4169E1"] remoteexec ["fn_Notification",0];
                };
                case EAST:
                {
                    {
                        [_x, [0,COLOR_RED]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P4;
                    ["RED TEAM SYNCHRONIZED PORTAL","#FF0000"] remoteexec ["fn_Notification",0];
                };
                case resistance:
                {
                    {
                        [_x, [0,COLOR_GREEN]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P4;
                    ["GREEN TEAM SYNCHRONIZED PORTAL","#32CD32"] remoteexec ["fn_Notification",0];
                };
                case civilian:
                {
                    {
                        [_x, [0,COLOR_WHITE]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P4;
                    ["PURPLE TEAM SYNCHRONIZED PORTAL","#800080"] remoteexec ["fn_Notification",0];
                };
            };
            _target setvariable ["SGS_Money",(_target getvariable ["SGS_money",0]) + 2];
            ["+2","Synchronization"] spawn fn_givePointNotification;
            //[] remoteexec ["fn_uncolorizePortal",0];
        },
        { // interupted
            //[] remoteexec ["fn_uncolorizePortal",0];
        },
        [],
        5,
        10000,
        false,
        false
    ] call BIS_fnc_holdActionAdd;

        [
        player,
        "Synchronize Portal",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
        "true && portal_5 getvariable 'portal' != side _target && _target distance portal_5 < 1.3",
        "true",
        {//code start
        },
        { //code progress
           // if ((_this select 4) == 1) then {[_target] remoteexec ["fn_colorizePortal",0];};
        },
        { // finished
            Portal_5 setvariable ["portal",side _target,true];

            switch (side group _target) do
            {
                case WEST:
                {
                    {
                        [_x, [0,COLOR_BLUE]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P5;
                    ["BLUE TEAM SYNCHRONIZED PORTAL","#4169E1"] remoteexec ["fn_Notification",0];
                };
                case EAST:
                {
                    {
                        [_x, [0,COLOR_RED]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P5;
                    ["RED TEAM SYNCHRONIZED PORTAL","#FF0000"] remoteexec ["fn_Notification",0];
                };
                case resistance:
                {
                    {
                        [_x, [0,COLOR_GREEN]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P5;
                    ["GREEN TEAM SYNCHRONIZED PORTAL","#32CD32"] remoteexec ["fn_Notification",0];
                };
                case civilian:
                {
                    {
                        [_x, [0,COLOR_WHITE]] remoteExec ["setobjecttexture", 0,true];
                        [_x,  [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"]] remoteExec ["setobjectmaterial", 0,true];
                    } foreach P5;
                    ["PURPLE TEAM SYNCHRONIZED PORTAL","#800080"] remoteexec ["fn_Notification",0];
                };
            };
            _target setvariable ["SGS_Money",(_target getvariable ["SGS_money",0]) + 2];
            ["+2","Synchronization"] spawn fn_givePointNotification;
            //[] remoteexec ["fn_uncolorizePortal",0];
        },
        { // interupted
            //[] remoteexec ["fn_uncolorizePortal",0];
        },
        [],
        5,
        10000,
        false,
        false
    ] call BIS_fnc_holdActionAdd;

};

fn_teamMoney =
{
    _finalText = format [""];
    _dolar = format ["<t color='#FFFFFF' font = 'PuristaBold' size='1' shadow='2' shadowColor='#000000' align='center'> %1<br/></t>","$"];
    _friendlies = (allPlayers select {side _x == (side group player)});
    for "_i" from 0 to (count _friendlies)-1 do
    {
        _readInfoName = format ["<t color='#FFFFFF' font = 'PuristaBold' size='1.2' shadow='2' shadowColor='#000000' align='center'>%1:</t>",name ((_friendlies select _i))];
        _readInfoMoney = format ["<t color='#FFA500' font = 'PuristaBold' size='1.2' shadow='2' shadowColor='#000000' align='center'> %1</t>",(_friendlies select _i) getVariable ["SGS_MONEY",0]];
        _finalText = _finalText + _readInfoName + _readInfoMoney + _dolar;
    };
    hintSilent parsetext _finalText;
    sleep 4;
    hintsilent "";
};

//----------------------------------------------------------------------------------
// KAUF MENU
//----------------------------------------------------------------------------------
fn_BuyingMenu =
{
    if !(hasInterface) exitwith {};
    //SGS_KaufmenuOpen = True;
    private _pos = objNUll;
    switch (side group player) do
    {
        case WEST:
        {
            _pos = startBP3;
        };
        case EAST:
        {
            _pos = startRP3;
        };
        case INDEPENDENT:
        {
            _pos = startGP3;
        };
        case CIVILIAN:
        {
            _pos = startCP3;
        };
    };
    // show teams money everytime
    [] spawn fn_teamMoney;

    if (player distance _pos >20) exitwith
    {
        ["You are not in buying zone"] spawn fn_warning;
    };
    disableSerialization;

    //_websiteLink = param [0,"",[""]];

    _display = findDisplay 46 createDisplay "RscDisplayEmpty";

    _pointsbck = _display ctrlCreate ["RscPicture", 00];
    _points = _display ctrlCreate ["RscStructuredText", 01];
    _wpbck0 = _display ctrlCreate ["RscPicture", 021];
    _wpcost0  = _display ctrlCreate ["RscStructuredText", 031];
    _wpicon0 = _display ctrlCreate ["RscStructuredText", 041];
    _wpbck1 = _display ctrlCreate ["RscPicture", 02];
    _wpcost1  = _display ctrlCreate ["RscStructuredText", 03];
    _wpicon1 = _display ctrlCreate ["RscStructuredText", 04];
    _wpbck2 = _display ctrlCreate ["RscPicture", 05];
    _wpcost2 = _display ctrlCreate ["RscStructuredText", 06];
    _wpicon2 = _display ctrlCreate ["RscStructuredText", 07];
    _wpbck3 = _display ctrlCreate ["RscPicture", 08];
    _wpcost3 = _display ctrlCreate ["RscStructuredText", 09];
    _wpicon3 = _display ctrlCreate ["RscStructuredText", 10];
    _wpbck4 = _display ctrlCreate ["RscPicture", 081];
    _wpcost4 = _display ctrlCreate ["RscStructuredText", 091];
    _wpicon4 = _display ctrlCreate ["RscStructuredText", 101];
    _exit = _display ctrlCreate ["RscStructuredText", 11];
    _warning = _display ctrlCreate ["RscPicture", 12];
    _warningtext = _display ctrlCreate ["RscStructuredText", 13];

    //_pointsbck ctrlSetPosition [0.295797 * safezoneW + safezoneX,0.248 * safezoneH + safezoneY,0.401113 * safezoneW,0.07 * safezoneH];
    _points ctrlSetPosition [0.295797 * safezoneW + safezoneX,0.248 * safezoneH + safezoneY,0.401113 * safezoneW,0.07 * safezoneH];

    //["0.157231 * safezoneW + safezoneX","0.332 * safezoneH + safezoneY","0.12398 * safezoneW","0.308 * safezoneH"]; bck
    //["0.157231 * safezoneW + safezoneX","0.584 * safezoneH + safezoneY","0.12398 * safezoneW","0.056 * safezoneH"]; cost
    // ["0.157231 * safezoneW + safezoneX","0.36 * safezoneH + safezoneY","0.12398 * safezoneW","0.196 * safezoneH"] icon

    _wpbck0 ctrlSetPosition [0.157231 * safezoneW + safezoneX,0.332 * safezoneH + safezoneY,0.12398 * safezoneW,0.308 * safezoneH];
    _wpcost0 ctrlSetPosition [0.157231 * safezoneW + safezoneX,0.584 * safezoneH + safezoneY,0.12398 * safezoneW,0.056 * safezoneH];//weapon cost
    _wpicon0 ctrlSetPosition [0.157231 * safezoneW + safezoneX,0.36 * safezoneH + safezoneY,0.12398 * safezoneW,0.196 * safezoneH];

    _wpbck1 ctrlSetPosition [0.295797 * safezoneW + safezoneX,0.332 * safezoneH + safezoneY,0.12398 * safezoneW,0.308 * safezoneH];
    _wpcost1 ctrlSetPosition [0.295797 * safezoneW + safezoneX,0.584 * safezoneH + safezoneY,0.12398 * safezoneW,0.056 * safezoneH];//weapon cost
    _wpicon1 ctrlSetPosition [0.295797 * safezoneW + safezoneX,0.36 * safezoneH + safezoneY,0.12398 * safezoneW,0.196 * safezoneH];//weapon pictur

    _wpbck2 ctrlSetPosition [0.434363 * safezoneW + safezoneX,0.332 * safezoneH + safezoneY,0.12398 * safezoneW,0.308 * safezoneH];
    _wpcost2 ctrlSetPosition[0.434363 * safezoneW + safezoneX,0.584 * safezoneH + safezoneY,0.12398 * safezoneW,0.056 * safezoneH]; // cost
    _wpicon2 ctrlSetPosition  [0.434363 * safezoneW + safezoneX,0.36 * safezoneH + safezoneY,0.12398 * safezoneW,0.196 * safezoneH] ;  //pic

    _wpbck3 ctrlSetPosition [0.57293 * safezoneW + safezoneX,0.332 * safezoneH + safezoneY,0.12398 * safezoneW,0.308 * safezoneH];
    _wpcost3 ctrlSetPosition [0.57293 * safezoneW + safezoneX,0.584 * safezoneH + safezoneY,0.12398 * safezoneW,0.056 * safezoneH]; // cost
    _wpicon3 ctrlSetPosition [0.57293 * safezoneW + safezoneX,0.36 * safezoneH + safezoneY,0.12398 * safezoneW,0.196 * safezoneH]; // pictur

    _wpbck4 ctrlSetPosition [0.711496 * safezoneW + safezoneX,0.332 * safezoneH + safezoneY,0.12398 * safezoneW,0.308 * safezoneH];
    _wpcost4 ctrlSetPosition [0.711496 * safezoneW + safezoneX,0.584 * safezoneH + safezoneY,0.12398 * safezoneW,0.056 * safezoneH];//weapon cost
    _wpicon4 ctrlSetPosition [0.711496 * safezoneW + safezoneX,0.374 * safezoneH + safezoneY,0.12398 * safezoneW,0.196 * safezoneH];

    //["0.711496 * safezoneW + safezoneX","0.332 * safezoneH + safezoneY","0.12398 * safezoneW","0.308 * safezoneH"];
    // ["0.711496 * safezoneW + safezoneX","0.584 * safezoneH + safezoneY","0.12398 * safezoneW","0.056 * safezoneH"]; //cost
    // ["0.711496 * safezoneW + safezoneX","0.374 * safezoneH + safezoneY","0.12398 * safezoneW","0.196 * safezoneH"] //img

    //pripadne dalsi moznosti
    //["0.295797 * safezoneW + safezoneX,0.654 * safezoneH + safezoneY,0.401113 * safezoneW,0.07 * safezoneH]

    _warning ctrlSetPosition [0.383312 * safezoneW + safezoneX,0.724 * safezoneH + safezoneY,0.240668 * safezoneW,0.084 * safezoneH];
    _warningtext ctrlSetPosition [0.448949 * safezoneW + safezoneX,0.724 * safezoneH + safezoneY,0.175031 * safezoneW,0.084 * safezoneH] ;// text
    _exit ctrlSetPosition [0.857355 * safezoneW + safezoneX,0.892 * safezoneH + safezoneY,0.12398 * safezoneW,0.07 * safezoneH];
    _points ctrlSetStructuredText parseText format ["<t color='#FFFFFF' font = 'PuristaMedium' size = '1.5' align = 'CENTER' shadow = '2'> YOUR $ POINTS: %1</t>",player getvariable ["SGS_Money",0]];
    _exit ctrlSetStructuredText parseText "<t color='#FFFFFF' font = 'PuristaMedium' size = '1.5' align = 'CENTER' shadow = '2'> [ESC] Exit</t>";

    if (player getvariable "SGS_Money" >= SGS_WP0_COST) then {_wpbck0 ctrlSetText ([.4, .4, .4, .1] call BIS_fnc_colorRGBAtoTexture)} else {_wpbck0 ctrlSetText ([0.4, .0, .0, .2] call BIS_fnc_colorRGBAtoTexture)};
    if (player getvariable "SGS_Money" >= SGS_WP1_COST) then {_wpbck1 ctrlSetText ([.4, .4, .4, .1] call BIS_fnc_colorRGBAtoTexture)}else {_wpbck1 ctrlSetText ([0.4, .0, .0, .2] call BIS_fnc_colorRGBAtoTexture)};
    if (player getvariable "SGS_Money" >= SGS_WP2_COST) then {_wpbck2 ctrlSetText ([.4, .4, .4, .1] call BIS_fnc_colorRGBAtoTexture)}else {_wpbck2 ctrlSetText ([0.4, .0, .0, .2] call BIS_fnc_colorRGBAtoTexture)};
    if (player getvariable "SGS_Money" >= SGS_WP3_COST) then {_wpbck3 ctrlSetText ([.4, .4, .4, .1] call BIS_fnc_colorRGBAtoTexture)}else {_wpbck3 ctrlSetText ([0.4, .0, .0, .2] call BIS_fnc_colorRGBAtoTexture)};
    if (player getvariable "SGS_Money" >= SGS_WP4_COST) then {_wpbck4 ctrlSetText ([.4, .4, .4, .1] call BIS_fnc_colorRGBAtoTexture)}else {_wpbck4 ctrlSetText ([0.4, .0, .0, .2] call BIS_fnc_colorRGBAtoTexture)};
    /*
    {_x ctrlSetText ([0.4, 0.4, 0.4, 0.1] call BIS_fnc_colorRGBAtoTexture)} foreach [_wpbck0,_wpbck1];
    {_x ctrlSetText ([0.4, 0, 0, 0.2] call BIS_fnc_colorRGBAtoTexture)} foreach [_wpbck2,_wpbck3,_wpbck4];//_pointsbck*/
    _wpicon0 ctrlSetStructuredText parseText format ["<a size='6.3'><img image='img\vernin2.pac'/></a>"];
    _wpicon1  ctrlSetStructuredText parseText format ["<a size='6.3'><img image='img\mxa.pac'/></a>"];
    _wpicon2 ctrlSetStructuredText parseText format ["<a size='6.3'><img image='img\katiba.pac'/></a>"];
    _wpicon3 ctrlSetStructuredText parseText format ["<a size='6.3'><img image='img\mk200.pac'/></a>"];
    _wpicon4 ctrlSetStructuredText parseText format ["<a size='6.3'><img image='img\ak12.pac'/></a>"];

    _wpcost0 ctrlSetStructuredText parseText format ["<t color='#FFFFFF' font = 'PuristaMedium' size = '0.8' align = 'CENTER' shadow = '1'> COST: %1</t>",SGS_WP0_COST];
    _wpcost1 ctrlSetStructuredText parseText format ["<t color='#FFFFFF' font = 'PuristaMedium' size = '0.8' align = 'CENTER' shadow = '1'> COST: %1</t>",SGS_WP1_COST];
    _wpcost2 ctrlSetStructuredText parseText format ["<t color='#FFFFFF' font = 'PuristaMedium' size = '0.8' align = 'CENTER' shadow = '1'> COST: %1</t>",SGS_WP2_COST];
    _wpcost3 ctrlSetStructuredText parseText format ["<t color='#FFFFFF' font = 'PuristaMedium' size = '0.8' align = 'CENTER' shadow = '1'> COST: %1</t>",SGS_WP3_COST];
    _wpcost4 ctrlSetStructuredText parseText format ["<t color='#FFFFFF' font = 'PuristaMedium' size = '0.8' align = 'CENTER' shadow = '1'> COST: %1</t>",SGS_WP4_COST];

    {_x ctrlCommit 0;} foreach [_points,_wpcost0,_wpcost1,_wpcost2,_wpcost3,_wpcost4,_wpicon0,_wpicon1,_wpicon2,_wpicon3,_wpicon4,_wpbck0,_wpbck1,_wpbck2,_wpbck3,_wpbck4,_exit,_warningtext,_warning];//_pointsbck

    _display displayAddEventHandler ["KEYDOWN", {if (_this select 1 == 48) then {(_this select 0) closeDisplay 1}}];
    // Player selected SNIPER RIFLE
    _wpicon0 ctrlAddEventHandler
    ["MouseButtonClick",
        {
            if (player getvariable ["SGS_Money",0] < SGS_WP0_COST) exitwith {playsound "additemfailed";hint "You dont have enough points for this weapon"};
           // hint str (ctrlParent(_this select 0));
            ctrlParent(_this select 0) closeDisplay 1;
            //hintsilent "";
            [] spawn
            {
                playsound "additemOK";
                //Hint "weapon 1";
                player setvariable ["SGS_Money",(player getvariable "SGS_Money") - SGS_WP0_COST,true];
                private _script = [] spawn fn_removePrimaryStuff;
                //SNIPER RIFLE
                waituntil {scriptDone  _script};
                player addmagazine "30Rnd_45ACP_Mag_SMG_01_Tracer_Red";
                player addmagazine "30Rnd_45ACP_Mag_SMG_01_Tracer_Red";
                player addmagazine "30Rnd_45ACP_Mag_SMG_01_Tracer_Red";
                player addmagazine "30Rnd_45ACP_Mag_SMG_01_Tracer_Red";
                player addmagazine "30Rnd_45ACP_Mag_SMG_01_Tracer_Red";
                player addmagazine "30Rnd_45ACP_Mag_SMG_01_Tracer_Red";
                player addmagazine "30Rnd_45ACP_Mag_SMG_01_Tracer_Red";
                player addmagazine "30Rnd_45ACP_Mag_SMG_01_Tracer_Red";
                player addweapon "SMG_01_F";
                player addPrimaryWeaponItem "optic_Aco_smg";
                player selectweapon (primaryWeapon player);
            };
        }
    ];

    // Player selected SNIPER RIFLE
    _wpicon1 ctrlAddEventHandler
    ["MouseButtonClick",
        {
            if (player getvariable ["SGS_Money",0] < SGS_WP1_COST) exitwith {playsound "additemfailed";hint "You dont have enough points for this weapon"};
            ctrlParent(_this select 0) closeDisplay 1;
            hintsilent "";
            [] spawn
            {
                playsound "additemOK";
                //Hint "weapon 1";
                player setvariable ["SGS_Money",(player getvariable "SGS_Money") - SGS_WP1_COST,true];
                private _script = [] spawn fn_removePrimaryStuff;
                //SNIPER RIFLE
                waituntil {scriptDone  _script};
                player addmagazine "30Rnd_65x39_caseless_mag_Tracer";
                player addmagazine "30Rnd_65x39_caseless_mag_Tracer";
                player addmagazine "30Rnd_65x39_caseless_mag_Tracer";
                player addmagazine "30Rnd_65x39_caseless_mag_Tracer";
                player addweapon "arifle_MX_Black_F";
                player addPrimaryWeaponItem "optic_Aco_smg";
                player selectweapon (primaryWeapon player);
            };
        }
    ];
    // Player selected ASSAULT RIFLE
    _wpicon2 ctrlAddEventHandler
    ["MouseButtonClick",
        {
            if (player getvariable ["SGS_Money",0] < SGS_WP2_COST) exitwith {playsound "additemfailed";hint "You dont have enough points for this weapon"};
            ctrlParent(_this select 0) closeDisplay 1;
            hintsilent "";
            [] spawn
            {
                playsound "additemOK";
                //Hint "weapon 2";
                player setvariable ["SGS_Money",(player getvariable "SGS_Money") - SGS_WP2_COST,true];
                private _script =[] spawn fn_removePrimaryStuff;
                // ASSAULT RIFLE
                waituntil {scriptDone _script};
                player addmagazine "30Rnd_65x39_caseless_green_mag_Tracer";
                player addmagazine "30Rnd_65x39_caseless_green_mag_Tracer";
                player addmagazine "30Rnd_65x39_caseless_green_mag_Tracer";
                player addmagazine "30Rnd_65x39_caseless_green_mag_Tracer";
                player addmagazine "30Rnd_65x39_caseless_green_mag_Tracer";
                player addweapon "arifle_Katiba_F";
                player addPrimaryWeaponItem "optic_Aco_smg";
                player selectweapon (primaryWeapon player);
            };
        }
    ];
    // Player selected MACHINE GUN
    _wpicon3 ctrlAddEventHandler
    ["MouseButtonClick",
        {
            if (player getvariable ["SGS_Money",0] < SGS_WP3_COST) exitwith {playsound "additemfailed";hint "You dont have enough points for this weapon"};
            ctrlParent(_this select 0) closeDisplay 1;
            hintsilent "";
            [] spawn
            {
                playsound "additemOK";
                //Hint "weapon 3";
                player setvariable ["SGS_Money",(player getvariable "SGS_Money") - SGS_WP3_COST,true];
                private _script =[] spawn fn_removePrimaryStuff;
                //MACHINE GUN
                waituntil {scriptDone  _script};
                player addmagazine "200Rnd_65x39_cased_Box_Tracer";
                player addmagazine "200Rnd_65x39_cased_Box_Tracer";
                player addweapon "LMG_Mk200_F";
                player addPrimaryWeaponItem "optic_Aco_smg";
                player selectweapon (primaryWeapon player);
            };
        }
    ];
     // Player selected SNIPER RIFLE
    _wpicon4 ctrlAddEventHandler
    ["MouseButtonClick",
        {
            if (player getvariable ["SGS_Money",0] < SGS_WP4_COST) exitwith {playsound "additemfailed";hint "You dont have enough points for this weapon"};
            ctrlParent(_this select 0) closeDisplay 1;
            hintsilent "";
            [] spawn
            {
                playsound "additemOK";
                //Hint "weapon 1";
                player setvariable ["SGS_Money",(player getvariable "SGS_Money") - SGS_WP4_COST,true];
                private _script = [] spawn fn_removePrimaryStuff;
                //SNIPER RIFLE
                waituntil {scriptDone  _script};
                player addmagazine "30Rnd_762x39_Mag_Tracer_F";
                player addmagazine "30Rnd_762x39_Mag_Tracer_F";
                player addmagazine "30Rnd_762x39_Mag_Tracer_F";
                player addmagazine "30Rnd_762x39_Mag_Tracer_F";
                player addmagazine "30Rnd_762x39_Mag_Tracer_F";
                player addweapon "arifle_AK12_F";
                player addPrimaryWeaponItem "optic_Arco_blk_F";
                player selectweapon (primaryWeapon player);
            };
        }
    ];
};

//----------------------------------------------------------------------------------
// LOADOUTS FOR EVERY TEAM
//----------------------------------------------------------------------------------
fn_roundloadout = {

    if !(hasInterface) exitwith {};

    // refill ammo in primary weapon
    if (primaryweapon player != "") then
    {
        //refill actual mgz.
        _primMag = primaryWeaponMagazine player;
        _primfullMag = getNumber(configFile >> "CfgMagazines" >> (_primMag select 0) >> "count");
        player setAmmo [primaryweapon player, _primfullMag];
    } else {
        ["Open buying menu by pressing 'B'"] spawn fn_warning;
    };
    // refill ammo in handgun
    if (handgunWeapon player != "") then
    {
        // refil actual mgz.
        _handMag = handgunMagazine player;
        _handfullMag = getNumber(configFile >> "CfgMagazines" >> (_handMag select 0) >> "count");
        player setAmmo [handgunweapon player, _handfullMag];

        _curPist = {_x == (handgunMagazine player select 0)} count magazines player;
        if (_curPist >= 3) exitwith {};
        for "_i" from 1 to (3 - _curPist) do
        {
            player addItemToUniform (handgunMagazine player select 0);
        };
    };
    // refill IR grenades
    _curIR = {_x == "B_IR_Grenade"} count magazines player;
    if (_curIR < 2) then
    {
         for "_i" from 1 to (2 - _curIR) do
        {
            player addItemToUniform "B_IR_Grenade";
        };
    };

    /*        HERE      */
    player setdamage 0;
};
//----------------------------------------------------------------------------------
// COLORIZE PORTAL
//----------------------------------------------------------------------------------
fn_colorizePortal =
{
    _portal_color = [];
    switch (side group (_this select 0)) do
    {
        case WEST: {_portal_color = COLOR_blue};
        case EAST: {_portal_color = COLOR_red};
        case resistance: {_portal_color = COLOR_green};
        case civilian: {_portal_color = COLOR_white};
    };
    {
        _x setobjecttextureglobal [0,_portal_color];
        _x setobjectmaterialglobal [0,"a3\characters_f_bootcamp\common\data\vrarmoremmisive.rvmat"];
    } foreach PortalBloks;
};

//----------------------------------------------------------------------------------
// START NEW ROUND AND SET INFINITE RESPAWN TIME
//----------------------------------------------------------------------------------
fn_startNewRound =
{
    PlaySound "boom";
    setPlayerRespawnTime 10;
};
//----------------------------------------------------------------------------------
// TURN OFF THE MUSIC
//----------------------------------------------------------------------------------
fn_musicOn =
{
    2 fademusic 0.5;
    Playmusic ["LeadTrack01_F_Bootcamp",0];
};

fn_fademusic =
{
  1 fademusic 0;
  sleep 2;
  Playmusic "";
};

//----------------------------------------------------------------------------------
//  MAIN NOTIFICATION (END OF THE ROUND)
//----------------------------------------------------------------------------------
fn_Notification = {
    disableSerialization;
    params ["_text","_color"];
    /*#define SIDE_X 0.0246262 * safezoneW
    #define SIDE_Y 0.0376164 * safezoneH*/

    private _display = displayNull;
    waitUntil {_display = call BIS_fnc_displayMission; !(isNull _display)};

    private ["_notificationText","_notificationBck"];
    _notificationText = uiNamespace getVariable ["ctrlSpectrumNotification",controlNull];
    _notificationBck = uiNamespace getVariable ["ctrlSpectrumNotificationBck",controlNull];

    if (isnull _notificationBck) then
    {
        _notificationBck = _display ctrlCreate ["RscPicture", 0176541];
        uiNamespace setVariable ["ctrlSpectrumNotificationBck",_notificationBck];
        _notificationBck ctrlSetPosition [0.303939 * safezoneW + safezoneX,0.16361 * safezoneH + safezoneY,0.389687 * safezoneW,0.055 * safezoneH];
        _notificationBck ctrlSetText ([0, 0, 0, 0.6] call BIS_fnc_colorRGBAtoTexture);
    };

    if (isNull _notificationText) then
    {
        _notificationText = _display ctrlCreate ["RscStructuredText", 0176543];
        uiNamespace setVariable ["ctrlSpectrumNotification",_notificationText];
        _notificationText ctrlSetPosition [0.303939 * safezoneW + safezoneX,0.16361 * safezoneH + safezoneY,0.389687 * safezoneW,0.055 * safezoneH];
    };

    _what = format ["<t color='%2' font = 'PuristaBold' size = '1.5' align = 'CENTER' shadow = '2'>%1</t>",_text,_color];      //TODO: Localize
    _notificationText ctrlSetStructuredText parseText _what;
    _notificationBck ctrlsetfade 0;
    _notificationText ctrlsetfade 0;
    _notificationBck  ctrlCommit 0;
    _notificationText ctrlCommit 0;

    private _script = missionNamespace getVariable ["scriptSpectrumNotification",scriptNull];
    if (!scriptDone _script) then {terminate _script;};
    _script = [_notificationText,_notificationBck] spawn
    {
        disableSerialization;
        params ["_notificationText","_notificationBck"];

        sleep 6;
        _notificationText ctrlSetFade 1;
        _notificationText ctrlCommit 1;
        _notificationBck  ctrlSetFade 1;
        _notificationBck  ctrlCommit 1;
        /*
        sleep 2;
        ctrlDelete _notificationText;
        */
    };
    missionNamespace setvariable ["scriptSpectrumNotification",_script];
};

fn_warning =
{
    disableSerialization;
    params ["_text"];

    private _display = displayNull;
    waitUntil {_display = call BIS_fnc_displayMission; !(isNull _display)};

    private ["_warningBck","_warningText"];
    _warningBck = uiNamespace getVariable ["ctrlSpectrumWarningBck",controlNull];
    _warningText = uiNamespace getVariable ["ctrlSpectrumWarningText",controlNull];

    if (isnull _warningBck) then
    {
        _warningBck = _display ctrlCreate ["RscPicture", 0176532];
        uiNamespace setVariable ["ctrlSpectrumWarningBck",_warningBck];
        _warningBck ctrlSetPosition [0.383312 * safezoneW + safezoneX,0.724 * safezoneH + safezoneY,0.240668 * safezoneW,0.084 * safezoneH];
        _warningBck ctrlSetText "img\warning4.pac";
    };
    if (isnull _warningText) then
    {
        _warningText = _display ctrlCreate ["RscStructuredText", 0176533];
        uiNamespace setVariable ["ctrlSpectrumWarningText",_warningText];
        _warningText ctrlSetPosition [0.448949 * safezoneW + safezoneX,0.724 * safezoneH + safezoneY,0.175031 * safezoneW,0.084 * safezoneH];
    };

    _what = format ["<t color='#FFFFFF' font = 'PuristaLight' size = '0.9' align = 'LEFT' shadow = '2'>%1</t>",_text];
    _warningText ctrlSetStructuredText parseText _what;
    _warningBck ctrlsetfade 0;
    _warningText ctrlSetFade 0;
    _warningBck  ctrlCommit 0;
    _warningText ctrlCommit 0;

    private _script = missionNamespace getVariable ["scriptSpectrumWarning",scriptNull];
    if (!scriptDone _script) then {terminate _script;};
    _script = [_warningBck,_warningText] spawn
    {
        disableSerialization;
        params ["_warningBck","_warningText"];

        sleep 3.5;
        _warningBck ctrlSetFade 1;
        _warningBck ctrlCommit 1;
        _warningText  ctrlSetFade 1;
        _warningText  ctrlCommit 1;
    };
    missionNamespace setvariable ["scriptSpectrumWarning",_script];
};

fn_UI_counter =
{
    disableSerialization;
    //params ["_text"];

    private _display = displayNull;
    waitUntil {_display = call BIS_fnc_displayMission; !(isNull _display)};

    private ["_ScoreBck0","_ScoreBck","_Score1","_Score2","_Score3","_Score4","_money"];
    _ScoreBck0 = uiNamespace getVariable ["ctrlSpectrumScoreBck0",controlNull];
    _ScoreBck = uiNamespace getVariable ["ctrlSpectrumScoreBck",controlNull];
    _Score1 = uiNamespace getVariable ["ctrlSpectrumScore1",controlNull];
    _Score2 = uiNamespace getVariable ["ctrlSpectrumScore2",controlNull];
    _Score3 = uiNamespace getVariable ["ctrlSpectrumScore3",controlNull];
    _Score4 = uiNamespace getVariable ["ctrlSpectrumScore4",controlNull];
    _money = uiNamespace getVariable ["ctrlSpectrumMoney",controlNull];

    if (isnull _ScoreBck0) then
    {
        _ScoreBck0 = _display ctrlCreate ["RscPicture", 0576531];
        uiNamespace setVariable ["ctrlSpectrumScoreBck",_ScoreBck0];
        //[0.396439 * safezoneW + safezoneX,-0.00399999 * safezoneH + safezoneY,0.00583437 * safezoneW,0.028 * safezoneH]
        _ScoreBck0 ctrlSetPosition [0.397898 * safezoneW + safezoneX,-0.00399999 * safezoneH + safezoneY,0.00583437 * safezoneW,0.033 * safezoneH];
        _ScoreBck0 ctrlSetText ([1, 1, 1, .2] call BIS_fnc_colorRGBAtoTexture);
    };

    if (isnull _ScoreBck) then
    {
        _ScoreBck = _display ctrlCreate ["RscPicture", 0576532];
        uiNamespace setVariable ["ctrlSpectrumScoreBck",_ScoreBck];
        _ScoreBck ctrlSetPosition [0.397898 * safezoneW + safezoneX,-0.00399999 * safezoneH + safezoneY,0.175031 * safezoneW,0.033 * safezoneH];
        _ScoreBck ctrlSetText ([0, 0, 0, .6] call BIS_fnc_colorRGBAtoTexture);
    };
    if (isnull _Score1) then
    {
        _Score1 = _display ctrlCreate ["RscStructuredText", 0576533];
        uiNamespace setVariable ["ctrlSpectrumScore1",_Score1];
        _Score1 ctrlSetPosition [0.397899 * safezoneW + safezoneX,-0.00399999 * safezoneH + safezoneY,0.0437577 * safezoneW,0.042 * safezoneH];
    };
    if (isnull _Score2) then
    {
        _Score2 = _display ctrlCreate ["RscStructuredText", 0576534];
        uiNamespace setVariable ["ctrlSpectrumScore2",_Score2];
        _Score2 ctrlSetPosition [0.441656 * safezoneW + safezoneX,-0.00399999 * safezoneH + safezoneY,0.0437577 * safezoneW,0.028 * safezoneH];//0.042 * safezoneH];
    };
    if (isnull _Score3) then
    {
        _Score3 = _display ctrlCreate ["RscStructuredText", 0576535];
        uiNamespace setVariable ["ctrlSpectrumScore3",_Score3];
        _Score3 ctrlSetPosition [0.485414 * safezoneW + safezoneX,-0.00399999 * safezoneH + safezoneY,0.0437577 * safezoneW,0.028 * safezoneH];//0.042 * safezoneH];
    };
    if (isnull _Score4) then
    {
        _Score4 = _display ctrlCreate ["RscStructuredText", 0576536];
        uiNamespace setVariable ["ctrlSpectrumScore4",_Score4];
        _Score4 ctrlSetPosition [0.529172 * safezoneW + safezoneX,-0.00399999 * safezoneH + safezoneY,0.0437577 * safezoneW,0.028 * safezoneH];//0.042 * safezoneH];
    };

    if (isnull _money) then
    {
        _money = _display ctrlCreate ["RscStructuredText", 0576537];
        uiNamespace setVariable ["ctrlSpectrumMoney",_money];
        _money ctrlSetPosition  [0.901113 * safezoneW + safezoneX,0.752 * safezoneH + safezoneY,0.0948085 * safezoneW,0.042 * safezoneH];
    };

    _what1 = format ["<t color='#c308a7' font = 'PuristaBold' size = '1' align = 'CENTER' shadow = '2'>%1</t>",whitescore];
    _what2 = format ["<t color='#ab0909' font = 'PuristaBold' size = '1' align = 'CENTER' shadow = '2'>%1</t>",redscore];
    _what3 = format ["<t color='#067003' font = 'PuristaBold' size = '1' align = 'CENTER' shadow = '2'>%1</t>",greenscore];
    _what4 = format ["<t color='#025891' font = 'PuristaBold' size = '1' align = 'CENTER' shadow = '2'>%1</t>",bluescore];
    _moneyValue = "<t color='#FFA500' font = 'PuristaBold' size = '1' align = 'RIGHT' image = 'img\vernin2.pac' shadow = '2'>%1</t>";
    _Score1 ctrlSetStructuredText parseText _what1;
    _Score2 ctrlSetStructuredText parseText _what2;
    _Score3 ctrlSetStructuredText parseText _what3;
    _Score4 ctrlSetStructuredText parseText _what4;
    _money ctrlSetStructuredText parseText _moneyValue;
    {_x ctrlSetFade 0} foreach [_ScoreBck0,_Score1,_ScoreBck,_Score2,_Score3,_Score4,_money];
    {_x ctrlCommit 0} foreach [_ScoreBck0,_Score1,_ScoreBck,_Score2,_Score3,_Score4,_money];

    // Refreshing points each 0.5 seconds
    [_Score1,_ScoreBck,_Score2,_Score3,_Score4,_money] spawn
    {
        params ["_Score1","_ScoreBck","_Score2","_Score3","_Score4","_money"];
        while {true} do
        {
            _what1 = format ["<t color='#c308a7' font = 'PuristaBold' size = '1' align = 'CENTER' shadow = '2'>%1</t>",whitescore];
            _what2 = format ["<t color='#ab0909' font = 'PuristaBold' size = '1' align = 'CENTER' shadow = '2'>%1</t>",redscore];
            _what3 = format ["<t color='#067003' font = 'PuristaBold' size = '1' align = 'CENTER' shadow = '2'>%1</t>",greenscore];
            _what4 = format ["<t color='#025891' font = 'PuristaBold' size = '1' align = 'CENTER' shadow = '2'>%1</t>",bluescore];
            _moneyValue = format ["<t color='#FFA500' font = 'PuristaBold' size = '1' align = 'RIGHT' image = 'img\vernin2.pac' shadow = '2'>%1</t>",(player getvariable "SGS_money")];
            _pointsText = "<t color='#FFFFFF' font = 'PuristaBold' size = '0.8' align = 'RIGHT' image = 'img\vernin2.pac' shadow = '2'> $</t>";
            _Score1 ctrlSetStructuredText parseText _what1;
            _Score2 ctrlSetStructuredText parseText _what2;
            _Score3 ctrlSetStructuredText parseText _what3;
            _Score4 ctrlSetStructuredText parseText _what4;
            _money ctrlSetStructuredText parseText (_moneyValue + _pointsText);
            {_x ctrlSetFade 0} foreach [_Score1,_ScoreBck,_Score2,_Score3,_Score4,_money];
            {_x ctrlCommit 0} foreach [_Score1,_ScoreBck,_Score2,_Score3,_Score4,_money];
            sleep 0.5;
        };
    };
    // Loading bar
    [_ScoreBck0] spawn
    {
        params ["_ScoreBck0"];
        while {true} do
        {
            waituntil {NewCycle};
            NewCycle = false;
            _ScoreBck0 ctrlSetPosition [0.397898 * safezoneW + safezoneX,-0.00399999 * safezoneH + safezoneY,0.00583437 * safezoneW,0.033 * safezoneH];
            _ScoreBck0 ctrlCommit 0;
            _ScoreBck0 ctrlSetPosition [0.397898 * safezoneW + safezoneX,-0.00399999 * safezoneH + safezoneY,0.175031 * safezoneW,0.033 * safezoneH];
            _ScoreBck0 ctrlCommit 20;
        };
    };
};


 // text
/*
#FFA500 - zluta
*/
//playsound "defaultNotificationClose";
//playsound "defaultNotification";

// #FF0000 CERVENA
// #4169E1 MODRA
// #800080 FIALOVA
// #32CD32 ZELENA
// #FFFFFF
/*
["GREEN TEAM SYNCHRONIZED PORTAL","#32CD32"] spawn fn_Notification;
["GREEN TEAM WON THE ROUND","#32CD32"] spawn fn_Notification;