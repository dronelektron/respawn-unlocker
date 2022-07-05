static const int g_beamColor[] = {
    BEAM_COLOR_RED,
    BEAM_COLOR_GREEN,
    BEAM_COLOR_BLUE,
    BEAM_COLOR_ALPHA
};

static int g_beamModelIndex;
static int g_beamHaloIndex;

void Visualizer_PrecacheTempEntityModels() {
    g_beamModelIndex = PrecacheModel("materials/sprites/laser.vmt");
    g_beamHaloIndex  = PrecacheModel("materials/sprites/halo01.vmt");
}

void Visualizer_DrawTrigger(int client, const float vertices[VERTICES_COUNT][VECTOR_SIZE]) {
    Visualizer_DrawBeam(client, vertices[LEFT_REAR_BOTTOM], vertices[RIGHT_REAR_BOTTOM]);
    Visualizer_DrawBeam(client, vertices[LEFT_REAR_TOP], vertices[RIGHT_REAR_TOP]);
    Visualizer_DrawBeam(client, vertices[LEFT_FRONT_BOTTOM], vertices[RIGHT_FRONT_BOTTOM]);
    Visualizer_DrawBeam(client, vertices[LEFT_FRONT_TOP], vertices[RIGHT_FRONT_TOP]);
    Visualizer_DrawBeam(client, vertices[LEFT_REAR_BOTTOM], vertices[LEFT_FRONT_BOTTOM]);
    Visualizer_DrawBeam(client, vertices[LEFT_REAR_TOP], vertices[LEFT_FRONT_TOP]);
    Visualizer_DrawBeam(client, vertices[RIGHT_REAR_BOTTOM], vertices[RIGHT_FRONT_BOTTOM]);
    Visualizer_DrawBeam(client, vertices[RIGHT_REAR_TOP], vertices[RIGHT_FRONT_TOP]);
    Visualizer_DrawBeam(client, vertices[LEFT_REAR_BOTTOM], vertices[LEFT_REAR_TOP]);
    Visualizer_DrawBeam(client, vertices[LEFT_FRONT_BOTTOM], vertices[LEFT_FRONT_TOP]);
    Visualizer_DrawBeam(client, vertices[RIGHT_REAR_BOTTOM], vertices[RIGHT_REAR_TOP]);
    Visualizer_DrawBeam(client, vertices[RIGHT_FRONT_BOTTOM], vertices[RIGHT_FRONT_TOP]);
}

void Visualizer_DrawBeam(int client, const float start[VECTOR_SIZE], const float end[VECTOR_SIZE]) {
    TE_SetupBeamPoints(
        start,
        end,
        g_beamModelIndex,
        g_beamHaloIndex,
        BEAM_START_FRAME,
        BEAM_FRAME_RATE,
        BEAM_LIFE_TIME,
        BEAM_WIDTH,
        BEAM_END_WIDTH,
        BEAM_FADE_LENGTH,
        BEAM_AMPLITUDE,
        g_beamColor,
        BEAM_SPEED
    );

    TE_SendToClient(client);
}
