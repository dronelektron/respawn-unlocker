void MessagePrint_WallsRemoved() {
    if (CrateList_Size() == 0 || !Variable_IsWallsEnabled() || !Variable_IsNotificationsEnabled()) {
        return;
    }

    CPrintToChatAll("%s%t", PREFIX_COLORED, "Respawn unlocked");
}

void MessagePrint_CratesAdded() {
    if (CrateList_Size() == 0 || !Variable_IsCratesEnabled() || !Variable_IsNotificationsEnabled()) {
        return;
    }

    CPrintToChatAll("%s%t", PREFIX_COLORED, "Crates created");
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
        ReplyToCommand(client, "%s%t", PREFIX, "Crates loaded");
        LogMessage("\"%L\" loaded %d crates", client, cratesAmount);
    }
}

void Message_CratesSaved(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Crates saved");
    LogMessage("\"%L\" saved %d crates", client, CrateList_Size());
}

void Message_EditorEnabled(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Crates editor enabled");
    LogMessage("\"%L\" enabled crates editor", client);
}

void Message_EditorDisabled(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Crates editor disabled");
    LogMessage("\"%L\" disabled crates editor", client);
}

void Message_CrateAdded(int client, float cratePosition[VECTOR_SIZE]) {
    float cratePosX = cratePosition[X];
    float cratePosY = cratePosition[Y];
    float cratePosZ = cratePosition[Z];

    ReplyToCommand(client, "%s%t", PREFIX, "Crate added", cratePosX, cratePosY, cratePosZ);
    LogMessage("\"%L\" added a crate (%f, %f, %f)", client, cratePosX, cratePosY, cratePosZ);
}

void Message_CrateRemoved(int client, float cratePosition[VECTOR_SIZE]) {
    float cratePosX = cratePosition[X];
    float cratePosY = cratePosition[Y];
    float cratePosZ = cratePosition[Z];

    ReplyToCommand(client, "%s%t", PREFIX, "Crate removed", cratePosX, cratePosY, cratePosZ);
    LogMessage("\"%L\" removed a crate (%f, %f, %f)", client, cratePosX, cratePosY, cratePosZ);
}

void MessageReply_CrateNotFound(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Crate not found");
}
