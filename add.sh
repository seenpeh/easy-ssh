#!/bin/bash

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

echo "done!"
