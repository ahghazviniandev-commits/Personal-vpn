#!/bin/bash

clear

echo "   ___         _    ___  ___ ____   "
echo "  / __|___ _ _| |_ / _ \/ __|__  |  "
echo " | (__/ -_) ' \  _| (_) \__ \ / /   "
echo "  \___\___|_||_\__|\___/|___//_/    "
echo " Backup Sender to Telegram"

# install dependencies (Ubuntu 22.04)
sudo apt update -y
sudo apt install -y zip curl cron

# ensure cron is running
sudo systemctl enable cron
sudo systemctl start cron


# Bot token
while [[ -z "$tk" ]]; do
    echo "Bot token:"
    read -r tk
    if [[ -z "$tk" ]]; then
        echo "Invalid input. Token cannot be empty."
    fi
done


# Chat id
while [[ -z "$chatid" ]]; do
    echo "Chat id:"
    read -r chatid
    if [[ -z "$chatid" ]]; then
        echo "Invalid input. Chat id cannot be empty."
    elif [[ ! $chatid =~ ^-?[0-9]+$ ]]; then
        echo "${chatid} is not a number."
        chatid=""
    fi
done


# Caption
echo "Caption (for example your domain):"
read -r caption
