void Command_Create() {
    RegAdminCmd("sm_respawnunlocker", OnRespawnUnlocker, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_lock", OnLockRespawn, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_unlock", OnUnlockRespawn, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_walls_enable", OnEnableWalls, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_walls_disable", OnDisableWalls, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_trigger_mark", OnMarkTrigger, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_trigger_unmark", OnUnmarkTrigger, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_trigger_path", OnTriggerPath, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_triggers_save", OnSaveTriggers, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_triggers_load", OnLoadTriggers, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_catapult_add", OnAddCatapult, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_catapult_remove", OnRemoveCatapult, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_catapult_enable", OnEnableCatapult, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_catapult_disable", OnDisableCatapult, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_catapult_path", OnCatapultPath, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_catapult_set_origin", OnSetCatapultOrigin, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_catapult_set_height", OnSetCatapultHeight, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_catapults_save", OnSaveCatapults, ADMFLAG_GENERIC);
    RegAdminCmd("sm_respawnunlocker_catapults_load", OnLoadCatapults, ADMFLAG_GENERIC);
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

static Action OnEnableWalls(int client, int args) {
    UseCase_EnableWalls(client);

    return Plugin_Handled;
}

static Action OnDisableWalls(int client, int args) {
    UseCase_DisableWalls(client);

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

static Action OnAddCatapult(int client, int args) {
    Catapult_Add(client);

    return Plugin_Handled;
}

static Action OnRemoveCatapult(int client, int args) {
    if (args < 1) {
        Message_CatapultRemoveUsage(client);

        return Plugin_Handled;
    }

    char name[CATAPULT_NAME_SIZE];

    GetCmdArg(1, name, sizeof(name));
    Catapult_Remove(client, name);

    return Plugin_Handled;
}

static Action OnEnableCatapult(int client, int args) {
    if (args < 1) {
        Message_CatapultEnableUsage(client);

        return Plugin_Handled;
    }

    char name[CATAPULT_NAME_SIZE];

    GetCmdArg(1, name, sizeof(name));
    Catapult_Toggle(client, name, ENABLED_YES);

    return Plugin_Handled;
}

static Action OnDisableCatapult(int client, int args) {
    if (args < 1) {
        Message_CatapultDisableUsage(client);

        return Plugin_Handled;
    }

    char name[CATAPULT_NAME_SIZE];

    GetCmdArg(1, name, sizeof(name));
    Catapult_Toggle(client, name, ENABLED_NO);

    return Plugin_Handled;
}

static Action OnCatapultPath(int client, int args) {
    if (args < 1) {
        Message_CatapultPathUsage(client);

        return Plugin_Handled;
    }

    char name[CATAPULT_NAME_SIZE];

    GetCmdArg(1, name, sizeof(name));
    Catapult_Path(client, name);

    return Plugin_Handled;
}

static Action OnSetCatapultOrigin(int client, int args) {
    if (args < 1) {
        Message_CatapultSetOriginUsage(client);

        return Plugin_Handled;
    }

    char name[CATAPULT_NAME_SIZE];

    GetCmdArg(1, name, sizeof(name));
    Catapult_SetOrigin(client, name);

    return Plugin_Handled;
}

static Action OnSetCatapultHeight(int client, int args) {
    if (args < 1) {
        Message_CatapultSetHeightUsage(client);

        return Plugin_Handled;
    }

    char name[CATAPULT_NAME_SIZE];

    GetCmdArg(1, name, sizeof(name));
    Catapult_SetHeight(client, name);

    return Plugin_Handled;
}

static Action OnSaveCatapults(int client, int args) {
    UseCase_SaveCatapults(client);

    return Plugin_Handled;
}

static Action OnLoadCatapults(int client, int args) {
    UseCase_LoadCatapults(client);

    return Plugin_Handled;
}
