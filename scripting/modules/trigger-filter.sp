static StringMap g_triggers;

void TriggerFilter_Create() {
    g_triggers = new StringMap();
    g_triggers.SetValue(TRIGGER_HURT, NO_VALUE);
    g_triggers.SetValue(TRIGGER_PUSH, NO_VALUE);
    g_triggers.SetValue(TRIGGER_TELEPORT, NO_VALUE);
}

bool TriggerFilter_IsBad(int entity) {
    char className[CLASS_NAME_SIZE];

    GetEntityClassname(entity, className, sizeof(className));

    return !g_triggers.ContainsKey(className);
}
