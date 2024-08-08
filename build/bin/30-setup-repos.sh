#!/bin/bash

set -eu
#shellcheck source=common.sh
. /srv/common.sh

for ((i=0; i<$(cfg_count_user); i++)); do
    user=$(cfg_get_account_user "$i") || die "$user"

    echo "Setting up repos for $user"
    if [ ! -d /git/"$user" ]; then
        echo "Warning: missing repo folder, creating it"
        mkdir -p /git/"$user"
    fi

    chown -R "$user":"$user" /git/"$user"
done
