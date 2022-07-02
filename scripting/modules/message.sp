void MessagePrint_WallsRemoved() {
    if (CrateList_Size() == 0 || !Variable_IsWallsEnabled() || !Variable_IsNotificationsEnabled()) {
        return;
    }

    CPrintToChatAll("%s%t", PREFIX_COLORED, "Walls removed");
}

void MessagePrint_CratesAdded() {
    if (CrateList_Size() == 0 || !Variable_IsCratesEnabled() || !Variable_IsNotificationsEnabled()) {
        return;
    }

    CPrintToChatAll("%s%t", PREFIX_COLORED, "Crates added");
}

void Message_CratesLoaded(int client) {
    int cratesAmount = CrateList_Size();

    if (client == CONSOLE) {
        if (cratesAmount == 0) {
            LogMessage("No crates for this map", cratesAmount);
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
