function grf -d "Unstage selected file"
    switch $argv[1]
        case ''
            begin
                set branch (git diff --cached --name-only * | fzf -d 10)
                and git restore --staged $branch
                and git status -sb
            end; or begin
                git status -sb
                and echo -e (set_color red) "\nERR:" (set_color normal)"No file selected."
            end
        case '*'
            git restore --staged $argv[1]
            git status -sb
    end
end

complete --command grf --w 'git restore --staged'
