int Entity_SpawnCrate(float position[VECTOR_SIZE]) {
    int crate = CreateEntityByName("prop_dynamic_override");

    DispatchKeyValue(crate, "model", "models/props_junk/wood_crate001a.mdl");
    DispatchKeyValue(crate, "disableshadows", "1");
    DispatchKeyValue(crate, "solid", "6");
    DispatchSpawn(crate);

    SetEntityRenderColor(crate, 255, 255, 255, 190);
    SetEntityRenderMode(crate, RENDER_TRANSCOLOR);

    float minBounds[VECTOR_SIZE];
    float newPosition[VECTOR_SIZE];

    GetEntPropVector(crate, Prop_Send, "m_vecMins", minBounds);

    newPosition[0] = position[0];
    newPosition[1] = position[1];
    newPosition[2] = position[2] - minBounds[2];

    TeleportEntity(crate, newPosition, NULL_VECTOR, NULL_VECTOR);

    return crate;
}

int Entity_GetCollisionGroup(int entity) {
    return GetEntProp(entity, Prop_Send, COLLISION_GROUP);
}

void Entity_SetCollisionGroup(int entity, int group) {
    SetEntProp(entity, Prop_Send, COLLISION_GROUP, group);
}
