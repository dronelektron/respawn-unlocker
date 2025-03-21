#include <sourcemod>
#include <sdktools>

#include "respawn-unlocker/entity"
#include "respawn-unlocker/key"
#include "respawn-unlocker/math"
#include "respawn-unlocker/menu"
#include "respawn-unlocker/message"
#include "respawn-unlocker/storage"
#include "respawn-unlocker/trigger-filter"
#include "respawn-unlocker/use-case"
#include "respawn-unlocker/visualizer"
#include "respawn-unlocker/wall"

#include "modules/console-command.sp"
#include "modules/console-variable.sp"
#include "modules/entity.sp"
#include "modules/event.sp"
#include "modules/math.sp"
#include "modules/menu.sp"
#include "modules/message.sp"
#include "modules/storage.sp"
#include "modules/trigger-filter.sp"
#include "modules/trigger-list.sp"
#include "modules/trigger.sp"
#include "modules/use-case.sp"
#include "modules/visualizer.sp"
#include "modules/wall.sp"

public Plugin myinfo = {
    name = "Respawn unlocker",
    author = "Dron-elektron",
    description = "Allows you to unlock the respawn",
    version = "1.6.4",
    url = "https://github.com/dronelektron/respawn-unlocker"
};

public void OnPluginStart() {
    Command_Create();
    Variable_Create();
    Event_Create();
    TriggerFilter_Create();
    TriggerList_Create();
    LoadTranslations("respawn-unlocker.phrases");
    AutoExecConfig(_, "respawn-unlocker");
}

public void OnMapInit(const char[] mapName) {
    Storage_BuildPath(mapName);
    Storage_LoadTriggers();
}

public void OnMapStart() {
    Visualizer_Precache();
}
