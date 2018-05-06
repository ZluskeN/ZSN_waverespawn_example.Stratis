private _zsn_list = _this;
private _zsn_units = [];
{if (_foreachindex < zsn_wsw) then {_zsn_units pushback _x};} foreach _zsn_list;
["", "BLACK OUT"] remoteexec ["titleText", _zsn_units];
_zsn_ranked = _zsn_units apply {[rankId _x, rating _x, _x]};
_zsn_ranked = _zsn_ranked - [ -1 ];
_zsn_ranked sort false;
_hr = _zsn_ranked select 0 select 2;
_grp = createGroup west;
{[_x select 2] joinsilent _grp} forEach _zsn_ranked;
_hr setUnitRank "SERGEANT";
if (count _zsn_units > 1) then {_zsn_ranked select 1 select 2 setUnitRank "CORPORAL"; [_zsn_ranked select 1 select 2, "YELLOW"] remoteexec ["assignteam"];};
if (count _zsn_units > 2) then {_zsn_ranked select 2 select 2 setUnitRank "PRIVATE"; [_zsn_ranked select 2 select 2, "BLUE"] remoteexec ["assignteam"];};
if (count _zsn_units > 3) then {_zsn_ranked select 3 select 2 setUnitRank "PRIVATE"; [_zsn_ranked select 3 select 2, "YELLOW"] remoteexec ["assignteam"];};
if (count _zsn_units > 4) then {_zsn_ranked select 4 select 2 setUnitRank "PRIVATE"; [_zsn_ranked select 4 select 2, "BLUE"] remoteexec ["assignteam"];};
if (count _zsn_units > 5) then {_zsn_ranked select 5 select 2 setUnitRank "PRIVATE"; [_zsn_ranked select 5 select 2, "YELLOW"] remoteexec ["assignteam"];};
if (count _zsn_units > 6) then {_zsn_ranked select 6 select 2 setUnitRank "PRIVATE"; [_zsn_ranked select 6 select 2, "BLUE"] remoteexec ["assignteam"];};
if (count _zsn_units > 7) then {_zsn_ranked select 7 select 2 setUnitRank "PRIVATE"; [_zsn_ranked select 7 select 2, "YELLOW"] remoteexec ["assignteam"];};
if (count _zsn_units > 8) then {_zsn_ranked select 8 select 2 setUnitRank "CORPORAL"; [_zsn_ranked select 8 select 2, "BLUE"] remoteexec ["assignteam"];};
if (count _zsn_units > 9) then {_zsn_ranked select 9 select 2 setUnitRank "PRIVATE"; [_zsn_ranked select 9 select 2, "RED"] remoteexec ["assignteam"];};
if (zsn_low) then {
	[_hr, zsn_wloadouts select 0] call zsn_fnc_loadInventory;
	if (count _zsn_units > 1) then {[_zsn_ranked select 1 select 2, zsn_wloadouts select 1] call zsn_fnc_loadInventory;};
	if (count _zsn_units > 2) then {[_zsn_ranked select 2 select 2, zsn_wloadouts select 2] call zsn_fnc_loadInventory;};
	if (count _zsn_units > 3) then {[_zsn_ranked select 3 select 2, zsn_wloadouts select 3] call zsn_fnc_loadInventory;};
	if (count _zsn_units > 4) then {[_zsn_ranked select 4 select 2, zsn_wloadouts select 4] call zsn_fnc_loadInventory;};
	if (count _zsn_units > 5) then {[_zsn_ranked select 5 select 2, zsn_wloadouts select 5] call zsn_fnc_loadInventory;};
	if (count _zsn_units > 6) then {[_zsn_ranked select 6 select 2, zsn_wloadouts select 6] call zsn_fnc_loadInventory;};
	if (count _zsn_units > 7) then {[_zsn_ranked select 7 select 2, zsn_wloadouts select 7] call zsn_fnc_loadInventory;};
	if (count _zsn_units > 8) then {[_zsn_ranked select 8 select 2, zsn_wloadouts select 8] call zsn_fnc_loadInventory;};
	if (count _zsn_units > 9) then {[_zsn_ranked select 9 select 2, zsn_wloadouts select 9] call zsn_fnc_loadInventory;};
};
remoteexec ["zsn_fnc_clearweapon", _zsn_units];
{_x setVehiclePosition [(getpos zsn_respawn_west), [], 8];} forEach _zsn_units;
if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
	[player, false] remoteExec ["TFAR_fnc_forceSpectator", _zsn_units];
	[{if (call TFAR_fnc_haveLRRadio) then {[call TFAR_fnc_activeLRRadio,true] call TFAR_fnc_radioOn}}] remoteExecCall ["bis_fnc_call", _zsn_units];
	[{if (call TFAR_fnc_haveSWRadio) then {[call TFAR_fnc_activeSWRadio,true] call TFAR_fnc_radioOn}}] remoteExecCall ["bis_fnc_call", _zsn_units];
};
["Terminate"] remoteExec ["BIS_fnc_EGSpectator", _zsn_units];
["", "BLACK IN"] remoteexec ["titleText", _zsn_units];
[format ["New squad spawned, callsign %2. %1 is the the squad leader", name _hr, _grp]] remoteExec ["hint", west];
