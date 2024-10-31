#!/usr/bin/env bash

screencapture -i /tmp/ocr_snapshot.png
tesseract --dpi 300 /tmp/ocr_snapshot.png stdout 2>&1
#tesseract --dpi 300 /tmp/ocr_snapshot.png stdout  -l {query} 2>&1
