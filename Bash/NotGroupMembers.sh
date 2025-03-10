#!/bin/bash

# Function to check if script is executed with root privileges
function checkUsers  {
    CHECKUSER=${1}
    [ ${CHECKUSER} == ${USER} ] && return 0
    return 1
}

# Function to check if group exists
function checkGroupExist  {
    EXISTUSER=${1}
    grep -q "^${EXISTUSER}:" /etc/group
    return $?
}

############# Fetch a list of users from the "deployG" group #############
## Exit codes:
#   0: Success
#   1: Script is executed with a user has no privileges
#   2: Group does not exist

# Check if script is executed with root privileges
checkUsers "root"
if [ $? -ne 0 ]; then
    echo "Script must be executed with sudo privilege"
    exit 1
fi

# Check if the group "deployG" exists
checkGroupExist "deployG"
if [ $? -ne 0 ]; then
    echo "Group 'deployG' does not exist"
    exit 2
fi

# Get the list of group members
GROUP_MEMBERS=$(groupmems -l -g deployG)

# Get the list of all users with UID >= 1000
ALL_USERS=$(awk -F: '$3 >= 1000 { print $1 }' /etc/passwd)

# Filter out users who are not in GROUP_MEMBERS
for user in $ALL_USERS; do
    if ! echo "$GROUP_MEMBERS" | grep -qw "$user"; then
        echo "$user"
    fi
done

exit 0