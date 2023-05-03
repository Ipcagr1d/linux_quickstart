#!/bin/bash

# Install Fish shell
sudo apt-get update
sudo apt-get install -y fish

# Set Fish as default shell
sudo chsh -s /usr/bin/fish $USER

# Install oh-my-fish
curl -L https://get.oh-my.fish | fish

# Install Tide theme
omf install tide

# Set Tide as default theme
fish -c "omf theme tide"

# Create a dynamic Fish prompt that displays the current Git branch
cat << EOF >> ~/.config/fish/functions/fish_prompt.fish
function fish_prompt
    set_color normal
    echo -n (whoami)'@'(hostname)':'
    set_color -o normal
    echo -n (pwd | fish_git_prompt)
    set_color normal
    echo -n '> '
    set_color -o normal
end
EOF

# Reload Fish configuration
fish -c "source ~/.config/fish/config.fish"
