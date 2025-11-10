function gaf -d "Stage selected file"
    set diff_pager (git config core.pager)
    set extract "
    sed 's/^.*]  //' |
    sed 's/.* -> //' |
    sed -e 's/^\\\"//' -e 's/\\\"\$//'"
    set previewScript "
        set file (echo {} | $extract)
        if git status -s -- \$file | grep '^??' &>/dev/null;  # diff with /dev/null for untracked files
            git diff --color=always --no-index -- /dev/null \$file | $diff_pager | sed '2 s/added:/untracked:/'
        else
            git diff --color=always -- \$file | $diff_pager
        end"
    switch $argv[1]
        case ''
            begin
                set saved_pwd $PWD
                and cdr
                and set file (begin; git ls-files -o --exclude-standard; git diff --name-only; end | fzf --prompt 'git add ' --preview "$previewScript" )
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

