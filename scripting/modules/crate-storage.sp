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
        LogMessage("No crates for this map");

        return;
    }

    do {
        float cratePosition[POSITION_SIZE];

        cratePosition[0] = kv.GetFloat("position_x");
        cratePosition[1] = kv.GetFloat("position_y");
        cratePosition[2] = kv.GetFloat("position_z");

        g_cratePositions.PushArray(cratePosition);
    } while (kv.GotoNextKey());

    LogMessage("Loaded %d crates for this map", g_cratePositions.Length);
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
