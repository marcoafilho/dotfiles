#!/bin/bash

################################################################################
# Helper functions                                                             #
################################################################################

answer_is_yes() {
  [[ "$REPLY" =~ ^[Yy]$ ]] \
    && return 0 \
    || return 1
}

ask() {
  print_question "$1"
  read
}

ask_for_confirmation() {
  print_question "$1 [y/n] "
  read
}

print_question() {
  # Print output in yellow
  printf "\e[0;33m $1 \e[0m"
}

################################################################################
# Dotfiles management functions                                                #
################################################################################

# Backup existing dotfiles into the DOTFILES_BACKUP_DIR directory.
backup_dotfiles() {
  echo "Backing up existing dotfiles from ~ to $DOTFILES_BACKUP_DIR"
  mkdir -p $DOTFILES_BACKUP_DIR
  for i in ${FILES_TO_SYMLINK[@]}; do
    mv -f ~/.${i##*/} $DOTFILES_BACKUP_DIR
  done
}

# Create symbolic links.
create_dotfiles_symlinks() {
  backup_dotfiles
  for i in ${FILES_TO_SYMLINK[@]}; do
    source="$DOTFILES_DIR/$i"
    target="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

    ln -fs $source $target
  done
}

################################################################################
# Atom package management                                                      #
################################################################################

list_atom_packages() {
  apm list --installed --bare
}

install_atom_packages() {
  apm install --packages-file $DOTFILES_DIR/.atom/packages.list
}

################################################################################
# Main script                                                                  #
################################################################################

# Set the dotfiles directory in order to run this script from anywhere.
pushd `dirname $0` > /dev/null
DOTFILES_DIR=`pwd`
popd > /dev/null
DOTFILES_BACKUP_DIR=~/dotfiles_old

declare -a FILES_TO_SYMLINK=(
  'atom'
  'git/gitconfig'
)

main() {
  ask_for_confirmation "Backup and override existing dotfiles?"
  if answer_is_yes; then
    create_dotfiles_symlinks
  fi

  ask_for_confirmation "Install brew?"
  if answer_is_yes; then
    . install/brew.sh
  fi

  ask_for_confirmation "Install brew cask and its applications"
  if answer_is_yes; then
    . install/brew-cask.sh
  fi

  ask_for_confirmation "Install atom packages?"
  if answer_is_yes; then
    install_atom_packages
  fi
}

main
