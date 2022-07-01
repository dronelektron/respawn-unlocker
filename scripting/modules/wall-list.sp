static ArrayList g_entities = null;
static ArrayList g_collisionGroups = null;

void WallList_Create() {
    g_entities = new ArrayList();
    g_collisionGroups = new ArrayList();
}

void WallList_Destroy() {
    delete g_entities;
    delete g_collisionGroups;
}

void WallList_Clear() {
    g_entities.Clear();
    g_collisionGroups.Clear();
}

int WallList_Size() {
    return g_entities.Length;
}

int WallList_GetEntity(int index) {
    return g_entities.Get(index);
}

int WallList_GetCollisionGroup(int index) {
    return g_collisionGroups.Get(index);
}

void WallList_Add(int entity, int collisionGroup) {
    g_entities.Push(entity);
    g_collisionGroups.Push(collisionGroup);
}
