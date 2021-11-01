void CreateConCmds() {
    RegAdminCmd("sm_respawnunlocker_reload_crates", Command_ReloadCrates, ADMFLAG_GENERIC);
}

public Action Command_ReloadCrates(int client, int args) {
    ApplyToKeyValues(LoadCratesFromFile);
    ReplyCratesReloaded(client);

    return Plugin_Handled;
}
