#!/bin/bash

sudo -v

if test ! $(which brew)
then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Add an applications repo to the list.
brew tap homebrew/versions

brew update

brew upgrade --all

apps=(
  coreutils
  git
  git-extras
  homebrew/completions/brew-cask-completion
  hub
  mongodb
  openssl
  redis
  rvm
  ssh-copy-id
  v8
)

brew install "${apps[@]}"

brew cleanup
