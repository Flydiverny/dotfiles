#!/usr/bin/env fish
abbr -a less 'less -r'

abbr -a nr npm-run
abbr -a yr npm-run

if command -qs exa
	abbr -a ls 'exa'
	abbr -a l 'exa -lh --icons'
	abbr -a la 'exa -lah --icons'
	abbr -a ll 'exa -l --icons'
	abbr -a lt 'exa -l --icons --tree --level=2'
else
	abbr -a l 'ls -lAh'
	abbr -a la 'ls -A'
	abbr -a ll 'ls -l'
end

if command -qs fdfind
	ln -sf (which fdfind) ~/.bin/fd
end

# if command -qs fd
# 	abbr -a find 'fd'
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
	abbr -a grep 'rg'
end

# if command -qs dog
# 	abbr -a dig 'dog'
# end
