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

    if (TriggerList_Exists(hammerId)) {
        Message_TriggerAlreadyMarked(client, hammerId);

        return;
    }

    HighlightTrigger(client, entity);
    TriggerList_Add(hammerId);
    Message_TriggerMarked(client, hammerId);
}

void Trigger_Unmark(int client) {
    int entity, hammerId;

    if (!TraceTrigger(client, entity, hammerId)) {
        return;
    }

    if (!TriggerList_Exists(hammerId)) {
        Message_TriggerNotMarked(client, hammerId);

        return;
    }

    HighlightTrigger(client, entity);
    TriggerList_RemoveByHammerId(hammerId);
    Message_TriggerUnmarked(client, hammerId);
}

static bool TraceTrigger(int client, int& entity, int& hammerId) {
    entity = Trigger_Trace(client);

    if (entity <= WORLD) {
        Message_TriggerNotFound(client);

        return false;
    }

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
    Visualizer_DrawBox(client, vertices);
}

void Trigger_Toggle(bool enabled) {
    ToggleByClassName(TRIGGER_HURT, enabled);
    ToggleByClassName(TRIGGER_PUSH, enabled);
    ToggleByClassName(TRIGGER_TELEPORT, enabled);
}

static void ToggleByClassName(const char[] className, bool enabled) {
    int entity = INVALID_INDEX;

    while (FindTrigger(entity, className)) {
        int hammerId = Entity_GetHammerId(entity);

        if (TriggerList_Exists(hammerId)) {
            Entity_SetActivity(entity, enabled);
        }
    }
}

static bool FindTrigger(int& entity, const char[] className) {
    entity = FindEntityByClassname(entity, className);

    return entity > INVALID_INDEX;
}
