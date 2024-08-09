#!/bin/bash

set -eu
#shellcheck source=common.sh
. /srv/common.sh

git_authkeys=/home/git/.ssh/authorized_keys
mkdir -p /home/git/.ssh
touch $git_authkeys
rm $git_authkeys


for ((i=0; i<$(cfg_count_user); i++)); do
    user=$(cfg_get_account_user "$i") || die "$user"

    mkdir -p /home/"$user"/.ssh
    echo "Loading keys for $user"
    safe_cd /home/"$user"
    cfg_get_account_keys "$i" > .ssh/authorized_keys
    chown -R "$user":"$user" .ssh
    chmod 700 .ssh
    chmod -R 600 .ssh/*

    while read key; do
      printf 'environment="GIT_USER=%s" %s\n' $user "$key" >>$git_authkeys
    done <.ssh/authorized_keys
done

