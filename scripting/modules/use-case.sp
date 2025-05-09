void UseCase_LockRespawn(int client) {
    LockRespawn();
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

void UseCase_EnableWalls(int client) {
    EnableWalls();
    Message_WallsEnabled(client);
}

void UseCase_DisableWalls(int client) {
    DisableWalls();
    Message_WallsDisabled(client);
}

void UseCase_EnableTriggers(int client) {
    Trigger_ToggleAll(ENABLED_YES);
    Message_TriggersEnabled(client);
}

void UseCase_DisableTriggers(int client) {
    Trigger_ToggleAll(ENABLED_NO);
    Message_TriggersDisabled(client);
}

void UseCase_EnableCatapults(int client) {
    Catapult_ToggleAll(ENABLED_YES);
    Message_CatapultsEnabled(client);
}

void UseCase_DisableCatapults(int client) {
    Catapult_ToggleAll(ENABLED_NO);
    Message_CatapultsDisabled(client);
}

static void LockRespawn() {
    EnableWalls();
    Trigger_ToggleAll(ENABLED_YES);
    Catapult_ToggleAll(ENABLED_NO);
}

static void UnlockRespawn() {
    DisableWalls();
    Trigger_ToggleAll(ENABLED_NO);
    Catapult_ToggleAll(ENABLED_YES);
}

static void EnableWalls() {
    Wall_ToggleAll(WALL_TEAM, ENABLED_YES);
    Wall_ToggleAll(WALL_BLOCKER, ENABLED_YES);
}

static void DisableWalls() {
    Wall_ToggleAll(WALL_TEAM, ENABLED_NO);
    Wall_ToggleAll(WALL_BLOCKER, ENABLED_NO);
}

void UseCase_SaveTriggers(int client) {
    Storage_SaveTriggers();
    Message_TriggersSaved(client);
}

void UseCase_LoadTriggers(int client) {
    Trigger_ToggleAll(ENABLED_YES);
    Storage_LoadTriggers();
    Trigger_UpdateEntities();
    Message_TriggersLoaded(client);
}

void UseCase_SaveCatapults(int client) {
    Storage_SaveCatapults();
    Message_CatapultsSaved(client);
}

void UseCase_LoadCatapults(int client) {
    Catapult_ToggleAll(ENABLED_NO);
    Storage_LoadCatapults();
    Message_CatapultsLoaded(client);
}

void UseCase_AssertModel(int index) {
    if (index == INVALID_MODEL_INDEX) {
        SetFailState("Unable to precache a model");
    }
}
