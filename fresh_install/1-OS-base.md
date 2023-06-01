# Base

## Disk

* `/`: 30 Go
* `/opt/`: 300 Go
* `/home/`: 100 Go

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
