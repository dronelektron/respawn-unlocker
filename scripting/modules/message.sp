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
