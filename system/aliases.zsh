#!/bin/sh
# modern make
if which mmake >/dev/null 2>&2; then
	alias make='mmake'
fi

# exa is a better ls tool
if which exa >/dev/null 2>&1; then
	alias ls='exa'
	alias l='exa -la --git'
	alias la='exa -laa --git'
	alias ll='exa -l --git'
else
	if [ "$(uname -s)" = "Darwin" ]; then
		alias ls="ls -FG"
	else
		alias ls="ls -F --color"
	fi
	alias l="ls -lAh"
	alias la="ls -A"
	alias ll="ls -l"
fi

alias grep="grep --color=auto"
alias duf="du -sh * | sort -hr"
alias less="less -r"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# quick hack to make watch work with aliases
alias watch='watch '

# open, pbcopy and pbpaste on linux
if [ "$(uname -s)" != "Darwin" ]; then
	if [ -z "$(command -v pbcopy)" ]; then
		if [ -n "$(command -v xclip)" ]; then
			alias pbcopy="xclip -selection clipboard"
			alias pbpaste="xclip -selection clipboard -o"
		elif [ -n "$(command -v xsel)" ]; then
			alias pbcopy="xsel --clipboard --input"
			alias pbpaste="xsel --clipboard --output"
		fi
	fi
	if [ -e /usr/bin/xdg-open ]; then
		alias open="xdg-open"
	fi
fi

# fh - repeat history
fh() {
	print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
# alias hist='history | grep' # requires an argument
alias hist="fh"

alias psg='ps -Af | grep'
alias ping='ping -c 5'

# privileged access
if [ $UID -ne 0 ]; then
	alias scat='sudo cat'
    alias svim='sudo vim'
    alias snano='sudo nano'
    alias root='sudo su'
    alias reboot='sudo reboot'
fi
