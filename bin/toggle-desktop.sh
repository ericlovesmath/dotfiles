#!/usr/bin/env bash

IS_DESKTOP_VISIBLE=$(defaults read com.apple.finder CreateDesktop)

if [[ "$IS_DESKTOP_VISIBLE" == "true" ]]; then
    defaults write com.apple.finder CreateDesktop false
else
    defaults write com.apple.finder CreateDesktop true
fi

killall Finder
