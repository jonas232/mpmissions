RYD_JR_vh = (assignedVehicle player);
RYD_JR_Brother removeAction (_this select 2);

_txt = "Loading the body...";
0.5 fadeSound 0;
TitleText [_txt,"BLACK OUT",0.55];

sleep 1;

deleteVehicle RYD_JR_Brother;
loaded_body = true;

	{
	_id = _x addAction ["<t color='#d0a900'>Load body onto the boat</t>", "BodyBoat.sqf", [], 1, false, true, "", "((isPlayer _target) and (alive RYD_JR_vh) and (({alive _x} count RYD_JR_boats) > 0) and (({(RYD_JR_vh distance _x) < 30} count RYD_JR_boats) > 0) and not (has_body_boat) and ((player distance RYD_JR_vh) < 6))"];
	}
foreach (RYD_JR_Recruitable + [player]);

0.5 fadeSound 1;
TitleText [_txt,"BLACK IN",0.55];

sleep 0.6;

if (alive RYD_JR_boat) then {TitleText ["All right! Now, I'll just drive back to my boat...","PLAIN DOWN", 1]};

_cond = "((isPlayer _target) and not (RYD_JR_inStealth) and not (isNull (assignedVehicle player)) and not ((assignedVehicle player) in (RYD_JR_boats + [RYD_JR_vh])) and (((assignedVehicle player) distance RYD_JR_vh) < 20) and ((player distance (assignedVehicle player)) < 6))";

	{
	_aID = _x addAction ["<t color='#d0a900'>Move body into your current vehicle</t>", "MoveBody.sqf", [], 1, false, true, "",_cond]
	}
foreach (RYD_JR_Recruitable + [player]);
