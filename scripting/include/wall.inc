#if defined _wall_included
 #endinput
#endif
#define _wall_included

#define ENTITY_NOT_FOUND -1
#define COLLISION_GROUP_IN_VEHICLE 10
#define COLLISION_GROUP "m_CollisionGroup"

char g_wallEntityClasses[][] = {"func_team_wall", "func_teamblocker"};

ArrayList g_wallEntities = null;
ArrayList g_wallCollisionGroups = null;
