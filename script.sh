#!/bin/bash

read -p "Enter the server ip: " ip

read -p "Enter the server password: " pass

read -p "Enter the server user (Enter for default 'root'): " user

read -p "Enter the server name: (For example Germany1): " name

if [ -z "$user" ]; then
    user="root"
fi

echo "Host $name
  HostName $ip
  User $user" >> ~/.ssh/config

ssh-keygen -t rsa -C "easy ssh"

➜ ssh-copy-id -i ~/.ssh/id_ed25519.pub $name

echo "done!"
