#!/usr/bin/env fish
if command -qs fdfind
    ln -sf (which fdfind) ~/.bin/fd
end

if command -qs batcat
    ln -sf (which batcat) ~/.bin/bat
end

if command -qs zoxide
    zoxide init fish >$__fish_config_dir/conf.d/zoxide.fish
end
