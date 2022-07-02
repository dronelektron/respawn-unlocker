static TopMenu g_adminMenu = null;

static TopMenuObject g_respawnUnlockerCategory = INVALID_TOPMENUOBJECT;
static TopMenuObject g_menuItemEnableEditor = INVALID_TOPMENUOBJECT;
static TopMenuObject g_menuItemDisableEditor = INVALID_TOPMENUOBJECT;
static TopMenuObject g_menuItemAddCrate = INVALID_TOPMENUOBJECT;
static TopMenuObject g_menuItemRemoveCrate = INVALID_TOPMENUOBJECT;
static TopMenuObject g_menuItemLoadCrates = INVALID_TOPMENUOBJECT;
static TopMenuObject g_menuItemSaveCrates = INVALID_TOPMENUOBJECT;

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
        g_menuItemEnableEditor = AdminMenu_AddItem(ITEM_EDITOR_ENABLE);
        g_menuItemDisableEditor = AdminMenu_AddItem(ITEM_EDITOR_DISABLE);
        g_menuItemAddCrate = AdminMenu_AddItem(ITEM_EDITOR_CRATE_ADD);
        g_menuItemRemoveCrate = AdminMenu_AddItem(ITEM_EDITOR_CRATE_REMOVE);
        g_menuItemLoadCrates = AdminMenu_AddItem(ITEM_CRATES_LOAD);
        g_menuItemSaveCrates = AdminMenu_AddItem(ITEM_CRATES_SAVE);
    }
}

TopMenuObject AdminMenu_AddItem(const char[] name) {
    return g_adminMenu.AddItem(name, AdminMenuHandler_RespawnUnlocker, g_respawnUnlockerCategory);
}

public void AdminMenuHandler_RespawnUnlocker(TopMenu topmenu, TopMenuAction action, TopMenuObject topobj_id, int param, char[] buffer, int maxlength) {
    if (action == TopMenuAction_DisplayOption) {
        if (topobj_id == g_respawnUnlockerCategory) {
            Format(buffer, maxlength, "%T", RESPAWN_UNLOCKER, param);
        } else if (topobj_id == g_menuItemEnableEditor) {
            Format(buffer, maxlength, "%T", ITEM_EDITOR_ENABLE, param);
        } else if (topobj_id == g_menuItemDisableEditor) {
            Format(buffer, maxlength, "%T", ITEM_EDITOR_DISABLE, param);
        } else if (topobj_id == g_menuItemAddCrate) {
            Format(buffer, maxlength, "%T", ITEM_EDITOR_CRATE_ADD, param);
        } else if (topobj_id == g_menuItemRemoveCrate) {
            Format(buffer, maxlength, "%T", ITEM_EDITOR_CRATE_REMOVE, param);
        } else if (topobj_id == g_menuItemLoadCrates) {
            Format(buffer, maxlength, "%T", ITEM_CRATES_LOAD, param);
        } else if (topobj_id == g_menuItemSaveCrates) {
            Format(buffer, maxlength, "%T", ITEM_CRATES_SAVE, param);
        }
    } else if (action == TopMenuAction_DisplayTitle) {
        if (topobj_id == g_respawnUnlockerCategory) {
            Format(buffer, maxlength, "%T", RESPAWN_UNLOCKER, param);
        }
    } else if (action == TopMenuAction_SelectOption) {
        if (topobj_id == g_menuItemEnableEditor) {
            UseCase_EnableEditor(param);
        } else if (topobj_id == g_menuItemDisableEditor) {
            UseCase_DisableEditor(param);
        } else if (topobj_id == g_menuItemAddCrate) {
            UseCase_AddCrate(param);
        } else if (topobj_id == g_menuItemRemoveCrate) {
            UseCase_RemoveCrate(param);
        } else if (topobj_id == g_menuItemLoadCrates) {
            UseCase_LoadCrates(param);
        } else if (topobj_id == g_menuItemSaveCrates) {
            UseCase_SaveCrates(param);
        }

        topmenu.DisplayCategory(g_respawnUnlockerCategory, param);
    }
}
