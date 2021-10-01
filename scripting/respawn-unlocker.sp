#include <sourcemod>
#include <sdktools_functions>
#include <morecolors>

#define PREFIX_COLORED "{fuchsia}[Respawn unlocker] "
#define MAX_WALLS_COUNT 32
#define ENTITY_NOT_FOUND -1
#define COLLISION_GROUP_IN_VEHICLE 10
#define MAX_CRATES_COUNT 8

public Plugin myinfo = {
    name = "Respawn unlocker",
    author = "Dron-elektron",
    description = "Allows you to remove invisible walls and add crates near the spawn zone at the end of the round",
    version = "1.1.0",
    url = ""
}

static const char g_wallEntityClasses[][] = {"func_team_wall", "func_teamblocker"};

static int g_wallsCount = 0;
static int g_wallEntities[MAX_WALLS_COUNT];
static int g_wallCollisionFlags[MAX_WALLS_COUNT];

static int g_cratesCount = 0;
static float g_cratePositions[MAX_CRATES_COUNT][3];

static ConVar g_wallsEnabled = null;
static ConVar g_cratesEnabled = null;
static ConVar g_notificationsEnabled = null;

public void OnPluginStart() {
    g_wallsEnabled = CreateConVar("sm_respawnunlocker_walls", "1", "Enable (1) or disable (0) walls removing");
    g_cratesEnabled = CreateConVar("sm_respawnunlocker_crates", "1", "Enable (1) or disable (0) crates adding");
    g_notificationsEnabled = CreateConVar("sm_respawnunlocker_notifications", "1", "Enable (1) or disable (0) notifications");

    HookEvent("dod_round_start", Event_RoundStart);
    HookEvent("dod_round_win", Event_RoundWin);

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
    CreateCrates();
    NotifyAboutCrates();

    return Plugin_Continue;
}

void LoadCrates() {
    char configPath[PLATFORM_MAX_PATH];
    char mapName[256];

    GetCurrentMap(mapName, sizeof(mapName));
    BuildPath(Path_SM, configPath, sizeof(configPath), "configs/respawn-unlocker.txt");

    if (!FileExists(configPath)) {
        return;
    }

    KeyValues kv = new KeyValues("Crates");

    kv.ImportFromFile(configPath);
    g_cratesCount = 0;

    if (!kv.JumpToKey(mapName) || !kv.GotoFirstSubKey()) {
        LogMessage("No crates for this map");

        delete kv;

        return;
    }

    do {
        g_cratePositions[g_cratesCount][0] = kv.GetFloat("position_x");
        g_cratePositions[g_cratesCount][1] = kv.GetFloat("position_y");
        g_cratePositions[g_cratesCount][2] = kv.GetFloat("position_z");
        g_cratesCount++;
    } while (kv.GotoNextKey());

    LogMessage("Loaded %d crates for this map", g_cratesCount);

    delete kv;
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
    if (!IsWallsEnabled()) {
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
    if (g_wallsCount == 0 || !IsWallsEnabled() || !IsNotificationsEnabled()) {
        return;
    }

    CPrintToChatAll("%s%t", PREFIX_COLORED, "Respawn unlocked");
}

void NotifyAboutCrates() {
    if (g_cratesCount == 0 || !IsCratesEnabled() || !IsNotificationsEnabled()) {
        return;
    }

    CPrintToChatAll("%s%t", PREFIX_COLORED, "Crates created");
}

void CreateCrates() {
    if (!IsCratesEnabled()) {
        return;
    }

    for (int crateIndex = 0; crateIndex < g_cratesCount; crateIndex++) {
        CreateCrate(g_cratePositions[crateIndex]);
    }
}

void CreateCrate(const float position[3]) {
    int crate = CreateEntityByName("prop_dynamic_override");

    DispatchKeyValue(crate, "model", "models/props_junk/wood_crate001a.mdl");
    DispatchKeyValue(crate, "disableshadows", "1");
    DispatchKeyValue(crate, "solid", "6");
    DispatchSpawn(crate);

    SetEntityRenderColor(crate, 255, 255, 255, 127);
    SetEntityRenderMode(crate, RENDER_TRANSCOLOR);

    float minBounds[3];
    float newPosition[3];

    GetEntPropVector(crate, Prop_Send, "m_vecMins", minBounds);

    newPosition[0] = position[0];
    newPosition[1] = position[1];
    newPosition[2] = position[2] - minBounds[2];

    TeleportEntity(crate, newPosition, NULL_VECTOR, NULL_VECTOR);
}

bool IsWallsEnabled() {
    return g_wallsEnabled.IntValue == 1;
}

bool IsCratesEnabled() {
    return g_cratesEnabled.IntValue == 1;
}

bool IsNotificationsEnabled() {
    return g_notificationsEnabled.IntValue == 1;
}
