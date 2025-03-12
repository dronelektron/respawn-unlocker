void UseCase_LockRespawn(int client) {
    Wall_Toggle(WALL_TEAM, ENABLED_YES);
    Wall_Toggle(WALL_BLOCKER, ENABLED_YES);
    Message_RespawnLocked(client);
}

void UseCase_UnlockRespawn(int client) {
    Wall_Toggle(WALL_TEAM, ENABLED_NO);
    Wall_Toggle(WALL_BLOCKER, ENABLED_NO);
    Message_RespawnUnlocked(client);
}
