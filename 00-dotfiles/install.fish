#!/usr/bin/env fish
for f in $DOTFILES/*/conf.d/*.fish
	ln -sf $f $__fish_config_dir/conf.d/(basename $f)
end

