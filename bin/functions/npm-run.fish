#!/usr/bin/env fish
function __run_yarn_npm
	if ! command -qa fzf
        echo "fzf not found"
        return 1
    end

    if ! command -qa jq
        echo "jq not found"
        return 1
    end

    if ! test -f package.json
        echo "No package.json found"
        return 1
    end

    # if test -f package-lock.json
    #     set RUNNER npm
    # end

    # if test -f yarn.lock
    #     set RUNNER yarn
    # end

    if test -n "$argv"
        $RUNNER run $argv
        return $status
    end

    set -l commands (jq -r ".scripts | keys[]" <package.json)

    # Only do workspaces for yarn
    if set workspaces (jq -r '.workspaces.packages[]' <package.json 2>/dev/null)
    else if set workspaces (jq -r '.workspaces[]' <package.json 2>/dev/null)
    end

	for ws in packages/* $workspaces
		if ! test -f "$ws/package.json"
			continue
		end

		set -l scripts (jq -r ".scripts | keys[] | \"$ws \(.)\"" <"$ws/package.json" 2>/dev/null)
		for script in $scripts
			if test -n "$script"
				set -a commands $script
			end
		end
	end

    # shellcheck disable=SC2016
    set previewScript '
	set target (string split " " {});
	set ws $target[1];
	set script $target[2];
	if test -z "$script";
		set script $ws;
		set ws ".";
		set cwd "";
	else;
		set cwd " --cwd $ws";
	end;
	set reset (tput sgr0);
	set bold (tput bold);
	set yellow (tput setaf 3);
	set command (jq -r ".scripts[\"$script\"]" <"$ws/package.json");
	echo -e {$yellow}{$bold}__RUNNER__{$cwd} run $script\n{$reset}# $command
	'

    # preview should show correct runner
    set previewScript (string replace "__RUNNER__" "$RUNNER" "$previewScript")

    # user aborted, we exit
    if ! set selection (printf %s\n $commands | fzf --preview-window down:2 --preview "$previewScript")
        return $status
    end

    set command (string split ' ' $selection)

    if test (count $command) -eq 2
        set script $command[2]
        if test "$RUNNER" = 'yarn'
            set cwd " --cwd $command[1]"
        end
        if test "$RUNNER" = 'npm'
            set cwd " -w $command[1]"
        end
    else
        set script $command[1]
    end

    # echo "$RUNNER$cwd run $script"
    commandline -- "$RUNNER$cwd run $script"
    # commandline -f repaint
    commandline -f execute
end


function npm-run -d npm-run
	RUNNER=npm __run_yarn_npm
end

function yarn-run -d yarn-run
	RUNNER=yarn __run_yarn_npm
end

complete --command npm-run --w 'npm run'
complete --command yarn-run --w 'yarn run'
