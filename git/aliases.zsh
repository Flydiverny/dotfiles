#!/bin/sh
if command -v hub >/dev/null 2>&1; then
	alias git='hub'
fi

_gdnfzf() {
	file=$(
		git diff --name-only $* | fzf -d 10
	) || return
	rootDir=$(git rev-parse --show-toplevel)
	echo "$rootDir/$file"
}

alias gs='git status -sb'

alias gl="git log --graph --decorate --abbrev-commit --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gr="git pull -r"
alias gp="gr && git push && git link"
alias gdc="git diff --cached"
alias gd='git diff'
alias gc="git commit -m"
#alias gb='git branch -v'
alias gaa="git add -A && gs"
alias glnext='git log --oneline $(git describe --tags --abbrev=0 @^)..@'

alias gdw="git diff --ignore-space-at-eol -b -w --ignore-blank-lines"
alias gdcw="gdw --cached"

alias gcb='git checkout $(git branch | fzf -d 10)'
alias gcf='git checkout -- $(_gdnfzf) && clear && gs'
alias grf='git reset HEAD $(_gdnfzf --cached) && gs'

alias gsp="git stash && gr"
alias gspp="gsp && git stash pop"

alias gnb="git checkout -b"

alias gaf='git add $(_gdnfzf) && gs'
alias gdf='git diff $(_gdnfzf)'
alias gdfc='git diff --cached $(_gdnfzf --cached)'

alias stash="git stash"
alias master="git checkout master"

alias gsm="git stash && git checkout master"

gi() {
	curl -s "https://www.gitignore.io/api/$*"
}

_gitaddfun() {
	git add $*
}

alias ga="noglob _gitaddfun"
