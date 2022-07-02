# Respawn Unlocker

Allows you to unlock respawn at the end of the round:

* Remove invisible walls
* Add crates

### Supported Games

* Day of Defeat: Source

### Installation

* Download latest [release](https://github.com/dronelektron/respawn-unlocker/releases) (compiled for SourceMod 1.10)
* Extract "plugins" and "translations" folders to "addons/sourcemod" folder of your server

### Console Variables

* sm_respawnunlocker_walls - Enable (1) or disable (0) walls removing [default: "1"]
* sm_respawnunlocker_crates - Enable (1) or disable (0) crates adding [default: "1"]
* sm_respawnunlocker_notifications - Enable (1) or disable (0) notifications [default: "1"]
* sm_respawnunlocker_crate_color_red - Crate color (red channel) [default: "0"]
* sm_respawnunlocker_crate_color_green - Crate color (green channel) [default: "255"]
* sm_respawnunlocker_crate_color_blue - Crate color (blue channel) [default: "255"]
* sm_respawnunlocker_crate_color_alpha - Crate color (alpha channel) [default: "255"]

### Console Commands

* sm_respawnunlocker_crates_load - Load crates from file
* sm_respawnunlocker_crates_save - Save crates to file
* sm_respawnunlocker_editor_enable - Enable crates editor (will spawn crates)
* sm_respawnunlocker_editor_disable - Disable crates editor (will destroy crates)
* sm_respawnunlocker_editor_crate_add - Add a crate where you are looking
* sm_respawnunlocker_editor_crate_remove - Remove a crate where you are looking

### Crates Storage

The crates config file should be created in the following location:

```
addons/sourcemod/configs/respawn-unlocker.txt
```

This file will have the following structure:

```
"Crates"
{
    // Map name
    "dod_gan_games"
    {
        // Crate's number
        "1"
        {
            // X, Y - position of the center, Z - position of the bottom
            "position"      "320.000000 -128.000000 64.000000"
        }
        "2"
        {
            "position"      "320.000000 -108.000000 104.000000"
        }
        "3"
        {
            "position"      "2300.000000 -128.000000 64.000000"
        }
        "4"
        {
            "position"      "2300.000000 -108.000000 104.000000"
        }
    }
}
```

This is how crates "3" and "4" will look like in the game:

![dod_gan_games](https://i.imgur.com/uxp9rcY.png)
