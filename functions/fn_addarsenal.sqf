params [
	["_box",""],
	["_fact",faction player],
	["_ea",[]]
];
["AmmoboxInit",[_box,false]] spawn BIS_fnc_arsenal;
_ua = [];
	{
	if ((configName _x) isKindoF "CAManBase") then {
		_ua pushback (configName _x);
	};
} forEach ("(getText (_x >> 'faction') == _fact) && (getNumber (_x >> 'scope') > 1)" configClasses (configfile >> "CfgVehicles"));
{if (_x in _ua) then {_ua = _ua - _x;} else {_ua pushback _x;};} foreach _ea;
{
	private _lo = getUnitLoadout (configFile >> "CfgVehicles" >> _x);
	[_box,[_lo select 0 select 0],true] call BIS_fnc_addVirtualWeaponCargo;
	[_box,[_lo select 1 select 0],true] call BIS_fnc_addVirtualWeaponCargo;
	[_box,[_lo select 2 select 0],true] call BIS_fnc_addVirtualWeaponCargo;
	[_box,[_lo select 3 select 0],true] call BIS_fnc_addVirtualItemCargo;
	if (str [_lo select 3] != "[[]]") then {
		if (str [_lo select 3 select 1] != "[[]]") then {
			{
				{
					if (typename (_x select 0) == "ARRAY") then {
						[_box,_x select 0 select 0,true] call BIS_fnc_addVirtualWeaponCargo;
					} else {
						if (isClass (configFile >> "CfgMagazines" >> _x select 0)) then {
							[_box,_x select 0,true] call BIS_fnc_addVirtualMagazineCargo;
						} else {
							[_box,_x select 0,true] call BIS_fnc_addVirtualItemCargo;
						};
					};
				} foreach _x
			} foreach [_lo select 3 select 1]
		};
	};
	[_box,[_lo select 4 select 0],true] call BIS_fnc_addVirtualItemCargo;
	if (str [_lo select 4] != "[[]]") then {
		if (str [_lo select 4 select 1] != "[[]]") then {
			{
				{
					if (typename (_x select 0) == "ARRAY") then {
						[_box,_x select 0 select 0,true] call BIS_fnc_addVirtualWeaponCargo;
					} else {
						if (isClass (configFile >> "CfgMagazines" >> _x select 0)) then {
							[_box,_x select 0,true] call BIS_fnc_addVirtualMagazineCargo;
						} else {
							[_box,_x select 0,true] call BIS_fnc_addVirtualItemCargo;
						};
					};
				} foreach _x
			} foreach [_lo select 4 select 1]
		};
	};
	[_box,[_lo select 5 select 0],true] call BIS_fnc_addVirtualbackpackCargo;
	if (str [_lo select 5] != "[[]]") then {
		if (str [_lo select 5 select 1] != "[[]]") then {
			{
				{
					if (typename (_x select 0) == "ARRAY") then {
						[_box,_x select 0 select 0,true] call BIS_fnc_addVirtualWeaponCargo;
					} else {
						if (isClass (configFile >> "CfgMagazines" >> _x select 0)) then {
							[_box,_x select 0,true] call BIS_fnc_addVirtualMagazineCargo;
						} else {
							[_box,_x select 0,true] call BIS_fnc_addVirtualItemCargo;
						};
					};
				} foreach _x
			} foreach [_lo select 5 select 1]
		};
	};
	[_box,[_lo select 6],true] call BIS_fnc_addVirtualItemCargo;
	[_box,[_lo select 7],true] call BIS_fnc_addVirtualItemCargo;
	[_box,[_lo select 8 select 0],true] call BIS_fnc_addVirtualItemCargo;
	{[_box,_x,true] call BIS_fnc_addVirtualItemCargo} foreach [_lo select 9];
} foreach _ua;
