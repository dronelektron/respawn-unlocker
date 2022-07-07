# Respawn unlocker

Allows you to unlock respawn at the end of the round:

* Disable invisible walls
* Disable triggers
* Add crates

### Supported Games

* Day of Defeat: Source

### Installation

* Download latest [release](https://github.com/dronelektron/respawn-unlocker/releases) (compiled for SourceMod 1.10)
* Extract "plugins" and "translations" folders to "addons/sourcemod" folder of your server

### Console Variables

* sm_respawnunlocker_walls - Enable (1) or disable (0) walls removing [default: "1"]
* sm_respawnunlocker_crates - Enable (1) or disable (0) crates adding [default: "1"]
* sm_respawnunlocker_triggers - Enable (1) or disable (0) triggers removing [default: "1"]
* sm_respawnunlocker_notifications - Enable (1) or disable (0) notifications [default: "1"]
* sm_respawnunlocker_crate_color_red - Crate color (red channel) [default: "0"]
* sm_respawnunlocker_crate_color_green - Crate color (green channel) [default: "255"]
* sm_respawnunlocker_crate_color_blue - Crate color (blue channel) [default: "255"]
* sm_respawnunlocker_crate_color_alpha - Crate color (alpha channel) [default: "255"]

### Console Commands

* sm_respawnunlocker_crates_load - Load crates from the file
* sm_respawnunlocker_crates_save - Save crates to the file
* sm_respawnunlocker_editor_enable - Enable crates editor (will spawn crates)
* sm_respawnunlocker_editor_disable - Disable crates editor (will destroy crates)
* sm_respawnunlocker_editor_crate_add - Add a crate
* sm_respawnunlocker_editor_crate_remove - Remove a crate
* sm_respawnunlocker_trigger_add - Add a trigger to the list
* sm_respawnunlocker_trigger_remove - Remove a trigger from the list
* sm_respawnunlocker_triggers_load - Load triggers from the file
* sm_respawnunlocker_triggers_save - Save triggers to the file

### Crates Storage

Each map has its own configuration file:

```
addons/sourcemod/configs/respawn-unlocker/{map_name}.txt
```

This file will have the following structure:

```
"Entities"
{
    "Crates"
    {
        "1"
        {
            // X, Y - position of the center, Z - position of the bottom
            "position"      "-157.499695 1407.957275 -255.968750"
        }
        "2"
        {
            "position"      "224.163727 1086.800537 -255.968750"
        }
        "3"
        {
            "position"      "205.046783 1086.626831 -216.018341"
        }
    }
    "Triggers"
    {
        "1"
        {
            "entity"        "140"
        }
        "2"
        {
            "entity"        "233"
        }
    }
}
```

What the crates will look at the end of the round:

![dod_gan_games](https://i.imgur.com/ZNyOoSg.jpeg)
