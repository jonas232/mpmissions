RYD_JR_vh = (assignedVehicle player);

_txt = "Moving the body...";
0.5 fadeSound 0;
TitleText [_txt,"BLACK OUT",0.55];

sleep 1;

0.5 fadeSound 1;
TitleText [_txt,"BLACK IN",0.55];

sleep 0.6;

TitleText ["OK. Body moved into my current vehicle...","PLAIN DOWN", 1];