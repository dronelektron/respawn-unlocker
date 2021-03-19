#include <sourcemod>
#include <sdktools_functions>
#include <morecolors>

#define PREFIX_COLORED "{fuchsia}[Respawn unlocker] "
#define MAX_WALLS_COUNT 32
#define ENTITY_NOT_FOUND -1
#define COLLISION_GROUP_IN_VEHICLE 10

public Plugin myinfo = {
    name = "Respawn unlocker",
    author = "Dron-elektron",
    description = "Allows to unlock respawn at the end of the round",
    version = "1.0.0",
    url = ""
}

static const char g_wallEntityClasses[][] = {"func_team_wall", "func_teamblocker"};

static int g_wallsCount = 0;
static int g_wallEntities[MAX_WALLS_COUNT];
static int g_wallCollisionFlags[MAX_WALLS_COUNT];

static ConVar g_pluginEnabled = null;
static ConVar g_notificationsEnabled = null;

public void OnPluginStart() {
    g_pluginEnabled = CreateConVar("sm_respawnunlocker_enable", "1", "Enable (1) or disable (0) plugin");
    g_notificationsEnabled = CreateConVar("sm_respawnunlocker_notifications", "1", "Enable (1) or disable (0) notifications");

    HookEvent("dod_round_start", Event_RoundStart);
    HookEvent("dod_round_win", Event_RoundWin);

    LoadTranslations("respawn-unlocker.phrases");
    AutoExecConfig(true, "respawn-unlocker");
}

public void OnMapStart() {
    FindWallEntities();
    SaveWallsCollisionFlags();
}

public Action Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
    RestoreWallsCollisionFlags()

    return Plugin_Continue;
}

public Action Event_RoundWin(Event event, const char[] name, bool dontBroadcast) {
    RemoveWallsCollisionFlags();
    NotifyAboutRespawnUnlocking();

    return Plugin_Continue;
}

void FindWallEntities() {
    int wallIndex = 0;
    int entity = ENTITY_NOT_FOUND;

    for (int classIndex = 0; classIndex < sizeof(g_wallEntityClasses); classIndex++) {
        while ((entity = FindEntityByClassname(entity, g_wallEntityClasses[classIndex])) != ENTITY_NOT_FOUND) {
            g_wallEntities[wallIndex++] = entity;
        }
    }

    g_wallsCount = wallIndex;
}

void SaveWallsCollisionFlags() {
    for (int wallIndex = 0; wallIndex < g_wallsCount; wallIndex++) {
        int entity = g_wallEntities[wallIndex];

        g_wallCollisionFlags[wallIndex] = GetCollisionFlags(entity);
    }
}

void RemoveWallsCollisionFlags() {
    if (!IsPluginEnabled()) {
        return;
    }

    for (int wallIndex = 0; wallIndex < g_wallsCount; wallIndex++) {
        int entity = g_wallEntities[wallIndex];

        SetCollisionFlags(entity, COLLISION_GROUP_IN_VEHICLE);
    }
}

void RestoreWallsCollisionFlags() {
    for (int wallIndex = 0; wallIndex < g_wallsCount; wallIndex++) {
        int entity = g_wallEntities[wallIndex];

        SetCollisionFlags(entity, g_wallCollisionFlags[wallIndex]);
    }
}

int GetCollisionFlags(int entity) {
    return GetEntProp(entity, Prop_Send, "m_CollisionGroup");
}

void SetCollisionFlags(int entity, int flags) {
    SetEntProp(entity, Prop_Send, "m_CollisionGroup", flags);
}

void NotifyAboutRespawnUnlocking() {
    if (g_wallsCount == 0 || !IsPluginEnabled() || !IsNotificationsEnabled()) {
        return;
    }

    CPrintToChatAll("%s%t", PREFIX_COLORED, "Respawn unlocked");
}

bool IsPluginEnabled() {
    return g_pluginEnabled.IntValue == 1;
}

bool IsNotificationsEnabled() {
    return g_notificationsEnabled.IntValue == 1;
}
