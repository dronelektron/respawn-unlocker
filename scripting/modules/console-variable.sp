static ConVar g_gravity;
static ConVar g_autoUnlock;
static ConVar g_catapultColor;

void Variable_Create() {
    g_gravity = FindConVar("sv_gravity");
    g_autoUnlock = CreateConVar("sm_respawnunlocker_auto", "1", "Automatic respawn unlock (on - 1, off - 0)");
    g_catapultColor = CreateConVar("sm_respawnunlocker_catapult_color", "EE82EE", "Catapult color (in HEX)");
    g_catapultColor.AddChangeHook(OnCatapultColor);
}

float Variable_Gravity() {
    return g_gravity.FloatValue;
}

bool Variable_AutoUnlock() {
    return g_autoUnlock.BoolValue;
}

void Variable_CatapultColor(int& red, int& green, int& blue) {
    char color[COLOR_SIZE];

    g_catapultColor.GetString(color, sizeof(color));

    Color_HexToRgb(color, red, green, blue);
}

static void OnCatapultColor(ConVar variable, const char[] oldValue, const char[] newValue) {
    if (Regex_IsBadColor(newValue)) {
        g_catapultColor.SetString(oldValue);
    }
}
