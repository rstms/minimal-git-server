#!/bin/bash

#HELP [SOURCE TARGET] move (rename) SOURCE to TARGET repository

show_usage() {
    echo "Usage: mv SOURCE TARGET"
}

# shellcheck disable=SC1091
. /srv/env
# shellcheck source=git-shell-commands-common.sh
. /srv/git-shell-commands-common.sh

if [ $# -ne 2 ]
then
    show_usage
    exit 1
fi

SRC_FOLDER="${REPO_ROOT}/$1"
TGT_FOLDER="${REPO_ROOT}/$2"

if [ -d "$TGT_FOLDER" ]; then
    die "target exists: $2"
fi

if ! [ -d "$SRC_FOLDER" ]; then
    die "nonexistent source: $1"
fi

if ! is_git_repo "$SRC_FOLDER"; then
    warning "$SRC_FOLDER is not a git repository"
fi


# TODO: don't allow to move inside another existing repo

mkdir -p "$(dirname "$TGT_FOLDER")"
mv "$SRC_FOLDER" "$TGT_FOLDER"
