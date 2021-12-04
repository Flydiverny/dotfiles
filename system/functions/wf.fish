function wf -d "quick fuzzy find into $PROJECTS/$WORK_PROJECTS"
    set goHere (fd -t d -t l -d 1 . $PROJECTS/$WORK_PROJECTS | sed "s@$PROJECTS/$WORK_PROJECTS/@@" | fzf -d 10)
    and c "$WORK_PROJECTS/$goHere"
end
