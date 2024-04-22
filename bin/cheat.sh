#!/bin/sh
LANGUAGES=$(echo "golang lua cpp typescript python java csharp rust css haskell ocaml bash" | tr ' ' '\n')
CORE_UTILS=$(echo "xargs find mv sed awk" | tr ' ' '\n')

SELECTED=$(printf "$LANGUAGES\n$CORE_UTILS" | fzf)
echo $SELECTED

read -p "Query: " QUERY
QUERY=$(printf %s "$QUERY" | jq -sRr @uri)

#if printf $LANGUAGES | grep -qs $SELECTED; then
if grep -q "$SELECTED" <<< "$LANGUAGES"; then
    curl cht.sh/$SELECTED/$QUERY
else
    curl cht.sh/$SELECTED~$QUERY
fi
