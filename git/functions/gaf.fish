function gaf -d "Stage selected file"
    switch $argv[1]
        case ''
            begin
                set file (git diff --name-only * | fzf -d 10)
                and git add $file
                and git status -sb
            end; or begin
                git status -sb
                and echo -e (set_color red) "\nERR:" (set_color normal)"No file selected."
            end
        case '*'
            git add $argv[1]
            git status -sb
    end
end

complete --command gaf --w 'git add'

