// Save inventory if altered in editor, to load later on respawn
[player, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory;

// Give FNGs safety vests, so they are easier to keep track of
if (isMultiplayer) then {
	if (isnil {squadParams player select 0 select 1}) then {
		removeVest player; 
		if (isClass(configFile >> "CfgPatches" >> "us_military_units")) then {	
			player addvest "usm_vest_safety";
		} else {
			if (571710 in (getDLCs 1)) then	{
				player addvest selectRandom ["V_safety_yellow_F","V_safety_orange_F","V_safety_blue_F"];
			} else {
				if (isClass(configFile >> "CfgPatches" >> "CUP_Creatures_Military_USMC")) then {
					player addvest "CUP_V_B_LHDVest_Yellow";
				} else {
					player addvest "V_DeckCrew_yellow_F";
				};
			};
		};
	};
};

// Remove magazine from gun and add it to inventory
if (currentWeapon player isKindOf ["Rifle_Base_F", configFile >> "CfgWeapons"]) then {
	player addmagazine currentMagazine player;
	player removePrimaryWeaponItem currentMagazine player;
};

// Create trigger on respawn markers, which will be consulted when displaying explanatory hints on player death
zsn_eplayer_trg = createTrigger ["EmptyDetector", getmarkerPos "respawn_east"];
zsn_eplayer_trg setTriggerActivation ["civ", "PRESENT", true];				
zsn_wplayer_trg = createTrigger ["EmptyDetector", getmarkerPos "respawn_west"];
zsn_wplayer_trg setTriggerActivation ["civ", "PRESENT", true];
zsn_gplayer_trg = createTrigger ["EmptyDetector", getmarkerPos "respawn_guerrila"];
zsn_gplayer_trg setTriggerActivation ["civ", "PRESENT", true];

// Add script to respawn event, which will initialize spectating and handle counters
player addEventHandler ["Respawn", {
	titleText ["", "BLACK OUT"];
	["Initialize",[player, [playerside], false, false, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {[player, true] call TFAR_fnc_forceSpectator;};
	switch (playerSide) do {
		case east: {
			if ((zsn_wavecount_east ^ 2) >= 1) then {
				if ((zsn_wavesize_east - (count list zsn_eplayer_trg)) > 1) then {
					hint format ["Wave Respawn is in effect, wave size is %1. You will respawn when %2 more players die.", zsn_wavesize_east, (zsn_wavesize_east - (count list zsn_eplayer_trg + 1))];
				} else {
					hint format ["Wave Respawn is in effect, wave size is %1.", zsn_wavesize_east];
				};
			};
		};
		case west: {
			if ((zsn_wavecount_west ^ 2) >= 1) then {
				if ((zsn_wavesize_west - (count list zsn_wplayer_trg)) > 1) then {
					hint format ["Wave Respawn is in effect, wave size is %1. You will respawn when %2 more players die.", zsn_wavesize_west, (zsn_wavesize_west - (count list zsn_wplayer_trg + 1))];
				} else {
					hint format ["Wave Respawn is in effect, wave size is %1.", zsn_wavesize_west];
				};
			};
		};
		case resistance: {
			if ((zsn_wavecount_resistance ^ 2) >= 1) then {
				if ((zsn_wavesize_resistance - (count list zsn_gplayer_trg)) > 1) then {
					hint format ["Wave Respawn is in effect, wave size is %1. You will respawn when %2 more players die.", zsn_wavesize_resistance, zsn_wavesize_resistance - (count list zsn_gplayer_trg + 1)];
				} else {
					hint format ["Wave Respawn is in effect, wave size is %1.", zsn_wavesize_resistance];
				};	
			};
		};
	};
	[player, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory;
	[player] join createGroup CIVILIAN;
	titleText ["", "BLACK IN"];
}];
