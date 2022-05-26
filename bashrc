# .bashrc
# export SYSTEMD_PAGER=
# Uncomment the following line if you don't like systemctl's auto-paging feature
# export SYSTEMD_PAGER=

##############################
## PROMPT COMMAND

# check for SVN / GIT statuses
if [ -z ${BRANCH_PROMPT+x} ]; then
  export PROMPT_COMMAND=""
else
  PROMPT_COMMAND="/home/jwoods/junk/dotfiles/svnprompt.pl"
  PROMPT_COMMAND="/home/jwoods/junk/dotfiles/gitprompt.pl;$PROMPT_COMMAND"
  # export PROMPT_COMMAND="echo '';$PROMPT_COMMAND"
  export PROMPT_COMMAND="$PROMPT_COMMAND"
fi

# export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# PROMPT_COMMAND='~/junk/personal/NG/git/gitprompt.pl'

##############################
## BASH PROMPT CONFIGURATION

# Update bash prompt to look pretty.
PS1=""                                   # Currently no Newline in default color
# change color when running as su
if [ "`id -u`" -eq 0 ]; then
   PS1="$PS1\[\e[1;31m\]\u\[\e[0m\] "    # display username in bold red
else
   PS1="$PS1\[\e[1;34m\]\u\[\e[0m\] "    # display username in bold blue
fi
PS1="$PS1\[\e[38;5;231m\]:\[\e[0m\] "    # colon separator in bold white
PS1="$PS1\[\e[1;35m\]\h\[\e[0m\] "       # Display hostname in bold purple
if [ -z ${PATH_PROMPT+x} ]; then
  PS1="$PS1\[\e[1;33m\]\W\[\e[0m\]"      # display current directory in gold
else
  PS1="$PS1\[\e[1;33m\]\$PWD\[\e[0m\]"   # display full pathname in gold
fi
if [ -z ${PROMPT1+x} ]; then
  PS1="$PS1 $ "                          # no newline, but '$ ' in defaut color
else
  PS1="$PS1\n$ "                         # newline, and '$ ' in defaut color
fi

##############################
## HISTORY / WIN SIZE CONFIG

# Causes bash to append to history instead of overwriting it so if you start a
# new terminal, you have old session history
shopt -s histappend

# adding /bin causes issues with buildroot
def_path=/usr/bin:/usr/sbin:/usr/local/bin:$HOME/.local/bin:/var/lib/snapd/snap/bin
PATH=$def_path

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups:erasedups
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

##############################
## MAN CONFIGURATION

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

##############################
## BC CONFIGURATION (The simplest calc available)

# Ensure that the math library is used (for sine, cosine, etc).
# remember the special variables: scale, last, ibase, and obase
alias bc="BC_ENV_ARGS=<(echo \"pi=4*a(1);scale=6\") \bc -l"

##############################
## VIM CONFIGURATION

# duh
export EDITOR='vim'

##############################
## VIVADO CONFIGURATION

# assuming Vivado/SDK tools installed to /opt/Xilinx
export vpath=/opt/Xilinx
export vivado_path_20182=$vpath/SDK/2018.2/gnu/aarch32/lin/gcc-arm-linux-gnueabi/bin
export vivado_path_20182=$vivado_path_20182:$vpath/SDK/2018.2/gnu/arm/lin/bin
export vivado_path_20182=$vivado_path_20182:$vpath/SDK/2018.2/bin
export vivado_path_20182=$vivado_path_20182:$vpath/Vivado/2018.2/bin
export PATH=$PATH:/opt/Xilinx/SDK/2018.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/
export PATH=$PATH:/opt/Xilinx/SDK/2018.2/gnu/aarch32/lin/gcc-arm-none-eabi/arm-none-eabi/bin/
export PATH=$vivado_path_20182:$PATH

# Vivado License
export LM_LICENSE_FILE=2100@hyperlynxlsvm.spacemicro.com 

##############################
## ALIASES

# quit should equal exit ...
alias quit='exit'
# make updating the terminal and editing rc files easy.
alias reload='source ~/.bashrc'

# Toggle between full path length, and current directory only in bash prompt
alias     pp='if [ -z ${PATH_PROMPT+x} ]; then PATH_PROMPT="SET"; else unset PATH_PROMPT; fi; reload'
# Toggle on/off seeing the branch name / changes in bash prompt 
alias     bp='if [ -z ${BRANCH_PROMPT+x} ]; then BRANCH_PROMPT="SET"; else unset BRANCH_PROMPT; fi; reload'
# Toggle on/off the bash prompt spanning 2 lines
alias     1p='if [ -z ${PROMPT1+x} ]; then PROMPT1="SET"; else unset PROMPT1; fi; reload'
# Toggle all
alias      p='pp && bp && 1p'

# vim aliases that are frequently used.
alias  vima='vim ~/.bash_aliases'
alias  vimb='vim ~/.bashrc'
alias  vimv='vim ~/.vimrc'
alias  vimt='vim ~/.tmux.conf'
alias vimtt='vim ~/.tmux/tmux-theme.conf'
alias vimto='vim ~/junk/personal/doc/to-do.rst'

# abbreviate common directory commands
alias  mkdir='mkdir -pv'
alias     ..='cd ..'
alias    ...='cd ../..'
alias   ....='cd ../../..'
alias  .....='cd ../../../..'
alias ......='cd ../../../../..'

# Adding color and auto sorting common 'ls' commands
alias      l='/bin/ls -hNv   --color=auto --group-directories-first'
alias     ll='/bin/ls -lhNv  --color=auto --group-directories-first'
alias     la='/bin/ls -lahNv --color=auto --group-directories-first'

# SVN Commands to make it more like git
# svn add - begins tracking file. svn_add makes changelist act like staging area
alias svnadd='svn cl staging_area'
alias  svnci='svn ci --cl staging_area -m'

# Misc commands that are helpful
# Xilinx DocNav shortcut
alias docnav='/opt/Xilinx/DocNav/docnav'
# Spruce up the regular diff, please and thank you
alias   diff='colordiff'
# common shortcut for screenshotting.
alias scnsht='gnome-screenshot --clipboard --area'

# remote logout command is pkill if using cinnamon...
if [ -z ${XRDP_SESSION+x} ] || [ $(head -n 1 ~/.Xclients) == "gnome-session" ]; then
  alias logoff='gnome-session-quit --logout'
else
  alias logoff='pkill -u jwoods'
fi

alias octave='/usr/bin/flatpak run --branch=stable --arch=x86_64 \
--command=/app/bin/octave --file-forwarding org.octave.Octave --gui &'
##############################
## SOURCE BASH ALIASES

[ -f ~/.bash_aliases ] && source ~/.bash_aliases
