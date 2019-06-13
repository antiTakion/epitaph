#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTSIZE=50000
export HISTFILESIZE=50000
export HISTCONTROL=erasedups
shopt -s histappend
eval "`dircolors -b`"

alias ls='ls --color=auto'
PS1='\u@\h \W$ '

(cat /home/takion/.cache/wal/sequences &)

#(wal -r -t  &)
#. /home/takion/.local/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
