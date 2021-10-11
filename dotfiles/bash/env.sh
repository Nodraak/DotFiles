#!/usr/bin/env bash

#
# Env variables
#

export EDITOR="subl -w"  # for git, crontab, ...

# Home
export PATH=${HOME}/bin:${PATH}
export PATH=${HOME}/.local/bin:${PATH}

# go
export GOPATH=${HOME}/gopath
export PATH=$GOPATH:$GOPATH/bin:${PATH}
export DRIVE_GOMAXPROCS=8

# c/cpp
#export GCCARMPATH=/home/nodraak/Documents/Etudes/ECE_ING4/Deoxys/stm32-mbed/gcc-arm-none-eabi-5_4-2016q2/bin
#export PATH=$GCCARMPATH:${PATH}

# nodejs
#export PATH=/opt/node-v8.1.2-linux-x64/bin/:${PATH}

# rust
export PATH=${HOME}/.cargo/bin:${PATH}
