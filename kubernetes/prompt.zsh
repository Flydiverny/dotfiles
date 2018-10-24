#!/bin/bash
kubeprompt="/usr/local/opt/kube-ps1/share/kube-ps1.sh"
if [ -f "$kubeprompt" ]; then
  source $kubeprompt
  prompt_newline=' $(kube_ps1)'${PREPROMPT}${prompt_newline}
fi
