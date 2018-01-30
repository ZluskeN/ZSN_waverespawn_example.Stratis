[resistance] remoteExec ["zsn_waverespawn", 2];
[west, (paramsarray select 0), (paramsarray select 1), true, true, west] remoteExec ["zsn_waverespawn", 2];
[east, (paramsarray select 2), (paramsarray select 3), true, true, east] remoteExec ["zsn_waverespawn", 2];

zsn_waverespawn = {
	params [
		["_zsn_side", west, [east]],			//Side to execute wave respawn for 		(SIDE, Default west)
		["_zsn_wavesize", 9, [8]],			//Size of respawn waves				(NUMBER, Default 4)
		["_zsn_wavecount", -1, [8]],			//Number of respawn waves 			(NUMBER, Default -1 = infinite)
		["_zsn_loadout", false, [false]],		//new wave receives custom gear			(BOOLEAN, Default true)
		["_zsn_pvp", false, [true]],			//pvp or coop					(BOOLEAN, Default false = coop)
		["_zsn_respawnside", _this select 0, [east]]	//Side to execute wave respawn for 		(SIDE, Default same as _zsn_side)
	];
	zsn_pvp = _zsn_pvp;
	publicVariable "zsn_pvp";
	switch (_zsn_side) do {
		case east: {
			zsn_loadout_east = _zsn_loadout;
			publicVariable "zsn_loadout_east";
			zsn_wavecount_east = _zsn_wavecount;
			publicVariable "zsn_wavecount_east";
			zsn_wavesize_east = _zsn_wavesize;
			publicVariable "zsn_wavesize_east";
			if (!isNil ("zsn_espawn_trg")) then {deleteVehicle zsn_espawn_trg;};
			zsn_espawn_trg = createTrigger ["EmptyDetector", getmarkerPos "respawn_east"];
			zsn_espawn_trg setTriggerActivation ["civ", "PRESENT", true];
			if (_zsn_respawnside == west) then {zsn_espawn_trg setTriggerStatements ["isServer && (zsn_wavecount_east ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wavesize_east", "thisList call zsn_spawnwave_west;",""];};
			if (_zsn_respawnside == east) then {zsn_espawn_trg setTriggerStatements ["isServer && (zsn_wavecount_east ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wavesize_east", "thisList call zsn_spawnwave_east;",""];};
			if (_zsn_respawnside == resistance) then {zsn_espawn_trg setTriggerStatements ["isServer && (zsn_wavecount_east ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wavesize_east", "thisList call zsn_spawnwave_resistance;",""];};
			if (!isNil ("zsn_efail_trg")) then {deleteVehicle zsn_efail_trg;};
			zsn_efail_trg = createTrigger ["EmptyDetector", getmarkerPos "respawn_east"];
			zsn_efail_trg setTriggerActivation ["civ", "PRESENT", true];
            		zsn_efail_trg setTriggerStatements ["isServer && {alive _x && Side _x == east} count (allPlayers - entities 'HeadlessClient_F') < 1 && {Side _x == civilian} count thislist >= 1", "[east, thisList] call zsn_allplayersdead;",""];
		};
		case west: {
			zsn_loadout_west = _zsn_loadout;
			publicVariable "zsn_loadout_west";
			zsn_wavecount_west = _zsn_wavecount;
			publicVariable "zsn_wavecount_west";
			zsn_wavesize_west = _zsn_wavesize;
			publicVariable "zsn_wavesize_west";
			if (!isNil ("zsn_wspawn_trg")) then {deleteVehicle zsn_wspawn_trg;};
			zsn_wspawn_trg = createTrigger ["EmptyDetector", getmarkerPos "respawn_west"];
			zsn_wspawn_trg setTriggerActivation ["civ", "PRESENT", true];
			if (_zsn_respawnside == west) then {zsn_wspawn_trg setTriggerStatements ["isServer && (zsn_wavecount_west ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wavesize_west", "thisList call zsn_spawnwave_west;",""];};
			if (_zsn_respawnside == east) then {zsn_wspawn_trg setTriggerStatements ["isServer && (zsn_wavecount_west ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wavesize_west", "thisList call zsn_spawnwave_east;",""];};
			if (_zsn_respawnside == resistance) then {zsn_wspawn_trg setTriggerStatements ["isServer && (zsn_wavecount_west ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wavesize_west", "thisList call zsn_spawnwave_resistance;",""];};
			if (!isNil ("zsn_wfail_trg")) then {deleteVehicle zsn_wfail_trg;};
			zsn_wfail_trg = createTrigger ["EmptyDetector", getmarkerPos "respawn_west"];
			zsn_wfail_trg setTriggerActivation ["civ", "PRESENT", true];
            		zsn_wfail_trg setTriggerStatements ["isServer && {alive _x && Side _x == west} count (allPlayers - entities 'HeadlessClient_F') < 1 && {Side _x == civilian} count thislist >= 1", "[west, thisList] call zsn_allplayersdead;",""];
		};
		case resistance: {
			zsn_loadout_resistance = _zsn_loadout;
			publicVariable "zsn_loadout_resistance";
			zsn_wavecount_resistance = _zsn_wavecount;
			publicVariable "zsn_wavecount_resistance";
			zsn_wavesize_resistance = _zsn_wavesize;
			publicVariable "zsn_wavesize_resistance";
			if (!isNil ("zsn_gspawn_trg")) then {deleteVehicle zsn_gspawn_trg;};
			zsn_gspawn_trg = createTrigger ["EmptyDetector", getmarkerPos "respawn_guerrila"];
			zsn_gspawn_trg setTriggerActivation ["civ", "PRESENT", true];
			if (_zsn_respawnside == west) then {zsn_gspawn_trg setTriggerStatements ["isServer && (zsn_wavecount_resistance ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wavesize_resistance", "thisList call zsn_spawnwave_west;",""];};
			if (_zsn_respawnside == east) then {zsn_gspawn_trg setTriggerStatements ["isServer && (zsn_wavecount_resistance ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wavesize_resistance", "thisList call zsn_spawnwave_east;",""];};
			if (_zsn_respawnside == resistance) then {zsn_gspawn_trg setTriggerStatements ["isServer && (zsn_wavecount_resistance ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wavesize_resistance", "thisList call zsn_spawnwave_resistance;",""];};
			if (!isNil ("zsn_gfail_trg")) then {deleteVehicle zsn_gfail_trg;};
			zsn_gfail_trg = createTrigger ["EmptyDetector", getmarkerPos "respawn_guerrila"];
			zsn_gfail_trg setTriggerActivation ["civ", "PRESENT", true];
            		zsn_gfail_trg setTriggerStatements ["isServer && {alive _x && Side _x == resistance} count (allPlayers - entities 'HeadlessClient_F') < 1 && {Side _x == civilian} count thislist >= 1", "[resistance, thisList] call zsn_allplayersdead;",""];
		};
	};
	addMissionEventHandler ["entityKilled", {
		params ["_unit"]; 
		if (!isPlayer _unit) then {
			_unit setVariable ["loadout", getUnitLoadout _unit]
    		};
  	}];
	addMissionEventHandler ["entityRespawned", {
		params ["_unit"];
		if (!isPlayer _unit) then {
			[_unit] join createGroup CIVILIAN;
			_unit setUnitLoadout (_unit getVariable "loadout")
		};
	}];
};

zsn_allplayersdead = {
	params ["_zsn_side","_zsn_thislist"];
	switch (_zsn_side) do {
		case east: {
			if ((zsn_wavecount_east ^ 2) >= 1) then {
				(_zsn_thislist) call zsn_spawnwave_east;
			} else {
				if (zsn_pvp) then {
					'SideScore' call BIS_fnc_endMissionServer;
				} else {
					'EveryoneLost' call BIS_fnc_endMissionServer;
				}
			}
		};
		case west: {
			if ((zsn_wavecount_west ^ 2) >= 1) then {
				(_zsn_thislist) call zsn_spawnwave_west;
			} else {
				if (zsn_pvp) then {
					'SideScore' call BIS_fnc_endMissionServer;
				} else {
					'EveryoneLost' call BIS_fnc_endMissionServer;
				}
			}
		};
		case resistance: {
			if ((zsn_wavecount_resistance ^ 2) >= 1) then {
				(_zsn_thislist) call zsn_spawnwave_resistance;
			} else {
				if (zsn_pvp) then {
					'SideScore' call BIS_fnc_endMissionServer;
				} else {
					'EveryoneLost' call BIS_fnc_endMissionServer;
				};
			};
		};
	};
};

zsn_spawnwave_east = {
	params ["_zsn_thislist"];
	["", "BLACK OUT"] remoteexec ["titleText", _zsn_thislist];
	_players = _zsn_thislist apply {[ rankId _x, rating _x, _x ]};
	_players = _players - [ -1 ];
	_players sort false;
	_grp = createGroup east;
	{[_x select 2] join _grp} forEach _players;
	if (zsn_loadout_east) then {
		if (count _units > 0) then {[_players select 0 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_O_Soldier_SL_F"] call BIS_fnc_loadInventory;};
		if (count _units > 1) then {[_players select 1 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_O_Soldier_TL_F"] call BIS_fnc_loadInventory; _players select 1 select 2 assignTeam "YELLOW";};
		if (count _units > 2) then {[_players select 2 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_O_Soldier_LAT_F"] call BIS_fnc_loadInventory; _players select 2 select 2 assignTeam "BLUE";};
		if (count _units > 3) then {[_players select 3 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_O_Soldier_AR_F"] call BIS_fnc_loadInventory; _players select 3 select 2 assignTeam "YELLOW";};
		if (count _units > 4) then {[_players select 4 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_O_Heavygunner_F"] call BIS_fnc_loadInventory; _players select 4 select 2 assignTeam "BLUE";};
		if (count _units > 5) then {[_players select 5 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_O_Soldier_AT_F"] call BIS_fnc_loadInventory; _players select 5 select 2 assignTeam "YELLOW";};
		if (count _units > 6) then {[_players select 6 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_O_Soldier_AAR_F"] call BIS_fnc_loadInventory; _players select 6 select 2 assignTeam "BLUE";};
		if (count _units > 7) then {[_players select 7 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_O_Soldier_AAT_F"] call BIS_fnc_loadInventory; _players select 7 select 2 assignTeam "YELLOW";};
		if (count _units > 8) then {[_players select 8 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_O_Soldier_TL_F"] call BIS_fnc_loadInventory; _players select 8 select 2 assignTeam "BLUE";};
		_spawnvehicle = "O_LSV_02_Unarmed_F" createVehicle getpos zsn_respawn_east;
	};
	_highestRanked = _players select 0 select 2;
	[format ["%1 is the the squad leader, your callsign is %2", name _highestRanked, _grp]] remoteExec ["hint", _zsn_thislist];
	{_x setVehiclePosition [(getpos zsn_respawn_east), [], 4]} forEach _zsn_thislist;
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
		[player, false] remoteExec ["TFAR_fnc_forceSpectator", _zsn_thislist];
	};
	["Terminate"] remoteExec ["BIS_fnc_EGSpectator", _zsn_thislist];
	zsn_wavecount_east = zsn_wavecount_east - 1;
	publicVariable "zsn_wavecount_east";
	["", "BLACK IN"] remoteexec ["titleText", _zsn_thislist];
};

zsn_spawnwave_west = {
	params ["_zsn_thislist"];
	["", "BLACK OUT"] remoteexec ["titleText", _zsn_thislist];
	_players = _zsn_thislist apply {[ rankId _x, rating _x, _x ]};
	_players = _players - [ -1 ];
	_players sort false;
	_grp = createGroup west;
	{[_x select 2] join _grp} forEach _players;
	if (zsn_loadout_west) then {
		if (count _units > 0) then {[_players select 0 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_B_Soldier_SL_F"] call BIS_fnc_loadInventory;};
		if (count _units > 1) then {[_players select 1 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_B_Soldier_TL_F"] call BIS_fnc_loadInventory; _players select 1 select 2 assignTeam "YELLOW";};
		if (count _units > 2) then {[_players select 2 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_B_Soldier_LAT_F"] call BIS_fnc_loadInventory; _players select 2 select 2 assignTeam "BLUE";};
		if (count _units > 3) then {[_players select 3 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_B_Soldier_AR_F"] call BIS_fnc_loadInventory; _players select 3 select 2 assignTeam "YELLOW";};
		if (count _units > 4) then {[_players select 4 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_B_Heavygunner_F"] call BIS_fnc_loadInventory; _players select 4 select 2 assignTeam "BLUE";};
		if (count _units > 5) then {[_players select 5 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_B_Soldier_AT_F"] call BIS_fnc_loadInventory; _players select 5 select 2 assignTeam "YELLOW";};
		if (count _units > 6) then {[_players select 6 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_B_Soldier_AAR_F"] call BIS_fnc_loadInventory; _players select 6 select 2 assignTeam "BLUE";};
		if (count _units > 7) then {[_players select 7 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_B_Soldier_AAT_F"] call BIS_fnc_loadInventory; _players select 7 select 2 assignTeam "YELLOW";};
		if (count _units > 8) then {[_players select 8 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_B_Soldier_TL_F"] call BIS_fnc_loadInventory; _players select 8 select 2 assignTeam "BLUE";};
		_spawnvehicle = "B_LSV_01_Unarmed_F" createVehicle getpos zsn_respawn_west;
	};
	_highestRanked = _players select 0 select 2;
	[format ["%1 is the the squad leader, your callsign is %2", name _highestRanked, _grp]] remoteExec ["hint", _zsn_thislist];
	{_x setVehiclePosition [(getpos zsn_respawn_west), [], 4]} forEach _zsn_thislist;
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
		[player, false] remoteExec ["TFAR_fnc_forceSpectator", _zsn_thislist];
	};
	["Terminate"] remoteExec ["BIS_fnc_EGSpectator", _zsn_thislist];
	zsn_wavecount_west = zsn_wavecount_west - 1;
	publicVariable "zsn_wavecount_west";
	["", "BLACK IN"] remoteexec ["titleText",  _zsn_thislist]; 	
};

zsn_spawnwave_resistance = {
	params ["_zsn_thislist"];
	["", "BLACK OUT"] remoteexec ["titleText", _zsn_thislist];
	_players = _zsn_thislist apply {[ rankId _x, rating _x, _x ]};
	_players = _players - [ -1 ];
	_players sort false;
	_grp = createGroup resistance;
	{[_x select 2] join _grp} forEach _players;
	if (zsn_loadout_resistance) then {
		if (count _units > 0) then {[_players select 0 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_I_Soldier_SL_F"] call BIS_fnc_loadInventory;};
		if (count _units > 1) then {[_players select 1 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_I_Soldier_TL_F"] call BIS_fnc_loadInventory; _players select 1 select 2 assignTeam "YELLOW";};
		if (count _units > 2) then {[_players select 2 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_I_Soldier_LAT_F"] call BIS_fnc_loadInventory; _players select 2 select 2 assignTeam "BLUE";};
		if (count _units > 3) then {[_players select 3 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_I_Soldier_AR_F"] call BIS_fnc_loadInventory; _players select 3 select 2 assignTeam "YELLOW";};
		if (count _units > 4) then {[_players select 4 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_I_Soldier_M_F"] call BIS_fnc_loadInventory; _players select 4 select 2 assignTeam "BLUE";};
		if (count _units > 5) then {[_players select 5 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_I_Soldier_AT_F"] call BIS_fnc_loadInventory; _players select 5 select 2 assignTeam "YELLOW";};
		if (count _units > 6) then {[_players select 6 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_I_Soldier_A_F"] call BIS_fnc_loadInventory; _players select 6 select 2 assignTeam "BLUE";};
		if (count _units > 7) then {[_players select 7 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_I_Soldier_AAT_F"] call BIS_fnc_loadInventory; _players select 7 select 2 assignTeam "YELLOW";};
		if (count _units > 8) then {[_players select 8 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_I_Soldier_TL_F"] call BIS_fnc_loadInventory; _players select 8 select 2 assignTeam "BLUE";};
		_spawnvehicle = "I_G_Offroad_01_F" createVehicle getpos zsn_respawn_guerrila;
	};
	_highestRanked = _players select 0 select 2;
	[format ["%1 is the the squad leader, your callsign is %2", name _highestRanked, _grp]] remoteExec ["hint", _zsn_thislist];
	{_x setVehiclePosition [(getpos zsn_respawn_guerrila), [], 4]} forEach _zsn_thislist;
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
		[player, false] remoteExec ["TFAR_fnc_forceSpectator", _zsn_thislist];
	};
	["Terminate"] remoteExec ["BIS_fnc_EGSpectator", _zsn_thislist];
	zsn_wavecount_resistance = zsn_wavecount_resistance - 1;
	publicVariable "zsn_wavecount_resistance";
	["", "BLACK IN"] remoteexec ["titleText", _zsn_thislist];
};
