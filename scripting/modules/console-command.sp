void Command_Create() {
    RegAdminCmd("sm_respawnunlocker", OnRespawnUnlocker, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_lock", OnLockRespawn, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_unlock", OnUnlockRespawn, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_trigger_mark", OnMarkTrigger, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_trigger_unmark", OnUnmarkTrigger, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_trigger_path", OnTriggerPath, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_triggers_save", OnSaveTriggers, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_triggers_load", OnLoadTriggers, ADMFLAG_GENERIC);
}

static Action OnRespawnUnlocker(int client, int args) {
    Menu_RespawnUnlocker(client);

    return Plugin_Handled;
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

static Action OnTriggerPath(int client, int args) {
    if (args < 1) {
        Message_TriggerPathUsage(client);

        return Plugin_Handled;
    }

    int hammerId = GetCmdArgInt(1);

    Trigger_Path(client, hammerId);

    return Plugin_Handled;
}

static Action OnSaveTriggers(int client, int args) {
    UseCase_SaveTriggers(client);

    return Plugin_Handled;
}

static Action OnLoadTriggers(int client, int args) {
    UseCase_LoadTriggers(client);

    return Plugin_Handled;
}
