char g_mapName[MAP_NAME_MAX_LENGTH];
char g_configPath[PLATFORM_MAX_PATH];

void SaveCurrentMapName() {
    GetCurrentMap(g_mapName, sizeof(g_mapName));
}

void BuildConfigPath() {
    BuildPath(Path_SM, g_configPath, sizeof(g_configPath), "configs/respawn-unlocker.txt");
}

void LoadCratesFromFile(KeyValues kv) {
    ClearCrateList();

    if (!kv.JumpToKey(g_mapName) || !kv.GotoFirstSubKey()) {
        LogMessage("No crates for this map");

        return;
    }

    do {
        float cratePosition[POSITION_SIZE];

        cratePosition[0] = kv.GetFloat("position_x");
        cratePosition[1] = kv.GetFloat("position_y");
        cratePosition[2] = kv.GetFloat("position_z");

        AddCrateToList(cratePosition);
    } while (kv.GotoNextKey());

    int cratesCount = GetCratesListSize();

    LogMessage("Loaded %d crates for this map", cratesCount);
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
