static char g_catapultName[MAXPLAYERS + 1][CATAPULT_NAME_SIZE];

void Menu_RespawnUnlocker(int client) {
    Menu menu = new Menu(RespawnUnlocker);

    menu.SetTitle("%T", RESPAWN_UNLOCKER, client);

    AddLocalizedItem(menu, RESPAWN_LOCK, client);
    AddLocalizedItem(menu, RESPAWN_UNLOCK, client);
    AddLocalizedItem(menu, WALLS, client);
    AddLocalizedItem(menu, TRIGGERS, client);
    AddLocalizedItem(menu, CATAPULTS, client);

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
        } else if (StrEqual(info, WALLS)) {
            Menu_Walls(param1);
        }  else if (StrEqual(info, TRIGGERS)) {
            Menu_Triggers(param1);
        } else if (StrEqual(info, CATAPULTS)) {
            Menu_Catapults(param1);
        }
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_Walls(int client) {
    Menu menu = new Menu(Walls);

    menu.SetTitle("%T", WALLS, client);

    AddLocalizedItem(menu, WALLS_ENABLE, client);
    AddLocalizedItem(menu, WALLS_DISABLE, client);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

static int Walls(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        if (StrEqual(info, WALLS_ENABLE)) {
            UseCase_EnableWalls(param1);
        } else if (StrEqual(info, WALLS_DISABLE)) {
            UseCase_DisableWalls(param1);
        }

        Menu_Walls(param1);
    } else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack) {
        Menu_RespawnUnlocker(param1);
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
    AddLocalizedItem(menu, TRIGGER_SHOW, client);
    AddLocalizedItem(menu, TRIGGERS_ENABLE, client);
    AddLocalizedItem(menu, TRIGGERS_DISABLE, client);
    AddLocalizedItem(menu, TRIGGERS_SAVE, client);
    AddLocalizedItem(menu, TRIGGERS_LOAD, client);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

static int Triggers(Menu menu, MenuAction action, int param1, int param2) {
    bool showMenuAgain = true;

    if (action == MenuAction_Select) {
        char info[INFO_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        if (StrEqual(info, TRIGGER_MARK)) {
            Trigger_Mark(param1);
        } else if (StrEqual(info, TRIGGER_UNMARK)) {
            Trigger_Unmark(param1);
        } else if (StrEqual(info, TRIGGER_SHOW)) {
            if (TriggerList_Size() == 0) {
                Message_TriggerListEmpty(param1);
            } else {
                Menu_ShowTrigger(param1);

                showMenuAgain = false;
            }
        } else if (StrEqual(info, TRIGGERS_ENABLE)) {
            UseCase_EnableTriggers(param1);
        } else if (StrEqual(info, TRIGGERS_DISABLE)) {
            UseCase_DisableTriggers(param1);
        }  else if (StrEqual(info, TRIGGERS_SAVE)) {
            UseCase_SaveTriggers(param1);
        } else if (StrEqual(info, TRIGGERS_LOAD)) {
            UseCase_LoadTriggers(param1);
        }

        if (showMenuAgain) {
            Menu_Triggers(param1);
        }
    } else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack) {
        Menu_RespawnUnlocker(param1);
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_ShowTrigger(int client, int firstItem = 0) {
    Menu menu = new Menu(ShowTrigger);

    menu.SetTitle("%T", TRIGGER_SHOW, client);

    AddTriggerItems(menu, client);

    menu.ExitBackButton = true;
    menu.DisplayAt(client, firstItem, MENU_TIME_FOREVER);
}

static int ShowTrigger(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        int hammerId = StringToInt(info);

        Menu_ShowTrigger(param1, menu.Selection);
        Trigger_Path(param1, hammerId);
    } else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack) {
        Menu_Triggers(param1);
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

static void AddTriggerItems(Menu menu, int client) {
    char info[INFO_SIZE];
    char item[ITEM_SIZE];

    for (int i = 0; i < TriggerList_Size(); i++) {
        int hammerId = TriggerList_GetHammerId(i);

        IntToString(hammerId, info, sizeof(info));
        FormatEx(item, sizeof(item), "%T", TRIGGER, client, hammerId);

        menu.AddItem(info, item);
    }
}

void Menu_Catapults(int client) {
    Menu menu = new Menu(Catapults);

    menu.SetTitle("%T", CATAPULTS, client);

    AddLocalizedItem(menu, CATAPULT_ADD, client);
    AddLocalizedItem(menu, CATAPULT_LIST, client);
    AddLocalizedItem(menu, CATAPULTS_SAVE, client);
    AddLocalizedItem(menu, CATAPULTS_LOAD, client);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

static int Catapults(Menu menu, MenuAction action, int param1, int param2) {
    bool showMenuAgain = true;

    if (action == MenuAction_Select) {
        char info[INFO_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        if (StrEqual(info, CATAPULT_ADD)) {
            Catapult_Add(param1);
        } else if (StrEqual(info, CATAPULT_LIST)) {
            Menu_CatapultList(param1);

            showMenuAgain = false;
        } else if (StrEqual(info, CATAPULTS_SAVE)) {
            UseCase_SaveCatapults(param1);
        } else if (StrEqual(info, CATAPULTS_LOAD)) {
            UseCase_LoadCatapults(param1);
        }

        if (showMenuAgain) {
            Menu_Catapults(param1);
        }
    } else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack) {
        Menu_RespawnUnlocker(param1);
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_CatapultList(int client) {
    if (CatapultList_Size() == 0) {
        Message_CatapultListEmpty(client);
        Menu_Catapults(client);

        return;
    }

    Menu menu = new Menu(CatapultList);

    menu.SetTitle("%T", CATAPULT_LIST, client);

    AddCatapultItems(menu, client);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

static int CatapultList(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        Menu_CatapultEditor(param1, info);
    } else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack) {
        Menu_Catapults(param1);
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_CatapultEditor(int client, const char[] name) {
    strcopy(g_catapultName[client], CATAPULT_NAME_SIZE, name);

    Menu menu = new Menu(CatapultEditor);

    menu.SetTitle("%T", CATAPULT, client, name);

    AddLocalizedItem(menu, CATAPULT_ENABLE, client);
    AddLocalizedItem(menu, CATAPULT_DISABLE, client);
    AddLocalizedItem(menu, CATAPULT_SET_ORIGIN, client);
    AddLocalizedItem(menu, CATAPULT_SET_HEIGHT, client);
    AddLocalizedItem(menu, CATAPULT_SHOW, client);
    AddLocalizedItem(menu, CATAPULT_REMOVE, client);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

static int CatapultEditor(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        if (StrEqual(info, CATAPULT_ENABLE)) {
            Catapult_Toggle(param1, g_catapultName[param1], ENABLED_YES);
        } else if (StrEqual(info, CATAPULT_DISABLE)) {
            Catapult_Toggle(param1, g_catapultName[param1], ENABLED_NO);
        } else if (StrEqual(info, CATAPULT_SET_ORIGIN)) {
            Catapult_SetOrigin(param1, g_catapultName[param1]);
        } else if (StrEqual(info, CATAPULT_SET_HEIGHT)) {
            Catapult_SetHeight(param1, g_catapultName[param1]);
        } else if (StrEqual(info, CATAPULT_SHOW)) {
            Catapult_Path(param1, g_catapultName[param1]);
        } else if (StrEqual(info, CATAPULT_REMOVE)) {
            Catapult_Remove(param1, g_catapultName[param1]);
        }

        if (CatapultList_FindByName(g_catapultName[param1]) == INVALID_INDEX) {
            Menu_CatapultList(param1);
        } else {
            Menu_CatapultEditor(param1, g_catapultName[param1]);
        }
    } else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack) {
        Menu_CatapultList(param1);
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

static void AddCatapultItems(Menu menu, int client) {
    char info[INFO_SIZE];
    char item[ITEM_SIZE];

    for (int i = 0; i < CatapultList_Size(); i++) {
        CatapultList_GetName(i, info);
        FormatEx(item, sizeof(item), "%T", CATAPULT, client, info);

        menu.AddItem(info, item);
    }
}

static void AddLocalizedItem(Menu menu, const char[] phrase, int client) {
    char item[ITEM_SIZE];

    FormatEx(item, sizeof(item), "%T", phrase, client);

    menu.AddItem(phrase, item);
}
