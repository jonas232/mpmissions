_tgt = _this select 0;
_pos = getPosATL _tgt;

hint "Hideout established";

if not (RYD_JR_multiHC) then
	{
	RYD_JR_Base = [_tgt];
	
	if not (RYD_JR_NoMarkers) then
		{
		if (isNil "RYD_JR_HDMark") then
			{
			RYD_JR_HDMark = "hdMark_" + (str _pos);
			RYD_JR_HDMark = createMarker [RYD_JR_HDMark,_pos];
			RYD_JR_HDMark setMarkerColor "colorBlue";
			RYD_JR_HDMark setMarkerShape "ICON";
			RYD_JR_HDMark setMarkerType "mil_flag";
			RYD_JR_HDMark setMarkerSize [1,1];
			RYD_JR_HDMark setMarkerText " Hideout";
			
			_tgt setVariable ["RYD_JR_MyCPMark",RYD_JR_HDMark]
			}
		else
			{
			RYD_JR_HDMark setMarkerPos _pos;
			RYD_JR_HDMark setMarkerAlpha 1;
			}
		}
	}
else
	{
	RYD_JR_Base pushBack _tgt;

	if not (RYD_JR_NoMarkers) then
		{	
		_hdm = "hdMark_" + (str _pos);
		_hdm = createMarker [_hdm,_pos];
		_hdm setMarkerColor "colorBlue";
		_hdm setMarkerShape "ICON";
		_hdm setMarkerType "mil_flag";
		_hdm setMarkerSize [1,1];
		_hdm setMarkerText " Hideout";
		
		_tgt setVariable ["RYD_JR_MyCPMark",_hdm]
		}
	};