#!/usr/bin/env bash

function reflex_init_work_env() {
    DOC_ROOT="$HOME/Documents/"

    terminator --layout layout-reflex

    keepassxc &
    firefox --new-tab "https://gmail.com/" \
        --new-tab "https://calendar.google.com/calendar/u/0/r" \
        --new-tab "https://reflexaerospace.atlassian.net/jira/software/projects/AV/boards/52/backlog" &

    subl \
       --project "${DOC_ROOT}/sublime-projects/reflex.sublime-project" \
        "/home/adrien/Documents/admin/time-tracking-detailed.md" \
        "/home/adrien/Documents/admin/todo-tasks.md"

    gitg --no-wd &

    # cleanup the terminal used to boostrap the env
    exit
}

# function reflex_screen_conf_desk() {
#     # arandr
#     xrandr \
#         --output XWAYLAND0 --mode 1920x1200 --pos 5120x140 --rotate normal \
#         --output XWAYLAND1 --mode 2560x1440 --pos 2560x0 --rotate normal --primary \
#         --output XWAYLAND2 --mode 2560x1440 --pos 0x0 --rotate normal
# }

#
# Ccstudio
# /opt/ti/ccs1200/ccs/eclipse/ccstudio
#
# HALCOGEN
# cd ~/.wine/drive_c/ti/Hercules/HALCoGen/v04.07.01 && wine HALCOGEN.exe
#

export PATH=$PATH:/opt/gcc-arm-none-eabi-10.3-2021.10/bin/

#RTEMS_TOOLCHAIN_ROOT=/opt/rtems/rtems-6-arm-toolchain/
#export PATH=${RTEMS_TOOLCHAIN_ROOT}/bin:$PATH
