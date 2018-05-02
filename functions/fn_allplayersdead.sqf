params [
	["_zsn_side",""],
	["_zsn_list",""]
];
if ({alive _x && Side _x == _zsn_side} count (allPlayers - entities 'HeadlessClient_F') < 1) then {
	switch (_zsn_side) do {
		case east: {
			if ((zsn_wce ^ 2) >= 1) then {
				zsn_ofe = zsn_ofe + (zsn_wse - (count _zsn_list));
				publicVariable "zsn_ofe";
				_zsn_list spawn zsn_fnc_spawnwave_east;
				if (zsn_wce != 0) then {zsn_wce = zsn_wce - 1;}; publicVariable "zsn_wce";
				if (zsn_wce == 0 && zsn_ofe > 0) then {
					[east, zsn_ofe, 1, zsn_loe, zsn_rse] remoteexec ['zsn_fnc_waverespawn',2];
				};
			} else {
				if (zsn_pvp) then {
					'SideScore' call BIS_fnc_endMissionServer;
				} else {
					'EveryoneLost' call BIS_fnc_endMissionServer;
				};
			};
		};
		case west: {
			if ((zsn_wcw ^ 2) >= 1) then {
				zsn_ofw = zsn_ofw + (zsn_wsw - (count _zsn_list));
				publicVariable "zsn_ofw";
				_zsn_list spawn zsn_fnc_spawnwave_west;
				if (zsn_wcw != 0) then {zsn_wcw = zsn_wcw - 1;}; publicVariable "zsn_wcw";
				if (zsn_wcw == 0 && zsn_ofw > 0) then {
					[west, zsn_ofw, 1, zsn_low, zsn_rsw] remoteexec ['zsn_fnc_waverespawn',2];
				};
			} else {
				if (zsn_pvp) then {
					'SideScore' call BIS_fnc_endMissionServer;
				} else {
					'EveryoneLost' call BIS_fnc_endMissionServer;
				};
			};
		};
		case resistance: {
			if ((zsn_wcg ^ 2) >= 1) then {
				zsn_ofg = zsn_ofg + (zsn_wsg - (count _zsn_list));
				publicVariable "zsn_ofg";
				_zsn_list spawn zsn_fnc_spawnwave_resistance;
				if (zsn_wcg != 0) then {zsn_wcg = zsn_wcg - 1;}; publicVariable "zsn_wcg";
				if (zsn_wcg == 0 && zsn_ofg > 0) then {
					[resistance, zsn_ofg, 1, zsn_log, zsn_rsg] remoteexec ['zsn_fnc_waverespawn',2];
				};
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

