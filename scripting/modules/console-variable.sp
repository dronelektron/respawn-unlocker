static ConVar g_autoUnlock;

void Variable_Create() {
    g_autoUnlock = CreateConVar("sm_respawnunlocker_auto", "1", "Automatic respawn unlock (on - 1, off - 0)");
}

bool Variable_AutoUnlock() {
    return g_autoUnlock.BoolValue;
}
