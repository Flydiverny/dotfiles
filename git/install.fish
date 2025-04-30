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

# alias --save g='git'
# alias --save gl='git pull --prune'
# alias --save glg='git log --graph --decorate --oneline --abbrev-commit'
# alias --save glga='glg --all'
# alias --save gp='git push origin HEAD'
# alias --save gpa='git push origin --all'
# alias --save gd='git diff'
# alias --save gc='git commit -s'
# alias --save gca='git commit -sa'
# alias --save gco='git checkout'
# alias --save gb='git branch -v'
# alias --save ga='git add'
# alias --save gaa='git add -A'
# alias --save gcm='git commit -sm'
# alias --save gcam='git commit -sam'
# alias --save gs='git status -sb'
# alias --save glnext='git log --oneline (git describe --tags --abbrev=0 @^)..@'
# alias --save gw='git switch'
# alias --save gm='git switch (git main-branch)'
# alias --save gms='git switch (git main-branch); and git sync'
# alias --save egms='e; git switch (git main-branch); and git sync'
# alias --save gwc='git switch -c'

alias --save g='git'
alias --save gs='git status -sb'
alias --save gl='git log --graph --decorate --abbrev-commit --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
alias --save gr='git pull -r'
alias --save gp='git pull -r; and git push origin HEAD; and git link'
alias --save gdc='git diff --cached'
alias --save gd='git diff'
alias --save gc='git commit -sm'
#alias --save gb='git branch -v'
alias --save ga='git add'
alias --save gaa='git add -A; and git status -sb'
# alias --save glnext='git log --oneline $(git describe --tags --abbrev=0 @^)..@'

alias --save gdw='git diff --ignore-space-at-eol -b -w --ignore-blank-lines'
alias --save gdcw='git diff --ignore-space-at-eol -b -w --ignore-blank-lines --cached'

# alias --save gcb='git checkout (git branch | fzf -d 10)'
# alias --save gcf='git checkout -- $(_gdnfzf) && clear && gs'
# alias --save grf='git reset HEAD $(_gdnfzf --cached) && gs'

alias --save gsp='git stash; and git pull -r'
alias --save gspp='git stash; and git pull -r; and git stash pop'

alias --save gnb='git switch -c'

# alias --save gaf='git add $(_gdnfzf) && gs'
# alias --save gdf='git diff $(_gdnfzf)'
# alias --save gdfc='git diff --cached $(_gdnfzf --cached)'

alias --save stash='git stash'
alias --save master='git switch (git main-branch)'
alias --save main='git switch (git main-branch)'
alias --save rebase='git rebase -i origin/(git main-branch)'


alias --save gsm='git stash; and git checkout master'

alias --save gpu='git push -u origin HEAD'

alias --save gsu='git submodule update --init --recursive'
