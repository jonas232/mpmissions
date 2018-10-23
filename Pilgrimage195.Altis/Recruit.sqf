if (RYD_JR_FuelFund < 10000) exitWith {hint "You don't have enough ff."};

_unit = _this select 0;

if not (_unit in RYD_JR_ReleasedPOW) then
	{
	RYD_JR_ReleasedPOW pushBack _unit
	};

RYD_JR_FuelFund = RYD_JR_FuelFund - 10000;
RYD_JR_FuelFundSpent = RYD_JR_FuelFundSpent + 10000;

hint format ["He's now free and under your command. Your current account: %1",RYD_JR_FuelFund];

_unit removeAction (_this select 2);

_unit setCaptive false;
_unit forceSpeed -1;

_name = RYD_JR_Names select (floor (random (count RYD_JR_Names)));
RYD_JR_Names = RYD_JR_Names - [_name];

_surname = RYD_JR_Surnames select (floor (random (count RYD_JR_Surnames)));
RYD_JR_Surnames = RYD_JR_Surnames - [_surname];

_unit setName [_name + " " + _surname,_name,_surname];

_unit setNameSound _name;

_speaker = RYD_JR_Speakers select (floor (random (count RYD_JR_Speakers)));
_unit setSpeaker _speaker;
RYD_JR_Speakers = RYD_JR_Speakers - [_speaker];

_unit setVariable ["RYD_JR_MyName",_name];
	
_unit addEventHandler ["Killed",
	{
	_unit = _this select 0;
	if (_unit in RYD_JR_MyPeople) then
		{
		nul = [_unit] spawn 
			{
			_unit = _this select 0;
			_name = _unit getVariable ["RYD_JR_MyName","Buddy"];
			sleep (3 + (random 2)); 
			_mrn = RYD_JR_Mourn select (floor (random (count RYD_JR_Mourn)));
			RYD_JR_Mourn = RYD_JR_Mourn - [_mrn];
			_text = format [_mrn,_name];
			TitleText [_text,"PLAIN DOWN", 2];
			};
			
		RYD_JR_MyPeople = RYD_JR_MyPeople - [_unit];
		}
	}];
	
[_unit] joinSilent (group player);

addSwitchableUnit _unit; 

RYD_JR_Mercs pushBack _unit;
RYD_JR_MyPeople pushBack _unit;

_cond = "(isPlayer _target) and not (RYD_JR_inStealth) and (not (isNull (assignedVehicle player)) and not (RYD_JR_FuelFund < 1000) and ((player distance (assignedVehicle player)) < 6) and (((fuel (assignedVehicle player)) < 1) or ((damage (assignedVehicle player)) > 0) or not (canMove (assignedVehicle player)) or not (canFire (assignedVehicle player))))";
_aID = _unit addAction ["<t color='#d0a900'>Inspect your vehicle for 1000 ff</t>", "InspectVeh.sqf", [], 1, false, true, "",_cond];

if not (RYD_JR_NoMarkers) then
	{
	_aID = _unit addAction ["<t color='#d0a900'>Hitch-hiking</t>", "Hitchhiking.sqf", [], 1, false, true, "", "((isPlayer _target) and (isOnRoad (vehicle player)) and (RYD_JR_FuelFund > 0) and not ((RYD_JR_LT) or (RYD_JR_inStealth) or (RYD_JR_isResting) or (has_body)))"];
	};
	
_aID = _unit addAction ["<t color='#d0a900'>Check account</t>", "account.sqf", [], 1, false, true, "","(isPlayer _target)"];

if (RYD_JR_ADM) then
	{
	_aID = _unit addAction ["<t color='#d0a900'>Anonymous Data Market - hostile activity (600 ff)</t>", "ADMenemy.sqf", [], 1, false, true, "","((isPlayer _target) and (RYD_JR_EnData) and not (RYD_JR_FuelFund < 600))"];
	_aID = _unit addAction ["<t color='#d0a900'>Anonymous Data Market - vehicles (1200 ff)</t>", "ADMvehicles.sqf", [], 1, false, true, "","((isPlayer _target) and (RYD_JR_VehData) and not (RYD_JR_FuelFund < 1200))"];
	};

_aID = _unit addAction ["<t color='#d0a900'>Prepare an empty box</t>", "CreateBox.sqf", [], 1, false, true, "","(isPlayer _target) and not ((count RYD_JR_BoxCreated) > 0) and (player == (vehicle player))"];
_aID = _unit addAction ["<t color='#d0a900'>Remove prepared box</t>", "RemoveBox.sqf", [], 1, false, true, "","(isPlayer _target) and ((count RYD_JR_BoxCreated) > 0) and (player == (vehicle player))"];

_aID = _unit addAction ["<t color='#d0a900'>Return to the hideout</t>", "hideoutTravel.sqf", [], 1, false, true, "","((isPlayer _target) and ((count RYD_JR_Base) > 0) and not ((RYD_JR_inStealth) or (RYD_JR_isResting) or (has_body)))"];

_aID = _unit addAction ["<t color='#d0a900'>Force self-destruction of the UGV</t>", "HackUGV.sqf", 3, 1, false, true, "", "(isPlayer _target) and (alive RYD_JR_AI) and not (RYD_JR_UGVDisabled) and not (RYD_JR_Hacking) and (({_x in (assignedItems player)} count RYD_JR_Terminals) > 0) and (RYD_JR_AISpotted) and ((player distance RYD_JR_AI) < 100)"];
_aID = _unit addAction ["<t color='#d0a900'>Reprogram the UGV targeting</t>", "HackUGV.sqf", 1, 1, false, true, "", "(isPlayer _target) and (alive RYD_JR_AI) and not (RYD_JR_UGVDisabled) and not (RYD_JR_noAI) and not (RYD_JR_Hacking) and (({_x in (assignedItems player)} count RYD_JR_Terminals) > 0) and (RYD_JR_AISpotted) and ((player distance RYD_JR_AI) < 100)"];
_aID = _unit addAction ["<t color='#d0a900'>Disable UGV's AI control</t>", "HackUGV.sqf", 2, 1, false, true, "", "(isPlayer _target) and (alive RYD_JR_AI) and not (RYD_JR_UGVDisabled) and not (RYD_JR_Hacking) and (({_x in (assignedItems player)} count RYD_JR_Terminals) > 0) and (RYD_JR_AISpotted) and ((player distance RYD_JR_AI) < 100)"];
_aID = _unit addAction ["<t color='#d0a900'>Find ammo for your vehicle</t>", "ReammoVeh.sqf", true, 1, false, true, "", "((isPlayer _target) and (({not ((toLower _x) in ['minicarhorn','carhorn','truckhorn','truckhorn2','truckhorn3'])} count (weapons (assignedVehicle player))) > 0) and not (RYD_JR_AmmoSearch) and not (isNull (assignedVehicle player)) and ((player distance (assignedVehicle player)) < 6))"];

