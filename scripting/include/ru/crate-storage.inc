#if defined _ru_crate_storage_included
 #endinput
#endif
#define _ru_crate_storage_included

#define MAP_NAME_MAX_LENGTH 256
#define CRATE_ID_MAX_LENGTH 256
#define KV_KEY_POSITION "position"

enum {
    X = 0,
    Y,
    Z,
    VECTOR_SIZE
};

typedef KeyValuesCallback = function void (KeyValues kv);
