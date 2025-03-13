void Command_Create() {
    RegAdminCmd("sm_respawnunlocker_lock", OnLockRespawn, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_unlock", OnUnlockRespawn, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_trigger_mark", OnMarkTrigger, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_trigger_unmark", OnUnmarkTrigger, ADMFLAG_GENERIC);
}

static Action OnLockRespawn(int client, int args) {
    UseCase_LockRespawn(client);

    return Plugin_Handled;
}

static Action OnUnlockRespawn(int client, int args) {
    UseCase_UnlockRespawn(client);

    return Plugin_Handled;
}

static Action OnMarkTrigger(int client, int args) {
    Trigger_Mark(client);

    return Plugin_Handled;
}

static Action OnUnmarkTrigger(int client, int args) {
    Trigger_Unmark(client);

    return Plugin_Handled;
}
