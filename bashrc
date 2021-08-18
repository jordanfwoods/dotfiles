# .bashrc
# export SYSTEMD_PAGER=
# Uncomment the following line if you don't like systemctl's auto-paging feature
# export SYSTEMD_PAGER=

# Update bash prompt to look pretty.
PS1=""                                   # Newline in default color
# change color when running as su
if [ "`id -u`" -eq 0 ]; then
   PS1="$PS1\[\e[1;31m\]\u\[\e[0m\] "    # display username in bold red
else
   PS1="$PS1\[\e[1;34m\]\u\[\e[0m\] "    # display username in bold blue
fi
PS1="$PS1\[\e[38;5;231m\]:\[\e[0m\] "    # colon separator in bold white
PS1="$PS1\[\e[1;35m\]\h\[\e[0m\] "       # Display hostname in bold purple
if [ -z ${DISP_PATH+x} ]; then
  PS1="$PS1\[\e[1;33m\]\$PWD\[\e[0m\] "  # display full pathname in gold
else
  PS1="$PS1\[\e[1;33m\]\W\[\e[0m\] "     # display full pathname in gold
fi
PS1="$PS1\n$ "                           # newline, and '$ ' in defaut color

# adding /bin causes issues with buildroot
def_path=/usr/bin:/usr/sbin:/usr/local/bin:$HOME/.local/bin:/var/lib/snapd/snap/bin
PATH=$def_path

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups:erasedups
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "

# Causes bash to append to history instead of overwriting it so if you start a
# new terminal, you have old session history
shopt -s histappend
# check for SVN / GIT statuses
if [ -z ${SVN_PROMPT+x} ]; then
  export PROMPT_COMMAND="echo \"\""
else
  PROMPT_COMMAND="/home/jwoods/junk/jordanfwoods/dotfiles/svnprompt.pl"
  export PROMPT_COMMAND="/home/jwoods/junk/jordanfwoods/dotfiles/gitprompt.pl;$PROMPT_COMMAND"
fi
# export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# PROMPT_COMMAND='~/junk/personal/NG/git/gitprompt.pl'

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

# assuming Vivado/SDK tools installed to /opt/Xilinx
export vpath=/opt/Xilinx
export vivado_path_20182=$vpath/SDK/2018.2/gnu/aarch32/lin/gcc-arm-linux-gnueabi/bin
export vivado_path_20182=$vivado_path_20182:$vpath/SDK/2018.2/gnu/arm/lin/bin
export vivado_path_20182=$vivado_path_20182:$vpath/SDK/2018.2/bin
export vivado_path_20182=$vivado_path_20182:$vpath/Vivado/2018.2/bin
export PATH=$vivado_path_20182:$PATH

# make updating the terminal and editing rc files easy.
alias reload='source ~/.bashrc'
alias     pp='if [ -z ${DISP_PATH+x} ]; then DISP_PATH="SET"; else unset DISP_PATH; fi; reload'
alias   svnp='if [ -z ${SVN_PROMPT+x} ]; then SVN_PROMPT="SET"; else unset SVN_PROMPT; fi; reload'
alias   vima='vim ~/.bash_aliases'
alias   vimb='vim ~/.bashrc'
alias   vimv='vim ~/.vimrc'

# abbreviate common directory commands
alias  mkdir='mkdir -pv'
alias     ..='cd ..'
alias    ...='cd ../..'
alias   ....='cd ../../..'
alias  .....='cd ../../../..'
alias ......='cd ../../../../..'

# Adding color and auto sorting common 'ls' commands
alias      l='ls -hNv   --color=auto --group-directories-first'
alias     ll='ls -lhNv  --color=auto --group-directories-first'
alias     la='ls -lahNv --color=auto --group-directories-first'

# SVN Commands to make it more like git
# svn add - begins tracking file. svn_add makes changelist act like staging area
alias svnadd='svn cl staging_area'
alias  svnci='svn ci --cl staging_area -m'

# Misc commands that are helpful
# Xilinx DocNav shortcut
alias docnav='/opt/Xilinx/DocNav/docnav'
# Spruce up the regular diff, please and thank you
alias   diff='colordiff'
# shortcuts for the basic calculator and Binary calc.
alias  gcalc='gnome-calculator --mode=basic'
alias  gcpro='gnome-calculator --mode=programming'
# common shortcut for screenshotting.
alias scnsht='gnome-screenshot --clipboard --area'

[ -f ~/.bash_aliases ] && source ~/.bash_aliases
