#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

#include "morecolors"
#include "wall"
#include "message"
#include "crate-storage"
#include "crate-editor"

public Plugin myinfo = {
    name = "Respawn unlocker",
    author = "Dron-elektron",
    description = "Allows you to unlock respawn at the end of the round",
    version = "1.3.1",
    url = ""
};

public void OnPluginStart() {
    CreateConVars();
    CreateConCmds();
    CreateWallList();
    CreateCrateList();
    CreateEditorCrateList();
    BuildConfigPath();
    HookEvent("dod_round_start", Event_RoundStart);
    HookEvent("dod_round_win", Event_RoundWin);
    LoadTranslations("respawn-unlocker.phrases");
    AutoExecConfig(true, "respawn-unlocker");
}

public void OnPluginEnd() {
    DestroyWallList();
    DestroyCrateList();
    DestroyEditorCrateList();
}

public void OnMapStart() {
    SaveCurrentMapName();
    FindWalls();
    ApplyToKeyValues(LoadCratesFromFile);
    LogCratesLoaded();
}

public Action Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
    RestoreWallsCollisionGroup();
    ClearEditorCrateList();

    return Plugin_Continue;
}

public Action Event_RoundWin(Event event, const char[] name, bool dontBroadcast) {
    RemoveWallsCollisionGroup();
    NotifyAboutWalls();
    SpawnCrates();
    NotifyAboutCrates();

    return Plugin_Continue;
}
