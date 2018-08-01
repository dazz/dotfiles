# If you come from bash you might have to change your $PATH.

export PATH=$HOME/.composer/vendor/bin:$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/dazz/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )


#-----------------------------------------------------------------------------
# Source this file after save :)
#-----------------------------------------------------------------------------

alias resource='source ~/.zshrc'
alias aliases='vim ~/.zshrc && source ~/.zshrc'

#-----------------------------------------------------------------------------
# Functions
#-----------------------------------------------------------------------------

# http://onethingwell.org/post/758016936/one-thing-todo
t() {
    if [[ "$*" == "" ]] ; then
        cat ~/.todo
    else
        echo "$*" > ~/.todo
    fi
}

# http://askubuntu.com/questions/89710/how-do-i-free-up-more-space-in-boot
do-remove-old-releases() {
    kernelver=$(uname -r | sed -r 's/-[a-z]+//')
    dpkg -l linux-{image,headers}-"[0-9]*" | awk '/ii/{print $2}' | grep -ve $kernelver
    #sudo apt-get purge $(dpkg -l linux-{image,headers}-"[0-9]*" | awk '/ii/{print $2}' | grep -ve "$(uname -r | sed -r 's/-[a-z]+//')")
}

# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$@"
}

function xtree {
    find ${1:-.} -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}

#-----------------------------------------------------------------------------
# Software & Updates
#-----------------------------------------------------------------------------

alias install='sudo apt install'
alias search='echo "apt-cache search" && apt-cache search'
alias update='sudo apt update'
alias updatable='apt list --upgradable | less -R'
alias upgrade='sudo apt upgrade'
alias goodmorning='sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo apt-get autoclean; composer selfupdate && composer global update'
alias update-repos='cd && mr update && cd ${PWD} && composer selfupdate'

#-----------------------------------------------------------------------------
# Aaaaall my shortcuts
#-----------------------------------------------------------------------------

alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -lFh --color=always'
alias la='ls -AF'
alias lh='ls -lah'
alias l='ls -CF'
alias l.='ls -ld .*'
alias lr='ls -r'
alias lt='ls -t'
alias lrt='ls -rt'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias ..='cd ..;'
alias ...='cd ../..;'
alias .4='cd ../../..;'
alias .5='cd ../../../..;'
alias man="man -a"
alias df='df --human-readable'
alias du='du --human-readable'

alias back='cd $OLDPWD'
alias openports="netstat -nape --inet"
alias myip="curl www.whatismyip.org"
alias ping='ping -c 10 -a'
alias ports='netstat -tulanp'

alias h='history | grep $1' # in this manner, a nice command:  h <searchterm>


alias git_clean='git branch --merged | grep -v "\*" | grep -v master | grep -v dev | xargs -n 1 git branch -d'
alias gg='gitg'

## pass options to free ## 
alias meminfo='free -m -l -t'
 
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
 
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
 
## Get server cpu info ##
alias cpuinfo='lscpu'

#------
# l'admin
#------
alias tails='sudo tail -f /var/log/syslog'

#-----------------------------------------------------------------------------
# start autocomplete for command line
#-----------------------------------------------------------------------------
autoload -U promptinit compinit
promptinit
compinit
prompt bart

#source ~/.convox/completion.bash

#-----------------------------------------------------------------------------
# ZSH
#-----------------------------------------------------------------------------

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colorize wd dircycle docker docker-compose)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"
