Titletext ["","BLACK FADED",0];

0 fadeMusic 0.4;
0 fadeSound 0;
enableSentences false;
enableRadio false;

west setFriend [resistance, 0];
resistance setFriend [west, 0];

east setFriend [resistance, 1];
resistance setFriend [east, 1];

//west setFriend [sideEnemy, 0];
//east setFriend [sideEnemy, 0];
//resistance setFriend [sideEnemy, 0];

civilian setFriend [west,1];
west setFriend [civilian,1];

//west setFriend [sideFriendly, 1];
//east setFriend [sideFriendly, 1];
//resistance setFriend [sideFriendly, 1];
//civilian setFriend [sideFriendly,1];

RYD_JR_Debug = false;

//////
//player setCaptive true;
//player allowdamage false;
//RYD_JR_AI setDamage 1;
//////

player addRating 100000;

RYD_JR_LoadTime = 100000;

RYD_JR_RepEvents = [];//[[200,[15000,20000,0],time]];
RYD_JR_Freq = [];

RYD_JR_FuelFund = 3000;
RYD_JR_FuelFundGain = 0;
RYD_JR_FuelFundSpent = 0;
RYD_JR_LastFuelFund = 3000;
RYD_JR_Asked = 0;
RYD_JR_Interrogated = 0;
RYD_JR_Searched = 0;
RYD_JR_FTDistance = 0;
RYD_JR_Outro = false;
RYD_JR_SoundO = objNull;
RYD_JR_RingO = objNull;
RYD_JR_DecoyPending = false;
RYD_JR_noWeapons = false;

_mess1 = "Alex. I know all this, I'm not a child. I decided to do this, so I'll go there and visit all the holy places until I find the one which father told us about. This has to be done now, exactly because of the situation. Any day now and they'll destroy that place, or worse, find the thing. It's just too important! We've discussed this already. It's not so bad there, I'll be cautious and all will be fine.";
_mess2 = "Alex. Greetings from Altis. I'm on the island. Indeed, pity, dad didn't tell us more specifics before he died. Yes, no doubt, they had a war here. It's chaos. People are scared, many have left. Some say that no one's in control here. It's one big mess. Anarchy! All this was left like that intentionally, if you want to know what I think. I can still hear distant shots and explosions.<br /><br />Perhaps you were right, but I'll complete my search. Anyway, I'm stuck here for at least a few more days, so I'll find this damn thing and bring it back home. The most interesting part. I've heard a rumour about a haunting wheeled demon somewhere on the island. Yeah, exactly, sounds like someone found it and turned it on. Poor bastard, whoever he was. I need to act fast, before more people die, but if it's already unleashed... I don't know. Just, what we feared. I must figure this out. Your brother.";
_mess3 = "Both of my men were caught tonight and deported somewhere. I barely avoided the same fate... I heard them talking about strongholds. Do you know anything about these strongholds? I must figure it out, or proceed alone.";
_mess4 = "Alex. Things went wrong. It was too dangeros. I should hve listened to you. Now is too late. Hurtsnot muh time lft. I am bleeding out fast. I found theplce but ths damn thing shot me, lsennbro tak careof mother I lv,,,,,,,,,,,,,,,,,";
_plan = format ["No time to waste. I got the last message en route back home after completing my last contract. Decided to divert immediately without any preparations. The island is a hostile place, no allies there, and I have only light gear with me, but to hell with this. I'll find something on Altis for sure. I need to figure out at least some framework plan. Let's try:<br /><br />PRIMARY:<br /><br /> Find brother by checking every church and chapel.<br /><br />Find a vehicle to transport brothers body to the boat.<br /><br />Take his body from the island for a proper burial.<br /><br />SECONDARY:<br /><br /> Find and check these %1strongholds%1, if possible - free the captured men, that were helping my brother, Philip.<br /><br />PS:<br /><br /> If only I could get a remote terminal of some sort, I could probably disable or even reprogram father's damn invention, if necessary. Note: need strong signal for that, so I need to get close enough. About 100 meters? An unobstructed line of sight would be optimal but I know, what that means. Perhaps a brutal approach is safer after all?",'"'];
_notes = format ["You know that his body lies at one of the churches or chapels. There are over 200 of such places on the island.<br /><br />Search the bodies of enemy team leaders. Some may hold data useful to narrow down the number of places to search.<br /><br />Intel may also be found by interrogating captives, asking locals (not always reliable) or finding Intel amongst loot items that may hold some kind of data - look for 3D exclamation marks. Each checked or excluded place will be marked on the map.<br /><br />Chance for useful info, same as overall attitude of civilians, depends on your reputation. Reputation is affected by certain actions or events. The closer the event, the stronger the impact on the locals. Also in time rumours about it may spread, thus impact may be increased further, also for distant locations. Killing civilians seriously worsens your reputation, but eliminating hostile marauders and some other actions like paying for Intel or releasing captives will raise it. However over time your actions affecting reputation will be gradually forgotten, so their impact reduced.<br /><br />When you find the body, you need to load it into your vehicle of choice. To do that, bring the vehicle very close to the body and use the loading action, that should appear at the body.<br /><br />After that, guard the body carrier vehicle well, if it's destroyed, the mission is no longer possible to win.<br /><br />Body can be also moved into another vehicle, that is currently player's vehicle and is close to the current carrier of the body.<br /><br />When the vehicle with the body is close enough, you can load the body onto the boat, that finishes the mission.<br /><br />Pay attention on showing from time to time on screen messages about spotted trails, heard sounds or sensed smells. Such notifications reflect Alex' awareness about near enemy or hidden camp presence.",[]];
_ff = format ["Fuel fund is your account, where you keep the funds needed for fuel, repairs and bribes, expressed in ff (fuel fund unit).<br /><br />You can raise its quota by hiding found loot and selling on the online black market info about hideout location. To do this, choose %1Sell content%1 action from actions menu at box, you want to sell. This will initialize the online auction.<br /><br />You can spend the funds on paying for hitch-hiking fast travel rides by using the proper action whenever you stand on a road (note: no one will take you if you are travelling with the body). Every 1 ff covers the distance of 1 meter. 1000 ff at the time can be spent for field inspection of your vehicle, which includes partial repairs and refueling.<br /><br />Sometimes you may be notified about short-term opportunities to buy via action menu info about approximate location of random empty vehicle or enemy group presence. The more offers are presented, the lesser the chance for the next (because each location may be sold only once).",'"'];
_hide = format ["If you find and clear one of the hidden camps present on the map, you can establish a hideout at the fireplace. Hideouts may be moved from camp to camp or many may be established, depending on your initial decision. Hideouts may be also packed into nearby vehicle and moved to the any suitable area.<br /><br />At a hideout's fireplace you can, via action menu, rest 6 hours at a time and treat your wounds simultaneously, if you have a first aid kit in the inventory (one will be removed) or a medkit. At each such base you can also find two cargo boxes, one allowing you to sell stored inside loot.<br /><br />Additionally, if safe, you can fast travel to your current or chosen hideout (be careful, do not leave a vehicle or obstacle on a hideout's parking area)."];
_stronghold = format ["During your search you may encounter strongholds belonging to local warlords. At such places you may expect to find better Intel and possibly more hostiles, including armor, mines, static weaponry and sometimes even aerial assets. So be extra careful!"];
_introA = format ["<font color='#d0a900'>%1The journey is the reward, if it leads somewhere.%1</font><br /><br /><br /><br /> Real pilgrimage is always a challenge. Well done game is always a fun. I hope, this scenario will provide you with both. The gameplay was designed to be immersive and dynamic with unlimited playability. I think, I've achieved that.<br /><br /> Pilgrimage combines many of my own ideas, and some provided by feedback from users. Also gathers together concepts known early on, that I always liked.<br /><br /> Pilgrimage was created as %1my own perfect scenario%1. It extensively uses Arma 3 content, gives full freedom of choice and opportunities to see parts of Altis never seen before. It makes the journey interesting, unique each time, challenging and makes you motivated to experience it again and again... In some way it's a classical quest for knowledge and power. It's dynamic and widely customizable, but always retains its specific flavour.<br /><br /> Pilgrimage does not require any custom addons to play, but was designed as mod-friendly, so user may get additional benefits by playing with properly configured modifications that add new content or tweak the gameplay. I can't guarantee flawless cooperation with custom content, but I made, what I could to raise the chance for it.<br /><br /> If you are trying this scenario for the first time, I thank you and recommend you read Alex's Notebook entries so you know, what's the Alex's back story or at least check the Pilgrimage Guide for useful infromation.<br /><br />Have fun!<br /><br /><br />Rydygier",'"',"'"];

player createDiaryRecord ["Diary", ["Welcome",_introA]];

player createDiarySubject ["GUIGuide","Pilgrimage Guide"];

_s1 = "Alex's Notebook";

player createDiarySubject ["Game",_s1];

player createDiaryRecord ["Game", ["Various",_notes]];
player createDiaryRecord ["Game", ["Strongholds",_stronghold]];
player createDiaryRecord ["Game", ["Hideouts",_hide]];
player createDiaryRecord ["Game", ["Fuel fund",_ff]];
player createDiaryRecord ["Game", ["To do",_plan]];
player createDiaryRecord ["Game", ["Message #4",_mess4]];
player createDiaryRecord ["Game", ["Message #3",_mess3]];
player createDiaryRecord ["Game", ["Message #2",_mess2]]; 
player createDiaryRecord ["Game", ["Message #1",_mess1]];

_s2 = format ["Phone calls",[]];

player createDiarySubject ["phoneC",_s2];


_intro2 = " On the next screen you'll get a chance to customize many aspects of gameplay. Of course, you can play on default settings, carefully chosen to provide optimal entertainment, but each player has their own preferences and own taste. So, if you wish to customize your own Pilgrimage, make your choices wisely, as these settings have a serious impact on the mission.<br /><br /> For example using this tool you can make Altis nearly empty or fill it with more than 1100 hostile units. Another option for most settings is to choose them randomly, so mission will surprise you. Press the blue button to begin, press ESC key when GUI is displayed to restore default settings. Chosen settings will be saved to your game profile and restored next play.<br /><br /> Apart from init settings GUI you have to your disposal a supports menu in-game (0-8). Here you can skip time, clean bodies of fallen AIs along with their gear and wrecks or switch periodic autosaving and fatigue effects.";
_lootV = " ABUNDANT - loot may be located randomly in the most of the enterable buildings across the island. Some loot may be found at the bodies of fallen enemies, but this loot will be decimated. At military bases there's an increased chance for better loot. <br /><br /> NORMAL - as ABUNDANT, but chance for finding any weaponry in civilian houses is seriously reduced. <br /><br /> REALISTIC - this is special setting that deeply changes shape of the game. In this mode there will be no loot inside civilian houses. Instead the player may find more loot at the body, hidden camp, checkpoint and military or research installations. And especially in buildings located near strongholds and guarded airfields.";
_lootO = " How often (statistically) you'll find some loot in buildings.<br /><br /> This decides, how easy will be to raise fuel fund, but also how often you'll get a chance to find something useful for you, like a weapon or ammo.<br /><br /> Note, settings higher than default means plenty of loot every larger city. The maximum setting can even make you to search most of the buildings, so be sure, you want that before you raise it. Works analogously for REALISTIC loot distribution.";
_cpDens = " Statistical density of hostile checkpoints at crossroads.<br /><br /> Maximum level means a checkpoint every four suitable crossroads on Altis. This means about 70 such places spread across the whole Altis.";
_garrDens = " Statistical chance for presence of hostile garrison group(s) at every town and village, most of the smaller settlements and some other positions.<br /><br /> Most of them will be infantry groups, some patrolling the area, some wandering and some garrisoning near buildings.<br /><br /> There's also a statistical chance for several motorized or even armored forces. Such groups will usually perform constant long range patrols between several locations and will sometimes investigate an area, where player was spotted.<br /><br /> Some recon groups may rarely spot the player's trail and try to hunt down the player, trying to predict, where the player is heading and coordinating the chase with some motorized or aerial groups in range.";
_hdDens = " Statistical chance for presence of up to 24 hidden camps, usually in the most wild and remote parts of the island.<br /><br /> Choose this setting carefully, as two dozen of camps aren't much for Altis' size, and you're not likely to find such a camp in every part of the island. These places can be very valuable. When cleared, such camp may serve as a so called hideout, a logistic corner stone of your operations, and providing you a safe place to rest or heal, fast travelling there for free, room for supplies and a place for selling loot.<br /><br /> Hideouts may be packed into an owned nearby vehicle by using the action at a fireplace and can be unpacked in another location by action from vehicle's menu.";
_phone = " Sometimes someone may call Alex. Such conversations are conducted fully autonomously, without any player interaction. Most such conversations serve only for explaining a bit about the background of the plot, but some may also provide useful information. Some players however, especially experienced, may not need such distraction and prefer to disable phone calls.<br /><br /> ADM (Anonymous Data Market) is an online service providing Alex an opportunity to instantly sell Intel about hidden loot, but also to buy Intel on the approximate location of enemy groups or available empty vehicles spread across the island. This Intel is random as for place and time of occurrence. Selling on ADM is always active, but here the player may choose to disable incoming offers if you prefer to play without such possibility.<br /><br /> Note, you'll need a radio to receive any calls or ADM messages and you'll need also a map, if you want to receive ADM offers.";
_landing = " By default Alex on his own will choose one of suitable for discrete landing spots on the coast. The player however may limit Alex's choice using the compass direction part of the coastline.<br /><br /> As this is about a stealthy incursion, don't expect a landing in the middle of the city beach.";
_multiHD = " If enabled, Alex can establish many hideouts simultaneously. Otherwise only one hideout at a time is allowed, and attempt of establishing a second hideout will result with replacing the current hideout instead of adding next one to the previous.";
_companion = " By default Alex is a lone wolf. The player however may prefer to operate with a companion, a medic who is an old friend of Alex. If the player has any subordinates, there's a possibility of random chatter from time to time.";
_hard = format [" EASY - The player is better equipped at the start (better weaponry, more magazines, vest, NV goggles...).<br /><br /> NORMAL - default. Alex begins with a random SMG, three magazines, personal items, first aid kit and a small backpack.<br /><br /> HARD - There will be no map markers, that could reveal Alex's position, so if the game difficulty settings are set properly, players this way can choose to play without any navigation markers, so they are forced to locate their own position using a map, compass, watch and characteristic elements of the surroundings. In this mode hitch-hiking is disabled and so are the shift+click waypoint feature, artillery fire mission markers, boat marker, hideout markers etc. There is also reduced efficiency of vehicle repairing via %1Inspect%1 action. Also the Intel bought on ADM will reveal random empty vehicle, not the closest one.<br /><br /> VERY HARD - the same, as HARD, but also the player starts without a map, radio, compass and watch. The hand gun instead of SMG.<br /><br /> INSANE - The same as VERY HARD, but Alex has no gear at all. Only underpants. Are you really INSANE enough to deal with it and, the more, to explain for yourself, how this possibly could happen?",'"'];
_mb = " By default the bodies of enemies killed by Alex are marked on the map, so they're easier to find. This can be disabled or expanded for all the bodies, that Alex could spot, except your brother's. Be sure to disable this if you want to play without navigation markers.";
_loot3D = " By default each nearby building containing any loot will be marked in 3D with an exclamation mark. There are a number of other 3D icons used in the game. This setting allows you to reduce the amount of displayed loot 3D marks, disable them completely or disable all 3D markers.";
_caching = " Performance and compatibility setting.<br /><br /> Caching of distant objects and units is essential in a scenario of this scale. I strongly recommend using the default caching system (D-R for Despawn-Respawn), as it's more effective. Secondary system (H-S for Hide-Show) is less effective, but more conservative, so it may help if default mode causes some issues, for example with some custom addons.<br /><br /> Additional B mode is for not removing old and far dead bodies except those from Ambient Combat. Gear left by the fallen will be removed anyway, if a body is old enough and the player is far enough.<br /><br /> Note, the supports menu (0-8) provides an option to delete all bodies and wrecks if the games performance is dropping or if you simply won't to leave dead just like that. Note, equipment of fallen soldiers will be removed too, so be sure you take what you need before removing them. The body of your brother will be not removed.";
_arty = " When enabled, on the map will be a few randomly located enemy mortars. They have ability of shelling the player in range, if spotted by any unit allied with the mortar. If near enough, motorized group equipped with SP mortars also may join the party. Additionally the player can set here 4x more ammo for the mortars (32 HE rounds by default).<br /><br /> Being under artillery fire can kill you easily. However mortars aren't very accurate and the spread is big. There are map markers showing in detail pending fire missions to increase a player's chance of survival.";
_air = " Two of the four strongholds present on the map are of an airfield type. If this option is not disabled, at both randomly chosen airfields will be present armed helicopter ready for Seek and Destroy patrol over areas in pointed range, of where the player was spotted.<br /><br /> Each allied with the chopper group have one chance to call for aerial support. Probability depends on the distance from the airfield. Helicopters are unavailable for a time after each patrol but will always actively defend airfield, if attacked by the player.<br /><br /> Note, helicopters are a deadly threat for vehicles. As long you are on foot, you are mostly safe, but staying in the vehicle during such a patrol is very risky.";
_ac = " Changes the gameplay completely. If enabled, OPFOR and Resistance are hostile to each other, while the player is still hostile to both. That means no aerial patrols for Resistance groups nor artillery or armored support if the supporting unit isn't of same side. Apart from that AC after an initial delay will spawn widely around the player patrolling groups of both sides to generate ambient combat (AC).  The amount of groups spawned at a time depends on intensity. Depending on the chosen mode, it will do that constantly, or until the limit of spawns for the given area has be reached.<br /><br /> The more urbanized an area, the more intense AC may become, so AC makes approaching towns riskier. In the more remote and wild areas far from the cities, AC intensity will be reduced to a minimum. Ambient Combat by intention boosts immersion in a FPS-friendly way by providing a war around the player.<br /><br /> Be very careful with this setting. Even set on LOW this will make you potentially unsafe and busy with hostiles. It's no longer your choice when to be involved in combat. Your enemies will fight each other, and that can possibly make things easier for you and open up new tactical possibilities.<br /><br /> Note also, if you're in are mood for experiments, you can disable all hostile presence with above settings and use AC exclusively as a dynamic tool for hostile population.";
_ammo = " By default loot boxes may contain a weapon and sometimes will also provide the correct magazines. Here you can set it, so that a weapon from the loot box will get some ammunition every time.<br /><br /> The best chance of getting the best weaponry loot is at the military installations, but those places are often heavily guarded.";
_idt = " By default you start at 5 am. Here you can choose another time to start. Note, you can wait also in-game at a hideout's fireplace or via the support menu (0-8).";
_cpl = " Amount of civilian units spawned around the player, if there are enough buildings around.<br /><br /> Civilians will wander around randomly between buildings and other areas, and they will tend to stay home or under a roof at night, rain or combat and during rain or combat. They will also react with panic or fear, and will run away from fire fights etc.<br /><br /> Some civilians, marked by the blue exclamation mark, may provide interesting Intel, or at least point an approximate direction, as to where you should look for the body. But don't trust them completely because some may give false directions. Civilians may rarely want you to assassinate some hostile unit nearby in return for Intel of good quality and some money.<br /><br /> The target will be marked approximately on the map and in 3D by another exclamation mark. The Intel you'll get will be sent via e-mail (action menu) after you kill the appointed person, and the amount of money you get depends on how you performed the task (distance, surprise...). The farther the kill shot, the bigger the reward.<br /><br /> Note, you can use custom addons with or instead of this module for civilian ambience, and Intel will still be provided by the local population.";
_cps = " Additional setting for civilian ambience. This controls, how widely civilians will be spread around the player. The lower the radius, the population becomes more thronged. The lowest settings may cause really extreme situations, like a few inhabitants per each house.";
_circle = " Amongst all the various Intel regarding your brother's body location, so called Intel Circle is the most important. It limits the search area, and if you have more than one Intel Circle, the overlap will give a more refined search area. Also, some players prefer to stay in game longer so you can control how often you'll get such Intel. You can limit the possible sources to only four warlords present on the map or even disable it completely. Even the highest settings mean that Intel is rare though.<br /><br /> Note:<br /><br /> Excluding civilians from that kind of Intel will disable the assassinate side missions, as these missions reward you with Intel Circle.";
 

player createDiaryRecord ["GUIGuide", ["Circle Intel",_circle]];
player createDiaryRecord ["GUIGuide", ["Civilian spread",_cps]];
player createDiaryRecord ["GUIGuide", ["Civilian population",_cpl]];
player createDiaryRecord ["GUIGuide", ["Initial daytime",_idt]];
player createDiaryRecord ["GUIGuide", ["Proper ammo in loot",_ammo]];
player createDiaryRecord ["GUIGuide", ["Ambient Combat",_ac]];
player createDiaryRecord ["GUIGuide", ["Air SAD range",_air]];
player createDiaryRecord ["GUIGuide", ["Artillery",_arty]];
player createDiaryRecord ["GUIGuide", ["Caching mode",_caching]];
player createDiaryRecord ["GUIGuide", ["3D icons",_loot3D]];
player createDiaryRecord ["GUIGuide", ["Mark bodies",_mb]];
player createDiaryRecord ["GUIGuide", ["Difficulty",_hard]];
player createDiaryRecord ["GUIGuide", ["Companion",_companion]];
player createDiaryRecord ["GUIGuide", ["Multiple hideouts",_multiHD]];
player createDiaryRecord ["GUIGuide", ["Landing area",_landing]];
player createDiaryRecord ["GUIGuide", ["Phone and ADM",_phone]];
player createDiaryRecord ["GUIGuide", ["Hidden camps density",_hdDens]];
player createDiaryRecord ["GUIGuide", ["Garrisons density",_garrDens]];
player createDiaryRecord ["GUIGuide", ["Checkpoints density",_cpDens]];
player createDiaryRecord ["GUIGuide", ["Loot occurence",_lootO]];
player createDiaryRecord ["GUIGuide", ["Loot distribution",_lootV]];
player createDiaryRecord ["GUIGuide", ["Overall notes",_intro2]];

AIBuddy = objNull;

RYD_JR_BoxCreated = [];

RYD_JR_SCAActive = true;

has_body = false;
loaded_body = false;
has_body_boat = false;
RYD_JR_DetectedBy = [];
RYD_JR_vh = RYD_JR_Alex;
RYD_JR_inCombat = false;
RYD_JR_inStealth = false; 
RYD_JR_isPlaying = false;
RYD_JR_isResting = false;
RYD_JR_LT = false;
RYD_JR_LT2 = false;
RYD_JR_HT = false;
RYD_JR_callRejected = false;
RYD_JR_callPending = false;
RYD_JR_AISpotted = false;
RYD_JR_AllMobile = [];
RYD_JR_EnData = false;
RYD_JR_VehData = false;
RYD_JR_ShowLootMarkers = 2;
RYD_JR_ShowKillMarkers = 2;
RYD_JR_LocatedVehs = [];
RYD_JR_LocatedGroups = [];
RYD_JR_BusyPatrols = [];
RYD_JR_PatrolCalled = false;
RYD_JR_isWaiting = false;
RYD_JR_CallNo = 0;
RYD_JR_LastChat = -30;
RYD_JR_LastCityBattle = [-3600,[0,0,0]];
RYD_JR_AfterBattle = [];

RYD_JR_LocatedVehsN = 0;
RYD_JR_LocatedGroupsN = 0;

RYD_JR_PackedCPLoot = [objNull,objNull];
RYD_JR_PackedCamp = RYD_JR_DeadMan;
RYD_JR_PackedMark = "";

RYD_JR_LastPlay = 0;
RYD_JR_LastTalk = 0;
RYD_JR_LastComm = 0;
RYD_JR_safeTracksC = [];
RYD_JR_stealthTracksC = [];
RYD_JR_combatTracksC = [];
RYD_JR_LootHouses = [];
RYD_JR_SomeHouses = [];
RYD_JR_AllLootHouses = [];
RYD_JR_AllHolders = [];
RYD_JR_AllStuff = [];
RYD_JR_AllCaptives = [];
RYD_JR_DM_Count = 0;
RYD_JR_Base = [];
RYD_JR_Mercs = [];

RYD_JR_mHandle = [] spawn {};
RYD_JR_cHandle = [] spawn {};

RYD_AS_Pause = true;
RYD_AS_SmartTargeting = true;

RydGARR_PathFinding = 0;
RydGARR_Rush = false;

RYD_JR_CargoValueM = 0.5;
RYD_JR_CargoDensityM = 1;
RYD_JR_CPDensityM = 1;
RYD_JR_GarrDensityM = 1;
RYD_JR_HCDensityM = 1;
RYD_JR_Phone = true;
RYD_JR_HCSell = true;
RYD_JR_multiHC = false;
RYD_JR_AIFriend = false;
RYD_JR_NoItems = false;
RYD_JR_CachingMode = 1;
RYD_JR_Arty = false;
RYD_JR_APRangeM = 1;
RYD_JR_ACIntense = 0;
RYD_JR_AlwaysAmmo = false;
RYD_JR_Daytime = 5;
RYD_JR_Reset = true;
RYD_JR_KeepMyBodies = false;
RYD_JR_ADM = true;
RYD_JR_ArtyMA = false;
RYD_JR_RealLoot = false;
RYD_JR_Abundant = true;
RYD_JR_BetterGear = false;
RYD_JR_AS = false;
RYD_JR_LimitedAC = false;
RYD_JR_NoMarkers = false;
RYD_JR_Naked = false;
RYD_JR_ACSpawns = [];
RYD_JR_Fatigue = true;
RYD_JR_Difficulty = 0;

RYD_JR_SCARadius = 400;
RYD_JR_SCADensity = 50;

RYD_JR_GCIntel = 5;
RYD_JR_StartingMode = "R";

_ehID = addMusicEventHandler ["MusicStop", {terminate RYD_JR_mHandle;RYD_JR_isPlaying = false;RYD_JR_LastPlay = time}];
_ehID = addMissionEventHandler ["loaded",{terminate RYD_JR_mHandle;RYD_JR_isPlaying = false;RYD_JR_PCDisabled = false;RYD_JR_LastPlay = (time - 60)}];

RYD_TakeValues = 
	{	
	_txt = "";
		
	_ix = lbCurSel 2100;

	switch (_ix) do
		{
		case (RYD_ix_CargoDens_100) : {RYD_JR_CargoDensityM = 1;_txt = format ["100%1",'%']};
		case (RYD_ix_CargoDens_75) : {RYD_JR_CargoDensityM = 0.75;_txt = format ["75%1",'%']};
		case (RYD_ix_CargoDens_50) : {RYD_JR_CargoDensityM = 0.5;_txt = format ["50%1",'%']};
		case (RYD_ix_CargoDens_25) : {RYD_JR_CargoDensityM = 0.25;_txt = format ["25%1",'%']};
		case (RYD_ix_CargoDens_10) : {RYD_JR_CargoDensityM = 0.1;_txt = format ["10%1",'%']};
		case (RYD_ix_CargoDens_0) : {RYD_JR_CargoDensityM = 0;_txt = "DISABLED"};
		case (RYD_ix_CargoDens_Rn) :
			{
			_ix2 = floor (random 6);
			switch (_ix2) do
				{
				case (0) : {RYD_JR_CargoDensityM = 1;_txt = format ["100%1",'%']};
				case (1) : {RYD_JR_CargoDensityM = 0.75;_txt = format ["75%1",'%']};
				case (2) : {RYD_JR_CargoDensityM = 0.5;_txt = format ["50%1",'%']};
				case (3) : {RYD_JR_CargoDensityM = 0.25;_txt = format ["25%1",'%']};
				case (4) : {RYD_JR_CargoDensityM = 0.1;_txt = format ["10%1",'%']};
				case (5) : {RYD_JR_CargoDensityM = 0;_txt = "DISABLED"};
				};
			}
		};
		
	profileNamespace setVariable ["RYD_ix_CargoDens",_ix];
	
	_txtM = format ["<font size=13>LOOT OCCURENCE:</font><font color='#d0a900' size=12><br />%1</font>",_txt];
	
	_ix = lbCurSel 2101;

	switch (_ix) do
		{
		case (RYD_ix_CargoDis_A) : {RYD_JR_RealLoot = false;_txt = "ABUNDANT";RYD_JR_Abundant = true};
		case (RYD_ix_CargoDis_N) : {RYD_JR_RealLoot = false;_txt = "NORMAL";RYD_JR_Abundant = false};
		case (RYD_ix_CargoDis_R) : {RYD_JR_RealLoot = true;_txt = "REALISTIC";RYD_JR_Abundant = false};
		case (RYD_ix_CargoDis_ANW) : {RYD_JR_RealLoot = false;_txt = "ABUNDANT (NW)";RYD_JR_Abundant = true;RYD_JR_noWeapons = true};
		case (RYD_ix_CargoDis_NNW) : {RYD_JR_RealLoot = false;_txt = "NORMAL (NW)";RYD_JR_Abundant = false;RYD_JR_noWeapons = true};
		case (RYD_ix_CargoDis_RNW) : {RYD_JR_RealLoot = true;_txt = "REALISTIC (NW)";RYD_JR_Abundant = false;RYD_JR_noWeapons = true};
		case (RYD_ix_CargoDis_Rn) :
			{
			_ix2 = floor (random 6);
			switch (_ix2) do
				{
				case (0) : {RYD_JR_RealLoot = false;_txt = "ABUNDANT";RYD_JR_Abundant = true};
				case (1) : {RYD_JR_RealLoot = false;_txt = "NORMAL";RYD_JR_Abundant = false};
				case (2) : {RYD_JR_RealLoot = true;_txt = "REALISTIC";RYD_JR_Abundant = false};
				case (3) : {RYD_JR_RealLoot = false;_txt = "ABUNDANT (NW)";RYD_JR_Abundant = true;RYD_JR_noWeapons = true};
				case (4) : {RYD_JR_RealLoot = false;_txt = "NORMAL (NW)";RYD_JR_Abundant = false;RYD_JR_noWeapons = true};
				case (5) : {RYD_JR_RealLoot = true;_txt = "REALISTIC (NW)";RYD_JR_Abundant = false;RYD_JR_noWeapons = true};
				};
			}
		};
		
	profileNamespace setVariable ["RYD_ix_CargoDis",_ix];
	
	if (RYD_JR_CargoDensityM == 0) then {_txt = "-"};

	_txtM = _txtM + (format ["<font size=13><br /><br />LOOT DISTRIBUTION:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
	
	_ix = lbCurSel 2102;

	switch (_ix) do
		{
		case (RYD_ix_AAmmo_ON) : {RYD_JR_AlwaysAmmo = true;_txt = "ALWAYS"};
		case (RYD_ix_AAmmo_OFF) : {RYD_JR_AlwaysAmmo = false;_txt = "SOMETIMES"};
		case (RYD_ix_AAmmo_Rn) :
			{
			_ix2 = floor (random 2);
			switch (_ix2) do
				{
				case (0) : {RYD_JR_AlwaysAmmo = true;_txt = "ALWAYS"};
				case (1) : {RYD_JR_AlwaysAmmo = false;_txt = "SOMETIMES"};
				};
			}
		};
		
	profileNamespace setVariable ["RYD_ix_AAmmo",_ix];
	
	if (RYD_JR_CargoDensityM == 0) then {_txt = "-"};
	
	_txtM = _txtM + (format ["<font size=13><br /><br />PROPER AMMO IN LOOT:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
	
	_ix = lbCurSel 2103;

	switch (_ix) do
		{
		case (RYD_ix_GarrDens_100) : {RYD_JR_GarrDensityM = 1;_txt = format ["100%1",'%']};
		case (RYD_ix_GarrDens_75) : {RYD_JR_GarrDensityM = 0.75;_txt = format ["75%1",'%']};
		case (RYD_ix_GarrDens_50) : {RYD_JR_GarrDensityM = 0.5;_txt = format ["50%1",'%']};
		case (RYD_ix_GarrDens_25) : {RYD_JR_GarrDensityM = 0.25;_txt = format ["25%1",'%']};
		case (RYD_ix_GarrDens_10) : {RYD_JR_GarrDensityM = 0.1;_txt = format ["10%1",'%']};
		case (RYD_ix_GarrDens_0) : {RYD_JR_GarrDensityM = 0;_txt = "DISABLED"};
		case (RYD_ix_GarrDens_Rn) :
			{
			_ix2 = floor (random 6);
			switch (_ix2) do
				{
				case (0) : {RYD_JR_GarrDensityM = 1;_txt = format ["100%1",'%']};
				case (1) : {RYD_JR_GarrDensityM = 0.75;_txt = format ["75%1",'%']};
				case (2) : {RYD_JR_GarrDensityM = 0.5;_txt = format ["50%1",'%']};
				case (3) : {RYD_JR_GarrDensityM = 0.25;_txt = format ["25%1",'%']};
				case (4) : {RYD_JR_GarrDensityM = 0.1;_txt = format ["10%1",'%']};
				case (5) : {RYD_JR_GarrDensityM = 0;_txt = "DISABLED"};
				};
			}
		};
		
	profileNamespace setVariable ["RYD_ix_GarrDens",_ix];

	_txtM = _txtM + (format ["<font size=13><br /><br />GARRISONS DENSITY:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
		
	_ix = lbCurSel 2104;

	switch (_ix) do
		{
		case (RYD_ix_CPDens_100) : {RYD_JR_CPDensityM = 1;_txt = format ["100%1",'%']};
		case (RYD_ix_CPDens_75) : {RYD_JR_CPDensityM = 0.75;_txt = format ["75%1",'%']};
		case (RYD_ix_CPDens_50) : {RYD_JR_CPDensityM = 0.5;_txt = format ["50%1",'%']};
		case (RYD_ix_CPDens_25) : {RYD_JR_CPDensityM = 0.25;_txt = format ["25%1",'%']};
		case (RYD_ix_CPDens_10) : {RYD_JR_CPDensityM = 0.1;_txt = format ["10%1",'%']};
		case (RYD_ix_CPDens_0) : {RYD_JR_CPDensityM = 0;_txt = "DISABLED"};
		case (RYD_ix_CPDens_Rn) :
			{
			_ix2 = floor (random 6);
			switch (_ix2) do
				{
				case (0) : {RYD_JR_CPDensityM = 1;_txt = format ["100%1",'%']};
				case (1) : {RYD_JR_CPDensityM = 0.75;_txt = format ["75%1",'%']};
				case (2) : {RYD_JR_CPDensityM = 0.5;_txt = format ["50%1",'%']};
				case (3) : {RYD_JR_CPDensityM = 0.25;_txt = format ["25%1",'%']};
				case (4) : {RYD_JR_CPDensityM = 0.1;_txt = format ["10%1",'%']};
				case (5) : {RYD_JR_CPDensityM = 0;_txt = "DISABLED"};
				};
			}
		};
		
	profileNamespace setVariable ["RYD_ix_CPDens",_ix];
	
	_txtM = _txtM + (format ["<font size=13><br /><br />CHECKPOINTS DENSITY:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
		
	_ix = lbCurSel 2105;

	switch (_ix) do
		{
		case (RYD_ix_HCDens_100) : {RYD_JR_HCDensityM = 1;_txt = format ["100%1",'%']};
		case (RYD_ix_HCDens_75) : {RYD_JR_HCDensityM = 0.75;_txt = format ["75%1",'%']};
		case (RYD_ix_HCDens_50) : {RYD_JR_HCDensityM = 0.5;_txt = format ["50%1",'%']};
		case (RYD_ix_HCDens_25) : {RYD_JR_HCDensityM = 0.25;_txt = format ["25%1",'%']};
		case (RYD_ix_HCDens_10) : {RYD_JR_HCDensityM = 0.1;_txt = format ["10%1",'%']};
		case (RYD_ix_HCDens_0) : {RYD_JR_HCDensityM = 0;_txt = "DISABLED"};
		case (RYD_ix_HCDens_Rn) :
			{
			_ix2 = floor (random 6);
			switch (_ix2) do
				{
				case (0) : {RYD_JR_HCDensityM = 1;_txt = format ["100%1",'%']};
				case (1) : {RYD_JR_HCDensityM = 0.75;_txt = format ["75%1",'%']};
				case (2) : {RYD_JR_HCDensityM = 0.5;_txt = format ["50%1",'%']};
				case (3) : {RYD_JR_HCDensityM = 0.25;_txt = format ["25%1",'%']};
				case (4) : {RYD_JR_HCDensityM = 0.1;_txt = format ["10%1",'%']};
				case (5) : {RYD_JR_HCDensityM = 0;_txt = "DISABLED"};
				};
			}
		};
		
	profileNamespace setVariable ["RYD_ix_HCDens",_ix];
	
	_txtM = _txtM + (format ["<font size=13><br /><br />HIDDEN CAMPS DENSITY:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
	
	_ix = lbCurSel 2106;
	
	switch (_ix) do
		{
		case (RYD_ix_SCA_D_50) : {RYD_JR_SCADensity = 50;_txt = "50"};
		case (RYD_ix_SCA_D_40) : {RYD_JR_SCADensity = 40;_txt = "40"};
		case (RYD_ix_SCA_D_30) : {RYD_JR_SCADensity = 30;_txt = "30"};
		case (RYD_ix_SCA_D_20) : {RYD_JR_SCADensity = 20;_txt = "20"};
		case (RYD_ix_SCA_D_10) : {RYD_JR_SCADensity = 10;_txt = "10"};
		case (RYD_ix_SCA_D_D) : {RYD_JR_SCAActive = false;_txt = "DISABLED"};
		case (RYD_ix_SCA_D_Rn) :
			{
			_ix2 = floor (random 6);
			switch (_ix2) do
				{
				case (0) : {RYD_JR_SCADensity = 50;_txt = "50"};
				case (1) : {RYD_JR_SCADensity = 40;_txt = "40"};
				case (2) : {RYD_JR_SCADensity = 30;_txt = "30"};
				case (3) : {RYD_JR_SCADensity = 20;_txt = "20"};
				case (4) : {RYD_JR_SCADensity = 10;_txt = "10"};
				case (5) : {RYD_JR_SCAActive = false;_txt = "DISABLED"};
				};
			}
		};
		
	profileNamespace setVariable ["RYD_ix_SCA_D",_ix];
	
	_txtM = _txtM + (format ["<font size=13><br /><br />CIVILIAN POPULATION:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
	
	_ix = lbCurSel 2107;
	
	switch (_ix) do
		{
		case (RYD_ix_SCA_R_600) : {RYD_JR_SCARadius = 600;_txt = "600"};
		case (RYD_ix_SCA_R_400) : {RYD_JR_SCARadius = 400;_txt = "400"};
		case (RYD_ix_SCA_R_300) : {RYD_JR_SCARadius = 300;_txt = "300"};
		case (RYD_ix_SCA_R_200) : {RYD_JR_SCARadius = 200;_txt = "200"};
		case (RYD_ix_SCA_R_100) : {RYD_JR_SCARadius = 100;_txt = "100"};
		case (RYD_ix_SCA_R_Rn) :
			{
			_ix2 = floor (random 5);
			switch (_ix2) do
				{
				case (0) : {RYD_JR_SCARadius = 600;_txt = "600"};
				case (1) : {RYD_JR_SCARadius = 400;_txt = "400"};
				case (2) : {RYD_JR_SCARadius = 300;_txt = "300"};
				case (3) : {RYD_JR_SCARadius = 200;_txt = "200"};
				case (4) : {RYD_JR_SCARadius = 100;_txt = "100"};
				};
			}
		};
		
	profileNamespace setVariable ["RYD_ix_SCA_R",_ix];
	
	if not (RYD_JR_SCAActive) then {_txt = "-"};

	_txtM = _txtM + (format ["<font size=13><br /><br />CIVILIAN SPREAD:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
	
	_ix = lbCurSel 2108;

	switch (_ix) do
		{
		case (RYD_ix_Friend_ON) : {RYD_JR_AIFriend = true;_txt = "ON"};
		case (RYD_ix_Friend_OFF) : {RYD_JR_AIFriend = false;_txt = "OFF"};
		case (RYD_ix_Friend_Rn) :
			{
			_ix2 = floor (random 2);
			switch (_ix2) do
				{
				case (0) : {RYD_JR_AIFriend = true;_txt = "ON"};
				case (1) : {RYD_JR_AIFriend = false;_txt = "OFF"};
				};
			}
		};
		
	profileNamespace setVariable ["RYD_ix_Friend",_ix];
	
	_txtM = _txtM + (format ["<font size=13><br /><br />COMPANION:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
	
	_ix = lbCurSel 2109;

	switch (_ix) do
		{
		case (RYD_ix_Arty_OFF) : {RYD_JR_Arty = false;_txt = "OFF"};
		case (RYD_ix_Arty_ON) : {RYD_JR_Arty = true;_txt = "ON"};
		case (RYD_ix_Arty_MORE) : {RYD_JR_Arty = true;RYD_JR_ArtyMA = true;_txt = "MORE AMMO"};
		case (RYD_ix_Arty_Rn) :
			{
			_ix2 = floor (random 3);
			switch (_ix2) do
				{
				case (0) : {RYD_JR_Arty = false;_txt = "OFF"};
				case (1) : {RYD_JR_Arty = true;_txt = "ON"};
				case (2) : {RYD_JR_Arty = true;RYD_JR_ArtyMA = true;_txt = "MORE AMMO"};
				};
			}
		};
		
	profileNamespace setVariable ["RYD_ix_Arty",_ix];
	
	_txtM = _txtM + (format ["<font size=13><br /><br />ARTILLERY:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
		
	_ix = lbCurSel 2110;

	switch (_ix) do
		{
		case (RYD_ix_AP_VL) : {RYD_JR_APRangeM = 2.1;_txt = "VERY LONG"};
		case (RYD_ix_AP_L) : {RYD_JR_APRangeM = 1.2;_txt = "LONG"};
		case (RYD_ix_AP_M) : {RYD_JR_APRangeM = 0.5;_txt = "MEDIUM"};
		case (RYD_ix_AP_S) : {RYD_JR_APRangeM = 0.25;_txt = "SHORT"};
		case (RYD_ix_AP_D) : {RYD_JR_APRangeM = 0;_txt = "DISABLED"};
		case (RYD_ix_AP_Rn) :
			{
			_ix2 = floor (random 5);
			switch (_ix2) do
				{
				case (0) : {RYD_JR_APRangeM = 2.1;_txt = "VERY LONG"};
				case (1) : {RYD_JR_APRangeM = 1.2;_txt = "LONG"};
				case (2) : {RYD_JR_APRangeM = 0.5;_txt = "MEDIUM"};
				case (3) : {RYD_JR_APRangeM = 0.25;_txt = "SHORT"};
				case (4) : {RYD_JR_APRangeM = 0;_txt = "DISABLED"};
				};
			}
		};
		
	profileNamespace setVariable ["RYD_ix_AP",_ix];
	
	_txtM = _txtM + (format ["<font size=13><br /><br />AIR SAD RANGE:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
		
	_ix = lbCurSel 2111;

	switch (_ix) do
		{
		case (RYD_ix_AC_H) : {RYD_JR_ACIntense = 7;_txt = "HIGH"};
		case (RYD_ix_AC_M) : {RYD_JR_ACIntense = 3;_txt = "MEDIUM"};
		case (RYD_ix_AC_L) : {RYD_JR_ACIntense = 1;_txt = "LOW"};
		case (RYD_ix_AC_HL) : {RYD_JR_ACIntense = 7;RYD_JR_LimitedAC = true;_txt = "HIGH(L)"};
		case (RYD_ix_AC_ML) : {RYD_JR_ACIntense = 3;RYD_JR_LimitedAC = true;_txt = "MEDIUM(L)"};
		case (RYD_ix_AC_LL) : {RYD_JR_ACIntense = 1;RYD_JR_LimitedAC = true;_txt = "LOW(L)"};
		case (RYD_ix_AC_D) : {RYD_JR_ACIntense = 0;_txt = "DISABLED"};
		case (RYD_ix_AC_Rn) :
			{
			_ix2 = floor (random 7);
			switch (_ix2) do
				{
				case (0) : {RYD_JR_ACIntense = 7;_txt = "HIGH"};
				case (1) : {RYD_JR_ACIntense = 3;_txt = "MEDIUM"};
				case (2) : {RYD_JR_ACIntense = 1;_txt = "LOW"};
				case (3) : {RYD_JR_ACIntense = 7;RYD_JR_LimitedAC = true;_txt = "HIGH(L)"};
				case (4) : {RYD_JR_ACIntense = 3;RYD_JR_LimitedAC = true;_txt = "MEDIUM(L)"};
				case (5) : {RYD_JR_ACIntense = 1;RYD_JR_LimitedAC = true;_txt = "LOW(L)"};
				case (6) : {RYD_JR_ACIntense = 0;_txt = "DISABLED"};
				};
			}
		};
		
	profileNamespace setVariable ["RYD_ix_AC",_ix];
	
	_txtM = _txtM + (format ["<font size=13><br /><br />AMBIENT COMBAT:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
	
	_ix = lbCurSel 2112;

	switch (_ix) do
		{
		case (RYD_ix_Diff_BG) : {RYD_JR_Difficulty = 0;RYD_JR_BetterGear = true;_txt = "EASY"};
		case (RYD_ix_Diff_N) : {RYD_JR_Difficulty = 1;_txt = "NORMAL"};
		case (RYD_ix_Diff_H) : {RYD_JR_Difficulty = 2;RYD_JR_NoMarkers = true;_txt = "HARD"};
		case (RYD_ix_Diff_HNI) : {RYD_JR_Difficulty = 3;RYD_JR_NoItems = true;RYD_JR_NoMarkers = true;_txt = "VERY HARD"};
		case (RYD_ix_Diff_HN) : {RYD_JR_Difficulty = 4;RYD_JR_Naked = true;RYD_JR_NoItems = true;RYD_JR_NoMarkers = true;_txt = "INSANE"};
		case (RYD_ix_Diff_Rn) :
			{
			_ix2 = floor (random 5);
			switch (_ix2) do
				{
				case (0) : {RYD_JR_Difficulty = 0;RYD_JR_BetterGear = true;_txt = "EASY"};
				case (1) : {RYD_JR_Difficulty = 1;_txt = "NORMAL"};
				case (2) : {RYD_JR_Difficulty = 2;RYD_JR_NoMarkers = true;_txt = "HARD"};
				case (3) : {RYD_JR_Difficulty = 3;RYD_JR_NoItems = true;RYD_JR_NoMarkers = true;_txt = "VERY HARD"};
				case (4) : {RYD_JR_Difficulty = 4;RYD_JR_Naked = true;RYD_JR_NoItems = true;RYD_JR_NoMarkers = true;_txt = "INSANE"};
				};
			}
		};
		
	profileNamespace setVariable ["RYD_ix_Diff",_ix];
	
	_txtM = _txtM + (format ["<font size=13><br /><br />DIFFICULTY:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
	
	_ix = lbCurSel 2113;

	switch (_ix) do
		{
		case (RYD_ix_multiHC_ON) : {RYD_JR_multiHC = true;_txt = "ON"};
		case (RYD_ix_multiHC_OFF) : {RYD_JR_multiHC = false;_txt = "OFF"};
		case (RYD_ix_multiHC_Rn) :
			{
			_ix2 = floor (random 2);
			switch (_ix2) do
				{
				case (0) : {RYD_JR_multiHC = true;_txt = "ON"};
				case (1) : {RYD_JR_multiHC = false;_txt = "OFF"};
				};
			}
		};
		
	profileNamespace setVariable ["RYD_ix_multiHC",_ix];
	
	_txtM = _txtM + (format ["<font size=13><br /><br />MULTIPLE HIDEOUTS:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
	
	_ix = lbCurSel 2114;
	
	switch (_ix) do
		{
		case (RYD_ix_GCI_10) : {RYD_JR_GCIntel = 10;_txt = "FREQUENT"};
		case (RYD_ix_GCI_5) : {RYD_JR_GCIntel = 5;_txt = "AVERAGE"};
		case (RYD_ix_GCI_2) : {RYD_JR_GCIntel = 2;_txt = "RARE"};
		case (RYD_ix_GCI_O) : {RYD_JR_GCIntel = -1;_txt = "ONLY WARLORDS"};
		case (RYD_ix_GCI_D) : {RYD_JR_GCIntel = 0;_txt = "DISABLED"};
		case (RYD_ix_GCI_Rn) :
			{
			_ix2 = floor (random 5);
			switch (_ix2) do
				{
				case (0) : {RYD_JR_GCIntel = 10;_txt = "FREQUENT"};
				case (1) : {RYD_JR_GCIntel = 5;_txt = "AVERAGE"};
				case (2) : {RYD_JR_GCIntel = 2;_txt = "RARE"};
				case (3) : {RYD_JR_GCIntel = -1;_txt = "ONLY WARLORDS"};
				case (4) : {RYD_JR_GCIntel = 0;_txt = "DISABLED"};
				};
			}
		};
		
	profileNamespace setVariable ["RYD_ix_GCI",_ix];
	
	_txtM = _txtM + (format ["<font size=13><br /><br />CIRCLE INTEL:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
	
	_ix = lbCurSel 2115;

	switch (_ix) do
		{
		case (RYD_ix_KillMark_FULL) : {RYD_JR_ShowKillMarkers = 2;_txt = "SPOTTED"};
		case (RYD_ix_KillMark_LIM) : {RYD_JR_ShowKillMarkers = 1;_txt = "OWN KILLS"};
		case (RYD_ix_KillMark_NONE) : {RYD_JR_ShowKillMarkers = 0;_txt = "NONE"};
		case (RYD_ix_KillMark_Rn) :
			{
			_ix2 = floor (random 3);
			switch (_ix2) do
				{
				case (0) : {RYD_JR_ShowKillMarkers = 2;_txt = "SPOTTED"};
				case (1) : {RYD_JR_ShowKillMarkers = 1;_txt = "OWN KILLS"};
				case (2) : {RYD_JR_ShowKillMarkers = 0;_txt = "NONE"};
				};
			}
		};
		
	profileNamespace setVariable ["RYD_ix_KillMark",_ix];
	
	_txtM = _txtM + (format ["<font size=13><br /><br />MARK BODIES:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
	
	_ix = lbCurSel 2116;

	switch (_ix) do
		{
		case (RYD_ix_LootMark_FULL) : {RYD_JR_ShowLootMarkers = 2;_txt = "ALL"};
		case (RYD_ix_LootMark_LIM) : {RYD_JR_ShowLootMarkers = 1;_txt = "LESS LOOT ICONS"};
		case (RYD_ix_LootMark_NONE) : {RYD_JR_ShowLootMarkers = 0;_txt = "NO LOOT ICONS"};
		case (RYD_ix_LootMark_COMM) : {RYD_JR_ShowLootMarkers = -0.5;_txt = "COMMENTS ONLY"};
		case (RYD_ix_LootMark_NONE_ALL) : {RYD_JR_ShowLootMarkers = -1;_txt = "NONE"};
		case (RYD_ix_LootMark_Rn) :
			{
			_ix2 = floor (random 5);
			switch (_ix2) do
				{
				case (0) : {RYD_JR_ShowLootMarkers = 2;_txt = "ALL"};
				case (1) : {RYD_JR_ShowLootMarkers = 1;_txt = "LESS LOOT ICONS"};
				case (2) : {RYD_JR_ShowLootMarkers = 0;_txt = "NO LOOT ICONS"};
				case (3) : {RYD_JR_ShowLootMarkers = -0.5;_txt = "COMMENTS ONLY"};
				case (4) : {RYD_JR_ShowLootMarkers = -1;_txt = "NONE"};
				};
			}
		};
		
	profileNamespace setVariable ["RYD_ix_LootMark",_ix];
	
	_txtM = _txtM + (format ["<font size=13><br /><br />3D ICONS:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
		
	_ix = lbCurSel 2117;

	switch (_ix) do
		{
		case (RYD_ix_Phone_ON_ADM_ON) : {RYD_JR_Phone = true;RYD_JR_ADM = true;_txt = "BOTH"};
		case (RYD_ix_Phone_OFF_ADM_ON) : {RYD_JR_Phone = false;RYD_JR_ADM = true;_txt = "ADM ONLY"};
		case (RYD_ix_Phone_ON_ADM_OFF) : {RYD_JR_Phone = true;RYD_JR_ADM = false;_txt = "PHONE ONLY"};
		case (RYD_ix_Phone_OFF_ADM_OFF) : {RYD_JR_Phone = false;RYD_JR_ADM = false;_txt = "NONE"};
		case (RYD_ix_Phone_Rn) :
			{
			_ix2 = floor (random 4);
			switch (_ix2) do
				{
				case (0) : {RYD_JR_Phone = true;RYD_JR_ADM = true;_txt = "BOTH"};
				case (1) : {RYD_JR_Phone = false;RYD_JR_ADM = true;_txt = "ADM ONLY"};
				case (2) : {RYD_JR_Phone = true;RYD_JR_ADM = false;_txt = "PHONE ONLY"};
				case (3) : {RYD_JR_Phone = false;RYD_JR_ADM = false;_txt = "NONE"};
				};
			}
		};
		
	profileNamespace setVariable ["RYD_ix_Phone",_ix];
	
	_txtM = _txtM + (format ["<font size=13><br /><br />PHONE AND ADM:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
	
	_ix = lbCurSel 2118;

	switch (_ix) do
		{
		case (RYD_ix_DT_DAWN) : {RYD_JR_Daytime = 5;_txt = "DAWN"};
		case (RYD_ix_DT_NOON) : {RYD_JR_Daytime = 12;_txt = "NOON"};
		case (RYD_ix_DT_SUNSET) : {RYD_JR_Daytime = 19;_txt = "SUNSET"};
		case (RYD_ix_DT_NIGHT) : {RYD_JR_Daytime = 0;_txt = "MIDNIGHT"};
		case (RYD_ix_DT_RANDOM) : {_hr = floor (random 24);RYD_JR_Daytime = _hr;_txt = (str _hr)};
		};
		
	profileNamespace setVariable ["RYD_ix_DT",_ix];
	
	_txtM = _txtM + (format ["<font size=13><br /><br />INITIAL DAYTIME:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
		
	_ix = lbCurSel 2119;

	switch (_ix) do
		{
		case (RYD_ix_StartM_R) : {RYD_JR_StartingMode = "R";_txt = "UNKNOWN"};
		case (RYD_ix_StartM_N) : {RYD_JR_StartingMode = "N";_txt = "NORTH"};
		case (RYD_ix_StartM_E) : {RYD_JR_StartingMode = "E";_txt = "EAST"};
		case (RYD_ix_StartM_S) : {RYD_JR_StartingMode = "S";_txt = "SOUTH"};
		case (RYD_ix_StartM_W) : {RYD_JR_StartingMode = "W";_txt = "WEST"};
		};
		
	profileNamespace setVariable ["RYD_ix_StartM",_ix];
	
	_txtM = _txtM + (format ["<font size=13><br /><br />LANDING AREA:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
				
	_ix = lbCurSel 2120;

	switch (_ix) do
		{
		case (RYD_ix_Caching_1) : {RYD_JR_CachingMode = 1;_txt = "D-R"};
		case (RYD_ix_Caching_2) : {RYD_JR_CachingMode = 2;_txt = "H-S"};
		case (RYD_ix_Caching_1b) : {RYD_JR_CachingMode = 1;RYD_JR_KeepMyBodies = true;_txt = "D-R(B)"};
		case (RYD_ix_Caching_2b) : {RYD_JR_CachingMode = 2;RYD_JR_KeepMyBodies = true;_txt = "H-S(B)"};
		};
		
	profileNamespace setVariable ["RYD_ix_Caching",_ix];
	
	_txtM = _txtM + (format ["<font size=13><br /><br />CACHING MODE:</font><font color='#d0a900' size=12><br />%1</font>",_txt]);
			
	player createDiaryRecord ["Diary", ["Settings review",_txtM]];
	
	saveProfileNamespace;
	
	RYD_JR_Reset = false;
	};
	
finishMissionInit;

RYD_init_cam = "camera" camCreate [2668.46,12383.7,50];
RYD_init_cam setDir 50;
RYD_init_cam cameraEffect ["internal", "BACK"];
RYD_init_cam camCommit 0;

0 setFog [1, 0.15, 0];

0 fadeSound 0;

sleep 0.5;

_tracks = 
	[
	"BackgroundTrack03_F_EPC",
	"BackgroundTrack02_F_EPC",
	"BackgroundTrack01_F_EPC",
	"LeadTrack03_F_EPC"
	];

_track = _tracks select (floor (random (count _tracks)));

playMusic _track;

RYD_JR_Dialog = 
	{
	_dl = createDialog "RscPIO";

	waitUntil {dialog};
	
	RYD_ix_CargoDens_100 = lbAdd [2100, "100%"];
	RYD_ix_CargoDens_75 = lbAdd [2100, "75%"];
	RYD_ix_CargoDens_50 = lbAdd [2100, "50%"];
	RYD_ix_CargoDens_25 = lbAdd [2100, "25%"];
	RYD_ix_CargoDens_10 = lbAdd [2100, "10%"];
	RYD_ix_CargoDens_0 = lbAdd [2100, "NONE"];
	RYD_ix_CargoDens_Rn = lbAdd [2100, "RANDOM"];

	lbSetCurSel [2100, profileNamespace getVariable ["RYD_ix_CargoDens",RYD_ix_CargoDens_50]];

	RYD_ix_CargoDis_A = lbAdd [2101, "ABUNDANT"];
	RYD_ix_CargoDis_N = lbAdd [2101, "NORMAL"];
	RYD_ix_CargoDis_R = lbAdd [2101, "REALISTIC"];
	RYD_ix_CargoDis_ANW = lbAdd [2101, "ABUNDANT (NW)"];
	RYD_ix_CargoDis_NNW = lbAdd [2101, "NORMAL (NW)"];
	RYD_ix_CargoDis_RNW = lbAdd [2101, "REALISTIC (NW)"];
	RYD_ix_CargoDis_Rn = lbAdd [2101, "RANDOM"];

	lbSetCurSel [2101,profileNamespace getVariable ["RYD_ix_CargoDis",RYD_ix_CargoDis_N]];	
	
	
	RYD_ix_AAmmo_ON = lbAdd [2102, "ALWAYS"];
	RYD_ix_AAmmo_OFF = lbAdd [2102, "SOMETIMES"];
	RYD_ix_AAmmo_Rn = lbAdd [2102, "RANDOM"];

	lbSetCurSel [2102, profileNamespace getVariable ["RYD_ix_AAmmo",RYD_ix_AAmmo_OFF]];
	
	
	RYD_ix_GarrDens_100 = lbAdd [2103, "100%"];
	RYD_ix_GarrDens_75 = lbAdd [2103, "75%"];
	RYD_ix_GarrDens_50 = lbAdd [2103, "50%"];
	RYD_ix_GarrDens_25 = lbAdd [2103, "25%"];
	RYD_ix_GarrDens_10 = lbAdd [2103, "10%"];
	RYD_ix_GarrDens_0 = lbAdd [2103, "NONE"];
	RYD_ix_GarrDens_Rn = lbAdd [2103, "RANDOM"];

	lbSetCurSel [2103, profileNamespace getVariable ["RYD_ix_GarrDens",RYD_ix_GarrDens_75]];
	

	RYD_ix_CPDens_100 = lbAdd [2104, "100%"];
	RYD_ix_CPDens_75 = lbAdd [2104, "75%"];
	RYD_ix_CPDens_50 = lbAdd [2104, "50%"];
	RYD_ix_CPDens_25 = lbAdd [2104, "25%"];
	RYD_ix_CPDens_10 = lbAdd [2104, "10%"];
	RYD_ix_CPDens_0 = lbAdd [2104, "NONE"];
	RYD_ix_CPDens_Rn = lbAdd [2104, "RANDOM"];

	lbSetCurSel [2104, profileNamespace getVariable ["RYD_ix_CPDens",RYD_ix_CPDens_25]];


	RYD_ix_HCDens_100 = lbAdd [2105, "100%"];
	RYD_ix_HCDens_75 = lbAdd [2105, "75%"];
	RYD_ix_HCDens_50 = lbAdd [2105, "50%"];
	RYD_ix_HCDens_25 = lbAdd [2105, "25%"];
	RYD_ix_HCDens_10 = lbAdd [2105, "10%"];
	RYD_ix_HCDens_0 = lbAdd [2105, "NONE"];
	RYD_ix_HCDens_Rn = lbAdd [2105, "RANDOM"];

	lbSetCurSel [2105, profileNamespace getVariable ["RYD_ix_HCDens",RYD_ix_HCDens_100]];	
	
	
	RYD_ix_SCA_D_50 = lbAdd [2106, "50"];
	RYD_ix_SCA_D_40 = lbAdd [2106, "40"];	
	RYD_ix_SCA_D_30 = lbAdd [2106, "30"];
	RYD_ix_SCA_D_20 = lbAdd [2106, "20"];
	RYD_ix_SCA_D_10 = lbAdd [2106, "10"];
	RYD_ix_SCA_D_D = lbAdd [2106, "DISABLED"];
	RYD_ix_SCA_D_Rn = lbAdd [2106, "RANDOM"];

	lbSetCurSel [2106, profileNamespace getVariable ["RYD_ix_SCA_D",RYD_ix_SCA_D_30]];
	
	
	RYD_ix_SCA_R_600 = lbAdd [2107, "600"];
	RYD_ix_SCA_R_400 = lbAdd [2107, "400"];
	RYD_ix_SCA_R_300 = lbAdd [2107, "300"];	
	RYD_ix_SCA_R_200 = lbAdd [2107, "200"];
	RYD_ix_SCA_R_100 = lbAdd [2107, "100"];
	RYD_ix_SCA_R_Rn = lbAdd [2107, "RANDOM"];

	lbSetCurSel [2107, profileNamespace getVariable ["RYD_ix_SCA_R",RYD_ix_SCA_R_400]];
	
	
	RYD_ix_Friend_ON = lbAdd [2108, "ON"];
	RYD_ix_Friend_OFF = lbAdd [2108, "OFF"];
	RYD_ix_Friend_Rn = lbAdd [2108, "RANDOM"];

	lbSetCurSel [2108, profileNamespace getVariable ["RYD_ix_Friend",RYD_ix_Friend_OFF]];


	RYD_ix_Arty_MORE = lbAdd [2109, "MORE AMMO"];
	RYD_ix_Arty_ON = lbAdd [2109, "ON"];
	RYD_ix_Arty_OFF = lbAdd [2109, "OFF"];
	RYD_ix_Arty_Rn = lbAdd [2109, "RANDOM"];

	lbSetCurSel [2109, profileNamespace getVariable ["RYD_ix_Arty",RYD_ix_Arty_OFF]];

	
	RYD_ix_AP_VL = lbAdd [2110, "VERY LONG"];	
	RYD_ix_AP_L = lbAdd [2110, "LONG"];
	RYD_ix_AP_M = lbAdd [2110, "MEDIUM"];
	RYD_ix_AP_S = lbAdd [2110, "SHORT"];
	RYD_ix_AP_D = lbAdd [2110, "DISABLED"];
	RYD_ix_AP_Rn = lbAdd [2110, "RANDOM"];

	lbSetCurSel [2110, profileNamespace getVariable ["RYD_ix_AP",RYD_ix_AP_M]];


	RYD_ix_AC_H = lbAdd [2111, "HIGH"];
	RYD_ix_AC_M = lbAdd [2111, "MEDIUM"];
	RYD_ix_AC_L = lbAdd [2111, "LOW"];
	RYD_ix_AC_HL = lbAdd [2111, "HIGH(L)"];
	RYD_ix_AC_ML = lbAdd [2111, "MEDIUM(L)"];
	RYD_ix_AC_LL = lbAdd [2111, "LOW(L)"];
	RYD_ix_AC_D = lbAdd [2111, "DISABLED"];
	RYD_ix_AC_Rn = lbAdd [2111, "RANDOM"];

	lbSetCurSel [2111, profileNamespace getVariable ["RYD_ix_AC",RYD_ix_AC_D]];
	
	
	RYD_ix_Diff_BG = lbAdd [2112, "EASY"];
	RYD_ix_Diff_N = lbAdd [2112, "NORMAL"];
	RYD_ix_Diff_H = lbAdd [2112, "HARD"];
	RYD_ix_Diff_HNI = lbAdd [2112, "VERY HARD"];
	RYD_ix_Diff_HN = lbAdd [2112, "INSANE"];
	RYD_ix_Diff_Rn = lbAdd [2112, "RANDOM"];

	lbSetCurSel [2112, profileNamespace getVariable ["RYD_ix_Diff",RYD_ix_Diff_N]];


	RYD_ix_multiHC_ON = lbAdd [2113, "ON"];
	RYD_ix_multiHC_OFF = lbAdd [2113, "OFF"];
	RYD_ix_multiHC_Rn = lbAdd [2113, "RANDOM"];

	lbSetCurSel [2113, profileNamespace getVariable ["RYD_ix_multiHC",RYD_ix_multiHC_ON]];


	RYD_ix_GCI_10 = lbAdd [2114, "FREQUENT"];
	RYD_ix_GCI_5 = lbAdd [2114, "AVERAGE"];
	RYD_ix_GCI_2 = lbAdd [2114, "RARE"];	
	RYD_ix_GCI_O = lbAdd [2114, "ONLY WARLORDS"];
	RYD_ix_GCI_D = lbAdd [2114, "DISABLED"];
	RYD_ix_GCI_Rn = lbAdd [2114, "RANDOM"];

	lbSetCurSel [2114, profileNamespace getVariable ["RYD_ix_GCI",RYD_ix_GCI_5]];
	
	
	RYD_ix_KillMark_FULL = lbAdd [2115, "SPOTTED"];
	RYD_ix_KillMark_LIM = lbAdd [2115, "OWN KILLS"];
	RYD_ix_KillMark_NONE = lbAdd [2115, "NONE"];
	RYD_ix_KillMark_Rn = lbAdd [2115, "RANDOM"];

	lbSetCurSel [2115, profileNamespace getVariable ["RYD_ix_KillMark",RYD_ix_KillMark_LIM]];
	

	RYD_ix_LootMark_FULL = lbAdd [2116, "ALL"];
	RYD_ix_LootMark_LIM = lbAdd [2116, "LESS LOOT ICONS"];
	RYD_ix_LootMark_NONE = lbAdd [2116, "NO LOOT ICONS"];
	RYD_ix_LootMark_COMM = lbAdd [2116, "COMMENTS ONLY"];
	RYD_ix_LootMark_NONE_ALL = lbAdd [2116, "NONE"];
	RYD_ix_LootMark_Rn = lbAdd [2116, "RANDOM"];

	lbSetCurSel [2116, profileNamespace getVariable ["RYD_ix_LootMark",RYD_ix_LootMark_FULL]];
	

	RYD_ix_Phone_ON_ADM_ON = lbAdd [2117, "BOTH"];
	RYD_ix_Phone_OFF_ADM_ON = lbAdd [2117, "ADM ONLY"];
	RYD_ix_Phone_ON_ADM_OFF = lbAdd [2117, "PHONE ONLY"];
	RYD_ix_Phone_OFF_ADM_OFF = lbAdd [2117, "NONE"];
	RYD_ix_Phone_Rn = lbAdd [2117, "RANDOM"];

	lbSetCurSel [2117, profileNamespace getVariable ["RYD_ix_Phone",RYD_ix_Phone_ON_ADM_ON]];
	
	
	RYD_ix_DT_DAWN = lbAdd [2118, "DAWN"];
	RYD_ix_DT_NOON = lbAdd [2118, "NOON"];
	RYD_ix_DT_SUNSET = lbAdd [2118, "SUNSET"];
	RYD_ix_DT_NIGHT = lbAdd [2118, "MIDNIGHT"];
	RYD_ix_DT_RANDOM = lbAdd [2118, "RANDOM"];

	lbSetCurSel [2118, profileNamespace getVariable ["RYD_ix_DT",RYD_ix_DT_DAWN]];
	
	RYD_ix_StartM_N = lbAdd [2119, "NORTH"];
	RYD_ix_StartM_S = lbAdd [2119, "SOUTH"];
	RYD_ix_StartM_R = lbAdd [2119, "UNKNOWN"];
	RYD_ix_StartM_E = lbAdd [2119, "EAST"];
	RYD_ix_StartM_W = lbAdd [2119, "WEST"];

	lbSetCurSel [2119, profileNamespace getVariable ["RYD_ix_StartM",RYD_ix_StartM_R]];


	RYD_ix_Caching_1 = lbAdd [2120, "D-R"];
	RYD_ix_Caching_2 = lbAdd [2120, "H-S"];
	RYD_ix_Caching_1b = lbAdd [2120, "D-R(B)"];
	RYD_ix_Caching_2b = lbAdd [2120, "H-S(B)"];

	lbSetCurSel [2120, profileNamespace getVariable ["RYD_ix_Caching",RYD_ix_Caching_1]];
	
		
	waitUntil {not dialog};
	
	if (RYD_JR_Reset) then
		{
		systemChat "Restoring default settings";
		
			{
			profileNamespace setVariable [_x,nil]
			}
		foreach ["RYD_ix_CargoDis","RYD_ix_CargoDens","RYD_ix_CPDens","RYD_ix_GarrDens","RYD_ix_HCDens","RYD_ix_Phone","RYD_ix_StartM","RYD_ix_multiHC","RYD_ix_Friend","RYD_ix_Diff","RYD_ix_KillMark","RYD_ix_LootMark","RYD_ix_Caching","RYD_ix_Caching","RYD_ix_Arty","RYD_ix_AP","RYD_ix_AC","RYD_ix_AAmmo","RYD_ix_DT","RYD_ix_SCA_D","RYD_ix_SCA_R","RYD_ix_GCI"];
		
		saveProfileNamespace;
		
		[] call RYD_JR_Dialog;
		};
	};

[] call RYD_JR_Dialog;

if (RYD_JR_ACIntense > 0) then
	{
	east setFriend [resistance, 0];
	resistance setFriend [east, 0];
	};
	
RYD_JR_GLimit = floor (142 - (RYD_JR_ACIntense/2));

2 fadeMusic 0;

sleep 2.2;

if (RYD_JR_NoMarkers) then {deleteMarker "bm1"};

playMusic "";

0 fadeMusic 0.4;

//Titletext [sText,"BLACK FADED",0];

[] execVM "RYD_JR\JRInit.sqf";



