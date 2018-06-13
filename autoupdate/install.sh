#!/bin/sh
# setups the auto-update
if which crontab >/dev/null 2>&1; then
	(
		crontab -l | grep -v "dot_update"
		echo "0 */2 * * * $HOME/.dotfiles/bin/dot_update > ${TMPDIRR:-/tmp}/dot_update.log 2>&1"
	) | crontab -
else
	echo "Err: Didn't find any crontab so can't setup autoupdate!"
fi