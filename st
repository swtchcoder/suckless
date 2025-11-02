#!/bin/sh
set -e
BUILD="${2:-$(mktemp -d)}"
curl -Lo "$BUILD/st.tar.gz" https://dl.suckless.org/st/st-0.8.5.tar.gz
tar -xzf "$BUILD/st.tar.gz" -C "$BUILD"
patch -p1 -d "$BUILD/st-0.8.5" < st.diff
curl -fsSL https://st.suckless.org/patches/gruvbox/st-gruvbox-dark-0.8.5.diff \
  | patch -p1 -d "$BUILD/st-0.8.5"
curl -fsSL https://st.suckless.org/patches/scrollback/st-scrollback-0.8.5.diff \
  | patch -p1 -d "$BUILD/st-0.8.5"
curl -fsSL https://st.suckless.org/patches/scrollback/st-scrollback-mouse-20191024-a2c479c.diff \
  | patch -p1 -d "$BUILD/st-0.8.5"
curl -fsSL https://st.suckless.org/patches/anysize/st-anysize-20220718-baa9357.diff \
  | patch -p1 -d "$BUILD/st-0.8.5"
make -C "$BUILD/st-0.8.5" PREFIX="${1:-/usr/local}" install
