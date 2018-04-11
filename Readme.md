Place objects in the editor, name them zsn_respawn_east, zsn_respawn_west and/or zsn_respawn_guerrila.
This is the place the players will be moved to when they are given control back. Make sure they are objects,
(I recommend the invisible Helipad, but any object is supported, including vehicles)

[west, 4, -1, true, false, west] remoteExec ["zsn_waverespawn", 2];

Is the line used to call the script, it contains six params;

- Side: the side to use wave respawn, default is West.

- Wave Size: The number of players to include in each wave, default is 8

- Wave count: The max number of waves to respawn, default is -1 (infinite)

- Custom Loadout: New wave gets custom loadouts defined in description.ext, they can also respawn with a vehicle. 
If false thay will respawn with the gear they had at mission start. Default is false. If you set this to true, you can use classnames from config or define custom loadouts in description.ext. Place them in the array in initserver.sqf

- PvP: whether or not this is a PvP mission, this determines what kind of end trigger will be used when one side runs out of "lives". Default is false

- Respawn side: which side the new wave will belong to, if you want to respawn players to a different side, default is the same as whatever you set in the first param

This line can be executed anywhere in the mission at any point, it can be used to change the respawn conditions during gameplay

There is also support for setting params size and count in the mission lobby, (see the top line in initserver.sqf for resistance) the params are set in description.ext

To initialize the script for multiple sides, just execute the command line multiple times, this example mission executes it three times for three sides.

If all players are dead and there are spawn waves left, the script will spawn in the new wave automatically. The overflow is saved and when the side runs out of waves a last wave will be spawned with the overflow.

You can initiate the a new wave spawn yourself, maybe upon objective completion or other criteria. To do this, fill in the custom param at the bottom of initserver.sqf

Lastly, if you for some reason don't want players without squad logos to spawn with safety vests, you can remove the bottom line in initserver.sqf
