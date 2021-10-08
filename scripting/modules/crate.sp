static int g_cratesCount = 0;
static float g_cratePositions[MAX_CRATES_COUNT][3];

void LoadCrates() {
    char configPath[PLATFORM_MAX_PATH];
    char mapName[256];

    GetCurrentMap(mapName, sizeof(mapName));
    BuildPath(Path_SM, configPath, sizeof(configPath), "configs/respawn-unlocker.txt");

    if (!FileExists(configPath)) {
        return;
    }

    KeyValues kv = new KeyValues("Crates");

    kv.ImportFromFile(configPath);
    g_cratesCount = 0;

    if (!kv.JumpToKey(mapName) || !kv.GotoFirstSubKey()) {
        LogMessage("No crates for this map");

        delete kv;

        return;
    }

    do {
        g_cratePositions[g_cratesCount][0] = kv.GetFloat("position_x");
        g_cratePositions[g_cratesCount][1] = kv.GetFloat("position_y");
        g_cratePositions[g_cratesCount][2] = kv.GetFloat("position_z");
        g_cratesCount++;
    } while (kv.GotoNextKey());

    LogMessage("Loaded %d crates for this map", g_cratesCount);

    delete kv;
}

void NotifyAboutCrates() {
    if (g_cratesCount == 0 || !IsCratesEnabled() || !IsNotificationsEnabled()) {
        return;
    }

    CPrintToChatAll("%s%t", PREFIX_COLORED, "Crates created");
}

void SpawnCrates() {
    if (!IsCratesEnabled()) {
        return;
    }

    for (int crateIndex = 0; crateIndex < g_cratesCount; crateIndex++) {
        SpawnCrate(g_cratePositions[crateIndex]);
    }
}

void SpawnCrate(const float position[3]) {
    int crate = CreateEntityByName("prop_dynamic_override");

    DispatchKeyValue(crate, "model", "models/props_junk/wood_crate001a.mdl");
    DispatchKeyValue(crate, "disableshadows", "1");
    DispatchKeyValue(crate, "solid", "6");
    DispatchSpawn(crate);

    SetEntityRenderColor(crate, 255, 255, 255, 127);
    SetEntityRenderMode(crate, RENDER_TRANSCOLOR);

    float minBounds[3];
    float newPosition[3];

    GetEntPropVector(crate, Prop_Send, "m_vecMins", minBounds);

    newPosition[0] = position[0];
    newPosition[1] = position[1];
    newPosition[2] = position[2] - minBounds[2];

    TeleportEntity(crate, newPosition, NULL_VECTOR, NULL_VECTOR);
}
