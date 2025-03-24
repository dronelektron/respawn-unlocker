void Sound_Precache() {
    if (!PrecacheSound(SOUND_CATAPULT, PRELOAD_YES)) {
        SetFailState("Unable to precache the '%s' sound", SOUND_CATAPULT);
    }
}

void Sound_Catapult(int entity) {
    EmitSoundToAll(SOUND_CATAPULT, entity);
}
