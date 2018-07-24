if (!isServer) exitWith {};

_cachepos = getposatl (_this select 0);
[_cachepos]spawn {
_cachepos = _this select 0;
"Bo_GBU12_lgb" createVehicle _cachepos;
sleep 0.8;
"Bo_GBU12_lgb" createVehicle [(_cachepos select 0) + random(5) - 10,(_cachepos select 1) + random(5) - 10,(_cachepos select 2)];
sleep 0.4;
"Bo_GBU12_lgb" createVehicle [(_cachepos select 0) + random(5) - 10,(_cachepos select 1) + random(5) - 10,(_cachepos select 2)];
sleep 2;
"Bo_GBU12_lgb" createVehicle [(_cachepos select 0) + random(5) - 10,(_cachepos select 1) + random(5) - 10,(_cachepos select 2)];
};
