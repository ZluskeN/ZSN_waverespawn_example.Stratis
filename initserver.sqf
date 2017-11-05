[resistance] remoteExec ["zsn_waverespawn", 2];
[west, 2, 6, false, true] remoteExec ["zsn_waverespawn", 2];
[east, 3, 4, false, true] remoteExec ["zsn_waverespawn", 2];

zsn_waverespawn = {
	params [
		["_zsn_side", west, [east]],	//Side to execute wave respawn for 		(SIDE, Default west)
		["_zsn_wavesize", 4, [8]],	//Size of respawn waves				(NUMBER, Default 4)
		["_zsn_wavecount", -1, [8]],	//Number of respawn waves 			(NUMBER, Default -1 = infinite)
		["_zsn_radio", true, [false]],	//Equip leader of new wave with itemradio	(BOOLEAN, Default true)
		["_zsn_pvp", false, [true]]	//pvp or coop					(BOOLEAN, Default false = coop)
	];
	switch (_zsn_side) do {
		case east: {
			zsn_radio_east = _zsn_radio;
			publicVariable "zsn_radio_east";
			zsn_wavecount_east = _zsn_wavecount;
			publicVariable "zsn_wavecount_east";
			zsn_wavesize_east = _zsn_wavesize;
			publicVariable "zsn_wavesize_east";
			if (!isNil ("zsn_espawn_trg")) then {deleteVehicle zsn_espawn_trg;};
			zsn_espawn_trg = createTrigger ["EmptyDetector", getmarkerPos "respawn_east"];
			zsn_espawn_trg setTriggerActivation ["civ", "PRESENT", true];
			zsn_espawn_trg setTriggerStatements ["isServer && {Side _x == civilian} count thislist >= zsn_wavesize_east && (zsn_wavecount_east ^ 2) >= 1", "thisList call zsn_spawnwave_east;",""];
			if (!isNil ("zsn_efail_trg")) then {deleteVehicle zsn_efail_trg;};
			zsn_efail_trg = createTrigger ["EmptyDetector", getmarkerPos "respawn_east"];
			zsn_efail_trg setTriggerActivation ["civ", "PRESENT", true];
			if (_zsn_pvp) then {
				zsn_efail_trg setTriggerStatements ["isServer && {alive _x && Side _x == east} count (allPlayers - entities 'HeadlessClient_F') < 1 && (zsn_wavecount_east ^ 2) < 1", "'SideScore' call BIS_fnc_endMissionServer;",""];
			} else {
				zsn_efail_trg setTriggerStatements ["isServer && {alive _x && Side _x == east} count (allPlayers - entities 'HeadlessClient_F') < 1 && (zsn_wavecount_east ^ 2) < 1", "'EveryoneLost' call BIS_fnc_endMissionServer;",""];
			};
		};
		case west: {
			zsn_radio_west = _zsn_radio;
			publicVariable "zsn_radio_west";
			zsn_wavecount_west = _zsn_wavecount;
			publicVariable "zsn_wavecount_west";
			zsn_wavesize_west = _zsn_wavesize;
			publicVariable "zsn_wavesize_west";
			if (!isNil ("zsn_wspawn_trg")) then {deleteVehicle zsn_wspawn_trg;};
			zsn_wspawn_trg = createTrigger ["EmptyDetector", getmarkerPos "respawn_west"];
			zsn_wspawn_trg setTriggerActivation ["civ", "PRESENT", true];
			zsn_wspawn_trg setTriggerStatements ["isServer && {Side _x == civilian} count thislist >= zsn_wavesize_west && (zsn_wavecount_west ^ 2) >= 1", "thisList call zsn_spawnwave_west;",""];
			if (!isNil ("zsn_wfail_trg")) then {deleteVehicle zsn_wfail_trg;};
			zsn_wfail_trg = createTrigger ["EmptyDetector", getmarkerPos "respawn_west"];
			zsn_wfail_trg setTriggerActivation ["civ", "PRESENT", true];
			if (_zsn_pvp) then {
            			zsn_wfail_trg setTriggerStatements ["isServer && {alive _x && Side _x == west} count (allPlayers - entities 'HeadlessClient_F') < 1 && (zsn_wavecount_west ^ 2) < 1", "'SideScore' call BIS_fnc_endMissionServer;",""];
			} else {
            			zsn_wfail_trg setTriggerStatements ["isServer && {alive _x && Side _x == west} count (allPlayers - entities 'HeadlessClient_F') < 1 && (zsn_wavecount_west ^ 2) < 1", "'EveryoneLost' call BIS_fnc_endMissionServer;",""];
			};
		};
		case resistance: {
			zsn_radio_resistance = _zsn_radio;
			publicVariable "zsn_radio_resistance";
			zsn_wavecount_resistance = _zsn_wavecount;
			publicVariable "zsn_wavecount_resistance";
			zsn_wavesize_resistance = _zsn_wavesize;
			publicVariable "zsn_wavesize_resistance";
			if (!isNil ("zsn_gspawn_trg")) then {deleteVehicle zsn_gspawn_trg;};
			zsn_gspawn_trg = createTrigger ["EmptyDetector", getmarkerPos "respawn_guerrila"];
			zsn_gspawn_trg setTriggerActivation ["civ", "PRESENT", true];
			zsn_gspawn_trg setTriggerStatements ["isServer && {Side _x == civilian} count thislist >= zsn_wavesize_resistance && (zsn_wavecount_resistance ^ 2) >= 1", "thisList call zsn_spawnwave_resistance;",""];
			if (!isNil ("zsn_gfail_trg")) then {deleteVehicle zsn_gfail_trg;};
			zsn_gfail_trg = createTrigger ["EmptyDetector", getmarkerPos "respawn_guerrila"];
			zsn_gfail_trg setTriggerActivation ["civ", "PRESENT", true];
			if (_zsn_pvp) then {
            			zsn_gfail_trg setTriggerStatements ["isServer && {alive _x && Side _x == resistance} count (allPlayers - entities 'HeadlessClient_F') < 1 && (zsn_wavecount_resistance ^ 2) < 1", "'SideScore' call BIS_fnc_endMissionServer;",""];
			} else {
            			zsn_gfail_trg setTriggerStatements ["isServer && {alive _x && Side _x == resistance} count (allPlayers - entities 'HeadlessClient_F') < 1 && (zsn_wavecount_resistance ^ 2) < 1", "'EveryoneLost' call BIS_fnc_endMissionServer;",""];
			};
		};
	};
};

zsn_spawnwave_east = {
	_units = _this;
	["", "BLACK OUT"] remoteexec ["titleText", _units];
	_players = _units apply {[ rankId _x, rating _x, _x ]};
	_players = _players - [ -1 ];
	_players sort false;
	_grp = createGroup east;
	{[_x select 2] join _grp} forEach _players;
	_highestRanked = _players select 0 select 2;
	if (zsn_radio_east) then {
		_highestRanked additem "itemradio";
		_highestRanked assignItem "itemradio";
	};
	{_x setVehiclePosition [(getpos zsn_respawn_east), [], 4]} forEach _units;
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then 
	{
		[player, false] remoteExec ["TFAR_fnc_forceSpectator", _units];
	};
	["Terminate"] remoteExec ["BIS_fnc_EGSpectator", _units];
	[format ["%1 is the the squad leader, your callsign is %2", name _highestRanked, _grp]] remoteExec ["hint", _units];
	zsn_wavecount_east = zsn_wavecount_east - 1;
	publicVariable "zsn_wavecount_east";
	["", "BLACK IN"] remoteexec ["titleText", _units];
};

zsn_spawnwave_west = {
	_units = _this;
	["", "BLACK OUT"] remoteexec ["titleText", _units];
	_players = _units apply {[ rankId _x, rating _x, _x ]};
	_players = _players - [ -1 ];
	_players sort false;
	_grp = createGroup west;
	{[_x select 2] join _grp} forEach _players;
	_highestRanked = _players select 0 select 2;
	if (zsn_radio_west) then
	{
		_highestRanked additem "itemradio";
		_highestRanked assignItem "itemradio";
	};
	{_x setVehiclePosition [(getpos zsn_respawn_west), [], 4]} forEach _units;
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then 
	{
		[player, false] remoteExec ["TFAR_fnc_forceSpectator", _units];
	};
	["Terminate"] remoteExec ["BIS_fnc_EGSpectator", _units];
	[format ["%1 is the the squad leader, your callsign is %2", name _highestRanked, _grp]] remoteExec ["hint", _units];
	zsn_wavecount_west = zsn_wavecount_west - 1;
	publicVariable "zsn_wavecount_west";
	["", "BLACK IN"] remoteexec ["titleText",  _units]; 	
};

zsn_spawnwave_resistance = {
	_units = _this;
	["", "BLACK OUT"] remoteexec ["titleText", _units];
	_players = _units apply {[ rankId _x, rating _x, _x ]};
	_players = _players - [ -1 ];
	_players sort false;
	_grp = createGroup resistance;
	{[_x select 2] join _grp} forEach _players;
	_highestRanked = _players select 0 select 2;
	if (zsn_radio_resistance) then {
		_highestRanked additem "itemradio";
		_highestRanked assignItem "itemradio";
	};
	{_x setVehiclePosition [(getpos zsn_respawn_guerrila), [], 4]} forEach _units;
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then 
	{
		[player, false] remoteExec ["TFAR_fnc_forceSpectator", _units];
	};
	["Terminate"] remoteExec ["BIS_fnc_EGSpectator", _units];
	[format ["%1 is the the squad leader, your callsign is %2", name _highestRanked, _grp]] remoteExec ["hint", _units];
	zsn_wavecount_resistance = zsn_wavecount_resistance - 1;
	publicVariable "zsn_wavecount_resistance";
	["", "BLACK IN"] remoteexec ["titleText", _units];
};
