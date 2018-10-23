_tgt = _this select 0;

_tgt removeAction (_this select 2);

_event = [0.5 + (random 0.5),getPosATL player,time];
RYD_JR_RepEvents pushBack _event;

_txt = "OK, you can go now. Good luck out there!";

if (_tgt getVariable ["RYD_JR_Captive",false]) then
	{
	_txt = "Get lost! Before I change my mind.";
	}
else
	{
	if not (_tgt in RYD_JR_ReleasedPOW) then
		{
		RYD_JR_ReleasedPOW pushBack _tgt
		};
	};

0.5 fadeSound 0;
TitleText [_txt,"BLACK OUT",0.55];

sleep 1;

deleteVehicle _tgt;

0.5 fadeSound 1;
TitleText [_txt,"BLACK IN",0.55];

sleep 5;
	
TitleText ["","PLAIN", 1];