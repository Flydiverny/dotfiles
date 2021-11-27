#!/usr/bin/env fish
# set nord theme (from fish_config)
set -U fish_color_normal normal
set -U fish_color_command 81a1c1
set -U fish_color_quote a3be8c
set -U fish_color_redirection b48ead
set -U fish_color_end 88c0d0
set -U fish_color_error ebcb8b
set -U fish_color_param eceff4
set -U fish_color_comment 434c5e
set -U fish_color_match --background=brblue
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_search_match bryellow --background=brblack
set -U fish_color_history_current --bold
set -U fish_color_operator 00a6b2
set -U fish_color_escape 00a6b2
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_valid_path --underline
set -U fish_color_autosuggestion 4c566a
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel -r
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D yellow
set -U fish_pager_color_prefix white --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan

set -Ux EDITOR nano
set -Ux VISUAL $EDITOR
set -Ux WEDITOR code

set -Ux DOTFILES ~/.dotfiles
set -Ux PROJECTS ~/Code

set -Ua fish_user_paths $DOTFILES/bin $HOME/.bin

for f in $DOTFILES/*/functions
	set -Up fish_function_path $f
end

if test -f ~/.localrc.fish
	ln -sf ~/.localrc.fish ~/.config/fish/conf.d/localrc.fish
end

eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)