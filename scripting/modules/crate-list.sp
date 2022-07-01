static ArrayList g_cratePositions = null;

void CrateList_Create() {
	g_cratePositions = new ArrayList(VECTOR_SIZE);
}

void CrateList_Destroy() {
    delete g_cratePositions;
}

void CrateList_Clear() {
	g_cratePositions.Clear();
}

int CrateList_Size() {
    return g_cratePositions.Length;
}

void CrateList_Get(int index, float position[VECTOR_SIZE]) {
    g_cratePositions.GetArray(index, position);
}

void CrateList_Add(float position[VECTOR_SIZE]) {
    g_cratePositions.PushArray(position);
}

void CrateList_Remove(int index) {
    g_cratePositions.Erase(index);
}
