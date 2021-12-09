#!/bin/sh

filename=$1
#target="$(dirname "${filename}")/../pdf"
outputFile="$(basename "$filename" .md).pdf"

pandoc \
    --pdf-engine=xelatex \
    -V "geometry:margin=1in" \
    -o "$outputFile" $filename
    #-V 'mainfont:DejaVuSerif' \
    #-V 'mainfontoptions:Extension=.ttf, UprightFont=*, BoldFont=*-Bold, ItalicFont=*-Italic, BoldItalicFont=*-BoldItalic' \
    #-V 'sansfont:DejaVuSans.ttf' \
    #-V 'monofont:DejaVuSansMono.ttf' \

 #    --toc \
