#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Add-on shared folder or name missing: $0 <shared-folder> <addon-name>"
    echo "- Example on Windows: $0 //192.168.178.74/addons megacmd"
    echo "  (assuming login to samba server with Explorer before)"
    echo "- Example on MacOS: $0 /Volumes/addons megacmd"
    echo "  (assuming that 'addons' was mounted with Finder before)"
    exit 1
fi

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "Script folder: $SCRIPT_DIR"

REMOTE_DIR="$1"
ADDON_NAME="$2"

LOCAL_DIR="$(SCRIPT_DIR)/$ADDON_NAME"
if [ ! -d "$LOCAL_DIR" ]; then
    echo "Local directory '$LOCAL_DIR' does not exist."
    exit 1
fi

if [ ! -d "$REMOTE_DIR" ]; then
    echo "Samba directory '$REMOTE_DIR' does not exist."
    exit 1
fi

echo "Local: $LOCAL_DIR"
echo "Remote: $REMOTE_DIR"

rm -rf $REMOTE_DIR/$ADDON_NAME
cp -r $LOCAL_DIR $REMOTE_DIR/
