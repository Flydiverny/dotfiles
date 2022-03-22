function gdfc -d "Diff selected file"
    switch $argv[1]
        case ''
            begin
                set saved_pwd $PWD
                and cdr
                and set file (git diff --cached --name-only | fzf --prompt 'git diff --cached ' --preview 'git diff --cached --color {}')
                and git diff --cached $file
                and builtin cd $saved_pwd
            end; or begin
                git status -sb
                and echo -e (set_color red) "\nERR:" (set_color normal)"No file selected."
            end
        case '*'
            git diff --cached $argv[1]
    end
end

complete --command gdfc --w 'git diff --cached'

