static ArrayList g_entities = null;

void TriggerList_Create() {
    g_entities = new ArrayList();
}

void TriggerList_Destroy() {
    delete g_entities;
}

void TriggerList_Clear() {
    g_entities.Clear();
}

int TriggerList_Size() {
    return g_entities.Length;
}

int TriggerList_Get(int index) {
    return g_entities.Get(index);
}

bool TriggerList_Add(int entity) {
    int index = g_entities.FindValue(entity);

    if (index != ENTITY_NOT_FOUND) {
        return false;
    }

    g_entities.Push(entity);

    return true;
}

bool TriggerList_Remove(int entity) {
    int index = g_entities.FindValue(entity);

    if (index == ENTITY_NOT_FOUND) {
        return false;
    }

    g_entities.Erase(index);

    return true;
}
