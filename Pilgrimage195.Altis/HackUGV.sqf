RYD_JR_Hacking = true;

_hack = _this select 3;

switch (_hack) do
	{
	case (1) :
		{
		TitleText ["All right. So let's make this thing actually work, as it should.","PLAIN DOWN",1];
		
		sleep (1 + (random 1));
		
		hint "Connecting, stand by...";
		
		sleep (1 + (random 1));
		
		hint "Accessing, stand by...";
		
		sleep (2 + (random 1));
		
		_tooFar = false;
		
		for "_i" from 0 to 15 step 0.1 do
			{
			_dst = player distance RYD_JR_AI;
			_isLOS = [getposASL player,getPosASL RYD_JR_AI,1.0,1.0,player,RYD_JR_AI] call RYD_JR_LOSCheck;
			
			if not (_isLOS) then {_dst = _dst + (random 20)};
			
			if ((_dst - 100) > ((random 10) + (random 10) + (random 10) + (random 10))) exitWith {_tooFar = true};
			_progress = (round ((_i/15) * 1000))/10;
			_txt = "Accessing:\n %1%2";
			if (_dst > 90) then {_txt = "Accessing (weak signal):\n %1%2"};
			hintSilent format [_txt,_progress,'%'];
					
			if (_dst > 90) then {_dst = 90 + ((_dst - 90)^2)};
			
			_delay = (random 0.025) * ((_dst/20) min 1);
			
			if not (_isLOS) then
				{
				_delay  = _delay * 15
				};
			
			sleep (0.1 + _delay)
			};
			
		if (_tooFar) exitWith {hint "Connection lost. Check signal quality."};
		
		player removeAction (_this select 2);
		
		hint "Overwriting targeting settings, stand by...";
		
		sleep (2 + (random 2));
		
		hint "Done. Disconnecting...";

		RYD_JR_UGVHacked = true;
		RYD_JR_AI addRating 10000000;
		RYD_JR_AI setCaptive false;
		
		sleep 1;

		TitleText ["Great. Now this damn thing should engage only the bad guys.","PLAIN DOWN",1];
		};
		
	case (2) :
		{
		TitleText ["All right. So let's exorcize that damn ghost in the machine.","PLAIN DOWN",1];
		
		sleep (1 + (random 1));
		
		hint "Connecting, stand by...";
		
		sleep (1 + (random 1));
		
		hint "Accessing, stand by...";
		
		sleep (2 + (random 1));
		
		_tooFar = false;
		
		for "_i" from 0 to 15 step 0.1 do
			{
			_dst = player distance RYD_JR_AI;
			_isLOS = [getposASL player,getPosASL RYD_JR_AI,1.0,1.0,player,RYD_JR_AI] call RYD_JR_LOSCheck;
			
			if not (_isLOS) then {_dst = _dst + (random 20)};
			
			if ((_dst - 100) > ((random 10) + (random 10) + (random 10) + (random 10))) exitWith {_tooFar = true};
			_progress = (round ((_i/15) * 1000))/10;
			_txt = "Accessing:\n %1%2";
			if (_dst > 90) then {_txt = "Accessing (weak signal):\n %1%2"};
			hintSilent format [_txt,_progress,'%'];
					
			if (_dst > 90) then {_dst = 90 + ((_dst - 90)^2)};
			
			_delay = (random 0.025) * ((_dst/20) min 1);
			
			if not (_isLOS) then
				{
				_delay  = _delay * 15
				};
			
			sleep (0.1 + _delay)
			};
			
		if (_tooFar) exitWith {hint "Connection lost. Check signal quality."};
		
		player removeAction (_this select 2);
		
		hint "Erasing AI control algorithms, stand by...";
		
		sleep (2 + (random 2));
		
		hint "Done. Disconnecting...";

		RYD_JR_UGVHacked = true;
		RYD_JR_noAI = true;
		RYD_AS_Active = false;
		RYD_JR_AI addRating 10000000;
		RYD_JR_AI setCaptive false;
		
		sleep 1;

		TitleText ["Great. AI should be banished anytime.","PLAIN DOWN",1];
		};
		
	case (3) :
		{
		TitleText ["Now let's apply this some special medicine...","PLAIN DOWN",1];
		
		sleep (1 + (random 1));
		
		hint "Connecting, stand by...";
		
		sleep (1 + (random 1));
		
		hint "Uploading, stand by...";

		sleep (2 + (random 1));
		
		_tooFar = false;
		
		for "_i" from 0 to 15 step 0.1 do
			{
			_dst = player distance RYD_JR_AI;
			_isLOS = [getposASL player,getPosASL RYD_JR_AI,1.0,1.0,player,RYD_JR_AI] call RYD_JR_LOSCheck;
			
			if not (_isLOS) then {_dst = _dst + (random 20)};
			
			if ((_dst - 100) > ((random 10) + (random 10) + (random 10) + (random 10))) exitWith {_tooFar = true};
			_progress = (round ((_i/15) * 1000))/10;
			_txt = "Uploading:\n %1%2";
			if (_dst > 90) then {_txt = "Uploading (weak signal):\n %1%2"};
			hintSilent format [_txt,_progress,'%'];
						
			if (_dst > 90) then {_dst = 90 + ((_dst - 90)^2)};
			
			_delay = (random 0.025) * ((_dst/20) min 1);
			
			if not (_isLOS) then
				{
				_delay  = _delay * 15
				};
			
			sleep (0.1 + _delay)
			};
			
		if (_tooFar) exitWith {hint "Connection lost. Check signal quality."};
		
		player removeAction (_this select 2);
		
		hint "Data uploaded. Disconnecting.";
		
		sleep (2 + (random 2));

		RYD_JR_UGVDisabled = true;
		RYD_JR_AI setVariable ["RYD_AS_Disabled",true];
		
		RYD_JR_AI setDamage 1;
				
		sleep (1 + (random 2));

		TitleText ["Yippee ki-yay, motherfucker!","PLAIN DOWN",1];
		};
	};

RYD_JR_Hacking = false;