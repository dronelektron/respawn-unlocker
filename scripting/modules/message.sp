void NotifyAboutWalls() {
    if (GetWallsListSize() == 0 || !IsWallsEnabled() || !IsNotificationsEnabled()) {
        return;
    }

    CPrintToChatAll("%s%t", PREFIX_COLORED, "Respawn unlocked");
}

void NotifyAboutCrates() {
    if (GetCratesListSize() == 0 || !IsCratesEnabled() || !IsNotificationsEnabled()) {
        return;
    }

    CPrintToChatAll("%s%t", PREFIX_COLORED, "Crates created");
}

void ReplyCratesReloaded(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Crates reloaded");
}
