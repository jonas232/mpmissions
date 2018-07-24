if (!isServer) exitWith {};


_plane = _this;
_pos = getposasl _plane;
 
_plane engineOn true;
_plane hideobject true;
 
while {true} do {
 
    sleep 0.1;
    _plane setposasl _pos;
 
    if (time > 600) exitWith {deletevehicle _plane};
 
};