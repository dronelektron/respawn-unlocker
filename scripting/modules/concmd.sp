void CreateConCmds() {
    RegAdminCmd("sm_respawnunlocker_crates_load", Command_LoadCrates, ADMFLAG_GENERIC);
}

public Action Command_LoadCrates(int client, int args) {
    ApplyToKeyValues(LoadCratesFromFile);

    return Plugin_Handled;
}
