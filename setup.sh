#!/bin/sh

# Exit the script immediatly if a command fails
set -e

ln -s ~/dotfiles/.vim/ ~/.vim
ln -s ~/dotfiles/.dir_colors ~/.dir_colors
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.zshrc ~/.zshrc
