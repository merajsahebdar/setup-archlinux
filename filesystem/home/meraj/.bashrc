#
# ~/.bash_profile
#

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# source system profile
[[ -f /etc/profile ]] && . /etc/profile

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # we have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1="[\[\033[36m\]μ\[\033[00m\] \[\033[35m\]\W\[\033[00m\]]\$(git branch 2>/dev/null | grep '^*' | colrm 1 2 | xargs -I{} echo -ne '[\033[37m{}\033[00m]')# "
else
    PS1='\u@\h:\W\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \W\a\]$PS1"
    ;;
*)
    ;;
esac

# personaly prefer to define all aliases in a seperate file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

type nvim >/dev/null 2>&1 && EDITOR="nvim" || EDITOR="vim"
export EDITOR

# other stuff ...
export GPG_TTY=$(tty)
