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

        int hammerId = TriggerList_GetHammerId(i);

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
            int index = TriggerList_Add();

            TriggerList_SetHammerId(index, hammerId);
            TriggerList_SetEntity(index, INVALID_INDEX);
        }
    } while (kv.GotoNextKey());
}

void Storage_SaveCatapults() {
    KeyValues kv = LoadKeyValues();

    SaveCatapults(kv);
    SaveKeyValues(kv);
    CloseHandle(kv);
}

static void SaveCatapults(KeyValues kv) {
    if (kv.JumpToKey(SECTION_CATAPULTS)) {
        kv.DeleteThis();
    }

    int catapultsAmount = CatapultList_Size();

    if (catapultsAmount == 0) {
        return;
    }

    kv.JumpToKey(SECTION_CATAPULTS, CREATE_YES);

    for (int i = 0; i < catapultsAmount; i++) {
        char name[CATAPULT_NAME_SIZE];
        float origin[3];

        CatapultList_GetName(i, name);
        CatapultList_GetOrigin(i, origin);

        float height = CatapultList_GetHeight(i);

        kv.JumpToKey(name, CREATE_YES);
        kv.SetVector(KEY_ORIGIN, origin);
        kv.SetFloat(KEY_HEIGHT, height);
        kv.GoBack();
    }
}

void Storage_LoadCatapults() {
    KeyValues kv = LoadKeyValues();

    LoadCatapults(kv);
    CloseHandle(kv);
}

static void LoadCatapults(KeyValues kv) {
    CatapultList_Clear();

    if (!kv.JumpToKey(SECTION_CATAPULTS) || !kv.GotoFirstSubKey()) {
        return;
    }

    do {
        char name[CATAPULT_NAME_SIZE];
        float origin[3];

        kv.GetSectionName(name, sizeof(name));
        kv.GetVector(KEY_ORIGIN, origin);

        float height = kv.GetFloat(KEY_HEIGHT, CATAPULT_HEIGHT);
        int index = CatapultList_Add();

        CatapultList_SetName(index, name);
        CatapultList_SetOrigin(index, origin);
        CatapultList_SetHeight(index, height);
    } while (kv.GotoNextKey());
}

static KeyValues LoadKeyValues() {
    KeyValues kv = new KeyValues("RespawnUnlocker");

    kv.ImportFromFile(g_configPath);

    return kv;
}

static void SaveKeyValues(KeyValues kv) {
    if (TriggerList_Size() == 0 && CatapultList_Size() == 0) {
        DeleteFile(g_configPath);

        return;
    }

    kv.Rewind();
    kv.ExportToFile(g_configPath);
}
