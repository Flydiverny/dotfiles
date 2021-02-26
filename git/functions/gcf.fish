function gcf -d "Remove local changes from selected file"
    switch $argv[1]
        case ''
            begin
                set saved_pwd $PWD
                and cdr
                set file (git diff --name-only | fzf -d 10)
                and git restore $file
                and git status -sb
                and builtin cd $saved_pwd
            end; or begin
                git status -sb
                and echo -e (set_color red) "\nERR:" (set_color normal)"No file selected."
            end
        case '*'
            git restore $argv[1]
            git status -sb
    end
end

complete --command gcf --w 'git restore'

