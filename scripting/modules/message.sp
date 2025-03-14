void Message_RespawnLocked(int client) {
    ShowActivity2(client, PREFIX, "%t", "Respawn locked");
    LogMessage("\"%L\" locked the respawn", client);
}

void Message_RespawnUnlocked(int client) {
    if (client == CONSOLE) {
        PrintToChatAll("%t%t", PREFIX_COLORED, "Respawn unlocked");
    } else {
        ShowActivity2(client, PREFIX, "%t", "Respawn unlocked");
        LogMessage("\"%L\" unlocked the respawn", client);
    }
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
        LogMessage("Triggers are saved");
    } else {
        ShowActivity2(client, PREFIX, "%t", "Triggers saved");
        LogMessage("\"%L\" saved the triggers", client);
    }
}

void Message_TriggersLoaded(int client) {
    if (client == CONSOLE) {
        LogMessage("Triggers are loaded");
    } else {
        ShowActivity2(client, PREFIX, "%t", "Triggers loaded");
        LogMessage("\"%L\" loaded the triggers", client);
    }
}
