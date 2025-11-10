#!/usr/bin/env fish
curl -sL https://raw.githubusercontent.com/evanlucas/fish-kubectl-completions/master/completions/kubectl.fish -o $__fish_config_dir/kubectl.fish

set -gx PATH $PATH $HOME/.krew/bin

