void MessagePrint_WallsDisabled() {
    CPrintToChatAll("%s%t", PREFIX_COLORED, "Walls disabled");
}

void MessagePrint_TriggersDisabled() {
    CPrintToChatAll("%s%t", PREFIX_COLORED, "Triggers disabled");
}

void MessagePrint_CratesAdded() {
    CPrintToChatAll("%s%t", PREFIX_COLORED, "Crates added");
}

void Message_CratesLoaded(int client) {
    int cratesAmount = CrateList_Size();

    if (client == CONSOLE) {
        if (cratesAmount == 0) {
            LogMessage("No crates for this map");
        } else {
            LogMessage("Loaded %d crates", cratesAmount);
        }
    } else {
        ShowActivity2(client, PREFIX, "%t", "Crates loaded", cratesAmount);
        LogMessage("\"%L\" loaded %d crates", client, cratesAmount);
    }
}

void Message_CratesSaved(int client) {
    int cratesAmount = CrateList_Size();

    ShowActivity2(client, PREFIX, "%t", "Crates saved", cratesAmount);
    LogMessage("\"%L\" saved %d crates", client, cratesAmount);
}

void Message_TriggersLoaded(int client) {
    int triggersAmount = TriggerList_Size();

    if (client == CONSOLE) {
        if (triggersAmount == 0) {
            LogMessage("No triggers for this map");
        } else {
            LogMessage("Loaded %d triggers", triggersAmount);
        }
    } else {
        ShowActivity2(client, PREFIX, "%t", "Triggers loaded", triggersAmount);
        LogMessage("\"%L\" loaded %d triggers", client, triggersAmount);
    }
}

void Message_TriggersSaved(int client) {
    int triggersAmount = TriggerList_Size();

    ShowActivity2(client, PREFIX, "%t", "Triggers saved", triggersAmount);
    LogMessage("\"%L\" saved %d triggers", client, triggersAmount);
}

void Message_EditorEnabled(int client) {
    ShowActivity2(client, PREFIX, "%t", "Crates editor enabled");
    LogMessage("\"%L\" enabled crates editor", client);
}

void Message_EditorDisabled(int client) {
    ShowActivity2(client, PREFIX, "%t", "Crates editor disabled");
    LogMessage("\"%L\" disabled crates editor", client);
}

void Message_CrateAdded(int client) {
    ShowActivity2(client, PREFIX, "%t", "Crate added");
    LogMessage("\"%L\" added a crate", client);
}

void Message_CrateRemoved(int client) {
    ShowActivity2(client, PREFIX, "%t", "Crate removed");
    LogMessage("\"%L\" removed a crate", client);
}

void MessageReply_CrateNotFound(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Crate not found");
}

void MessageReply_TriggerNotFound(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Trigger not found");
}

void Message_TriggerAddedToList(int client, int entity) {
    ShowActivity2(client, PREFIX, "%t", "Trigger added to list", entity);
    LogMessage("\"%L\" added trigger %d to list", client, entity);
}

void MessageReply_TriggerAlreadyAddedToList(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Trigger already added to list", entity);
}

void Message_TriggerRemovedFromList(int client, int entity) {
    ShowActivity2(client, PREFIX, "%t", "Trigger removed from list", entity);
    LogMessage("\"%L\" removed trigger %d from list", client, entity);
}

void MessageReply_TriggerAlreadyRemovedFromList(int client, int entity) {
    ReplyToCommand(client, "%s%t", PREFIX, "Trigger already removed from list", entity);
}
