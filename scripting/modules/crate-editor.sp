void CreateEditorCrateList() {
    g_editorCrateEntities = new ArrayList();
}

void DestroyEditorCrateList() {
    delete g_editorCrateEntities;
}

void ClearEditorCrateList() {
    g_editorCrateEntities.Clear();
}

void SpawnEditorCrates() {
    DestroyEditorCrates();

    float cratePosition[VECTOR_SIZE];

    for (int i = 0; i < g_cratePositions.Length; i++) {
        g_cratePositions.GetArray(i, cratePosition);

        int crate = SpawnCrate(cratePosition);

        g_editorCrateEntities.Push(crate);
    }
}

void DestroyEditorCrates() {
    for (int i = 0; i < g_editorCrateEntities.Length; i++) {
        int crate = g_editorCrateEntities.Get(i);

        DestroyCrate(crate);
    }

    g_editorCrateEntities.Clear();
}

void DestroyCrate(int crate) {
    AcceptEntityInput(crate, "Kill");
}

void AddCrate(int client, float cratePosition[VECTOR_SIZE]) {
    TracePosition(client, cratePosition);

    int crate = SpawnCrate(cratePosition);

    g_cratePositions.PushArray(cratePosition);
    g_editorCrateEntities.Push(crate);
}

bool RemoveCrate(int client, float cratePosition[VECTOR_SIZE]) {
    int crate = TraceCrate(client);
    int crateIndex = g_editorCrateEntities.FindValue(crate);

    if (crateIndex == CRATE_NOT_FOUND) {
        ReplyCrateNotFound(client);

        return false;
    }

    DestroyCrate(crate);

    g_cratePositions.GetArray(crateIndex, cratePosition);
    g_cratePositions.Erase(crateIndex);
    g_editorCrateEntities.Erase(crateIndex);

    return true;
}

void TracePosition(int client, float position[VECTOR_SIZE]) {
    float eyesPosition[VECTOR_SIZE];
    float eyesAngles[VECTOR_SIZE];

    GetClientEyePosition(client, eyesPosition);
    GetClientEyeAngles(client, eyesAngles);

    Handle trace = TR_TraceRayFilterEx(eyesPosition, eyesAngles, MASK_SHOT, RayType_Infinite, TraceEntityFilter_Players);

    TR_GetEndPosition(position, trace);
    CloseHandle(trace);
}

int TraceCrate(int client) {
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
