set -x EDITOR nano
set -x VISUAL $EDITOR
set -x WEDITOR code

set -Ux DOTFILES ~/.dotfiles
set -Ux PROJECTS ~/Code

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
end

if test -f ~/.localrc.fish
    source ~/.localrc.fish
end
