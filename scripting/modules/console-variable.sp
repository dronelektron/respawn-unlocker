static ConVar g_wallsEnabled = null;
static ConVar g_cratesEnabled = null;
static ConVar g_notificationsEnabled = null;

void Variable_Create() {
    g_wallsEnabled = CreateConVar("sm_respawnunlocker_walls", "1", "Enable (1) or disable (0) walls removing");
    g_cratesEnabled = CreateConVar("sm_respawnunlocker_crates", "1", "Enable (1) or disable (0) crates adding");
    g_notificationsEnabled = CreateConVar("sm_respawnunlocker_notifications", "1", "Enable (1) or disable (0) notifications");
}

bool Variable_IsWallsEnabled() {
    return g_wallsEnabled.IntValue == 1;
}

bool Variable_IsCratesEnabled() {
    return g_cratesEnabled.IntValue == 1;
}

bool Variable_IsNotificationsEnabled() {
    return g_notificationsEnabled.IntValue == 1;
}
