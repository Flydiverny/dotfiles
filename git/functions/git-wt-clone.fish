function git-wt-clone --description "Clone a git repository as bare for worktrees"
    # Examples of call:
    # git-wt-clone git@github.com:name/repo.git
    # => Clones to a /repo directory
    #
    # git-wt-clone git@github.com:name/repo.git my-repo
    # => Clones to a /my-repo directory

    if test (count $argv) -eq 0
        echo "Usage: git-wt-clone <git-url> [directory-name]"
        return 1
    end

    set url $argv[1]
    set basename (string replace -r '.*/' '' $url)
    set name $argv[2]
    if test -z "$name"
        set name (string replace -r '\.[^.]*$' '' $basename)
    end

    mkdir $name
    cd $name

    # Moves all the administrative git files (a.k.a $GIT_DIR) under .bare directory.
    #
    # Plan is to create worktrees as siblings of this directory.
    # Example targeted structure:
    # .bare
    # main
    # new-awesome-feature
    # hotfix-bug-12
    # ...
    git clone --bare $url .bare
    echo "gitdir: ./.bare" > .git

    # Explicitly sets the remote origin fetch so we can fetch remote branches
    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

    # Gets all branches from origin
    git fetch origin
end
