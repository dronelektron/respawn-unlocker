static ConVar g_wallsEnabled = null;
static ConVar g_cratesEnabled = null;
static ConVar g_triggersEnabled = null;
static ConVar g_notificationsEnabled = null;
static ConVar g_crateColorRed = null;
static ConVar g_crateColorGreen = null;
static ConVar g_crateColorBlue = null;
static ConVar g_crateColorAlpha = null;

void Variable_Create() {
    g_wallsEnabled = CreateConVar("sm_respawnunlocker_walls", "1", "Enable (1) or disable (0) walls removing");
    g_cratesEnabled = CreateConVar("sm_respawnunlocker_crates", "1", "Enable (1) or disable (0) crates adding");
    g_triggersEnabled = CreateConVar("sm_respawnunlocker_triggers", "1", "Enable (1) or disable (0) triggers removing");
    g_notificationsEnabled = CreateConVar("sm_respawnunlocker_notifications", "1", "Enable (1) or disable (0) notifications");
    g_crateColorRed = CreateConVar("sm_respawnunlocker_crate_color_red", "0", "Crate color (red channel)");
    g_crateColorGreen = CreateConVar("sm_respawnunlocker_crate_color_green", "255", "Crate color (green channel)");
    g_crateColorBlue = CreateConVar("sm_respawnunlocker_crate_color_blue", "255", "Crate color (blue channel)");
    g_crateColorAlpha = CreateConVar("sm_respawnunlocker_crate_color_alpha", "255", "Crate color (alpha channel)");
}

bool Variable_IsWallsEnabled() {
    return g_wallsEnabled.IntValue == 1;
}

bool Variable_IsCratesEnabled() {
    return g_cratesEnabled.IntValue == 1;
}

bool Variable_IsTriggersEnabled() {
    return g_triggersEnabled.IntValue == 1;
}

bool Variable_IsNotificationsEnabled() {
    return g_notificationsEnabled.IntValue == 1;
}

int Variable_GetCrateColorRed() {
    return g_crateColorRed.IntValue;
}

int Variable_GetCrateColorGreen() {
    return g_crateColorGreen.IntValue;
}

int Variable_GetCrateColorBlue() {
    return g_crateColorBlue.IntValue;
}

int Variable_GetCrateColorAlpha() {
    return g_crateColorAlpha.IntValue;
}
