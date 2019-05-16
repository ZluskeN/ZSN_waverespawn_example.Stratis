// This debug script recalls the wave respawn initialization with existing parameters, use it if you experience som kind of hickup
// "call zsn_fnc_respawndebug"

if (zsn_wre) then {[east, zsn_wse, zsn_wce, zsn_loe, zsn_rse] remoteexecCall ["zsn_fnc_waverespawn", 2];};
if (zsn_wrw) then {[west, zsn_wsw, zsn_wcw, zsn_low, zsn_rsw] remoteexecCall ["zsn_fnc_waverespawn", 2];};
if (zsn_wrg) then {[resistance, zsn_wsg, zsn_wcg, zsn_log, zsn_rsg] remoteexecCall ["zsn_fnc_waverespawn", 2];};
