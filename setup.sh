#!/bin/bash

# Set the current path into SCRIPT_PATH
pushd `dirname $0` > /dev/null
SCRIPT_PATH=`pwd`
popd > /dev/null

# Create symbolic link for gitconfig.
ln -fs $SCRIPT_PATH/git/gitconfig ~/.gitconfig
