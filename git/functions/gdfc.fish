function gdfc -d "Diff selected file"
    switch $argv[1]
        case ''
            begin
                set file (git diff --cached --name-only * | fzf -d 10)
                and git diff --cached $file
            end; or begin
                git status -sb
                and echo -e (set_color red) "\nERR:" (set_color normal)"No file selected."
            end
        case '*'
            git diff --cached $argv[1]
    end
end

complete --command gdfc --w 'git diff --cached'

