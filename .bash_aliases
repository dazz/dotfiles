# specify the dir name of the project
project_dir_name='playground'
project_path='/var/www'
own_user='vagrant'
www_group='www-data'

# the dummy access to the mysql
alias mysql_vagrant='mysql --user=root -p<your-password>'

# composer-dev aliases
alias get-composer='curl -s http://getcomposer.org/installer | php'

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

# delete cache and make dir writable
alias symfony-cdw='symfony-cd;symfony-cw'

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

#export PS1='[\h]\[\e[0;32;40m\][\#][\t][\w]\e[0m $ '

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=ignoredups
export HISTSIZE=100000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize


function parse_git_branch {
    git rev-parse --git-dir > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        git_status="$(git status 2> /dev/null)"
        branch_pattern="^# On branch ([^${IFS}]*)"
        detached_branch_pattern="# Not currently on any branch"
        remote_pattern="# Your branch is (.*) of"
        diverge_pattern="# Your branch and (.*) have diverged"
        untracked_pattern="# Untracked files:"
        new_pattern="new file:"
        not_staged_pattern="Changes not staged for commit"

        #files not staged for commit
        if [[ ${git_status}} =~ ${not_staged_pattern} ]]; then
            state="✔"
        fi
        # add an else if or two here if you want to get more specific
        # show if we're ahead or behind HEAD
        if [[ ${git_status} =~ ${remote_pattern} ]]; then
            if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
                remote="↑"
            else
                remote="↓"
            fi
        fi
        #new files
        if [[ ${git_status} =~ ${new_pattern} ]]; then
            remote="+"
        fi
        #untracked files
        if [[ ${git_status} =~ ${untracked_pattern} ]]; then
            remote="✖"
        fi
        #diverged branch
        if [[ ${git_status} =~ ${diverge_pattern} ]]; then
            remote="↕"
        fi
        #branch name
        if [[ ${git_status} =~ ${branch_pattern} ]]; then
            branch=${BASH_REMATCH[1]}
        #detached branch
        elif [[ ${git_status} =~ ${detached_branch_pattern} ]]; then
            branch="NO BRANCH"
        fi

        echo " ( ${branch} ${state}${remote})"
    fi
    return
}

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;32m\]$(parse_git_branch)\[\033[00m\]$ '