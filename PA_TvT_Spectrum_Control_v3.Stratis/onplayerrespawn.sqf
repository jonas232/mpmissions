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

player addvest "V_PlateCarrier1_blk";
player addGoggles "G_Balaclava_TI_blk_F";
player addHeadgear selectrandom ["H_CrewHelmetHeli_B","H_PASGT_basic_black_F","H_Helmet_Skate","H_EarProtectors_black_F"];
if !(isnil "S1") then {player setvariable ["SGS_Money",(player getvariable "SGS_Money") + 1,true];};

// add pistols and mgzs
player addItemToUniform "11Rnd_45ACP_Mag";
player addItemToUniform "11Rnd_45ACP_Mag";
player addItemToUniform "11Rnd_45ACP_Mag";
player addItemToUniform "11Rnd_45ACP_Mag";

player addWeapon "hgun_Pistol_heavy_01_F";
player addHandgunItem "optic_MRD";

// add decoys
if !(isnil "S1") then
{
	player addItemToUniform "B_IR_Grenade";
	player addItemToUniform "B_IR_Grenade";
};
["Open buying menu by pressing 'B'"] spawn fn_warning;
if !(isnil "S1") then {[] spawn fn_holdActions;};
{deleteVehicle _x} foreach Alldead;
player enableFatigue false;
//[] spawn fn_UI_counter;
//[] spawn fn_activateUI;

