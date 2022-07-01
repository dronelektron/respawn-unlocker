static ArrayList g_editorCrateEntities = null;

void Editor_Create() {
    g_editorCrateEntities = new ArrayList();
}

void Editor_Destroy() {
    delete g_editorCrateEntities;
}

void Editor_Clear() {
    g_editorCrateEntities.Clear();
}

void Editor_SpawnCrates() {
    Editor_DestroyCrates();

    float cratePosition[VECTOR_SIZE];

    for (int i = 0; i < CrateList_Size(); i++) {
        CrateList_Get(i, cratePosition);

        int crate = Entity_SpawnCrate(cratePosition);

        g_editorCrateEntities.Push(crate);
    }
}

void Editor_DestroyCrates() {
    for (int i = 0; i < g_editorCrateEntities.Length; i++) {
        int crate = g_editorCrateEntities.Get(i);

        Editor_DestroyCrate(crate);
    }

    g_editorCrateEntities.Clear();
}

void Editor_DestroyCrate(int crate) {
    AcceptEntityInput(crate, "Kill");
}

void Editor_AddCrate(int client, float cratePosition[VECTOR_SIZE]) {
    Editor_TracePosition(client, cratePosition);

    int crate = Entity_SpawnCrate(cratePosition);

    CrateList_Add(cratePosition);
    g_editorCrateEntities.Push(crate);
}

bool Editor_RemoveCrate(int client, float cratePosition[VECTOR_SIZE]) {
    int crate = Editor_TraceCrate(client);
    int crateIndex = g_editorCrateEntities.FindValue(crate);

    if (crateIndex == CRATE_NOT_FOUND) {
        MessageReply_CrateNotFound(client);

        return false;
    }

    Editor_DestroyCrate(crate);

    CrateList_Get(crateIndex, cratePosition);
    CrateList_Remove(crateIndex);
    g_editorCrateEntities.Erase(crateIndex);

    return true;
}

void Editor_TracePosition(int client, float position[VECTOR_SIZE]) {
    float eyesPosition[VECTOR_SIZE];
    float eyesAngles[VECTOR_SIZE];

    GetClientEyePosition(client, eyesPosition);
    GetClientEyeAngles(client, eyesAngles);

    Handle trace = TR_TraceRayFilterEx(eyesPosition, eyesAngles, MASK_SHOT, RayType_Infinite, TraceEntityFilter_Players);

    TR_GetEndPosition(position, trace);
    CloseHandle(trace);
}

int Editor_TraceCrate(int client) {
    float eyesPosition[3];
    float eyesAngles[3];

    GetClientEyePosition(client, eyesPosition);
    GetClientEyeAngles(client, eyesAngles);

    Handle trace = TR_TraceRayFilterEx(eyesPosition, eyesAngles, MASK_SHOT, RayType_Infinite, TraceEntityFilter_Players);
    int crate = TR_GetEntityIndex(trace);

    CloseHandle(trace);

    return crate;
}

bool TraceEntityFilter_Players(int entity, int contentsMask) {
    return entity > MaxClients;
}
