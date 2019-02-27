#!/bin/sh

alias kx='kubectx'
alias kn='kubens'

alias k='kubectl'
alias kg='kubectl get'
alias sk='kubectl -n kube-system'
alias ke='EDITOR=nano kubectl edit'
alias klbaddr="kubectl get svc -ojsonpath='{.status.loadBalancer.ingress[0].hostname}'"

alias kdebug='kubectl run -i -t debug --rm --image=caarlos0/debug --restart=Never'
alias knrunning='kubectl get pods --field-selector=status.phase!=Running'
# alias kfails='kubectl get po -owide --all-namespaces | grep "0/" | tee /dev/tty | wc -l'
alias kfails='kubectl get po -owide --all-namespaces --field-selector=status.phase=Failed | tee /dev/tty | wc -l'
alias kimg="kubectl get deployment -ojsonpath='{...image}' | tr '[[:space:]]' '\n' | sed -e s@(.*[^/])/@@g | tr ':' ' ' | column -t"
