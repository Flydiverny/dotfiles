function gdf -d "Diff selected file"
    switch $argv[1]
        case ''
            begin
                set saved_pwd $PWD
                and cdr
                and set file (git diff --name-only | fzf -d 10)
                and git diff $file
                and builtin cd $saved_pwd
            end; or begin
                git status -sb
                and echo -e (set_color red) "\nERR:" (set_color normal)"No file selected."
            end
        case '*'
            git diff $argv[1]
    end
end

complete --command gdf --w 'git diff'

