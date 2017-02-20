#!/bin/bash

brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

apps=(
    1password
    atom
    dropbox
    firefox
    google-chrome
    google-drive
    opera
    skype
    spotify
    wunderlist
)

brew cask install "${apps[@]}"
