#!/bin/bash

# Search files in INPUT_SOURCE for TODO/FIXME and mark as warnings.

INPUT_SOURCE=$1
OUTPUT=source_todos.txt
TAGS="TODO(:)?|FIXME(:)?"

# Scan source for TAGS and mark as warnings.
echo "searching ${INPUT_SOURCE} for ${TAGS}"
find "${INPUT_SOURCE}" \( -name "*.h" -or -name "*.m" -or -name "*.swift" \) -print0 \
| xargs -0 egrep --with-filename --line-number --only-matching "($TAGS).*\$" \
| perl -p -e "s/($TAGS)/ warning: \$1/"
