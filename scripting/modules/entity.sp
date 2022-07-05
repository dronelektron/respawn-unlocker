int Entity_SpawnCrate(float position[VECTOR_SIZE]) {
    int crate = CreateEntityByName("prop_dynamic_override");

    DispatchKeyValue(crate, "model", "models/props_junk/wood_crate001a.mdl");
    DispatchKeyValue(crate, "disableshadows", "1");
    DispatchSpawn(crate);

    SetEntProp(crate, Prop_Send, SOLID_TYPE, SOLID_TYPE_VPHYSICS);
    SetEntityRenderMode(crate, RENDER_TRANSCOLOR);
    Entity_SetColorFromVariable(crate);

    float minBounds[VECTOR_SIZE];
    float newPosition[VECTOR_SIZE];

    GetEntPropVector(crate, Prop_Send, VECTOR_BOUNDS_MIN, minBounds);

    newPosition[X] = position[X];
    newPosition[Y] = position[Y];
    newPosition[Z] = position[Z] - minBounds[Z];

    TeleportEntity(crate, newPosition, NULL_VECTOR, NULL_VECTOR);

    return crate;
}

void Entity_SetColorFromVariable(int entity) {
    int red = Variable_GetCrateColorRed();
    int green = Variable_GetCrateColorGreen();
    int blue = Variable_GetCrateColorBlue();
    int alpha = Variable_GetCrateColorAlpha();

    SetEntityRenderColor(entity, red, green, blue, alpha);
}

int Entity_GetCollisionGroup(int entity) {
    return GetEntProp(entity, Prop_Send, COLLISION_GROUP);
}

void Entity_SetCollisionGroup(int entity, int group) {
    SetEntProp(entity, Prop_Send, COLLISION_GROUP, group);
}

void Entity_Disable(int entity) {
    AcceptEntityInput(entity, "Disable");
}
