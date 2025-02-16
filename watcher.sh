#!/bin/zsh

# Find the root of the repository
ROOT_DIR=$(git rev-parse --show-toplevel)

# Use find to locate all .md files and pass them to entr to watch for changes
find "$ROOT_DIR" -name '*.md' | entr -c ./compile.sh
