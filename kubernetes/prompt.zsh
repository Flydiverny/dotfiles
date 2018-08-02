#!/bin/bash
source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
# PPROMPT='$(kube_ps1)'$PREPROMPT
prompt_newline=' $(kube_ps1)'$PREPROMPT$prompt_newline
