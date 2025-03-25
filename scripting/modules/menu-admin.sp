static TopMenu g_adminMenu;
static TopMenuObject g_category;
static TopMenuObject g_lockRespawn;
static TopMenuObject g_unlockRespawn;
static TopMenuObject g_walls;
static TopMenuObject g_triggers;
static TopMenuObject g_catapults;

public void OnAdminMenuReady(Handle topMenuHandle) {
    TopMenu topMenu = TopMenu.FromHandle(topMenuHandle);

    if (topMenu != g_adminMenu) {
        g_adminMenu = topMenu;

        FillAdminMenu();
    }
}

public void OnLibraryRemoved(const char[] name) {
    if (StrEqual(name, ADMIN_MENU)) {
        g_adminMenu = null;
    }
}

void AdminMenu_Create() {
    if (LibraryExists(ADMIN_MENU)) {
        TopMenu topMenu = GetAdminTopMenu();

        if (topMenu == null) {
            return;
        }

        OnAdminMenuReady(topMenu);
    }
}

bool AdminMenu_Exists() {
    return g_adminMenu != null;
}

void AdminMenu_Show(int client) {
    g_adminMenu.Display(client, TopMenuPosition_Start);
}

void AdminMenu_ShowCategory(int client) {
    g_adminMenu.DisplayCategory(g_category, client);
}

static void FillAdminMenu() {
    g_category = g_adminMenu.AddCategory(RESPAWN_UNLOCKER, RespawnUnlocker);

    if (g_category == INVALID_TOPMENUOBJECT) {
        SetFailState("Unable to create the '%s' category", RESPAWN_UNLOCKER);
    }

    g_lockRespawn = AddTopMenuItem(RESPAWN_LOCK);
    g_unlockRespawn = AddTopMenuItem(RESPAWN_UNLOCK);
    g_walls = AddTopMenuItem(WALLS);
    g_triggers = AddTopMenuItem(TRIGGERS);
    g_catapults = AddTopMenuItem(CATAPULTS);
}

static TopMenuObject AddTopMenuItem(const char[] name) {
    return g_adminMenu.AddItem(name, RespawnUnlocker, g_category);
}

static void RespawnUnlocker(TopMenu topMenu, TopMenuAction action, TopMenuObject topMenuObject, int param, char[] buffer, int maxLength) {
    if (action == TopMenuAction_DisplayTitle) {
        if (topMenuObject == g_category) {
            FormatEx(buffer, maxLength, "%T", RESPAWN_UNLOCKER, param);
        }
    } else if (action == TopMenuAction_DisplayOption) {
        if (topMenuObject == g_category) {
            FormatEx(buffer, maxLength, "%T", RESPAWN_UNLOCKER, param);
        } else if (topMenuObject == g_lockRespawn) {
            FormatEx(buffer, maxLength, "%T", RESPAWN_LOCK, param);
        } else if (topMenuObject == g_unlockRespawn) {
            FormatEx(buffer, maxLength, "%T", RESPAWN_UNLOCK, param);
        } else if (topMenuObject == g_walls) {
            FormatEx(buffer, maxLength, "%T", WALLS, param);
        } else if (topMenuObject == g_triggers) {
            FormatEx(buffer, maxLength, "%T", TRIGGERS, param);
        } else if (topMenuObject == g_catapults) {
            FormatEx(buffer, maxLength, "%T", CATAPULTS, param);
        }
    } else if (action == TopMenuAction_SelectOption) {
        if (topMenuObject == g_lockRespawn) {
            UseCase_LockRespawn(param);
            AdminMenu_ShowCategory(param);
        } else if (topMenuObject == g_unlockRespawn) {
            UseCase_UnlockRespawn(param);
            AdminMenu_ShowCategory(param);
        } else if (topMenuObject == g_walls) {
            Menu_Walls(param);
        } else if (topMenuObject == g_triggers) {
            Menu_Triggers(param);
        } else if (topMenuObject == g_catapults) {
            Menu_Catapults(param);
        }
    }
}
