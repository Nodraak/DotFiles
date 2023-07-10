FROM ubuntu:23.04

RUN apt update
RUN apt install -q -y --no-install-recommends \
    ca-certificates \
    cmake \
    gettext \
    git \
    gsettings-desktop-schemas-dev \
    libdazzle-1.0-dev \
    libgee-0.8-dev \
    libgirepository1.0-dev \
    libgit2-glib-1.0-dev \
    libgpgme-dev \
    libgspell-1-dev \
    libgtksourceview-4-dev \
    libhandy-1-dev \
    libjson-glib-dev \
    libpeas-1.0-0 \
    libpeas-dev \
    libsecret-1-dev \
    meson \
    ninja-build \
    valac

WORKDIR /tmp/
RUN git clone https://gitlab.gnome.org/GNOME/gitg.git

WORKDIR /tmp/gitg/

RUN git checkout 32271214 # 2022-10-09 13:26:24 +0000 Update Russian translation Aleksandr Melman

RUN meson --prefix=/usr build
RUN ninja -C build
RUN ninja -C install

CMD ["gitg"]
