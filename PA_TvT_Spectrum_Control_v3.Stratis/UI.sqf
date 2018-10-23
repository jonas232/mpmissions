// SHOW AWESOME NOOBS UI
disableSerialization;
titleRsc ["BIS_LG_PlayersStats", "PLAIN"];

waitUntil {!isNull (uiNameSpace getVariable "PlayersStats")};
  _display = uiNameSpace getVariable "PlayersStats";

//----------------------------------------------------------------------------------
// DEFINED ALL UI ELEMENTS
//----------------------------------------------------------------------------------

  //ODPOCET/TIMER
  _hodiny = _display displayCtrl 16654;
  _hodiny ctrlSetTextColor [1,1,1,0.3];
  _hodiny ctrlSetBackgroundColor [0,0,0,0];

//----------------------------------------------------------------------------------
// GREEN TEAM SKULLS AND ALIVE STATUS
//----------------------------------------------------------------------------------
    _grnicon1 = _display displayCtrl 17841;
    _grnskull1 = _display displayCtrl 16841;
    _grnicon2 = _display displayCtrl 17842;
    _grnskull2 = _display displayCtrl 16842;
    _grnicon3 = _display displayCtrl 17843;
    _grnskull3 = _display displayCtrl 16843;
    _grnicon4 = _display displayCtrl 17844;
    _grnskull4 = _display displayCtrl 16844;
      //ZELENI POCET BODU / GREEN POINTS
    _grnText1 = _display displayCtrl 16649;
    _grnText1 ctrlSetText "0";
    _grnText1 ctrlSetTextColor [1,1,1,0.3];
      //NASTAVENI PRUHLEDNOSTI LEBKY / ALPHA OF SKULLS
    _grnskull1 ctrlSetTextColor [0,0,0,0];
    _grnskull2 ctrlSetTextColor [0,0,0,0];
    _grnskull3 ctrlSetTextColor [0,0,0,0];
    _grnskull4 ctrlSetTextColor [0,0,0,0];

//----------------------------------------------------------------------------------
// PURPLE TEAM SKULLS AND ALIVE STATUS
//----------------------------------------------------------------------------------
    _redicon1 = _display displayCtrl 17845;
    _redskull1 = _display displayCtrl 16845;
    _redicon2 = _display displayCtrl 17846;
    _redskull2 = _display displayCtrl 16846;
    _redicon3 = _display displayCtrl 17847;
    _redskull3 = _display displayCtrl 16847;
    _redicon4 = _display displayCtrl 17848;
    _redskull4 = _display displayCtrl 16848;
      //CERVENI POCET BODU / PURPLE POINTS
    _redText1 = _display displayCtrl 16646;
    _redText1 ctrlSetText "0";
    _redText1 ctrlSetTextColor [1,1,1,0.3];
      //NASTAVENI PRUHLEDNOSTI LEBKY / ALPHA OF SKULLS
    _redskull1 ctrlSetTextColor [0,0,0,0];
    _redskull2 ctrlSetTextColor [0,0,0,0];
    _redskull3 ctrlSetTextColor [0,0,0,0];
    _redskull4 ctrlSetTextColor [0,0,0,0];

//----------------------------------------------------------------------------------
// BLUE TEAM SKULLS AND ALIVE STATUS
//----------------------------------------------------------------------------------
    _blueicon1 = _display displayCtrl 17849;
    _blueskull1 = _display displayCtrl 16849;
    _blueicon2 = _display displayCtrl 17850;
    _blueskull2 = _display displayCtrl 16851;
    _blueicon3 = _display displayCtrl 17851;
    _blueskull3 = _display displayCtrl 16852;
    _blueicon4 = _display displayCtrl 17852;
    _blueskull4 = _display displayCtrl 16853;
      //MODRI POCET BODU / BLUE POINTS
    _bluText1 = _display displayCtrl 16647;
    _bluText1 ctrlSetText "0";
    _bluText1 ctrlSetTextColor [1,1,1,0.3];
      //NASTAVENI PRUHLEDNOSTI LEBKY / ALPHA OF SKULLS
    _blueskull1 ctrlSetTextColor [0,0,0,0];
    _blueskull2 ctrlSetTextColor [0,0,0,0];
    _blueskull3 ctrlSetTextColor [0,0,0,0];
    _blueskull4 ctrlSetTextColor [0,0,0,0];

//----------------------------------------------------------------------------------
// WHITE TEAM SKULLS AND ALIVE STATUS
//----------------------------------------------------------------------------------
    _whiteicon1 = _display displayCtrl 17853;
    _whiteskull1 = _display displayCtrl 16850;
    _whiteicon2 = _display displayCtrl 17854;
    _whiteskull2 = _display displayCtrl 16854;
    _whiteicon3 = _display displayCtrl 17855;
    _whiteskull3 = _display displayCtrl 16855;
    _whiteicon4 = _display displayCtrl 17856;
    _whiteskull4 = _display displayCtrl 16856;
      //BILI POCET BODU / WHITE POINTS
    _wthText1 = _display displayCtrl 16648;
    _wthText1 ctrlSetText "0";
    _wthText1 ctrlSetTextColor [1,1,1,0.3];
      //NASTAVENI PRUHLEDNOSTI LEBKY / ALPHA OF SKULLS
    _whiteskull1 ctrlSetTextColor [0,0,0,0];
    _whiteskull2 ctrlSetTextColor [0,0,0,0];
    _whiteskull3 ctrlSetTextColor [0,0,0,0];
    _whiteskull4 ctrlSetTextColor [0,0,0,0];

//----------------------------------------------------------------------------------
// WINNER ANNOUNCEMENT
//----------------------------------------------------------------------------------

    //TEXT KDO VYHRAL
    _infoText1 = _display displayCtrl 16653;
    _infoText1 ctrlSetText (format [""]);
    _infoText1 ctrlSetTextColor [1,1,1,0.3];
    _infotext1 ctrlSetBackgroundColor [0,0,0,0];
    //POZADI TABULKY
    //_infoText2 = _display displayCtrl 55123;
    //_infoText2 ctrlSetTextColor [1,0,1,0.3];

//----------------------------------------------------------------------------------
// KRUTOPŘÍSNÁ NAHEKOVANÁ SMYČKA UI (JAK BY ŘEKL HLADAS, RADĚJI NEDĚLEJTE NIC!)
//----------------------------------------------------------------------------------
while {true} do
{

    /*
    _hodiny ctrlSetStructuredText (parseText format ["%1",glt_timerMsg]);

    if (timer_hodiny  < 10 || timer_hodiny  > 120 ) then {_hodiny ctrlSetTextColor [0.8,0,0,0.6];};
    if (timer_hodiny  >= 10 && timer_hodiny  < 120) then {_hodiny ctrlSetTextColor [1,1,1,0.3];};
    */

    //----------------------------------------------------------------------------------
    // INFO TEXT AFTER EVERY ROUND
    //----------------------------------------------------------------------------------
    /*
    if (GREEN_WON) then {_infotext1 ctrlSetBackgroundColor [0,0,0,0.9];_infoText1 ctrlSetTextColor [0,0.8,0,0.8];_infoText1 ctrlSetText "GREEN TEAM WON THE ROUND";};
    if (WHITE_WON) then {_infotext1 ctrlSetBackgroundColor [0,0,0,0.9];_infoText1 ctrlSetTextColor [1,0,1,0.8];_infoText1 ctrlSetText "PURPLE TEAM WON THE ROUND";};
    if (RED_WON) then {_infotext1 ctrlSetBackgroundColor [0,0,0,0.9];_infoText1 ctrlSetTextColor [1,0,0,0.8];_infoText1 ctrlSetText "RED TEAM WON THE ROUND";};
    if (BLUE_WON) then {_infotext1 ctrlSetBackgroundColor [0,0,0,0.9];_infoText1 ctrlSetTextColor [0,0.6,1,0.8];_infoText1 ctrlSetText "BLUE TEAM WON THE ROUND";};
    */


    //----------------------------------------------------------------------------------
    // SET POINTS OF TEAMS IN UI
    //----------------------------------------------------------------------------------

    _bluText1 ctrlSetText (format ["%1",blueScore]);
    _redText1 ctrlSetText (format ["%1",redscore]);
    _grnText1 ctrlSetText (format ["%1",greenscore]);
    _wthText1 ctrlSetText (format ["%1",whitescore]);

    //----------------------------------------------------------------------------------
    // HANDLING SHOW/HIDE SKULLS (ALIVE/DEAD SOLDIERS)
    //----------------------------------------------------------------------------------

    if (isnil "bp1" || {!alive bp1}) then {_blueicon1 ctrlSetBackgroundColor [0,0.7,1,0.05];_blueskull1 ctrlSetTextColor [1,1,1,0.5];} else {_blueicon1 ctrlSetBackgroundColor [0,0.7,1,0.8];_blueskull1 ctrlSetTextColor [1,1,1,0];};
    if (isnil "bp2" || {!alive bp2}) then {_blueicon2 ctrlSetBackgroundColor [0,0.7,1,0.05];_blueskull2 ctrlSetTextColor [1,1,1,0.5];} else {_blueicon2 ctrlSetBackgroundColor [0,0.7,1,0.8];_blueskull2 ctrlSetTextColor [1,1,1,0];};
    if (isnil "bp3" || {!alive bp3}) then {_blueicon3 ctrlSetBackgroundColor [0,0.7,1,0.05];_blueskull3 ctrlSetTextColor [1,1,1,0.5];} else {_blueicon3 ctrlSetBackgroundColor [0,0.7,1,0.8];_blueskull3 ctrlSetTextColor [1,1,1,0];};
    if (isnil "bp4" || {!alive bp4}) then {_blueicon4 ctrlSetBackgroundColor [0,0.7,1,0.05];_blueskull4 ctrlSetTextColor [1,1,1,0.5];} else {_blueicon4 ctrlSetBackgroundColor [0,0.7,1,0.8];_blueskull4 ctrlSetTextColor [1,1,1,0];};


    if (isnil "rp1" || {!alive rp1}) then {_redicon1 ctrlSetBackgroundColor [1,0,0,0.05];_redskull1 ctrlSetTextColor [1,1,1,0.5];} else {_redicon1 ctrlSetBackgroundColor [1,0,0,0.8];_redskull1 ctrlSetTextColor [1,1,1,0];};
    if (isnil "rp2" || {!alive rp2}) then {_redicon2 ctrlSetBackgroundColor [1,0,0,0.05];_redskull2 ctrlSetTextColor [1,1,1,0.5];} else {_redicon2 ctrlSetBackgroundColor [1,0,0,0.8];_redskull2 ctrlSetTextColor [1,1,1,0];};
    if (isnil "rp3" || {!alive rp3}) then {_redicon3 ctrlSetBackgroundColor [1,0,0,0.05];_redskull3 ctrlSetTextColor [1,1,1,0.5];} else {_redicon3 ctrlSetBackgroundColor [1,0,0,0.8];_redskull3 ctrlSetTextColor [1,1,1,0];};
    if (isnil "rp4" || {!alive rp4}) then {_redicon4 ctrlSetBackgroundColor [1,0,0,0.05];_redskull4 ctrlSetTextColor [1,1,1,0.5];} else {_redicon4 ctrlSetBackgroundColor [1,0,0,0.8];_redskull4 ctrlSetTextColor [1,1,1,0];};

    if (isnil "cp1" || {!alive cp1})  then {_whiteicon1 ctrlSetBackgroundColor [1,0,1,0.05];_whiteskull1 ctrlSetTextColor [1,1,1,0.5];} else {_whiteicon1 ctrlSetBackgroundColor [1,0,1,0.8];_whiteskull1 ctrlSetTextColor [1,1,1,0];};
    if (isnil "cp2" || {!alive cp2}) then {_whiteicon2 ctrlSetBackgroundColor [1,0,1,0.05];_whiteskull2 ctrlSetTextColor [1,1,1,0.5];} else {_whiteicon2 ctrlSetBackgroundColor [1,0,1,0.8];_whiteskull2 ctrlSetTextColor [1,1,1,0];};
    if (isnil "cp3" || {!alive cp3}) then {_whiteicon3 ctrlSetBackgroundColor [1,0,1,0.05];_whiteskull3 ctrlSetTextColor [1,1,1,0.5];} else {_whiteicon3 ctrlSetBackgroundColor [1,0,1,0.8];_whiteskull3 ctrlSetTextColor [1,1,1,0];};
    if (isnil "cp4" || {!alive cp4}) then {_whiteicon4 ctrlSetBackgroundColor [1,0,1,0.05];_whiteskull4 ctrlSetTextColor [1,1,1,0.5];} else {_whiteicon4 ctrlSetBackgroundColor [1,0,1,0.8];_whiteskull4 ctrlSetTextColor [1,1,1,0];};

    if (isnil "gp1" || {!alive gp1}) then {_grnicon1 ctrlSetBackgroundColor [0,1,0,0.05];_grnskull1 ctrlSetTextColor [1,1,1,0.5];} else {_grnicon1 ctrlSetBackgroundColor [0,1,0,0.8];_grnskull1 ctrlSetTextColor [1,1,1,0];};
    if (isnil "gp2" || {!alive gp2}) then {_grnicon2 ctrlSetBackgroundColor [0,1,0,0.05];_grnskull2 ctrlSetTextColor [1,1,1,0.5];} else {_grnicon2 ctrlSetBackgroundColor [0,1,0,0.8];_grnskull2 ctrlSetTextColor [1,1,1,0];};
    if (isnil "gp3" || {!alive gp3}) then {_grnicon3 ctrlSetBackgroundColor [0,1,0,0.05];_grnskull3 ctrlSetTextColor [1,1,1,0.5];} else {_grnicon3 ctrlSetBackgroundColor [0,1,0,0.8];_grnskull3 ctrlSetTextColor [1,1,1,0];};
    if (isnil "gp4" || {!alive gp4}) then {_grnicon4 ctrlSetBackgroundColor [0,1,0,0.05];_grnskull4 ctrlSetTextColor [1,1,1,0.5];} else {_grnicon4 ctrlSetBackgroundColor [0,1,0,0.8];_grnskull4 ctrlSetTextColor [1,1,1,0];};

    sleep 0.5;
};


/*
win info
["0.295797 * safezoneW + safezoneX","0.164 * safezoneH + safezoneY","0.401113 * safezoneW","0.07 * safezoneH"]
points
["0.295797 * safezoneW + safezoneX","0.248 * safezoneH + safezoneY","0.401113 * safezoneW","0.07 * safezoneH"]
weaponbck 1
["0.295797 * safezoneW + safezoneX","0.332 * safezoneH + safezoneY","0.12398 * safezoneW","0.308 * safezoneH"]
["0.295797 * safezoneW + safezoneX","0.584 * safezoneH + safezoneY","0.12398 * safezoneW","0.056 * safezoneH"]//weapon cost
["0.295797 * safezoneW + safezoneX","0.36 * safezoneH + safezoneY","0.12398 * safezoneW","0.196 * safezoneH"]//weapon pictur

weaponbck2
["0.434363 * safezoneW + safezoneX","0.332 * safezoneH + safezoneY","0.12398 * safezoneW","0.308 * safezoneH"]
["0.434363 * safezoneW + safezoneX","0.584 * safezoneH + safezoneY","0.12398 * safezoneW","0.056 * safezoneH"] // cost
["0.434363 * safezoneW + safezoneX","0.36 * safezoneH + safezoneY","0.12398 * safezoneW","0.196 * safezoneH"]   //pic

weaponbck3
["0.57293 * safezoneW + safezoneX","0.332 * safezoneH + safezoneY","0.12398 * safezoneW","0.308 * safezoneH"]
["0.57293 * safezoneW + safezoneX","0.584 * safezoneH + safezoneY","0.12398 * safezoneW","0.056 * safezoneH"] // cost
["0.57293 * safezoneW + safezoneX","0.36 * safezoneH + safezoneY","0.12398 * safezoneW","0.196 * safezoneH"] // pictur

pripadne dalsi moznosti
["0.295797 * safezoneW + safezoneX","0.654 * safezoneH + safezoneY","0.401113 * safezoneW","0.07 * safezoneH"]
upozorneni
["0.383312 * safezoneW + safezoneX","0.724 * safezoneH + safezoneY","0.240668 * safezoneW","0.084 * safezoneH"]
["0.448949 * safezoneW + safezoneX","0.724 * safezoneH + safezoneY","0.175031 * safezoneW","0.084 * safezoneH"] // text

exit
["0.857355 * safezoneW + safezoneX","0.892 * safezoneH + safezoneY","0.12398 * safezoneW","0.07 * safezoneH"]