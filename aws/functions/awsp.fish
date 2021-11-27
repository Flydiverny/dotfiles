function awsp -d "Switch aws profile"
    switch $argv[1]
        case ''
            begin
                set profile (aws configure list-profiles | fzf -d 10)
                and set -gx AWS_PROFILE $profile
                and echo "Switched to $profile"
            end; or echo "No profile selected, you are on $AWS_PROFILE"
        case '*'
            set -gx AWS_PROFILE $argv[1]
    end
end

# complete --command awsp --w 'git restore'
