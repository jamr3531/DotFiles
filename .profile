########## PATH ##########
# Local libs
export LLIB=/data/data/com.termux/files/home/.local/lib
# Local Binaries
export LBIN=/data/data/com.termux/files/home/.local/bin
# Rust Binaries
export CARGOBIN=/data/data/com.termux/files/home/.cargo/bin
# Node Binaries
#export NPMBIN=$(node bin)
# Go Path
export GOPATH=/data/data/com.termux/files/home/.go
# Put it all together...
export PATH=$CARGOBIN:$LBIN:$LLIB:$GOPATH:$PATH

########## VALUES ##########
export HOSTNAME=$(getprop ro.product.device)
export HOST='Android'
export USER=$(id -un)
export TERM='xterm-256color'
## TERMUX DIRECTORIES:
# TH: Termux Home
export TH='/data/data/com.termux/files/home'
# RH: Root Home  (for 'tsu')
export RH='/data/data/com.termux/files/home/.suroot'
# TB: Termux Bin
export TBIN='/data/data/com.termux/files/usr/bin'
# TE: Termux Etc
export TE='/data/data/com.termux/files/usr/etc'
# TU: Termux Usr
export TU='/data/data/com.termux/files/usr'
# TUS: Termux Usr Share
export TUS='/data/data/com.termux/files/usr/share'
## SYSTEM DIRECTORIES:
# SD: SDcard (internal storage AKA "storage/emulated/0")
export SD='/sdcard'
# DL: Downloads
export DL='/sdcard/Downloads'
# MUSIC
export MUSIC='/sdcard/Music'
# DOCS
export DOCS='/sdcard/Documents'
# SB: Sbin
export SBIN='/sbin'
# XB: Xbin
export XBIN='/system/xbin'
## FILES:
# System
export BP='/system/build.prop'
export HOSTS='/system/etc/hosts'
# Shells
# TBRC: Termux Bashrc
export TBRC='/data/data/com.termux/files/usr/etc/bash.bashrc'
# MBRC: My Bashrc
export MBRC='/data/data/com.termux/files/home/.bashrc'
# SBRC: System Bashrc
export SBRC='/system/etc/bash/bashrc'
# TZRC: Termux Zshrc
export TZRC='/data/data/com.termux/files/usr/etc/zshrc'
# MZRC: My Zshrc
export MZRC='/data/data/com.termux/files/home/.zshrc'
# SZRC: System Zshrc
export SZRC='/system/zsh/zshrc'
# MRC: Mkshrc      (System only, I dont use this inside Termux)
export MRC='/system/etc/mkshrc'
# FC:  Fish Config (Termux only, I dont use this outside Termux)
export FC='/data/data/com.termux/files/usr/etc/fish/config.fish'
# MFC: My Fish Config
export MFC='/data/data/com.termux/files/home/.config.fish'


##### ONE STARTUP FILE FOR MULTIPLE SHELLS & ENVIRONMENTS #####
# No need for tons of files just to set the above values,
# So I use one .profile instead.
#
# This also avoids "$HOME" or "~" as when using:
# 'tsu', 'proot' or 'chroot' the value for $HOME changes.

# Where you keep your startup files:
SOURCE_FOLDER='/data/data/com.termux/files/home'

# Source shell-specific startup files if that shell is in use:
# Android's default shell (mksh)
if [ "$MKSH" ] && [ -f $SOURCE_FOLDER/.mkshrc ]; then
source $SOURCE_FOLDER/.mkshrc
fi

# Termux's default shell (bash)
if [[ "$BASH" ]] && [[ -f $SOURCE_FOLDER/.bashrc ]]; then
source $SOURCE_FOLDER/.bashrc
fi

# Zsh
if [[ "$ZSH" ]] && [[ -f $SOURCE_FOLDER/.zshrc ]]; then
source $SOURCE_FOLDER/.zshrc
fi

# Fish
if [[ "$FISH" ]] && [[ -f $SOURCE_FOLDER/.config.fish ]]; then
source $SOURCE_FOLDER/.config.fish
fi

#### NOTE!  Zsh doesnt source this file for  shells.
#          Fish doesnt source this file at all.
# ZSH: source this by adding below to your .zprofile:
# [[ -f ~/.profile ]] && emulate sh -c 'source ~/.profile'
# FISH: source this by adding below to your . :
# [[ -f ~/.profile ]] && emulate sh -c 'source ~/.profile'
