static char g_wallEntityClasses[][] = {"func_team_wall", "func_teamblocker"};

static int g_wallsCount = 0;
static int g_wallEntities[MAX_WALLS_COUNT];
static int g_wallCollisionFlags[MAX_WALLS_COUNT];

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
