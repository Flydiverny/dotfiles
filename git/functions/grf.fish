function grf -d "Unstage selected file"
    switch $argv[1]
        case ''
            begin
                set saved_pwd $PWD
                and cdr
                and set file (git diff --cached --name-only | fzf --prompt 'git restore --staged ')
                and git restore --staged $file
                and git status -sb
                and builtin cd $saved_pwd
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
