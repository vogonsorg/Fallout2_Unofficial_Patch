#!/bin/bash

set -xeu -o pipefail

extra_dir=${extra_dir:-extra}
mpack_version=${mpack_version:-4.1.9}

mpack_file="modderspack_$mpack_version.7z"
mpack_url="https://sourceforge.net/projects/sfall/files/Modders%20pack/$mpack_file/download"
compile_exe="compile.exe"
mpack_compile="ScriptEditor/resources/$compile_exe"

# directories
cache_dir="$HOME/.cache/build"
bin_dir="$(realpath extra/bin)"
mkdir -p "$cache_dir" "$bin_dir"

# compile.exe, no cache (mpack version may change)
wget -q "$mpack_url" -O "$mpack_7z"
7zr e "$mpack_7z" "$mpack_compile"
mv -f "$compile_exe" "$bin_dir/"
# sfall headers
7zr x "$mpack_7z" "scripting_docs/headers"
mv "scripting_docs/headers" "scripts_src/sfall"

# new wine
sudo dpkg --add-architecture i386
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
sudo add-apt-repository ppa:cybermax-dexter/sdl2-backport
sudo apt install winehq-stable
