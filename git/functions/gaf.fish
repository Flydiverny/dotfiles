function gaf -d "Stage selected file"
    switch $argv[1]
        case ''
            begin
                set saved_pwd $PWD
                and cdr
                and set file (begin; git ls-files -o --exclude-standard; git diff --name-only; end | fzf -d 10)
                and git add $file
                and git status -sb
                and builtin cd $saved_pwd
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

