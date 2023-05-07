#!/usr/bin/env bash

# Exit on any error
set -e

# Check if Zsh is installed
if ! [ -x "$(command -v zsh)" ]; then
  echo 'Zsh is not installed. Installing now...' >&2
  if [[ "$(uname -s)" == "Linux" ]]; then
    if [ -x "$(command -v apt-get)" ]; then
      sudo apt-get update
      sudo apt-get install -y zsh
    else
      echo 'Unsupported package manager. Please install Zsh manually.' >&2
      exit 1
    fi
  else
    echo 'Unsupported OS. Please install Zsh manually.' >&2
    exit 1
  fi
fi

# Check if Oh My Zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo 'Oh My Zsh is not installed. Installing now...' >&2
  if ! sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" >/dev/null 2>&1; then
    echo 'Failed to install Oh My Zsh. Please install it manually.' >&2
    exit 1
  fi
fi

# Check if zsh-autosuggestions plugin is installed
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
  echo 'zsh-autosuggestions plugin is not installed. Installing now...' >&2
  if ! git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions >/dev/null 2>&1; then
    echo 'Failed to install zsh-autosuggestions. Please install it manually.' >&2
    exit 1
  fi
fi

# Set Zsh as default shell
if [[ $SHELL != *"zsh"* ]]; then
  echo 'Setting Zsh as default shell...' >&2
  if ! chsh -s $(which zsh) >/dev/null 2>&1; then
    echo 'Failed to set Zsh as default shell. Please set it manually.' >&2
    exit 1
  fi
fi

echo 'Zsh installation and configuration completed successfully!'
