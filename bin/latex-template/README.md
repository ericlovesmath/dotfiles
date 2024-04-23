How to precompile the preamble:

- Add `documentclass` specification to the preamble such as `\documentclass[a4paper]{article}`
- Run `pdflatex -ini -jobname="preamble" "&pdflatex preamble.tex\dump"`
- Move `preamble.fmt` into the relevant folder
- Place `%&preamble` on top of target document using preamble instead of `\input{preamble.tex}`
- Reference: https://web.archive.org/web/20160712215709/http://www.howtotex.com:80/tips-tricks/faster-latex-part-iv-use-a-precompiled-preamble/
