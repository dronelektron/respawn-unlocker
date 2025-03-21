static char g_configPath[PLATFORM_MAX_PATH];

void Storage_BuildPath(const char[] mapName) {
    BuildPath(Path_SM, g_configPath, sizeof(g_configPath), "configs/respawn-unlocker");

    if (!DirExists(g_configPath)) {
        CreateDirectory(g_configPath, PERMISSIONS);
    }

    Format(g_configPath, sizeof(g_configPath), "%s/%s.txt", g_configPath, mapName);
}

void Storage_SaveTriggers() {
    KeyValues kv = LoadKeyValues();

    SaveTriggers(kv);
    SaveKeyValues(kv);
    CloseHandle(kv);
}

static void SaveTriggers(KeyValues kv) {
    if (kv.JumpToKey(SECTION_TRIGGERS)) {
        kv.DeleteThis();
    }

    int triggersAmount = TriggerList_Size();

    if (triggersAmount == 0) {
        return;
    }

    kv.JumpToKey(SECTION_TRIGGERS, CREATE_YES);

    for (int i = 0; i < triggersAmount; i++) {
        char key[SECTION_SIZE];

        IntToString(i, key, sizeof(key));

        int hammerId = TriggerList_Get(i);

        kv.JumpToKey(key, CREATE_YES);
        kv.SetNum(KEY_HAMMER_ID, hammerId);
        kv.GoBack();
    }
}

void Storage_LoadTriggers() {
    KeyValues kv = LoadKeyValues();

    LoadTriggers(kv);
    CloseHandle(kv);
}

static void LoadTriggers(KeyValues kv) {
    TriggerList_Clear();

    if (!kv.JumpToKey(SECTION_TRIGGERS) || !kv.GotoFirstSubKey()) {
        return;
    }

    do {
        int hammerId = kv.GetNum(KEY_HAMMER_ID, INVALID_HAMMER_ID);

        if (hammerId != INVALID_HAMMER_ID) {
            TriggerList_Add(hammerId);
        }
    } while (kv.GotoNextKey());
}

static KeyValues LoadKeyValues() {
    KeyValues kv = new KeyValues("RespawnUnlocker");

    kv.ImportFromFile(g_configPath);

    return kv;
}

static void SaveKeyValues(KeyValues kv) {
    if (TriggerList_Size() == 0) {
        DeleteFile(g_configPath);

        return;
    }

    kv.Rewind();
    kv.ExportToFile(g_configPath);
}
