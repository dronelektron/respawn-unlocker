void Message_RespawnLocked(int client) {
    if (client == CONSOLE) {
        ShowConsoleActivity("Respawn locked");
        LogMessage("Respawn is locked");
    } else {
        ShowActivity2(client, PREFIX, "%t", "Respawn locked");
        LogMessage("\"%L\" locked the respawn", client);
    }
}

void Message_RespawnUnlocked(int client) {
    if (client == CONSOLE) {
        ShowConsoleActivity("Respawn unlocked");
        LogMessage("Respawn is unlocked");
    } else {
        ShowActivity2(client, PREFIX, "%t", "Respawn unlocked");
        LogMessage("\"%L\" unlocked the respawn", client);
    }
}

void Message_RespawnUnlockedColored() {
    PrintToChatAll("%t%t", PREFIX_COLORED, "Respawn unlocked");
}

void Message_TriggerNotFound(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Trigger not found");
}

void Message_TriggerWithoutHammerId(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Trigger without hammer id");
}

void Message_TriggerTypeNotSupported(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Trigger type not supported");
}

void Message_TriggerAlreadyMarked(int client, int hammerId) {
    ReplyToCommand(client, "%s%t", PREFIX, "Trigger already marked", hammerId);
}

void Message_TriggerNotMarked(int client, int hammerId) {
    ReplyToCommand(client, "%s%t", PREFIX, "Trigger not marked", hammerId);
}

void Message_TriggerMarked(int client, int hammerId) {
    ShowActivity2(client, PREFIX, "%t", "Trigger marked", hammerId);
    LogMessage("\"%L\" marked the trigger %d", client, hammerId);
}

void Message_TriggerUnmarked(int client, int hammerId) {
    ShowActivity2(client, PREFIX, "%t", "Trigger unmarked", hammerId);
    LogMessage("\"%L\" unmarked the trigger %d", client, hammerId);
}

void Message_TriggerPathUsage(int client) {
    ReplyToCommand(client, "%s%s", PREFIX, "Usage: sm_respawnunlocker_trigger_path <hammerid>");
}

void Message_TriggerListEmpty(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Trigger list empty");
}

void Message_TriggersSaved(int client) {
    if (client == CONSOLE) {
        ShowConsoleActivity("Triggers saved");
        LogMessage("Triggers are saved");
    } else {
        ShowActivity2(client, PREFIX, "%t", "Triggers saved");
        LogMessage("\"%L\" saved the triggers", client);
    }
}

void Message_TriggersLoaded(int client) {
    if (client == CONSOLE) {
        ShowConsoleActivity("Triggers loaded");
        LogMessage("Triggers are loaded");
    } else {
        ShowActivity2(client, PREFIX, "%t", "Triggers loaded");
        LogMessage("\"%L\" loaded the triggers", client);
    }
}

void Message_CatapultNotCreated() {
    LogError("Unable to create a catapult");
}

void Message_CatapultNotSpawned(int entity) {
    LogError("Unable to spawn the catapult %d", entity);
}

void Message_CatapultRemoveUsage(int client) {
    ReplyToCommand(client, "%s%s", PREFIX, "Usage: sm_respawnunlocker_catapult_remove <name>");
}

void Message_CatapultEnableUsage(int client) {
    ReplyToCommand(client, "%s%s", PREFIX, "Usage: sm_respawnunlocker_catapult_enable <name>");
}

void Message_CatapultDisableUsage(int client) {
    ReplyToCommand(client, "%s%s", PREFIX, "Usage: sm_respawnunlocker_catapult_disable <name>");
}

void Message_CatapultPathUsage(int client) {
    ReplyToCommand(client, "%s%s", PREFIX, "Usage: sm_respawnunlocker_catapult_path <name>");
}

void Message_CatapultSetOriginUsage(int client) {
    ReplyToCommand(client, "%s%s", PREFIX, "Usage: sm_respawnunlocker_catapult_set_origin <name>");
}

void Message_CatapultSetHeightUsage(int client) {
    ReplyToCommand(client, "%s%s", PREFIX, "Usage: sm_respawnunlocker_catapult_set_height <name>");
}

void Message_TracingFailed(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Tracing failed");
}

void Message_CatapultNotFound(int client, const char[] name) {
    ReplyToCommand(client, "%s%t", PREFIX, "Catapult not found", name);
}

void Message_CatapultListEmpty(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Catapult list empty");
}

void Message_CatapultAdded(int client, const char[] name) {
    ShowActivity2(client, PREFIX, "%t", "Catapult added", name);
    LogMessage("\"%L\" added the '%s' catapult", client, name);
}

void Message_CatapultRemoved(int client, const char[] name) {
    ShowActivity2(client, PREFIX, "%t", "Catapult removed", name);
    LogMessage("\"%L\" removed the '%s' catapult", client, name);
}

void Message_CatapultEnabled(int client, const char[] name) {
    ShowActivity2(client, PREFIX, "%t", "Catapult enabled", name);
    LogMessage("\"%L\" enabled the '%s' catapult", client, name);
}

void Message_CatapultDisabled(int client, const char[] name) {
    ShowActivity2(client, PREFIX, "%t", "Catapult disabled", name);
    LogMessage("\"%L\" disabled the '%s' catapult", client, name);
}

void Message_CatapultOriginUpdated(int client, const char[] name) {
    ShowActivity2(client, PREFIX, "%t", "Catapult origin updated", name);
    LogMessage("\"%L\" updated the '%s' catapult origin", client, name);
}

void Message_CatapultHeightUpdated(int client, const char[] name) {
    ShowActivity2(client, PREFIX, "%t", "Catapult height updated", name);
    LogMessage("\"%L\" updated the '%s' catapult height", client, name);
}

void Message_CatapultsSaved(int client) {
    if (client == CONSOLE) {
        ShowConsoleActivity("Catapults saved");
        LogMessage("Catapults are saved");
    } else {
        ShowActivity2(client, PREFIX, "%t", "Catapults saved");
        LogMessage("\"%L\" saved the catapults", client);
    }
}

void Message_CatapultsLoaded(int client) {
    if (client == CONSOLE) {
        ShowConsoleActivity("Catapults loaded");
        LogMessage("Catapults are loaded");
    } else {
        ShowActivity2(client, PREFIX, "%t", "Catapults loaded");
        LogMessage("\"%L\" loaded the catapults", client);
    }
}

static void ShowConsoleActivity(const char[] phrase) {
    PrintToChatAll("%s%N: %t", PREFIX, CONSOLE, phrase);
}
