#!/bin/sh

# Tips
YES=0
NO=1
promote_yn() {
    eval ${2}=$NO
    read -p "$1 [y/N]: " yn
    case $yn in
        [Yy]* )    eval ${2}=$YES;;
        [Nn]*|'' ) eval ${2}=$NO;;
        *)         eval ${2}=$NO;;
    esac
}

promote_yn "Have you set the best mirrors in sourcelist?" "continue"
if [ $continue -eq $NO ]; then
    exit 1
fi

# Use colors, but only if connected to a terminal, and that terminal
# supports them.
if command -v tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
fi

# Get OS name
SYSTEM=`uname -s`
INSTALL="apt-get"

# Brew
if [ "$SYSTEM" = "Darwin" ]; then
    if command -v brew >/dev/null 2>&1; then
        INSTALL=brew;
    else
        echo "${RED}Error: brew is not installed${NORMAL}" >&2
    fi
fi

# Apt-Cyg
if [ "$OSTYPE" = "cygwin" ]; then
    printf "${BLUE} ➜  Installing Apt-Cyg...${NORMAL}\n"
    if ! command -v apt-cyg >/dev/null 2>&1; then
        APTCYG=/usr/local/bin/apt-cyg
        curl -fsSL https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg > $APT_CYG
        chmod +x $APT_CYG
        INSTALL=$APT_CYG
    fi
fi

#apt/apt-get/pacman
if [ "$SYSTEM" = "Linux" ]; then
    if command -v apt >/dev/null 2>&1; then
        INSTALL="sudo apt -y "
    elif command -v apt-get >/dev/null 2>&1; then
        INSTALL="sudo apt-get -y "
    elif command -v pacman >/dev/null 2>&1; then
        INSTALL="sudo pacman -S --noconfirm "
    else
        echo "${RED}Error: unable to find apt or apt-get or pacman ${NORMAL}" >&2
    fi
fi

$INSTALL update
$INSTALL upgrade

INSTALL="$INSTALL install"

$INSTALL git
$INSTALL wget
$INSTALL curl

$INSTALL zsh
$INSTALL vim
$INSTALL tmux
$inSTALL ctags

$INSTALL python3
$INSTALL lua5.3

$INSTALL cmake
$INSTALL ripgrep
$INSTALL silversearcher-ag

$INSTALL valgrind

$INSTALL parcellite                  # clipit
$INSTALL peek
$INSTALL screenkey
$INSTALL neofetch                    # screenfetch
$INSTALL meld
$INSTALL peco
$INSTALL aspell                      # hunspell

