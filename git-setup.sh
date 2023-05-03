#!/bin/bash

# Check if Git is installed
if ! [ -x "$(command -v git)" ]; then
  echo 'Error: Git is not installed.' >&2
  exit 1
fi

# Get user details
read -p "Enter your name: " name
read -p "Enter your email: " email

# Configure user details
git config --global user.name "$name"
git config --global user.email "$email"

# Set up SSH keys
echo "Setting up SSH keys..."
ssh-keygen -t ed25519 -a 100 -C "$email"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo "Git setup completed successfully! Use cat ~/.ssh/id_ed25519 to see SSH key"
