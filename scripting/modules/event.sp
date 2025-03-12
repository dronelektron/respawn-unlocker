void Event_Create() {
    HookEvent("dod_round_start", OnRoundStart);
    HookEvent("dod_round_win", OnRoundWin);
}

static void OnRoundStart(Event event, const char[] name, bool dontBroadcast) {
    UseCase_TeamWall_Toggle(ENABLED_YES);
}

static void OnRoundWin(Event event, const char[] name, bool dontBroadcast) {
    if (Variable_AutoUnlock()) {
        UseCase_UnlockRespawn(CONSOLE);
    }
}
