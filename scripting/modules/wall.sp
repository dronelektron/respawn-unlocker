static char g_classNames[][] = {
    "func_team_wall",
    "func_teamblocker"
};

static int g_collisionGroup[] = {
    COLLISION_GROUP_NONE,
    COLLISION_GROUP_OBJECT
};

void Wall_Toggle(int type, bool enabled) {
    int entity = INVALID_INDEX;

    while (FindWall(entity, g_classNames[type])) {
        int collisionGroup = enabled ? g_collisionGroup[type] : COLLISION_GROUP_IN_VEHICLE;

        Entity_SetCollisionGroup(entity, collisionGroup);
    }
}

static bool FindWall(int& entity, const char[] className) {
    entity = FindEntityByClassname(entity, className);

    return entity > INVALID_INDEX;
}
