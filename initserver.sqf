// Initial init for wave respawn, run for the side or sides you want to use wave respawn for, this example is for all sides, resistance uses custom mission parameters that can be set in the lobby
[east, 6, 5, true] remoteexec ["zsn_fnc_waverespawn", 2];
[west, 5, 6, true] remoteexec ["zsn_fnc_waverespawn", 2];
[resistance,(paramsarray select 0),(paramsarray select 1)] remoteexec ["zsn_fnc_waverespawn", 2];

// If the fourth param is "true" you can define custom loadouts for the new wave below. Either from description.ext or config
zsn_eloadouts = [
	"ZSN_O_Squadleader",	//Custom loadout for squad leader, will be given sergeant rank
	"ZSN_O_Teamleader",	//Custom loadout tor team leader, will be given corporal rank and assigned fire team 1
	"ZSN_O_Soldier1",	//Custom loadout for soldier, will be given private rank and assigned fire team 2
	"ZSN_O_Soldier2",	//Custom loadout for soldier, will be given private rank and assigned fire team 1
	"ZSN_O_Soldier3",	//Custom loadout for soldier, will be given private rank and assigned fire team 2
	"ZSN_O_Soldier4",	//Custom loadout for soldier, will be given private rank and assigned fire team 1
	"ZSN_O_Soldier5",	//Custom loadout for soldier, will be given private rank and assigned fire team 2
	"ZSN_O_Soldier6",	//Custom loadout for soldier, will be given private rank and assigned fire team 1
	"ZSN_O_Teamleader",	//Custom loadout for team leader 2, will be given corporal rank and assigned fire team 2
	"ZSN_O_Medic"		//Custom loadout for squad medic, will be assigned team red and made "attendant"
];
zsn_wloadouts = [
	"ZSN_B_Squadleader",	//Custom loadout for squad leader, will be given sergeant rank
	"ZSN_B_Teamleader",	//Custom loadout tor team leader, will be given corporal rank and assigned fire team 1
	"ZSN_B_Soldier1",	//Custom loadout for soldier, will be given private rank and assigned fire team 2
	"ZSN_B_Soldier2",	//Custom loadout for soldier, will be given private rank and assigned fire team 1
	"ZSN_B_Soldier3",	//Custom loadout for soldier, will be given private rank and assigned fire team 2
	"ZSN_B_Soldier4",	//Custom loadout for soldier, will be given private rank and assigned fire team 1
	"ZSN_B_Soldier5",	//Custom loadout for soldier, will be given private rank and assigned fire team 2
	"ZSN_B_Soldier6",	//Custom loadout for soldier, will be given private rank and assigned fire team 1
	"ZSN_B_Teamleader",	//Custom loadout for team leader 2, will be given corporal rank and assigned fire team 2
	"ZSN_B_Medic"		//Custom loadout for squad medic, will be assigned team red and made "attendant"
];
zsn_gloadouts = [
	"I_Soldier_SL_F",	//Custom loadout for squad leader, will be given sergeant rank
	"I_Soldier_TL_F",	//Custom loadout tor team leader, will be given corporal rank and assigned fire team 1
	"I_Soldier_LAT_F",	//Custom loadout for soldier, will be given private rank and assigned fire team 2
	"I_Soldier_M_F",	//Custom loadout for soldier, will be given private rank and assigned fire team 1
	"I_Soldier_AR_F",	//Custom loadout for soldier, will be given private rank and assigned fire team 2
	"I_Soldier_LAT2_F",	//Custom loadout for soldier, will be given private rank and assigned fire team 1
	"I_Soldier_AAR_F",	//Custom loadout for soldier, will be given private rank and assigned fire team 2
	"I_Soldier_A_F",	//Custom loadout for soldier, will be given private rank and assigned fire team 1
	"I_Soldier_TL_F",	//Custom loadout for team leader 2, will be given corporal rank and assigned fire team 2
	"I_medic_F"		//Custom loadout for squad medic, will be assigned team red and made "attendant"
];

// This is for when you want to spawn in the wave upon some custom mission condition rather than player count
zsn_spawnconditions = [
	"false",		//Custom spawn condition for REDFOR
	"false",		//Custom spawn condition for BLUFOR
	"false"			//Custom spawn condition for INDEP
];

zsn_ect = createTrigger ["EmptyDetector", getmarkerPos "respawn_east"];
zsn_ect setTriggerActivation ["civ", "PRESENT", true];
zsn_ect setTriggerStatements [zsn_spawnconditions select 0, "thisList call zsn_fnc_spawnwave_east;",""];

zsn_wct = createTrigger ["EmptyDetector", getmarkerPos "respawn_west"];
zsn_wct setTriggerActivation ["civ", "PRESENT", true];
zsn_wct setTriggerStatements [zsn_spawnconditions select 1, "thisList call zsn_fnc_spawnwave_west;",""];

zsn_gct = createTrigger ["EmptyDetector", getmarkerPos "respawn_guerrila"];
zsn_gct setTriggerActivation ["civ", "PRESENT", true];
zsn_gct setTriggerStatements [zsn_spawnconditions select 2, "thisList call zsn_fnc_spawnwave_resistance;",""];

// This the player inits that run client-side on mission start (safetyfirst is the infamous safety vest script)
remoteexec ["zsn_fnc_localplayerinit", 0, true];
remoteexec ["zsn_fnc_safetyfirst", -2];
