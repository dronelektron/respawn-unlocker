#pragma semicolon 1

#include <sourcemod>
#include <sdktools>

#include "morecolors"

#pragma newdecls required

#include "crate"
#include "wall"
#include "message"

public Plugin myinfo = {
    name = "Respawn unlocker",
    author = "Dron-elektron",
    description = "Allows you to unlock respawn at the end of the round",
    version = "1.1.1",
    url = ""
}

public void OnPluginStart() {
    HookEvent("dod_round_start", Event_RoundStart);
    HookEvent("dod_round_win", Event_RoundWin);

    CreateConVars();
    CreateConCmds();
    LoadTranslations("respawn-unlocker.phrases");
    AutoExecConfig(true, "respawn-unlocker");
}

public void OnMapStart() {
    FindWallEntities();
    SaveWallsCollisionFlags();
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
