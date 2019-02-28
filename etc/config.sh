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

# default editor
export EDITOR=vim
# export TERM=xterm-256color

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
[[ $- != *i* ]] && return


#----------------------------------------------------------------------
# keymap
#----------------------------------------------------------------------

# default bash key binding
if [ -n "$BASH_VERSION" ]; then
	bind '"\eh":"\C-b"'
	bind '"\el":"\C-f"'
	bind '"\ej":"\C-n"'
	bind '"\ek":"\C-p"'
	bind '"\eH":"\eb"'
	bind '"\eL":"\ef"'
	bind '"\eJ":"\C-a"'
	bind '"\eK":"\C-e"'
	bind '"\e;":"ll\n"'
elif [ -n "$ZSH_VERSION" ]; then
	bindkey -s '\e;' 'll\n'
	bindkey -s '\eu' 'ranger_cd\n'
fi


#----------------------------------------------------------------------
# https://github.com/rupa/z
#----------------------------------------------------------------------
if [ -z "$DISABLE_Z_PLUGIN" ]; then
	if [ -x "$INIT_LUA" ] && [ -f "~/.local/bin/z.lua" ]; then
		if [ -n "$BASH_VERSION" ]; then
			eval "$($INIT_LUA ~/.local/bin/z.lua --init bash once)"
		elif [ -n "$ZSH_VERSION" ]; then
			eval "$($INIT_LUA ~/.local/bin/z.lua --init zsh once)"
		else
			eval "$($INIT_LUA ~/.local/etc/z.lua --init auto once)"
		fi
		alias zz='z -i'
	elif [ -f "~/.local/bin/z.sh" ]; then
		if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
			. "~/.local/bin/z.sh"
		fi
		alias zz='z'
	fi
fi

alias zc='z -c'
alias zf='cd "$(z -l -s | fzf --reverse --height 35%)"'
alias zzc='zz -c'

#----------------------------------------------------------------------
# other interactive shell settings
#----------------------------------------------------------------------
export GCC_COLORS=1
export EXECIGNORE="*.dll"
