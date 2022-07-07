void Command_Create() {
    RegAdminCmd("sm_respawnunlocker_crate_add", Command_AddCrate, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_crate_remove", Command_RemoveCrate, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_crates_show", Command_ShowCrates, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_crates_hide", Command_HideCrates, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_crates_load", Command_LoadCrates, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_crates_save", Command_SaveCrates, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_trigger_add", Command_AddTriggerToList, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_trigger_remove", Command_RemoveTriggerFromList, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_triggers_load", Command_LoadTriggers, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_triggers_save", Command_SaveTriggers, ADMFLAG_GENERIC);
}

public Action Command_AddCrate(int client, int args) {
    UseCase_AddCrate(client);

    return Plugin_Handled;
}

public Action Command_RemoveCrate(int client, int args) {
    UseCase_RemoveCrate(client);

    return Plugin_Handled;
}

public Action Command_ShowCrates(int client, int args) {
    UseCase_ShowCrates(client);

    return Plugin_Handled;
}

public Action Command_HideCrates(int client, int args) {
    UseCase_HideCrates(client);

    return Plugin_Handled;
}

public Action Command_LoadCrates(int client, int args) {
    UseCase_LoadCrates(client);

    return Plugin_Handled;
}

public Action Command_SaveCrates(int client, int args) {
    UseCase_SaveCrates(client);

    return Plugin_Handled;
}

public Action Command_AddTriggerToList(int client, int args) {
    UseCase_AddTriggerToList(client);

    return Plugin_Handled;
}

public Action Command_RemoveTriggerFromList(int client, int args) {
    UseCase_RemoveTriggerFromList(client);

    return Plugin_Handled;
}

public Action Command_LoadTriggers(int client, int args) {
    UseCase_LoadTriggers(client);

    return Plugin_Handled;
}

public Action Command_SaveTriggers(int client, int args) {
    UseCase_SaveTriggers(client);

    return Plugin_Handled;
}
