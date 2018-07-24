/*	
		
			Author: DanielChicken

			Description:
			Creates a flyby from behind, flying overhead.
			
			---------------------------------------------------------

			Add this to an object to test the script:

			this addAction ["Flyby test", "scripts\FlyByScript.sqf"];

			----------------------------------------------------------

			Or add this to a trigger:
	
			null=[] execVM "scripts\FlyByScript.sqf";

*/			

	//Sets the variable to the innermost scope.
		
		private ["_Target","_DistR","_DistL","_Air","_pos","_posStart","_posFinish"];

	//Who the helicopter flies over.
		
		_Target = player;

	//Which helicopter the script chooses
	//TO EDIT
	//Delete and Choose Which Helicopter you want, adding the same increases %
		
		_Air = ["RHS_UH60M","RHS_UH60M_MEV2","RHS_UH60M_ESSS2"];

	//Spawn Location and Delete Location
	//TO EDIT
	//_posStart = _Target getRelPos [HOW FAR BEHIND IT WILL SPAWN, 180];
	//_posFinish = _Target getRelPos [HOW FAR AHEAD IT WILL DELETE, 0];
		
		_posStart = _Target getRelPos [1000, 180];
		
		_posFinish = _Target getRelPos [2000, 0];
	
/////////////////////////

	//Final Script
	//TO EDIT
	//The "100" is the altitude, change this to whatever is prefered
		
		ambFlyby = [_PosStart , _PosFinish, 300, "FULL", selectRandom _Air] call BIS_fnc_ambientFlyBy;

/////////////////////////
