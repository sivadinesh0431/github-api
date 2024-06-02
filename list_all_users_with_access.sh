#!/bin/sh

api_url="https://api.github.com"
Username=$username
Token=$token

Repo_owner=$1
Repo_name=$2

function github_api_get {
    local endpoint="$1"
    local url="${api_url}/${endpoint}"
    # Get request format for GitHub
    curl -s -u "${Username}:${Token}" "${url}"
}

function list_users_read_access {
    local endpoint="repos/${Repo_owner}/${Repo_name}/collaborators"
    collaborators=$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')

    if [[ -z "$collaborators" ]]; then
        echo "No users found for ${Repo_owner}/${Repo_name}"
    else
        echo "Users with read access:"
        echo "$collaborators"
    fi
}

# Main script
echo "Listing Users"
list_users_read_access

