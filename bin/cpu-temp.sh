#!/usr/bin/env bash

osascript -e 'tell application "System Events" to tell process "Macs Fan Control" to get the name of the first UI element of menu bar 2'
