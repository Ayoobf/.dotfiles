#!/bin/bash
<<<<<<< HEAD

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
=======
# Helper Script
DOTFILES_DIR="$HOME/dotfiles"

BACKUP_DIR="$HOME/dotfile_backups/$(date +%Y%m%d_%H%M%S)"
INIT_FLE="$HOME/.zshrc"I
stow_package() {
	local package=$1
	stow -t $HOME -D $package # Unstow
	stow -t $HOME -R $package # Restow
}

# Functionto append sourcing to bashrc
append_sourcing() {
    local file=$1
    echo "if [ -f $file ]; then . $file; fi" >> $INIT_FILE
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

        main_file="$HOME/.$package"  # Assuming main config files are named after the package
        if [ -f "$main_file" ]; then
            echo "Appending sourcing for $main_file..."
            append_sourcing "$main_file"
        fi
    fi
done

echo "All dotfiles have been stowed."
>>>>>>> parent of 797e845 (before stow.sh refactor)
