# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias q='exit'
alias cd..='cd ..'
alias hl='hledger'
alias hlb='hledger balance'
alias cj='hl register assets:caja'
alias scp1='cat ~/donweb.txt && cd ~/fl5 && scp -P 5088 -r templates/ static/ *.py root@179.43.127.47:/home/app'
alias ssh1='cat ~/donweb.txt && ssh -p 5088 root@179.43.127.47'
alias bac='cat ~/donweb.txt && scp -P 5088 root@179.43.127.47:/root/backup.sql ~/backup.sql'
alias fl='cd ~/fl5 && source .venv/bin/activate && flask run'
alias ll='ls -latr'
alias xm='xmodmap .Xmodmap'
alias em='emacsclient'

if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="$HOME/.cargo/bin:$PATH"
export EDITOR=emacsclient
