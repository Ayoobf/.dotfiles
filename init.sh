#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

BACKUP_DIR="$HOME/dotfile_backups/$(date +%Y%m%d_%H%M%S)"

stow_package() {
	local package=$1
	stow -t $HOME -D $package # Unstow
	stow -t $HOME -R $package # Restow
}

# Make sure the backup directory exists
mkdir -p $BACKUP_DIR

echo "Starting to stow dotfiles..."

# Iterate over each directory in the dotfiles folder
for dir in $DOTFILES_DIR/*; do
    if [ -d "$dir" ]; then
        package=$(basename $dir)

        # Check for existing files and back them up
        stow -n -t $HOME -v $package 2>&1 | grep "\* existing target is" | awk '{print $NF}' | while read -r file; do
            echo "Backing up existing file $file..."
            mkdir -p "$BACKUP_DIR/$(dirname $file)"
            mv "$HOME/$file" "$BACKUP_DIR/$file"
        done

        # Stow the package
        echo "Stowing $package..."
        stow_package $package
    fi
done

echo "All dotfiles have been stowed."
