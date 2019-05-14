This is a wave respawn script that allows players to respawn in waves of predefines sizes. It runs on top of the vanilla respawn system.

What you need to do:

move initserver.sqf, description.ext and the functions folder into your mission folder.

Open up your mission and place objects or markers in the editor, name them zsn_respawn_east, zsn_respawn_west and/or zsn_respawn_guerrila. This is the place the players will be moved to when they are given control back.

[west, 4, -1, true, west] remoteExec ["zsn_fnc_waverespawn", 2];

Is the line used to call the script, it contains five params;

- Side: the side to use wave respawn, default is West.

- Wave Size: The number of players to include in each wave, default is a quarter of total players on given side

- Wave count: The max number of waves to respawn, default is -1 (infinite)

- Custom Loadout: New wave gets custom loadouts defined in description.ext of config. 
If false they will respawn with the gear they had at mission start. Default is false. If you set this to true, you can use classnames from config or define custom loadouts in description.ext. Place them in the array in initserver.sqf

- Respawn side: which side the new wave will belong to, if you want to respawn players to a different side. 
Default is the same side as in the first param

This line can be executed anywhere in the mission at any point, it can be used to change the respawn conditions during gameplay.

There is also support for setting params size and count in the mission lobby, (see the top line in initserver.sqf for indep side) the params are defined in description.ext

To initialize the script for multiple sides, just execute the command line multiple times, this example mission executes it three times for three sides.

If all players are dead and there are spawn waves left, the script will automatically spawn in the remaining players. The overflow is saved for a last wave.

You can initiate the a new wave spawn yourself even if wave count has not been reached, maybe upon objective completion or other criteria. To do this, replace the "false" entry at the bottom of initserver.sqf with your custom condition or variable. 

The script also forces players to spawn with their weapons unloaded which I find helps a lot with Nonintentional Discharges in the spawn area

If you experience problems in the script you can try "call zsn_fnc_respawndebug" to reset it
