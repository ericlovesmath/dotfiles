#!/bin/sh

filename=$1
outputFile="$(basename "$filename" .md).pdf"

pandoc \
    --filter $HOME/bin/pandoc-latex-env-filter.py -s \
    --include-in-header $HOME/bin/preamble.tex \
    --metadata-file $HOME/bin/args.yaml \
    -f markdown $filename -t pdf -o "$outputFile"
    # --filter pandoc-latex-environment \
    # --template $HOME/bin/preamble.tex \
    # --filter pandoc-crossref
    # --pdf-engine=xelatex \
