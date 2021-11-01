ConVar g_wallsEnabled = null;
ConVar g_cratesEnabled = null;
ConVar g_notificationsEnabled = null;

void CreateConVars() {
    g_wallsEnabled = CreateConVar("sm_respawnunlocker_walls", "1", "Enable (1) or disable (0) walls removing");
    g_cratesEnabled = CreateConVar("sm_respawnunlocker_crates", "1", "Enable (1) or disable (0) crates adding");
    g_notificationsEnabled = CreateConVar("sm_respawnunlocker_notifications", "1", "Enable (1) or disable (0) notifications");
}

bool IsWallsEnabled() {
    return g_wallsEnabled.IntValue == 1;
}

bool IsCratesEnabled() {
    return g_cratesEnabled.IntValue == 1;
}

bool IsNotificationsEnabled() {
    return g_notificationsEnabled.IntValue == 1;
}
