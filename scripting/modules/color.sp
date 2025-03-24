void Color_HexToRgb(const char[] hex, int& red, int& green, int& blue) {
    red = HexToInt(hex, 0);
    green = HexToInt(hex, 2);
    blue = HexToInt(hex, 4);
}

static int HexToInt(const char[] hex, int start) {
    return CharToInt(hex[start]) * 16 + CharToInt(hex[start + 1]);
}

static int CharToInt(char c) {
    return c >= '0' && c <= '9' ? c - '0' : c - 'A' + 10;
}
