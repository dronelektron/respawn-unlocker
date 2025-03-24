static int g_beamModelIndex;
static int g_beamHaloIndex;

void Visualizer_Precache() {
    g_beamModelIndex = PrecacheModel("materials/sprites/laser.vmt", PRELOAD_YES);
    g_beamHaloIndex  = PrecacheModel("materials/sprites/halo01.vmt", PRELOAD_YES);

    UseCase_AssertModel(g_beamModelIndex);
    UseCase_AssertModel(g_beamHaloIndex);
}

void Visualizer_DrawBox(int client, const float vertices[8][3], int color[4]) {
    Visualizer_DrawBeam(client, vertices[LEFT_REAR_BOTTOM], vertices[RIGHT_REAR_BOTTOM], color);
    Visualizer_DrawBeam(client, vertices[LEFT_REAR_TOP], vertices[RIGHT_REAR_TOP], color);
    Visualizer_DrawBeam(client, vertices[LEFT_FRONT_BOTTOM], vertices[RIGHT_FRONT_BOTTOM], color);
    Visualizer_DrawBeam(client, vertices[LEFT_FRONT_TOP], vertices[RIGHT_FRONT_TOP], color);
    Visualizer_DrawBeam(client, vertices[LEFT_REAR_BOTTOM], vertices[LEFT_FRONT_BOTTOM], color);
    Visualizer_DrawBeam(client, vertices[LEFT_REAR_TOP], vertices[LEFT_FRONT_TOP], color);
    Visualizer_DrawBeam(client, vertices[RIGHT_REAR_BOTTOM], vertices[RIGHT_FRONT_BOTTOM], color);
    Visualizer_DrawBeam(client, vertices[RIGHT_REAR_TOP], vertices[RIGHT_FRONT_TOP], color);
    Visualizer_DrawBeam(client, vertices[LEFT_REAR_BOTTOM], vertices[LEFT_REAR_TOP], color);
    Visualizer_DrawBeam(client, vertices[LEFT_FRONT_BOTTOM], vertices[LEFT_FRONT_TOP], color);
    Visualizer_DrawBeam(client, vertices[RIGHT_REAR_BOTTOM], vertices[RIGHT_REAR_TOP], color);
    Visualizer_DrawBeam(client, vertices[RIGHT_FRONT_BOTTOM], vertices[RIGHT_FRONT_TOP], color);
}

void Visualizer_DrawBeam(int client, const float start[3], const float end[3], int color[4]) {
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
        color,
        BEAM_SPEED
    );

    TE_SendToClient(client);
}
