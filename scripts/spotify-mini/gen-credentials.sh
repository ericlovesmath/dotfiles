#!/usr/bin/env bash

echo Make a new Spotify Application \(Does not require Premium\): https://developer.spotify.com/dashboard/applications
echo Add "https://localhost:8888/callback" as a Redirect URI

echo Client ID:
read CLIENT_ID
echo Client Secret: 
read CLIENT_SECRET

echo
echo Use the following link to authorize Spotify:
echo "https://accounts.spotify.com/authorize?response_type=code&client_id=$CLIENT_ID&scope=user-read-currently-playing%20user-read-playback-state&redirect_uri=https%3A%2F%2Flocalhost%3A8888%2Fcallback"
echo
echo Once authorized, copy the part of the URI after \"?code=\"
echo CODE: 
read CODE

REDIRECT_URL="https://localhost:8888/callback"
REFRESH_TOKEN=$(curl -d client_id=$CLIENT_ID -d client_secret=$CLIENT_SECRET -d grant_type=authorization_code -d code=$CODE -d redirect_uri=$REDIRECT_URL https://accounts.spotify.com/api/token | jq -r ".refresh_token")

rm $(dirname "$0")/credentials.cfg

echo 'CLIENT_ID='"\"$CLIENT_ID\"" >> $(dirname "$0")/credentials.cfg
echo 'CLIENT_SECRET='"\"$CLIENT_SECRET\"" >> $(dirname "$0")/credentials.cfg
echo 'CODE='"\"$CODE\"" >> $(dirname "$0")/credentials.cfg
echo 'REFRESH_TOKEN='"\"$REFRESH_TOKEN\"" >> $(dirname "$0")/credentials.cfg
echo 'REFRESH_RATE=5' >> $(dirname "$0")/credentials.cfg

echo
echo credentials.cfg created
echo Configuration complete. Run ./sptmini.sh again
