#include <sourcemod>
#include <sdktools>

#include "respawn-unlocker/entity"
#include "respawn-unlocker/message"
#include "respawn-unlocker/use-case"
#include "respawn-unlocker/wall"

#include "modules/console-command.sp"
#include "modules/console-variable.sp"
#include "modules/entity.sp"
#include "modules/event.sp"
#include "modules/message.sp"
#include "modules/use-case.sp"
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
    LoadTranslations("respawn-unlocker.phrases");
    AutoExecConfig(_, "respawn-unlocker");
}
