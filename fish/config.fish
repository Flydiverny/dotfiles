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

end

if test -f ~/.localrc.fish
    source ~/.localrc.fish
end
