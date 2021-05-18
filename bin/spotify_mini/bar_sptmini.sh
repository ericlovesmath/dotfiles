#!/usr/bin/env bash

source $(dirname "$0")/credentials.cfg

# Internal settings
REDIRECT_URL="https://localhost:8888/callback"

ENCODED_CLIENT=$(echo -n "$CLIENT_ID:$CLIENT_SECRET" | base64)
ACCESS_TOKEN=$(curl -s -H "Authorization: Basic $ENCODED_CLIENT" -d grant_type=refresh_token -d refresh_token=$REFRESH_TOKEN https://accounts.spotify.com/api/token | jq -r ".access_token")

if [[ "$ACCESS_TOKEN" == null ]]; then
    printf '%s\n' "Credentials missing / incorrect. Try running ./gen-credentials.sh" >&2
    show_cursor
fi

CURRENT_SONG=$(curl -sX "GET" "https://api.spotify.com/v1/me/player/currently-playing?market=US" -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer $ACCESS_TOKEN")
SONG_TITLE=$(echo $CURRENT_SONG | jq -r ".item.name")
SONG_ARTIST=$(echo $CURRENT_SONG | jq -r ".item.artists[].name")

if [[ "$SONG_TITLE" != "$OLD_SONG_TITLE" && "$SONG_TITLE" != "" ]]; then 
  OLD_SONG_TITLE="$SONG_TITLE"
  echo Playing: $SONG_TITLE - $SONG_ARTIST # | fold -s -w $(($COLUMNS-4)) | fmt -c -w $COLUMNS
fi; 
