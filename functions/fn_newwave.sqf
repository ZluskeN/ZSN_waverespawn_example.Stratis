params ["_zsn_units"];
if (player in _zsn_units) then {
	call zsn_fnc_clearweapon;
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
		[player, false] call TFAR_fnc_forceSpectator;
		[call TFAR_fnc_activeSWRadio,true] call TFAR_fnc_radioOn;
		[call TFAR_fnc_activeLRRadio,true] call TFAR_fnc_radioOn;
	};
	["Terminate"] call BIS_fnc_EGSpectator;
	titleText ["", "BLACK IN"];
};