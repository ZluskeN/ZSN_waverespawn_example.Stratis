params [
	["_zsn_side", west, [east]],					//Side to execute wave respawn for 		(SIDE, Default west)
	["_zsn_ws", (floor ((playersNumber _this select 0)/4)), [9]],	//Size of respawn waves				(NUMBER, Default is 1/4 of the number of players on that side)
	["_zsn_wc", -1, [8]],						//Number of respawn waves 			(NUMBER, Default -1 = infinite)
	["_zsn_lo", false, [true]],					//new wave receives custom gear			(BOOLEAN, Default false)
	["_zsn_rs", _this select 0, [east]]				//Side to execute wave respawn for 		(SIDE, Default same as _zsn_side)
];
zsn_pvp = false;
if (isNil "zsn_wre") then {zsn_wre = false; publicVariable "zsn_wre";};
if (isNil "zsn_wrw") then {zsn_wrw = false; publicVariable "zsn_wrw";};
if (isNil "zsn_wrg") then {zsn_wrg = false; publicVariable "zsn_wrg";};
if (_zsn_ws < 2) then {_zsn_ws = 2;};
zsn_rd = (getMissionConfigValue ["respawnDelay",2]) + 1;
switch (_zsn_side) do {
	case east: {
		zsn_wre = true; publicVariable "zsn_wre";
		if (zsn_wrw || (zsn_wrg && [resistance, east] call BIS_fnc_sideIsEnemy)) then {zsn_pvp = true;};
		publicVariable "zsn_pvp";
		if (isNil ("respawn_east")) then {
			respawn_east = createMarker ["respawn_east", [100,0]];
			Edome = "Land_Dome_Small_F" createVehicle [100,0,0];
			Edome setPos [100,0,0];
		};
		if ("zsn_respawn_east" in allMapMarkers) then {
			_helih = "HeliHEmpty" createVehicle getMarkerPos "zsn_respawn_east"; 
			_helih setvehiclevarname "zsn_respawn_east"; 
			zsn_respawn_east = _helih;
		};
		zsn_ofe = 0; publicVariable "zsn_ofe";
		zsn_loe = _zsn_lo; publicVariable "zsn_loe";
		zsn_wce = _zsn_wc; publicVariable "zsn_wce";
		zsn_wse = _zsn_ws; publicVariable "zsn_wse"; 
		zsn_rse = _zsn_rs; publicVariable "zsn_rse";
		if (!isNil ("zsn_est")) then {deleteVehicle zsn_est;};
		zsn_est = createTrigger ["EmptyDetector", getmarkerPos "respawn_east"];
		zsn_est setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		if (zsn_rse == east) then {zsn_est setTriggerStatements ["isServer && (zsn_wce ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wse", "
			_zsn_units = [];
			{if (_foreachindex < zsn_wse) then {_zsn_units pushback _x};} foreach thislist; 
			_zsn_units call zsn_fnc_spawnwave_east;
			zsn_wce = zsn_wce - 1; publicVariable 'zsn_wce'; 
			if (zsn_wce == 0 && zsn_ofe > 0) then {
				[east, zsn_ofe, 1, zsn_loe, zsn_rse] remoteexecCall ['zsn_fnc_waverespawn',2];
			};
		",""];};
		if (zsn_rse == west) then {zsn_est setTriggerStatements ["isServer && (zsn_wce ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wse", "
			_zsn_units = [];
			{if (_foreachindex < zsn_wse) then {_zsn_units pushback _x};} foreach thislist; 
			_zsn_units call zsn_fnc_spawnwave_west;
			zsn_wce = zsn_wce - 1; publicVariable 'zsn_wce'; 
			if (zsn_wce == 0 && zsn_ofe > 0) then {
				[east, zsn_ofe, 1, zsn_loe, zsn_rse] remoteexecCall ['zsn_fnc_waverespawn',2];
			};
		",""];};
		if (zsn_rse == resistance) then {zsn_est setTriggerStatements ["isServer && (zsn_wce ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wse", "
			_zsn_units = [];
			{if (_foreachindex < zsn_wse) then {_zsn_units pushback _x};} foreach thislist; 
			_zsn_units call zsn_fnc_spawnwave_resistance;
			zsn_wce = zsn_wce - 1; publicVariable 'zsn_wce'; 
			if (zsn_wce == 0 && zsn_ofe > 0) then {
				[east, zsn_ofe, 1, zsn_loe, zsn_rse] remoteexecCall ['zsn_fnc_waverespawn',2];
			};
		",""];};
		if (!isNil ("zsn_eft")) then {deleteVehicle zsn_eft;};
		zsn_eft = createTrigger ["EmptyDetector", getmarkerPos "respawn_east"];
		zsn_eft setTriggerTimeout [zsn_rd, zsn_rd, zsn_rd, true];
		zsn_eft setTriggerActivation ["civ", "PRESENT", true];
      	zsn_eft setTriggerStatements ["isServer && {alive _x && Side _x == east} count (allPlayers - entities 'HeadlessClient_F') < 1 && {Side _x == civilian} count thislist >= 1", "[zsn_rse, thisList] call zsn_fnc_allplayersdead;",""];
	};
	case west: {
		zsn_wrw = true;	publicVariable "zsn_wrw";
		if (zsn_wre || (zsn_wrg && [resistance, west] call BIS_fnc_sideIsEnemy)) then {zsn_pvp = true;};
		publicVariable "zsn_pvp";
		if (isNil ("respawn_west")) then {
			respawn_west = createMarker ["respawn_west", [0,100]];
			Wdome = "Land_Dome_Small_F" createVehicle [0,100,0];
			Wdome setPos [0,100,0];
		};
		if ("zsn_respawn_west" in allMapMarkers) then {
			_helih = "HeliHEmpty" createVehicle getMarkerPos "zsn_respawn_west"; 
			_helih setvehiclevarname "zsn_respawn_west"; 
			zsn_respawn_west = _helih;
		};
		zsn_ofw = 0; publicVariable "zsn_ofw";
		zsn_low = _zsn_lo; publicVariable "zsn_low";
		zsn_wcw = _zsn_wc; publicVariable "zsn_wcw";
		zsn_wsw = _zsn_ws; publicVariable "zsn_wsw";
		zsn_rsw = _zsn_rs; publicVariable "zsn_rsw";
		if (!isNil ("zsn_wst")) then {deleteVehicle zsn_wst;};
		zsn_wst = createTrigger ["EmptyDetector", getmarkerPos "respawn_west"];
		zsn_wst setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		if (zsn_rsw == east) then {zsn_wst setTriggerStatements ["isServer && (zsn_wcw ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wsw", "
			_zsn_units = [];
			{if (_foreachindex < zsn_wsw) then {_zsn_units pushback _x};} foreach thislist; 
			_zsn_units call zsn_fnc_spawnwave_east;
			zsn_wcw = zsn_wcw - 1; publicVariable 'zsn_wcw'; 
			if (zsn_wcw == 0 && zsn_ofw > 0) then {
				[west, zsn_ofw, 1, zsn_low, zsn_rsw] remoteexecCall ['zsn_fnc_waverespawn',2];
			};
		",""];};
		if (zsn_rsw == west) then {zsn_wst setTriggerStatements ["isServer && (zsn_wcw ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wsw", "
			_zsn_units = [];
			{if (_foreachindex < zsn_wsw) then {_zsn_units pushback _x};} foreach thislist; 
			_zsn_units call zsn_fnc_spawnwave_west;
			zsn_wcw = zsn_wcw - 1; publicVariable 'zsn_wcw'; 
			if (zsn_wcw == 0 && zsn_ofw > 0) then {
				[west, zsn_ofw, 1, zsn_low, zsn_rsw] remoteexecCall ['zsn_fnc_waverespawn',2];
			};
		",""];};
		if (zsn_rsw == resistance) then {zsn_wst setTriggerStatements ["isServer && (zsn_wcw ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wsw", "
			_zsn_units = [];
			{if (_foreachindex < zsn_wsw) then {_zsn_units pushback _x};} foreach thislist; 
			_zsn_units call zsn_fnc_spawnwave_resistance;
			zsn_wcw = zsn_wcw - 1; publicVariable 'zsn_wcw'; 
			if (zsn_wcw == 0 && zsn_ofw > 0) then {
				[west, zsn_ofw, 1, zsn_low, zsn_rsw] remoteexecCall ['zsn_fnc_waverespawn',2];
			};
		",""];};
		if (!isNil ("zsn_wft")) then {deleteVehicle zsn_wft;};
		zsn_wft = createTrigger ["EmptyDetector", getmarkerPos "respawn_west"];
		zsn_wft setTriggerTimeout [zsn_rd, zsn_rd, zsn_rd, true];
		zsn_wft setTriggerActivation ["civ", "PRESENT", true];
       	zsn_wft setTriggerStatements ["isServer && {alive _x && Side _x == west} count (allPlayers - entities 'HeadlessClient_F') < 1 && {Side _x == civilian} count thislist >= 1", "[zsn_rsw, thisList] call zsn_fnc_allplayersdead;",""];
	};
	case resistance: {
		zsn_wrg = true; publicVariable "zsn_wrg";
		if ((zsn_wrw && [west, resistance] call BIS_fnc_sideIsEnemy) || (zsn_wre && [east, resistance] call BIS_fnc_sideIsEnemy)) then {zsn_pvp = true;};
		publicVariable "zsn_pvp";
		if (isNil ("respawn_guerrila")) then {
			respawn_guerrila = createMarker ["respawn_guerrila", [0,0]];
			Gdome = "Land_Dome_Small_F" createVehicle [0,0,0];
			Gdome setPos [100,100,0];
		};
		if ("zsn_respawn_guerrila" in allMapMarkers) then {
			_helih = "HeliHEmpty" createVehicle getMarkerPos "zsn_respawn_guerrila"; 
			_helih setvehiclevarname "zsn_respawn_guerrila"; 
			zsn_respawn_guerrila = _helih;
		};
		zsn_ofg = 0; publicVariable "zsn_ofg";
		zsn_log = _zsn_lo; publicVariable "zsn_log";
		zsn_wcg = _zsn_wc; publicVariable "zsn_wcg";
		zsn_wsg = _zsn_ws; publicVariable "zsn_wsg";
		zsn_rsg = _zsn_rs; publicVariable "zsn_rsg";
		if (!isNil ("zsn_gst")) then {deleteVehicle zsn_gst;};
		zsn_gst = createTrigger ["EmptyDetector", getmarkerPos "respawn_guerrila"];
		zsn_gst setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		if (zsn_rsg == east) then {zsn_gst setTriggerStatements ["isServer && (zsn_wcg ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wsg", "
			_zsn_units = [];
			{if (_foreachindex < zsn_wsg) then {_zsn_units pushback _x};} foreach thislist; 
			_zsn_units call zsn_fnc_spawnwave_east;
			zsn_wcg = zsn_wcg - 1; publicVariable 'zsn_wcg'; 
			if (zsn_wcg == 0 && zsn_ofg > 0) then {
				[resistance, zsn_ofg, 1, zsn_log, zsn_rsg] remoteexecCall ['zsn_fnc_waverespawn',2];
			};
		",""];};
		if (zsn_rsg == west) then {zsn_gst setTriggerStatements ["isServer && (zsn_wcg ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wsg", "
			_zsn_units = [];
			{if (_foreachindex < zsn_wsg) then {_zsn_units pushback _x};} foreach thislist; 
			_zsn_units call zsn_fnc_spawnwave_west;
			zsn_wcg = zsn_wcg - 1; publicVariable 'zsn_wcg'; 
			if (zsn_wcg == 0 && zsn_ofg > 0) then {
				[resistance, zsn_ofg, 1, zsn_log, zsn_rsg] remoteexecCall ['zsn_fnc_waverespawn',2];
			};
		",""];};
		if (zsn_rsg == resistance) then {zsn_gst setTriggerStatements ["isServer && (zsn_wcg ^ 2) >= 1 && {Side _x == civilian} count thislist >= zsn_wsg", "
			_zsn_units = [];
			{if (_foreachindex < zsn_wsg) then {_zsn_units pushback _x};} foreach thislist; 
			_zsn_units call zsn_fnc_spawnwave_resistance;
			zsn_wcg = zsn_wcg - 1; publicVariable 'zsn_wcg'; 
			if (zsn_wcg == 0 && zsn_ofg > 0) then {
				[resistance, zsn_ofg, 1, zsn_log, zsn_rsg] remoteexecCall ['zsn_fnc_waverespawn',2];
			};
		",""];};
		if (!isNil ("zsn_gft")) then {deleteVehicle zsn_gft;};
		zsn_gft = createTrigger ["EmptyDetector", getmarkerPos "respawn_guerrila"];
		zsn_gft setTriggerTimeout [zsn_rd, zsn_rd, zsn_rd, true];
		zsn_gft setTriggerActivation ["civ", "PRESENT", true];
        zsn_gft setTriggerStatements ["isServer && {alive _x && Side _x == resistance} count (allPlayers - entities 'HeadlessClient_F') < 1 && {Side _x == civilian} count thislist >= 1", "[zsn_rsg, thisList] call zsn_fnc_allplayersdead;",""];
	};
};
addMissionEventHandler ["entityKilled", {
	params ["_unit"]; 
	if (!isPlayer _unit) then {
			[_unit] join grpNull;
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
