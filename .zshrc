# /etc/profile

#Set our umask
umask 022

# Set our default path
PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/home/h0wser/.local/bin"
export PATH

# Load profiles from /etc/profile.d
if test -d /etc/profile.d/; then
	for profile in /etc/profile.d/*.sh; do
		test -r "$profile" && . "$profile"
	done
	unset profile
fi

# Source global bash config
if test "$PS1" && test "$BASH" && test -r /etc/bash.bashrc; then
	. /etc/bash.bashrc
fi

autoload -U colors && colors

autoload -U promptinit
promptinit
# Set prompt
PROMPT="%{$fg[red]%}%n@%M %{$reset_color%}- %{$fg[red]%}[%3~]%{$reset_color%} > "
RPROMPT="[%?] %*"

# Termcap is outdated, old, and crusty, kill it.
unset TERMCAP

# Man is much better than us at figuring this out
unset MANPATH

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

alias ls='ls -F --format=single-column --color=always --group-directories-first'
eval `dircolors -b ~/.dir_colors`

alias fucking='sudo'
alias please='sudo $(history -p !!)'
alias sudo='sudo '

alias r='vim ~/.zshrc && source ~/.zshrc'

alias py2='python2'
alias py3='python'

alias :q='exit'
alias c='clear'

alias pac='yaourt'

alias music='ncmpcpp'

alias runescape='java -jar ~/Orion/OSBuddy.jar > /dev/null 2>&1 &'

alias tmux="tmux -2" # forces 256 colors in tmux :) 

# Use good compilers
export CC=clang
export CXX=clang++

# Editor
export EDITOR=vim

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/h0wser/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
