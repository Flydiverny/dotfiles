#!/usr/bin/env fish
function npm-run -d npm-run
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

    if test -f package-lock.json
        set RUNNER npm
    end

    if test -f yarn.lock
        set RUNNER yarn
    end

    if test -n "$argv"
        $RUNNER run $argv
        return $status
    end

    set commands (jq -r ".scripts | keys[]" <package.json | string split0)

    # Only do workspaces for yarn
    if test "$RUNNER" = yarn
        if set workspaces (jq -r '.workspaces.packages[]' <package.json 2>/dev/null)
            for ws in $workspaces
                if ! test -f "$ws/package.json"
                    continue
                end

                set scripts (jq -r ".scripts | keys[] | \"$ws \(.)\"" <"$ws/package.json" 2>/dev/null | string split0)
                set commands $commands$scripts
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
    if ! set selection (echo "$commands" | fzf --preview-window down:2 --preview "$previewScript")
        return $status
    end

    set command (string split ' ' $selection)

    if test (count $command) -eq 2
        set script $command[2]
        set cwd " --cwd $command[1]"
    else
        set script $command[1]
    end

    # echo "$RUNNER$cwd run $script"
    commandline -- "$RUNNER$cwd run $script"
    # commandline -f repaint
    commandline -f execute
end
