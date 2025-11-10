#!/usr/bin/env fish

# Don't ask ssh password all the time
switch (uname)
    case Darwin
        git config --global credential.helper osxkeychain
    case '*'
        git config --global credential.helper cache
end

# better diffs
if command -qs delta
    git config --global core.pager delta
    git config --global interactive.diffFilter 'delta --color-only'
    git config --global delta.syntax-theme Nord
    git config --global delta.line-numbers true
    git config --global delta.decorations true
end

# use vscode as mergetool
if command -qs code
    git config --global merge.tool vscode
    and git config --global mergetool.vscode.cmd 'code --wait $MERGED'
end
