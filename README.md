# Respawn unlocker

Allows you to unlock the respawn:

* Enable / Disable invisible walls
* Enable / Disable triggers

Supported trigger types:

* trigger_hurt
* trigger_push
* trigger_teleport

### Supported Games

* Day of Defeat: Source

### Requirements

* [SourceMod](https://www.sourcemod.net) 1.11 or later

### Installation

* Download latest [release](https://github.com/dronelektron/respawn-unlocker/releases)
* Extract `plugins` and `translations` folders to `addons/sourcemod` folder of your server

### Console Commands

* sm_respawnunlocker - Open the menu
* sm_respawnunlocker_lock - Lock the respawn
* sm_respawnunlocker_unlock - Unlock the respawn
* sm_respawnunlocker_trigger_mark - Add a trigger to the list
* sm_respawnunlocker_trigger_unmark - Remove a trigger from the list
* sm_respawnunlocker_trigger_path &lt;hammerid&gt; - Show the path to the trigger
* sm_respawnunlocker_triggers_save - Save the triggers to the file
* sm_respawnunlocker_triggers_load - Load the triggers from the file

### Console Variables

* sm_respawnunlocker_auto - Automatic respawn unlock (on - 1, off - 0) [default: "1"]
