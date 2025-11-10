#!/usr/bin/env fish

# Don't ask ssh password all the time
switch (uname)
    case Darwin
        git config --global credential.helper osxkeychain
    case '*'
        git config --global credential.helper cache
end

# better diffs
if command -qs delta
    git config --global core.pager delta
    git config --global interactive.diffFilter 'delta --color-only'
    git config --global delta.syntax-theme Nord
    git config --global delta.line-numbers true
    git config --global delta.decorations true
end

# use vscode as mergetool
if command -qs code
    git config --global merge.tool vscode
    and git config --global mergetool.vscode.cmd 'code --wait $MERGED'
end

if command -qs gh
    alias --save 'grv'='gh repo view -w'
    alias --save 'gpv'='gh pr view -w'
end

alias --save g='git'
alias --save gs='git status -sb'
alias --save gl='git log --graph --decorate --abbrev-commit --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
alias --save gr='git pull -r'
alias --save gp='git pull -r; and git push origin HEAD; and git link'
alias --save gdc='git diff --cached'
alias --save gd='git diff'
alias --save gc='git commit -sm'
alias --save ga='git add'
alias --save gaa='git add -A; and git status -sb'

alias --save gdw='git diff --ignore-space-at-eol -b -w --ignore-blank-lines'
alias --save gdcw='git diff --ignore-space-at-eol -b -w --ignore-blank-lines --cached'

alias --save gsp='git stash; and git pull -r'
alias --save gspp='git stash; and git pull -r; and git stash pop'

alias --save gnb='git switch -c'

alias --save stash='git stash'
alias --save master='git switch (git main-branch)'
alias --save main='git switch (git main-branch)'
alias --save rebase='git rebase -i origin/(git main-branch)'

alias --save gsm='git stash; and git checkout master'

alias --save gpu='git push -u origin HEAD'

alias --save gsu='git submodule update --init --recursive'
