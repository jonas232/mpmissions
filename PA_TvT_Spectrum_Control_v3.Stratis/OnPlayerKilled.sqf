//----------------------------------------------------------------------------------
// ??? SWITCH OFF THE LIGHT ON PLAYER UNIFORM ???
//----------------------------------------------------------------------------------
PlaySound "HS1";
//if (alive player) then {forcerespawn player;setPlayerRespawnTime 10e10;};
//player setdamage 1;
//if !(isnil "S1") then {setPlayerRespawnTime 10e10} else {setPlayerRespawnTime 0};
//if (isnil "S1") exitwith {};
//Sleep 1;
//HINT "WAIT FOR ANOTHER ROUND";

//----------------------------------------------------------------------------------
// SPLENDID TRANFER TO CAMERA
//----------------------------------------------------------------------------------

call bis_fnc_vrfadein;
[] spawn fn_holdActions;
/*
//----------------------------------------------------------------------------------
// CREATE CAMERA ABOVE ARENA MOVING ACROSS SLOWLY
//----------------------------------------------------------------------------------
_camera = "camera" camCreate [0,0,0];
_camera cameraEffect ["INTERNAL", "BACK"];
	;comment "16:19:36";
	_camera camPrepareTarget [48928.09,41085.96,-80595.19];
	_camera camPreparePos [1702.11,5592.50,83.47];
	_camera camPrepareFOV 0.700;
	_camera camCommitPrepared 0;
	/*
	;comment "14:11:27";
	_camera camPrepareTarget [70671.32,45722.50,-64542.66];
	_camera camPreparePos [6674.41,4105.90,51.88];
	_camera camPrepareFOV 0.700;
	_camera camCommitPrepared 0;

 [] execVM "UI.SQF";

	;comment "14:12:23";
	_camera camPrepareTarget [50514.89,-58303.24,-64541.29];
	_camera camPreparePos [6688.08,4198.35,55.62];
	_camera camPrepareFOV 0.700;
	_camera camCommitPrepared 200;

	;comment "16:19:59";
	_camera camPrepareTarget [-15230.65,62149.50,-80589.88];
	_camera camPreparePos [1792.57,5578.91,96.37];
	_camera camPrepareFOV 0.700;
	_camera camCommitPrepared 200;


//----------------------------------------------------------------------------------
// DESTROY CAMERA IF IS END OF THE ROUND (PLAYERRESPAWNTIME <=2)
//----------------------------------------------------------------------------------

while {true} do {

  if (!ROUND_RUNNING) exitwith {
        Sleep 0.1;
        _camera CameraEffect ["Terminate", "Back"];
        CamDestroy _camera;
        Sleep 1;
        };
    sleep 0.1;
};

*/
