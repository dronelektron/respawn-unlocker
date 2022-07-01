static char g_mapName[MAP_NAME_MAX_LENGTH];
static char g_configPath[PLATFORM_MAX_PATH];

void CrateStorage_SaveCurrentMapName() {
    GetCurrentMap(g_mapName, sizeof(g_mapName));
}

void CrateStorage_BuildConfigPath() {
    BuildPath(Path_SM, g_configPath, sizeof(g_configPath), "configs/respawn-unlocker.txt");
}

void CrateStorage_ApplyToKeyValues(KeyValuesCallback callback) {
    KeyValues kv = new KeyValues("Crates");

    if (FileExists(g_configPath)) {
        kv.ImportFromFile(g_configPath);
        kv.Rewind();
    }

    Call_StartFunction(INVALID_HANDLE, callback);
    Call_PushCell(kv);
    Call_Finish();

    delete kv;
}

void CrateStorage_LoadFromFile(KeyValues kv) {
    CrateList_Clear();

    if (!kv.JumpToKey(g_mapName) || !kv.GotoFirstSubKey()) {
        return;
    }

    float cratePosition[VECTOR_SIZE];

    do {
        kv.GetVector(KV_KEY_POSITION, cratePosition);

        CrateList_Add(cratePosition);
    } while (kv.GotoNextKey());
}

void CrateStorage_SaveToFile(KeyValues kv) {
    if (kv.JumpToKey(g_mapName)) {
        kv.DeleteThis();
        kv.Rewind();
    }

    int cratesAmount = CrateList_Size();

    if (cratesAmount > 0) {
        kv.JumpToKey(g_mapName, true);
    }

    char crateId[CRATE_ID_MAX_LENGTH];
    float cratePosition[VECTOR_SIZE];

    for (int i = 0; i < cratesAmount; i++) {
        IntToString(i + 1, crateId, sizeof(crateId));
        CrateList_Get(i, cratePosition);

        kv.JumpToKey(crateId, true);
        kv.SetVector(KV_KEY_POSITION, cratePosition);
        kv.GoBack();
    }

    kv.Rewind();
    kv.ExportToFile(g_configPath);
}
