static char g_className[][] = {
    "func_team_wall",
    "func_teamblocker"
};

static int g_collisionGroup[] = {
    COLLISION_GROUP_NONE,
    COLLISION_GROUP_OBJECT
};

void Wall_Toggle(int type, bool enabled) {
    int entity = INVALID_INDEX;

    while (Entity_FindByClassName(entity, g_className[type])) {
        int collisionGroup = enabled ? g_collisionGroup[type] : COLLISION_GROUP_IN_VEHICLE;

        Entity_SetCollisionGroup(entity, collisionGroup);
    }
}
