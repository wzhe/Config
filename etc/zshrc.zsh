# Zsh configuration

ANTIGEN=$HOME/.antigen
DOTFILES=$HOME/.dotfiles

# Configure Antigen
declare -a ANTIGEN_CHECK_FILES
ANTIGEN_CHECK_FILES=($HOME/.zshrc $HOME/.zshrc.local)

# Load Antigen
if [[ $OSTYPE == darwin* ]]; then
    source /usr/local/share/antigen/antigen.zsh
else
    if command -v apt-get >/dev/null 2>&1; then
        source /usr/share/zsh-antigen/antigen.zsh
    elif command -v yaourt >/dev/null 2>&1; then
        source /usr/share/zsh/share/antigen.zsh
    else
        source $ANTIGEN/antigen.zsh
    fi
fi

# Load the oh-my-zsh's library
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle common-aliases
antigen bundle git
antigen bundle colored-man-pages
antigen bundle extract
antigen bundle sudo
antigen bundle z

# Misc bundles.
antigen bundle djui/alias-tips
[[ $OSTYPE != cygwin* ]] && antigen bundle andrewferrier/fzf-z
if command -v fdfind >/dev/null 2>&1; then
    alias fd='fdfind';
fi

# OS bundles
if [[ $OSTYPE == darwin* ]]; then
    antigen bundle osx
    if command -v brew >/dev/null 2>&1; then
        alias bu='brew upgrade --cleanup'
        alias bcu='brew cu --all --yes --no-brew-update --cleanup'
        alias bua='bu && bcu'
    fi
elif [[ $OSTYPE == linux* ]]; then
    if command -v apt-get >/dev/null 2>&1; then
        antigen bundle ubuntu
        alias agua='aguu -y && agar -y && aga -y'
        alias kclean+='sudo aptitude remove -P "?and(~i~nlinux-(ima|hea),\
                            ?not(?or(~n`uname -r | cut -d'\''-'\'' -f-2`,\
                            ~nlinux-generic,\
                            ~n(linux-(virtual|headers-virtual|headers-generic|image-virtual|image-generic|image-`dpkg --print-architecture`)))))"'
    elif command -v pacman >/dev/null 2>&1; then
        antigen bundle archlinux
    fi
fi

# antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zdharma/fast-syntax-highlighting
# antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle hlissner/zsh-autopair

# Load the theme.
antigen theme ys            # ys, dst, steeef, wedisagree, robbyrussell

# Local customizations, e.g. theme, plugins, aliases, etc.
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local

# Tell Antigen that you're done
antigen apply

# Completion enhancements
source $DOTFILES/completion.zsh

# Load FZF
if [[ $OSTYPE == cygwin* ]]; then
    [ -f /etc/profile.d/fzf.zsh ] && source /etc/profile.d/fzf.zsh;
else
    [ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh;
fi
if command -v rg >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='rg --hidden --files'
elif command -v ag >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='ag -U --hidden -g ""'
fi
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

#
# Aliases
#
unalias fd

# General
alias zshconf="$EDITOR $HOME/.zshrc; $EDITOR $HOME/.zshrc.local"
alias h='history'
alias c='clear'
alias rt='trash'                # `brew install trash` or `npm install --global trash-cli`

alias gtr='git tag -d $(git tag) && git fetch --tags' # Refresh local tags from remote

if [[ $OSTYPE == darwin* ]]; then
    command -v gls >/dev/null 2>&1 && alias ls='gls --color=tty --group-directories-first'
else
    alias ls='ls --color=tty --group-directories-first'
fi

# Emacs
alias emacs='emacsclient -a ""'
alias e='emacs -n'
alias ec='emacs -c'
alias ef='emacs -n -c'
alias te='emacs -nw'
alias rmelc='rm -f $HOME/.emacs.d/lisp/*.elc'
alias rmtags='rm -f GTAGS; rm -f GRTAGS; rm -f GPATH; rm -f TAGS'
alias restart_emacs='emacsclient -e "(let ((last-nonmenu-event nil) (kill-emacs-query-functions nil)) (save-buffers-kill-emacs t))" && te'

# Upgrade
alias upgrade_repo='git pull --rebase --stat origin master'
alias upgrade_dotfiles='cd $DOTFILES && upgrade_repo; cd - >/dev/null'
alias upgrade_emacs='cd $HOME/.emacs.d && upgrade_repo; cd - >/dev/null'
alias upgrade_oh_my_tmux='cd $HOME/.tmux && upgrade_repo; cd - >/dev/null'
alias upgrade_env='upgrade_dotfiles && sh $DOTFILES/install.sh'

if [[ $OSTYPE == darwin* ]]; then
    (( $+commands[brew] )) && alias upgrade_antigen='brew update antigen'
    alias upgrade_brew_cask='$DOTFILES/install_brew_cask.sh'
elif [[ $OSTYPE == linux* ]]; then
    # (( $+commands[apt-get] )) && apug -y antigen
    alias upgrade_antigen='sudo curl -o /usr/share/zsh-antigen/antigen.zsh -sL git.io/antigen'
else
    alias upgrade_antigen='curl -fsSL git.io/antigen > $ANTIGEN/antigen.zsh.tmp && mv $ANTIGEN/antigen.zsh.tmp $ANTIGEN/antigen.zsh'
fi

# Proxy
PROXY=http://127.0.0.1:1087
SOCK_PROXY=socks5://127.0.0.1:1086
NO_PROXY=10.*.*.*,192.168.*.*,*.local,localhost,127.0.0.1
alias showproxy='echo "proxy=$http_proxy"'
alias setproxy='export http_proxy=$PROXY; export https_proxy=$PROXY; export no_proxy=$NO_PROXY; showproxy'
alias unsetproxy='export http_proxy=; export https_proxy=; export no_proxy=; showproxy'
alias toggleproxy='if [ -n "$http_proxy" ]; then unsetproxy; else setproxy; fi'
alias set_sock_proxy='export http_proxy=$SOCK_PROXY; export https_proxy=$SOCK_PROXY; export no_proxy=$NO_PROXY; showproxy'
alias unset_sock_proxy=unsetproxy
alias toggle_sock_proxy='if [ -n "$http_proxy" ]; then unset_sock_proxy; else set_sock_proxy; fi'
alias ag='command ag'
