#include <sourcemod>
#include <sdktools>
#undef REQUIRE_PLUGIN
#include <adminmenu>

#include "morecolors"

#pragma semicolon 1
#pragma newdecls required

#include "ru/crate-editor"
#include "ru/crate-storage"
#include "ru/entity"
#include "ru/menu"
#include "ru/message"

#include "modules/console-command.sp"
#include "modules/console-variable.sp"
#include "modules/crate-editor.sp"
#include "modules/crate-list.sp"
#include "modules/crate-storage.sp"
#include "modules/entity.sp"
#include "modules/menu.sp"
#include "modules/message.sp"
#include "modules/use-case.sp"
#include "modules/wall-list.sp"

public Plugin myinfo = {
    name = "Respawn unlocker",
    author = "Dron-elektron",
    description = "Allows you to unlock respawn at the end of the round",
    version = "1.5.0",
    url = "https://github.com/dronelektron/respawn-unlocker"
};

public void OnPluginStart() {
    Variable_Create();
    Command_Create();
    CrateList_Create();
    WallList_Create();
    CrateEditor_Create();
    AdminMenu_Create();
    CrateStorage_BuildConfigPath();
    HookEvent("dod_round_start", Event_RoundStart);
    HookEvent("dod_round_win", Event_RoundWin);
    LoadTranslations("respawn-unlocker.phrases");
    AutoExecConfig(true, "respawn-unlocker");
}

public void OnPluginEnd() {
    CrateList_Destroy();
    WallList_Destroy();
    CrateEditor_Destroy();
}

public void OnMapStart() {
    CrateStorage_SaveCurrentMapName();
    UseCase_FindWalls();
    UseCase_LoadCrates(CONSOLE);
}

public void OnAdminMenuReady(Handle topMenu) {
    AdminMenu_OnReady(topMenu);
}

public void OnLibraryRemoved(const char[] name) {
    if (strcmp(name, ADMIN_MENU) == 0) {
        AdminMenu_Destroy();
    }
}

public Action Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
    UseCase_RestoreWalls();
    CrateEditor_Clear();

    return Plugin_Continue;
}

public Action Event_RoundWin(Event event, const char[] name, bool dontBroadcast) {
    UseCase_RemoveWalls();
    UseCase_AddCrates();

    return Plugin_Continue;
}
