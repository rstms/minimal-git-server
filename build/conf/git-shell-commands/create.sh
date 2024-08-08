#!/bin/bash

#HELP [REPO_NAME] create a git repo

show_usage() {
    echo "Usage: create REPO_NAME"
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

GIT_REPO="${REPO_ROOT}/$USER/$1"
if [ -d "$GIT_REPO" ]; then
    die "Already exists, skipped !"
fi
git init -q --bare "$GIT_REPO"

echo "You can now clone it :"
ok "git clone ssh://${USER}@${EXTERNAL_HOSTNAME}$(url_port $EXTERNAL_PORT)${GIT_REPO}"
