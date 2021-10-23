static char g_wallEntityClasses[][] = {"func_team_wall", "func_teamblocker"};

static ArrayList g_wallEntities = null;
static ArrayList g_wallCollisionGroups = null;

void CreateWallList() {
    g_wallEntities = new ArrayList();
    g_wallCollisionGroups = new ArrayList();
}

void DestroyWallList() {
    delete g_wallEntities;
    delete g_wallCollisionGroups;
}

void ClearWallList() {
    g_wallEntities.Clear();
    g_wallCollisionGroups.Clear();
}

void AddWallToList(int entity, int collisionGroup) {
    g_wallEntities.Push(entity);
    g_wallCollisionGroups.Push(collisionGroup);
}

void FindWalls() {
    ClearWallList();

    int entity = ENTITY_NOT_FOUND;

    for (int classIndex = 0; classIndex < sizeof(g_wallEntityClasses); classIndex++) {
        while ((entity = FindEntityByClassname(entity, g_wallEntityClasses[classIndex])) != ENTITY_NOT_FOUND) {
            int collisionGroup = GetCollisionFlags(entity);

            AddWallToList(entity, collisionGroup);
        }
    }
}

void RemoveWallsCollisionFlags() {
    if (!IsWallsEnabled()) {
        return;
    }

    for (int i = 0; i < g_wallEntities.Length; i++) {
        int entity = g_wallEntities.Get(i);

        SetCollisionFlags(entity, COLLISION_GROUP_IN_VEHICLE);
    }
}

void RestoreWallsCollisionFlags() {
    for (int i = 0; i < g_wallEntities.Length; i++) {
        int entity = g_wallEntities.Get(i);
        int collisionGroup = g_wallCollisionGroups.Get(i);

        SetCollisionFlags(entity, collisionGroup);
    }
}

int GetCollisionFlags(int entity) {
    return GetEntProp(entity, Prop_Send, "m_CollisionGroup");
}

void SetCollisionFlags(int entity, int flags) {
    SetEntProp(entity, Prop_Send, "m_CollisionGroup", flags);
}

void NotifyAboutRespawnUnlocking() {
    if (g_wallEntities.Length == 0 || !IsWallsEnabled() || !IsNotificationsEnabled()) {
        return;
    }

    CPrintToChatAll("%s%t", PREFIX_COLORED, "Respawn unlocked");
}
