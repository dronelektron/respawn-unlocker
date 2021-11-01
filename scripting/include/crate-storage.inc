#if defined _crate_storage_included
 #endinput
#endif
#define _crate_storage_included

#define MAP_NAME_MAX_LENGTH 256
#define POSITION_SIZE 3

typeset KeyValuesCallback {
    function void (KeyValues kv);
}
