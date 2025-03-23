void Math_GetMiddle(int entity, float middle[3]) {
    float origin[3];
    float mins[3];
    float maxs[3];

    Entity_GetOrigin(entity, origin);
    Entity_GetMins(entity, mins);
    Entity_GetMaxs(entity, maxs);
    AddVectors(origin, mins, mins);
    AddVectors(origin, maxs, maxs);
    AddVectors(mins, maxs, middle);
    ScaleVector(middle, HALF);
}

void Math_GetVertices(const float start[3], const float end[3], float vertices[8][3]) {
    float min[3];
    float max[3];

    min[X] = Min(start[X], end[X]);
    min[Y] = Min(start[Y], end[Y]);
    min[Z] = Min(start[Z], end[Z]);
    max[X] = Max(start[X], end[X]);
    max[Y] = Max(start[Y], end[Y]);
    max[Z] = Max(start[Z], end[Z]);

    FillVector(vertices[LEFT_FRONT_BOTTOM], min[X], max[Y], min[Z]);
    FillVector(vertices[LEFT_FRONT_TOP], min[X], max[Y], max[Z]);
    FillVector(vertices[LEFT_REAR_BOTTOM], min[X], min[Y], min[Z]);
    FillVector(vertices[LEFT_REAR_TOP], min[X], min[Y], max[Z]);
    FillVector(vertices[RIGHT_FRONT_BOTTOM], max[X], max[Y], min[Z]);
    FillVector(vertices[RIGHT_FRONT_TOP], max[X], max[Y], max[Z]);
    FillVector(vertices[RIGHT_REAR_BOTTOM], max[X], min[Y], min[Z]);
    FillVector(vertices[RIGHT_REAR_TOP], max[X], min[Y], max[Z]);
}

float Math_GetCatapultHeight(int index, float target[3]) {
    float origin[3];

    CatapultList_GetOrigin(index, origin);

    float height = target[Z] - origin[Z];

    if (height < 0.0) {
        height = CATAPULT_HEIGHT;
    }

    return height;
}

float Math_GetCatapultVelocity(int entity) {
    float height = Catapult_GetHeight(entity);

    return Pow(2.0 * Variable_Gravity() * height, HALF);
}

static void FillVector(float vector[3], float x, float y, float z) {
    vector[X] = x;
    vector[Y] = y;
    vector[Z] = z;
}

static float Min(float a, float b) {
    return a < b ? a : b;
}

static float Max(float a, float b) {
    return a > b ? a : b;
}
