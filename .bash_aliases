# specify the dir name of the project
project_dir_name='playground'
project_path='/var/www'
own_user='vagrant'
www_group='www-data'

# the dummy access to the mysql
alias mysql_vagrant='mysql --user=root -p<your-password>'

# symfony-dev aliases
alias composer='php composer.phar'
alias symfony='php app/console'

# go to project
alias go='cd $project_path/$project_dir_name/'
alias go-symfony='go;symfony'

# symfony cache clear
alias symfony-cc='symfony cache:clear'

# delete cache dir content
alias symfony-cd='sudo rm -Rf $project_path/$project_dir_name/app/cache/*'

# build bootstrap run in project-dir
alias symfony-build_bootstrap='./vendor/sensio/distribution-bundle/Sensio/Bundle/DistributionBundle/Resources/bin/build_bootstrap.php'

# make cache writeable
alias symfony-cw='sudo chmod -R 777 $project_path/$project_dir_name/app/cache'

# make log files writable
alias symfony-lw='sudo chmod -R 777 $project_path/$project_dir_name/app/logs'

# make all the files owned by user vagrant and group www-data
alias symfony-own="sudo chown -R $own_user:$www_group $project_path/$project_dir_name/*"


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# standard aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'

# write our own PS1
#    \d – Current date
#    \t – Current time
#    \h – Host name
#    \# – Command number
#    \u – User name
#    \W – Current working directory (ie: Desktop/)
#    \w – Current working directory, full path (ie: /Users/Admin/Desktop)

export PS1='\[\e[0;32;40m\][\#][\t][\w]\e[0m $ '

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=ignoredups
export HISTSIZE=100000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize
