#include <sourcemod>
#include <sdktools>

#include "morecolors"

#pragma semicolon 1
#pragma newdecls required

#include "ru/crate-storage"
#include "ru/editor"
#include "ru/entity"
#include "ru/message"

#include "modules/console-command.sp"
#include "modules/console-variable.sp"
#include "modules/crate-list.sp"
#include "modules/crate-storage.sp"
#include "modules/editor.sp"
#include "modules/entity.sp"
#include "modules/message.sp"
#include "modules/use-case.sp"
#include "modules/wall-list.sp"

public Plugin myinfo = {
    name = "Respawn unlocker",
    author = "Dron-elektron",
    description = "Allows you to unlock respawn at the end of the round",
    version = "1.3.2",
    url = "https://github.com/dronelektron/respawn-unlocker"
};

public void OnPluginStart() {
    Variable_Create();
    Command_Create();
    CrateList_Create();
    WallList_Create();
    Editor_Create();
    CrateStorage_BuildConfigPath();
    HookEvent("dod_round_start", Event_RoundStart);
    HookEvent("dod_round_win", Event_RoundWin);
    LoadTranslations("respawn-unlocker.phrases");
    AutoExecConfig(true, "respawn-unlocker");
}

public void OnPluginEnd() {
    CrateList_Destroy();
    WallList_Destroy();
    Editor_Destroy();
}

public void OnMapStart() {
    CrateStorage_SaveCurrentMapName();
    UseCase_FindWalls();
    UseCase_LoadCrates(CONSOLE);
}

public Action Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
    UseCase_RestoreWalls();
    Editor_Clear();

    return Plugin_Continue;
}

public Action Event_RoundWin(Event event, const char[] name, bool dontBroadcast) {
    UseCase_RemoveWalls();
    UseCase_AddCrates();

    return Plugin_Continue;
}
