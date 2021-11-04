void NotifyAboutWalls() {
    if (g_wallEntities.Length == 0 || !IsWallsEnabled() || !IsNotificationsEnabled()) {
        return;
    }

    CPrintToChatAll("%s%t", PREFIX_COLORED, "Respawn unlocked");
}

void NotifyAboutCrates() {
    if (g_cratePositions.Length == 0 || !IsCratesEnabled() || !IsNotificationsEnabled()) {
        return;
    }

    CPrintToChatAll("%s%t", PREFIX_COLORED, "Crates created");
}

void ReplyCratesLoaded(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Crates loaded");
}

void ReplyCratesSaved(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Crates saved");
}

void ReplyCratesEditorEnabled(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Crates editor enabled");
}

void ReplyCratesEditorDisabled(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Crates editor disabled");
}

void ReplyCrateAdded(int client, float cratePosition[VECTOR_SIZE]) {
    float cratePosX = cratePosition[X];
    float cratePosY = cratePosition[Y];
    float cratePosZ = cratePosition[Z];

    ReplyToCommand(client, "%s%t", PREFIX, "Crate added", cratePosX, cratePosY, cratePosZ);
}

void ReplyCrateRemoved(int client, float cratePosition[VECTOR_SIZE]) {
    float cratePosX = cratePosition[X];
    float cratePosY = cratePosition[Y];
    float cratePosZ = cratePosition[Z];

    ReplyToCommand(client, "%s%t", PREFIX, "Crate removed", cratePosX, cratePosY, cratePosZ);
}

void ReplyCrateNotFound(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Crate not found");
}

void LogCratesEditorEnabled(int client) {
    LogMessage("\"%L\" enabled crates editor", client);
}

void LogCratesEditorDisabled(int client) {
    LogMessage("\"%L\" disabled crates editor", client);
}

void LogCrateAdded(int client, float cratePosition[VECTOR_SIZE]) {
    float cratePosX = cratePosition[X];
    float cratePosY = cratePosition[Y];
    float cratePosZ = cratePosition[Z];

    LogMessage("\"%L\" added a crate (%f, %f, %f)", client, cratePosX, cratePosY, cratePosZ);
}

void LogCrateRemoved(int client, float cratePosition[VECTOR_SIZE]) {
    float cratePosX = cratePosition[X];
    float cratePosY = cratePosition[Y];
    float cratePosZ = cratePosition[Z];

    LogMessage("\"%L\" removed a crate (%f, %f, %f)", client, cratePosX, cratePosY, cratePosZ);
}

void LogCratesLoaded(int client = NO_CLIENT) {
    if (client == NO_CLIENT) {
        if (g_cratePositions.Length == 0) {
            LogMessage("No crates for this map", g_cratePositions.Length);
        } else {
            LogMessage("Loaded %d crates", g_cratePositions.Length);
        }
    } else {
        LogMessage("\"%L\" loaded %d crates", client, g_cratePositions.Length);
    }
}

void LogCratesSaved(int client) {
    LogMessage("\"%L\" saved %d crates", client, g_cratePositions.Length);
}
