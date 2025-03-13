void Entity_GetOrigin(int entity, float origin[3]) {
    GetEntPropVector(entity, Prop_Send, ENTITY_PROPERTY_VEC_ORIGIN, origin);
}

void Entity_GetMins(int entity, float mins[3]) {
    GetEntPropVector(entity, Prop_Send, ENTITY_PROPERTY_VEC_MINS, mins);
}

void Entity_GetMaxs(int entity, float maxs[3]) {
    GetEntPropVector(entity, Prop_Send, ENTITY_PROPERTY_VEC_MAXS, maxs);
}

void Entity_SetCollisionGroup(int entity, int collisionGroup) {
    SetEntProp(entity, Prop_Send, ENTITY_PROPERTY_COLLISION_GROUP, collisionGroup);
}

int Entity_GetHammerId(int entity) {
    return GetEntProp(entity, Prop_Data, ENTITY_PROPERTY_HAMMER_ID);
}

void Entity_SetActivity(int entity, bool enabled) {
    AcceptEntityInput(entity, enabled ? "Enable" : "Disable");
}
