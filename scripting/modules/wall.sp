char g_wallEntityClasses[][] = {"func_team_wall", "func_teamblocker"};

ArrayList g_wallEntities = null;
ArrayList g_wallCollisionGroups = null;

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

int GetWallsListSize() {
    return g_wallEntities.Length;
}

void FindWalls() {
    ClearWallList();

    int entity = ENTITY_NOT_FOUND;

    for (int classIndex = 0; classIndex < sizeof(g_wallEntityClasses); classIndex++) {
        while ((entity = FindEntityByClassname(entity, g_wallEntityClasses[classIndex])) != ENTITY_NOT_FOUND) {
            int collisionGroup = GetCollisionGroup(entity);

            AddWallToList(entity, collisionGroup);
        }
    }
}

void RemoveWallsCollisionGroup() {
    if (!IsWallsEnabled()) {
        return;
    }

    for (int i = 0; i < g_wallEntities.Length; i++) {
        int entity = g_wallEntities.Get(i);

        SetCollisionGroup(entity, COLLISION_GROUP_IN_VEHICLE);
    }
}

void RestoreWallsCollisionGroup() {
    for (int i = 0; i < g_wallEntities.Length; i++) {
        int entity = g_wallEntities.Get(i);
        int collisionGroup = g_wallCollisionGroups.Get(i);

        SetCollisionGroup(entity, collisionGroup);
    }
}

int GetCollisionGroup(int entity) {
    return GetEntProp(entity, Prop_Send, "m_CollisionGroup");
}

void SetCollisionGroup(int entity, int group) {
    SetEntProp(entity, Prop_Send, "m_CollisionGroup", group);
}
