static char g_configPath[PLATFORM_MAX_PATH];

void Storage_BuildConfigPath() {
    BuildPath(Path_SM, g_configPath, sizeof(g_configPath), "configs/respawn-unlocker");

    if (!DirExists(g_configPath)) {
        CreateDirectory(g_configPath, PERMISSIONS);
    }

    char mapName[PLATFORM_MAX_PATH];

    GetCurrentMap(mapName, sizeof(mapName));
    Format(g_configPath, sizeof(g_configPath), "%s/%s.txt", g_configPath, mapName);
}

void Storage_ApplyToKeyValues(KeyValuesCallback callback) {
    KeyValues kv = new KeyValues(KEY_ROOT);

    if (FileExists(g_configPath)) {
        kv.ImportFromFile(g_configPath);
        kv.Rewind();
    }

    Call_StartFunction(INVALID_HANDLE, callback);
    Call_PushCell(kv);
    Call_Finish();

    delete kv;
}

void Storage_LoadCrates(KeyValues kv) {
    CrateList_Clear();

    if (!kv.JumpToKey(KEY_CRATES) || !kv.GotoFirstSubKey()) {
        return;
    }

    float cratePosition[VECTOR_SIZE];

    do {
        kv.GetVector(KEY_CRATE_POSITION, cratePosition);

        CrateList_Add(cratePosition);
    } while (kv.GotoNextKey());
}

void Storage_SaveCrates(KeyValues kv) {
    if (kv.JumpToKey(KEY_CRATES)) {
        kv.DeleteThis();
        kv.Rewind();
    }

    int cratesAmount = CrateList_Size();

    if (cratesAmount > 0) {
        kv.JumpToKey(KEY_CRATES, CREATE_YES);
    }

    char crateId[ID_MAX_LENGTH];
    float cratePosition[VECTOR_SIZE];

    for (int i = 0; i < cratesAmount; i++) {
        IntToString(i + 1, crateId, sizeof(crateId));
        CrateList_Get(i, cratePosition);

        kv.JumpToKey(crateId, CREATE_YES);
        kv.SetVector(KEY_CRATE_POSITION, cratePosition);
        kv.GoBack();
    }

    kv.Rewind();
    kv.ExportToFile(g_configPath);
}

void Storage_LoadTriggers(KeyValues kv) {
    TriggerList_Clear();

    if (!kv.JumpToKey(KEY_TRIGGERS) || !kv.GotoFirstSubKey()) {
        return;
    }

    do {
        int entity = kv.GetNum(KEY_TRIGGER_ENTITY);

        TriggerList_Add(entity);
    } while (kv.GotoNextKey());
}

void Storage_SaveTriggers(KeyValues kv) {
    if (kv.JumpToKey(KEY_TRIGGERS)) {
        kv.DeleteThis();
        kv.Rewind();
    }

    int triggersAmount = TriggerList_Size();

    if (triggersAmount > 0) {
        kv.JumpToKey(KEY_TRIGGERS, CREATE_YES);
    }

    char triggerId[ID_MAX_LENGTH];

    for (int i = 0; i < triggersAmount; i++) {
        IntToString(i + 1, triggerId, sizeof(triggerId));

        int entity = TriggerList_Get(i);

        kv.JumpToKey(triggerId, CREATE_YES);
        kv.SetNum(KEY_TRIGGER_ENTITY, entity);
        kv.GoBack();
    }

    kv.Rewind();
    kv.ExportToFile(g_configPath);
}
