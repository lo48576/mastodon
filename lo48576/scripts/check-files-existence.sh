#!/bin/sh

die() {
    if [ -z "${1:-}" ] ; then
        echo "Error happened." >&2
    else
        echo "ERROR: ${1}" >&2
    fi
    exit 1
}

cd "$(dirname "$0")"
cd ../../

FINAL_RETCODE=0

find . \( -type d -name '.git' -prune \) -o \( -type f -iname '*.sample' \) -print | sed -e 's/\.sample$//' | while read file ; do
    echo "Checking file: ${file}" >&2
    if [ \! -f "$file" ] ; then
        die "A file \`${file}\` is expected but it doesn't exist. See \`${file}.sample\` for detail."
    fi
    if cmp --silent "${file}.sample" "$file" ; then
        echo "WARNING: \`${file}\` is completely same as \`${file}.sample\`. Check the file content." >&2
        FINAL_RETCODE=1
    fi
done

echo 'All OK.'
exit "$FINAL_RETCODE"
