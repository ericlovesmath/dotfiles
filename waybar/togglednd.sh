#!/bin/bash

# Toggle DND
if [ "$(makoctl mode)" == "dnd" ]; then
    makoctl mode -s default && echo ""
else
    makoctl mode -s dnd && echo ""
fi
