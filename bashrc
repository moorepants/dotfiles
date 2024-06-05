# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Fixes minor spelling errors in cd pathnames.
shopt -s cdspell

# Fix minor spelling errors on word completion if the given name does not exist
# Requires bash 4 or greater
if test $BASH_VERSINFO -ge 4;
then shopt -s dirspell;
fi

# Complete hostnames after @
shopt -s hostcomplete
# Don't complete on empty lines (it hangs bash and is not very useful)
shopt -s no_empty_cmd_completion

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# tell me what branch I am on in a git repo
# and capital "W" makes it only show the current directory
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[31m\]$(__git_ps1 "(%s)")\[\033[00m\]\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\[\033[31m\]$(__git_ps1 "(%s)")\[\033[00m\]\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \R\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# add path to my bin
export PATH=$PATH:~/bin

# matlab
alias matlab='matlab -nodesktop -nosplash'

# go2
function go2-cd() {
  if type go2 &> /dev/null; then
    go2 --cd $*
  else
    \cd $*
  fi
}
# NOTE : go2 is no longer available in 20.04 LTS so I install with conda
UBUNTUVER=$(echo $(lsb_release -rs) | bc -l)
if [[ $UBUNTUVER < 20 ]]; then
  [ -e /usr/lib/go2/go2.sh ] && source /usr/lib/go2/go2.sh
else
  [ -e /home/moorepants/miniconda/lib/go2/go2.sh ] && source /home/moorepants/miniconda/lib/go2/go2.sh
fi
#alias cd='go2-cd' # caches all directorys you change to with cd

# zotero
alias zotero=/opt/zotero/zotero

# miniconda/anaconda
if [ -d $HOME/miniconda ]; then
  CONDAPATH=$HOME/miniconda
elif [ -d $HOME/miniconda3 ]; then
  CONDAPATH=$HOME/miniconda3
elif [ -d $HOME/anaconda ]; then
  CONDAPATH=$HOME/anaconda
fi
export PATH="$CONDAPATH/bin:$PATH"
alias act='source activate'
# TODO : deactvate seems to call "cd -P" and the go2 alias complains about that
# flag.
alias deact='conda deactivate'
alias condarm='conda env remove -n'
if [[ $UBUNTUVER < 20 ]] || [[ $UBUNTUVER > 22.04 ]] ; then
	eval "$(register-python-argcomplete conda)"
else
	eval "$(register-python-argcomplete3 conda)"
fi
# # complete source activate. Thanks to Paul Kienzle from NIST for the
# # suggestion.
_activate_complete ()
{
    local cur="${COMP_WORDS[COMP_CWORD]}";
    COMPREPLY=($(compgen -W "`cd $CONDAPATH/envs && ls -d *`" -- "$cur" ));
}
complete -F _activate_complete "act"

_condarm_complete ()
{
    local cur="${COMP_WORDS[COMP_CWORD]}";
    COMPREPLY=($(compgen -W "`cd $CONDAPATH/envs && ls -d *`" -- "$cur" ));
}
complete -F _condarm_complete "condarm"

# R
alias R="R --no-save"

# simbody
#export SIMBODY_HOME=/usr/local

# opensim
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/opensim/lib
#export PATH=/opt/opensim/bin:$PATH
#export OPENSIM_HOME=/opt/opensim

# ipopt
#export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:~/src/CoinIpopt/build/lib/pkgconfig
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/src/CoinIpopt/build/lib

# turns off the stupid beeping when typing in terminal? xset b off &

# some weird conda glib bug, see
# https://github.com/conda-forge/glib-feedstock/issues/19
export GIO_EXTRA_MODULES=/usr/lib/x86_64-linux-gnu/gio/modules/

alias foundry=/opt/foundryvtt/foundryvtt
