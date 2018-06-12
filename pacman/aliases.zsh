if [ -f "/etc/arch-release" ]; then
    # pacman/yaourt aliases
    #alias pacman='PACMAN=/usr/bin/pacman; [ -f /usr/bin/pacman-color ] && PACMAN=/usr/bin/pacman-color; $PACMAN $@'
    alias pac="sudo pacman -S"              # default action        - install one or more packages
    alias paca="/usr/bin/yaourt -S"                 # default yaourt action - install one or more packages including AUR
    alias pacu="/usr/bin/yaourt -Syu"               # '[u]pdate'            - upgrade all packages to their newest version
    alias pacua="/usr/bin/yaourt -Syua"             # '[u]pdate'            - upgrade all packages to their newest version
    alias pacr="sudo /usr/bin/yaourt -Rs"           # '[r]emove'            - uninstall one or more packages
    alias pacs="pacman -Ss"         # '[s]earch'            - search for a package using one or more keywords
    alias pacas="/usr/bin/yaourt -Ss"               # '[a]ur [s]earch'      - search for a package or a PKGBUILD using one or more keywords
    alias paci="/usr/bin/yaourt -Si"                # '[i]nfo'              - show information about a package
    alias paclo="pacman -Qdt"               # '[l]ist [o]rphans'    - list all packages which are orphaned
    alias pacc="sudo pacman -Scc"           # '[c]lean cache'       - delete all not currently installed package files
    alias paclf="pacman -Ql"                # '[l]ist [f]iles'      - list all files installed by a given package
    alias pacexpl="/usr/bin/yaourt -D --asexplicit" # 'mark as [expl]icit'  - mark one or more packages as explicitly installed
    alias pacimpl="/usr/bin/yaourt -D --asdeps"     # 'mark as [impl]icit'  - mark one or more packages as non explicitly installed

    # '[r]emove [o]rphans' - recursively remove ALL orphaned packages
    alias pacro="pacman -Qtdq > /dev/null && sudo pacman -Rs \$(pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g')"
fi
