function cf -d "quick fuzzy find into $PROJECTS"
	set goHere (fd -t d -t l -d 2 . $PROJECTS | sed "s@$PROJECTS/@@" | fzf -d 10)
	and c "$goHere"
end
