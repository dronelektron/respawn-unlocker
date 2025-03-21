void UseCase_LockRespawn(int client) {
    Wall_Toggle(WALL_TEAM, ENABLED_YES);
    Wall_Toggle(WALL_BLOCKER, ENABLED_YES);
    Trigger_Toggle(ENABLED_YES);
    Message_RespawnLocked(client);
}

void UseCase_UnlockRespawn(int client) {
    UnlockRespawn();
    Message_RespawnUnlocked(client);
}

void UseCase_UnlockRespawnAuto() {
    UnlockRespawn();
    Message_RespawnUnlockedColored();
}

static void UnlockRespawn() {
    Wall_Toggle(WALL_TEAM, ENABLED_NO);
    Wall_Toggle(WALL_BLOCKER, ENABLED_NO);
    Trigger_Toggle(ENABLED_NO);
}

void UseCase_SaveTriggers(int client) {
    Storage_SaveTriggers();
    Message_TriggersSaved(client);
}

void UseCase_LoadTriggers(int client) {
    Storage_LoadTriggers();
    Trigger_UpdateEntities();
    Message_TriggersLoaded(client);
}
