void Command_Create() {
    RegAdminCmd("sm_respawnunlocker_crates_load", Command_LoadCrates, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_crates_save", Command_SaveCrates, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_editor_enable", Command_EnableEditor, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_editor_disable", Command_DisableEditor, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_editor_crate_add", Command_AddCrate, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_editor_crate_remove", Command_RemoveCrate, ADMFLAG_GENERIC);
}

public Action Command_LoadCrates(int client, int args) {
    UseCase_LoadCrates(client);

    return Plugin_Handled;
}

public Action Command_SaveCrates(int client, int args) {
    UseCase_SaveCrates(client);

    return Plugin_Handled;
}

public Action Command_EnableEditor(int client, int args) {
    UseCase_EnableEditor(client);

    return Plugin_Handled;
}

public Action Command_DisableEditor(int client, int args) {
    UseCase_DisableEditor(client);

    return Plugin_Handled;
}

public Action Command_AddCrate(int client, int args) {
    UseCase_AddCrate(client);

    return Plugin_Handled;
}

public Action Command_RemoveCrate(int client, int args) {
    UseCase_RemoveCrate(client);

    return Plugin_Handled;
}