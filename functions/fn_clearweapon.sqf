
// Anrop Gold Members get golden AKs
if (getPlayerUID player == 76561198130090580) then {
	if (currentWeapon player isKindOf ["sfp_ak5_base", configFile >> "CfgWeapons"];) then {
		_magtype = currentmagazine player;  
		_magcount = {_x == _magtype} count magazines player;  
		for _magtype from 0 to _magcount do {
			player removemagazine _magtype;
			player addmagazine "sfp_30Rnd_556x45_Stanag_tracer";
		};  
		player removeweapon primaryWeapon player;  
		player addweapon "sfp_ak5_gold";
	} else {
		if (currentWeapon player isKindOf ["CUP_arifle_AK_Base", configFile >> "CfgWeapons"];) then {
			_magtype = currentmagazine player;  
			_magcount = {_x == _magtype} count magazines player;  
			for _magtype from 0 to _magcount do {
				player removemagazine _magtype;
				player addmagazine "CUP_30Rnd_762x39_AK47_TK_M";
			};  
			player removeweapon primaryWeapon player;  
			player addweapon "CUP_arifle_AKS_Gold";
		};
	};
};

// Remove magazine from gun and add it to inventory
if (currentWeapon player isKindOf ["Rifle_Base_F", configFile >> "CfgWeapons"]) then {
	player addmagazine currentMagazine player;
	player removePrimaryWeaponItem currentMagazine player;
};