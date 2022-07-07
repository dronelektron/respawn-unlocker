static TopMenu g_adminMenu = null;

static TopMenuObject g_respawnUnlockerCategory = INVALID_TOPMENUOBJECT;
static TopMenuObject g_menuItemCratesManagement = INVALID_TOPMENUOBJECT;
static TopMenuObject g_menuItemTriggersManagement = INVALID_TOPMENUOBJECT;

void AdminMenu_Create() {
    TopMenu topMenu = GetAdminTopMenu();

    if (LibraryExists(ADMIN_MENU) && topMenu != null) {
        OnAdminMenuReady(topMenu);
    }
}

void AdminMenu_Destroy() {
    g_adminMenu = null;
}

public void AdminMenu_OnReady(Handle topMenuHandle) {
    TopMenu topMenu = TopMenu.FromHandle(topMenuHandle);

    if (topMenu == g_adminMenu) {
        return;
    }

    g_adminMenu = topMenu;

    AdminMenu_Fill();
}

void AdminMenu_Fill() {
    g_respawnUnlockerCategory = g_adminMenu.AddCategory(RESPAWN_UNLOCKER, AdminMenuHandler_RespawnUnlocker);

    if (g_respawnUnlockerCategory != INVALID_TOPMENUOBJECT) {
        g_menuItemCratesManagement = AdminMenu_AddItem(CRATES_MANAGEMENT);
        g_menuItemTriggersManagement = AdminMenu_AddItem(TRIGGERS_MANAGEMENT);
    }
}

TopMenuObject AdminMenu_AddItem(const char[] name) {
    return g_adminMenu.AddItem(name, AdminMenuHandler_RespawnUnlocker, g_respawnUnlockerCategory);
}

public void AdminMenuHandler_RespawnUnlocker(TopMenu topmenu, TopMenuAction action, TopMenuObject topobj_id, int param, char[] buffer, int maxlength) {
    if (action == TopMenuAction_DisplayOption) {
        if (topobj_id == g_respawnUnlockerCategory) {
            Format(buffer, maxlength, "%T", RESPAWN_UNLOCKER, param);
        } else if (topobj_id == g_menuItemCratesManagement) {
            Format(buffer, maxlength, "%T", CRATES_MANAGEMENT, param);
        } else if (topobj_id == g_menuItemTriggersManagement) {
            Format(buffer, maxlength, "%T", TRIGGERS_MANAGEMENT, param);
        }
    } else if (action == TopMenuAction_DisplayTitle) {
        if (topobj_id == g_respawnUnlockerCategory) {
            Format(buffer, maxlength, "%T", RESPAWN_UNLOCKER, param);
        }
    } else if (action == TopMenuAction_SelectOption) {
        if (topobj_id == g_menuItemCratesManagement) {
            Menu_CratesManagement(param);
        } else if (topobj_id == g_menuItemTriggersManagement) {
            Menu_TriggersManagement(param);
        }
    }
}

void Menu_CratesManagement(int client) {
    Menu menu = new Menu(MenuHandler_CratesManagement);

    menu.SetTitle("%T", CRATES_MANAGEMENT, client);

    Menu_AddItem(menu, ITEM_CRATE_ADD, client);
    Menu_AddItem(menu, ITEM_CRATE_REMOVE, client);
    Menu_AddItem(menu, ITEM_CRATES_SHOW, client);
    Menu_AddItem(menu, ITEM_CRATES_HIDE, client);
    Menu_AddItem(menu, ITEM_CRATES_LOAD, client);
    Menu_AddItem(menu, ITEM_CRATES_SAVE, client);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_CratesManagement(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[MENU_ITEM_INFO_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        if (StrEqual(info, ITEM_CRATE_ADD)) {
            UseCase_AddCrate(param1);
        } else if (StrEqual(info, ITEM_CRATE_REMOVE)) {
            UseCase_RemoveCrate(param1);
        } else if (StrEqual(info, ITEM_CRATES_SHOW)) {
            UseCase_ShowCrates(param1);
        } else if (StrEqual(info, ITEM_CRATES_HIDE)) {
            UseCase_HideCrates(param1);
        } else if (StrEqual(info, ITEM_CRATES_LOAD)) {
            UseCase_LoadCrates(param1);
        } else if (StrEqual(info, ITEM_CRATES_SAVE)) {
            UseCase_SaveCrates(param1);
        }

        Menu_CratesManagement(param1);
    } else {
        MenuHandler_Default(menu, action, param1, param2);
    }

    return 0;
}

void Menu_TriggersManagement(int client) {
    Menu menu = new Menu(MenuHandler_TriggersManagement);

    menu.SetTitle("%T", TRIGGERS_MANAGEMENT, client);

    Menu_AddItem(menu, ITEM_TRIGGER_ADD, client);
    Menu_AddItem(menu, ITEM_TRIGGER_REMOVE, client);
    Menu_AddItem(menu, ITEM_TRIGGERS_LOAD, client);
    Menu_AddItem(menu, ITEM_TRIGGERS_SAVE, client);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_TriggersManagement(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[MENU_ITEM_INFO_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        if (StrEqual(info, ITEM_TRIGGER_ADD)) {
            UseCase_AddTriggerToList(param1);
        } else if (StrEqual(info, ITEM_TRIGGER_REMOVE)) {
            UseCase_RemoveTriggerFromList(param1);
        } else if (StrEqual(info, ITEM_TRIGGERS_LOAD)) {
            UseCase_LoadTriggers(param1);
        } else if (StrEqual(info, ITEM_TRIGGERS_SAVE)) {
            UseCase_SaveTriggers(param1);
        }

        Menu_TriggersManagement(param1);
    } else {
        MenuHandler_Default(menu, action, param1, param2);
    }

    return 0;
}

void MenuHandler_Default(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_End) {
        delete menu;
    } else if (action == MenuAction_Cancel) {
        if (param2 == MenuCancel_ExitBack && g_adminMenu != null) {
            g_adminMenu.Display(param1, TopMenuPosition_LastCategory);
        }
    }
}

void Menu_AddItem(Menu menu, const char[] phrase, int client) {
    char buffer[TEXT_BUFFER_MAX_SIZE];

    Format(buffer, sizeof(buffer), "%T", phrase, client);

    menu.AddItem(phrase, buffer);
}
