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

    TriggerList_RemoveByHammerId(hammerId);
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
    Visualizer_DrawBeam(client, clientMiddle, entityMiddle);
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

void Trigger_Path(int client, int hammerId) {
    int entity = FindTriggerByHammerId(hammerId);

    if (entity == INVALID_INDEX) {
        Message_TriggerNotFound(client);

        return;
    }

    HighlightPath(client, entity);
    HighlightTrigger(client, entity);
}

static int FindTriggerByHammerId(int hammerId) {
    int entity = INVALID_INDEX;

    entity = GetMaxIndex(entity, FindTriggerByClassName(TRIGGER_HURT, hammerId));
    entity = GetMaxIndex(entity, FindTriggerByClassName(TRIGGER_PUSH, hammerId));
    entity = GetMaxIndex(entity, FindTriggerByClassName(TRIGGER_TELEPORT, hammerId));

    return entity;
}

static int FindTriggerByClassName(const char[] className, int hammerId) {
    int entity = INVALID_INDEX;

    while (Entity_FindByClassName(entity, className)) {
        if (Entity_GetHammerId(entity) == hammerId) {
            break;
        }
    }

    return entity;
}

static int GetMaxIndex(int index1, int index2) {
    return index1 > index2 ? index1 : index2;
}

void Trigger_Toggle(bool enabled) {
    ToggleByClassName(TRIGGER_HURT, enabled);
    ToggleByClassName(TRIGGER_PUSH, enabled);
    ToggleByClassName(TRIGGER_TELEPORT, enabled);
}

static void ToggleByClassName(const char[] className, bool enabled) {
    int entity = INVALID_INDEX;

    while (Entity_FindByClassName(entity, className)) {
        int hammerId = Entity_GetHammerId(entity);

        if (TriggerList_Exists(hammerId)) {
            Entity_SetActivity(entity, enabled);
        }
    }
}
