#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

echo "Starting to stow dotfiles..."
for dir in $DOTFILES_DIR/*; do
    if [ -d "$dir" ]; then
        package=$(basename $dir)
        stow -D -t $HOME $package # Unstow
        stow -R -t $HOME $package # Restow
        echo "source $HOME/.${package}rc" >> $HOME/.bashrc # Append source command
    fi
done

echo "All dotfiles have been stowed and sourced commands appended to .bashrc."
