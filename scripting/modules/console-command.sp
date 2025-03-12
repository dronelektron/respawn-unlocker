void Command_Create() {
    RegAdminCmd("sm_respawnunlocker_lock", OnLockRespawn, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_unlock", OnUnlockRespawn, ADMFLAG_GENERIC);
}

static Action OnLockRespawn(int client, int args) {
    UseCase_LockRespawn(client);

    return Plugin_Handled;
}

static Action OnUnlockRespawn(int client, int args) {
    UseCase_UnlockRespawn(client);

    return Plugin_Handled;
}
