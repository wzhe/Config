#----------------------------------------------------------------------
# Initialize environment and alias
#----------------------------------------------------------------------
alias ls='ls --color'
alias ll='ls -lh'
alias la='ls -lAh'
alias grep='grep --color=tty'
alias nvim='/usr/local/opt/bin/vim --cmd "let g:vim_startup=\"nvim\""'
alias mvim='/usr/local/opt/bin/vim --cmd "let g:vim_startup=\"mvim\""'
alias tmux='tmux -2'
alias vim="vim -X"
#alias emacs="emacs -nw"

# default editor
export EDITOR=vim

if [ "$TERM" == "xterm" ]; then
	export TERM=xterm-256color
fi

# disable ^s and ^q
# stty -ixon 2> /dev/null

# setup for cheat
if [ -d "$HOME/.vim/vim/cheat" ]; then
	export DEFAULT_CHEAT_DIR=~/.vim/vim/cheat
fi


#----------------------------------------------------------------------
# exit if not bash/zsh, or not in an interactive shell
#----------------------------------------------------------------------
[ -z "$BASH_VERSION" ] && [ -z "$ZSH_VERSION" ] && return
#[[ $- != *i* ]] && return


#----------------------------------------------------------------------
# keymap
#----------------------------------------------------------------------



#----------------------------------------------------------------------
# https://github.com/rupa/z
#----------------------------------------------------------------------
if command -v lua>/dev/null 2>&1; then
	INIT_LUA="lua"
fi
if command -v lua5.3>/dev/null 2>&1; then
	INIT_LUA="lua5.3"
fi
if [ "$INIT_LUA" ]; then
	if [ -f "$HOME/.local/bin/z.lua" ]; then
		if [ -n "$BASH_VERSION" ]; then
			eval "$($INIT_LUA $HOME/.local/bin/z.lua --init bash once)"
		elif [ -n "$ZSH_VERSION" ]; then
			eval "$($INIT_LUA $HOME/.local/bin/z.lua --init zsh once)"
		else
			eval "$($INIT_LUA $HOME/.local/bin/z.lua --init auto once)"
		fi
		alias zz='z -i'
	fi
	elif [ -f "$HOME/.local/bin/z.sh" ]; then
		if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
			. $HOME/.local/bin/z.sh
		fi
		alias zz='z'
fi

alias zc='z -c'
alias zf='cd "$(z -l -s | fzf --reverse --height 35%)"'
alias zzc='zz -c'

#----------------------------------------------------------------------
# other interactive shell settings
#----------------------------------------------------------------------
export GCC_COLORS=1
export EXECIGNORE="*.dll"
