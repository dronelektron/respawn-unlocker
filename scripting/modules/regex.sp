static Regex g_colorRegex;

void Regex_Create() {
    g_colorRegex = new Regex(REGEX_COLOR);
}

bool Regex_IsBadColor(const char[] color) {
    return g_colorRegex.MatchAll(color) != 1;
}
