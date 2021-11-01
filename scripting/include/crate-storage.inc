#if defined _crate_storage_included
 #endinput
#endif
#define _crate_storage_included

#define MAP_NAME_MAX_LENGTH 256
#define POSITION_SIZE 3

typeset KeyValuesCallback {
    function void (KeyValues kv);
}

char g_mapName[MAP_NAME_MAX_LENGTH];
char g_configPath[PLATFORM_MAX_PATH];

ArrayList g_cratePositions = null;
