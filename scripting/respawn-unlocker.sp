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
    HookEvent("dod_round_start", Event_RoundStart);
    HookEvent("dod_round_win", Event_RoundWin);
    LoadTranslations("respawn-unlocker.phrases");
    AutoExecConfig(true, "respawn-unlocker");
}

public void OnPluginEnd() {
    DestroyWallList();
}

public void OnMapStart() {
    FindWalls();
    LoadCrates();
}

public Action Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
    RestoreWallsCollisionFlags();

    return Plugin_Continue;
}

public Action Event_RoundWin(Event event, const char[] name, bool dontBroadcast) {
    RemoveWallsCollisionFlags();
    NotifyAboutRespawnUnlocking();
    SpawnCrates();
    NotifyAboutCrates();

    return Plugin_Continue;
}
