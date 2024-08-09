#!/bin/bash

#HELP [TARGET] remove TARGET directory/repo

show_usage() {
    echo "Usage: rmrepo TARGET"
}

# shellcheck disable=SC1091
. /srv/env
# shellcheck source=git-shell-commands-common.sh
. /srv/git-shell-commands-common.sh

if [ $# -ne 1 ]
then
    show_usage
    exit 1
fi

TARGET_DIR="${REPO_ROOT}/$1"

if ! [ -d "$TARGET_DIR" ]
then
    die "nonexistent: $1"
fi


read -p "Confirm IRRECOVERABLE DELETION of $1 (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then 
  rm -rf "$TARGET_DIR"
else
  warning "Cowardly refused."
fi
