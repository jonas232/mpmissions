// Zeus Commands:
// Gear:

// Vics and Crates
["crate_med",this,"blu_f"] call f_fnc_assignGear;

["crate_car",this,"blu_f"] call f_fnc_assignGear;

["crate_tr",this,"blu_f"] call f_fnc_assignGear;

// Units
["co",this] call f_fnc_assignGear;
["dc",this] call f_fnc_assignGear;
["r",this] call f_fnc_assignGear;
["gren",this] call f_fnc_assignGear;
["m",this] call f_fnc_assignGear;
["ar",this] call f_fnc_assignGear;
["r",this] call f_fnc_assignGear;
["eng",this] call f_fnc_assignGear;

CST_Misc_Walls

// Vic Inits
// Humvees
["v_car",this,"blu_f"] call f_fnc_assignGear;
this execVM "scripts\fn_fuel.sqf";
[this, 3] call ace_cargo_fnc_setSpace;
["Land_CanisterFuel_F", this, 1] call ace_cargo_fnc_loadItem;
["Land_CanisterFuel_F", this, 1] call ace_cargo_fnc_loadItem;
["Land_CanisterFuel_F", this, 1] call ace_cargo_fnc_loadItem;
["Land_CanisterFuel_F", this, 1] call ace_cargo_fnc_loadItem;
["ACE_Wheel", this, 1] call ace_cargo_fnc_loadItem;
["ACE_Wheel", this, 1] call ace_cargo_fnc_loadItem
// Truck
["v_tr",this,"blu_f"] call f_fnc_assignGear;
[this, 21] call ace_cargo_fnc_setSpace;
// Fuel Crate
this setFuelCargo 0;
this attachTo [VehNato_TR1_8, [0, 0.4, -0.35] ]; 