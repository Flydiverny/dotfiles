function kubemc
    echo "kubemc $argv[1]"
end

function kubemcp
    echo "kubemc $argv[1]"
end

function handle_preexec --on-event fish_preexec
    set -l input_cmd $argv[1]
    set -l split_cmd (string split ' ' $input_cmd)
    set -l first_cmd $split_cmd[1]
    set -l cmd "$split_cmd[2..-1]"


    if test "$first_cmd" = kubemc
        echo -e "running kubemc on\n  $cmd"
        set -l contexts (kubectl config get-contexts -o name | grep -v tools | grep staging)
        for context in $contexts
            set -l modified_cmd (string replace -a "kubectl" "kubectl --context \"$context\"" $cmd)
            echo -e "Running using \e[1;33m$context\e[0m"
            echo -e "  $modified_cmd\n"
            eval $modified_cmd
            echo -e "\n"
        end
    end
    if test "$first_cmd" = kubemcp
        echo -e "running kubemcp on\n  $cmd"
        set -l contexts (kubectl config get-contexts -o name | grep -v tools | grep production)
        for context in $contexts
            set -l modified_cmd (string replace -a "kubectl" "kubectl --context \"$context\"" $cmd)
            echo -e "Running using \e[1;33m$context\e[0m"
            echo -e "  $modified_cmd\n"
            eval $modified_cmd
            echo -e "\n"
        end
    end
end

function fish_preexec
    handle_preexec
end
