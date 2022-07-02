int Entity_SpawnCrate(float position[VECTOR_SIZE]) {
    int crate = CreateEntityByName("prop_dynamic_override");

    DispatchKeyValue(crate, "model", "models/props_junk/wood_crate001a.mdl");
    DispatchKeyValue(crate, "disableshadows", "1");
    DispatchSpawn(crate);

    SetEntProp(crate, Prop_Send, SOLID_TYPE, SOLID_TYPE_VPHYSICS);
    SetEntityRenderColor(crate, 255, 255, 255, 190);
    SetEntityRenderMode(crate, RENDER_TRANSCOLOR);

    float minBounds[VECTOR_SIZE];
    float newPosition[VECTOR_SIZE];

    GetEntPropVector(crate, Prop_Send, VECTOR_MINS, minBounds);

    newPosition[X] = position[X];
    newPosition[Y] = position[Y];
    newPosition[Z] = position[Z] - minBounds[Z];

    TeleportEntity(crate, newPosition, NULL_VECTOR, NULL_VECTOR);

    return crate;
}

int Entity_GetCollisionGroup(int entity) {
    return GetEntProp(entity, Prop_Send, COLLISION_GROUP);
}

void Entity_SetCollisionGroup(int entity, int group) {
    SetEntProp(entity, Prop_Send, COLLISION_GROUP, group);
}
