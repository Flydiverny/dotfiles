function gfu -d "Stage selected file"
    set diff_pager (git config core.pager)
    set previewScript "
        echo {} |grep -Eo '[a-f0-9]+' |head -1 |xargs -I% git show --color=always % -- $files | $diff_pager"
    switch $argv[1]
        case ''
            begin
                set target_commit (git log --color=always --format='%h%d %s %cr' | fzf --prompt 'git commit --fixup ' --preview "$previewScript" | rg -o '[a-f0-9]+' | head -1 )
                and git commit --fixup $target_commit
                and git status -sb
            end; or begin
                git status -sb
                and echo -e (set_color red) "\nERR:" (set_color normal)"No commit selected."
            end
        case '*'
            git commit --fixup $argv[1]
            git status -sb
    end
end

complete --command gfu --w 'git commit --fixup'

# function forgit::fixup -d "git fixup"
#     git diff --cached --quiet && echo 'Nothing to fixup: there are no staged changes.' && return 1

#     set files (echo $argv | sed -nE 's/.* -- (.*)/\1/p')
#     set preview "echo {} |grep -Eo '[a-f0-9]+' |head -1 |xargs -I% git show --color=always % -- $files | delta"

#     set target_commit (git log --color=always --format='%h%d %s %cr' $argv | fzf +s +m --tiebreak=index --preview=\"$preview\" | rg -o '[a-f0-9]+' | head -1)
#     git commit --fixup $target_commit
# end
