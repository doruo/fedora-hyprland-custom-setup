#!/bin/bash
# https://github.com/doruo
# Some ideas and codes are taken from https://github.com/JaKooLit

# /--------------------/ VARIABLES /--------------------/

# Set some colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
INFO="$(tput setaf 4)[INFO]$(tput sgr0)"
WARN="$(tput setaf 1)[WARN]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
MAGENTA="$(tput setaf 5)"
ORANGE="$(tput setaf 214)"
WARNING="$(tput setaf 1)"
YELLOW="$(tput setaf 3)"
GREEN="$(tput setaf 2)"
BLUE="$(tput setaf 4)"
SKY_BLUE="$(tput setaf 6)"
RESET="$(tput sgr0)"

# Script attributes
DIALOG_BOX_HEIGHT=7
DIALOG_BOX_WIDTH=50
DELAY_BEFORE_REBOOT=5

# Path vars
RELATIVE_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
CUSTOM_CONF_PATH="$RELATIVE_PATH/dots"
CONF_PATH="$HOME/.config/hypr"

# Config
OS="Fedora"
PACKAGE_MANAGER="dnf"
YEAR="2025"
HOST="JaKooLit"

# Urls
HOST_REPO="https://github.com/$HOST/$OS-Hyprland"
HOST_REPO_AUTO_INSTALL="https://raw.githubusercontent.com/$HOST/$OS-Hyprland/main/auto-install.sh"

# /--------------------/ INIT /--------------------/

whiptail --title "Doruo custom $OS-Hyprland ($YEAR) Install Script" \
    --msgbox "Welcome to Doruo $OS-Hyprland ($YEAR) Install Script!\n\n\
Mostly taken from Jakoolit incredible setup: $HOST_REPO"\
    15 80

clear
cd $HOME

# Update operating system
echo "${INFO} Operating System: $OS"
echo "${INFO} Updating $PACKAGE_MANAGER packages..."
sudo $PACKAGE_MANAGER update

# Install utilities
UTILITIES="whiptail rsync"

echo "${INFO} Installing utilities requiered for setup..."
sudo $PACKAGE_MANAGER install $UTILITIES

# /--------------------/ HYPRLAND /--------------------/

# Create main directory
echo "${INFO} Creating $OS-Hyprland directory..."
mkdir $HOME/$OS-Hyprland

# Install
echo "${INFO} Installing $HOST $OS Hyprland..."
git clone --depth=1 $HOST_REPO.git $HOME/$OS-Hyprland
cd $HOME/$OS-Hyprland
chmod +x install.sh
./install.sh

# Ask if the user wants to proceed custom setup
if ! whiptail --title "Proceed with custom setup?" \
    --yesno "Would you like to proceed additionnal custom setup?" \
    $DIALOG_BOX_HEIGHT $DIALOG_BOX_WIDTH; then

    echo -e "\n"
    echo "${INFO} You chose ${YELLOW}NOT${RESET} to proceed. ${YELLOW}Exiting...${RESET}"
    echo -e "\n"
    exit 1
fi

# /--------------------/ CUSTOM SETUP INTERFACE /--------------------/

# Custom Hyprland config
CHOICE_CUSTOM_CONFIG=1
CHOICE_CUSTOM_ALIASES=1

# Dev & softwares
CHOICE_INSTALL_DEV_SOFT=1
CHOICE_INSTALL_DEV_LANG=1
CHOICE_INSTALL_DISCORD=1

CHOICE_REBOOT_AFTER_INSTALL=1

# Ask if the user wants to delete older config
if whiptail --title "Custom Hyprland config" \
    --yesno "Would you like to use custom Hyprland config ?" \
    $DIALOG_BOX_HEIGHT $DIALOG_BOX_WIDTH; then

    CHOICE_CUSTOM_CONFIG=0
fi       

if whiptail --title "Custom aliases" \
    --yesno "Would you like to use custom aliases ?" \
    $DIALOG_BOX_HEIGHT $DIALOG_BOX_WIDTH; then

    CHOICE_CUSTOM_ALIASES=0
fi        


# Dev softwares
if whiptail --title "Dev softwares" \
    --yesno "Would you like to install dev softwares ?" \
    $DIALOG_BOX_HEIGHT $DIALOG_BOX_WIDTH; then

    CHOICE_INSTALL_DEV_SOFT=0
fi  

# Dev langages
if whiptail --title "Dev langages" \
    --yesno "Would you like to install go, python ?" \
    $DIALOG_BOX_HEIGHT $DIALOG_BOX_WIDTH; then

    CHOICE_INSTALL_DEV_LANG=0
fi    

# Discord
if whiptail --title "Discord" \
    --yesno "Would you like to install discord ?" \
    $DIALOG_BOX_HEIGHT $DIALOG_BOX_WIDTH; then
    
    CHOICE_INSTALL_DISCORD=0
fi  

# Reboot
# Ask if the user wants to reboot
if whiptail --title "End of Hyprland setup" \
    --yesno "Would you like to reboot when finished ? (recommended)" \
    $DIALOG_BOX_HEIGHT $DIALOG_BOX_WIDTH; then

    CHOICE_REBOOT_AFTER_INSTALL=0
fi

# /--------------------/ CUSTOM SETUP PROCESS /--------------------/

# Custom Hyprland config

if [ $CHOICE_CUSTOM_CONFIG -eq 0 ]; then

    echo -e "\n"echo "${INFO} You chose to use custom Hyprland config."
    echo -e "\n"

    FOLDERS="rofi UserConfigs UserScripts waybar"

    for dir in $FOLDERS; do
        if [ -d "$dir" ]; then
            echo "Syncing config directory: $dir..."
            rsync -rf $CUSTOM_CONF_PATH/$dir $CONF_PATH/$dir
        fi
    done

    # Custom wallpapers in a different copy path
    cp -rf $CUSTOM_CONF_PATH/wallpapers $HOME/Pictures/wallpapers     

else
    echo -e "\n"
    echo "${INFO} You chose ${YELLOW}NOT${RESET} to use custom Hyprland config."
    echo -e "\n"
fi

# Custom aliases

if [ $CHOICE_CUSTOM_ALIASES -eq 0 ]; then

    echo -e "\n"echo "${INFO} You chose to use custom aliases."
    echo -e "\n"
    
    if [ -f .bashrc ]; then
        truncate -s 0 .bashrc
    fi
    cat $CUSTOM_CONF_PATH/aliases > .bashrc
    source .bashrc

else
    echo -e "\n"
    echo "${INFO} You chose ${YELLOW}NOT${RESET} to use custom aliases."
    echo -e "\n"
fi

# Dev softwares

if [ $CHOICE_INSTALL_DEV_SOFT -eq 0 ]; then
    echo -e "\n"
    echo "${INFO} You chose to install softwares. ${YELLOW}Installing...${RESET}"

    SOFTWARES="git code pgadmin4"

    for software in $SOFTWARES; do
        echo "Installing software: $software..."
        sudo $PACKAGE_MANAGER install $software
    done
else
    echo -e "\n"
    echo "${INFO} You chose ${YELLOW}NOT${RESET} to install softwares."
    echo -e "\n"
fii

# Dev langages

if [ $CHOICE_INSTALL_DEV_LANG -eq 0 ]; then
    echo -e "\n"
    echo "${INFO} You chose to install dev langages (go, python). ${YELLOW}Installing...${RESET}"

    DEV_LANGS="go java python3 php"

    for langage in $DEV_LANGS; do
        echo "Installing programming langage: $langage..."
        sudo $PACKAGE_MANAGER install $langage
    done
else
    echo -e "\n"
    echo "${INFO} You chose ${YELLOW}NOT${RESET} to install dev langages (go, python)."
    echo -e "\n"
fi

# Discord

if [ $CHOICE_INSTALL_DISCORD -eq 0 ]; then
    echo -e "\n"
    echo "${INFO} You chose to install Discord. ${YELLOW}Installing...${RESET}"
    sudo $PACKAGE_MANAGER install discord 
else
    echo -e "\n"
    echo "${INFO} You chose ${YELLOW}NOT${RESET} to install Discord."
    echo -e "\n"
fi

# Reboot

if [ $CHOICE_REBOOT_AFTER_INSTALL -eq 0 ]; then
    echo -e "\n"
    echo "${INFO} You chose to reboot when finished."
    echo -e "\n"
    echo -e "${INFO} ${YELLOW}Rebooting $OS, starting in $DELAY_BEFORE_REBOOT seconds...${RESET}"
    sleep $DELAY_BEFORE_REBOOT
    reboot
else
    echo -e "\n"
    echo "${INFO} You chose ${YELLOW}NOT${RESET} to reboot when finished."
    echo -e "\n"
fi

echo -e "\n ${OK} ${GREEN}End of custom install for $OS-Hyprland.${RESET}"
