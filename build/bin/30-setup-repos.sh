#!/bin/bash

set -eu
#shellcheck source=common.sh
. /srv/common.sh

for ((i=0; i<$(cfg_count_user); i++)); do
    user=$(cfg_get_account_user "$i") || die "$user"
    echo "Scanning repos for $user"
    REPO_ROOT=/home/$user
    for repo in $(find "$REPO_ROOT" -name "config" | sort); do
      repo_dir=$(dirname "$repo")
      repo_name=${repo_dir#"$REPO_ROOT/"}
      echo "  $(du -sh $repo_dir)"
      chown -R $user:$user $repo_dir
    done
    if [ ! -L /home/$user/$user ]; then
        ln -s /home/$user /home/$user/$user
    fi
done
