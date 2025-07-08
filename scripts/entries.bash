#!/usr/bin/env bash

# Populates entries/entries.typ file with all the entry typst files in the entries folder
# Each typst file within this folder and its children will be included, unless they begin with // NOT_AN_ENTRY

# TODO: Perhaps this should be a python script instead? That would make the dev environment setup easier.

entries_dir="./entries"
json_file="$entries_dir/entries.json"
find "$entries_dir" -mindepth 2 -iname "*.typ" -print0 \
  | xargs -d '\0' grep -vl "^// NOT_AN_ENTRY" \
  | jq -R \
  | jq -s '[ .[] | split("/")[2:] | join("/")]' \
  > "$json_file"