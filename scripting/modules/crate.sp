ArrayList g_cratePositions = null;

void CreateCrateList() {
    g_cratePositions = new ArrayList(POSITION_SIZE);
}

void DestroyCrateList() {
    delete g_cratePositions;
}

void ClearCrateList() {
    g_cratePositions.Clear();
}

void AddCrateToList(float cratePosition[POSITION_SIZE]) {
    g_cratePositions.PushArray(cratePosition);
}

int GetCratesListSize() {
    return g_cratePositions.Length;
}

void SpawnCrates() {
    if (!IsCratesEnabled()) {
        return;
    }

    float cratePosition[POSITION_SIZE];

    for (int i = 0; i < g_cratePositions.Length; i++) {
        g_cratePositions.GetArray(i, cratePosition);

        SpawnCrate(cratePosition);
    }
}

void SpawnCrate(float position[POSITION_SIZE]) {
    int crate = CreateEntityByName("prop_dynamic_override");

    DispatchKeyValue(crate, "model", "models/props_junk/wood_crate001a.mdl");
    DispatchKeyValue(crate, "disableshadows", "1");
    DispatchKeyValue(crate, "solid", "6");
    DispatchSpawn(crate);

    SetEntityRenderColor(crate, 255, 255, 255, 127);
    SetEntityRenderMode(crate, RENDER_TRANSCOLOR);

    float minBounds[POSITION_SIZE];
    float newPosition[POSITION_SIZE];

    GetEntPropVector(crate, Prop_Send, "m_vecMins", minBounds);

    newPosition[0] = position[0];
    newPosition[1] = position[1];
    newPosition[2] = position[2] - minBounds[2];

    TeleportEntity(crate, newPosition, NULL_VECTOR, NULL_VECTOR);
}
