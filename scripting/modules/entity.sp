void Entity_SetCollisionGroup(int entity, int collisionGroup) {
    SetEntProp(entity, Prop_Send, ENTITY_PROPERTY_COLLISION_GROUP, collisionGroup);
}

int Entity_GetHammerId(int entity) {
    return GetEntProp(entity, Prop_Data, ENTITY_PROPERTY_HAMMER_ID);
}

void Entity_SetActivity(int entity, bool enabled) {
    AcceptEntityInput(entity, enabled ? "Enable" : "Disable");
}
