#!/usr/bin/env fish
if command -qs fdfind
    ln -sf (which fdfind) ~/.bin/fd
end

if command -qs batcat
    ln -sf (which batcat) ~/.bin/bat
end
