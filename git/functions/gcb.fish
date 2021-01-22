function gcb -d "Switch to git branch"
    switch $argv[1]
        case ''
            set branch (git branch | fzf -d 10 | sed -e 's/\*//'  |sed -e 's/^[ \t]*//')
            git switch $branch
        case '*'
            git switch $argv[1]
    end
end

complete --command gcb --w 'git switch'
