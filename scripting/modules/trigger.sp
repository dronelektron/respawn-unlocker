static int g_trigger[MAXPLAYERS + 1];

int Trigger_Trace(int client) {
    float origin[3];
    float angles[3];

    GetClientEyePosition(client, origin);
    GetClientEyeAngles(client, angles);

    g_trigger[client] = INVALID_INDEX;

    TR_EnumerateEntities(origin, angles, PARTITION_TRIGGER_EDICTS, RayType_Infinite, OnEntityTrace, client);

    return g_trigger[client];
}

static bool OnEntityTrace(int entity, int client) {
    g_trigger[client] = entity;

    return false;
}

void Trigger_Mark(int client) {
    int entity, hammerId;

    if (!TraceTrigger(client, entity, hammerId)) {
        return;        
    }

    if (TriggerList_FindByHammerId(hammerId) != INVALID_INDEX) {
        Message_TriggerAlreadyMarked(client, hammerId);

        return;
    }

    int index = TriggerList_Add();

    TriggerList_SetHammerId(index, hammerId);
    TriggerList_SetEntity(index, entity);
    Message_TriggerMarked(client, hammerId);
}

void Trigger_Unmark(int client) {
    int entity, hammerId;

    if (!TraceTrigger(client, entity, hammerId)) {
        return;
    }

    int index = TriggerList_FindByHammerId(hammerId);

    if (index == INVALID_INDEX) {
        Message_TriggerNotMarked(client, hammerId);

        return;
    }

    TriggerList_Remove(index);
    Message_TriggerUnmarked(client, hammerId);
}

static bool TraceTrigger(int client, int& entity, int& hammerId) {
    entity = Trigger_Trace(client);

    if (entity <= WORLD) {
        Message_TriggerNotFound(client);

        return false;
    }

    HighlightTrigger(client, entity);

    hammerId = Entity_GetHammerId(entity);

    if (hammerId == INVALID_HAMMER_ID) {
        Message_TriggerWithoutHammerId(client);

        return false;
    }

    if (TriggerFilter_IsBad(entity)) {
        Message_TriggerTypeNotSupported(client);

        return false;
    }

    return true;
}

static void HighlightPath(int client, int entity) {
    float clientMiddle[3];
    float entityMiddle[3];

    Math_GetMiddle(client, clientMiddle);
    Math_GetMiddle(entity, entityMiddle);
    Visualizer_DrawBeam(client, clientMiddle, entityMiddle, COLOR_WHITE);
}

static void HighlightTrigger(int client, int entity) {
    float origin[3];
    float mins[3];
    float maxs[3];
    float vertices[8][3];

    Entity_GetOrigin(entity, origin);
    Entity_GetMins(entity, mins);
    Entity_GetMaxs(entity, maxs);
    AddVectors(origin, mins, mins);
    AddVectors(origin, maxs, maxs);
    Math_GetVertices(mins, maxs, vertices);
    Visualizer_DrawBox(client, vertices, COLOR_YELLOW);
}

void Trigger_Path(int client, int hammerId) {
    int index = TriggerList_FindByHammerId(hammerId);

    if (index == INVALID_INDEX) {
        Message_TriggerNotFound(client);

        return;
    }

    int entity = TriggerList_GetEntity(index);

    HighlightPath(client, entity);
    HighlightTrigger(client, entity);
}

void Trigger_UpdateEntities() {
    UpdateEntities(TRIGGER_HURT);
    UpdateEntities(TRIGGER_PUSH);
    UpdateEntities(TRIGGER_TELEPORT);
}

static void UpdateEntities(const char[] className) {
    int entity = INVALID_INDEX;

    while (Entity_FindByClassName(entity, className)) {
        int hammerId = Entity_GetHammerId(entity);
        int index = TriggerList_FindByHammerId(hammerId);

        if (index != INVALID_INDEX) {
            TriggerList_SetEntity(index, entity);
        }
    }
}

void Trigger_Toggle(bool enabled) {
    for (int i = 0; i < TriggerList_Size(); i++) {
        int entity = TriggerList_GetEntity(i);

        if (entity != INVALID_INDEX) {
            Entity_SetActivity(entity, enabled);
        }
    }
}
