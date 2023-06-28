# .bashrc
# export SYSTEMD_PAGER=
# Uncomment the following line if you don't like systemctl's auto-paging feature
# export SYSTEMD_PAGER=

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# source global definitions
[ -f /etc/bashrc ] && source /etc/bashrc

##############################
## PROMPT COMMAND

dot='/home/jwoods/junk/dotfiles/'
[[ ! -d $dot ]] && dot='/Users/jordan/sandbox/dotfiles/'

# check for SVN / GIT statuses
if [ -z ${BRANCH_PROMPT+x} ]; then
  export PROMPT_COMMAND=""
else
  PROMPT_COMMAND="$dot/svnprompt.pl"
  PROMPT_COMMAND="$dot/gitprompt.pl;$PROMPT_COMMAND"
  export PROMPT_COMMAND="$PROMPT_COMMAND"
fi

export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

##############################
## BASH PROMPT CONFIGURATION

# Update bash prompt to look pretty.
PS1=""                                   # Currently no Newline in default color
# change color when running as su
if [ "`id -u`" -eq 0 ]; then
   PS1="$PS1\[\e[1;31m\]\u\[\e[0m\] "    # display username in bold red
else
   # PS1="$PS1\[\e[0;34m\]\u\[\e[0m\] "  # display username in bold blue
   PS1="$PS1\[\e[1;34m\]\u\[\e[0m\] "    # display username in regular cyan
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
[[ $(uname -s) == "Darwin" ]] && def_path=/bin:$def_path
PATH=$def_path

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups:erasedups
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Allow for scrolling up to reverse search history.
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

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

# 2018.2
export vivado_path_20182=$vpath/SDK/2018.2/gnu/aarch32/lin/gcc-arm-linux-gnueabi/bin
export vivado_path_20182=$vivado_path_20182:$vpath/SDK/2018.2/gnu/arm/lin/bin
export vivado_path_20182=$vivado_path_20182:$vpath/SDK/2018.2/bin
export vivado_path_20182=$vivado_path_20182:$vpath/Vivado/2018.2/bin
export PATH=$PATH:/opt/Xilinx/SDK/2018.2/gnu/aarch32/lin/gcc-arm-none-eabi/bin/
export PATH=$PATH:/opt/Xilinx/SDK/2018.2/gnu/aarch32/lin/gcc-arm-none-eabi/arm-none-eabi/bin/
export PATH=$vivado_path_20182:$PATH

# 2021.1
export PATH=$PATH:/opt/Xilinx/Vitis/2021.2/bin/

# Vivado License
export LM_LICENSE_FILE=2100@hyperlynxlsvm.spacemicro.com
export XILINXD_LICENSE_FILE=2100@hyperlynxlsvm.spacemicro.com

##############################
## Janky Firefox

export PATH=/opt/firefox:$PATH

##############################
## ImageJ

export PATH=/opt/ImageJ:$PATH

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
alias vimto='vim -p ~/junk/personal/doc/main.todo ~/junk/personal/doc/daily.done ~/junk/personal/doc/weekly.done'

# abbreviate common directory commands
alias  mkdir='mkdir -pv'
alias     ..='cd ..'
alias    ...='cd ../..'
alias   ....='cd ../../..'
alias  .....='cd ../../../..'
alias ......='cd ../../../../..'

# Adding color and auto sorting common 'ls' commands
alias      l='/bin/ls -hN   --color=auto --group-directories-first'
alias     ll='/bin/ls -ohN  --color=auto --group-directories-first'
alias     l1='/bin/ls -1h   --color=auto --group-directories-first'
alias     la='/bin/ls -oahN --color=auto --group-directories-first'
unset  LS_COLORS
export LS_COLORS='rs=0:ln=38;5;51:mh=44;38;5;15:pi=40;38;5;11:so=38;5;13:do=38;5;5:'
export LS_COLORS=$LS_COLORS:'bd=48;5;232;38;5;11:cd=48;5;232;38;5;3:or=48;5;232;38;5;9:'
export LS_COLORS=$LS_COLORS:'mi=05;48;5;232;38;5;15:su=48;5;196;38;5;15:sg=48;5;11;38;5;16:'
# export LS_COLORS='rs=0:di=38;5;27:ln=38;5;51:mh=44;38;5;15:pi=40;38;5;11:so=38;5;13:do=38;5;5:bd=48;5;232;38;5;11:cd=48;5;232;38;5;3:or=48;5;232;38;5;9:mi=05;48;5;232;38;5;15:su=48;5;196;38;5;15:sg=48;5;11;38;5;16:ca=48;5;196;38;5;226:tw=48;5;10;38;5;16:ow=48;5;10;38;5;21:st=48;5;21;38;5;15:ex=38;5;34:*.tar=38;5;9:*.tgz=38;5;9:*.arc=38;5;9:*.arj=38;5;9:*.taz=38;5;9:*.lha=38;5;9:*.lz4=38;5;9:*.lzh=38;5;9:*.lzma=38;5;9:*.tlz=38;5;9:*.txz=38;5;9:*.tzo=38;5;9:*.t7z=38;5;9:*.zip=38;5;9:*.z=38;5;9:*.Z=38;5;9:*.dz=38;5;9:*.gz=38;5;9:*.lrz=38;5;9:*.lz=38;5;9:*.lzo=38;5;9:*.xz=38;5;9:*.bz2=38;5;9:*.bz=38;5;9:*.tbz=38;5;9:*.tbz2=38;5;9:*.tz=38;5;9:*.deb=38;5;9:*.rpm=38;5;9:*.jar=38;5;9:*.war=38;5;9:*.ear=38;5;9:*.sar=38;5;9:*.rar=38;5;9:*.alz=38;5;9:*.ace=38;5;9:*.zoo=38;5;9:*.cpio=38;5;9:*.7z=38;5;9:*.rz=38;5;9:*.cab=38;5;9:*.jpg=38;5;13:*.jpeg=38;5;13:*.gif=38;5;13:*.bmp=38;5;13:*.pbm=38;5;13:*.pgm=38;5;13:*.ppm=38;5;13:*.tga=38;5;13:*.xbm=38;5;13:*.xpm=38;5;13:*.tif=38;5;13:*.tiff=38;5;13:*.png=38;5;13:*.svg=38;5;13:*.svgz=38;5;13:*.mng=38;5;13:*.pcx=38;5;13:*.mov=38;5;13:*.mpg=38;5;13:*.mpeg=38;5;13:*.m2v=38;5;13:*.mkv=38;5;13:*.webm=38;5;13:*.ogm=38;5;13:*.mp4=38;5;13:*.m4v=38;5;13:*.mp4v=38;5;13:*.vob=38;5;13:*.qt=38;5;13:*.nuv=38;5;13:*.wmv=38;5;13:*.asf=38;5;13:*.rm=38;5;13:*.rmvb=38;5;13:*.flc=38;5;13:*.avi=38;5;13:*.fli=38;5;13:*.flv=38;5;13:*.gl=38;5;13:*.dl=38;5;13:*.xcf=38;5;13:*.xwd=38;5;13:*.yuv=38;5;13:*.cgm=38;5;13:*.emf=38;5;13:*.axv=38;5;13:*.anx=38;5;13:*.ogv=38;5;13:*.ogx=38;5;13:*.aac=38;5;45:*.au=38;5;45:*.flac=38;5;45:*.mid=38;5;45:*.midi=38;5;45:*.mka=38;5;45:*.mp3=38;5;45:*.mpc=38;5;45:*.ogg=38;5;45:*.ra=38;5;45:*.wav=38;5;45:*.axa=38;5;45:*.oga=38;5;45:*.spx=38;5;45:*.xspf=38;5;45:'

# Misc commands that are helpful
# Xilinx DocNav shortcut
alias docnav='/opt/Xilinx/DocNav/docnav'
# Spruce up the regular diff, please and thank you
alias   diff='colordiff'
# common shortcut for screenshotting.
alias scnsht='gnome-screenshot --clipboard --area'

# handy kill command
alias kviv='[[ ! -z $(pidof vivado) ]] && kill $(pidof vivado)'
alias klibre='[[ ! -z $(pidof oosplash) ]] && kill $(pidof oosplash)'
# Display USB devices available.
alias llusb='ls /dev/ttyUSB*'
# sort files by size in local dir
alias files='find -type f -exec du -Sh {} + | sort -rh | head -n 10'

# remote logout command is pkill if using cinnamon...
if [ -z ${XRDP_SESSION+x} ] || [ $(head -n 1 ~/.Xclients) == "gnome-session" ]; then
  alias logoff='gnome-session-quit --logout'
else
  alias logoff='pkill -u jwoods'
fi

alias octave='/usr/bin/flatpak run --branch=stable --arch=x86_64 \
--command=/app/bin/octave --file-forwarding org.octave.Octave --gui &'

##############################
## FUNCTIONS

# smart extract
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) tar xjf    $1;;
      *.tar.gz)  tar xzf    $1;;
      *.bz2)     bunzip2    $1;;
      *.rar)     rar x      $1;;
      *.gz)      gunzip     $1;;
      *.tar)     tar xf     $1;;
      *.tbz2)    tar xjf    $1;;
      *.tgz)     tar xzf    $1;;
      *.zip)     unzip      $1;;
      *.Z)       uncompress $1;;
      *.7z)      7z x       $1;;
      *)         echo "'$1' cannot be extracted via extract()";;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# # publicip - shows public IP address
# publicip ()
# {
#   echo "--------------- Public IP ---------------"
#   myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
#   echo "${myip}"
#   echo "-----------------------------------------"
# }

# dirsize - finds directory sizes and lists them for the current directory
dirsize ()
{
  # ls-list all directories, du-get depth of dirs
  ls -d */ | du -hx --max-depth=1 2> /dev/null | \
  # sed-remove './', sort-sort in numberical order
  sed 's_\./__gi' | sort -rn > /tmp/list
  # Display in size order.
  egrep '^ *[0-9.]*G' /tmp/list
  egrep '^ *[0-9.]*M' /tmp/list
  egrep '^ *[0-9.]*K' /tmp/list
  # don't keep list
  rm -rf /tmp/list
}

# procedure to save hdf/ltx/bit files for 5mp camera from CameraFirmware dir.
# 1st arg: must be either 'spw' or 'cl'.
# 2nd arg: must be either blank or 'fm'.
save5mp() {
  # Check that we are using correct options
  if [ -z $1 ] || ([ $1 != "spw" ] && [ $1 != "cl" ]); then
    echo "Usage: 'save5mp spw [fm]' or 'save5mp cl [fm]'"
    return
  fi

  # Create location of hdf/ltx/bit files...
  local path="./build"
  [ "$1" = "spw" ]  && local path="$path/spacewire/temp"
  [ "$1" = "cl"  ]  && local path="$path/camera_link/temp"
  if   [ -z "$2" ];     then path="${path}/vivado_proj/vivado_proj.sdk";
  elif [ "$2" = "fm" ]; then path="${path}_fm/vivado_proj/vivado_proj.sdk"; fi

  if [[ ! -d $path ]]; then
    echo "$path does not exist!"
    return 1
  fi

  # find latest created files.
  local filename=$(ls -t $path | head -n1 | sed 's/\..*//g')

  # remote check-in to correct place in homeserver
  echo "Uploading ${filename}.* to /home/jwoods/lab/5mp/fw/$1/ in homeserver"
  for i in $path/$filename.*; do
    # echo "$(md5sum $i | awk '{print $1;}')  ${i##*/}"
    echo "${i##*/} : $(md5sum $i | awk '{print $1;}')"
  done
  scp $path/$filename.* jwoods@homeserver:/home/jwoods/lab/5mp/fw/$1/
}
# trying out my own completion function
_save5mp() {
  case $3 in
    "save5mp")   COMPREPLY=( $(compgen -W "spw cl" -- "$2") ) ;;
    "spw"| "cl") COMPREPLY=( $(compgen -W "fm [Blank]" -- "$2") ) ;;
    *)           unset COMPREPLY ;;
  esac
}
complete -F _save5mp save5mp

MAKETAGS() {
  local cmd='ctags --langmap=Verilog:+.sv -R --Verilog-kinds=-prn'
  if [ -f .ctagsignore ]; then
    cmd="$cmd --exclude=@.ctagsignore"
  fi
  if [ -z $FWTAGS ]; then
    cmd="$cmd --languages=vhdl,Verilog"
  fi
  cmd="$cmd $@"
  eval $cmd
}
# HDL Specific
alias MakeTags='FWTAGS="SET"; MAKETAGS'
alias MakeFWTags='unset FWTAGS; MAKETAGS'

##############################
## Command Line Completions

# autocomplete git / svn / make commands
# [ -f /etc/bash_completion.d/git ] && source /etc/bash_completion.d/git
# [ -f /usr/share/bash-completion/completions/svn ] && source /usr/share/bash-completion/completions/svn
complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+\s*:([^=]|$)' ?akefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make

##############################
## SOURCE BASH ALIASES

[ -f ~/.bash_aliases ] && source ~/.bash_aliases
# Scripts to review from falcon1
[[ -r /etc/profile.d/bash_completion.sh ]] && . /etc/profile.d/bash_completion.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.bash_completion/watson ] && source ~/.bash_completion/watson
