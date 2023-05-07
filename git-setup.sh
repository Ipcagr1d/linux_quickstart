#!/usr/bin/env bash

# Exit on any error
set -e

# Check if Git is installed
if ! [ -x "$(command -v git)" ]; then
  echo 'Error: Git is not installed.' >&2
  exit 1
fi

# Get user details
read -rp "Enter your name: " name
read -rp "Enter your email: " email

# Configure user details
if ! git config --global user.name "$name"; then
  echo 'Failed to set user name. Please check your input.' >&2
  exit 1
fi

if ! git config --global user.email "$email"; then
  echo 'Failed to set user email. Please check your input.' >&2
  exit 1
fi

# Personal git setup configuration
if ! git config --global init.defaultBranch main; then
  echo 'Failed to set default branch name. Please check your input.' >&2
  exit 1
fi

if ! git config --global color.ui auto; then
  echo 'Failed to set color.ui to auto. Please check your input.' >&2
  exit 1
fi

if ! git config --global pull.rebase false; then
  echo 'Failed to set pull.rebase to false. Please check your input.' >&2
  exit 1
fi

# Set up SSH keys
echo "Setting up SSH keys..."
if ! ssh-keygen -t ed25519 -a 100 -C "$email"; then
  echo 'Failed to generate SSH key. Please check your input.' >&2
  exit 1
fi

eval "$(ssh-agent -s)"
if ! ssh-add ~/.ssh/id_ed25519; then
  echo 'Failed to add SSH key to ssh-agent. Please check your input.' >&2
  exit 1
fi

echo "Git setup completed successfully! Use cat ~/.ssh/id_ed25519.pub to see SSH key."
