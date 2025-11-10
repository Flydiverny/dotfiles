function gcw -d "Git checkout worktree - switch to existing or create new worktree"
    # Check if we're in a git repository
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo "Error: Not in a git repository"
        return 1
    end

    switch $argv[1]
        case ''
            # Interactive mode with fzf
            if not command -v fzf >/dev/null 2>&1
                echo "Error: fzf is required for interactive mode"
                return 1
            end

            # Use git branch -a directly with colors, just filter out HEAD and duplicates
            set selected (git branch -a --color=always | grep -v 'remotes/origin/HEAD' | sort -u | fzf --ansi --tac --prompt="Select branch: " --height=15 | string trim | sed 's/^[*+] *//' | sed 's#remotes/origin/##')

            if test -n "$selected"
                gcw "$selected"
            end

        case '*'
            # Direct branch specification
            set target_branch $argv[1]

            # Check if this branch already has a worktree
            set existing_worktree ""
            set worktree_info (git worktree list --porcelain)

            set current_path ""
            for line in $worktree_info
                if string match -q 'worktree *' $line
                    set current_path (string replace 'worktree ' '' $line)
                else if string match -q "branch refs/heads/$target_branch" $line
                    set existing_worktree $current_path
                    break
                end
            end

            if test -n "$existing_worktree"
                # Worktree exists, switch to it
                echo "Switching to existing worktree for branch '$target_branch': $existing_worktree"
                cd "$existing_worktree"
                # Ensure upstream tracking is configured
                if not git rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1
                    if git show-ref --verify --quiet "refs/remotes/origin/$target_branch"
                        git branch --set-upstream-to="origin/$target_branch" "$target_branch" 2>/dev/null
                        if test $status -eq 0
                            echo "Configured upstream tracking to origin/$target_branch"
                        else
                            echo "Warning: Failed to set upstream tracking for $target_branch"
                        end
                    end
                end
            else
                # Create new worktree
                set main_worktree (git worktree list | head -1 | awk '{print $1}')
                set worktree_parent (dirname "$main_worktree")
                set new_worktree_path "$worktree_parent/$target_branch"

                # Sanitize branch name for directory (replace slashes with dashes)
                set safe_branch_name (echo "$target_branch" | sed 's/\//-/g')
                set new_worktree_path "$worktree_parent/$safe_branch_name"

                echo "Creating new worktree for branch '$target_branch' at: $new_worktree_path"

                # Check if branch exists locally or remotely
                if git show-ref --verify --quiet "refs/heads/$target_branch"
                    # Local branch exists
                    git worktree add "$new_worktree_path" "$target_branch"
                else if git show-ref --verify --quiet "refs/remotes/origin/$target_branch"
                    # Remote branch exists, create local tracking branch
                    git worktree add "$new_worktree_path" -b "$target_branch" "origin/$target_branch"
                else
                    # Neither exists, create new branch
                    git worktree add "$new_worktree_path" -b "$target_branch"
                end

                if test $status -eq 0
                    echo "Successfully created worktree. Switching to: $new_worktree_path"
                    cd "$new_worktree_path"
                    # Ensure upstream tracking is configured (worktree add -b doesn't auto-track)
                    if not git rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1
                        if git show-ref --verify --quiet "refs/remotes/origin/$target_branch"
                            git branch --set-upstream-to="origin/$target_branch" "$target_branch" 2>/dev/null
                            if test $status -eq 0
                                echo "Configured upstream tracking to origin/$target_branch"
                            else
                                echo "Warning: Failed to set upstream tracking for $target_branch"
                            end
                        end
                    end
                else
                    echo "Failed to create worktree for branch '$target_branch'"
                    return 1
                end
            end
    end
end

complete --command gcw --w 'git branch'
