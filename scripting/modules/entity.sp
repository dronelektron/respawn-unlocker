void Entity_SetCollisionGroup(int entity, int collisionGroup) {
    SetEntProp(entity, Prop_Send, ENTITY_PROPERTY_COLLISION_GROUP, collisionGroup);
}
