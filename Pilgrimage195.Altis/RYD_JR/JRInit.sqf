//0 fadeSound 0;
//TitleText ["","BLACK FADED",0];

RYD_JR_StomperKilled = false;

RYD_JR_AI addEventHandler ["Killed",
	{
	nul = [] spawn 
		{
		if ((count _this) > 1) then 
			{
			if ((_this select 1) in ([vehicle player,assignedVehicle player] + (units (group player)))) then 
				{
				RYD_JR_StomperKilled = true;
				RYD_JR_LastChat = time;
				sleep (1 + (random 2)); 
				TitleText ["Yippee ki-yay, motherfucker!","PLAIN DOWN", 1];
				}
			}
		}
	}];

RYD_JR_Names = 
	[
	"Anthis",
	"Costa",
	"Dimitirou",
	"Elias",
	"Gekas",
	"Kouris",
	"Leventis",
	"Markos",
	"Nikas",
	"Nicolo",
	"Panas",
	"Petros",
	"Rosi",
	"Samaras",
	"Stavrou",
	"Thanos",
	"Vega"
	];
	
RYD_JR_Surnames = 
	[
	"Petrakis",
	"Papadopoulos",
	"Vlahos",
	"Angelopoulos",
	"Nikolaidis",
	"Georgiou",
	"Petridis",
	"Athanasiadis",
	"Dimitriadis",
	"Papadakis",
	"Panagiotopoulos",
	"Papantoniou",
	"Constantinou",
	"Alexopoulos",
	"Argyros",
	"Banis",
	"Baros",
	"Chontos",
	"Christakos",
	"Demopoulos",
	"Drakos",
	"Eliopoulos",
	"Eliades",
	"Fotopoulos",
	"Frangos",
	"Gianakos",
	"Gianopoulos",
	"Hallas",
	"Hondros",
	"Ioannou",
	"Jason",
	"Katsaros",
	"Kritikos",
	"Livas",
	"Loukas",
	"Manolis",
	"Matranga",
	"Nasso",
	"Nikitas",
	"Papageorgiou",
	"Polites",
	"Rodis",
	"Roussos",
	"Scafidi",
	"Sotiropoulos",
	"Tavoularis",
	"Tomaras",
	"Varela",
	"Velis",
	"Xenakis",
	"Xenos",
	"Zacharias",
	"Zervas"
	];
	
RYD_JR_Speakers = 
	[
	"Male01GRE",
	"Male02GRE",
	"Male03GRE",
	"Male04GRE",
	"Male05GRE"
	];
	
RYD_JR_Speakers = RYD_JR_Speakers - [speaker player];

RYD_JR_Mourn = 
	[
	"%1!!!",
	"No! %1!",
	"Fuck! Fuck! %1!",
	"Shit! %1! Damn!",
	"Oh no, %1...",
	"%1? Report! %1! Fuck!"
	];

RYD_JR_CurrentCampfires = [];
RYD_JR_MyPeople = [];
RYD_JR_NearTargets = [];
RYD_JR_ActualTargets = [];
RYD_JR_NearCivs = [];
RYD_JR_Informers = [];
RYD_JR_ToAsk = [];
RYD_JR_Doctors = [];
RYD_JR_Mechanics = [];
RYD_JR_Sellers = [];
RYD_JR_ShopBoxes = [];
RYD_JR_Delation = [];
RYD_JR_PastDelations = [];
RYD_JR_ReportedSteps = [];
RYD_JR_LastReport = -60;

RYD_JR_Recruitable = [];

RYD_JR_Trackers2 = [];
RYD_JR_Trackers3 = [];
RYD_JR_Trackers4 = [];
RYD_JR_ReleasedPOW = [];

RYD_JR_HuntStage = 1;

if (RYD_JR_AIFriend) then
	{
	AIBuddy = (group player) createUnit ["B_G_medic_F", position player, [], 0, "FORM"];
	
	RYD_JR_Recruitable pushBack AIBuddy;
	
	addSwitchableUnit AIBuddy; 
	
	RYD_JR_MyPeople pushBack AIBuddy;
	
		{
		AIBuddy setSkill [_x,0.2 + (random 0.4) + (random 0.4)];
		}
	foreach ["general","aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding"];
	
	_name = RYD_JR_Names select (floor (random (count RYD_JR_Names)));
	RYD_JR_Names = RYD_JR_Names - [_name];
	
	_surname = RYD_JR_Surnames select (floor (random (count RYD_JR_Surnames)));
	RYD_JR_Surnames = RYD_JR_Surnames - [_surname];
	
	AIBuddy setName [_name + " " + _surname,_name,_surname];
	
	AIBuddy setNameSound _name; 
	
	AIBuddy setVariable ["RYD_JR_MyName",_name];
		
	AIBuddy addEventHandler ["Killed",
		{
		_unit = _this select 0;
		RYD_JR_AIFriend = false;
		if (_unit in RYD_JR_MyPeople) then
			{
			nul = [_unit] spawn 
				{
				_unit = _this select 0;
				_name = _unit getVariable ["RYD_JR_MyName","Buddy"];
				sleep (3 + (random 2)); 
				_mrn = RYD_JR_Mourn select (floor (random (count RYD_JR_Mourn)));
				RYD_JR_Mourn = RYD_JR_Mourn - [_mrn];
				_text = format [_mrn,_name];
				TitleText [_text,"PLAIN DOWN", 2];
				};
				
			RYD_JR_MyPeople = RYD_JR_MyPeople - [_unit];
			}
		}];
		
	_speaker = RYD_JR_Speakers select (floor (random (count RYD_JR_Speakers)));
	AIBuddy setSpeaker _speaker;
	RYD_JR_Speakers = RYD_JR_Speakers - [_speaker];
	};
	
RYD_JR_CaptivesClasses = ["B_G_medic_F","B_G_engineer_F"];
RYD_JR_ActualStrongholds = [];
RYD_JR_ActualAirfields = [];
RYD_JR_ShownStrongholds = [];

player setName ["Alexander Laskaris","Alex","Laskaris"];

//player setvariable ["MARTA_showRules",["BLU_F",-1,"CIV_F",-1,"OPF_F",0,"OPF_G_F",0,"IND_F",0,"IND_G_F",0]];

startloadingscreen ["Pilgrimage","RscDisplayLoadCustom"];
progressLoadingScreen 0;

titleRsc ["PIL_LOGO","BLACK FADED"];

RYD_init_cam cameraEffect ["Terminate", "BACK"];
deleteVehicle RYD_init_cam;

RYD_JR_isBlastcore = "warfxpe" in activatedAddons;
 
call compile preprocessfile "RYD_JR\JR_fnc.sqf";
call compile preprocessFile "Intro\cam_fnc.sqf";
call compile preprocessFile "RYD_JR\MainLoop.sqf";
call compile preprocessFile "RYD_FFE\FFE_fnc.sqf";
Shellview = compile preprocessFile "RYD_FFE\Shellview.sqf";

["RYD_JR_LazyT","onMapSingleClick","RYD_JR_LazyTravel"] call BIS_fnc_addStackedEventHandler;

RYD_AS_Targets = [player];

[[RYD_JR_AI],RYD_AS_Targets,500,360,0,false,0,false,false] execVM "AS\ASInit.sqf";

RYD_JR_AllWeapons = [];
RYD_JR_AllAmmo = [];
RYD_JR_AllItems = [];
//RYD_JR_AllBackpacks = [];
RYD_JR_AllSoftV = [];
RYD_JR_AllArmor = [];
RYD_JR_AllHelis = [];
RYD_JR_BusyHelis = [];
RYD_JR_AllEV = [];
RYD_JR_cached = [];
RYD_JR_allEnemy = [];
RYD_JR_AllInfGroups = [];
RYD_JR_AllMotGroups = [];
RYD_JR_AllMechGroups = [];
RYD_JR_AllArmGroups = [];
RYD_JR_AllGarrisons = [];
RYD_JR_EmptyVehs = [];
RYD_JR_CPGroups = [];
RYD_JR_CPItems = [];
RYD_JR_BBGroups = [];
RYD_JR_Camps = [];
RYD_JR_Boats = [RYD_JR_boat];

RYD_JR_AllInfGroupsI = [];
RYD_JR_AllMotGroupsI = [];
RYD_JR_AllMechGroupsI = [];
RYD_JR_AllArmGroupsI = [];

RYD_JR_AllInfGroupsE = [];
RYD_JR_AllMotGroupsE = [];
RYD_JR_AllMechGroupsE = [];
RYD_JR_AllArmGroupsE = [];

RYD_JR_AllMobileE = [];
RYD_JR_AllMobileI = [];

RYD_JR_AllSpawnedGps = [];
RYD_JR_AllSpawnedAIs = [];
RYD_JR_AllSpawnedVehs = [];
RYD_JR_POW = [];

RYD_JR_LastSpawn = -900;

RYD_JR_Tanks =
	[
	"B_MBT_01_cannon_F",
	"B_MBT_01_TUSK_F",
	"O_MBT_02_cannon_F",
	"I_MBT_03_cannon_F",
	"B_MBT_01_arty_F",
	"O_MBT_02_arty_F",
	"B_MBT_01_mlrs_F"
	];

RYD_JR_BetterLootBuildings = 
	[
	"Land_BagBunker_Large_F",
	"Land_BagBunker_Small_F",
	"Land_BagBunker_Tower_F",
	"Land_Barracks_ruins_F",
	"Land_i_Barracks_V1_F",
	"Land_i_Barracks_V1_dam_F",
	"Land_i_Barracks_V2_F",
	"Land_i_Barracks_V2_dam_F",
	"Land_u_Barracks_V2_F",
	"Land_Bunker_F",
	"Land_Cargo_House_V1_ruins_F",
	"Land_Cargo_House_V1_F",
	"Land_Cargo_House_V2_ruins_F",
	"Land_Cargo_House_V2_F",
	"Land_Cargo_House_V3_ruins_F",
	"Land_Cargo_House_V3_F",
	"Land_Cargo_HQ_V1_ruins_F",
	"Land_Cargo_HQ_V1_F",
	"Land_Cargo_HQ_V2_ruins_F",
	"Land_Cargo_HQ_V2_F",
	"Land_Cargo_HQ_V3_ruins_F",
	"Land_Cargo_HQ_V3_F",
	"Land_Cargo_Patrol_V1_ruins_F",
	"Land_Cargo_Patrol_V1_F",
	"Land_Cargo_Patrol_V2_ruins_F",
	"Land_Cargo_Patrol_V2_F",
	"Land_Cargo_Patrol_V3_ruins_F",
	"Land_Cargo_Patrol_V3_F",
	"Land_Cargo_Tower_V1_ruins_F",
	"Land_Cargo_Tower_V1_F",
	"Land_Cargo_Tower_V1_No1_F",
	"Land_Cargo_Tower_V1_No2_F",
	"Land_Cargo_Tower_V1_No3_F",
	"Land_Cargo_Tower_V1_No4_F",
	"Land_Cargo_Tower_V1_No5_F",
	"Land_Cargo_Tower_V1_No6_F",
	"Land_Cargo_Tower_V1_No7_F",
	"Land_Cargo_Tower_V2_ruins_F",
	"Land_Cargo_Tower_V2_F",
	"Land_Cargo_Tower_V3_ruins_F",
	"Land_Cargo_Tower_V3_F",
	"Land_Medevac_house_V1_ruins_F",
	"Land_Medevac_house_V1_F",
	"Land_Medevac_HQ_V1_ruins_F",
	"Land_Medevac_HQ_V1_F",
	"Land_MilOffices_V1_F",
	"Land_Radar_ruins_F",
	"Land_Radar_F",
	"Land_Radar_Small_ruins_F",
	"Land_Radar_Small_F",
	"Land_Dome_Big_F",
	"Land_Dome_Small_F",
	"Land_Research_house_V1_ruins_F",
	"Land_Research_house_V1_F",
	"Land_Research_HQ_ruins_F",
	"Land_Research_HQ_F",
	"Land_TentHangar_V1_ruins_F",
	"Land_TentHangar_V1_F",
	"Land_TentHangar_V1_dam_F"
	];
	
RYD_JR_Choppers = 
	[
	"O_Heli_Attack_02_F",
	"O_Heli_Attack_02_black_F"
	];
	
RYD_JR_Armored = 
	[
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Wheeled_02_rcws_F",
	"O_APC_Tracked_02_AA_F",
	"O_MBT_02_cannon_F"
	];
	
RYD_JR_Static = 
	[
	"O_HMG_01_high_F",
	"O_GMG_01_high_F",
	"O_static_AT_F"
	];
		
RYD_JR_MCamps = 
	[
	[5410.92,17908.8,0],
	[20961.3,19273.9,0],
	[14206.8,21230.5,0],
	[9956.2,19354.9,0],
	[12283.1,8891.36,0],
	[12476.3,15191.9,0],
	[9568.32,15096,0],
	[20082.6,6730.65,0],
	[8293.6,10078.4,0]
	];

RYD_JR_AirFields = 
	[
	[11501.8,11653.8,0],
	[14769.5,16315.1,0],
	[9127.23,21475.3,0],
	[21117.2,7308.47,0],
	[23154.3,18635,0],
	[26975.8,24697.1,0]
	];
	
RYD_JR_Flares = 
	[
	"F_40mm_Cir",
	"F_40mm_Red",
	"F_40mm_Green",
	"F_40mm_Yellow",
	"F_40mm_White"
	];

switch (RYD_JR_StartingMode) do
	{
	case ("R") :
		{
		RYD_JR_Starting = 
			[
			[[6235.72,22549,0],[6243.98,22562.1,0]],
			[[3034.64,22062,0],[3024.77,22070.9,0]],
			[[2920.62,21468.7,0],[2900.08,21467.9,0]],
			[[2626.81,19750.1,0],[2608.27,19737.3,0]],
			[[9434.76,23154.3,0],[9459.17,23156.4,0]],
			[[14810.6,22855.4,0],[14830.1,22863.9,0]],
			[[19252.2,19230.9,0],[19240,19221.2,0]],
			[[23559.6,23166.2,0],[23548.6,23171.8,0]],
			[[24134.3,17470.1,0],[24155.2,17466.5,0]],
			[[24690.3,23787,0],[24704.1,23794.5,0]],
			[[22154.9,13371.1,0],[22169.3,13351.4,0]],
			[[21386.3,9906.21,0],[21439,9903.39,0]],
			[[18591.8,6133.61,0],[18577.8,6122.62,0]],
			[[12861.3,8034.27,0],[12873.1,8042.39,0]],
			[[4965.07,9525.15,0],[4963.61,9518.36,0]],
			[[2715.67,9816.25,0],[2709.26,9798.89,0]],
			
			[[28329,25187,0],[28347,25187,0]],
			[[15372,22424,0],[15383,22442,0]],
			[[2701,22079,0],[2687,22057,0]],
			[[25704,19497,0],[25718,19483,0]],
			[[15817,11393,0],[15835,11453,0]]
			];		
		};
		
	case ("N") :
		{
		RYD_JR_Starting = 
			[
			[[3034.64,22062,0],[3024.77,22070.9,0]],
			[[6235.72,22549,0],[6243.98,22562.1,0]],
			[[9434.76,23154.3,0],[9459.17,23156.4,0]],
			[[14810.6,22855.4,0],[14830.1,22863.9,0]],
			[[19252.2,19230.9,0],[19240,19221.2,0]],
			[[23559.6,23166.2,0],[23548.6,23171.8,0]],
			[[24690.3,23787,0],[24704.1,23794.5,0]],
			
			[[28329,25187,0],[28347,25187,0]],
			[[15372,22424,0],[15383,22442,0]],
			[[2701,22079,0],[2687,22057,0]]
			];		
		};
		
	case ("E") :
		{
		RYD_JR_Starting = 
			[
			[[24690.3,23787,0],[24704.1,23794.5,0]],
			[[24134.3,17470.1,0],[24155.2,17466.5,0]],
			[[22154.9,13371.1,0],[22169.3,13351.4,0]],
			[[21386.3,9906.21,0],[21439,9903.39,0]],
			[[18591.8,6133.61,0],[18577.8,6122.62,0]],
			
			[[25704,19497,0],[25718,19483,0]]  
			];		
		};
		
	case ("S") :
		{
		RYD_JR_Starting = 
			[
			[[21386.3,9906.21,0],[21439,9903.39,0]],
			[[18591.8,6133.61,0],[18577.8,6122.62,0]],
			[[12861.3,8034.27,0],[12873.1,8042.39,0]],
			[[4965.07,9525.15,0],[4963.61,9518.36,0]],
			[[2715.67,9816.25,0],[2709.26,9798.89,0]],
			
			[[15817,11393,0],[15835,11453,0]]
			];		
		};
		
	case ("W") :
		{
		RYD_JR_Starting = 
			[
			[[3034.64,22062,0],[3024.77,22070.9,0]],
			[[2920.62,21468.7,0],[2900.08,21467.9,0]],
			[[2626.81,19750.1,0],[2608.27,19737.3,0]],
			[[4965.07,9525.15,0],[4963.61,9518.36,0]],
			[[2715.67,9816.25,0],[2709.26,9798.89,0]]
			];		
		};
	};
		
RYD_JR_AllMilGuardGroups = [];

RYD_JR_AllGuardGroups = 
	[
	[east,configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardSentry"],
	[east,configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam"],
	[east,configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardSquad"]
	];
	
RYD_JR_AllLocalGroups = 
	[
	[resistance,configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry"],
	[resistance,configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam"],
	[resistance,configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry"],
	[resistance,configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam"],
	[resistance,configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry"],
	[resistance,configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam"],
	[east,configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconSentry"],
	[east,configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry"],
	[east,configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardSentry"],
	[east,configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam"],
	//[east,configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "SpecOps" >> "OI_ReconTeam_UAV"],
	[east,configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Support" >> "OI_recon_EOD"]
	];
	
RYD_JR_BBGuardGroups = 
	[
	[east,configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad"],
	[east,configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad_Weapons"],
	[east,configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardSquad"]
	];
	
RYD_JR_AllFIAGroups = 
	[
	[west,configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfSentry"],
	[west,configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfSquad"],
	[west,configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfSquad_Weapons"],
	[west,configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfTeam"],
	[west,configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfTeam_AT"],
	[west,configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_ReconSentry"],
	[west,configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_SniperTeam_M"],
	[west,configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Motorized_MTP" >> "IRG_MotInf_Team"],
	[west,configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Motorized_MTP" >> "IRG_Technicals"]
	];
	
RYD_JR_AlexCompromised = 
	[
	"Should we engage?",
	"What are our orders?",
	"We'll handle this.",
	"We'll take care of that bastard.",
	"Commence attack.",
	"Code RED.",
	"Kill the fucker.",
	"Neutralize the threat."
	];
	
RYD_JR_CalmChat = 
	[
	"Nothing unusual. It's calm here.",
	"No contacts so far.",
	"Just another boring place. Nothing is going on.",
	"No hostiles in the area.",
	"We're bored as hell.",
	"Nothing new. We continue.",
	"No suspicious activity over here.",
	"What we're doing here, again? Nothing to report."
	];
		
RYD_JR_Conversations = 
	[
/////
	[
	[
	"Lucas Laskaris: Alex? Uncle Lucas here.",
	"Is it true about Philip? I can't believe it.", 
	"Where are you? Mother despairs.",
	["She cries and curses my brother the whole day."],
	"Alex: Yes, uncle. Try to calm her down for now.",
	["I think Phil found, what dad hid. And it killed him."],
	"Lucas Laskaris: You should be there to calm her down.",
	["Wait, what do you mean, he found it? It's active? God!"],
	"Alex: Exactly.",
	"Thought, mom doesn't know yet. You know, she won't speak to me.",
	"I'm trying to find Philip's body. I was close when it happened. Just a few hours.",
	["Wanted to do it before I tell her."],
	"Lucas Laskaris: She knows. Phil had sent her a message just before.",
	"We're all shocked.",
	"And Tyrone is looking for you.",
	"And now you're saying, you also went there? Do you want to die too?",
	"Now listen to me carefully:",
	"My brother had a good reason to hide what he'd invented from the military.",
	"He was frightened, when we spoke back then. He hadn't thought clearly when he hid this.",
	["After that, when he decided to destroy it... The rest you know. He fell before he got any chance to go back..."],
	"Alex: Yes, uncle, I know most of this. Phil knew too. That's why he did it.",
	"He wanted to finish what father couldn't. I argued with him, Mom too, but he was determined.",
	"He had as good reason to act, as father did. And I have now.",
	["I've no intention to mess with the machine. Only to find the remains of my brother."],
	"Lucas Laskaris: I think the same, as Pene though about Phil's quest, you're stupid going there when...",
	["You're unable to stop this, you can only die, as your brother did. Think about your mother."],
	"Alex: I disagree it's our duty to stop this cursed invention, and my duty to bring Phil home for a proper burial.",
	"And I'm able to do so.",
	"I've no time to argue. I mourn my brother, but I must act.",
	"Take care of my mother until I return. Don't tell her, what I'm doing.",
	"Bye."
	],
	true,
	"Lucas Laskaris"
	],
/////
	[
	[
	"Tyrone: Hi. My condolences. I have the analysis and list of coordinates, you ordered.",
	"I don't like to throw such data in the air like that, but you were obviously in a hurry and I missed you at home.",
	["Should I send it now, despite the risk?"],
	["Alex: Thanks. Yes, just send it. Payment as usual?"],
	"Tyrone: Sure. Sending. Be careful out there. This sounds... Well, read it. Cheers.",
	"Attachment #1: Platform - UGV, probably Stomper RCWS model;",
	"Combat reaction distance - about 600 meters;",
	"Sensors range/pursuit range - approx. 1000 meters;",
	"Weaponry - .50 cal, approx. 1000 rounds, possibly GMG 40mm, 200 rounds;",
	"Autonomy - decisive: full, executive: full. No external control;",
	"AI algorithm: unknown;",
	"Expected behaviour: restless engaging closest human or active vehicle target inside reaction range until eliminated or beyond sensors range;",
	"Counteracting suggestions: 1. ATGM or calibre >=.50 with AP rounds from unmanned platform or armoured vehicle located beyond sensors range;",
	"2. EMP impulse;",
	"Notes: keep obstructed LOS when inside engagement radius;",
	"END OF Attachment #1",
	"Attachment #2: Possible locations of strongholds on Altis (medium reliability):",
	"5403,17923",
	"20911,19250",
	"14210,21231",
	"9958,19332",
	"12276,8909",
	"12399,15191",
	"9525,15097",
	"20076,6740",
	"8284,10063",
	"END OF Attachment #2"
	],
	false,
	"Tyrone"
	],
/////
	[
	[
	["Cassie: Yo Alex. I heard you went somewhere? Something about Phil? You remember - dinner tonight, right?"],
	["Alex: Yo. I'm afraid, I can't be there this time. I'm not at home, at least until tomorrow. Could we meet another day?"],
	"Cassie: Alex, you... I hope, this time you have a better reason to leave me like that, like you have lately.",
	["I don't want to speak to you."],
	"Alex: Cassie?"
	],
	false,
	"Cassie"
	],
/////
	[
	[
	["Unknown number: You owe me a lot of money. Where's my fuckin' money??"],
	"Alex: Fuck you!"
	],
	true,
	"Unknown number"
	],
/////	
	[
	[
	"Unknown number: YES! FINALLY! YOU WIN!!! Call immediately on the number below and choose your..."
	],
	true,
	"Unknown number"
	],
//////	
	[
	[
	["Yorre: I've got a big job lined up, so I'm putting a team together. It pays a lot of money. You in?"],
	["Alex: When and where?"],
	["Yorre: Next week, details later."],
	["Alex: OK. Sign me up."],
	"Yorre: Splendid. I'll be in touch!"
	],
	true,
	"Yorre"
	]
//////	
	];
		
RYD_JR_Interrupts = 
	[
	"Alex: Oh, sorry, I've got to go.",
	"Alex: Wait, I'll call back.",
	"Alex: Hold on.",
	"Alex: No time to talk right now."
	];
	
RYD_JR_CInitTalkOff = 
	[
	"Alex: Hello?",
	"Alex: Yes?",
	"Alex: Alex here, I'm listening."
	];

RYD_JR_CInitTalk = 
	[	
	"Alex: Yeah?",
	"Alex: What's up?"
	];
	
RYD_JR_Complaints = 
	[
	"Damn! Not now!",
	"Shit.",
	"Fuck, there wasn't a worse moment!",
	"Be silent you piece of shit."
	];

RYD_JR_KillShouts = 
	[
	"Rest In Pieces!",
	"Eat this!",
	"Neeext!",
	"Nice.",
	"Checked off...",
	"One less.",
	"Just die.",
	"Here you go.",
	"Memento mori.",
	"For my brother, you bastard!",
	"Clean death. Well, not so clean maybe.",
	"This will teach them respect.",
	"See you in hell.",
	"What are you waitin' for? Christmas?",
	"I'm gonna get medieval on your asses!",
	"Say hello to my little friend!",
	"So... who wants to dance?",
	"Mess with the best, you will die like the rest",
	"Life is like a box of ammo.",
	"Hakuna matata, mother fucker.",
	"I got news for you...bullet news"
	];
	
RYD_JR_Chatting = 
	[
	"Can we stop for a moment? Something fell into my shoe.",	
	"And this joke? Woman comes to a doc... OK, I guess you've heard this one.",	
	"Eh. This old wound again gives me a hard time.",	
	"I'd better eat something.",	
	"Damn, not many people on this island!",	
	"That would be a great place for a holiday.",	
	"Could you stop whistling, please? Thank you.",	
	"Nice weather, isn't it?",	
	"I'm sick of all this.",	
	"I have to clean my weapon. At the next stop.",	
	"Could use some action, huh? Well, true. Not necessarily.",	
	"And what if... Uh, nothing.",	
	"Screwed country indeed.",	
	"I tell you, I almost blew his head off. Shame, you had to see it. Two hundred meters. At least!",	
	"If only I ruled here ... Hmm. Maybe, better not.",	
	"Hey, now that's a big ant. Ouch! You little shit!",	
	"Easy to get lost here.",	
	"What rhymes with 'abattoir'?",	
	"Space does not exist. Seriously. The cosmos is a hoax.",	
	"Fuckin' weather. Fuckin' insects. Fuckin' country.",	
	"... and you know I'll never forget that look ...",	
	"Death from perspiration. How it sounds?",	
	"Got a cigarette?",	
	"Frankly, I don't know what to think about all this.",	
	"I wonder what's the name of that tree?",	
	"Tell me, what the hell am I doing here, instead of sitting at home watching TV with a cold beer in my hand, huh?",	
	"Never again Greece.",	
	"And I actually like to kill.",	
	"I wonder, if this is edible.",	
	"I know! There is a solution! A nuclear bomb!",	
	"Beer. Cold beer with foam. Or two. Altis for two beers.",	
	"If I survive, I'll write a haiku about all this.",
	"What epitaph would you like to have engraved on your tomb?",
	"So... It wasn't a joke? Really we do all this because of some damned, rotting corpse, not for all this loot and money?",
	"Rough winds do shake the darling buds of May...",
	"True is it that we have seen better days.",
	"The devil can cite Scripture for his purpose.",
	"The miserable have no other medicine but only hope.",
	"A man can die but once.",
	"The first thing we do, let's kill all the lawyers.",
	"Is this a dagger which I see before me, The handle toward my hand?",
	"Of all creatures that breathe and move upon the earth, nothing is bred that is weaker than man.",
	"Everything is more beautiful because we're doomed.",
	"Even a fool learns something once it hits him.",
	"A man who has been through bitter experiences and travelled far enjoys even his sufferings after a time.",
	"The difficulty is not so great to die for a friend as to find a friend worth dying for.",
	"Life is largely a matter of expectation.",
	"We men are wretched things.",
	"--crooning softly--",		
	"In my opinion... Bah! Who cares about my opinion?",	
	"And if there would be a kindergarten, in the future?",	
	"Everyone thinks only about himself and only I think about me.",	
	"There are two kinds of people. Me and the others.",	
	"This time we have a plan, or we'll improvise, as usual?",	
	"Sometimes I feel like a character from a computer game. And you?",	
	"No comment.",	
	"I'll be surprised if I get out of this place alive."	
	];
			
RYD_JR_Chatting0 = +RYD_JR_Chatting;

RYD_JR_ChattingNewVeh = 
	[
	"New vehicle? Cool.",
	"So, you really needed a new toy, huh?",
	"Yeah, nice. But I preffer more shiny. Gold mettalic perhaps?",
	"Next time I'll choose our new limo...",
	"Well, let's hope this junk will not fall apart too soon.",
	"Seriously? Now we'll drive this thing?",
	"Better this, than on foot, I suppose.",
	"So... I hope, it's comfy at least.",
	"What I think about this vehicle? Well. It's for free at least.",
	"OK. Now let's get out of here before owner will come back.",
	"Decent find, I would say.",
	"I have that GTA feeling.",
	"Interesting, how easily they abandoned this vehicle, isn't?",
	"Well, I hope this vehicle will be more useful than exposing.",
	"Christmas time!",
	"Indeed... How we name this new conveyance?"
	];
	
RYD_JR_ChattingNewVeh0 = +RYD_JR_ChattingNewVeh;

RYD_JR_ChattingGoodRep = 
	[
	"Yeah, at least some should like us a bit more now.",
	"Be carefull, if we'll continue like this, locals will proclaim us damn heroes. Or worse.",
	"Somehow I prefer, when we're acting like this.",
	"Yeah. We rock.",
	"Good one!",
	"Perfect.",
	"Refreshing. We should do this more often.",
	"Business with pleasure.",
	"Good.",
	"Very well.",
	"Not bad.",
	"I like that.",
	"Are we after some medals or something here?",
	"I love the smell of whatever it is in... current daypart.",
	"That certainly would be good for our karma.",
	"Those unique moments...",
	"Nicely done."
	];

RYD_JR_ChattingGoodRep0 = +RYD_JR_ChattingGoodRep;

RYD_JR_ChattingGroupGone = 
	[
	"It's %1. %2 guarding %3 is not responding. Over.",
	"%1 reporting. %2 guarding %3 is not responding. Over.",
	"%1 here. %2 guarding %3 is not responding. Over.",
	"%1 reporting. We've lost contact with %2 in the %3 area. Over.",
	"It's %1. We've lost contact with %2 in the %3 area. Over.",
	"%1 here. We've lost contact with %2 in the %3 area. Over.",
	"%1 here. Something wrong happened near %3 - there's no contact with %2. Over.",
	"%1 reporting. Something wrong happened near %3 - there's no contact with %2. Over.",
	"It's %1. Something wrong happened near %3 - there's no contact with %2. Over.",
	"It's %1. %3 is not responding. Over.",
	"%1 reporting. %3 is not responding. Over.",
	"%1 here. %3 is not responding. Over.",
	"It's %1. %2 is not responding. Over.",
	"%1 reporting. %2 is not responding. Over.",
	"%1 here. %2 is not responding. Over."
	];

RYD_JR_ChattingBadRep = 
	[
	"What have we done?",
	"Oops!",
	"Now, that wasn't nice.",
	"I don't like this.",
	"Are we bad people, or just erring?",
	"Oh, no!",
	"Shame on us.",
	"So sad.",
	"Did we just passed to the dark side of the Force?",
	"Something, I would like to forget...",
	"Accidental or intentional?",
	"Should we really act like this?",
	"Fuck.",
	"Damn.",
	"Shit happens.",
	"That sucks.",
	"Being an evildoer is not cool at all.",
	"Did we just killed him? I can't believe.",
	"I hate all this collateral damage shit.",
	"Not good",
	"No, no, no! I don't believe this!"
	];

RYD_JR_ChattingBadRep0 = +RYD_JR_ChattingBadRep;

RYD_JR_Chatting_City_LowRep = 
	[
	"Seems, we aren't very popular here. I'm wondering, why is that...",
	"It's only me, or people of %1 don't trust us very much? They have no reason to trust, I guess.",
	"Damn, I really don't like the way he looked at me.",
	"Obviously he heard about us, and that wasn't anything good.",
	"I think, we should leave this town ASAP. The locals evidently are of the same opinion.",
	"Seems, we aren't very popular in %1. Perhaps we shouldn't stay here too long?"
	];
	
RYD_JR_Chatting_City = 
	[
	"Nice town, I would say.",
	"I wonder, what the locals actually think about us. Probably nothing.",
	"That house seemed pretty damaged. Usual view on Altis recently, I'm affraid.",
	"%1 seems to be a good choice for holiday.",
	"Shit, look at their faces. Fear, desperation... Stigma of war.",
	"Hm, %1 looks like a nice town to live. Once, at least..."
	];
	
RYD_JR_Chatting_City_HiRep = 
	[
	"Now I know what it's like to be famous. Pleasant feeling.",
	"If I'm not mistaken, we are truly welcome in %1.",
	"Apparently locals like us. Well, they should, I think.",
	"Looks, like for people of %1 you are someone in kind of Robin Hood.",
	"Man, you saw this? They seem treat us like some saviors.",
	"Here, in %1, I'm feeling nearly like a hero or something."
	];

RYD_JR_CivilComment_Enthusiastic = 
	[
	"That's him? Wow!",
	"You're my idol!",
	"It's so great, you visited our town",
	"Stay with us, please",
	"That's him! Alex the Great!",
	"Could I name my son after you?",
	"You're our hope",
	"Godspeed!",
	"Can I get your autograph?",
	"Give them hell, Alex!",
	"Greetings!",
	"Welcome to our town!",
	"New sheriff in town",
	"I thought, he is taller. And wider",
	"That's Alex, the brave punisher of hundreds!",
	"Did you found your brother?",
	"I'm so happy, I saw him",
	"That's Alex! Now everything will be fine",
	"Do you marry one of my daughters? Or both?",
	"Salute!",
	"Our savior!",
	"You're a true hero!",
	"Go! Go! Go Alex for the win!",
	"I named my fish after you"
	];

RYD_JR_CivilComment_Positive = 
	[
	"Nice to meet you",
	"Good day",
	"I heard good things about you",
	"Will you help us?",
	"Good job out there",
	"Keep up the good work",
	"Someone told me, you're OK",
	"Good luck",
	"Are you that Alex looking for someone?",
	"I think, it's him",
	"Good to see you",
	"So rumors was true",
	"Now maybe something will change?",
	"Cheers",
	"Yes, it's probably that guy",
	"How are you?",
	"I like, what you are doing",
	"Have I nice day"
	];

RYD_JR_CivilComment_Neutral = 
	[
	"Strange weather, eh?",
	"Who are you?",
	"What are you doing here, stranger?",
	"It's not safe for tourists",
	"Hard times",
	"Damn soldiers, they killed my last sheep",
	"Another patrol?",
	"We don't trust strangers",
	"He is armed!",
	"More mercs?",
	"Whose side you fighting for?",
	"Another hopeless day of hopeless war",
	"They killed my son",
	"How much longer?",
	"Yes, but... where all women gone?",
	"A visitor? Interesting.",
	"Memento mori",
	"I feel, like I was under control of some force. And you?",
	"This damn war will never end",
	"What do you want?",
	"Leave me alone",
	"End of the world? The sooner, the better",
	"Hm",
	"Khem!",
	"What?",
	"Whatever",
	"What's time is it?",
	"Nothing better to do?",
	"Do I know you?",
	"Who cares",
	"Where's my phone?",
	"I have to buy something to eat",
	"I'm so tired of all this",
	"I should leave Altis. But how and where to go?",
	"They kidnapped someone again. I may be next",
	"They don't like armed civilians",
	"I really don't care, who you are",
	"What's the point?",
	"What is it?",
	"We all die soon",
	"So what?",
	"Nevermind",
	"I should go back home",
	"Life's too short to waste it",
	"I have to drink some beer",
	"CSAT, AAF, mercs, whatever. Bandits",
	"Any chance for coop?",
	"Where are my saves?",
	"I need more boxes"
	];
	
RYD_JR_CivilComment_Negative = 
	[
	"Troublemaker",
	"Go away",
	"You shouldn't stay here, mister",
	"You're not welcome here",
	"We don't need any troubles",
	"Leave us alone",
	"So, you're that Alex? Shame on you",
	"Stay away",
	"Just leave me alone",
	"That's him? Asshole",
	"I don't fear you",
	"Another thug for hire",
	"Damn",
	"I'd better go",
	"You have blood on your hands",
	"We don't want you here"
	];
	
RYD_JR_CivilComment_Hateful = 
	[
	"Bastard!",
	"Get lost!",
	"That's him! Run!",
	"Don't kill us, please!",
	"Murderer!",
	"Disgrace",
	"Fuck you!",
	"Help!",
	"No! That's him!",
	"Alex the Black Death is here!",
	"Murderous son of a bitch",
	"I despise people like you",
	"He is here! Somebody, help me!",
	"Not you!",
	"Run for your life! That's him!",
	"Mercy!",
	"I would gladly kill you",
	"Oh, no!"
	];
	
RYD_JR_Commenting = [];

_modClass = configFile >> "CfgMods";
_vehClass = configFile >> "CfgVehicles";
_weapClass = configFile >> "CfgWeapons";
_ammoClass = configFile >> "CfgMagazines";
_musicClass = configFile >> "CfgMusic";

_softVAm = 30 + (floor (random 20));
_armVAm = ((3 + (floor (random 2)) - RYD_JR_Difficulty) max 0) min 3;

_mapDefPos = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
_mapSize = getNumber (configFile >> "CfgWorlds" >> worldName >> "mapSize");

_rds = _mapSize/2;
_mapC = [_rds,_rds];

RYD_JR_mapSize = _mapSize * 1.4;

_roadS = objNull;

RYD_JR_Treasures = [];
RYD_JR_TreasureLoot = 
	[
	[
		["arifle_Katiba_GL_F",(floor (random 4)) min 2],
		["arifle_MX_GL_F",(floor (random 4)) min 2],
		["arifle_MXM_F",(floor (random 3)) min 1],
		["arifle_TRG21_GL_F",(floor (random 4)) min 2],
		["launch_O_Titan_F",(floor (random 2)) min 1],
		["launch_O_Titan_short_F",(floor (random 2)) min 1],
		["launch_RPG32_F",(floor (random 2.5)) min 1],
		["launch_NLAW_F",(floor (random 2.5)) min 1],
		["LMG_Zafir_F",(floor (random 2.5)) min 2],
		["srifle_DMR_01_F",(floor (random 2.5)) min 2],
		["srifle_EBR_F",(floor (random 2.5)) min 1],
		["srifle_GM6_F",(floor (random 2)) min 1],
		["srifle_LRR_F",(floor (random 2)) min 1]
	],
		
	[
		["10Rnd_762x51_Mag",(floor (random 13))],
		["1Rnd_HE_Grenade_shell",(floor (random 25))],
		["150Rnd_762x51_Box",(floor (random 13))],
		["30Rnd_556x45_Stanag",(floor (random 25))],
		["30Rnd_65x39_caseless_green",(floor (random 25))],
		["5Rnd_127x108_APDS_Mag",(floor (random 13))],
		["5Rnd_127x108_Mag",(floor (random 13))],
		["7Rnd_408_Mag",(floor (random 13))],
		["30Rnd_65x39_caseless_mag",(floor (random 25))],
		["APERSBoundingMine_Range_Mag",(floor (random 13))],
		["APERSMine_Range_Mag",(floor (random 13))],
		["APERSTripMine_Wire_Mag",(floor (random 13))],
		["ATMine_Range_Mag",(floor (random 7))],
		["ClaymoreDirectionalMine_Remote_Mag",(floor (random 7))],
		["DemoCharge_Remote_Mag",(floor (random 13))],
		["NLAW_F",(floor (random 5))],
		["RPG32_F",(floor (random 5))],
		["RPG32_HE_F",(floor (random 5))],
		["SatchelCharge_Remote_Mag",(floor (random 5))],
		["SLAMDirectionalMine_Wire_Mag",(floor (random 5))],
		["Titan_AA",(floor (random 5))],
		["Titan_AP",(floor (random 5))],
		["Titan_AT",(floor (random 5))]
	],
	
	[
		["B_UavTerminal",(floor (random 1.1))],
		["I_UavTerminal",(floor (random 7)) min 4],
		["O_UavTerminal",(floor (random 7)) min 4],
		["Binocular",(floor (random 15)) min 10],
		["ItemMap",(floor (random 15)) min 10],
		["ItemRadio",(floor (random 15)) min 10],
		["ItemGPS",(floor (random 15)) min 10],
		["Laserdesignator",(floor (random 2)) min 1],
		["Medikit",(floor (random 3)) min 1],
		["MineDetector",(floor (random 3)) min 1],
		["NVGoggles_OPFOR",(floor (random 3)) min 1],
		["optic_Arco",(floor (random 7)) min 4],
		["optic_DMS",(floor (random 4)) min 2],
		["optic_Hamr",(floor (random 4)) min 2],
		["optic_LRPS",(floor (random 3)) min 1],
		["optic_Nightstalker",(floor (random 1.5)) min 1],
		["optic_NVS",(floor (random 2)) min 1],
		["optic_SOS",(floor (random 3)) min 1],
		["optic_tws",(floor (random 2)) min 1],
		["optic_tws_mg",(floor (random 2)) min 1],
		["Rangefinder",(floor (random 4)) min 2],
		["ToolKit",(floor (random 3)) min 1],
		["U_B_GhillieSuit",(floor (random 4)) min 2],
		["muzzle_snds_acp",(floor (random 5)) min 1],
		["muzzle_snds_B",(floor (random 5)) min 1],
		["muzzle_snds_H",(floor (random 5)) min 1],
		["muzzle_snds_H_MG",(floor (random 5)) min 1],
		["muzzle_snds_H_SW",(floor (random 5)) min 1],
		["muzzle_snds_L",(floor (random 5)) min 1],
		["muzzle_snds_M",(floor (random 5)) min 1]
	]
	];
	
RYD_JR_allCities = nearestLocations [_mapC, ["NameCityCapital","NameCity"],_rds * 1.42];
RYD_JR_allVillages = nearestLocations [_mapC, ["NameVillage"],_rds * 1.42];
RYD_JR_allLocal = nearestLocations [_mapC, ["NameLocal","Hill"],_rds * 1.42];

	{
	if ((tolower (text _x)) in ["sagonisi"]) exitWith {RYD_JR_allVillages set [_foreachIndex, 0]}
	}
foreach RYD_JR_allVillages;

RYD_JR_allVillages = RYD_JR_allVillages - [0];

	{
	if ((tolower (text _x)) in ["atsalis","fournos","monisi","savri","pyrgi"]) then {RYD_JR_allLocal set [_foreachIndex, 0]}
	}
foreach RYD_JR_allLocal;

RYD_JR_allLocal = RYD_JR_allLocal - [0];

RYD_JR_allHolyPlaces = 
	[
	[2932.84,17903.4,0.289673],
	[3007.58,12517.2,0.120321],
	[3122.04,22057.8,0.211172],
	[3285.79,13170.3,0.234678],
	[3411.76,14140.9,0.181026],
	[3589.74,10686.8,-0.0101852],
	[3631.35,12944.5,0.2403],
	[3645.99,13318.9,0.000481606],
	[3651.23,13326.3,-0.010632],
	[3645.12,13332.8,-0.000870228],
	[3682.89,12780.4,0.169868],
	[3885.97,12002.4,0.161831],
	[3896.87,12011.9,-0.0145569],
	[3876.24,15449.7,0.116955],
	[3943.11,10395.3,0.443188],
	[3950.95,13854,1.09252],
	[3944.02,13848.1,3.8147e-006],
	[3969.52,12641.8,-0.0610714],
	[4112.15,11349.5,0.139053],
	[4162.14,11822.8,-0.177326],
	[4151.7,11828.4,0.459095],
	[4146.48,16944.6,0.102468],
	[4257.46,15796.6,0.487251],
	[4337.34,11891.5,0.0215225],
	[4550.26,21492.1,-0.000732422],
	[4556.37,21499,-3.05176e-005],
	[4614.23,15380.3,0.0676727],
	[4746.79,16188.3,0.121437],
	[4780.72,13674,-0.0142937],
	[5046.43,11232.4,-0.118855],
	[5193.23,10937.3,0.0090065],
	[5287.64,16159.1,-0.0750504],
	[5368.92,10887.8,0.211445],
	[5549.21,12581.9,0.0378418],
	[5883.31,16043.9,0.276287],
	[6035.81,15482.1,-0.0214863],
	[6294.97,14603.8,0.285778],
	[6390.19,12091.2,0.460876],
	[7169.58,16377.9,0.663437],
	[7148.4,17115.3,0.21254],
	[7630.02,11208.1,-0.124109],
	[7857.56,18017.6,0.216599],
	[7886.58,14646.4,0.0371704],
	[7962.23,21305.7,-0.0171967],
	[8129.47,17290.4,-0.0324707],
	[8534.28,7326.77,0.204712],
	[8637.71,18357.2,2.37553],
	[8636.85,18369.9,2.14178],
	[8638.93,19245.3,0.106094],
	[8642.73,18363.9,-0.0605469],
	[8801.05,13351.4,0.0758209],
	[8924.83,7493.42,0.653412],
	[8941.1,11861.5,-0.0062027],
	[9141.86,17446.1,0.0625534],
	[9173.94,12015,0.076025],
	[9168.25,12021.6,-0.0723133],
	[9168.29,12008.3,-0.0480385],
	[9296.33,21316.1,-0.00548172],
	[9306.65,13449.3,0.255629],
	[9339.31,20834.1,0.0603294],
	[9403.7,20223.9,0.149139],
	[9451.2,23116.8,0.230508],
	[9496.41,15903,0.112198],
	[9525.69,20331.4,0.0863495],
	[9669.75,15852.5,0.232956],
	[10019.1,12847.5,-0.00269699],
	[10038.9,21322,0.0357666],
	[10070.5,11350.2,0.163279],
	[10053.7,19727.4,0.00840759],
	[10302.9,19164.8,0.659988],
	[10297.2,19157.9,2.35268],
	[10353.4,15214.1,0.110588],
	[10460.5,17206.8,0.0833359],
	[10650.3,12310.7,0.220881],
	[10949.6,16876.5,-0.0535545],
	[10954.8,12025.6,0.0805016],
	[10975.1,13611.3,0.288567],
	[10970.4,13604.1,2.50456],
	[11542.7,20814.6,0.138519],
	[11645.2,21534.1,0.0444679],
	[11841.3,20825.2,0.00566101],
	[12147.7,15728.7,0.0458298],
	[12383.4,14598.3,0.261679],
	[12388.4,14606.1,0.598581],
	[12379.7,15643.7,0.164091],
	[12665,17180.5,0.00572014],
	[12693.6,14244,0.977263],
	[12699,14251,0.288513],
	[12775.3,15175.1,0.0800171],
	[12841.7,14826.5,0.0864849],
	[12841.4,19617.5,-0.0123901],
	[13007.4,15088.9,0.225765],
	[13003.7,15077.4,1.11741],
	[13002.9,15260,-0.0188599],
	[13336.7,20173.1,0.016716],
	[13861.2,13431.4,0.242588],
	[13909.3,20874.2,0.0313835],
	[14059.7,18636.8,0.0679359],
	[14332.9,21825.9,0.0181351],
	[14416.1,19293.3,0.148056],
	[14436.3,18685.4,0.031208],
	[14430.2,20282.3,0.00687408],
	[14595.7,17665.5,0.0599594],
	[14603.1,20778.5,0.43819],
	[14613.1,20773.7,-0.000278473],
	[14755.6,20866.6,0.0239525],
	[14828,17585.6,0.00661659],
	[15031.1,22760.9,-0.0402555],
	[15172.2,20913.9,0.0436516],
	[15525.4,21645.8,-0.0584335],
	[15566.9,11414.6,-0.0278661],
	[15564,20496.8,-0.0071907],
	[15954.7,16204.6,-0.0448856],
	[16031.4,21271.4,0.208097],
	[16112.5,17394.9,0.0137634],
	[16113.7,17384.7,0.518614],
	[16374.4,10096.8,0.0107613],
	[16541,17182.2,-0.113167],
	[16668.3,16123.2,0.0932083],
	[16707.4,20467.3,0.0130749],
	[16695.8,21230.6,0.132947],
	[16769.8,21913.4,0.296165],
	[16827.2,12663.9,-0.000314713],
	[16871.6,16198.5,0.0486717],
	[17193,11756.5,0.0730057],
	[17272.2,10070.4,0.422783],
	[17325.9,12596.2,-0.00180054],
	[17450.8,18881,0.04951],
	[17464.2,14334.8,0.0140786],
	[17624.7,10508.9,0.245543],
	[17730.1,14995,0.197748],
	[17744.8,15156.2,0.0431671],
	[17885.7,10704.9,0.0252609],
	[17897.5,15044.1,-0.00409698],
	[17948.6,15198,-0.0436802],
	[17948.2,18197.1,-0.0658607],
	[17991.1,17665.3,-0.00038147],
	[17998,17672.2,-0.0369434],
	[18130.4,15174.9,0.029417],
	[18210.9,13822.9,-0.0522003],
	[18262.9,16384.6,-0.00933075],
	[18288.8,7770.28,-0.0547581],
	[18342.6,14802.5,-0.0116138],
	[18509.9,12141.4,0.00492859],
	[18520.4,6247.44,-0.0296946],
	[18608.8,6751.13,0.0148258],
	[18790.7,12759.2,0.0815964],
	[18791.8,16189.9,0.0360069],
	[18801.9,16762.9,0.0191078],
	[18868.8,16664.2,-0.668575],
	[18869.8,16650.4,0.000265121],
	[18877.3,16658.1,0.411247],
	[18872.5,16851,0.0741196],
	[19298.1,13015.4,0.00984955],
	[19349.5,11327,0.166451],
	[19331,13309,0.197582],
	[19377.1,17619.9,0.0709915],
	[19452.3,13160.1,-0.00322723],
	[19445.8,13164.9,-0.00165558],
	[19502.6,12103.8,0.262421],
	[19509.1,18965.4,-0.0630283],
	[19796.4,6105.67,0.0148926],
	[19784,18614.9,0.196306],
	[20000.5,14883,0.05443],
	[20094.1,16994.8,0.261391],
	[20093,19294.5,0.0726795],
	//[20228.4,11620.7,2.63774],
	[20252.7,11544.4,0.0798721],
	[20323.7,18660.1,0.152325],
	[20320.2,18668.9,0.000217438],
	[20375.7,11707,0.0179482],
	[20539.3,13569.9,0.0849724],
	[20520.7,14096.4,-0.000160217],
	[20615.2,15541.1,0.0330801],
	[20641.4,17235.9,0.0466995],
	[20676.9,8866.05,0.0999451],
	[20721.7,6587.23,0.114323],
	[20785.6,18455.4,-0.0112743],
	[20886.3,16887.7,-0.443897],
	[20891,16894.6,0.814461],
	[20886.3,16901.6,-1.37059],
	[21062.6,16876.3,0.0713577],
	[21162.8,12999.3,0.00884628],
	[21216,8816.29,0.408222],
	[21224.5,17523.4,-0.00344467],
	[21322.7,10550.1,-0.0134554],
	[21354.2,16406,0.0687466],
	[21356.2,16394.5,0.000595093],
	[21366.3,17757.2,0.0762405],
	[21405.8,9351.16,0.0451794],
	[21522.2,17207.5,-0.0288582],
	[21559.6,15434.3,-0.0582533],
	[21555.5,18358.5,-0.0350018],
	[21598.8,8605.83,0.163683],
	[21616.1,13252.2,0.0382099],
	[21669.2,7563.43,0.258793],
	[21725.8,14087,-0.00772572],
	[21775.1,7431.67,-0.0387173],
	[21842,21387.2,0.0243187],
	[21887.4,19376,0.0194263],
	[21986.3,15418.2,-0.0014286],
	[21964.5,19008.7,0.0138273],
	[22019.4,8634.44,-0.00969315],
	[22159.5,7936.74,0.00516605],
	[22255.8,19384.5,0.00361252],
	[22294.7,5092.48,-0.00470495],
	[22421.6,21918,0.0456581],
	[22447.6,15466.3,0.0403237],
	[22502.1,17011.4,-0.048336],
	[22611.1,19825.4,0.0657005],
	[22697.7,13734.3,0.0226588],
	[22720.2,6905.9,0.014226],
	[23197.8,19984.5,-0.00358009],
	[23213.3,21859,0.156393],
	[23352.1,24179.9,0.0231972],
	[23416.3,20593.1,0.0815163],
	[23853.7,20306.2,0.232527],
	[23943.3,20192.6,0.0232878],
	[23984.4,15443.9,0.211081],
	[24215.4,22631.7,0.018486],
	[24381.2,21009.2,-0.0782509],
	[24604.4,21179.9,0.0142231],
	[24773.9,20584.4,0.0183411],
	[24857.1,19190.5,0.165363],
	[25144.3,20890.7,0.276958],
	[25280.9,21962.8,0.00572586],
	[25436.1,19313.1,0.0195484],
	[25637.1,21432,-0.0355434],
	[25658.2,22874.3,0.183001],
	[25694.6,21316,0.0149708],
	[25690.4,21309,-1.71661e-005],
	[25787.3,21097.6,-0.0397511],
	[25997.3,23470.5,0.157156],
	[26030.6,19722.7,0.0220609],
	[26118.4,21795.7,0.0190964],
	[26200.7,24179,0.0411978],
	[26766.5,21350.9,0.00682545],
	[26906.8,21739.3,-0.0259628],
	[26995.9,23272,0.0319538],
	[26990.2,23264.9,0.000143051],
	[27045.9,24190.7,-0.0105839],
	[27120.7,21376.4,0.0159855],
	[27185.6,23227.5,0.0205097],
	[27774.9,23477.9,-0.0130434],
	[28067.3,23760.2,0.0990453],
	[28065.5,25202.8,0.00699615]
	];
	
RYD_JR_AllCheckpoints =
	[
	[3499.76,11886.2,0],
	[4215.4,13642.7,0],
	[4289.03,16600.7,0],
	[4444.84,20811.8,0],
	[4598.01,17178.2,0],
	[4674.06,20590.6,0],
	[4652.78,20640.2,0],
	[4745.67,20529,0],
	[4800.88,14679.4,0],
	[4859.62,10362.2,0],
	[4889.78,16959.4,0],
	[5016.99,13692.2,0],
	[5198.47,20364.5,0],
	[5521.88,10911.7,0],
	[6091.92,15599.8,0],
	[6257.06,22068,0],
	[6297.17,15526.4,0],
	[6473.92,19758.9,0],
	[6542.3,19676,0],
	[6936.8,18888.2,0],
	[7023.1,18981.3,0],
	[7177.8,18087.1,0],
	[7613.57,14388,0],
	[8284.91,15817.5,0],
	[8419.16,15753.5,0],
	[8406.89,20815.9,0],
	[8639.11,11463.8,0],
	[8896.06,14728.8,0],
	[8900.88,14730.6,0],
	[8914.16,12567,0],
	[8919.55,12613.1,0],
	[8945.19,11368.5,0],
	[9327.17,13435.1,0],
	[9317.57,13472.3,0],
	[9330.53,21547,0],
	[9337.75,21571.4,0],
	[9437.54,11248,0],
	[9501.33,15474.3,0],
	[9510.52,15463.2,0],
	[9514.25,15466.5,0],
	[9558,15016.3,0],
	[9741.05,11668,0],
	[9745.88,19928.1,0],
	[9798.87,11615.7,0],
	[9852.27,18574.7,0],
	[9886.42,9706.17,0],
	[9946.66,11556.2,0],
	[9940.83,12758.2,0],
	[9970.84,11587.4,0],
	[10017.4,12017.3,0],
	[10142.9,12732,0],
	[10188.2,11487.8,0],
	[10319.5,10076.6,0],
	[10493.4,10152.3,0],
	[10858.5,21596.2,0],
	[10974.3,21433.9,0],
	[10993.6,12935.8,0],
	[10984.5,15692.1,0],
	[11071,22572.9,0],
	[11076.2,22582.1,0],
	[11102.3,20738.2,0],
	[11249.3,21040.6,0],
	[11307.3,12170,0],
	[11298.6,15400.2,0],
	[11456,15770.8,0],
	[11579.5,20755.8,0],
	[11614.7,12814.3,0],
	[11624.9,14825.4,0],
	[11647.1,15551.9,0],
	[11868.2,22379.3,0],
	[11908.3,8575.95,0],
	[11913,8575.13,0],
	[11963.1,12995,0],
	[11986.4,14322.7,0],
	[12194.1,12917.8,0],
	[12361.5,12895.4,0],
	[12535.2,8465.64,0],
	[12593.9,8429.62,0],
	[12575.8,8502.64,0],
	[12617.4,17360.8,0],
	[13008.1,22339.9,0],
	[13180.6,15963.3,0],
	[13399.4,20690.9,0],
	[13421.3,17067.7,0],
	[13471.6,21227,0],
	[13561.5,19948.3,0],
	[14215.5,21086,0],
	[14251.5,20266.4,0],
	[14481.1,19672.8,0],
	[14795.1,19680.7,0],
	[14841.4,20176.6,0],
	[14945.5,21174.3,0],
	[15128.4,18530.3,0],
	[15354,20362.1,0],
	[15744.6,17771.3,0],
	[15753.1,11010,0],
	[15756.9,20739.2,0],
	[15885.8,17936,0],
	[15899.9,18007.9,0],
	[15969.9,21257.2,0],
	[16049.8,18614.3,0],
	[16046.7,21295.2,0],
	[16227.3,21082.2,0],
	[16393.9,17962.4,0],
	[16623.5,17731.7,0],
	[16991.2,18434.8,0],
	[17254.8,18790.6,0],
	[17438.9,18934.4,0],
	[17495,14347.1,0],
	[17583.3,14467.8,0],
	[17726.7,12959.5,0],
	[17702.6,12988.2,0],
	[17845.6,12821.6,0],
	[18101.6,17707.7,0],
	[18474.6,11251.2,0],
	[18593.2,17097.7,0],
	[18750.9,13000.4,0],
	[18904.1,8536,0],
	[19273.9,14354.4,0],
	[19291.5,14336.9,0],
	[19309.4,18184.5,0],
	[19500.3,14071.5,0],
	[19535.4,16517.9,0],
	[19581.4,9297.74,0],
	[19941.2,8541.49,0],
	[20031.3,10181,0],
	[20167.8,14789.8,0],
	[20168.2,19953,0],
	[20222.1,9818.84,0],
	[20282.2,17623.7,0],
	[20312.3,13810.5,0],
	[20324.2,16828.1,0],
	[20322.2,17456.1,0],
	[20317.9,17498.8,0],
	[20495.5,19407.6,0],
	[20632.4,13930.6,0],
	[20700.3,15892.4,0],
	[20715.7,17525.5,0],
	[20931.7,18652.2,0],
	[21018.4,17553,0],
	[21267.8,15487.7,0],
	[21266.1,15483.7,0],
	[21309.9,11882,0],
	[21422.9,17086.5,0],
	[21553.6,17095.5,0],
	[21586.3,9185.27,0],
	[21592.1,18855,0],
	[21678.5,16910.2,0],
	[21678,16905.3,0],
	[21708.3,17103.6,0],
	[21710.4,17696.2,0],
	[21813.2,13984.9,0],
	[21861.5,18119.4,0],
	[21890.7,15520.6,0],
	[21908.4,19538.3,0],
	[22078.5,17675.8,0],
	[22093.6,17884,0],
	[22087.9,19954.4,0],
	[22153.2,21108.6,0],
	[22174.8,14540.1,0],
	[22176.2,20264.3,0],
	[22252.1,14583.4,0],
	[22261.8,16662.4,0],
	[22302.4,14312.6,0],
	[22370.9,16205.8,0],
	[22360.1,21800.2,0],
	[22426.4,18569.2,0],
	[22447.1,17774.2,0],
	[22448.1,19256.3,0],
	[22499.6,20780.5,0],
	[22528.5,19186.8,0],
	[22557.8,15517.2,0],
	[22534,19189.2,0],
	[22560.2,17172.4,0],
	[22575,19512.2,0],
	[22565.2,21428.7,0],
	[22727.6,17223.8,0],
	[22726.4,20901.8,0],
	[22791.1,17804.9,0],
	[22839.7,18945,0],
	[22932.3,21019.1,0],
	[23022.7,19430.4,0],
	[23123.1,16723.1,0],
	[23497.7,20475,0],
	[23858.1,23585.7,0],
	[23866.3,23776.4,0],
	[23911.4,19484.3,0],
	[24166.2,23112.8,0],
	[24188,22798,0],
	[24216.3,23078.2,0],
	[24270,19777.6,0],
	[24358.1,22259.5,0],
	[24393.7,21526.2,0],
	[24426.8,19896.1,0],
	[24427.6,22239.5,0],
	[24474.5,22599.3,0],
	[24615.2,19333.3,0],
	[24743.4,20697.6,0],
	[24775.3,20713.4,0],
	[24834.7,22095.5,0],
	[25010.2,22632.1,0],
	[25027.3,18987.2,0],
	[25140.2,23369,0],
	[25255.9,19888.2,0],
	[25412,22861.6,0],
	[25416.1,22867.3,0],
	[25525.9,22882.3,0],
	[25767,22950.4,0],
	[25964.3,20180.6,0],
	[26053.3,22546.2,0],
	[26099.9,23064.6,0],
	[26223.9,20576.3,0],
	[26349.6,23708.6,0],
	[26461.4,22203.5,0],
	[26564.5,20686.4,0],
	[26588.7,22109.3,0],
	[26599.9,22692.8,0],
	[26964.3,23765.3,0],
	[26979,23824.4,0],
	[27213.9,22716.7,0],
	[27317.2,23536.5,0],
	[27394.4,21524.1,0],
	[27395.8,21532.7,0],
	[27429.4,22006.4,0],
	[27518.6,21733.8,0],
	[27560.9,20994.8,0],
	[27565.2,23494.9,0],
	[27760.9,21609.3,0],
	[27751.9,24944,0]
	];
	
RYD_JR_CPStuff = 
	[
	[[["I_officer_F"],["O_officer_F"]], [3.63086,0.884766,-1.12128], -194.99],
	[[["I_Soldier_AR_F","I_Soldier_GL_F","I_soldier_M_F","I_Soldier_LAT_F","I_Soldier_LAT_F","I_Soldier_LAT_F"],["O_Soldier_AR_F","O_Soldier_GL_F","O_soldier_M_F","O_Soldier_LAT_F","O_Soldier_LAT_F","O_Soldier_LAT_F"]], [3.85156,-0.870605,-1.12103], -4.98981],		
	[["Land_FieldToilet_F"], [11.3965,-2.69922,-0.917542], -4.92209],	
	[["Land_WoodenTable_small_F"], [2.05078,-0.781738,-1.12213], 0],	
	[["Land_ChairPlastic_F"], [0.757813,-0.916992,-1.12213], 0],	
	[["Land_ChairPlastic_F"], [1.96777,-2.7876,-1.12207], -90.0132],	
	[["RoadBarrier_F"], [-11.043,10.3389,-1.03241], -269.992],	
	[["RoadBarrier_small_F"], [8.53711,6.45898,-1.08905], 10.0125],	
	[["RoadBarrier_F"], [-13.1963,10.7368,-0.9776], -99.9897],	
	[["Land_HBarrier_3_F"], [9.39941,1.6875,-1.19641], -270.031],	
	[["Land_HBarrier_3_F"], [-9.57031,2.39258,-1.09552], -84.9973],	
	[["Land_HBarrier_5_F"], [0.419922,6.33447,-1.20557], 0.000366211],	
	[["Land_BarrelWater_grey_F"], [-7.59668,2.92334,-1.12811], -254.995],	
	[["Land_CargoBox_V1_F","Box_IND_AmmoVeh_F"], [-7.49219,0.679199,-1.12756], -254.995],	
	[["Land_Pallet_MilBoxes_F"], [7.42383,1.06348,-1.11041], -0.00158691],	
	[[["I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"],["O_MRAP_02_F","O_MRAP_02_hmg_F","O_MRAP_02_gmg_F"]], [-14.748,2.90918,-0.750061], -4.99078]
	];
	
RYD_JR_CampStuff = 
	[
	[["I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_AR_F","I_Soldier_GL_F","I_Soldier_AR_F","I_Soldier_GL_F","I_Soldier_LAT_F","I_soldier_M_F"], [-0.710938,2.99121,0], -189.97],
	[["I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_AR_F","I_Soldier_GL_F","I_Soldier_AR_F","I_Soldier_GL_F","I_Soldier_LAT_F","I_soldier_M_F"], [2.35938,-0.739258,0], -79.9695],
	[["I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_AR_F","I_Soldier_GL_F","I_Soldier_AR_F","I_Soldier_GL_F","I_Soldier_LAT_F","I_soldier_M_F"], [-1.89258,-0.821289,0], -284.97],
	[["Land_CampingTable_small_F"], [2.77539,-2.31152,0], -229.964],
	[["Land_TentA_F"], [3.42578,2.82227,0], -305.027],
	[["Land_TentA_F"], [-1.48242,-4.2793,0], -165.002],
	[["Land_WoodenLog_F"], [3.55273,-3.02148,0], -15.0208],
	[["Box_IND_AmmoVeh_F"], [1.42773,5.62305,0], -54.9613],
	[["Land_HelipadEmpty_F"], [-8.79883,6.54688,0], -54.9478],
	[["Land_GasCooker_F"], [1.90625,-3.29883,0], -54.9602],
	[["Box_IND_WpsSpecial_F"], [2.49219,7.27637,0], 35.0744]
	];

RYD_JR_IntelItems =
	[
	"Land_Laptop_unfolded_F",
	"Land_Laptop_F",
	"Land_HandyCam_F",
	"Land_Notepad_F",
	"Land_MobilePhone_smart_F",
	"Land_MobilePhone_old_F"
	];
			
_assigned = [];

	{
	_pos = _x;
	_tooClose = false;
	
		{
		if (((_x select 0) distance _pos) < 100) exitWith {_tooClose = true};
		}
	foreach _assigned;
	
	if not (_tooClose) then
		{
		//_alpha = 0;
		//_color = "ColorRed";
		//_size = [0.85,0.85];
		//_type = "hd_objective";
		
		//if (RYD_JR_Difficulty < 2) then
			//{
			_alpha = 1;
			_color = "ColorBlack";
			_size = [0.85,0.85];
			_type = "loc_Chapel";			
			//};
		
		_i = "HolyMark_" + (str _x);
		_i = createMarker [_i,_x];
		_i setMarkerColor _color;
		_i setMarkerShape "ICON";
		_i setMarkerType _type;
		_i setMarkerSize _size;
		_i setMarkerAlpha _alpha;
		_assigned pushBack [_pos,_i];
		}	
	}
foreach RYD_JR_allHolyPlaces;

_starting = RYD_JR_Starting select (floor (random (count RYD_JR_Starting)));

//_starting = RYD_JR_Starting select 9;
deleteWaypoint [(group player),0];

player setPos (_starting select 0);
RYD_JR_boat setPos (_starting select 1);
_wp = (group player) addWaypoint [(position player),0];

if (RYD_JR_AIFriend) then
	{
	AIBuddy setPos (player modelToWorld [3,-1,0]);
	};

"bm1" setMarkerPos (_starting select 1);

RYD_JR_allHolyPlaces = _assigned;

_hix = (floor (random (count RYD_JR_allHolyPlaces)));

RYD_JR_holyP = RYD_JR_allHolyPlaces select _hix;

while {((RYD_JR_holyP select 0) distance (_starting select 0)) < 1200} do
	{
	_hix = (floor (random (count RYD_JR_allHolyPlaces)));
	RYD_JR_holyP = RYD_JR_allHolyPlaces select _hix;
	};

RYD_JR_allHolyPlaces set [_hix,0];

RYD_JR_allHolyPlaces = RYD_JR_allHolyPlaces - [0];

_bodyPos = [(RYD_JR_holyP select 0),10,50,3,0,3,0] call BIS_fnc_findSafePos;

if ((_bodyPos distance (RYD_JR_holyP select 0)) > 100) then
	{
	_bodyPos = [(RYD_JR_holyP select 0),10,100,3,0,3,0] call BIS_fnc_findSafePos;
	};

RYD_JR_Brother setPos _bodyPos;
RYD_JR_Brother setDir (random 360);

_aiPos = [_bodyPos,1,50,5,0,3,0] call BIS_fnc_findSafePos;

RYD_JR_AI setPos _aiPos;
RYD_JR_AI setDir (random 360);

[(group RYD_JR_AI),_aiPos,"MOVE","STEALTH","BLUE","LIMITED","WEDGE",["true",""],true,100,1000,5,3,2,true] call RYD_JR_SADPatrol;

//diag_log format ["---------------------------------------------------------------------------- BODY POS %1",_bodyPos];

if (RYD_JR_Debug) then
	{
	_i = "BodyMark_" + (str _bodyPos);
	_i = createMarker [_i,_bodyPos];
	_i setMarkerColor "colorPink";
	_i setMarkerShape "ICON";
	_i setMarkerType "mil_dot";
	_i setMarkerSize [1.2,1.2];
	_i setMarkerText "BODY"
	};
	
_aID = RYD_JR_Brother addAction ["<t color='#d0a900'>Load body into the vehicle</t>", "BodyHide.sqf", [], 1, false, true, "", "(not (isNull (assignedVehicle player)) and (((assignedVehicle player) distance _target) < 10) and {has_body})"];
_id = RYD_JR_Brother addAction ["<t color='#d0a900'>Load body on the boat</t>", "BodyBoat.sqf", [], 1, false, true, "", "((({alive _x} count RYD_JR_boats) > 0) and (({(RYD_JR_Brother distance _x) < 200} count RYD_JR_boats) > 0) and not (has_body_boat) and not (RYD_JR_inStealth) and {has_body})"];

RYD_JR_Terminals = ["B_UavTerminal","I_UavTerminal","O_UavTerminal"];
RYD_JR_UGVDisabled = false;
RYD_JR_UGVHacked = false;
RYD_JR_AIRogued = false;
RYD_JR_Hacking = false;
RYD_JR_noAI = false;
RYD_JR_stopAI = false;
RYD_JR_AmmoSearch = false;

RYD_JR_safeTracks = [];
RYD_JR_stealthTracks = [];
RYD_JR_combatTracks = [];

for "_i" from 0 to ((count _musicClass) - 1) do
	{
	_class = _musicClass select _i;
	
	if (isClass _class) then
		{
		_class = configName _class;
		
		if (isText (_musicClass >> _class >> "theme")) then
			{
			if (isNumber (_musicClass >> _class >> "duration")) then
				{
				_dur = getNumber (_musicClass >> _class >> "duration");
				
				if (_dur > 60) then
					{
					_theme = toLower (getText (_musicClass >> _class >> "theme"));
					
					switch (_theme) do
						{
						case ("safe") : {RYD_JR_safeTracks pushBack [_class,_dur]};
						case ("stealth") : {RYD_JR_stealthTracks pushBack [_class,_dur]};
						case ("combat") : {RYD_JR_combatTracks pushBack [_class,_dur]};
						};
					}
				}
			}
		else
			{
			if (isText (_musicClass >> _class >> "musicClass")) then
				{
				if (isNumber (_musicClass >> _class >> "duration")) then
					{
					_dur = getNumber (_musicClass >> _class >> "duration");
					
					if (_dur > 60) then
						{
						_theme = toLower (getText (_musicClass >> _class >> "musicClass"));
						
						switch (_theme) do
							{
							case ("calm") : {RYD_JR_safeTracks pushBack [_class,_dur]};
							case ("stealth") : {RYD_JR_stealthTracks pushBack [_class,_dur]};
							case ("action") : {RYD_JR_combatTracks pushBack [_class,_dur]};
							};
						}
					}			
				}
			}
		}
	};

progressLoadingScreen 0.1;

_dlcRestricted = 
	[
	"u_b_fullghillie_lsh",
	"u_b_fullghillie_sard",
	"u_b_fullghillie_ard",
	"u_o_fullghillie_lsh",
	"u_o_fullghillie_sard",
	"u_o_fullghillie_ard",
	"u_i_fullghillie_lsh",
	"u_i_fullghillie_sard",
	"u_i_fullghillie_ard",
	"optic_ams",
	"optic_ams_khk",
	"optic_ams_snd",
	"optic_khs_blk",
	"optic_khs_hex",
	"optic_khs_old",
	"optic_khs_tan",
	"srifle_dmr_02_f",
	"srifle_dmr_02_camo_f",
	"srifle_dmr_02_sniper_f",
	"srifle_dmr_02_aco_f",
	"srifle_dmr_02_mrco_f",
	"srifle_dmr_02_sos_f",
	"srifle_dmr_02_dms_f",
	"srifle_dmr_02_sniper_ams_lp_s_f",
	"srifle_dmr_02_camo_ams_lp_f",
	"srifle_dmr_02_arco_f",
	"srifle_dmr_03_f",
	"srifle_dmr_03_khaki_f",
	"srifle_dmr_03_tan_f",
	"srifle_dmr_03_multicam_f",
	"srifle_dmr_03_woodland_f",
	"srifle_dmr_03_aco_f",
	"srifle_dmr_03_mrco_f",
	"srifle_dmr_03_sos_f",
	"srifle_dmr_03_dms_f",
	"srifle_dmr_03_tan_ams_lp_f",
	"srifle_dmr_03_dms_snds_f",
	"srifle_dmr_03_arco_f",
	"srifle_dmr_03_ams_f",
	"srifle_dmr_04_f",
	"srifle_dmr_04_tan_f",
	"srifle_dmr_04_aco_f",
	"srifle_dmr_04_mrco_f",
	"srifle_dmr_04_sos_f",
	"srifle_dmr_04_dms_f",
	"srifle_dmr_04_arco_f",
	"srifle_dmr_04_ns_lp_f",
	"srifle_dmr_05_blk_f",
	"srifle_dmr_05_hex_f",
	"srifle_dmr_05_tan_f",
	"srifle_dmr_05_aco_f",
	"srifle_dmr_05_mrco_f",
	"srifle_dmr_05_sos_f",
	"srifle_dmr_05_dms_f",
	"srifle_dmr_05_khs_lp_f",
	"srifle_dmr_05_dms_snds_f",
	"srifle_dmr_05_arco_f",
	"srifle_dmr_06_camo_f",
	"srifle_dmr_06_olive_f",
	"srifle_dmr_06_camo_khs_f",
	"mmg_01_hex_f",
	"mmg_01_tan_f",
	"mmg_01_hex_arco_lp_f",
	"mmg_02_camo_f",
	"mmg_02_black_f",
	"mmg_02_sand_f",
	"mmg_02_sand_rco_lp_f",
	"mmg_02_black_rco_bi_f"	
	];

for "_i" from 0 to ((count _weapClass) - 1) do
	{
	_class = _weapClass select _i;

	if (isClass _class) then
		{
		_class = configName _class;
		_scope = getNumber (_weapClass >> _class >> "Scope");
		
		_isOwned = [(_weapClass >> _class)] call RYD_JR_OwnedDLC;		
		
		if ((_scope == 2) and {(_isOwned)}) then
			{
			_pic = _weapClass >> _class >> "Picture";
			if (isText _pic) then
				{
				_pic = toLower (getText _pic);
				if not (_pic in ["","\a3\weapons_f\data\clear_empty.paa"]) then
					{
					_dlc = _weapClass >> _class >> "DLC";
										
					//if ((isText _dlc) and {((toLower _class) in _dlcRestricted) and {not ((304400 in (getDLCs 1)) or {332350 in (getDLCs 1)})}}) exitWith {};
					
					if (not (RYD_JR_Abundant) or {not (isText _dlc) or {not ((toLower (getText _dlc)) isEqualTo "kart")}}) then
						{
						if (not (RYD_JR_Abundant) or {(((toLower _class) find "u_c_driver_") < 0)}) then
							{
							_isItem = false;
							_item = _weapClass >> _class;
							_item = _class;
							_base = tolower _item;
							
							while {not (_base in ["itemcore","detectorcore","binocular"])} do
								{
								_base = inheritsFrom (_weapClass >> _base);
								if not (isClass _base) exitWith {};
								_base = tolower (configName _base);
								if (_base in ["default"]) exitWith {};
								};
								
							if (_base in ["itemcore","detectorcore","binocular"]) then
								{
								_isItem = true
								};

							switch (_isItem) do
								{
								case (false) : {RYD_JR_AllWeapons pushBack _class};
								case (true) : {RYD_JR_AllItems pushBack _class};
								}
							}
						}
					}
				}
			}
		}
	};
	
progressLoadingScreen 0.2;

for "_i" from 0 to ((count _ammoClass) - 1) do
	{
	_class = _ammoClass select _i;
	
	if (isClass _class) then
		{
		_class = configName _class;
		
		_isOwned = [(_ammoClass >> _class)] call RYD_JR_OwnedDLC;
		
		if ((isNumber (_ammoClass >> _class >> "weaponPoolAvailable")) and {(_isOwned)}) then
			{
			_inPool = getNumber (_ammoClass >> _class >> "weaponPoolAvailable");
			if (_inPool == 1) then
				{
				_shortD = _ammoClass >> _class >> "descriptionShort";
				if (isText _shortD) then
					{
					if not (_shortD in [""]) then
						{
						_pic = _ammoClass >> _class >> "Picture";
						if (isText _pic) then
							{
							_pic = getText _pic;
							if not (_pic in [""]) then
								{
								_dlc = _ammoClass >> _class >> "DLC";
								if (not (isText _dlc) or {not ((toLower (getText _dlc)) isEqualTo "kart")}) then
									{	
									RYD_JR_AllAmmo pushBack _class
									}
								}
							}
						}
					}
				}
			}
		}
	};
	
/*for "_i" from 0 to ((count _vehClass) - 1) do
	{
	_class = _vehClass select _i;
	
	if (isClass _class) then
		{
		_class = configName _class;
		_inherits = inheritsFrom (_vehClass >> _class);
		
		if (isClass _inherits) then
			{
			_inherits = configName _inherits;

			if (_inherits in ["B_FieldPack_blk","B_AssaultPack_Base","B_Carryall_Base","B_BergenC_Base","B_FieldPack_Base","B_Kitbag_Base","B_OutdoorPack_Base","B_TacticalPack_Base"]) then
				{		
				_scope = getNumber (_vehClass >> _class >> "Scope");
				if (_scope == 2) then
					{
					RYD_JR_AllBackpacks pushBack _class
					}
				}
			}
		}
	};*/
	
progressLoadingScreen 0.3;
	
for "_i" from 0 to ((count _vehClass) - 1) do
	{
	_class = _vehClass select _i;
	
	if (isClass _class) then
		{
		_class = configName _class;
		_lowClass = toLower _class;

		_isOwned = [(_vehClass >> _class)] call RYD_JR_OwnedDLC;
		_dlc = _vehClass >> _class >> "DLC";
		
		if ((not (isText _dlc) or {not ((toLower (getText _dlc)) isEqualTo "kart")}) and {(_isOwned)}) then
			{
			_scope = getNumber (_vehClass >> _class >> "Scope");
			if (_scope == 2) then
				{
				_sim = toLower (getText (_vehClass >> _class >> "Simulation"));
				if (_sim in ["carx","tankx"]) then
					{
					_hasDriver = getNumber (_vehClass >> _class >> "hasDriver");
					
					if (_hasDriver == 1) then
						{
						_vc = getText (_vehClass >> _class >> "vehicleClass");
						
						if not (_vc in ["Autonomous"]) then
							{
							if (_lowClass in ["b_g_quadbike_01_f","b_quadbike_01_f","o_quadbike_01_f","i_quadbike_01_f"]) then
								{
								_class = "C_Quadbike_01_F"
								};
							
							switch (_sim) do
								{
								case ("carx") : {RYD_JR_AllSoftV pushBack _class};
								case ("tankx") : {RYD_JR_AllArmor pushBack _class};
								}
							}
						}
					}
				}
			}
		}
	};
	
progressLoadingScreen 0.4;

	{
	for "_i" from 1 to _x do
		{
		_isGood = false;
		_spawnPos = [];
		_ct = 1;
		
		while {not (_isGood)} do
			{
			_pos = [(_mapC select 0) - _rds + (random (2 * _rds)),(_mapC select 1) - _rds + (random (2 * _rds))];
			
			if not (surfaceIsWater _pos) then
				{
				_pos set [2,0];
				_nR = _pos nearRoads 200;
				
				if not ((count _nR) < 1) then
					{
					_roadS = _nR select (floor (random (count _nR)));
					_spawnPos = [(getPosATL _roadS),8,50,15,0,2,0] call BIS_fnc_findSafePos;
					_spawnPos set [2,0];
					
					if ((_mapDefPos distance _spawnPos) > 1) then
						{
						if not (isOnRoad _spawnPos) then
							{
							_isGood = true
							}
						}
					}
				};
			
			_ct = _ct + 1;
			if (_ct > 50) exitWith {}
			};
			
		if (_isGood) then
			{
			_vehType = "";
			
			switch (_foreachIndex) do
				{
				case (0) : {_vehType = RYD_JR_AllSoftV select (floor (random (count RYD_JR_AllSoftV)))};
				case (1) : {_vehType = RYD_JR_AllArmor select (floor (random (count RYD_JR_AllArmor)))};
				};
			
			_veh = createVehicle [_vehType, _spawnPos, [], 0, "NONE"];
			
			RYD_JR_AllEV pushBack _veh;
			
			_dir = random 360;
			
			if not (isNull _roadS) then
				{
				_nRSg = (roadsConnectedTo _roadS) - [_roadS];
				
				if ((count _nRSg) > 0) then
					{
					_segRef = _nRSg select (floor (random (count _nRSg)));
					
					_dir = [(getPosATL _segRef),(getPosATL _roadS),6] call RYD_JR_AngTowards
					}
				};
					
			_veh setDir _dir;
			
			clearItemCargo _veh;
			clearWeaponCargo _veh;
			clearMagazineCargo _veh;
			if ((random 100) > 0.25) then {_veh setFuel (0.3 + (random 0.7))};
			if ((random 100) > 0.25) then {_veh setVehicleAmmo (random 1)};
			if ((random 100) > 0.25) then {_veh setDamage (random 0.6)};
			
			if (RYD_JR_Debug) then
				{
				_m = "VMark_" + (str _spawnPos);
				_m = createMarker [_m,_spawnPos];
				_m setMarkerColor "colorGrey";
				_m setMarkerShape "ICON";
				_m setMarkerType "mil_triangle";
				_m setMarkerSize [0.5,0.5];
				_m setMarkerText _vehType
				}
			};
		
		}
	}
foreach [_softVAm,_armVAm];

progressLoadingScreen 0.5;
	
	{
	_side = resistance;
	if (_foreachIndex == 1) then {_side = east};
	_gpClass = _x;
	
	for "_i" from 0 to ((count _gpClass) - 1) do
		{
		_class = _gpClass select _i;
		
		if (isClass _class) then
			{
			_isOwned = true;
			for "_j" from 0 to ((count _class) - 1) do
				{
				_vehC = _class select _j;
				if (isClass _vehC) then
					{
					_vehC = configName _vehC;
					_veh = _gpClass >> (configName _class) >> _vehC >> "vehicle";

					if (isText _veh) then
						{
						_veh = getText _veh;
						_isOwned = [(_vehClass >> _veh)] call RYD_JR_OwnedDLC;
						if not (_isOwned) exitWith {};
						};
						
					if not (_isOwned) exitWith {};
					};
					
				if not (_isOwned) exitWith {};
				};
			
			if (_isOwned) then
				{
				switch (_side) do
					{
					case (resistance) : {RYD_JR_AllInfGroupsI pushBack [_side,_class]};
					case (east) : {RYD_JR_AllInfGroupsE pushBack [_side,_class]};
					}
				}
			}
		}
	}
foreach [configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry",configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry"];
	
	{
	_side = resistance;
	if (_foreachIndex == 1) then {_side = east};
	_gpClass = _x;
	
	for "_i" from 0 to ((count _gpClass) - 1) do
		{
		_class = _gpClass select _i;
		
		if (isClass _class) then
			{
			_isOwned = true;
			for "_j" from 0 to ((count _class) - 1) do
				{
				_vehC = _class select _j;
				if (isClass _vehC) then
					{
					_vehC = configName _vehC;
					_veh = _gpClass >> (configName _class) >> _vehC >> "vehicle";

					if (isText _veh) then
						{
						_veh = getText _veh;
						_isOwned = [(_vehClass >> _veh)] call RYD_JR_OwnedDLC;
						if not (_isOwned) exitWith {};
						};
						
					if not (_isOwned) exitWith {};
					};
					
				if not (_isOwned) exitWith {};
				};
			
			if (_isOwned) then
				{	
				switch (_side) do
					{
					case (resistance) : {RYD_JR_AllMotGroupsI pushBack [_side,_class]};
					case (east) : {RYD_JR_AllMotGroupsE pushBack [_side,_class]};
					}
				}
			}
		}
	}
foreach [configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Motorized",configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Motorized_MTP"];
	
	{
	_side = resistance;
	if (_foreachIndex == 1) then {_side = east};
	_gpClass = _x;

	for "_i" from 0 to ((count _gpClass) - 1) do
		{
		_class = _gpClass select _i;
		
		if (isClass _class) then
			{
			_isOwned = true;
			for "_j" from 0 to ((count _class) - 1) do
				{
				_vehC = _class select _j;
				if (isClass _vehC) then
					{
					_vehC = configName _vehC;
					_veh = _gpClass >> (configName _class) >> _vehC >> "vehicle";

					if (isText _veh) then
						{
						_veh = getText _veh;
						_isOwned = [(_vehClass >> _veh)] call RYD_JR_OwnedDLC;
						if not (_isOwned) exitWith {};
						};
						
					if not (_isOwned) exitWith {};
					};
					
				if not (_isOwned) exitWith {};
				};
			
			if (_isOwned) then
				{	
				switch (_side) do
					{
					case (resistance) : {RYD_JR_AllMechGroupsI pushBack [_side,_class]};
					case (east) : {RYD_JR_AllMechGroupsE pushBack [_side,_class]};
					}
				}
			}
		}
	}
foreach [configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Mechanized",configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Mechanized"];
	
	{
	_side = resistance;
	if (_foreachIndex == 1) then {_side = east};
	_gpClass = _x;

	for "_i" from 0 to ((count _gpClass) - 1) do
		{
		_class = _gpClass select _i;
		
		if (isClass _class) then
			{
			_isOwned = true;
			for "_j" from 0 to ((count _class) - 1) do
				{
				_vehC = _class select _j;
				if (isClass _vehC) then
					{
					_vehC = configName _vehC;
					_veh = _gpClass >> (configName _class) >> _vehC >> "vehicle";

					if (isText _veh) then
						{
						_veh = getText _veh;
						_isOwned = [(_vehClass >> _veh)] call RYD_JR_OwnedDLC;
						if not (_isOwned) exitWith {};
						};
						
					if not (_isOwned) exitWith {};
					};
					
				if not (_isOwned) exitWith {};
				};
			
			if (_isOwned) then
				{
				switch (_side) do
					{
					case (resistance) : {RYD_JR_AllArmGroupsI pushBack [_side,_class]};
					case (east) : {RYD_JR_AllArmGroupsE pushBack [_side,_class]};
					}
				}
			}
		}
	}
foreach [configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Armored",configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Armored"];

_gpClass = configFile >> "CfgGroups";

for "_i" from 0 to ((count _gpClass) - 1) do
	{
	_class = _gpClass select _i;
	
	if (isClass _class) then
		{
		_side = configName _class;
		_rSide = east;
		
		switch (toLower _side) do
			{
			case ("east") : {_rSide = east};
			case ("west") : {_rSide = west};
			case ("indep") : {_rSide = resistance};
			default {_rSide = west};
			};		
		
		if not (_rSide == west) then
			{
			_path = _gpClass >> _side;
			
			for "_j" from 0 to ((count _path) - 1) do
				{
				_class = _path select _j;
				
				if (isClass _class) then
					{
					_fc = configName _class;
					
					_path2 = _path >> _fc;
					
					for "_k" from 0 to ((count _path2) - 1) do
						{
						_class = _path2 select _k;
				
						if (isClass _class) then
							{
							_kind = configName _class;
							
							_path3 = _path2 >> _kind;
							
							for "_l" from 0 to ((count _path3) - 1) do
								{
								_class = _path3 select _l;
								
								if (isClass _class) then
									{
									_gp = configName _class;
									
									_path4 = _path3 >> _gp;
									
									_name = toLower (getText (_path4 >> "name"));
									if (_name in ["diver team"]) exitWith {};
									
									_isOwned = true;
									
									_cnt = count _path4;
									_type = "inf";
									
									for "_m" from 0 to (_cnt - 1) do
										{
										_class = _path4 select _m;
										
										if (isClass _class) then
											{
											_unit = configName _class;
											
											_veh = _path4 >> _unit >> "vehicle";
											
											if (isText _veh) then
												{
												_veh = getText _veh;
												_vehClass = configFile >> "CfgVehicles";

												_isOwned = [(_vehClass >> _veh)] call RYD_JR_OwnedDLC;
												
												if not (_isOwned) exitWith {};
												
												_base = tolower _veh;
												
												while {not (_base in ["air","ship","tank","car","wheeled_apc_f","ugv_01_base_f"])} do
													{
													_base = inheritsFrom (_vehClass >> _base);
													if not (isClass _base) exitWith {};
													_base = tolower (configName _base);
													if (_base in ["allvehicles","all"]) exitWith {};
													};
													
												if (_base in ["air","ship","tank","car","wheeled_apc_f","ugv_01_base_f"]) then
													{
													_type = _base
													};
													
												if not (_type in ["inf"]) exitWith {}
												};
											
											if not (_isOwned) exitWith {};
											if not (_type in ["inf"]) exitWith {}
											};
											
										if not (_isOwned) exitWith {};
										if not (_type in ["inf"]) exitWith {}
										};
										
									if not (_isOwned) exitWith {};
										
									if not (_type in ["air","ship","ugv_01_base_f"]) then
										{
										_gp = [_rSide,_path4];
											
										switch (true) do
											{
											case (_type in ["tank"]) : 
												{
												_added = false;
												
													{
													if ((_x select 1) in [_path4]) exitWith {_added = true}
													}
												foreach (RYD_JR_AllArmGroupsI + RYD_JR_AllArmGroupsE + RYD_JR_AllMechGroupsE + RYD_JR_AllMechGroupsI);
												
												if not (_added) then
													{
													switch (_rSide) do
														{
														case (resistance) : {RYD_JR_AllArmGroupsI pushBack _gp};
														case (east) : {RYD_JR_AllArmGroupsE pushBack _gp};
														}
													}
												};
												
											case (_type in ["wheeled_apc_f"]) : 
												{
												_added = false;
												
													{
													if ((_x select 1) in [_path4]) exitWith {_added = true}
													}
												foreach (RYD_JR_AllMechGroupsI + RYD_JR_AllMechGroupsE);
												
												if not (_added) then
													{
													switch (_rSide) do
														{
														case (resistance) : {RYD_JR_AllMechGroupsI pushBack _gp};
														case (east) : {RYD_JR_AllMechGroupsE pushBack _gp};
														}
													}
												};
												
											case (_type in ["car"]) : 
												{
												_added = false;
												
													{
													if ((_x select 1) in [_path4]) exitWith {_added = true}
													}
												foreach (RYD_JR_AllMotGroupsI + RYD_JR_AllMotGroupsE);
												
												if not (_added) then
													{
													switch (_rSide) do
														{
														case (resistance) : {RYD_JR_AllMotGroupsI pushBack _gp};
														case (east) : {RYD_JR_AllMotGroupsE pushBack _gp};
														}
													}
												};
												
											case ((_cnt < 5) and ((random 100) > 30)) : 
												{
												_added = false;
												
													{
													if ((_x select 1) in [_path4]) exitWith {_added = true}
													}
												foreach RYD_JR_AllLocalGroups;
												
												if not (_added) then
													{
													RYD_JR_AllLocalGroups pushBack _gp
													}
												};	
												
											default
												{
												_added = false;
												
													{
													if ((_x select 1) in [_path4]) exitWith {_added = true}
													}
												foreach (RYD_JR_AllInfGroupsI + RYD_JR_AllInfGroupsE);
												
												if not (_added) then
													{
													switch (_rSide) do
														{
														case (resistance) : {RYD_JR_AllInfGroupsI pushBack _gp};
														case (east) : {RYD_JR_AllInfGroupsE pushBack _gp};
														}
													}										
												}
											}										
										}
									}
								}
							}
						}
					}
				}
			}
		}
	};
	
RYD_JR_AllInfGroups = RYD_JR_AllInfGroupsI + RYD_JR_AllInfGroupsE;
RYD_JR_AllMotGroups = RYD_JR_AllMotGroupsI + RYD_JR_AllMotGroupsE;
RYD_JR_AllMechGroups = RYD_JR_AllMechGroupsI + RYD_JR_AllMechGroupsE;
RYD_JR_AllArmGroups = RYD_JR_AllArmGroupsI + RYD_JR_AllArmGroupsE;
	
progressLoadingScreen 0.6;

RYD_JR_AllMilGuardGroups1 = RYD_JR_AllGuardGroups + RYD_JR_AllInfGroups;

RYD_JR_AllMilGuardGroups1E = RYD_JR_AllGuardGroups + RYD_JR_AllInfGroupsE;
RYD_JR_AllMilGuardGroups1I = RYD_JR_AllInfGroupsI;

RYD_JR_AllMilGuardGroups2 = RYD_JR_AllMotGroups + RYD_JR_AllMechGroups;

RYD_JR_AllMilGuardGroups2E = RYD_JR_AllMotGroupsE + RYD_JR_AllMechGroupsE;
RYD_JR_AllMilGuardGroups2I = RYD_JR_AllMotGroupsI + RYD_JR_AllMechGroupsI;

if (RYD_JR_Arty) then
	{
	RYD_JR_Mortars = [];
	
	_spots = [];

	_expression = "meadow * (1 - forest - trees - houses - sea)";
	_value = selectBestPlaces [_mapC,RYD_JR_mapSize,_expression,200,2 + (floor (random 3))];

		{
		_spots set [(count _spots),_x select 0];
		}
	foreach _value;
	
	_artyPlaces = [];

		{
		_pos0 = _x;
		_pos = _pos0;
		_pos set [2,0];
		_fe = _pos0 isFlatEmpty [6,200,1,5,0,false,objNull];

		if ((count _fe) > 0) then
			{
			_pos0 = _fe
			};
		
		_ct = 0;

		while {(((count _fe) < 1) or ((count (_pos nearRoads 60)) > 0))} do
			{
			_ct = _ct + 1;
			if (_ct > 48) exitWith {};
			_pos = [_pos0,30 + _ct,100 + (_ct * 2)] call RYD_JR_RandomAroundMM;
			_pos set [2,0];
			_fe = _pos isFlatEmpty [6,200,1,5,0,false,objNull];
			
			if ((count _fe) > 0) then
				{
				_pos = _fe;
				_pos set [2,0];
				};
			};
			
		if not (((count (_pos nearRoads 60)) > 0) or ((count _fe) < 1)) then
			{
			_pos = _fe;
			_pos set [2,0];
			_artyPlaces pushBack _pos;
			
			if (RYD_JR_Debug) then
				{
				_i = "aMark_" + (str _pos);
				_i = createMarker [_i,_pos];
				_i setMarkerColor "colorBrown";
				_i setMarkerShape "ICON";
				_i setMarkerType "mil_triangle";
				_i setMarkerSize [0.9,0.9];
				}
			}
		}
	foreach _spots;
	
		{
		_cl = ["I_Mortar_01_F","O_Mortar_01_F"];
		_veh = createVehicle [_cl select (floor (random (count _cl))), _x, [], 0, "NONE"];

		_veh setPos _x;
		
		createVehicleCrew _veh;
				
			{
			_x setSkill (0.15 + (random 0.25));
			[_x,false] call RYD_JR_DecimateGear;
			}
		foreach (crew _veh);
		
		(group _veh) setVariable ["RYD_JR_BatteryName","Hammer " + (str (_foreachIndex + 1))];

		RYD_JR_Mortars pushBack (group _veh)
		}
	foreach _artyPlaces;
	
	if (RYD_JR_ArtyMA) then
		{
		RydFFE_ArtyShells = 4
		};
	
	//RydFFE_Safe = 1;
	RydFFE_Interval = 20;
	RydFFE_2PhWithoutFO = true;
	RydFFE_Monogamy = false;
	RydFFE_Debug = not RYD_JR_NoMarkers;

	[] execVM "RYD_FFE\FFE.sqf";
	};

_spots = [];
_ct = 0;

_expression = "forest + trees - houses";
_value = selectBestPlaces [_mapC,RYD_JR_mapSize,_expression,200,24];

	{
	if ((random 1) < RYD_JR_HCDensityM) then
		{
		_spots set [(count _spots),_x select 0];
		}
	}
foreach _value;

_camps = [];

	{
	_pos0 = _x;
	_pos = _pos0;
	_pos set [2,0];
	_fe = _pos0 isFlatEmpty [18,200,0.5,5,0,false,objNull];
	
	if ((count _fe) > 0) then
		{
		_pos0 = _fe
		};
	
	_ct = 0;

	while {(((count _fe) < 1) or ((count (_pos nearRoads 60)) > 0))} do
		{
		_ct = _ct + 1;
		if (_ct > 48) exitWith {};
		_pos = [_pos0,30 + _ct,100 + (_ct * 2)] call RYD_JR_RandomAroundMM;
		_pos set [2,0];
		_fe = _pos isFlatEmpty [18,200,0.5,5,0,false,objNull];
		
		if ((count _fe) > 0) then
			{
			_pos = _fe;
			_pos set [2,0];
			};
		};
		
	if not (((count (_pos nearRoads 60)) > 0) or ((count _fe) < 1)) then
		{
		_pos = _fe;
		_pos set [2,0];
		_camps pushBack _pos;
		
		if (RYD_JR_Debug) then
			{
			_i = "fMark_" + (str _pos);
			_i = createMarker [_i,_pos];
			_i setMarkerColor "colorGreen";
			_i setMarkerShape "ICON";
			_i setMarkerType "mil_box";
			_i setMarkerSize [0.7,0.7];
			_i setMarkerText (str _foreachIndex)
			}
		}
	}
foreach _spots;

	{
	_cp = [_x] call RYD_JR_Sherwood;
	RYD_JR_CPItems = RYD_JR_CPItems + _cp;
	}
foreach _camps;

	{
	_aID = _x addAction ["<t color='#d0a900'>Establish hideout</t>", "hideout.sqf", [], 1, false, true, "", "not ((RYD_JR_inStealth) or (((_target in RYD_JR_Base) or (alive RYD_JR_PackedCamp)) and not (RYD_JR_multiHC)) or ((_target in RYD_JR_Base) and (RYD_JR_multiHC)))"];
	_aID = _x addAction ["<t color='#d0a900'>Pack hideout into vehicle</t>", "PackHideout.sqf", false, 1, false, true, "", "(not (isNull (assignedVehicle player)) and (((assignedVehicle player) distance _target) < 50)  and (_target in RYD_JR_Base) and not ((RYD_JR_inStealth) or (RYD_JR_isResting) or (alive RYD_JR_PackedCamp)))"];
	_aID = _x addAction ["<t color='#d0a900'>Rest 6 hours and heal yourself (first aid kit or medikit needed)</t>", "rest.sqf", [], 1, false, true, "", "(not ((RYD_JR_inCombat) or (RYD_JR_inStealth) or (RYD_JR_isResting)) and (_target in RYD_JR_Base))"];
	}
foreach RYD_JR_Camps;

_boatSpots = [];

_expression = "((waterDepth factor [1,1.4])/(1 + waterDepth)) * ((randomGen(houses factor [0.1,0.6]))/(1 + houses))";
_value = selectBestPlaces [_mapC,_rds,_expression,15,12];

	{
	_boatSpots set [(count _boatSpots),_x select 0];
	}
foreach _value;

	{
	_pos = _x;// select 0;
	//_val = _x select 1;
	_pos set [2,0];
	_nB = position (nearestBuilding _pos);
	_vehType = "C_Boat_Civil_01_F";
	if ((random 100) < 1) then
		{
		_vehType = ["B_Boat_Armed_01_minigun_F","I_Boat_Armed_01_minigun_F","O_Boat_Armed_01_hmg_F"] select (floor (random 3))
		};
	
	_boat = createVehicle [_vehType, _pos, [], 0, "NONE"];
	
	_dir = [_pos,_nB,10] call RYD_JR_AngTowards;
	
	_boat setDir _dir;	
	
	RYD_JR_Boats pushBack _boat;
	
	clearItemCargo _boat;
	clearWeaponCargo _boat;
	clearMagazineCargo _boat;
	if ((random 100) > 0.25) then {_boat setFuel (0.3 + (random 0.7))};
	if ((random 100) > 0.25) then {_boat setVehicleAmmo (random 1)};
	if ((random 100) > 0.25) then {_boat setDamage (random 0.6)};
	
	if (RYD_JR_Debug) then
		{
		_m = "VMark_" + (str _pos);
		_m = createMarker [_m,_pos];
		_m setMarkerColor "colorGrey";
		_m setMarkerShape "ICON";
		_m setMarkerType "mil_triangle";
		_m setMarkerSize [0.5,0.5];
		_m setMarkerText _vehType
		}
	}
foreach _boatSpots;

RYD_JR_AllEV = (RYD_JR_AllEV + RYD_JR_Boats) - [RYD_JR_Boat];

progressLoadingScreen 0.7;

	{
	_cond = "(isPlayer _target) and not (RYD_JR_inStealth) and (not (isNull (assignedVehicle player)) and not (RYD_JR_FuelFund < 1000) and ((player distance (assignedVehicle player)) < 6) and (((fuel (assignedVehicle player)) < 1) or ((damage (assignedVehicle player)) > 0) or not (canMove (assignedVehicle player)) or not (canFire (assignedVehicle player))))";
	_aID = _x addAction ["<t color='#d0a900'>Inspect your vehicle for 1000 ff</t>", "InspectVeh.sqf", [], 1, false, true, "",_cond];

	if not (RYD_JR_NoMarkers) then
		{
		_aID = _x addAction ["<t color='#d0a900'>Hitch-hiking</t>", "Hitchhiking.sqf", [], 1, false, true, "", "((isPlayer _target) and (isOnRoad (vehicle player)) and (RYD_JR_FuelFund > 0) and not ((RYD_JR_LT) or (RYD_JR_inStealth) or (RYD_JR_isResting) or (loaded_body)))"];
		};
		
	_aID = _x addAction ["<t color='#d0a900'>Check account</t>", "account.sqf", [], 1, false, true, "","(isPlayer _target)"];
	_aID = _x addAction ["<t color='#d0a900'>Place FF decoy</t>", "decoy.sqf", [], 1, false, true, "","((isPlayer _target) and {((count RYD_JR_Freq) > 0) and {not (RYD_JR_FuelFund < 1000) and {not (RYD_JR_inStealth and {RYD_JR_inCombat}) and {not (RYD_JR_isResting) and {not (RYD_JR_DecoyPending)}}}}})"];
	
	if (RYD_JR_ADM) then
		{
		_aID = _x addAction ["<t color='#d0a900'>Anonymous Data Market - hostile activity (600 ff)</t>", "ADMenemy.sqf", [], 1, false, true, "","((isPlayer _target) and (RYD_JR_EnData) and not (RYD_JR_FuelFund < 600))"];
		_aID = _x addAction ["<t color='#d0a900'>Anonymous Data Market - vehicles (1200 ff)</t>", "ADMvehicles.sqf", [], 1, false, true, "","((isPlayer _target) and (RYD_JR_VehData) and not (RYD_JR_FuelFund < 1200))"];
		};

	_aID = _x addAction ["<t color='#d0a900'>Prepare an empty box</t>", "CreateBox.sqf", [], 1, false, true, "","(isPlayer _target) and not ((count RYD_JR_BoxCreated) > 0) and (player == (vehicle player))"];
	_aID = _x addAction ["<t color='#d0a900'>Remove prepared box</t>", "RemoveBox.sqf", [], 1, false, true, "","(isPlayer _target) and ((count RYD_JR_BoxCreated) > 0) and (player == (vehicle player))"];

	_aID = _x addAction ["<t color='#d0a900'>Return to the hideout</t>", "hideoutTravel.sqf", [], 1, false, true, "","((isPlayer _target) and ((count RYD_JR_Base) > 0) and not ((RYD_JR_inStealth) or (RYD_JR_isResting) or (loaded_body)))"];

	_aID = _x addAction ["<t color='#d0a900'>Force self-destruction of the UGV</t>", "HackUGV.sqf", 3, 1, false, true, "", "(isPlayer _target) and (alive RYD_JR_AI) and not (RYD_JR_UGVDisabled) and not (RYD_JR_Hacking) and (({_x in (assignedItems player)} count RYD_JR_Terminals) > 0) and (RYD_JR_AISpotted) and ((player distance RYD_JR_AI) < 100)"];
	_aID = _x addAction ["<t color='#d0a900'>Reprogram the UGV targeting</t>", "HackUGV.sqf", 1, 1, false, true, "", "(isPlayer _target) and (alive RYD_JR_AI) and not (RYD_JR_UGVDisabled) and not (RYD_JR_noAI) and not (RYD_JR_Hacking) and (({_x in (assignedItems player)} count RYD_JR_Terminals) > 0) and (RYD_JR_AISpotted) and ((player distance RYD_JR_AI) < 100)"];
	_aID = _x addAction ["<t color='#d0a900'>Disable UGV's AI control</t>", "HackUGV.sqf", 2, 1, false, true, "", "(isPlayer _target) and (alive RYD_JR_AI) and not (RYD_JR_UGVDisabled) and not (RYD_JR_Hacking) and (({_x in (assignedItems player)} count RYD_JR_Terminals) > 0) and (RYD_JR_AISpotted) and ((player distance RYD_JR_AI) < 100)"];
	_aID = _x addAction ["<t color='#d0a900'>Find ammo for your vehicle</t>", "ReammoVeh.sqf", true, 1, false, true, "", "((isPlayer _target) and (({not ((toLower _x) in ['minicarhorn','carhorn','truckhorn','truckhorn2','truckhorn3'])} count (weapons (assignedVehicle player))) > 0) and not (RYD_JR_AmmoSearch) and not (isNull (assignedVehicle player)) and ((player distance (assignedVehicle player)) < 6))"];
	}
foreach (RYD_JR_Recruitable + [player]);

RYD_JR_StrongPos = [];
RYD_JR_CaptivesPos = [];

for "_m" from 1 to 2 do
	{
	_bCampPosIx = floor (random (count RYD_JR_MCamps));
	_bCPos = RYD_JR_MCamps select _bCampPosIx;
	RYD_JR_ActualStrongholds pushBack _bCPos;
	_tc = [+_bCPos] call RYD_JR_BigCamp;
	RYD_JR_MCamps set [_bCampPosIx,0];
	RYD_JR_MCamps = RYD_JR_MCamps - [0];
	RYD_JR_StrongPos pushBack [_bCPos,_tc];
	
	_bAFPosIx = floor (random (count RYD_JR_AirFields));
	_afPos = RYD_JR_AirFields select _bAFPosIx;
	RYD_JR_ActualAirfields pushBack _afPos;
	_tc = [+_afPos] call RYD_JR_Airfield;
	RYD_JR_AirFields set [_bAFPosIx,0];
	RYD_JR_AirFields = RYD_JR_AirFields - [0];
	RYD_JR_StrongPos pushBack [_afPos,_tc];
	};
	
RYD_JR_Strongholds = [];
	
	{
	_nB = _x nearObjects ["House",500];
	RYD_JR_Strongholds = RYD_JR_Strongholds + _nB
	}
foreach RYD_JR_ActualAirfields;

	{
	_nB = _x nearObjects ["House",200];
	RYD_JR_Strongholds = RYD_JR_Strongholds + _nB
	}
foreach RYD_JR_ActualStrongholds;
	
progressLoadingScreen 0.8;

	{
	_tooMuch = false;
	
	if ((random 1) < RYD_JR_GarrDensityM) then
		{
		_posL = position _x;
		
		_garrL = 0;
		_text = toLower (text _x);
		
		if not (_text in ["military"]) then
			{
			_mb = _posL nearObjects ["House",500];
			
				{
				if (_x in RYD_JR_BetterLootBuildings) exitWith {_text = "military"}
				}
			foreach _mb
			};	
					
		_nR = _posL nearRoads 100;
		_crs = [];
		
			{
			_con = roadsConnectedTo _x;
			if ((count _con) > 2) then
				{
				_crs pushBack _x
				}
			}
		foreach _nR;
		
		if ((count _crs) == 0) then
			{
			if ((count _nR) > 0) then
				{
				_crs = [_nR select (floor (random (count (_nR))))]
				}
			};
			
		if ((count _crs) > 0) then 
			{
			_posL = getPosATL (_crs select (floor (random (count (_crs)))))
			};
		
		_groups = RYD_JR_AllInfGroups;	
		_amnt = 2;
		_mil = _text in ["military"];
		
		if (_mil) then {_amnt = (((ceil (random 4)) max 2) min 3)};
		
		for "_j" from 1 to _amnt do
			{
			_mobile = false;
			_spawnPos = [_posL,0,250,10,0,5,0] call BIS_fnc_findSafePos;
			
			_spawnPos set [2,0];		
			
			_rnd = random 100;
			
			if ((_j == 1) and (_mil)) then {_rnd = 0};
			
			_gpKind = "inf";

			switch (true) do
				{
				case (_rnd > 95) : {_groups = RYD_JR_AllArmGroups;_mobile = true;_gpKind = "arm"};
				case (_rnd > 90) : {_groups = RYD_JR_AllMechGroups;_mobile = true;_gpKind = "mech"};
				case (_rnd > 80) : {_groups = RYD_JR_AllMotGroups;_mobile = true;_gpKind = "mot"};
				case (_rnd > 30) : {_groups = RYD_JR_AllGuardGroups};
				};
			
			_type = _groups select (floor (random (count _groups)));
			
			_side = _type select 0;
				
			if (({(side _x) == _side} count AllGroups) > RYD_JR_GLimit) exitWith {_tooMuch = true};
			
			_gp = [_spawnPos,_side,_type select 1,nil,_gpKind] call RYD_JR_SpawnGroupSafe;//BIS_fnc_spawnGroup;
			RYD_JR_allEnemy pushBack _gp;
			if (_mobile) then 
				{
				RYD_JR_AllMobile pushBack _gp;
				
				switch (side _gp) do
					{
					case (east) : {RYD_JR_AllMobileE pushBack _gp};
					case (resistance) : {RYD_JR_AllMobileI pushBack _gp};
					}
				};
			
			if (RYD_JR_Debug) then
				{
				_cl = "colorBlack";
				if (_gp in RYD_JR_AllMobile) then {_cl = "colorRed"};
				_i = "SMark_" + (str _spawnPos);
				_i = createMarker [_i,_spawnPos];
				_i setMarkerColor _cl;
				_i setMarkerShape "ICON";
				_i setMarkerType "mil_box";
				_i setMarkerSize [0.4,0.4];
				_i setMarkerText (configName (_type select 1));
				};
			
			if ((_mobile) and not (_mil)) then
				{
				[_gp] call RYD_JR_RoadPatrol
				}
			else
				{	
				_rnd = random 100;
				
				switch (true) do
					{
					case (((_rnd > 70) and (_garrL < 1)) or ((_j == 1) and (_mil))) : 
						{
						RYD_JR_AllGarrisons pushBack _gp;
						_garrL = _garrL + 1
						};
						
					case (_rnd > 10) : 
						{
						[_gp,_spawnPos,"SAD","SAFE","YELLOW","NORMAL","WEDGE",["true",""],true,150,600,25,2,3,true] call RYD_JR_SADPatrol;
						if not (_mobile) then
							{
							RYD_JR_Trackers2 pushBack _gp
							}
						};
						
					default 
						{
						_wp = [_gp,_spawnPos,"DISMISS","SAFE","YELLOW","NORMAL",["true",""]] call RYD_JR_WPadd;
						if not (_mobile) then
							{
							RYD_JR_Trackers2 pushBack _gp
							}
						}
					}
				}
			};
			
		if (_tooMuch) exitWith {};
		};
		
	if (_tooMuch) exitWith {};
	}
foreach RYD_JR_allCities;
	
	{
	_tooMuch = false;
	
	if ((random 1) < RYD_JR_GarrDensityM) then
		{
		_posL = position _x;
		
		_garrL = 0;
		_text = toLower (text _x);
		
		if not (_text in ["military"]) then
			{
			_mb = _posL nearObjects ["House",500];
			
				{
				if (_x in RYD_JR_BetterLootBuildings) exitWith {_text = "military"}
				}
			foreach _mb
			};	
		
		_nR = _posL nearRoads 100;
		_crs = [];
		
			{
			_con = roadsConnectedTo _x;
			if ((count _con) > 2) then
				{
				_crs pushBack _x
				}
			}
		foreach _nR;
		
		if ((count _crs) == 0) then
			{
			if ((count _nR) > 0) then
				{
				_crs = [_nR select (floor (random (count (_nR))))]
				}
			};
			
		if ((count _crs) > 0) then 
			{
			_posL = getPosATL (_crs select (floor (random (count (_crs)))))
			};
		
		_groups = RYD_JR_AllInfGroups;
		
		_amnt = 1;
		_mil = _text in ["military"];
		
		if (_mil) then {_amnt = (((ceil (random 4)) max 1) min 3)};
			
		for "_j" from 1 to _amnt do
			{
			_mobile = false;
			_spawnPos = [_posL,0,250,10,0,5,0] call BIS_fnc_findSafePos;
			
			_spawnPos set [2,0];			
						
			
			_rnd = random 100;
			
			if ((_j == 1) and (_mil)) then {_rnd = 0};
			
			_gpKind = "inf";
			
			switch (true) do
				{
				case (_rnd > 99) : {_groups = RYD_JR_AllArmGroups;_mobile = true;_gpKind = "arm"};
				case (_rnd > 96) : {_groups = RYD_JR_AllMechGroups;_mobile = true;_gpKind = "mech"};
				case (_rnd > 90) : {_groups = RYD_JR_AllMotGroups;_mobile = true;_gpKind = "mot"};
				case (_rnd > 70) : {_groups = RYD_JR_AllGuardGroups};
				};
			
			_type = _groups select (floor (random (count _groups)));
			
			_side = _type select 0;
				
			if (({(side _x) == _side} count AllGroups) > RYD_JR_GLimit) exitWith {_tooMuch = true};
			
			_gp = [_spawnPos,_type select 0,_type select 1,nil,_gpKind] call RYD_JR_SpawnGroupSafe;//BIS_fnc_spawnGroup;
				
			RYD_JR_allEnemy pushBack _gp;
			
			if (_mobile) then 
				{
				RYD_JR_AllMobile pushBack _gp;
				
				switch (side _gp) do
					{
					case (east) : {RYD_JR_AllMobileE pushBack _gp};
					case (resistance) : {RYD_JR_AllMobileI pushBack _gp};
					}
				};
			
			if (RYD_JR_Debug) then
				{
				_cl = "colorBlack";
				if (_gp in RYD_JR_AllMobile) then {_cl = "colorRed"};
				_i = "SMark_" + (str _spawnPos);
				_i = createMarker [_i,_spawnPos];
				_i setMarkerColor _cl;
				_i setMarkerShape "ICON";
				_i setMarkerType "mil_box";
				_i setMarkerSize [0.4,0.4];
				_i setMarkerText (configName (_type select 1));
				};
			
			if ((_mobile) and not (_mil)) then
				{
				[_gp] call RYD_JR_RoadPatrol
				}
			else
				{
				_rnd = random 100;
				
				switch (true) do
					{
					case (((_rnd > 50) and (_garrL < 1)) or ((_j == 1) and (_mil))) : 
						{
						RYD_JR_AllGarrisons pushBack _gp;
						_garrL = _garrL + 1
						};
						
					case (_rnd > 20) : 
						{
						[_gp,_spawnPos,"SAD","SAFE","YELLOW","NORMAL","WEDGE",["true",""],true,60,300,15,2,2,true] call RYD_JR_SADPatrol;
						if not (_mobile) then
							{
							RYD_JR_Trackers3 pushBack _gp
							}
						};
						
					default 
						{
						_wp = [_gp,_spawnPos,"DISMISS","SAFE","YELLOW","NORMAL",["true",""]] call RYD_JR_WPadd;
						if not (_mobile) then
							{
							RYD_JR_Trackers3 pushBack _gp
							}
						}
					}
				}
			};
			
		if (_tooMuch) exitWith {};
		};
		
	if (_tooMuch) exitWith {};
	}
foreach RYD_JR_allVillages;

progressLoadingScreen 0.9;
	
_chosenChecks = [];
_cnt = ceil (((count RYD_JR_AllCheckpoints)/4) * RYD_JR_CPDensityM);

for "_i" from 1 to _cnt do
	{
	_tooClose = false;
	_ix = floor (random (count RYD_JR_AllCheckpoints));
	_pos = RYD_JR_AllCheckpoints select _ix;
	RYD_JR_AllCheckpoints set [_ix,0];
	RYD_JR_AllCheckpoints = RYD_JR_AllCheckpoints - [0];
	
		{
		if ((_pos distance _x) < 500) exitWith {_tooClose = true};
		}
	foreach _chosenChecks;
	
	if not (_tooClose) then
		{
		_chosenChecks pushBack _pos
		}
	};
	
_sides = [east,resistance];

	{
	_side = _sides select (floor (random 2));
	
	if (({(side _x) == _side} count AllGroups) > RYD_JR_GLimit) then
		{
		_side = (_sides - [_side]) select 0
		};
		
	if (({(side _x) == _side} count AllGroups) > RYD_JR_GLimit) exitWith {};
	
	_cp = [_x,_side] call RYD_JR_CPSetup;
	
	RYD_JR_CPItems = RYD_JR_CPItems + _cp;
	
	if (RYD_JR_Debug) then
		{
		_i = "cMark_" + (str _x);
		_i = createMarker [_i,_x];
		_i setMarkerColor "colorRed";
		_i setMarkerShape "ICON";
		_i setMarkerType "mil_box";
		_i setMarkerSize [0.6,0.6];
		}
	}
foreach _chosenChecks;

diag_log format ["CP count: %1",count RYD_JR_CPGroups];

RYD_JR_allEnemy = RYD_JR_allEnemy + RYD_JR_CPGroups;
RYD_JR_AllStuff = RYD_JR_AllStuff + RYD_JR_CPItems;
	
	{
	_tooMuch = false;
	
	if ((random 1) < RYD_JR_GarrDensityM) then
		{
		_garrL = 0;
		_text = toLower (text _x);
		_mil = _text in ["military"];
		_posL = position _x;
		
		if not (_mil) then
			{
			_mb = _posL nearObjects ["House",500];
			
				{
				if (_x in RYD_JR_BetterLootBuildings) exitWith {_mil = true}
				}
			foreach _mb
			};
		
		if (((random 100) > 25) or (_mil)) then
			{
			_nR = _posL nearRoads 100;
			_crs = [];
			
				{
				_con = roadsConnectedTo _x;
				if ((count _con) > 2) then
					{
					_crs pushBack _x
					}
				}
			foreach _nR;
			
			if ((count _crs) == 0) then
				{
				if ((count _nR) > 0) then
					{
					_crs = [_nR select (floor (random (count (_nR))))]
					}
				};
				
			if ((count _crs) > 0) then 
				{
				_posL = getPosATL (_crs select (floor (random (count (_crs)))))
				};
					
			_gps = RYD_JR_AllLocalGroups;
			
			_amnt = 1;
			
			if (_mil) then {_gps = RYD_JR_AllMilGuardGroups1;_amnt = (((ceil (random 4)) max 1) min 3)};
			
			for "_j" from 1 to _amnt do
				{
				_spawnPos = [_posL,0,100,5,0,3,0] call BIS_fnc_findSafePos;
			
				_spawnPos set [2,0];			
				
				switch (true) do
					{
					case ((_j == _amnt) and (_amnt > 1)) : {_gps = RYD_JR_AllMilGuardGroups2};
					case ((_j > 1) and (_amnt > 1)) : {_gps = RYD_JR_AllMilGuardGroups1 + RYD_JR_AllMilGuardGroups2};
					};
										
				_type = _gps select (floor (random (count _gps)));
				
				_side = _type select 0;
				
				if (({(side _x) == _side} count AllGroups) > RYD_JR_GLimit) then
					{
					switch (_side) do
						{
						case (east) : 
							{
							_type = _gps select (floor (random 6));
							switch (true) do
								{
								case ((_j == _amnt) and (_amnt > 1)) : {_gps = RYD_JR_AllMilGuardGroups2I};
								case ((_j > 1) and (_amnt > 1)) : {_gps = RYD_JR_AllMilGuardGroups1I + RYD_JR_AllMilGuardGroups2I};
								};
							};
							
						case (resistance) : 
							{
							_type = _gps select (6 + (floor (random 5)));
							
							switch (true) do
								{
								case ((_j == _amnt) and (_amnt > 1)) : {_gps = RYD_JR_AllMilGuardGroups2E};
								case ((_j > 1) and (_amnt > 1)) : {_gps = RYD_JR_AllMilGuardGroups1E + RYD_JR_AllMilGuardGroups2E};
								};
							};
						};
						
					_side = _type select 0;
					};
					
				if (({(side _x) == _side} count AllGroups) > RYD_JR_GLimit) exitWith {_tooMuch = true};
				
				_gp = [_spawnPos,_side,_type select 1,nil,nil] call RYD_JR_SpawnGroupSafe;//BIS_fnc_spawnGroup;
				RYD_JR_allEnemy pushBack _gp;
			
				if (RYD_JR_Debug) then
					{
					_i = "SMark_" + (str _spawnPos);
					_i = createMarker [_i,_spawnPos];
					_i setMarkerColor "colorBlack";
					_i setMarkerShape "ICON";
					_i setMarkerType "mil_dot";
					_i setMarkerSize [0.4,0.4];
					_i setMarkerText (configname (_type select 1));
					};

				_rnd = random 100;
				
				switch (true) do
					{
					case (((_rnd > 60) and (_garrL < 1)) or ((_j == 1) and (_mil))) : 
						{
						RYD_JR_AllGarrisons pushBack _gp;
						_garrL = _garrL + 1
						};
						
					case (_rnd > 30) : 
						{
						[_gp,_spawnPos,"SAD","SAFE","YELLOW","NORMAL","WEDGE",["true",""],true,30,60,5,1,2,true] call RYD_JR_SADPatrol;
						RYD_JR_Trackers4 pushBack _gp
						};
						
					default 
						{
						_wp = [_gp,_spawnPos,"DISMISS","SAFE","YELLOW","NORMAL",["true",""]] call RYD_JR_WPadd;
						RYD_JR_Trackers4 pushBack _gp
						}
					};
				};
				
			if (_tooMuch) exitWith {};
			};
			
		if (_tooMuch) exitWith {};
		};
		
	if (_tooMuch) exitWith {};
	}
foreach RYD_JR_allLocal;

diag_log format ["Garr count: %1",(count RYD_JR_allEnemy) - (count RYD_JR_CPGroups)];
	
RYD_JR_East = [];
RYD_JR_Resistance = [];
RYD_JR_Trackers = [];

	{
	_ldr = leader _x;
	_x setVariable ["RYD_JR_MyTLName",[name _ldr,side _ldr]];
	_aID = _ldr addAction ["<t color='#d0a900'>Check the intel about your brother's death</t>", "IntelCheck.sqf", [false,side _ldr,"search"], 1, false, true, "", "(((player distance _target) < 3) and not (alive _target))"];

	if (RYD_JR_GCIntel > 0) then
		{
		if ((random 100) < (0.1 * RYD_JR_GCIntel)) then
			{
			_ldr setVariable ["RYD_JR_MoreIntel",true];
			}
		};
		
	_x setVariable ["RYD_JR_GroupCount",{alive _x} count (units _x)];
	
	switch (side _x) do
		{
		case (east) : {RYD_JR_East pushBack _x};
		case (resistance) : {RYD_JR_Resistance pushBack _x};
		};
		
	_camo = configFile >> "CfgVehicles" >> (typeOf _ldr) >> "camouflage";
	
	if (isNumber _camo) then
		{
		_camo = getNumber _camo;
		
		if (_camo < 1) then
			{
			RYD_JR_Trackers pushBack _x
			}
		};
	}
foreach RYD_JR_allEnemy;

KilledMark = compile preProcessFile "KIA\KilledMark.sqf";
[] call compile preprocessfile "KIA\AddKMark.sqf";

progressLoadingScreen 1;

_pDir = [getPosATL player,_mapDefPos,10] call RYD_JR_AngTowards;

player setDir _pDir;
RYD_JR_boat setDir (RYD_JR_boat getDir player);
if (RYD_JR_AIFriend) then
	{
	AIBuddy setDir _pDir;
	};
	
_weapArr = [["hgun_PDW2000_F",["30Rnd_9x21_Mag"]],["SMG_01_F",["30Rnd_45ACP_Mag_SMG_01"]],["SMG_02_F",["30Rnd_9x21_Mag"]]];

if ((dayTime < 4.5) or (dayTime > 19)) then
	{
	_weapArr = [["SMG_02_F",["30Rnd_9x21_Mag"]]];
	};

if (RYD_JR_BetterGear) then
	{
	_weapArr = [["arifle_TRG21_ARCO_pointer_F",["30Rnd_556x45_Stanag"]],["arifle_TRG21_GL_MRCO_F",["30Rnd_556x45_Stanag","1Rnd_HE_Grenade_shell"]],["arifle_TRG20_Holo_F",["30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"]]];
	};

if (RYD_JR_Difficulty == 3) then
	{
	_weapArr = [["hgun_ACPC2_F",["9Rnd_45ACP_Mag","9Rnd_45ACP_Mag"]],["hgun_P07_F",["16Rnd_9x21_Mag"]],["hgun_Pistol_heavy_01_F",["11Rnd_45ACP_Mag","11Rnd_45ACP_Mag"]],["hgun_Rook40_F",["16Rnd_9x21_Mag"]],["hgun_Pistol_heavy_02_F",["6Rnd_45ACP_Cylinder","6Rnd_45ACP_Cylinder","6Rnd_45ACP_Cylinder"]]];
	};

_uniforms = 
	[
	"U_BG_Guerilla1_1",
	"U_BG_Guerilla2_1",
	"U_BG_Guerilla2_2",
	"U_BG_Guerilla2_3",
	"U_BG_Guerilla3_1",
	"U_BG_leader",
	"U_I_G_Story_Protagonist_F",
	"U_I_G_resistanceLeader_F",
	"U_B_CombatUniform_mcam_tshirt",
	"U_B_CTRG_2"
	];

	{
	_unit = _x;
	
	if (RYD_JR_NoItems) then
		{
		removeAllAssignedItems _unit;
		};
	
	removeBackpack _unit;
	removeHeadgear _unit;
		
	if not (RYD_JR_BetterGear) then
		{
		removeVest _unit;
		};
	
	removeUniform _unit;
	
	if not (RYD_JR_Naked) then
		{
		_unit addBackpack "B_OutdoorPack_blu";
		_uni = _uniforms select (floor (random (count _uniforms)));
		_unit addUniform _uni
		};
	
	removeAllWeapons _unit;

		{
		_unit removeMagazine _x
		}
	foreach (magazines _unit);
	
	if not (RYD_JR_Naked) then
		{	
		_wArr = _weapArr select (floor (random (count _weapArr)));
		
		_mga = 3;
		
		if (RYD_JR_BetterGear) then
			{
			_mga = 5
			};
		
			{
			_unit addMagazines [_x, _mga];
			}
		foreach (_wArr select 1);
		
		_unit addWeapon (_wArr select 0);
		//_unit addItem "acc_flashlight";
		_unit addPrimaryWeaponItem "acc_flashlight";
		_unit addItemToBackpack "FirstAidKit";
		
		if (RYD_JR_BetterGear) then
			{
			_unit linkItem "NVGoggles";
			_unit addWeapon "Binocular"
			}
		};
		
	_unit unlinkItem  "ItemGPS";
	//_unit linkItem "B_UavTerminal";
	}
foreach (units (group player));

[RYD_JR_AllGarrisons] call RYD_JR_Garrison;

if (RYD_JR_SCAActive) then
	{
	[] call compile preprocessFile "SCA\SCAInit.sqf";
	};

diag_log format ["EG: %1 IG: %2 All units: %3",{(side _x) == east} count AllGroups,{(side _x) == resistance} count AllGroups,count AllUnits];

_allEnemies = +RYD_JR_allEnemy;

_allEnemies = [_allEnemies,(_starting select 0)] call RYD_JR_DistOrd;

if ((random 100) < 10) then
	{	
	_mineT = 
		[
		"APERSBoundingMine",
		"APERSBoundingMine",
		"APERSMine",
		"APERSMine",
		"APERSMine",
		"APERSMine",
		"APERSTripMine",
		"APERSTripMine",
		"ATMine",
		"ATMine"
		];
		
	_mineTS = 
		[
		"UnderwaterMineAB",
		"UnderwaterMine",
		"UnderwaterMinePDM"
		];

	_spots = [];
	_ct = 0;

	_expression = "(meadow * trees) * (1 - houses - sea)";
	_value = selectBestPlaces [_mapC,RYD_JR_mapSize,_expression,200,1];

		{
		_pos = _x select 0;
		_ct = 0;
		while {true} do
			{
			if (_ct > 100) exitWith {};
			_cities = nearestLocations [_pos, ["NameCityCapital","NameCity","NameVillage"],500];
			_nR = _pos nearRoads 200;
			if not ((surfaceIsWater _pos) or ((count _cities) > 0) or ((count _nR) > 0) or (isOnRoad _pos)) exitWith {};
			_ct = _ct + 1;
			_pos = [(_mapC select 0) - _rds + (random (2 * _rds)),(_mapC select 1) - _rds + (random (2 * _rds))];
			};
			
		if not (_ct > 100) then
			{
			_pos set [2,0];
			_trPos = [_pos,0,100,3,0,2,0] call BIS_fnc_findSafePos;
			_ct = 0;
			
			while {((_trPos distance _mapDefPos) < 10)} do
				{
				_trPos = [_pos,0,100,3,0,2,0] call BIS_fnc_findSafePos;
				_ct = _ct + 1;
				if (_ct > 50) exitWIth {}
				};
			
			RYD_JR_Treasures pushBack _trPos;
			_trPos set [2,1];
			RYD_JR_Chest = [_trPos,"B_supplyCrate_F",RYD_JR_TreasureLoot] call RYD_JR_AddLootCustom;
			
				{
				//_ix = _x addEventHandler ["InventoryOpened",{_this call {if ((_this select 1) in [RYD_JR_Chest]) then {RYD_JR_Treasures = [];{_x removeEventHandler ["InventoryOpened",_x getVariable ["RYD_JR_ChestEH",-1]]} foreach switchableUnits}}};
				//_x setVariable ["RYD_JR_ChestEH",_ix]
				}
			foreach switchableUnits;
						
			_wreckPos = [_trPos,10,30] call RYD_JR_RandomAroundMM;
			
			_wreck = createVehicle ["Land_Wreck_Heli_Attack_02_F", _wreckPos, [], 0, "NONE"];
			_wreck setDir (random 360);
			_wreck setPos (getPos _wreck);
			//_wreck setFuel 0;
			//_wreck setDamage 1;
				
			_size = 300;
			_buffor = 60;
			
			for "_i" from 1 to 1 do
				{
				_mfPos = _trPos;
				
				_amnt = 10 + (round (random 5));
						
				for "_j" from 1 to _amnt do
					{
					_types = _mineT;
					
					_mPos = [_mfPos,5,20] call RYD_JR_RandomAroundMM;
					
					if (surfaceIsWater _mPos) then
						{
						if (((ASLtoATL _mPos) select 2) > 1.5) then
							{
							_types = _mineTS
							}
						else
							{
							_mPos set [2,-((ASLtoATL _mPos) select 2)]
							}
						};
				
					_type = _types select (floor (random (count _types)));
					
					_mine = createMine [_type, _mPos, [], 0];
					_mine setDir (random 360); 
					
					_posS = position _mine;
					
					if (RYD_JR_Debug) then
						{
						_mk = "MineFMark_" + (str _posS);
						_mk = createMarker [_mk,_posS];
						_mk setMarkerColor "colorYellow";
						_mk setMarkerShape "ICON";
						_mk setMarkerType "mil_dot";
						_mk setMarkerSize [0.3,0.3];
						};
					};
				};
			
			if (RYD_JR_Debug) then
				{
				_cl = "ColorOrange";
				_i = "TMark_" + (str _trPos);
				_i = createMarker [_i,_trPos];
				_i setMarkerColor _cl;
				_i setMarkerShape "ICON";
				_i setMarkerType "mil_triangle";
				_i setMarkerSize [0.7,0.7];
				_i setMarkerText "T";
				};		
			}
		}
	foreach _value
	};
	
_initAllEnemy = +_allEnemies;
	
		{
		switch (true) do
			{
			case (isNil {_x}) : {_initAllEnemy set [_foreachIndex,0]};
			case (isNull _x) : {_initAllEnemy set [_foreachIndex,0]};
			case (({alive _x} count (units _x)) < 1) : {deleteGroup _x;_initAllEnemy set [_foreachIndex,0]};
			}
		}
	foreach _initAllEnemy;
	
	_initAllEnemy = _initAllEnemy - [0];
	_mk = "";
		
		{	
		_checked = [];
		
			{
			_vh = vehicle _x;
			
			if not (_vh in _checked) then
				{
				_checked pushBack _vh;
				
				if not (_vh == _x) then
					{
						{
						_x enableSimulation true;
						_x hideObject false
						}
					foreach (crew _vh)
					};
				
				_vh enableSimulation true;
				_vh hideObject false
				}
			}
		foreach (units _x);

		if ((_foreachIndex/10) == (floor (_foreachIndex/10))) then
			{
			//sleep 0.2;
			};
			
		_vhs = _x getVariable ["RYD_JR_OurVehs",[]];
		
			{
			(assignedDriver _x) moveInDriver _x;
			(assignedGunner _x) moveInGunner _x;
			(assignedCommander _x) moveInCommander _x;
			
			_vh = _x;
			
				{
				_x moveInCargo _vh
				}
			foreach (assignedCargo _x)
			}
		foreach _vhs;
		
		_rad = 2000;
		
		switch (true) do
			{
			//case (_x in RYD_JR_AllStuff) : {_rad = 1500};
			//case (_x in RYD_JR_AllHolders) : {_rad = 500};
			case (_x in RYD_JR_AllMobile) : {_rad = 4000};
			};
			
		_ldr0 = (leader _x);
		_sub0 = (units _x) - [_ldr0];
		_ldr = vehicle _ldr0;
		_ldrV = assignedVehicle _ldr0;

		if (isNull _ldrV) then {_ldrV = _ldr};
		
		_drv = assignedDriver _ldrV;
		_gun = assignedGunner _ldrV;
		_com = assignedCommander _ldrV;
		
		if (isNull _drv) then {_drv = driver _ldrV};
		if (isNull _gun) then {_gun = gunner _ldrV};
		if (isNull _com) then {_com = commander _ldrV};
		
		_assCL = assignedCargo _ldrV;
		_ldrCrew = ([_drv,_gun,_com,_ldrV] + _assCL);
		_ldrCrewMen = (_ldrCrew - [_ldrV,_ldr0]) + [_ldr0];
		_sub0 = _sub0 - _ldrCrew;
			
		_pos = getPosATL _ldr;
		
		if (RYD_JR_Debug) then
			{
			_mk = _x getVariable ["mymarker",""];
			_mk setMarkerPos _pos;
			//_mk setMarkerText (str (side _ldr0)) + "_" + (str (((expectedDestination _ldr0) select 0) distance (position _ldr0)));
			};
			
		_timeStamp = _x getVariable ["RYD_JR_TS",-120];
		
		if ((time - _timeStamp) > 120) then
			{
			if ((_pos distance player) > _rad) then
				{						
				switch (RYD_JR_CachingMode) do
					{
					case (1) :
						{
						_sub = [];
						_vehs = [];
						_added = [];
						
							{
							_sVeh = vehicle _x;
							_assVeh = assignedVehicle _x;
							if (isNull _assVeh) then {_assVeh = _sVeh};
							
							if (_assVeh == _x) then
								{
								if not (_x in _sub) then
									{
									_sub set [count _sub,_x];
									};
								};
								
							if not (_assVeh == _x) then
								{
								if not (_assVeh in _added) then
									{
									_crew = [];
									_assCargo = [];
									_drv = assignedDriver _assVeh;
									_gun = assignedGunner _assVeh;
									_com = assignedCommander _assVeh;
									
									if (isNull _drv) then {_drv = driver _assVeh};
									if (isNull _gun) then {_gun = gunner _assVeh};
									if (isNull _com) then {_com = commander _assVeh};
									
										{
										_crew set [count _crew,_x]
										}
									foreach [_drv,_gun,_com];
									
										{
										_driverOut = false;
										_type = typeOf _x;
										_sPos = getPosATL _x;
										_sDir = getDir _x;
										_sDam = damage _x;
										_sCargo = [];
										_data = [[],_type,_sPos,_sDir,_sDam,_x getVariable ["RYD_JR_Stopped",false],_x getVariable ["RYD_JR_Watched",[]],unitPos _x,_x getVariable ["RYD_JR_Sitting",false],_sCargo,_driverOut,_x getVariable ["RYD_JR_MyRemovedGear",[]],_x in _assVeh,_x];											
										_assCargo pushBack _data;
										}
									foreach (assignedCargo _assVeh);
									
									_added pushBack _assVeh;
									_vehs set [(count _vehs),[_assVeh,_crew,_assCargo]];
									}
								}
							}
						foreach _sub0;
															
						_gp = _x;

						_x allowFleeing 0;
						
							{
							_x enableSimulation false;
							_x hideObject true
							}
						foreach _ldrCrew;

						_ldr0 enableSimulation false;
						_ldr0 hideObject true;
						
						_gpData = [];

							{
							_isMan = [];
							_driverOut = false;
							_type = typeOf _x;
							_sPos = getPosATL _x;
							_sDir = getDir _x;
							_sDam = damage _x;
							_sCargo = [];

							_data = [_isMan,_type,_sPos,_sDir,_sDam,_x getVariable ["RYD_JR_Stopped",false],_x getVariable ["RYD_JR_Watched",[]],unitPos _x,_x getVariable ["RYD_JR_Sitting",false],_sCargo,_driverOut,_x getVariable ["RYD_JR_MyRemovedGear",[]]];											
							_gpData pushBack _data;

							deleteVehicle _x;	
							}
						foreach _sub;

							{
							_asV = _x select 0;
							_driverOut = false;
							
							if not ((assignedDriver _asV) in _asV) then
								{
								_driverOut = true
								};
							
							_isMan = [];
							
								{
								_isMan set [(count _isMan),[typeOf _x,damage _x,_x getVariable ["RYD_JR_MyRemovedGear",[]]]];
								deleteVehicle _x
								}
							foreach (_x select 1);
							
								{
								_isMan pushBack _x;
								deleteVehicle (_x select 13)
								}
							foreach (_x select 2);										
							
							_type = typeOf _asV;
							_sPos = getPosATL _asV;
							_sDir = getDir _asV;
							_sDam = damage _asV;
							
							_sCargo = [getWeaponCargo _asV,getMagazineCargo _asV,getItemCargo _asV];
								
							_data = [_isMan,_type,_sPos,_sDir,_sDam,_asV getVariable ["RYD_JR_Stopped",false],_asV getVariable ["RYD_JR_Watched",[]],unitPos _asV,_asV getVariable ["RYD_JR_Sitting",false],_sCargo,_driverOut,[]];											
							_gpData pushBack _data;
							deleteVehicle _asV
							}
						foreach _vehs;
															
						_x setVariable ["RYD_JR_GroupData",_gpData];
						};
						
					case (2) :
						{
						_checked = [];
						
							{
							_vh = vehicle _x;
							
							if not (_vh in _checked) then
								{
								_checked pushBack _vh;
								
								if not (_vh == _x) then
									{
										{
										_x enableSimulation false;
										_x hideObject true
										}
									foreach (crew _vh)
									};
								
								_vh enableSimulation false;
								_vh hideObject true
								}
							}
						foreach (units _x);
						};
					};
				
				if (RYD_JR_Debug) then
					{
					_mk setMarkerColor "ColorRed";
					};
				
				RYD_JR_cached pushBack _x;
				}
			}
		}
	foreach (_initAllEnemy - RYD_JR_AllHelis);

if (not (RYD_JR_isBlastcore) and {RYD_JR_HCDensityM > 0}) then
	{
	RYD_JR_CampFireSmoke_handle = [] spawn RYD_JR_CampfireSmoke
	};

RYD_JR_PCDisabled = false;

if not (RYD_JR_ShowLootMarkers in [-1,-0.5]) then
	{
	addMissionEventHandler ["Draw3D",RYD_JR_Icons3D]
	}
else
	{
	if (RYD_JR_ShowLootMarkers in [-0.5]) then
		{
		addMissionEventHandler ["Draw3D",RYD_JR_Icons3Dc]
		}
	};

if (RYD_JR_NoMarkers) then
	{
	[] spawn 
		{
		while {true} do
			{
			sleep 0.1;
			[] spawn RYD_JR_DisablePlayerCentering
			};
		};
	};
	
endloadingscreen;

_channelU = RYD_JR_Recruitable + [player,RYD_JR_Caller];

RYD_JR_Conv = radioChannelCreate [[1, 1, 1, 0.8], "RadioC", " ",_channelU, false];	
RYD_JR_RadioNeutral = radioChannelCreate [[1, 1, 0, 0.8], "RadioN", "RADIO:",_channelU, false];
RYD_JR_RadioAlarm = radioChannelCreate [[1, 0, 0, 0.8], "RadioA", "RADIO:",_channelU, false];
RYD_JR_RadioPhone = radioChannelCreate [[0, 1, 0, 0.8], "RadioP", "PHONE:",_channelU, false];
RYD_JR_RadioADMn = radioChannelCreate [[0, 1, 1, 0.8], "RadioADMn", "ADMclient - notifier_service (loc_filter: Altis):",_channelU, false];
RYD_JR_RadioADMa = radioChannelCreate [[1, 0, 1, 0.8], "RadioADMa", "ADMclient - auctioneer:",_channelU, false];

_allEnemies spawn RYD_JR_MainLoop;

RYD_JR_isPlaying = true;

RYD_JR_mHandle = ["EventTrack02_F_EPA",36] spawn
	{
	playMusic (_this select 0);
	
	sleep (_this select 1);
				
	RYD_JR_isPlaying = false;
	RYD_JR_LastPlay = time
	};

sleep 6;

_aPos = getPosATL player;
_aPos resize 2;

_wp setWaypointPosition [_aPos,0];

1800 setFog [0, 1, 0];

_hour = floor RYD_JR_Daytime;
_minute = (RYD_JR_Daytime - _hour) * 60;

setDate [2030, 6, 24, _hour, _minute];

//Titletext ["","BLACK IN", 3];

titleRsc ["PIL_LOGO","BLACK IN",3];

	{
	_wait = [_x,"PilgrimWait","","",""] call BIS_fnc_addCommMenuItem;
	_wait6 = [_x,"PilgrimWait6","","",""] call BIS_fnc_addCommMenuItem;
	_clean = [_x,"PilgrimClean","","",""] call BIS_fnc_addCommMenuItem;
	_as = [_x,"PilgrimAS","","",""] call BIS_fnc_addCommMenuItem;
	_ft = [_x,"PilgrimFT","","",""] call BIS_fnc_addCommMenuItem;
	}
foreach (RYD_JR_Recruitable + [player]);

2 fadeSound 1;

sleep 3;

enableRadio true;
enableSentences true;

sleep 0.25;

_text = format ["Good luck, %1!",profileName]; 

sleep 3;

Titletext  [_text,"PLAIN", 1];

RYD_JR_LoadTime = time;


/*
sleep 20;

if (RYD_JR_Debug) then
	{
	[] spawn 
		{
		while {true} do
			{
			sleep 1;
			
			hintSilent format ["Buildings: %1\nPositions: %2\nCivilians: %3 All: %4",count RYD_SCA_Buildings,count RYD_SCA_Positions,count RYD_SCA_Civilians,{not (isNull _x)} count RYD_SCA_NearCivilians];
			}
		}
	};*/

//[] execVM "CPULoadTest.sqf";
//[] execVM "BodyBoat.sqf";