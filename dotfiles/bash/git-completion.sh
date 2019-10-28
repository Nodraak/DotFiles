#!/usr/bin/env bash

# depending on OS and version
F=/usr/share/bash-completion/completions/git
if [[ -e "$F" ]]; then source "$F"; fi
F=/etc/bash_completion.d/git-prompt
if [[ -e "$F" ]]; then source "$F"; fi
F=/etc/bash_completion.d/git
if [[ -e "$F" ]]; then source "$F"; fi
# /usr/lib/git-core/git-sh-prompt/git-sh-prompt.sh
# source /usr/share/git-core/contrib/completion/git-prompt.sh
