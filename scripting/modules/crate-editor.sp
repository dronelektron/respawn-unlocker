void CreateEditorCrateList() {
    g_editorCrateEntities = new ArrayList();
}

void DestroyEditorCrateList() {
    delete g_editorCrateEntities;
}

void SpawnEditorCrates() {
    DestroyEditorCrates();

    float cratePosition[POSITION_SIZE];

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

void TracePosition(int client, float position[POSITION_SIZE]) {
    float eyesPosition[POSITION_SIZE];
    float eyesAngles[POSITION_SIZE];

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
