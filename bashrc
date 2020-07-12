# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

##############
# ALLIASES
##############
alias less='less -r'
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'
alias grep='grep --color=always'
alias sk_keyboard_layout='setxkbmap sk; xmodmap $HOME/.config/caps_esc_swap'
alias us_keyboard_layout='setxkbmap us; xmodmap $HOME/.config/caps_esc_swap'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# run in parallel and include all test files in t/, slow tests first
alias proveall='prove -j5 --state=slow,save -lr t/'

##############
# VARIABLES
##############
export VISUAL=vim
export EDITOR="$VISUAL"

##############
# BASH OPTIONS
##############
# for setting history length see HISTSIZE and HISTFILESIZE 
# HISTCONTROL don't put duplicate lines or lines starting with space in the history.
# see more in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000
HISTCONTROL=ignoreboth

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

##############
# PROMPTS
##############
# function parse_git_branch() {
#    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
# }

function short_path() {
        local IFS=/ P=${PWD#?} F
        for F in $P; do echo -n /${F::1}; done
        [[ $P ]] || echo -n /
        echo -n ${F:1}
}

# export PS1="[\t]\e[0;31m\$(parse_git_branch)\e[m \e[1;37m\$(short_path)\e[m \e[0;32m\u\e[m@\e[0;32m\h\e[m \e[1;37m\$\e[m "
# export PS1="[\t] \e[0;32m\u\e[m@\e[0;32m\h\e[m \e[1;37m\$\e[m "
export PS1="\u@\h \w> "                                                                                                    

###############
# PERLBREW
###############
source $HOME/perl5/perlbrew/etc/bashrc
perlbrew use perl-5.28.0

##############
# GCC 
##############
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
