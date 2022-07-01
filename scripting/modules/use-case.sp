void UseCase_FindWalls() {
    WallList_Clear();
    UseCase_FindWallsByClassName("func_team_wall");
    UseCase_FindWallsByClassName("func_teamblocker");
}

void UseCase_FindWallsByClassName(const char[] className) {
    int entity = ENTITY_NOT_FOUND;

    while ((entity = FindEntityByClassname(entity, className)) != ENTITY_NOT_FOUND) {
        int collisionGroup = Entity_GetCollisionGroup(entity);

        WallList_Add(entity, collisionGroup);
    }
}

void UseCase_RemoveWalls() {
    if (!Variable_IsWallsEnabled()) {
        return;
    }

    for (int i = 0; i < WallList_Size(); i++) {
        int entity = WallList_GetEntity(i);

        Entity_SetCollisionGroup(entity, COLLISION_GROUP_IN_VEHICLE);
    }

    MessagePrint_WallsRemoved();
}

void UseCase_RestoreWalls() {
    for (int i = 0; i < WallList_Size(); i++) {
        int entity = WallList_GetEntity(i);
        int collisionGroup = WallList_GetCollisionGroup(i);

        Entity_SetCollisionGroup(entity, collisionGroup);
    }
}

void UseCase_AddCrates() {
    if (!Variable_IsCratesEnabled()) {
        return;
    }

    float cratePosition[VECTOR_SIZE];

    for (int i = 0; i < CrateList_Size(); i++) {
        CrateList_Get(i, cratePosition);
        Entity_SpawnCrate(cratePosition);
    }

    MessagePrint_CratesAdded();
}

void UseCase_LoadCrates(int client) {
    CrateStorage_ApplyToKeyValues(CrateStorage_LoadFromFile);
    Message_CratesLoaded(client);
}

void UseCase_SaveCrates(int client) {
    CrateStorage_ApplyToKeyValues(CrateStorage_SaveToFile);
    Message_CratesSaved(client);
}

void UseCase_EnableEditor(int client) {
    Editor_SpawnCrates();
    Message_EditorEnabled(client);
}

void UseCase_DisableEditor(int client) {
    Editor_DestroyCrates();
    Message_EditorDisabled(client);
}

void UseCase_AddCrate(int client) {
    float cratePosition[VECTOR_SIZE];

    Editor_AddCrate(client, cratePosition);
    Message_CrateAdded(client, cratePosition);
}

void UseCase_RemoveCrate(int client) {
    float cratePosition[VECTOR_SIZE];

    if (Editor_RemoveCrate(client, cratePosition)) {
        Message_CrateRemoved(client, cratePosition);
    }
}
