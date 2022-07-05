void Math_CalculateZoneVertices(const float start[VECTOR_SIZE], const float end[VECTOR_SIZE], float vertices[VERTICES_COUNT][VECTOR_SIZE]) {
    Math_FillVector(vertices[LEFT_FRONT_BOTTOM], start[X], end[Y], start[Z]);
    Math_FillVector(vertices[LEFT_FRONT_TOP], start[X], end[Y], end[Z]);
    Math_FillVector(vertices[LEFT_REAR_BOTTOM], start[X], start[Y], start[Z]);
    Math_FillVector(vertices[LEFT_REAR_TOP], start[X], start[Y], end[Z]);
    Math_FillVector(vertices[RIGHT_FRONT_BOTTOM], end[X], end[Y], start[Z]);
    Math_FillVector(vertices[RIGHT_FRONT_TOP], end[X], end[Y], end[Z]);
    Math_FillVector(vertices[RIGHT_REAR_BOTTOM], end[X], start[Y], start[Z]);
    Math_FillVector(vertices[RIGHT_REAR_TOP], end[X], start[Y], end[Z]);
}

void Math_FillVector(float vector[VECTOR_SIZE], float x, float y, float z) {
    vector[X] = x;
    vector[Y] = y;
    vector[Z] = z;
}
