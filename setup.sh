#!/bin/bash

# Set the dotfiles directory in order to run this script from anywhere.
pushd `dirname $0` > /dev/null
DOTFILES_DIR=`pwd`
popd > /dev/null
DOTFILES_BACKUP_DIR=~/dotfiles_old

declare -a FILES_TO_SYMLINK=(
  'atom'
  'git/gitconfig'
)

# Backup existing dotfiles into the DOTFILES_BACKUP_DIR directory.
echo "Backing up existing dotfiles from ~ to $DOTFILES_BACKUP_DIR"
mkdir -p $DOTFILES_BACKUP_DIR
for i in ${FILES_TO_SYMLINK[@]}; do
  mv -f ~/.${i##*/} $DOTFILES_BACKUP_DIR
done

main() {
  # Create symbolic links.
  for i in ${FILES_TO_SYMLINK[@]}; do
    source="$DOTFILES_DIR/$i"
    target="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

    ln -fs $source $target
  done
}

main
