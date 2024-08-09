#!/bin/bash

set -eu
#shellcheck source=common.sh
. /srv/common.sh

create_user() {
    current_uid=$(id -u "$user" 2>/dev/null || echo "0")
    if [[ "$current_uid" == "0" ]]; then
        echo "Creating $user with uid=$uid (current uid=$current_uid)"
        adduser -D -s "$shell" -u "$uid" "$user"
    # sshd does not allow to login if no password is set
    random_pwd=$(cat /proc/sys/kernel/random/uuid)
    echo "$user":"$random_pwd" | chpasswd
    if [ -e /home/$user/git-shell-commands ]; then
      rm -rf /home/$user/git-shell-commands
    fi
    cp -R /srv/conf/git-shell-commands /home/"$user"/git-shell-commands
    chmod -R 755 /home/"$user"/git-shell-commands
    elif [[ "$current_uid" != "$uid" ]]; then
        die "Fatal, cannot change UID (from $current_uid to $uid). Please re-create container.";
    else
        continue
    fi

}

# note: this will break if 10K users are configured
uid=9999
user=git
shell=/usr/bin/init-git-shell-session
#shell=/usr/bin/git-shell
#shell=/bin/bash
create_user 

rm /home/git/git-shell-commands/*
nologin=/home/git/git-shell-commands/no-interactive-login
cat >$nologin - <<"EOF"
#!/bin/bash
echo "User $(whoami) Authorized successfully.  Interactive shell prohibited."
ls -al
EOF
chmod -R 755 $nologin

for ((i=0; i<$(cfg_count_user); i++)); do

    user=$(cfg_get_account_user "$i") || die "$user"
    uid=$(cfg_get_account_uid "$i") || die "$uid"
    shell=/usr/bin/git-shell
    create_user 
    #addgroup $user git
    #if [ -e /home/git/$user ]; then
    #  rm /home/git/$user
    #fi
    #ln -s /home/$user /home/git/$user
done
