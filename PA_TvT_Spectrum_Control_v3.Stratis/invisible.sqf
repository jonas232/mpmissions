//----------------------------------------------------------------------------------
// BASIC VARIABLES FOR GOING INVISIBLE
//----------------------------------------------------------------------------------

COLOR_VISION = 1 ;
_this = _this select 0;
_this setvariable ["vision",true];

//----------------------------------------------------------------------------------
// CHANGING INTO BLACK AND WHITE VISION
//----------------------------------------------------------------------------------

while {_this getvariable "vision"} do
{
  sleep 0.05;
  color_vision = color_vision - 0.11;
  "colorCorrections" ppEffectAdjust [1,1, 0, [0,0, 0, 0.0], [0.85, 0.85, 0.85, COLOR_VISION],  [0.5, 0.5, 0.5, 0]];
  "colorCorrections" ppEffectCommit 0;
  "colorCorrections" ppEffectEnable true;
  if (color_vision < 0.05) then
  {
    _this setvariable ["vision",false];
     // [_this,true] remoteexec ["bis_fnc_VRSpawnEffect",0];
    sleep INVISIBLE_TIME;
  };
};

//----------------------------------------------------------------------------------
// CHANGING FROM BLACK AND WHITE VISION
//----------------------------------------------------------------------------------
if !(_this getvariable "vision") then {
    while {!(_this getvariable "vision")} do
    {
        sleep 0.1;
        color_vision = color_vision + 0.11;
        "colorCorrections" ppEffectAdjust [1,1, 0, [0,0, 0, 0.0], [0.85, 0.85, 0.85, COLOR_VISION],  [0.5, 0.5, 0.5, 0]];
        "colorCorrections" ppEffectCommit 0;
        "colorCorrections" ppEffectEnable true;
        if (color_vision > 0.9) then
        {
           // [_this] remoteexec ["bis_fnc_VRSpawnEffect",0];
            sleep 0.5;
            _this setvariable ["vision",true];
        };
    };
};



