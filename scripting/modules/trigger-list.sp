static ArrayList g_triggers;

void TriggerList_Create() {
    g_triggers = new ArrayList();
}

void TriggerList_Clear() {
    for (int i = 0; i < g_triggers.Length; i++) {
        ClearItem(i);
    }

    g_triggers.Clear();
}

int TriggerList_Add() {
    StringMap item = new StringMap();

    return g_triggers.Push(item);
}

void TriggerList_Remove(int index) {
    ClearItem(index);

    g_triggers.Erase(index);
}

int TriggerList_GetHammerId(int index) {
    return GetValue(index, KEY_HAMMER_ID, INVALID_HAMMER_ID);
}

void TriggerList_SetHammerId(int index, int hammerId) {
    GetItem(index).SetValue(KEY_HAMMER_ID, hammerId);
}

int TriggerList_GetEntity(int index) {
    return GetValue(index, KEY_ENTITY, INVALID_INDEX);
}

void TriggerList_SetEntity(int index, int entity) {
    GetItem(index).SetValue(KEY_ENTITY, entity);
}

int TriggerList_FindByHammerId(int hammerId) {
    for (int i = 0; i < g_triggers.Length; i++) {
        if (TriggerList_GetHammerId(i) == hammerId) {
            return i;
        }
    }

    return INVALID_INDEX;
}

int TriggerList_Size() {
    return g_triggers.Length;
}

static void ClearItem(int index) {
    StringMap item = g_triggers.Get(index);

    item.Clear();
}

static StringMap GetItem(int index) {
    return g_triggers.Get(index);
}

static any GetValue(int index, const char[] key, any defaultValue) {
    any value = defaultValue;

    GetItem(index).GetValue(key, value);

    return value;
}
