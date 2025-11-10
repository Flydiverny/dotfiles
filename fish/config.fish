set -x EDITOR nano
set -x VISUAL $EDITOR
set -x WEDITOR code

set -Ux DOTFILES ~/.dotfiles
set -Ux PROJECTS ~/Code
set -x GOPATH $PROJECTS/Go

fish_add_path -a $GOPATH/bin /usr/local/go/bin || true
fish_add_path -a $DOTFILES/bin $HOME/.bin

status is-interactive; and begin
    source "/home/flydiverny/.config/ee/shell/ee.fish"

    # pnpm
    set -gx PNPM_HOME "/home/flydiverny/.local/share/pnpm"
    if not string match -q -- $PNPM_HOME $PATH
        set -gx PATH "$PNPM_HOME" $PATH
    end
    # pnpm end

    # homebrew
    if test -d (brew --prefix)"/share/fish/completions"
        set -p fish_complete_path (brew --prefix)/share/fish/completions
    end

    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end
    # homebrew end

    # Disable fish greeting
    set fish_greeting


    # Aliases

    abbr --add less less -r

    abbr --add nr npm-run
    abbr --add yr yarn-run

    if command -qs eza
        abbr --add ls eza
        abbr --add l eza -lh --icons
        abbr --add la eza -lah --icons
        abbr --add ll eza -l --icons
        abbr --add lt eza -l --icons --tree --level=2
    else
        abbr --add l ls -lAh
        abbr --add la ls -A
        abbr --add ll ls -l
    end

    # Git


    if command -qs gh
        abbr --add grv 'gh repo view -w'
        abbr --add gpv 'gh pr view -w'
    end

    # abbr --add g 'git'
    abbr --add gs 'git status -sb'
    abbr --add gl 'git log --graph --decorate --abbrev-commit --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
    abbr --add gr 'git pull -r'
    abbr --add gp 'git pull -r; and git push origin HEAD; and git link'
    abbr --add gdc 'git diff --cached'
    abbr --add gd 'git diff'
    abbr --add gc 'git commit -sm'
    abbr --add ga 'git add'
    abbr --add gaa 'git add -A; and git status -sb'

    abbr --add gdw 'git diff --ignore-space-at-eol -b -w --ignore-blank-lines'
    abbr --add gdcw 'git diff --ignore-space-at-eol -b -w --ignore-blank-lines --cached'

    abbr --add gsp 'git stash; and git pull -r'
    abbr --add gspp 'git stash; and git pull -r; and git stash pop'

    abbr --add gnb 'git switch -c'

    abbr --add stash 'git stash'
    abbr --add master 'git switch (git main-branch)'
    abbr --add main 'git switch (git main-branch)'
    abbr --add rebase 'git rebase -i origin/(git main-branch)'

    abbr --add gsm 'git stash; and git checkout master'

    abbr --add gpu 'git push -u origin HEAD'

    abbr --add gsu 'git submodule update --init --recursive'


end

if test -f ~/.localrc.fish
    source ~/.localrc.fish
end
