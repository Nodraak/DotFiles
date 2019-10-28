#!/usr/bin/env bash

function setup_aliases_ltadch()
{
    # from http://wpad/wpad.dat - 2019-05-07
    export http_proxy="http://ptmproxy.gmv.es:80"
    export https_proxy="http://ptmproxy.gmv.es:80"

    alias mount_projects="sudo umount /mnt/p ; sudo mount -t drvfs '\\\\gmvprojects\\s5_ics_asw' /mnt/p"
    alias mount_gmvstorage="sudo umount /mnt/s ; sudo mount -t drvfs '\\\\gmvstorage\\storage\\S5-ICS-ASW' /mnt/s"
    alias mount_gmvteca="sudo umount /mnt/t ; sudo mount -t drvfs '\\\\gmvteca\\gmvteca' /mnt/t"

    export DISPLAY=localhost:0.0
    alias xforwardS5Vcast="ssh -fX s5dev vcastqt"
    alias checkPis="ssh s5pis 'ps aux | grep h1505-mib'"

    alias sudo='sudo -EH'
}

function setup_aliases_s5dev()
{
    #
    # PATH
    #

    export PATHBAK=$PATH

    # common
    export PATH=$PATH:/home/adch/scripts
    export PATH=$PATH:/opt/vcast
    export PATH=$PATH:/opt/tsim-leon/tsim/linux-x64

    # custom
    export PATHUNITEST=$PATH:/opt/rtems-4.6/bin/
    export PATHVALTEST=$PATH:/opt/rtems/4.6_20171003/bin

    # export PATH=$PATHUNITEST  # ut_vcast
    export PATH=$PATHVALTEST  # path_vt

    #
    # Others
    #

    export LM_LICENSE_FILE=41931@licserver
    export S5ICSASW_VCAST_CONFIG_DIR=~/S5-ICS-ASW-VectorCast_CONFIG/

    alias svnstatus='svn status | grep -v ?'
    alias py='python3.6'
    alias pylint='python3.6 -m pylint'

    export LC_ALL=en_US.utf8
    export LC_CTYPE=en_US.utf8
}

setup_aliases_ltadch
#setup_aliases_s5dev
