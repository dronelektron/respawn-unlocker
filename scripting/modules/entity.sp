void Entity_GetOrigin(int entity, float origin[3]) {
    GetEntPropVector(entity, Prop_Send, ENTITY_PROPERTY_VEC_ORIGIN, origin);
}

void Entity_GetMins(int entity, float mins[3]) {
    GetEntPropVector(entity, Prop_Send, ENTITY_PROPERTY_VEC_MINS, mins);
}

void Entity_GetMaxs(int entity, float maxs[3]) {
    GetEntPropVector(entity, Prop_Send, ENTITY_PROPERTY_VEC_MAXS, maxs);
}

void Entity_GetAbsVelocity(int entity, float velocity[3]) {
    GetEntPropVector(entity, Prop_Data, ENTITY_PROPERTY_VEC_ABS_VELOCITY, velocity);
}

void Entity_SetCollisionGroup(int entity, int collisionGroup) {
    SetEntProp(entity, Prop_Send, ENTITY_PROPERTY_COLLISION_GROUP, collisionGroup);
}

void Entity_SetSolidType(int entity, int solidType) {
    SetEntProp(entity, Prop_Send, ENTITY_PROPERTY_SOLID_TYPE, solidType);
}

void Entity_SetSolidFlags(int entity, int solidFlags) {
    SetEntProp(entity, Prop_Send, ENTITY_PROPERTY_SOLID_FLAGS, solidFlags);
}

int Entity_GetHammerId(int entity) {
    return GetEntProp(entity, Prop_Data, ENTITY_PROPERTY_HAMMER_ID);
}

void Entity_SetActivity(int entity, bool enabled) {
    AcceptEntityInput(entity, enabled ? "Enable" : "Disable");
}

bool Entity_FindByClassName(int& entity, const char[] className) {
    entity = FindEntityByClassname(entity, className);

    return entity > INVALID_INDEX;
}
