#!/bin/bash

PLUGIN_NAME="respawn-unlocker"

cd scripting
spcomp $PLUGIN_NAME.sp -o ../plugins/$PLUGIN_NAME.smx
