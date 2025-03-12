void UseCase_LockRespawn(int client) {
    UseCase_TeamWall_Toggle(ENABLED_YES);
    TeamBlocker_Toggle(ENABLED_YES);
    Message_RespawnLocked(client);
}

void UseCase_UnlockRespawn(int client) {
    UseCase_TeamWall_Toggle(ENABLED_NO);
    TeamBlocker_Toggle(ENABLED_NO);
    Message_RespawnUnlocked(client);
}

void UseCase_TeamWall_Toggle(bool enabled) {
    int entity = INVALID_INDEX;

    while (FindWall(entity, "func_team_wall")) {
        int collisionGroup = enabled ? COLLISION_GROUP_NONE : COLLISION_GROUP_IN_VEHICLE;

        Entity_SetCollisionGroup(entity, collisionGroup);
    }
}

static void TeamBlocker_Toggle(bool enabled) {
    int entity = INVALID_INDEX;

    while (FindWall(entity, "func_teamblocker")) {
        int collisionGroup = enabled ? COLLISION_GROUP_OBJECT : COLLISION_GROUP_IN_VEHICLE;

        Entity_SetCollisionGroup(entity, collisionGroup);
    }
}

static bool FindWall(int& entity, const char[] className) {
    entity = FindEntityByClassname(entity, className);

    return entity > INVALID_INDEX;
}
