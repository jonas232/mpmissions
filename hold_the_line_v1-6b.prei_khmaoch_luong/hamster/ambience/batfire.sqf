activatedT1 = true;
activatedT2 = true;

_c = 0;
_target = getMarkerPos "target";

//run script every few seconds
while {true} do{
	sleep (random(5)+10);
	switch (_c % 6) do {
		case 0: {bt_0 doArtilleryFire [_target, "RHS_mag_m1_he_12", 1];};
		case 1: {bt_1 doArtilleryFire [_target, "RHS_mag_m1_he_12", 1];};
		case 2: {bt_2 doArtilleryFire [_target, "RHS_mag_m1_he_12", 1];};
		case 3: {bt_3 doArtilleryFire [_target, "RHS_mag_m1_he_12", 1];};
		case 4: {bt_4 doArtilleryFire [_target, "RHS_mag_m1_he_12", 1];};
		case 5: {bt_5 doArtilleryFire [_target, "RHS_mag_m1_he_12", 1];};
	};
	_c = _c + 1;
	//hint "fire command given";
}
