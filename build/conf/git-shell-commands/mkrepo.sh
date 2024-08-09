#!/bin/bash

#HELP [REPO_NAME] make a new repository

show_usage() {
    echo "Usage: mkrepo REPO_NAME"
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

# validate repo name 
# must start with alpha
# must contain only alphanumeric,dash,underscore
# cannot be git-shell-commands!

bad_repo="invalid name"
case "$1" in 
    ''|.ssh|git-shell-commands) die "$bad_repo";;
    $USER) die "$bad_repo";;
    [a-zA-Z][-a-zA-Z0-9_]*);;
    *) die "$bad_repo";;
esac

GIT_REPO="${REPO_ROOT}/$1"
if [ -d "$GIT_REPO" ]; then
    die "repo exists"
fi
git init -q --bare "$GIT_REPO"

ok "git clone $(repo_uri $1)"
