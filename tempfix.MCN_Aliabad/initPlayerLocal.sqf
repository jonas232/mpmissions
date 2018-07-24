/*-----------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------
*** Author: Hardballer
 
*** Description:
    client init
 
-------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------*/
 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  1) PARAM
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
playerUnit = _this select 0;    // unité du joueur (sélectionnée dans l'écran des slots)
playerIsJIP = _this select 1;   // boolean (true ou false). True = le joueur se connecte en cours de partie.
enableSaving [false, false]; // supprime la sauvegarde
 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  2) CALL / COMPILE
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
call compile preprocessFileLineNumbers "loadout.sqf";
 
//start blaffer new code
call compile preprocessFileLineNumbers "loadout_parapacks.sqf";
//end blaffer new code
 
 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  3) LOADOUT
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if !(isNil {playerUnit getVariable "loadout"}) then // La variable loadout doit être placer dans l'éditeur [init de l'unité] => this setVariable ["loadout", "aaf_sl"];
{
    if (isNil {playerUnit getVariable "loadout_done"}) then // loadout_done inexistant, on lance la function loadout
    {
        [playerUnit] call hard_setLoadout;
        playerUnit setVariable ["loadout_done", true, true]; // loadout_done permet de vérifier si le loadout a été fait afin d'éviter les doublons en cas de déco / reco.
    };
};
 
playerUnit action ["WeaponOnBack", playerUnit]; // pour que le joueur est l'arme baissée
setviewdistance 6000;
 
[] spawn {
    waitUntil {time > 1};
playerUnit switchMove "PlayerStand";
    playerUnit unassignitem "ItemMap";
    playerUnit removeitem "ItemMap";
};
 
 
 
//start blaffer new code
[playerUnit] spawn {
    playerUnit = _this select 0;
   
    sleep 15;
   
    waitUntil {sleep 5; ((getPosATL playerUnit) select 2) < 5 };
 
 
    sleep 10;
    [playerUnit] call hard_setLoadout_parapacks;
    setviewdistance 1500;
};
//end blaffer new code