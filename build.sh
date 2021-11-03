#!/bin/bash

PLUGIN_NAME="respawn-unlocker"

cd scripting
spcomp $PLUGIN_NAME.sp modules/*.sp -i include -o ../plugins/$PLUGIN_NAME.smx
