#include <sourcemod>
#include <sdktools>

#include "morecolors"

#pragma semicolon 1
#pragma newdecls required

#include "crate"
#include "wall"
#include "message"

public Plugin myinfo = {
    name = "Respawn unlocker",
    author = "Dron-elektron",
    description = "Allows you to unlock respawn at the end of the round",
    version = "1.2.0",
    url = ""
}

public void OnPluginStart() {
    CreateConVars();
    CreateConCmds();
    CreateWallList();
    CreateCrateList();
    BuildConfigPath();
    HookEvent("dod_round_start", Event_RoundStart);
    HookEvent("dod_round_win", Event_RoundWin);
    LoadTranslations("respawn-unlocker.phrases");
    AutoExecConfig(true, "respawn-unlocker");
}

public void OnPluginEnd() {
    DestroyWallList();
    DestroyCrateList();
}

public void OnMapStart() {
    SaveCurrentMapName();
    FindWalls();
    ApplyToKeyValues(LoadCratesFromFile);
}

public Action Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
    RestoreWallsCollisionGroup();

    return Plugin_Continue;
}

public Action Event_RoundWin(Event event, const char[] name, bool dontBroadcast) {
    RemoveWallsCollisionGroup();
    NotifyAboutRespawnUnlocking();
    SpawnCrates();
    NotifyAboutCrates();

    return Plugin_Continue;
}
