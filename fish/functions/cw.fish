function cw -d "Change git worktree using fzf"
    # Check if we're in a git repository
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo "Error: Not in a git repository"
        return 1
    end

    # Check if fzf is available
    if not command -v fzf >/dev/null 2>&1
        echo "Error: fzf is required but not installed"
        return 1
    end

    # Get list of worktrees with their branches
    set worktree_info (git worktree list --porcelain)

    # Parse worktree information
    set worktrees
    set branches
    set current_worktree (git rev-parse --show-toplevel)

    set current_path ""
    set current_branch ""

    for line in $worktree_info
        if string match -q 'worktree *' $line
            # Save previous worktree if we have one
            if test -n "$current_path"
                set -a worktrees $current_path
                set -a branches $current_branch
            end

            set current_path (string replace 'worktree ' '' $line)
            set current_branch unknown
        else if string match -q 'branch *' $line
            set current_branch (string replace 'branch refs/heads/' '' $line)
        else if string match -q detached $line
            set current_branch "HEAD (detached)"
        end
    end

    # Don't forget the last worktree
    if test -n "$current_path"
        set -a worktrees $current_path
        set -a branches $current_branch
    end

    if test (count $worktrees) -le 1
        echo "No additional worktrees found. Use 'git worktree add' to create more worktrees."
        return 1
    end

    # Format worktrees for fzf display
    set formatted_worktrees
    for i in (seq (count $worktrees))
        set worktree $worktrees[$i]
        set branch $branches[$i]
        set display_name (basename $worktree)

        if test "$worktree" = "$current_worktree"
            set -a formatted_worktrees "* $display_name [$branch]"
        else
            set -a formatted_worktrees "  $display_name [$branch]"
        end
    end

    # Use fzf to select worktree
    set selected_display (printf '%s\n' $formatted_worktrees | fzf --prompt="Select worktree: " --height=10 | sed 's/^[* ] //')

    if test -n "$selected_display"
        # Extract just the display name and find the corresponding worktree path
        set display_name (echo "$selected_display" | sed 's/ \[.*\]//')

        # Find the matching worktree path
        for i in (seq (count $worktrees))
            if test (basename $worktrees[$i]) = "$display_name"
                set selected $worktrees[$i]
                break
            end
        end

        echo "Switching to worktree: $selected"
        cd "$selected"
    end
end

# Add completion for git worktree commands
complete --command cw --description "Change git worktree using fzf"
