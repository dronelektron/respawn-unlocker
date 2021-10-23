static char g_mapName[MAP_NAME_MAX_LENGTH];
static char g_configPath[PLATFORM_MAX_PATH];

static ArrayList g_cratePositions = null;

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

void ClearCrateList() {
    g_cratePositions.Clear();
}

void AddCrateToList(float cratePosition[POSITION_SIZE]) {
    g_cratePositions.PushArray(cratePosition);
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

    int cratesCount = g_cratePositions.Length;

    LogMessage("Loaded %d crates for this map", cratesCount);
}

void NotifyAboutCrates() {
    if (g_cratePositions.Length == 0 || !IsCratesEnabled() || !IsNotificationsEnabled()) {
        return;
    }

    CPrintToChatAll("%s%t", PREFIX_COLORED, "Crates created");
}

void SpawnCrates() {
    if (!IsCratesEnabled()) {
        return;
    }

    float cratePosition[POSITION_SIZE];

    for (int i = 0; i < g_cratePositions.Length; i++) {
        g_cratePositions.GetArray(i, cratePosition);

        SpawnCrate(cratePosition);
    }
}

void SpawnCrate(float position[POSITION_SIZE]) {
    int crate = CreateEntityByName("prop_dynamic_override");

    DispatchKeyValue(crate, "model", "models/props_junk/wood_crate001a.mdl");
    DispatchKeyValue(crate, "disableshadows", "1");
    DispatchKeyValue(crate, "solid", "6");
    DispatchSpawn(crate);

    SetEntityRenderColor(crate, 255, 255, 255, 127);
    SetEntityRenderMode(crate, RENDER_TRANSCOLOR);

    float minBounds[POSITION_SIZE];
    float newPosition[POSITION_SIZE];

    GetEntPropVector(crate, Prop_Send, "m_vecMins", minBounds);

    newPosition[0] = position[0];
    newPosition[1] = position[1];
    newPosition[2] = position[2] - minBounds[2];

    TeleportEntity(crate, newPosition, NULL_VECTOR, NULL_VECTOR);
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
