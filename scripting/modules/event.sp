void Event_Create() {
    HookEvent("dod_round_start", Event_RoundStart);
    HookEvent("dod_round_win", Event_RoundWin);
}

public Action Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
    UseCase_RestoreWalls();
    CrateEditor_Clear();

    return Plugin_Continue;
}

public Action Event_RoundWin(Event event, const char[] name, bool dontBroadcast) {
    UseCase_DisableWalls();
    UseCase_DisableTriggers();
    UseCase_AddCrates();

    return Plugin_Continue;
}
