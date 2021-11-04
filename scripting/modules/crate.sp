void SpawnCrates() {
    if (!IsCratesEnabled()) {
        return;
    }

    float cratePosition[VECTOR_SIZE];

    for (int i = 0; i < g_cratePositions.Length; i++) {
        g_cratePositions.GetArray(i, cratePosition);

        SpawnCrate(cratePosition);
    }
}

int SpawnCrate(float position[VECTOR_SIZE]) {
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
