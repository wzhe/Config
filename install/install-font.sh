#!/bin/bash

source install-pre.sh

function check {
    if ! command -v git >/dev/null 2>&1; then
        echo "${RED}Error: git is not installed${NORMAL}" >&2
        exit 1
    fi
    if [ "$OSTYPE" = "cygwin" ]; then
        echo "${RED}Error: Cygwin is not supported${NORMAL}" >&2
        exit 1
    fi
}

function install {
    printf "${BLUE} ➜  Installing fonts...${NORMAL}\n"

    if [ "$SYSTEM" = "Darwin" ]; then
        # macOS
        font_dir="$HOME/Library/Fonts"

        fonts=(
            font-source-code-pro
            # font-dejavu-sans
            font-inconsolata
            font-hack-nerd-font

            font-wenquanyi-micro-hei
            font-wenquanyi-micro-hei-lite
            font-wenquanyi-zen-hei
        )

        if [ ! -f "${font_dir}/SourceCodePro-Regular.otf" ]; then
            for f in ${fonts[@]}; do
                brew cask install ${f}
            done
        fi
        brew cask cleanup
    elif [ "$SYSTEM" = "Linux" ]; then
        # Linux
        font_dir="$HOME/.local/share/fonts"
        mkdir -p $font_dir

        # Source Code Pro
        if [ ! -f "${font_dir}/SourceCodePro-Regular.otf" ]; then
            sync_repo adobe-fonts/source-code-pro $font_dir/source-code-pro release
            echo "Copying fonts..."
            find "$font_dir/source-code-pro" \( -name "$prefix*.[ot]tf" -or -name "$prefix*.pcf.gz" \) -type f -print0 | xargs -0 -n1 -I % cp "%" "$font_dir/"
            rm -rf $font_dir/source-code-pro
            fc-cache -f $font_dir
        fi

        if command -v apt-get >/dev/null 2>&1; then
            # Ubuntu/Debian
            fonts=(
                fonts-hack-ttf
                fonts-powerline
                fonts-wqy-microhei
                fonts-wqy-zenhei
                ttf-mscorefonts-installer
            )

            for f in ${fonts[@]}; do
                sudo apt-get upgrade -y ${f}
            done
        else
            if [ ! -f "${font_dir}/Hack Regular Nerd Font Complete.ttf" ]; then
                sh -c "$(curl -fsSL https://github.com/ryanoasis/nerd-fonts/raw/master/install.sh) Hack"
            fi
        fi
    fi
}

function main {
    check
    install
}

main
