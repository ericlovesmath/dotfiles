#!/bin/sh

filename=$1
#target="$(dirname "${filename}")/../pdf"
outputFile="$(basename "$filename" .md).pdf"

pandoc \
    -V "geometry:margin=1in" \
    -f markdown $filename -t pdf -o "$outputFile"
    # --filter pandoc-crossref
    # --pdf-engine=xelatex \
    #-V 'mainfont:DejaVuSerif' \
    #-V 'mainfontoptions:Extension=.ttf, UprightFont=*, BoldFont=*-Bold, ItalicFont=*-Italic, BoldItalicFont=*-BoldItalic' \
    #-V 'sansfont:DejaVuSans.ttf' \
    #-V 'monofont:DejaVuSansMono.ttf' \

    # --toc \
