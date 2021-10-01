# Respawn Unlocker

Allows you to remove invisible walls and add crates near the spawn zone at the end of the round.

### Supported Games

* Day of Defeat: Source

### Installation

* Download latest [release](https://github.com/dronelektron/respawn-unlocker/releases) (compiled for SourceMod 1.10)
* Extract "plugins" and "translations" folders to "addons/sourcemod" folder of your server

### Console Variables

* sm_respawnunlocker_walls - Enable (1) or disable (0) walls removing [default: "1"]
* sm_respawnunlocker_crates - Enable (1) or disable (0) crates adding [default: "1"]
* sm_respawnunlocker_notifications - Enable (1) or disable (0) notifications [default: "1"]

### How to add crates

Create a file "addons/sourcemod/configs/respawn-unlocker.txt" with the following structure:

```
"Crates"
{
    "dod_gan_games" // Map name
    {
        "1" // Crate's number
        {
            "position_x"    "320"  // Position of the center
            "position_y"    "-128" // Position of the center
            "position_z"    "64"   // Position of the bottom
        }

        "2"
        {
            "position_x"    "320"
            "position_y"    "-108"
            "position_z"    "104"
        }

        "3"
        {
            "position_x"    "2300"
            "position_y"    "-128"
            "position_z"    "64"
        }

        "4"
        {
            "position_x"    "2300"
            "position_y"    "-108"
            "position_z"    "104"
        }
    }
}
```

This is how crates "3" and "4" will look like in the game:

![dod_gan_games](https://i.imgur.com/uxp9rcY.png)
