
call compile preprocessfile "KIA\KIA_fnc.sqf"; 

	{
	if not ((side _x) in [civilian]) then 
		{
		if not ((side _x) in [west]) then
			{
			_KilledEH = _x addEventHandler ["Killed", {nul = _this spawn KilledMark}];
			_x setVariable ["RYD_JR_RIPmark",_KilledEH];
			};
			
		_aID = _x addAction ["<t color='#d0a900'>Sell content</t>", RYD_JR_SellCargo, false, 1, false, true, "", "not (alive _target)"];
		};
	}
foreach AllUnits;  