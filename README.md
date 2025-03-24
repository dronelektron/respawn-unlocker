# Respawn unlocker

Allows you to unlock the respawn:

* Manage the invisible walls
    * Enable
    * Disable
* Manage the triggers
    * Add to the list
    * Remove from the list
    * Show
    * Save to the file
    * Load from the file
* Manage the catapults
    * Add
    * Remove
    * Set origin
    * Set height
    * Enable
    * Disable
    * Show

Supported wall types:

* func_team_wall
* func_teamblocker

Supported trigger types:

* trigger_hurt
* trigger_push
* trigger_teleport

> [!NOTE]
> Tracing does not work on disabled triggers

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
* sm_respawnunlocker_trigger_mark - Add trigger to the list
* sm_respawnunlocker_trigger_unmark - Remove trigger from the list
* sm_respawnunlocker_trigger_path &lt;hammerid&gt; - Show path to the trigger
* sm_respawnunlocker_triggers_save - Save triggers to the file
* sm_respawnunlocker_triggers_load - Load triggers from the file
* sm_respawnunlocker_catapult_add - Add catapult
* sm_respawnunlocker_catapult_remove &lt;name&gt; - Remove catapult
* sm_respawnunlocker_catapult_enable &lt;name&gt; - Enable catapult
* sm_respawnunlocker_catapult_disable &lt;name&gt; - Disable catapult
* sm_respawnunlocker_catapult_path &lt;name&gt; - Show path to the catapult
* sm_respawnunlocker_catapult_set_origin &lt;name&gt; - Set catapult origin
* sm_respawnunlocker_catapult_set_height &lt;name&gt; - Set catapult height
* sm_respawnunlocker_catapults_save - Save catapults to the file
* sm_respawnunlocker_catapults_load - Load catapults from the file

### Console Variables

* sm_respawnunlocker_auto - Automatic respawn unlock (on - 1, off - 0) [default: "1"]
* sm_respawnunlocker_catapult_color - Catapult color (in HEX) [default: "EE82EE"]
