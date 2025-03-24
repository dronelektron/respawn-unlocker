#if defined _respawn_unlocker_entity_included
 #endinput
#endif
#define _respawn_unlocker_entity_included

#define WORLD 0
#define INVALID_HAMMER_ID 0
#define CLASS_NAME_SIZE 32
#define MAX_ENTITIES 2048

#define ENTITY_PROPERTY_VEC_ORIGIN "m_vecOrigin"
#define ENTITY_PROPERTY_VEC_MINS "m_vecMins"
#define ENTITY_PROPERTY_VEC_MAXS "m_vecMaxs"
#define ENTITY_PROPERTY_VEC_ABS_VELOCITY "m_vecAbsVelocity"
#define ENTITY_PROPERTY_COLLISION_GROUP "m_CollisionGroup"
#define ENTITY_PROPERTY_SOLID_TYPE "m_nSolidType"
#define ENTITY_PROPERTY_SOLID_FLAGS "m_usSolidFlags"
#define ENTITY_PROPERTY_HAMMER_ID "m_iHammerID"

#define COLLISION_GROUP_NONE 0
#define COLLISION_GROUP_IN_VEHICLE 10
#define COLLISION_GROUP_OBJECT 21

#define SOLID_TYPE_BBOX 2

#define SOLID_FLAG_TRIGGER (1 << 3)
#define SOLID_FLAG_USE_TRIGGER_BOUNDS (1 << 7)
