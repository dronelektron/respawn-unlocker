void CreateConCmds() {
    RegAdminCmd("sm_respawnunlocker_reload_crates", Command_ReloadCrates, ADMFLAG_GENERIC);
}

public Action Command_ReloadCrates(int client, int args) {
    ApplyToKeyValues(LoadCratesFromFile);
    ReplyToCommand(client, "%s%t", PREFIX, "Crates reloaded");

    return Plugin_Handled;
}
