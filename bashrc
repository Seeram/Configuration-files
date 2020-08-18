# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

##############
# HOST SPECIFIC
##############
# stuff useless to have everywhere, e.g. specific filepaths
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

export NUMBER_OF_CORES=6
export DEFAULT_PERLBREW_PERL_VERSION='perl-5.16.3'

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

# run in parallel and include all test files in t/, slow tests first
alias proveall="prove -j $NUMBER_OF_CORES --state=slow,save -lr t/"

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
export PS1="\u@\h \w> "

###############
# PERLBREW
###############
source $HOME/perl5/perlbrew/etc/bashrc
perlbrew use $DEFAULT_PERLBREW_PERL_VERSION

##############
# GCC
##############
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
