## Config

**Grub**

```bash
sudo vim /etc/default/grub
    GRUB_TIMEOUT=3
    GRUB_FONT=/boot/grub/unicode.pf2

sudo grub-mkfont -s 24 -o /boot/grub/unicode.pf2 /usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf
sudo grub-mkconfig -o /boot/efi/EFI/ubuntu/grub.cfg
```

**Journald**

```bash
sudo vim /etc/systemd/journald.conf
    SystemMaxUse=512M # default: 10% of FS, capped at 4 Go

sudo service systemd-journald restart

sudo journalctl --vacuum-size=512M
```

**Snaps**

```bash
ll /var/lib/snapd/snaps/

sudo snap set system refresh.retain=2

snap list --all | awk '/disabled/{print $1, $3}' | while read snapname revision; do sudo snap remove "$snapname" --revision="$revision"; done
```

**Bluetooth**

```bash
#https://askubuntu.com/questions/419115/make-bluetooth-disabled-by-default
sudo vim /etc/bluetooth/main.conf
    AutoEnable=false
```

**Tmpfs**

```bash
sudo vim /etc/fstab
    tmpfs                                           /tmp            tmpfs           defaults,noatime,nosuid,nodev,mode=1777,size=1024M 0 0
```

## Desktop background

```
$ dconf-editor
/org/gnome/desktop/background
    picture-options: zoom
    picture-uri: path/to/file
```

## Miscs

```bash
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface show-battery-percentage true
```

## Cleanup

```bash
dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n
sudo apt autoremove
sudo apt clean
```

## TODO

Conf:

* Bash: .bashrc + ln ~/.bash dotfiles
* Sublime: ln ~/.config/sublime-text-3/Packages dotfiles + license
* Gitg: ~/.local/share/gitg
* Terminator: ~/.config/terminator
* Firefox: ~/.mozilla
* ssh: ~/.ssh/
