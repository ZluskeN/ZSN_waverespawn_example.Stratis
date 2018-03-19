[resistance,(paramsarray select 0),(paramsarray select 1)] remoteExec ["zsn_waverespawn", 2];
[west, 5, 6, true, true, west] remoteExec ["zsn_waverespawn", 2];
[east, 6, 5, true, true, east] remoteExec ["zsn_waverespawn", 2];

zsn_waverespawn = {
	params [
		["_zsn_side", west, [east]],			//Side to execute wave respawn for 		(SIDE, Default west)
		["_zsn_ws", 8, [9]],				//Size of respawn waves				(NUMBER, Default 8)
		["_zsn_wc", -1, [8]],				//Number of respawn waves 			(NUMBER, Default -1 = infinite)
		["_zsn_lo", false, [false]],			//new wave receives custom gear			(BOOLEAN, Default false)
		["_zsn_pvp", false, [true]],			//pvp or coop					(BOOLEAN, Default false = coop)
		["_zsn_rs", _this select 0, [east]]		//Side to execute wave respawn for 		(SIDE, Default same as _zsn_side)
	];
	zsn_pvp = _zsn_pvp;
	publicVariable "zsn_pvp";
	switch (_zsn_side) do {
		case east: {
			zsn_le = _zsn_lo;
			publicVariable "zsn_le";
			zsn_wce = _zsn_wc;
			publicVariable "zsn_wce";
			zsn_wse = _zsn_ws;
			publicVariable "zsn_wse";
			zsn_ers = _zsn_rs;
			if (!isNil ("zsn_est")) then {deleteVehicle zsn_est;};
			zsn_est = createTrigger ["EmptyDetector", getmarkerPos "respawn_east"];
			zsn_est setTriggerActivation ["civ", "PRESENT", true];
			if (zsn_ers == west) then {zsn_est setTriggerStatements ["isServer && (zsn_wce ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wse", "thisList call zsn_spawnwave_west;",""];};
			if (zsn_ers == east) then {zsn_est setTriggerStatements ["isServer && (zsn_wce ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wse", "thisList call zsn_spawnwave_east;",""];};
			if (zsn_ers == resistance) then {zsn_est setTriggerStatements ["isServer && (zsn_wce ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wse", "thisList call zsn_spawnwave_resistance;",""];};
			if (!isNil ("zsn_eft")) then {deleteVehicle zsn_eft;};
			zsn_eft = createTrigger ["EmptyDetector", getmarkerPos "respawn_east"];
			zsn_eft setTriggerActivation ["civ", "PRESENT", true];
            		zsn_eft setTriggerStatements ["isServer && {alive _x && Side _x == east} count (allPlayers - entities 'HeadlessClient_F') < 1 && {Side _x == civilian} count thislist >= 1", "[zsn_ers, thisList] call zsn_allplayersdead;",""];
		};
		case west: {
			zsn_lw = _zsn_lo;
			publicVariable "zsn_lw";
			zsn_wcw = _zsn_wc;
			publicVariable "zsn_wcw";
			zsn_wsw = _zsn_ws;
			publicVariable "zsn_wsw";
			zsn_wrs = _zsn_rs;
			if (!isNil ("zsn_wst")) then {deleteVehicle zsn_wst;};
			zsn_wst = createTrigger ["EmptyDetector", getmarkerPos "respawn_west"];
			zsn_wst setTriggerActivation ["civ", "PRESENT", true];
			if (zsn_wrs == west) then {zsn_wst setTriggerStatements ["isServer && (zsn_wcw ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wsw", "thisList call zsn_spawnwave_west;",""];};
			if (zsn_wrs == east) then {zsn_wst setTriggerStatements ["isServer && (zsn_wcw ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wsw", "thisList call zsn_spawnwave_east;",""];};
			if (zsn_wrs == resistance) then {zsn_wst setTriggerStatements ["isServer && (zsn_wcw ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wsw", "thisList call zsn_spawnwave_resistance;",""];};
			if (!isNil ("zsn_wft")) then {deleteVehicle zsn_wft;};
			zsn_wft = createTrigger ["EmptyDetector", getmarkerPos "respawn_west"];
			zsn_wft setTriggerActivation ["civ", "PRESENT", true];
            		zsn_wft setTriggerStatements ["isServer && {alive _x && Side _x == west} count (allPlayers - entities 'HeadlessClient_F') < 1 && {Side _x == civilian} count thislist >= 1", "[zsn_wrs, thisList] call zsn_allplayersdead;",""];
		};
		case resistance: {
			zsn_lg = _zsn_lo;
			publicVariable "zsn_lg";
			zsn_wcg = _zsn_wc;
			publicVariable "zsn_wcg";
			zsn_wsg = _zsn_ws;
			publicVariable "zsn_wsg";
			zsn_grs = _zsn_rs;
			if (!isNil ("zsn_gst")) then {deleteVehicle zsn_gst;};
			zsn_gst = createTrigger ["EmptyDetector", getmarkerPos "respawn_guerrila"];
			zsn_gst setTriggerActivation ["civ", "PRESENT", true];
			if (zsn_grs == west) then {zsn_gst setTriggerStatements ["isServer && (zsn_wcg ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wsg", "thisList call zsn_spawnwave_west;",""];};
			if (zsn_grs == east) then {zsn_gst setTriggerStatements ["isServer && (zsn_wcg ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wsg", "thisList call zsn_spawnwave_east;",""];};
			if (zsn_grs == resistance) then {zsn_gst setTriggerStatements ["isServer && (zsn_wcg ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wsg", "thisList call zsn_spawnwave_resistance;",""];};
			if (!isNil ("zsn_gft")) then {deleteVehicle zsn_gft;};
			zsn_gft = createTrigger ["EmptyDetector", getmarkerPos "respawn_guerrila"];
			zsn_gft setTriggerActivation ["civ", "PRESENT", true];
            		zsn_gft setTriggerStatements ["isServer && {alive _x && Side _x == resistance} count (allPlayers - entities 'HeadlessClient_F') < 1 && {Side _x == civilian} count thislist >= 1", "[zsn_grs, thisList] call zsn_allplayersdead;",""];
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
	params [
		["_zsn_side",""],
		["_zsn_list",""]
	];
	switch (_zsn_side) do {
		case east: {
			if ((zsn_wce ^ 2) >= 1) then {
				_zsn_list call zsn_spawnwave_east;
			} else {
				if (zsn_pvp) then {
					'SideScore' call BIS_fnc_endMissionServer;
				} else {
					'EveryoneLost' call BIS_fnc_endMissionServer;
				}
			}
		};
		case west: {
			if ((zsn_wcw ^ 2) >= 1) then {
				_zsn_list call zsn_spawnwave_west;
			} else {
				if (zsn_pvp) then {
					'SideScore' call BIS_fnc_endMissionServer;
				} else {
					'EveryoneLost' call BIS_fnc_endMissionServer;
				}
			}
		};
		case resistance: {
			if ((zsn_wcg ^ 2) >= 1) then {
				_zsn_list call zsn_spawnwave_resistance;
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
	private _zsn_list = _this;
	private _zsn_units = [];
	{if (_foreachindex < zsn_wse) then {_zsn_units pushback _x};} foreach _zsn_list;
	["", "BLACK OUT"] remoteexec ["titleText", _zsn_units];
	_players = _zsn_units apply {[ rankId _x, rating _x, _x ]};
	_players = _players - [ -1 ];
	_players sort false;
	_grp = createGroup east;
	{[_x select 2] join _grp} forEach _players;
	if (zsn_le) then {
		if (count _zsn_units > 0) then {[_players select 0 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_O_Soldier_SL_F"] call BIS_fnc_loadInventory; _players select 0 select 2 setUnitRank "SERGEANT";};
		if (count _zsn_units > 1) then {[_players select 1 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_O_Soldier_TL_F"] call BIS_fnc_loadInventory; _players select 1 select 2 setUnitRank "CORPORAL"; _players select 1 select 2 assignTeam "YELLOW";};
		if (count _zsn_units > 2) then {[_players select 2 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_O_Soldier_LAT_F"] call BIS_fnc_loadInventory; _players select 2 select 2 setUnitRank "PRIVATE"; _players select 2 select 2 assignTeam "BLUE";};
		if (count _zsn_units > 3) then {[_players select 3 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_O_Soldier_AR_F"] call BIS_fnc_loadInventory; _players select 3 select 2 setUnitRank "PRIVATE"; _players select 3 select 2 assignTeam "YELLOW";};
		if (count _zsn_units > 4) then {[_players select 4 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_O_Heavygunner_F"] call BIS_fnc_loadInventory; _players select 4 select 2 setUnitRank "PRIVATE"; _players select 4 select 2 assignTeam "BLUE";};
		if (count _zsn_units > 5) then {[_players select 5 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_O_Soldier_AT_F"] call BIS_fnc_loadInventory; _players select 5 select 2 setUnitRank "PRIVATE"; _players select 5 select 2 assignTeam "YELLOW";};
		if (count _zsn_units > 6) then {[_players select 6 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_O_Soldier_AAR_F"] call BIS_fnc_loadInventory; _players select 6 select 2 setUnitRank "PRIVATE"; _players select 6 select 2 assignTeam "BLUE";};
		if (count _zsn_units > 7) then {[_players select 7 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_O_Soldier_AAT_F"] call BIS_fnc_loadInventory; _players select 7 select 2 setUnitRank "PRIVATE"; _players select 7 select 2 assignTeam "YELLOW";};
		if (count _zsn_units > 8) then {[_players select 8 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_O_Soldier_TL_F"] call BIS_fnc_loadInventory; _players select 8 select 2 setUnitRank "CORPORAL"; _players select 8 select 2 assignTeam "BLUE";};
		_spawnvehicle = "O_LSV_02_Unarmed_F" createVehicle getpos zsn_respawn_east;
	};
	_highestRanked = _players select 0 select 2;
	[format ["%1 is the the squad leader, your callsign is %2", name _highestRanked, _grp]] remoteExec ["hint", _zsn_units];
	{_x setVehiclePosition [(getpos zsn_respawn_east), [], 4]} forEach _zsn_units;
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
		[player, false] remoteExec ["TFAR_fnc_forceSpectator", _zsn_units];
	};
	["Terminate"] remoteExec ["BIS_fnc_EGSpectator", _zsn_units];
	if (zsn_wce != 0) then {zsn_wce = zsn_wce - 1;};
	publicVariable "zsn_wce";
	["", "BLACK IN"] remoteexec ["titleText", _zsn_units];
};

zsn_spawnwave_west = {
	private _zsn_list = _this;
	private _zsn_units = [];
	{if (_foreachindex < zsn_wsw) then {_zsn_units pushback _x};} foreach _zsn_list;
	["", "BLACK OUT"] remoteexec ["titleText", _zsn_units];
	_players = _zsn_units apply {[ rankId _x, rating _x, _x ]};
	_players = _players - [ -1 ];
	_players sort false;
	_grp = createGroup west;
	{[_x select 2] join _grp} forEach _players;
	if (zsn_lw) then {
		if (count _zsn_units > 0) then {[_players select 0 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_B_Soldier_SL_F"] call BIS_fnc_loadInventory; _players select 0 select 2 setUnitRank "SERGEANT";};
		if (count _zsn_units > 1) then {[_players select 1 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_B_Soldier_TL_F"] call BIS_fnc_loadInventory; _players select 1 select 2 setUnitRank "CORPORAL"; _players select 1 select 2 assignTeam "YELLOW";};
		if (count _zsn_units > 2) then {[_players select 2 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_B_Soldier_LAT_F"] call BIS_fnc_loadInventory; _players select 2 select 2 setUnitRank "PRIVATE"; _players select 2 select 2 assignTeam "BLUE";};
		if (count _zsn_units > 3) then {[_players select 3 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_B_Soldier_AR_F"] call BIS_fnc_loadInventory; _players select 3 select 2 setUnitRank "PRIVATE"; _players select 3 select 2 assignTeam "YELLOW";};
		if (count _zsn_units > 4) then {[_players select 4 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_B_Heavygunner_F"] call BIS_fnc_loadInventory; _players select 4 select 2 setUnitRank "PRIVATE"; _players select 4 select 2 assignTeam "BLUE";};
		if (count _zsn_units > 5) then {[_players select 5 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_B_Soldier_AT_F"] call BIS_fnc_loadInventory; _players select 5 select 2 setUnitRank "PRIVATE"; _players select 5 select 2 assignTeam "YELLOW";};
		if (count _zsn_units > 6) then {[_players select 6 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_B_Soldier_AAR_F"] call BIS_fnc_loadInventory; _players select 6 select 2 setUnitRank "PRIVATE"; _players select 6 select 2 assignTeam "BLUE";};
		if (count _zsn_units > 7) then {[_players select 7 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_B_Soldier_AAT_F"] call BIS_fnc_loadInventory; _players select 7 select 2 setUnitRank "PRIVATE"; _players select 7 select 2 assignTeam "YELLOW";};
		if (count _zsn_units > 8) then {[_players select 8 select 2, missionconfigfile >> "CfgRespawnInventory" >> "ZSN_B_Soldier_TL_F"] call BIS_fnc_loadInventory; _players select 8 select 2 setUnitRank "CORPORAL"; _players select 8 select 2 assignTeam "BLUE";};
		_spawnvehicle = "B_LSV_01_Unarmed_F" createVehicle getpos zsn_respawn_west;
	};
	_highestRanked = _players select 0 select 2;
	[format ["%1 is the the squad leader, your callsign is %2", name _highestRanked, _grp]] remoteExec ["hint", _zsn_units];
	{_x setVehiclePosition [(getpos zsn_respawn_west), [], 4]} forEach _zsn_units;
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
		[player, false] remoteExec ["TFAR_fnc_forceSpectator", _zsn_units];
	};
	["Terminate"] remoteExec ["BIS_fnc_EGSpectator", _zsn_units];
	if (zsn_wcw != 0) then {zsn_wcw = zsn_wcw - 1;};
	publicVariable "zsn_wcw";
	["", "BLACK IN"] remoteexec ["titleText",  _zsn_units]; 	
};

zsn_spawnwave_resistance = {
	private _zsn_list = _this;
	private _zsn_units = [];
	{if (_foreachindex < zsn_wsg) then {_zsn_units pushback _x};} foreach _zsn_list;
	["", "BLACK OUT"] remoteexec ["titleText", _zsn_units];
	_players = _zsn_units apply {[ rankId _x, rating _x, _x ]};
	_players = _players - [ -1 ];
	_players sort false;
	_grp = createGroup resistance;
	{[_x select 2] join _grp} forEach _players;
	if (zsn_lg) then {
		if (count _zsn_units > 0) then {[_players select 0 select 2, configfile >> "CfgVehicles" >> "I_Soldier_SL_F"] call BIS_fnc_loadInventory; _players select 0 select 2 setUnitRank "SERGEANT";};
		if (count _zsn_units > 1) then {[_players select 1 select 2, configfile >> "CfgVehicles" >> "I_Soldier_TL_F"] call BIS_fnc_loadInventory; _players select 1 select 2 setUnitRank "CORPORAL"; _players select 1 select 2 assignTeam "YELLOW";};
		if (count _zsn_units > 2) then {[_players select 2 select 2, configfile >> "CfgVehicles" >> "I_Soldier_LAT_F"] call BIS_fnc_loadInventory; _players select 2 select 2 setUnitRank "PRIVATE"; _players select 2 select 2 assignTeam "BLUE";};
		if (count _zsn_units > 3) then {[_players select 3 select 2, configfile >> "CfgVehicles" >> "I_Soldier_AR_F"] call BIS_fnc_loadInventory; _players select 3 select 2 setUnitRank "PRIVATE"; _players select 3 select 2 assignTeam "YELLOW";};
		if (count _zsn_units > 4) then {[_players select 4 select 2, configfile >> "CfgVehicles" >> "I_Soldier_M_F"] call BIS_fnc_loadInventory; _players select 4 select 2 setUnitRank "PRIVATE"; _players select 4 select 2 assignTeam "BLUE";};
		if (count _zsn_units > 5) then {[_players select 5 select 2, configfile >> "CfgVehicles" >> "I_Soldier_AT_F"] call BIS_fnc_loadInventory; _players select 5 select 2 setUnitRank "PRIVATE"; _players select 5 select 2 assignTeam "YELLOW";};
		if (count _zsn_units > 6) then {[_players select 6 select 2, configfile >> "CfgVehicles" >> "I_Soldier_A_F"] call BIS_fnc_loadInventory; _players select 6 select 2 setUnitRank "PRIVATE"; _players select 6 select 2 assignTeam "BLUE";};
		if (count _zsn_units > 7) then {[_players select 7 select 2, configfile >> "CfgVehicles" >> "I_Soldier_AAT_F"] call BIS_fnc_loadInventory; _players select 7 select 2 setUnitRank "PRIVATE"; _players select 7 select 2 assignTeam "YELLOW";};
		if (count _zsn_units > 8) then {[_players select 8 select 2, configfile >> "CfgVehicles" >> "I_Soldier_TL_F"] call BIS_fnc_loadInventory; _players select 8 select 2 setUnitRank "CORPORAL"; _players select 8 select 2 assignTeam "BLUE";};
		_spawnvehicle = "I_G_Offroad_01_F" createVehicle getpos zsn_respawn_guerrila;
	};
	_highestRanked = _players select 0 select 2;
	[format ["%1 is the the squad leader, your callsign is %2", name _highestRanked, _grp]] remoteExec ["hint", _zsn_units];
	{_x setVehiclePosition [(getpos zsn_respawn_guerrila), [], 4]} forEach _zsn_units;
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
		[player, false] remoteExec ["TFAR_fnc_forceSpectator", _zsn_units];
	};
	["Terminate"] remoteExec ["BIS_fnc_EGSpectator", _zsn_units];
	if (zsn_wcg != 0) then {zsn_wcg = zsn_wcg - 1;};
	publicVariable "zsn_wcg";
	["", "BLACK IN"] remoteexec ["titleText", _zsn_units];
};