# source /home/adrien/Documents/2021-PTS/work/CLAM/zeitfracht-clam/tools/bashrc.sh
# source /media/adrien/DataExt/Xilinx/Vivado/2021.1/settings64.sh
# sudo mount -t cifs -o username=adrien //pts-p160-fs01.pts.intern/Shares /mnt/pts-nc

alias i="invoke"
alias il="invoke --list"
source <(invoke --print-completion-script bash)
complete -F _complete_invoke -o default i

DOTNET_CLI_TELEMETRY_OPTOUT=1

export PATH=$PATH:/opt/kickstage/astris-precompiled-tools/opt/clang+llvm-12.0.1-x86_64-linux-gnu-ubuntu-/bin/

# reproducible compilation - not sure which is needed
export LANG="en_US.utf8"
export LANGUAGE="en_US.utf8"
export LC_ALL="en_US.utf8"
export LC_CTYPE="en_US.utf8"

function pts_initworkenv_term() {
    AKS_ROOT="$HOME/Documents/2021-PTS/work/Kickstage/2021-08-work/"

    terminator --new-tab -e "echo -e '\033]2;py\007' && cd Downloads/ && python3"
    terminator --new-tab -e "echo -e '\033]2;AKS/fsw\007' && cd ${AKS_ROOT}/astris-fsw-framework/ && bash"
    terminator --new-tab -e "echo -e '\033]2;AKS/asn1_parser\007' && cd ${AKS_ROOT}/asn1_parser/ && bash"
    terminator --new-tab -e "echo -e '\033]2;AKS/astris-tmtc-database\007' && cd ${AKS_ROOT}/astris-tmtc-database/ && bash"
    # COSMOS

    # cleanup the terminal used to boostrap the env
    exit
}

function pts_initworkenv_gui() {
    DOC_ROOT="$HOME/Documents/"

    gitg --no-wd &
    # mattermost
    subl \
        --project "${DOC_ROOT}/AKS.sublime-project" \
        "${DOC_ROOT}/2021-PTS/Notes/Notes-TODO.md" \
        "${DOC_ROOT}/2021-PTS/Time/Notes-Time.md"
    firefox --new-window "https://mail.pts.space/" &
    keepassxc &

    # cleanup the terminal used to boostrap the env
    exit
}
