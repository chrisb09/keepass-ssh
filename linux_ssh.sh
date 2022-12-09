#!/bin/bash
function install_package() {
packagesNeeded=$1
  if [ -x "$(command -v apk)" ];       then sudo apk add --no-cache $packagesNeeded
  elif [ -x "$(command -v apt)" ];     then sudo apt install $packagesNeeded
  elif [ -x "$(command -v apt-get)" ]; then sudo apt-get install $packagesNeeded
  elif [ -x "$(command -v dnf)" ];     then sudo dnf install $packagesNeeded
  elif [ -x "$(command -v zypper)" ];  then sudo zypper install $packagesNeeded
  else echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: $packagesNeeded">&2;
       exit 1;
  fi
}
function check_command() {
comm=$1
pkg=$2
echo $pkg
  if ! [ -x "$(command -v $comm)" ]; then
    echo "Error: $pkg is not installed." >&2
    read -p "Do you want to install it? (yes/no) " yn
    case $yn in
    yes ) echo ok, we will proceed;;
    no ) echo exiting...;
      exit;;
    * ) echo invalid response;
      exit 1;;
    esac
    install_package $pkg
  else
    echo $pkg is installed.
  fi
}
check_command keepassxc keepassxc
check_command xdotool xdotool
agents=$(ssh-add -l)
if [ "$agents" == "The agent has no identities." ]; then
    echo "No key found."
    keepassxc
    while [ "$agents" == "The agent has no identities." ];
    do
      sleep 1
      agents=$(ssh-add -l)
    done
    echo "KeePass instance unlocked and agent found."
    xdotool search --onlyvisible -classname KeePassXC windowminimize
else
    echo "Found one or more keys."
fi
echo "Clear output..."
clear
echo "Execute '$@'"
$@
