# Packages

## SSH key and Dotfiles

```bash
# SSH key

ssh-keygen -t ed25519 -C "adrienchardon@mailoo.org"
# add it to Github/Gitlab

# Dotfiles

cd ${HOME} && git clone git@github.com:Nodraak/DotFiles.git
cd DotFiles/

mkdir .config/sublime-text-3  # quick workaround
./install.py
```

## Basic system packages

```bash
APTINSTALL="sudo apt install -q -y"

# bash
${APTINSTALL} terminator bash-completion command-not-found
${APTINSTALL} git-lfs picocom usbutils moreutils acpi traceroute exif

${APTINSTALL} inotify-tools  # important for sublime-text

# basic tools and lib
${APTINSTALL} unzip gzip bzip2
${APTINSTALL} ca-certificates

# compile/dev
${APTINSTALL} build-essential gdb make cmake autoconf automake shellcheck
${APTINSTALL} python3-dev python3-pip
${APTINSTALL} colordiff ascii cloc dos2unix
${APTINSTALL} can-utils
${APTINSTALL} kicad

# sysadmin
${APTINSTALL} htop iotop iftop
${APTINSTALL} ethtool socat dnsutils netutils-tools net-tools
${APTINSTALL} telnet curl wget nmap strace
${APTINSTALL} rsync stress tree
${APTINSTALL} dconf-editor

# media
${APTINSTALL} ffmpeg imagemagick jpegoptim libxml2-utils
${APTINSTALL} dia graphviz

# apps
${APTINSTALL} pcmanfm gitg vlc libreoffice gimp
```

## Python packages

```bash
pip3 install \
    httpie pygments pylint ipython \
    numpy scipy matplotlib \
    requests beautifulsoup4 \
    flask django \
    ansible invoke \
    youtube-dl
```

## Latex / Pandoc

```bash
APTINSTALL="sudo apt install -q -y"

# texlive-fonts-extra: fontawesome - or just fonts-font-awesome
# texlive-latex-extra: moderncv + patch https://tex.stackexchange.com/questions/260446/what-does-you-have-requested-package-foo-but-the-package-provides-foo-me
# texlive-science: siunitx
${APTINSTALL} \
    pandoc \
    texlive \
    texlive-fonts-extra \
    texlive-lang-french \
    texlive-latex-extra \
    texlive-science \
    texlive-xetex

# ${APTINSTALL} texlive-full

# Finish texlive install

xzdec pgf texlive-formats-extra aspell
# refs
#   https://tex.stackexchange.com/questions/137428/tlmgr-cannot-setup-tlpdb
#   https://help.ubuntu.com/community/LaTeX
#   (https://en.wikibooks.org/wiki/LaTeX/Installing_Extra_Packages)
sudo tlmgr init-usertree
sudo tlmgr install framed
sudo texhash
sudo tlmgr option repository ftp://tug.org/historic/systems/texlive/2017/tlnet-final
```

## Apps

```bash
APTINSTALL="sudo apt install -q -y"

# Fallback browser

${APTINSTALL} chromium-browser

# Moserial
#
# https://wiki.gnome.org/action/show/Apps/Moserial / https://gitlab.gnome.org/GNOME/moserial.git
# deps: gnome-common yelp-tools gtk+-3.0 valac
# old: tarball from http://ftp.gnome.org/pub/GNOME/sources/moserial/

${APTINSTALL} moserial
sudo addgroup "$USERNAME" dialout


# KeyPassXC - https://keepassxc.org/download/

sudo add-apt-repository ppa:phoerious/keepassxc
sudo apt update
${APTINSTALL} keepassxc
```

## Sublime - https://www.sublimetext.com/3

```bash
cd ${HOME}/Downloads/
wget https://download.sublimetext.com/sublime-text_build-3211_amd64.deb
sudo dpkg -i sublime-text_build-3211_amd64.deb
# Add license
# Install Package Control
```

## Firefox

* Search engine
* Ask to save logins and passwords for websites
* Home
* Ctrl+Tab cycles through tabs in recently used order

pin Firefox: `sudo apt-mark hold firefox`

```text
* uninstall apt's firefox
* download from website + install manually in /opt + symlink to /usr/bin
* plugins:
    * uBlock Origin https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/
    * Privacy Badger https://www.eff.org/privacybadger
    * more extensions (cookie manager, disable ctrlq, ghostery, greasmonkey, gnotifier, live hhtp headers, modify http headers, sqlite manager, speed tweaks (speady fox), ssleuth, user agent switcher, web dev)
        * ublock origin
        * umatrix
        * privacy badger
        * canvas blocker
        * disconnect
        * https everywhere
        * decentraleyes
        * au revoir utm
        * google search link fix
        * smart referer

// fix some really annoying behavior

- browser.tabs.closeWindowWithLastTab = true
- app.update.auto = false

// Adapted from https://github.com/mid-kid/config and @aeris22 hints

- privacy.firstparty.isolate = true

// Don't phone home to mozilla
- datareporting.healthreport.service.enabled = false
- datareporting.healthreport.uploadEnabled = false
- toolkit.telemetry.enabled = false
- browser.selfsupport.url = ""

// Stupid integrated browser plugins
- browser.pocket.enabled = false

// Search suggestions
- browser.search.suggest.enabled = false

// Geolocation
- beacon.enabled = false
- geo.enabled = false

// Don't leak list of plugins
- plugins.enumerable_names = ""

// Disable prefetching - break some "hover" mechanisms
//- network.prefetch-next = false
//- network.dns.disablePrefetch = true
//- network.predictor.enabled = false

// Do not track (It's a good idea on paper, but without some enforcement it's useless. Especially when Google ignores it)
- privacy.trackingprotection.enabled = true
- privacy.donottrackheader.enabled = true

// Disable social media "integration"
- social.directories = ""
- social.remote-install.enabled = false
- social.toast-notifications.enabled = false

// Only allow cookies from originating server
//- network.cookie.cookieBehavior = 1

// Why do websites need my battery stats?
- dom.battery.enabled = false

// Only I say where I want to go
- accessibility.blockautorefresh = true

// Don't be shy.
- browser.urlbar.trimURLs = false




// Old

- Self-Destructing Cookies
- NoScript

Options:
-- Safebrowsing stuff
- browser.safebrowsing.enabled = false
- browser.safebrowsing.downloads.enabled = false
- browser.safebrowsing.malware.enabled = false
- extensions.blocklist.enabled = false

-- Disable DRM shit
- media.eme.enabled = false
- media.gmp-eme-adobe.enabled = false

-- WebRTC
- media.peerconnection.enabled = false -> NOP, breaks appears.in ? (need restart)

-- WebGL (Puts code in the GPU, could be harmful, isn't necessary anyway. Unless you're one of those "webapp" worshippers.)
- webgl.disabled = true

-- So much for that cheap anti-right-click trick some sites pull off
- dom.event.clipboardevents.enabled = false -> NOP, it breaks ctrl-c ctrl-v in gdocs
```
