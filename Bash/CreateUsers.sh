#!/bin/bash

# Function takes a parameter with the username and returns 0 if the requested user is the same as the current user.
# Otherwise, it returns 1.
function checkUsers {
    CHECKUSER=${1}
    [ ${CHECKUSER} == ${USER} ] && return 0
    return 1 
}

# Function takes a parameter with the username and returns 0 if the user does not exist.
# Otherwise, it returns 1.
function checkUserExist {
    EXISTUSER=${1}
    cat /etc/passwd | grep -w ${EXISTUSER} > /dev/null 2>&1
    [ ${?} -ne 0 ] && return 0
    return 1
}

# Function takes a parameter with the group name and returns 0 if the group does not exist.
# Otherwise, it returns 1.
function checkGroupExist {
    CHECKGROUP=${1}
    cat /etc/group | grep -w ${CHECKGROUP} > /dev/null 2>&1
    [ ${?} -ne 0 ] && return 0
    return 1
}

############# Create users named "Devo", "Testo", and "Prodo" on VM3 #############
## Exit codes:
#    0: Success
#    1: Script is executed without sufficient privileges
#    2: One or more users already exist
#    3: Group already exists

# Check if the script is executed with root privileges
checkUsers "root"
if [ $? -ne 0 ]; then
  echo "Script must be executed with sudo privileges"
  exit 1
fi

# Define the list of users to be created
users=("Devo" "Testo" "Prodo")

# Initialize array to track all users (existing or newly created)
all_users=()

# Check and create users if they do not exist
for user in "${users[@]}"; do
  checkUserExist "$user"
  if [ $? -eq 1 ]; then
    echo "User '$user' already exists"
  else
    useradd "$user"
    echo "User '$user' created"
  fi
  all_users+=("$user")  # Add all users (existing or new) to array
done

# Check and create the group "deployG" if it does not exist
checkGroupExist "deployG"
if [ $? -eq 1 ]; then
  echo "Group 'deployG' already exists"
else
  groupadd deployG
  echo "Group 'deployG' created"
fi

# Add all users to the group if they are not already members
for user in "${all_users[@]}"; do
  if groups "$user" | grep -q "\bdeployG\b"; then
    echo "User '$user' is already a member of group 'deployG'"
  else
    usermod -aG deployG "$user"
    echo "User '$user' added to group 'deployG'"
  fi
done

echo "Users '${all_users[@]}' have been processed and added to group 'deployG' where necessary."
exit 0
