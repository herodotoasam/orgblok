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
alias bac='cat ~/donweb.txt && scp -P 5088 root@179.43.127.47:/root/backup.sql ~/backup.sql && tar cvfz bac`date +%F`.tar.gz backup.sql'
alias fl='cd ~/fl5 && source .venv/bin/activate && flask run'
alias ll='ls -latr'
alias xm='xmodmap .Xmodmap'
alias em='emacsclient --alternate-editor vi'
alias mirror='cd ~/fl5 && git push --mirror git@bitbucket.org:pyrx/fl5.git && cd ~/.emacs.d/ && git push --mirror git@bitbucket.org:pyrx/emacs.git && cd ~/.password-store/ && git push --mirror git@bitbucket.org:pyrx/pass.git && mirrororg'
alias mirrororg='cd ~/orgblok/ && git push --mirror git@bitbucket.org-org:herodotoasam/orgblok.git && cd ~/fl5/ && git push --mirror git@bitbucket.org-org:herodotoasam/fl5.git && cd ~/.emacs.d/ && git push --mirror git@bitbucket.org-org:herodotoasam/emacs.git && cd ~/.password-store/ && git push --mirror git@bitbucket.org-org:herodotoasam/pass.git'

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
