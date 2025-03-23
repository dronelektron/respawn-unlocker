static ArrayList g_items;

void CatapultList_Create() {
    g_items = new ArrayList();
}

void CatapultList_Clear() {
    for (int i = 0; i < g_items.Length; i++) {
        ClearItem(i);
    }

    g_items.Clear();
}

int CatapultList_Size() {
    return g_items.Length;
}

int CatapultList_Add() {
    StringMap item = new StringMap();

    return g_items.Push(item);
}

void CatapultList_Remove(int index) {
    ClearItem(index);

    g_items.Erase(index);
}

void CatapultList_GetName(int index, char[] name) {
    GetItem(index).GetString(KEY_NAME, name, CATAPULT_NAME_SIZE);
}

void CatapultList_SetName(int index, const char[] name) {
    GetItem(index).SetString(KEY_NAME, name);
}

void CatapultList_GetOrigin(int index, float origin[3]) {
    GetItem(index).GetArray(KEY_ORIGIN, origin, sizeof(origin));
}

void CatapultList_SetOrigin(int index, const float origin[3]) {
    GetItem(index).SetArray(KEY_ORIGIN, origin, sizeof(origin));
}

float CatapultList_GetHeight(int index) {
    return GetValue(index, KEY_HEIGHT, CATAPULT_HEIGHT);
}

void CatapultList_SetHeight(int index, float height) {
    GetItem(index).SetValue(KEY_HEIGHT, height);
}

int CatapultList_GetEntity(int index) {
    return GetValue(index, KEY_ENTITY, INVALID_INDEX);
}

void CatapultList_SetEntity(int index, int entity) {
    GetItem(index).SetValue(KEY_ENTITY, entity);
}

int CatapultList_FindByName(const char[] name) {
    char tempName[CATAPULT_NAME_SIZE];

    for (int i = 0; i < g_items.Length; i++) {
        CatapultList_GetName(i, tempName);

        if (strcmp(tempName, name) == 0) {
            return i;
        }
    }

    return INVALID_INDEX;
}

static void ClearItem(int index) {
    CloseHandle(GetItem(index));
}

static StringMap GetItem(int index) {
    return g_items.Get(index);
}

static any GetValue(int index, const char[] key, any defaultValue) {
    any value = defaultValue;

    GetItem(index).GetValue(key, value);

    return value;
}
