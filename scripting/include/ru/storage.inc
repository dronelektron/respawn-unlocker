#if defined _ru_storage_included
 #endinput
#endif
#define _ru_storage_included

#define PERMISSIONS_USER (FPERM_U_READ | FPERM_U_WRITE | FPERM_U_EXEC)
#define PERMISSIONS_GROUP (FPERM_G_READ | FPERM_G_WRITE | FPERM_G_EXEC)
#define PERMISSIONS_OTHER (FPERM_O_READ | FPERM_O_EXEC)
#define PERMISSIONS (PERMISSIONS_USER | PERMISSIONS_GROUP | PERMISSIONS_OTHER)

#define KEY_ROOT "Entities"
#define KEY_CRATES "Crates"
#define KEY_CRATE_POSITION "position"

#define CRATE_ID_MAX_LENGTH 256
#define CREATE_YES true

typedef KeyValuesCallback = function void (KeyValues kv);
