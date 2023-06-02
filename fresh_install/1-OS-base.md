# Base

## Disk

* `/`: 30 Go
* `/opt/`: 300 Go
* `/home/`: 100 Go

**Move Windows's recovery partition**

Ref: https://superuser.com/questions/1453790/how-to-move-the-recovery-partition-on-windows-10

* Windows: `reagentc /disable`
* Linux: `echo 'start=490000M,' | sfdisk --no-act --no-tell-kernel --no-reread --move-data /dev/nvme0n1 -N 1`
* Windows: `reagentc /enable`

## Install sudo and update packages

```bash
USER=xx

# Install (very) basic packages
apt install -y sudo vim git

# Enable root for user
usermod -a -G sudo ${USER}

# Update packages
# update src: disable cdrom and add source
apt update -y
apt upgrade -y

# logout or reboot
```
