void Event_Create() {
    HookEvent("dod_round_start", OnRoundStart);
}

static void OnRoundStart(Event event, const char[] name, bool dontBroadcast) {
    UseCase_TeamWall_Toggle(ENABLED_YES);
}
