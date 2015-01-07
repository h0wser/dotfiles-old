#!/bin/sh

# WARNING this script is kinda fucking dangerous
# It removes ~/.vim and ~/.config/awesome before running 
# So make sure those are backed up if they need to be
# Exit the script immediatly if a command fails
set -e

rm -f ~/.vim
rm -f ~/.config/awesome
rm -f ~/.config/bspwm
rm -f ~/.config/sxhkd
rm -f ~/.config/dunst
rm -f ~/.config/themer
rm -f ~/scripts
ln -fs ~/dotfiles/.vim ~/.vim
ln -fs ~/dotfiles/.dir_colors ~/.dir_colors
ln -fs ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -fs ~/dotfiles/.vimrc ~/.vimrc
ln -fs ~/dotfiles/.zshrc ~/.zshrc
ln -fs ~/dotfiles/awesome/ ~/.config/awesome
ln -fs ~/dotfiles/bspwm/ ~/.config/bspwm
ln -fs ~/dotfiles/sxhkd/ ~/.config/sxhkd
ln -fs ~/dotfiles/.Xresources ~/.Xresources
ln -fs ~/dotfiles/.compton.conf ~/.compton.conf
ln -fs ~/dotfiles/.xinitrc ~/.xinitrc
ln -fs ~/dotfiles/dunst ~/.config/dunst
ln -fs ~/dotfiles/themer ~/.config/themer
ln -fs ~/dotfiles/scripts ~/scripts
