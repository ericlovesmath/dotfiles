#!/usr/bin/env bash

pkill -f spotifyd
spotifyd
spt
pkill -f spotifyd


#if [ ! "$(pgrep "spotifyd")" ]; then
#    spotifyd
#    until [ "$(pgrep "spotifyd")" ]
#    do   
#        sleep 1
#    done
#fi
#
#spt
#
#until [ !"$(pgrep "spotifyd")" ]
#    do   
#        pkill spotifyd
#    done
#pkill spotifyd
