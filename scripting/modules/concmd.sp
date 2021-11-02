void CreateConCmds() {
    RegAdminCmd("sm_respawnunlocker_crates_load", Command_LoadCrates, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_crates_save", Command_SaveCrates, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_editor_enable", Command_EnableEditor, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_editor_disable", Command_DisableEditor, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_editor_crate_add", Command_AddCrate, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_editor_crate_remove", Command_RemoveCrate, ADMFLAG_GENERIC);
}

public Action Command_LoadCrates(int client, int args) {
    ApplyToKeyValues(LoadCratesFromFile);
    ReplyCratesLoaded(client);
    LogCratesLoaded(client);

    return Plugin_Handled;
}

public Action Command_SaveCrates(int client, int args) {
    ApplyToKeyValues(SaveCratesToFile);
    ReplyCratesSaved(client);
    LogCratesSaved(client);

    return Plugin_Handled;
}

public Action Command_EnableEditor(int client, int args) {
    SpawnEditorCrates();
    ReplyCratesEditorEnabled(client);
    LogCratesEditorEnabled(client);

    return Plugin_Handled;
}

public Action Command_DisableEditor(int client, int args) {
    DestroyEditorCrates();
    ReplyCratesEditorDisabled(client);
    LogCratesEditorDisabled(client);

    return Plugin_Handled;
}

public Action Command_AddCrate(int client, int args) {
    float cratePosition[POSITION_SIZE];

    TracePosition(client, cratePosition);

    int crate = SpawnCrate(cratePosition);

    g_cratePositions.PushArray(cratePosition);
    g_editorCrateEntities.Push(crate);

    ReplyCrateAdded(client, cratePosition);
    LogCrateAdded(client, cratePosition);

    return Plugin_Handled;
}

public Action Command_RemoveCrate(int client, int args) {
    int crate = TraceCrate(client);
    int crateIndex = g_editorCrateEntities.FindValue(crate);

    if (crateIndex == CRATE_NOT_FOUND) {
        ReplyCrateNotFound(client);

        return Plugin_Handled;
    }

    DestroyCrate(crate);

    float cratePosition[POSITION_SIZE];

    g_cratePositions.GetArray(crateIndex, cratePosition);

    ReplyCrateRemoved(client, cratePosition);
    LogCrateRemoved(client, cratePosition);

    g_cratePositions.Erase(crateIndex);
    g_editorCrateEntities.Erase(crateIndex);

    return Plugin_Handled;
}
