#!/bin/bash

#HELP [REPO_NAME] output URL if repo exists or exit with error

show_usage() {
    echo "Usage: st REPO_NAME"
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

GIT_REPO="${REPO_ROOT}/$1"

if ! is_git_repo "$GIT_REPO"; then
    die "nonexistent: $1"
else
    ok "$(repo_uri $1)"
    exit 0
fi
