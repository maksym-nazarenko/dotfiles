#!/bin/bash

set -e -o pipefail


# fancy colours
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

log_error() {
    echo -e "${RED}${1}${NC}"
}

log_fatal() {
    log_error "$1"
    exit 1
}

log_success() {
    echo -e "${GREEN}${1}${NC}"
}

log_info() {
    echo -e "${1}"
}


git=git
current_branch="$($git branch --show-current)"
branches_remote_prune=$($git remote prune -n origin | sed -n -e 's|^.*origin/\(.*\)$|\1|p' | sort)
branches_local=$($git branch -l --no-column --color=never --format='%(refname:short)' | grep -v -E "^(main|master|$current_branch)\$" | sort)

branches_to_prune=$(comm -12  <(echo "$branches_remote_prune") <(echo "$branches_local"))

if [ -z "$branches_to_prune" ]; then
    log_info "No branches to prune"
    exit 0
fi

log_info "Local branches to prune:"
log_info "$branches_to_prune"

echo -n "Prune these branches?[yes/no]: "
read answer
if [ "$answer" = "yes" ]; then
    log_info "Pruning local and origin orphaned branches"
    $git remote prune origin
    $git branch -D $(echo $branches_to_prune)
fi

exit 0
