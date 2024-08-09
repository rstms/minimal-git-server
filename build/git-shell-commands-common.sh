#!/bin/bash

safe_tput()
{
    if [[ -t 1 ]]; then
        tput "$@"
    fi
}

is_git_repo()
{
    local repo="$1"
    if [ ! -d "$repo" ]; then
        return 1
    else
        if [ -f "$repo/config" ]; then
            return 0
        else
            return 1
        fi
    fi
}

uri_port() {
    if [ "$1" = "22" ]; then
        echo ""
    else
        echo ":$1"
    fi
}

repo_uri() {
  #echo "ssh://${USER}@${EXTERNAL_HOSTNAME}$(uri_port $EXTERNAL_PORT):$1"
  echo "git@${EXTERNAL_HOSTNAME}$(uri_port $EXTERNAL_PORT):${USER}/$1"
}


warning()
{
    safe_tput setaf 3; echo "$*"; safe_tput sgr0
}

ok()
{
    safe_tput setaf 2; echo "$*"; safe_tput sgr0
}

die()
{
    safe_tput setaf 1; echo Failed: "$*"; safe_tput sgr0
    exit 1
}
