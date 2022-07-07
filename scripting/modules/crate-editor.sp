static ArrayList g_editorCrateEntities = null;

void CrateEditor_Create() {
    g_editorCrateEntities = new ArrayList();
}

void CrateEditor_Destroy() {
    delete g_editorCrateEntities;
}

void CrateEditor_Clear() {
    g_editorCrateEntities.Clear();
}

void CrateEditor_SpawnCrates() {
    CrateEditor_DestroyCrates();

    float cratePosition[VECTOR_SIZE];

    for (int i = 0; i < CrateList_Size(); i++) {
        CrateList_Get(i, cratePosition);

        int crate = Entity_SpawnCrate(cratePosition);

        g_editorCrateEntities.Push(crate);
    }
}

void CrateEditor_DestroyCrates() {
    for (int i = 0; i < g_editorCrateEntities.Length; i++) {
        int crate = g_editorCrateEntities.Get(i);

        RemoveEntity(crate);
    }

    CrateEditor_Clear();
}

void CrateEditor_AddCrate(int client) {
    float cratePosition[VECTOR_SIZE];

    CrateEditor_TracePosition(client, cratePosition);

    int crate = Entity_SpawnCrate(cratePosition);

    CrateList_Add(cratePosition);
    g_editorCrateEntities.Push(crate);
}

bool CrateEditor_RemoveCrate(int client) {
    int crate = CrateEditor_TraceCrate(client);
    int crateIndex = g_editorCrateEntities.FindValue(crate);

    if (crateIndex == ENTITY_NOT_FOUND) {
        MessageReply_CrateNotFound(client);

        return false;
    }

    RemoveEntity(crate);
    CrateList_Remove(crateIndex);
    g_editorCrateEntities.Erase(crateIndex);

    return true;
}

void CrateEditor_TracePosition(int client, float position[VECTOR_SIZE]) {
    float eyesPosition[VECTOR_SIZE];
    float eyesAngles[VECTOR_SIZE];

    GetClientEyePosition(client, eyesPosition);
    GetClientEyeAngles(client, eyesAngles);

    Handle trace = TR_TraceRayFilterEx(eyesPosition, eyesAngles, MASK_SHOT, RayType_Infinite, TraceEntityFilter_Players);

    TR_GetEndPosition(position, trace);
    CloseHandle(trace);
}

int CrateEditor_TraceCrate(int client) {
    float eyesPosition[VECTOR_SIZE];
    float eyesAngles[VECTOR_SIZE];

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
