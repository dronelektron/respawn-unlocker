#include <sourcemod>
#include <sdktools>
#undef REQUIRE_PLUGIN
#include <adminmenu>

#include "ru/entity"
#include "ru/math"
#include "ru/menu"
#include "ru/message"
#include "ru/storage"
#include "ru/visualizer"

#include "modules/console-command.sp"
#include "modules/console-variable.sp"
#include "modules/crate-editor.sp"
#include "modules/crate-list.sp"
#include "modules/entity.sp"
#include "modules/math.sp"
#include "modules/menu.sp"
#include "modules/message.sp"
#include "modules/storage.sp"
#include "modules/trigger-editor.sp"
#include "modules/trigger-list.sp"
#include "modules/use-case.sp"
#include "modules/visualizer.sp"
#include "modules/wall-list.sp"

public Plugin myinfo = {
    name = "Respawn unlocker",
    author = "Dron-elektron",
    description = "Allows you to unlock respawn at the end of the round",
    version = "1.6.3",
    url = "https://github.com/dronelektron/respawn-unlocker"
};

public void OnPluginStart() {
    Variable_Create();
    Command_Create();
    CrateList_Create();
    WallList_Create();
    TriggerList_Create();
    CrateEditor_Create();
    AdminMenu_Create();
    HookEvent("dod_round_start", Event_RoundStart);
    HookEvent("dod_round_win", Event_RoundWin);
    LoadTranslations("respawn-unlocker.phrases");
    AutoExecConfig(true, "respawn-unlocker");
}

public void OnPluginEnd() {
    CrateList_Destroy();
    WallList_Destroy();
    TriggerList_Destroy();
    CrateEditor_Destroy();
}

public void OnMapStart() {
    Storage_BuildConfigPath();
    Visualizer_PrecacheTempEntityModels();
    UseCase_FindWalls();
    UseCase_LoadCrates(CONSOLE);
    UseCase_LoadTriggers(CONSOLE);
}

public void OnClientConnected(int client) {
    TriggerEditor_Reset(client);
}

public void OnAdminMenuReady(Handle topMenu) {
    AdminMenu_OnReady(topMenu);
}

public void OnLibraryRemoved(const char[] name) {
    if (StrEqual(name, ADMIN_MENU)) {
        AdminMenu_Destroy();
    }
}

public Action Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
    UseCase_RestoreWalls();
    CrateEditor_Clear();

    return Plugin_Continue;
}

public Action Event_RoundWin(Event event, const char[] name, bool dontBroadcast) {
    UseCase_DisableWalls();
    UseCase_DisableTriggers();
    UseCase_AddCrates();

    return Plugin_Continue;
}
