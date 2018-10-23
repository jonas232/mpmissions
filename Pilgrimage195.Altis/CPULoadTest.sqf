_stoper0 = time;
_sum = 0;
_ct = 0;
_av = 0;
while {(true)} do
	{
	_stoper = floor ((time - _stoper0) * 100);
	_delay = abs (_stoper - 100);
	if (_ct > 0) then {_sum = _sum + _delay;_av = _sum/_ct};
	
	if (_delay > 30) then
		{
		player sidechat format ["Delay: %1 (average: %2)",_delay,_av];
		diag_log format ["Delay: %1 (average: %2) - %3",_delay,_av,time];
		};
		
	_stoper0 = time;
	_a = random 1000;
	sleep 0.1;
	//_a = count Allgroups;
	_b = (random 1000) * _a;
	sleep 0.1;
	//_a = count Allgroups;
	_b = (random 1000) * _a;
	sleep 0.1;
	//_a = count Allgroups;
	_b = (random 1000) * _a;
	sleep 0.1;
	//_a = count Allgroups;
	_b = (random 1000) * _a;
	sleep 0.1;
	//_a = count Allgroups;
	_b = (random 1000) * _a;
	sleep 0.1;
	//_a = count Allgroups;
	_b = (random 1000) * _a;
	sleep 0.1;
	//_a = count Allgroups;
	_b = (random 1000) * _a;
	sleep 0.1;
	//_a = count Allgroups;
	_b = (random 1000) * _a;
	sleep 0.1;
	//_a = count Allgroups;
	_b = (random 1000) * _a;
	sleep 0.1;
	_ct = _ct + 1
	};