/*
Needed Mods:
- None

Optional Mods:
- None
*/

// Enemy infantry classes
opfor_officer = "I_G_officer_F";											//Officer
opfor_squad_leader = "I_G_Soldier_SL_F";									//Squad Leader
opfor_team_leader = "I_G_Soldier_TL_F";									//Team Leader
opfor_sentry = "I_G_Soldier_lite_F";										//Rifleman (Lite)
opfor_rifleman = "I_G_Soldier_F";											//Rifleman
opfor_rpg = "rhsgref_ins_g_grenadier_rpg";											//Rifleman (LAT)
opfor_grenadier = "I_G_Soldier_GL_F";										//Grenadier
opfor_machinegunner = "I_G_Soldier_AR_F";									//Autorifleman
opfor_heavygunner = "I_G_Soldier_AR_F";									//Heavy Gunner
opfor_marksman = "I_G_Sharpshooter_F";										//Marksman
opfor_sharpshooter = "I_G_Sharpshooter_F";								//Sharpshooter
opfor_sniper = "I_G_Sharpshooter_F";											//Sniper
opfor_at = "I_G_Soldier_LAT2_F";											//AT Specialist
opfor_aa = "rhsgref_ins_g_specialist_aa";											//AA Specialist
opfor_medic = "I_G_medic_F";												//Combat Life Saver
opfor_engineer = "I_G_engineer_F";										//Engineer
opfor_paratrooper = "I_G_Soldier_F";									//Paratrooper

// Enemy vehicles used by secondary objectives.
opfor_mrap = "LOP_AM_OPF_Landrover";												//Ifrit
opfor_mrap_armed = "LOP_AM_OPF_Landrover_M2";									//Ifrit (HMG)
opfor_transport_helo = "O_Heli_Light_02_unarmed_F";						//Mi-290 Taru (Bench)
opfor_transport_truck = "rhsgref_ins_g_gaz66o";							//Tempest Transport (Covered)
opfor_ammobox_transport = "O_Truck_03_transport_F";						//Tempest Transport (Open) -> Has to be able to transport resource crates!
opfor_fuel_truck = "RHS_Ural_Fuel_VMF_01";									//Tempest Fuel
opfor_ammo_truck = "rhsgref_ins_gaz66_ammo";									//Tempest Ammo
opfor_fuel_container = "Land_Pod_Heli_Transport_04_fuel_F";				//Taru Fuel Pod
opfor_ammo_container = "Land_Pod_Heli_Transport_04_ammo_F";				//Taru Ammo Pod
opfor_flag = "Flag_FIA_F";												//CSAT Flag

/* Adding a value to these arrays below will add them to a one out of however many in the array, random pick chance.
Therefore, adding the same value twice or three times means they are more likely to be chosen more often. */

/* Militia infantry. Lightweight soldier classnames the game will pick from randomly as sector defenders.
Think of them like garrison or military police forces, which are more meant to control the local population instead of fighting enemy armies. */
militia_squad = [
	"I_G_Soldier_lite_F",														//Rifleman (Lite)
	"I_G_Soldier_lite_F",														//Rifleman (Lite)
	"I_G_Soldier_lite_F",														//Rifleman
	"I_G_Soldier_lite_F",														//Rifleman
	"I_G_Soldier_LAT2_F",													//Rifleman (AT)
	"I_G_Soldier_AR_F",													//Autorifleman
	"I_G_Sharpshooter_F",													//Marksman
	"I_G_medic_F",												//Medic
	"I_G_engineer_F"													//Engineer
];

// Militia vehicles. Lightweight vehicle classnames the game will pick from randomly as sector defenders.
militia_vehicles = [
	"LOP_UVF_Landrover_M2"													//Qilin (armed)
];

// All enemy vehicles that can spawn as sector defenders and patrols at high enemy combat readiness (aggression levels).
opfor_vehicles = [
	"LOP_AM_OPF_Landrover_M2",													//Ifrit (HMG)
	"LOP_AM_OPF_Landrover_M2",													//Ifrit (GMG)
	"LOP_AM_OPF_Landrover_M2",													//Ifrit (GMG)
	"LOP_AFR_OPF_T34",										//BTR-K Kamysh
	"rhsgref_ins_g_gaz66_zu23",											//ZSU-39 Tigris
	"rhsgref_ins_g_gaz66_zu23",											//ZSU-39 Tigris
	"LOP_TKA_T55",												//T-100 Varsuk
	"LOP_TKA_T55"													//T-100 Varsuk
];

// All enemy vehicles that can spawn as sector defenders and patrols but at a lower enemy combat readiness (aggression levels).
opfor_vehicles_low_intensity = [
	"LOP_AM_OPF_Landrover_M2",													//Ifrit (HMG)
	"LOP_AM_OPF_Landrover_M2",													//Ifrit (HMG)
	"LOP_AM_OPF_BTR60",											//MSE-3 Marid 
	"LOP_AFR_OPF_T34"											//BTR-K Kamysh
];

// All enemy vehicles that can spawn as battlegroups, either assaulting or as reinforcements, at high enemy combat readiness (aggression levels).
opfor_battlegroup_vehicles = [
	"LOP_AM_OPF_Landrover_M2",													//Ifrit (HMG)
	"LOP_AM_OPF_Landrover_M2",													//Ifrit (GMG)
	"LOP_AM_OPF_Landrover_M2",													//Ifrit (GMG)
	"rhsgref_ins_g_gaz66o",											//Tempest Transport
	"rhsgref_ins_g_gaz66o",												//Tempest Transport (Covered)
	"LOP_AFR_OPF_T34",										//BTR-K Kamysh
	"rhsgref_ins_g_gaz66_zu23",											//ZSU-39 Tigris
	"rhsgref_ins_g_gaz66_zu23",											//ZSU-39 Tigris
	"LOP_TKA_T55",												//T-100 Varsuk
	"LOP_TKA_T55",												//T-100 Varsuk
	"O_Heli_Light_02_dynamicLoadout_F",									//Po-30 Orca (Armed)
	"O_Heli_Light_02_dynamicLoadout_F",									//Po-30 Orca (Armed)
	"O_Heli_Light_02_unarmed_F",										//Mi-290 Taru (Bench)
	"rhsgref_cdf_Mi24D_early"									//Mi-48 Kajman
];

// All enemy vehicles that can spawn as battlegroups, either assaulting or as reinforcements, at lower enemy combat readiness (aggression levels).
opfor_battlegroup_vehicles_low_intensity = [
	"LOP_AM_OPF_Landrover_M2",													//Ifrit (HMG)
	"LOP_AM_OPF_Landrover_M2",													//Ifrit (HMG)
	"rhsgref_ins_g_gaz66o",											//Tempest Transport
	"LOP_AM_OPF_BTR60",											//MSE-3 Marid 
	"LOP_AFR_OPF_T34",										//BTR-K Kamysh
	"rhsgref_ins_g_gaz66_zu23",											//ZSU-39 Tigris
	"O_Heli_Light_02_dynamicLoadout_F",									//Po-30 Orca (Armed)
	"O_Heli_Light_02_unarmed_F"										//Mi-290 Taru (Bench)
];

/* All vehicles that spawn within battlegroups (see the above 2 arrays) and also hold 8 soldiers as passengers.
If something in this array can't hold all 8 soldiers then buggy behaviours may occur.	*/
opfor_troup_transports = [
	"rhsgref_ins_g_gaz66o",											//Tempest Transport
	"rhsgref_ins_g_gaz66o",												//Tempest Transport (Covered)
	"LOP_AM_OPF_BTR60",											//MSE-3 Marid 
	"O_Heli_Light_02_unarmed_F",										//Mi-290 Taru (Bench)
	"O_Heli_Light_02_unarmed_F"									//Po-30 Orca (Armed)
];

// Enemy rotary-wings that will need to spawn in flight.
opfor_choppers = [
	"O_Heli_Light_02_unarmed_F",										//Mi-290 Taru (Bench)
	"O_Heli_Light_02_dynamicLoadout_F",									//Po-30 Orca (Armed)
	"rhsgref_cdf_Mi24D_early"									//Mi-48 Kajman
];

// Enemy fixed-wings that will need to spawn in the air.
opfor_air = [
	"I_C_Plane_Civil_01_F",									//To-199 Neophron (CAS)
	"I_C_Plane_Civil_01_F"												//To-201 Shikra
];
