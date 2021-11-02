void SaveCurrentMapName() {
    GetCurrentMap(g_mapName, sizeof(g_mapName));
}

void BuildConfigPath() {
    BuildPath(Path_SM, g_configPath, sizeof(g_configPath), "configs/respawn-unlocker.txt");
}

void CreateCrateList() {
    g_cratePositions = new ArrayList(POSITION_SIZE);
}

void DestroyCrateList() {
    delete g_cratePositions;
}

void LoadCratesFromFile(KeyValues kv) {
    g_cratePositions.Clear();

    if (!kv.JumpToKey(g_mapName) || !kv.GotoFirstSubKey()) {
        return;
    }

    float cratePosition[POSITION_SIZE];

    do {
        kv.GetVector(KV_KEY_POSITION, cratePosition);

        g_cratePositions.PushArray(cratePosition);
    } while (kv.GotoNextKey());
}

void SaveCratesToFile(KeyValues kv) {
    if (kv.JumpToKey(g_mapName)) {
        kv.DeleteThis();
        kv.Rewind();
    }

    if (g_cratePositions.Length > 0) {
        kv.JumpToKey(g_mapName, true);
    }

    char crateId[CRATE_ID_MAX_LENGTH];
    float cratePosition[POSITION_SIZE];

    for (int i = 0; i < g_cratePositions.Length; i++) {
        IntToString(i + 1, crateId, sizeof(crateId));

        g_cratePositions.GetArray(i, cratePosition);

        kv.JumpToKey(crateId, true);
        kv.SetVector(KV_KEY_POSITION, cratePosition);
        kv.GoBack();
    }

    kv.Rewind();
    kv.ExportToFile(g_configPath);
}

void ApplyToKeyValues(KeyValuesCallback callback) {
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
