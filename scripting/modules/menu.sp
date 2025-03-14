void Menu_RespawnUnlocker(int client) {
    Menu menu = new Menu(RespawnUnlocker);

    menu.SetTitle("%T", RESPAWN_UNLOCKER, client);

    AddLocalizedItem(menu, RESPAWN_LOCK, client);
    AddLocalizedItem(menu, RESPAWN_UNLOCK, client);
    AddLocalizedItem(menu, TRIGGERS, client);

    menu.Display(client, MENU_TIME_FOREVER);
}

static int RespawnUnlocker(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        if (StrEqual(info, RESPAWN_LOCK)) {
            UseCase_LockRespawn(param1);
            Menu_RespawnUnlocker(param1);
        } else if (StrEqual(info, RESPAWN_UNLOCK)) {
            UseCase_UnlockRespawn(param1);
            Menu_RespawnUnlocker(param1);
        } else if (StrEqual(info, TRIGGERS)) {
            Menu_Triggers(param1);
        }
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_Triggers(int client) {
    Menu menu = new Menu(Triggers);

    menu.SetTitle("%T", TRIGGERS, client);

    AddLocalizedItem(menu, TRIGGER_MARK, client);
    AddLocalizedItem(menu, TRIGGER_UNMARK, client);
    AddLocalizedItem(menu, TRIGGERS_SAVE, client);
    AddLocalizedItem(menu, TRIGGERS_LOAD, client);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

static int Triggers(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        if (StrEqual(info, TRIGGER_MARK)) {
            Trigger_Mark(param1);
        } else if (StrEqual(info, TRIGGER_UNMARK)) {
            Trigger_Unmark(param1);
        } else if (StrEqual(info, TRIGGERS_SAVE)) {
            UseCase_SaveTriggers(param1);
        } else if (StrEqual(info, TRIGGERS_LOAD)) {
            UseCase_LoadTriggers(param1);
        }

        Menu_Triggers(param1);
    } else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack) {
        Menu_RespawnUnlocker(param1);
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

static void AddLocalizedItem(Menu menu, const char[] phrase, int client) {
    char item[ITEM_SIZE];

    FormatEx(item, sizeof(item), "%T", phrase, client);

    menu.AddItem(phrase, item);
}
