static int g_selectedEntity[MAXPLAYERS + 1];

void TriggerEditor_Reset(int client) {
    g_selectedEntity[client] = ENTITY_NOT_FOUND;
}

int TriggerEditor_SelectTrigger(int client) {
    float eyesPosition[VECTOR_SIZE];
    float eyesAngles[VECTOR_SIZE];

    GetClientEyePosition(client, eyesPosition);
    GetClientEyeAngles(client, eyesAngles);

    TR_EnumerateEntities(eyesPosition, eyesAngles, PARTITION_TRIGGER_EDICTS, RayType_Infinite, TraceEntityEnumerator_Triggers, client);

    return g_selectedEntity[client];
}

bool TraceEntityEnumerator_Triggers(int entity, int client) {
    g_selectedEntity[client] = entity;

    return false;
}
