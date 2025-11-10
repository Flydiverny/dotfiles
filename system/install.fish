#!/usr/bin/env fish
alias --save less='less -r'

alias --save nr=npm-run
alias --save yr=yarn-run

if command -qs eza
    alias --save ls='eza'
    alias --save l='eza -lh --icons'
    alias --save la='eza -lah --icons'
    alias --save ll='eza -l --icons'
    alias --save lt='eza -l --icons --tree --level=2'
else
    alias --save l='ls -lAh'
    alias --save la='ls -A'
    alias --save ll='ls -l'
end

if command -qs fdfind
    ln -sf (which fdfind) ~/.bin/fd
end

# if command -qs fd
# 	alias --save find='fd'
# end

if command -qs batcat
    ln -sf (which batcat) ~/.bin/bat
end
if command -qa bat
    alias --save cat=bat
    set -Ux MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

if command -qs zoxide
    zoxide init fish >$__fish_config_dir/conf.d/zoxide.fish
end

if command -qs fzf
    set -Ux FZF_DEFAULT_OPTS "--color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1 --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1 --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b"
end

if command -qs rg
    alias --save grep='rg'
end

# if command -qs dog
# 	alias --save dig='dog'
# end
