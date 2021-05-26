# .bashrc
# export SYSTEMD_PAGER=
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# change color when running as su
if [ "`id -u`" -eq 0 ]; then
   PS1="\n[ \[\e[1;30m\]jwoods\[\e[0m\] : \[\e[1;35m\]\h \[\e[0;33m\]\$PWD \[\e[0m\]]\n$ "
else
   PS1="\n[ \[\e[0;36m\]jwoods\[\e[0m\] : \[\e[1;35m\]\h \[\e[0;33m\]\$PWD \[\e[0m\]]\n$ "
fi

# adding /bin causes issues with buildroot
def_path=/usr/bin:/usr/sbin:/usr/local/bin:$HOME/.local/bin:/var/lib/snapd/snap/bin
PATH=$def_path

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups:erasedups
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "

# Causes bash to append to history instead of overwriting it so if you start a
# new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Color for manpages
# explicitly state manpath, seemed to be missing in centos
export MANPATH=$MANPATH:/usr/share/man
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# duh
export EDITOR='vim'

# User specific aliases and functions
export vpath=/opt/Xilinx

export vivado_path_20191=$vivado_path_20191:$vpath/SDK/2019.1/gnu/arm/lin/bin
export vivado_path_20191=$vivado_path_20191:$vpath/SDK/2019.1/bin

export vivado_path_20191=$nbsp/SDK/2019.1/gnu/aarch32/lin/gcc-arm-linux-gnueabi/bin
export vivado_path_20191=$vivado_path_20191:$vpath/SDK/2019.1/gnu/arm/lin/bin
export vivado_path_20191=$vivado_path_20191:$vpath/SDK/2019.1/bin
export vivado_path_20191=$vivado_path_20191:$vpath/Vivado/2019.1/bin
export PATH=$vivado_path_20191:$PATH

alias reload='source ~/.bashrc'
alias  vima='vim ~/.bash_aliases'
alias  vimb='vim ~/.bashrc'
alias  vimj='vim ~/.vim/colors/jordan.vim'
alias  vimv='vim ~/.vimrc'

alias mkdir='mkdir -pv'
alias    ..='cd ..'
alias   ...='cd ../..'
alias  ....='cd ../../..'
alias .....='cd ../../../..'

# Adding color
# alias ls='ls -hN   --color=auto --group-directories-first'
alias    l='ls -hN   --color=auto --group-directories-first'
alias   ll='ls -lhN  --color=auto --group-directories-first'
alias   la='ls -lahN --color=auto --group-directories-first'

alias diff='colordiff' # Spruce up the regular diff, please and thank you

[ -f ~/.bash_aliases ] && source ~/.bash_aliases
