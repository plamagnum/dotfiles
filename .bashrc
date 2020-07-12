#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#GIT
source /usr/share/git/completion/git-prompt.sh

#functions git
get_sha() {
      git rev-parse --short HEAD 2>/dev/null
} 

#Rails
#rails_version() {
#	rails=$(rails --version | grep '^Rails [0-9]')
#	if [ "$?" == "0" ]; then
#		echo $rails
#	else
#		echo "No rails"
#	fi
#}

mping(){ ping $@|awk -F[=\ ] '/time=/{t=$(NF-1);f=2000-14*log(t^18);c="play -q -n synth 1 pl "f"&";print $0;system(c)}';}

export EDITOR=emacs

function phpbrew_current_php_version() {
  if type "php" > /dev/null; then
    local version=$(php -v | grep -E "PHP [57]" | sed 's/.*PHP \([^-]*\).*/\1/' | cut -c 1-6)
    if [[ -z "$PHPBREW_PHP" ]]; then
      echo "php:$version-system"
    else
      echo "php:$version-phpbrew"
    fi
  else
     echo "php:not-installed"
  fi
}

alias ls='ls --color=auto'
alias la='ls -la'
#PS1='[\u@\h \W]\$ '

#Mysql
export MYSQL_PS1="(\u@\h) [\d]> "


#case "`id -u`" in


#1000)PS1='[\[\e[1;36m\]\u\[\e[m\]]-[\[\e[1;37m\]\h\[\e[m\]]-[\[\e[1;31m\]Ruby-$(ruby -e "print RUBY_VERSION")\[\e[m\]]-[\[\e[1;35m\]$(rails_version)\[\e[m\]] \[\e[1;37m\]\w\[\e[m\]\n$(__git_ps1 "[\[\e[4;32m\]%s $(get_sha)\[\e[m\]]")$ > '
#		 ;;
#	0)PS1='[\[\e[1;31m\]\u\[\e[m\]]-[\[\e[1;37m\]\h\[\e[m\]]-[\[\e[1;31m\]Ruby-$(ruby -e "print RUBY_VERSION")\[\e[m\]]-[\[\e[1;35m\]$(rails_version)\[\e[m\]] \[\e[1;37m\]\w\[\e[m\]\n$(__git_ps1 "[\[\e[4;32m\]%s $(get_sha)\[\e[m\]]")$ > '
#	     ;;
#	993)PS1='[\[\e[1;31m\]\u\[\e[m\]]-[\[\e[1;37m\]\h\[\e[m\]]-[\[\e[1;31m\]Ruby-$(ruby -e "print RUBY_VERSION")\[\e[m\]]-[\[\e[1;35m\]$(rails_version)\[\e[m\]] \[\e[1;37m\]\w\[\e[m\]\n$(__git_ps1 "[\[\e[4;32m\]%s $(get_sha)\[\e[m\]]")$ > '
#	     ;;
#esac

case "`id -u`" in
	#1000)PS1='[\[\e[1;36m\]\u\[\e[m\]]-[\[\e[1;37m\]\h\[\e[m\]]-[\[\e[1;31m\]Ruby-$(ruby -e "print RUBY_VERSION")\[\e[m\]] \[\e[1;37m\]\w\[\e[m\]\n$(__git_ps1 "[\[\e[4;32m\]%s $(get_sha)\[\e[m\]]")$ > '
	1000)PS1='[\[\e[1;36m\]\u\[\e[m\]]-[\[\e[1;37m\]\h\[\e[m\]]-[\[\e[1;31m\]Ruby-$(ruby -e "print RUBY_VERSION")\[\e[m\]] \[\e[1;37m\]\w\[\e[m\]\n$(__git_ps1 "[\[\e[4;32m\]%s $(get_sha)\[\e[m\]]")$(phpbrew_current_php_version) > '	 
		 ;;
	0)PS1='[\[\e[1;31m\]\u\[\e[m\]]-[\[\e[1;37m\]\h\[\e[m\]]-[\[\e[1;31m\]Ruby-$(ruby -e "print RUBY_VERSION")\[\e[m\]]-[\[\e[1;35m\]$(~/.rvm/bin/rvm-prompt v)\[\e[m\]] \[\e[1;37m\]\w\[\e[m\]\n$(__git_ps1 "[\[\e[4;32m\]%s $(get_sha)\[\e[m\]]")$ > '
	     ;;
	993)PS1='[\[\e[1;31m\]\u\[\e[m\]]-[\[\e[1;37m\]\h\[\e[m\]]-[\[\e[1;31m\]Ruby-$(ruby -e "print RUBY_VERSION")\[\e[m\]]-[\[\e[1;35m\]$(~/.rvm/bin/rvm-prompt v)\[\e[m\]] \[\e[1;37m\]\w\[\e[m\]\n$(__git_ps1 "[\[\e[4;32m\]%s $(get_sha)\[\e[m\]]")$ > '
	     ;;
esac


export TERM="screen-256color"
#export TERM="xterm-256color emacs -nw"


#Emacs
alias emacs='emacs -nw'
alias semacs='sudo emacs -nw'
#Fetch
alias fetch='~/screenfetch-dev'
#WWW
alias first='cd /srv/http/first && clear'
alias blog='cd /srv/http/blog && clear'
alias farm='cd /srv/http/farm && vim'
alias geo='cd /srv/http/geo && clear'
alias geotest='cd /srv/http/geotest && clear'
alias second='cd /srv/http/second && clear'
alias gitlab='cd /home/gitlab/gitlabhq/lib/support/init.d && clear'
alias fr='cd /srv/http/firstror && clear'
alias p='cd ~/pentest && clear'
alias ht='cd /srv/http && clear'
alias ib='cd ~/irc-bot && clear'
alias dl='cd ~/docker-lamp && clear'

alias i3='vim .config/i3/config'
alias aw='cd ~/.config/awesome && vim rc.lua'
#alias viper='python ~/pentest/viper/viper-cli'
alias errt='multitail -f -cS apache_error /var/log/httpd/error_log'
alias dev='cd ~/develop && clear'
alias news='newsboat'


#Julia
alias q='emacs ~/q.org'

#Texts
alias www='cd ~/www && clear && vim'

#Films_list
alias f='emacs ~/films.org'

#i2pd
alias i2pd='cd /usr/local/bin/ && ./i2pd'

#Mind
alias mind='emacs ~/mind.org'

#Besiege
alias besiege='cd ~/games/Besiege && ./Besiege.x86_64'

#Minecraft
alias ms='cd ~/games/spigot && java -jar spigot-1.10.2.jar'
alias minecraft='cd ~/games && java -jar tlauncher-2.04_beta.jar'

#RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

PATH="/home/mark/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/mark/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/mark/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/mark/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/mark/perl5"; export PERL_MM_OPT;

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="/home/mark/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

#pyenv
export PATH="/home/mark/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

#py
export PATH="home/mark/.local/bin:$PATH"

#laravel
export PATH="/home/mark/.config/composer/vendor/bin:$PATH"

#go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH="$PATH:$GOBIN"

#pyro
export PATH=$PATH:/home/mark/lib/pyroscope/bin/

#java
#export _JAVA_AWT_WM_NONREPARENTING=1

#phpbrew
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc
#export PHPBREW_SET_PROMPT=1
#export PHPBREW_RC_ENABLE=1

[[ -s "/home/mark/.gvm/scripts/gvm" ]] && source "/home/mark/.gvm/scripts/gvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
