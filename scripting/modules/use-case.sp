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

    if (Variable_IsNotificationsEnabled() && WallList_Size() > 0) {
        MessagePrint_WallsRemoved();
    }
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

    if (Variable_IsNotificationsEnabled() && CrateList_Size() > 0) {
        MessagePrint_CratesAdded();
    }
}

void UseCase_RemoveTriggers() {
    if (!Variable_IsTriggersEnabled) {
        return;
    }

    for (int i = 0; i < TriggerList_Size(); i++) {
        int entity = TriggerList_Get(i);

        Entity_Disable(entity);
    }

    if (Variable_IsNotificationsEnabled() && TriggerList_Size() > 0) {
        MessagePrint_TriggersRemoved();
    }
}

void UseCase_LoadCrates(int client) {
    Storage_ApplyToKeyValues(Storage_LoadCrates);
    Message_CratesLoaded(client);
}

void UseCase_SaveCrates(int client) {
    Storage_ApplyToKeyValues(Storage_SaveCrates);
    Message_CratesSaved(client);
}

void UseCase_EnableEditor(int client) {
    CrateEditor_SpawnCrates();
    Message_EditorEnabled(client);
}

void UseCase_DisableEditor(int client) {
    CrateEditor_DestroyCrates();
    Message_EditorDisabled(client);
}

void UseCase_AddCrate(int client) {
    CrateEditor_AddCrate(client);
    Message_CrateAdded(client);
}

void UseCase_RemoveCrate(int client) {
    if (CrateEditor_RemoveCrate(client)) {
        Message_CrateRemoved(client);
    }
}

void UseCase_AddTriggerToList(int client) {
    int entity = TriggerEditor_SelectTrigger(client);

    if (entity == ENTITY_NOT_FOUND) {
        MessageReply_TriggerNotFound(client);

        return;
    }

    UseCase_VisualizeTrigger(client, entity);

    if (TriggerList_Add(entity)) {
        Message_TriggerAddedToList(client, entity);
    } else {
        MessageReply_TriggerAlreadyAddedToList(client, entity);
    }
}

void UseCase_RemoveTriggerFromList(int client) {
    int entity = TriggerEditor_SelectTrigger(client);

    if (entity == ENTITY_NOT_FOUND) {
        MessageReply_TriggerNotFound(client);

        return;
    }

    UseCase_VisualizeTrigger(client, entity);

    if (TriggerList_Remove(entity)) {
        Message_TriggerRemovedFromList(client, entity);
    } else {
        MessageReply_TriggerAlreadyRemovedFromList(client, entity);
    }
}

void UseCase_VisualizeTrigger(int client, int entity) {
    float entityPosition[VECTOR_SIZE];
    float entityMinBounds[VECTOR_SIZE];
    float entityMaxBounds[VECTOR_SIZE];
    float entityGlobalMinBounds[VECTOR_SIZE];
    float entityGlobalMaxBounds[VECTOR_SIZE];
    float entityVertices[VERTICES_COUNT][VECTOR_SIZE];

    GetEntPropVector(entity, Prop_Send, VECTOR_ORIGIN, entityPosition);
    GetEntPropVector(entity, Prop_Send, VECTOR_BOUNDS_MIN, entityMinBounds);
    GetEntPropVector(entity, Prop_Send, VECTOR_BOUNDS_MAX, entityMaxBounds);

    AddVectors(entityPosition, entityMinBounds, entityGlobalMinBounds);
    AddVectors(entityPosition, entityMaxBounds, entityGlobalMaxBounds);

    Math_CalculateZoneVertices(entityGlobalMinBounds, entityGlobalMaxBounds, entityVertices);
    Visualizer_DrawTrigger(client, entityVertices);
}

void UseCase_LoadTriggers(int client) {
    Storage_ApplyToKeyValues(Storage_LoadTriggers);
    Message_TriggersLoaded(client);
}

void UseCase_SaveTriggers(int client) {
    Storage_ApplyToKeyValues(Storage_SaveTriggers);
    Message_TriggersSaved(client);
}
