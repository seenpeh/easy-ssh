#!/bin/bash

# Function to add a new host to ~/.ssh/config
add_host() {
    read -p "Enter the server ip: " ip

    read -p "Enter the server user (Enter for default 'root'): " user

    if [ -z "$user" ]; then
      user="root"
    fi

    read -p "Enter the server name: (For example Germany1): " name

    echo "Host $name
      HostName $ip
      User $user" >> ~/.ssh/config

    rsa_file="$HOME/.ssh/id_ed25519"

    if [ ! -f "$rsa_file" ]; then
    ssh-keygen -t ed25519  
    fi

    ssh-copy-id -i ~/.ssh/id_ed25519.pub $name

    echo "Server name: $name user/ip: $user@$ip" >> ~/.ssh/hosts
    echo "Added host $name with IP $ip"
}

# Function to remove a host from ~/.ssh/config
remove_host() {
    cat ~/.ssh/hosts
    read -p "Enter the server name to remove: " name
    sed -i "/Host $name/,/^$/d" ~/.ssh/config
    sed -i "/Host $name/,/^$/d" ~/.ssh/hosts
    echo "Removed host $name"
}

# Main menu
while true; do
    echo "Select an option:"
    echo "1. Add new host"
    echo "2. Remove host"
    echo "3. Exit"
    read -p "Enter your choice: " choice
    case $choice in
        1) add_host ;;
        2) remove_host ;;
        3) exit ;;
        *) echo "Invalid option";;
    esac
done
