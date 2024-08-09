#!/bin/bash

#HELP list repositories

# shellcheck disable=SC1091
. /srv/env
# shellcheck source=git-shell-commands-common.sh
. /srv/git-shell-commands-common.sh

for repo in $(find "$REPO_ROOT" -name "config" | sort)
do
    folder=$(dirname "$repo")
    repo_name=${folder#"$REPO_ROOT/"}
    safe_tput setaf 5; echo -en "$repo_name\t"; safe_tput sgr0
    echo "$(repo_uri $repo_name)"
done
