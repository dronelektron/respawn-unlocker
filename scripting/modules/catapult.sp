static float g_origin[MAX_ENTITIES][3];
static float g_height[MAX_ENTITIES];

float Catapult_GetHeight(int entity) {
    return g_height[entity];
}

void Catapult_Precache() {
    if (PrecacheModel(CATAPULT_MODEL, PRELOAD_YES) == INVALID_MODEL_INDEX) {
        SetFailState("Unable to precache the '%s' model", CATAPULT_MODEL);
    }
}

void Catapult_Add(int client) {
    float origin[3];

    if (!TracePosition(client, origin)) {
        Message_TracingFailed(client);

        return;
    }

    int index = CatapultList_Add();
    char name[CATAPULT_NAME_SIZE];

    GenerateUniqueName(name);
    CatapultList_SetName(index, name);
    CatapultList_SetOrigin(index, origin);
    CatapultList_SetHeight(index, CATAPULT_HEIGHT);
    SpawnCatapult(index);
    HighlightCatapult(client, index);
    Message_CatapultAdded(client, name);
}

void Catapult_Remove(int client, const char[] name) {
    int index = CatapultList_FindByName(name);

    if (index == INVALID_INDEX) {
        Message_CatapultNotFound(client, name);

        return;
    }

    HighlightCatapult(client, index);
    KillCatapult(index);
    CatapultList_Remove(index);
    Message_CatapultRemoved(client, name);
}

void Catapult_SetOrigin(int client, const char[] name) {
    int index = CatapultList_FindByName(name);

    if (index == INVALID_INDEX) {
        Message_CatapultNotFound(client, name);

        return;
    }

    float origin[3];

    if (!TracePosition(client, origin)) {
        Message_TracingFailed(client);

        return;
    }

    CatapultList_SetOrigin(index, origin);
    RespawnCatapult(index);
    HighlightCatapult(client, index);
    Message_CatapultOriginUpdated(client, name);
}

void Catapult_SetHeight(int client, const char[] name) {
    int index = CatapultList_FindByName(name);

    if (index == INVALID_INDEX) {
        Message_CatapultNotFound(client, name);

        return;
    }

    float target[3];

    if (!TracePosition(client, target)) {
        Message_TracingFailed(client);

        return;
    }

    float height = Math_GetCatapultHeight(index, target);

    CatapultList_SetHeight(index, height);
    RespawnCatapult(index);
    HighlightCatapult(client, index);
    Message_CatapultHeightUpdated(client, name);
}

void Catapult_Path(int client, const char[] name) {
    int index = CatapultList_FindByName(name);

    if (index == INVALID_INDEX) {
        Message_CatapultNotFound(client, name);

        return;
    }

    HighlightPath(client, index);
    HighlightCatapult(client, index);
}

static void HighlightPath(int client, int index) {
    float clientMiddle[3];
    float catapultOrigin[3];

    Math_GetMiddle(client, clientMiddle);
    CatapultList_GetOrigin(index, catapultOrigin);
    Visualizer_DrawBeam(client, clientMiddle, catapultOrigin);
}

static void HighlightCatapult(int client, int index) {
    float origin[3];
    float target[3];
    float height = CatapultList_GetHeight(index);

    CatapultList_GetOrigin(index, origin);

    target = origin;
    target[Z] += height;

    Visualizer_DrawBeam(client, origin, target);
}

static bool TracePosition(int client, float position[3]) {
    float origin[3];
    float angles[3];

    GetClientEyePosition(client, origin);
    GetClientEyeAngles(client, angles);
    TR_TraceRayFilter(origin, angles, MASK_ALL, RayType_Infinite, IgnoreClients);
    TR_GetEndPosition(position);

    return TR_DidHit();
}

static bool IgnoreClients(int entity, int contentsMask) {
    return entity > MaxClients;
}

static void GenerateUniqueName(char[] name) {
    do {
        int randomInt = GetRandomInt(0, (1 << 16) - 1);

        FormatEx(name, CATAPULT_NAME_SIZE, "%04X", randomInt);
    } while (CatapultList_FindByName(name) != INVALID_INDEX);
}

void Catapult_ResetEntities() {
    for (int i = 0; i < CatapultList_Size(); i++) {
        CatapultList_SetEntity(i, INVALID_INDEX);
    }
}

void Catapult_ToggleAll(bool enabled) {
    for (int i = 0; i < CatapultList_Size(); i++) {
        if (enabled) {
            SpawnCatapult(i);
        } else {
            KillCatapult(i);
        }
    }
}

void Catapult_Toggle(int client, const char[] name, bool enabled) {
    int index = CatapultList_FindByName(name);

    if (index == INVALID_INDEX) {
        Message_CatapultNotFound(client, name);

        return;
    }

    if (enabled) {
        if (SpawnCatapult(index)) {
            Message_CatapultEnabled(client, name);
        }
    } else {
        if (KillCatapult(index)) {
            Message_CatapultDisabled(client, name);
        }
    }

    HighlightCatapult(client, index);
}

static void RespawnCatapult(int index) {
    if (CatapultList_GetEntity(index) == INVALID_INDEX) {
        return;
    }

    KillCatapult(index);
    SpawnCatapult(index);
}

static bool SpawnCatapult(int index) {
    if (CatapultList_GetEntity(index) != INVALID_INDEX) {
        return false;
    }

    int entity = CreateEntity();

    if (entity == INVALID_INDEX) {
        return false;
    }

    CatapultList_SetEntity(index, entity);
    CatapultList_GetOrigin(index, g_origin[entity]);
    Entity_SetCollisionGroup(entity, COLLISION_GROUP_IN_VEHICLE);
    Entity_SetSolidType(entity, SOLID_TYPE_BBOX);
    Entity_SetSolidFlags(entity, SOLID_FLAG_TRIGGER | SOLID_FLAG_USE_TRIGGER_BOUNDS);
    SdkHook_StartTouchPost(entity);
    SetColor(entity);
    TeleportCatapult(entity);

    g_height[entity] = CatapultList_GetHeight(index);

    return true;
}

static void SetColor(int entity) {
    int red, green, blue;

    Variable_CatapultColor(red, green, blue);
    SetEntityRenderColor(entity, red, green, blue);
}

static void TeleportCatapult(int entity) {
    float mins[3];
    float position[3];

    Entity_GetMins(entity, mins);

    position = g_origin[entity];
    position[Z] -= mins[Z];

    TeleportEntity(entity, position);
}

static bool KillCatapult(int index) {
    if (CatapultList_GetEntity(index) == INVALID_INDEX) {
        return false;
    }

    int entity = CatapultList_GetEntity(index);

    RemoveEntity(entity);
    CatapultList_SetEntity(index, INVALID_INDEX);

    return true;
}

static int CreateEntity() {
    int entity = CreateEntityByName("prop_dynamic_override");

    if (entity == INVALID_INDEX) {
        Message_CatapultNotCreated();

        return INVALID_INDEX;
    }

    DispatchKeyValue(entity, "model", CATAPULT_PATH);

    if (!DispatchSpawn(entity)) {
        Message_CatapultNotSpawned(entity);

        return INVALID_INDEX;
    }

    return entity;
}

void Catapult_OnStartTouchPost(int entity, int client) {
    float velocity[3];

    Entity_GetAbsVelocity(client, velocity);

    velocity[Z] = Math_GetCatapultVelocity(entity);

    TeleportEntity(client, _, _, velocity);
    Sound_Catapult(entity);
}
