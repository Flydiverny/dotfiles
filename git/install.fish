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

# abbr -a gl 'git pull --prune'
# abbr -a glg 'git log --graph --decorate --oneline --abbrev-commit'
# abbr -a glga 'glg --all"
# abbr -a gp 'git push origin HEAD'
# abbr -a gpa 'git push origin --all'
# abbr -a gd 'git diff'
# abbr -a gc 'git commit -s'
# abbr -a gca 'git commit -sa'
# abbr -a gco 'git checkout'
# abbr -a gb 'git branch -v'
# abbr -a ga 'git add'
# abbr -a gaa 'git add -A'
# abbr -a gcm 'git commit -sm'
# abbr -a gcam 'git commit -sam'
# abbr -a gs 'git status -sb'
# abbr -a glnext 'git log --oneline (git describe --tags --abbrev=0 @^)..@'
# abbr -a gw 'git switch'
# abbr -a gm 'git switch (git main-branch)'
# abbr -a gms 'git switch (git main-branch); git sync'
# abbr -a gwc 'git switch -c'

abbr -a gs 'git status -sb'
abbr -a gl 'git log --graph --decorate --abbrev-commit --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
abbr -a gr 'git pull -r'
abbr -a gp 'git pull -r; and git push origin HEAD; and git link'
abbr -a gdc 'git diff --cached'
abbr -a gd 'git diff'
abbr -a gc 'git commit -sm'
#abbr -a gb 'git branch -v'
abbr -a ga 'git add'
abbr -a gaa 'git add -A; and git status -sb'
# abbr -a glnext 'git log --oneline $(git describe --tags --abbrev=0 @^)..@'

abbr -a gdw 'git diff --ignore-space-at-eol -b -w --ignore-blank-lines'
abbr -a gdcw 'git diff --ignore-space-at-eol -b -w --ignore-blank-lines --cached'

# abbr -a gcb 'git checkout (git branch | fzf -d 10)'
# abbr -a gcf 'git checkout -- $(_gdnfzf) && clear && gs'
# abbr -a grf 'git reset HEAD $(_gdnfzf --cached) && gs'

abbr -a gsp 'git stash; and git pull -r'
abbr -a gspp 'git stash; and git pull -r; and git stash pop'

abbr -a gnb 'git switch -c'

# abbr -a gaf 'git add $(_gdnfzf) && gs'
# abbr -a gdf 'git diff $(_gdnfzf)'
# abbr -a gdfc 'git diff --cached $(_gdnfzf --cached)'

abbr -a stash 'git stash'
abbr -a master 'git switch (git main-branch)'
abbr -a main 'git switch (git main-branch)'

abbr -a gsm 'git stash; and git checkout master'

abbr -a gpu 'git push -u origin HEAD'
