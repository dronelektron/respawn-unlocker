static ArrayList g_triggers;

void TriggerList_Create() {
    g_triggers = new ArrayList();
}

void TriggerList_Clear() {
    g_triggers.Clear();
}

void TriggerList_Add(int hammerId) {
    g_triggers.Push(hammerId);
}

void TriggerList_RemoveByHammerId(int hammerId) {
    int index = g_triggers.FindValue(hammerId);

    if (index > INVALID_INDEX) {
        g_triggers.Erase(index);
    }
}

bool TriggerList_Exists(int hammerId) {
    int index = g_triggers.FindValue(hammerId);

    return index > INVALID_INDEX;
}
