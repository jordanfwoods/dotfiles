#------------------------------------------------------------------------------
# Begin of .cshrc
#------------------------------------------------------------------------------
#
##############################################################################
# RCS tracking information :
# $Id: .cshrc_tm-e-sd,v 1.1 2014/01/24 08:42:14 vlmaint Exp $
#
#
#
# For questions contact EEI Support 2220
#
##############################################################################
#
#------------------------------------------------------------------------------
#  Setting up the prompt
#------------------------------------------------------------------------------

setenv HOSTNAME `hostname`
setenv LANG "en_US.UTF-8"
set LANG = "en_US.UTF-8"

# alias cd 'cd \!*; set prompt="${USER}@${HOSTNAME}: ${PWD} > "'
# set prompt="${USER}@${HOSTNAME}: ${PWD} > " # Needed to set the prompt while open a new terminal
                                              # else the prompt would be correct after the first cd action

#if -f ~/.prompt then                   # If you want to have a user defined prompt
#   source ~/.prompt                    # user defined prompt then create a .prompt file to your home directory.
#   alias cd 'cd \!*;source ~/.prompt'  # Enable the if section and comment above 3 lines.
#endif                                  #

#------------------------------------------------------------------------------
#  Other shell settings
#------------------------------------------------------------------------------

set history=1000                        # Keeps last n commands in history overview
#set noclobber                          # Restrict output redirection so that existing files are
#                                       # not  destroyed by accident
set filec                               # Filename completion by ECS
set autolist = ambiguous
# set complete = enhance
umask 027                               # user file/dir creation mask 027 ->(d:drwxr-x--- f:-rw-r-----)
limit coredumpsize 0                    # Prevent creation of large useless files
limit stacksize unlimited               # for running outgen properly

#------------------------------------------------------------------------------
#  Aliases
#------------------------------------------------------------------------------

alias pwd 'echo $cwd'
alias h   history
alias m   more
alias ll  'ls -alg|more'
alias lg  ' ls -al | grep -i '
alias dp  'echo setenv DISPLAY $DISPLAY;echo $DISPLAY > ~/.disp.txt'

if -f ~/.alias then        # If you want to have a user defined aliases
   source ~/.alias         # then create a .alias file in your home directory
endif

#------------------------------------------------------------------------------
#  VISULA CAD SETTINGS
#------------------------------------------------------------------------------
if -f ~redac/.alias_redac then
   source ~redac/.alias_redac           # Activates aliases usefull for Layout and TPD engineers.
endif

#------------------------------------------------------------------------------
#  JFW Modifications
#------------------------------------------------------------------------------

# Precmd...
# alias precmd ~/temp/dotfiles-master/gitprompt.pl
unalias precmd

# Update prompt to look pretty.
if ($TERM == "xterm") then # Normal window
   set prompt="%{\033[1;31m%}%N%{\033[0m%} : " # display username in bold red
else
   set prompt="%{\033[1;36m%}%N%{\033[0m%} : " # display username in regular cyan if using ddm environment
endif
# set prompt="$prompt%{\033[38;5;231m%}:%{\033[0m%} "  # colon separator in bold white
set prompt="$prompt%{\033[1;34m%}%m%{\033[0m%} "     # Display hostname in bold purple
set prompt="$prompt%{\033[0;37m%}%C%{\033[0m%} [%h] " # display full pathname in gold %/ %c %C
# if (`where ddm_archstore` != "") then #    set prompt="%N : %m %C [%h] " # endif

# Allow for scrolling up to reverse search history.
bindkey -k up   history-search-backward
bindkey -k down history-search-forward

# TBD Color for manpages TBD
set LESS_TERMCAP_mb=%'%{\033[01;31m'
set LESS_TERMCAP_md=%'%{\033[01;31m'
set LESS_TERMCAP_me=%'%{\033[0m'
set LESS_TERMCAP_se=%'%{\033[0m'
set LESS_TERMCAP_so=%'%{\033[01;44;33m'
set LESS_TERMCAP_ue=%'%{\033[0m'
set LESS_TERMCAP_us=%'%{\033[01;32m'

# duh
set EDITOR='vim'

# Aliases...
alias reload 'source ~/.cshrc'
alias colorless 'sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g"'
# vim aliases that are frequently used.
alias  vima 'vim ~/.bash_aliases'
alias  vimc 'vim ~/.cshrc'
alias  vimv 'vim ~/.vimrc'
alias  gits 'git status --ignore-submodules=all'
#alias vimto='vim -p ~/junk/personal/doc/main.todo ~/junk/personal/doc/daily.done ~/junk/personal/doc/weekly.done'
# abbreviate common directory commands
alias  mkdir 'mkdir -pv'
alias     .. 'cd ..'
alias    ... 'cd ../..'
alias   .... 'cd ../../..'
alias  ..... 'cd ../../../..'
alias ...... 'cd ../../../../..'
alias      l '/bin/ls -hN   --color=auto --group-directories-first'
alias     ll '/bin/ls -ohN  --color=auto --group-directories-first'
alias     l1 '/bin/ls -1h   --color=auto --group-directories-first'
alias     la '/bin/ls -oahN --color=auto --group-directories-first'
alias scnsht 'gnome-screenshot --clipboard --area'
alias kviv   '[[ ! -z $(pidof vivado) ]] && kill $(pidof vivado)'
alias llusb  'ls /dev/ttyUSB*'
alias files  'find -type f -exec du -Sh {} + | sort -rh | head -n 10'
alias dirsize '~/junk/dotfiles/dirsize.sh'
alias MakeFWTags  'ctags -R --languages=vhdl,Verilog ${PWD}'
alias MakeTopTags 'ctags -R --languages=vhdl,Verilog ${PWD}/hdl ${PWD}/sub/*/hdl ${PWD}/sub/*/sub/*/hdl'
alias MakeAllTags 'ctags -R .'
#alias octave '/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=/app/bin/octave --file-forwarding org.octave.Octave --gui &'

# Autocompletions
setenv traditional_complete "true"
[ -f /usr/share/doc/tcsh/complete.tcsh         ] && source /usr/share/doc/tcsh/complete.tcsh
[ -f /usr/share/doc/tcsh-6.18.01/complete.tcsh ] && source /usr/share/doc/tcsh-6.18.01/complete.tcsh
[ -f ~/junk/dotfiles/git-completion.tcsh       ] && source ~/junk/dotfiles/git-completion.tcsh
complete make 'n/-f/f/' 'c_./_f_' 'c@TEST_NAME=@`~/junk/dotfiles/make_tc_complete.sh`@' 'c@TC=@`~/junk/dotfiles/make_tc_complete.sh`@' 'c/*=/f/' 'n@*@`~/junk/dotfiles/make_complete.sh`@'
alias __ddm_sub__ 'ls "`git rev-parse --show-toplevel`/sub"'
complete ddm_sub* 'p@1@`__ddm_sub__`@'
# complete make 'n/-f/f/' 'c/*=/f/' 'c_./_f_' \
#    'n@*@`grep -sohE "^[a-zA-Z0-9_. -]+\s*:" makefile Makefile | sed -n -e "/.PHONY/d" -e "/^[^     #].*:/s/:.*//p"`@'

if (! $?TMUX) then
   # echo "Safe from TMUX!"
else
   if ("$TMUX" != "") then # Normal window
      # echo "Good Luck in tmux!"
      stty erase 
      stty -iutf8
      bindkey "[1~"   beginning-of-line
      bindkey "[4~"   end-of-line
      bindkey ""      backward-delete-char
      bindkey "[3;2~" backward-delete-char
      if (! $?TMUX_SETUP ) then
         tmux rename-session -t`tmux display-message -p '#S'` `echo $ES_PROJECT | cut -d'/' -f5-`
         tmux rename-window -t1 main
         tmux set-option -s status-interval 60
         set TMUX_SETUP = "yes"
      endif
      alias st   "tmux rename-session -t`tmux display-message -p '#S'` `echo $ES_PROJECT | cut -d'/' -f5-` ; tmux rename-window -t1 main ; tmux set-option -s status-interval 60"
   endif
endif

# setenv DDMTERM "xterm -bg '#380380380' -fg white -sb -sl 10000"
setenv DDMTERM "/usr/bin/env LANG=en_US.UTF-8 /usr/bin/xterm -bg '#306156000' -fg white -sl 10000"
alias tmux "/usr/bin/env LANG=en_US.UTF-8 /home/jowoods/.caddir/RHEL7/cadbin/tmux"
# TBD:
# Legacy BASH functions

# unset  LS_COLORS
setenv LS_COLORS 'rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'
# set LS_COLORS='rs=0:ln=38;5;51:mh=44;38;5;15:pi=40;38;5;11:so=38;5;13:do=38;5;5:'
# set LS_COLORS='$LS_COLORS:bd=48;5;232;38;5;11:cd=48;5;232;38;5;3:or=48;5;232;38;5;9:'
# set LS_COLORS='$LS_COLORS:mi=05;48;5;232;38;5;15:su=48;5;196;38;5;15:sg=48;5;11;38;5;16:'
# export LS_COLORS='rs=0:di=38;5;27:ln=38;5;51:mh=44;38;5;15:pi=40;38;5;11:so=38;5;13:do=38;5;5:bd=48;5;232;38;5;11:cd=48;5;232;38;5;3:or=48;5;232;38;5;9:mi=05;48;5;232;38;5;15:su=48;5;196;38;5;15:sg=48;5;11;38;5;16:ca=48;5;196;38;5;226:tw=48;5;10;38;5;16:ow=48;5;10;38;5;21:st=48;5;21;38;5;15:ex=38;5;34:*.tar=38;5;9:*.tgz=38;5;9:*.arc=38;5;9:*.arj=38;5;9:*.taz=38;5;9:*.lha=38;5;9:*.lz4=38;5;9:*.lzh=38;5;9:*.lzma=38;5;9:*.tlz=38;5;9:*.txz=38;5;9:*.tzo=38;5;9:*.t7z=38;5;9:*.zip=38;5;9:*.z=38;5;9:*.Z=38;5;9:*.dz=38;5;9:*.gz=38;5;9:*.lrz=38;5;9:*.lz=38;5;9:*.lzo=38;5;9:*.xz=38;5;9:*.bz2=38;5;9:*.bz=38;5;9:*.tbz=38;5;9:*.tbz2=38;5;9:*.tz=38;5;9:*.deb=38;5;9:*.rpm=38;5;9:*.jar=38;5;9:*.war=38;5;9:*.ear=38;5;9:*.sar=38;5;9:*.rar=38;5;9:*.alz=38;5;9:*.ace=38;5;9:*.zoo=38;5;9:*.cpio=38;5;9:*.7z=38;5;9:*.rz=38;5;9:*.cab=38;5;9:*.jpg=38;5;13:*.jpeg=38;5;13:*.gif=38;5;13:*.bmp=38;5;13:*.pbm=38;5;13:*.pgm=38;5;13:*.ppm=38;5;13:*.tga=38;5;13:*.xbm=38;5;13:*.xpm=38;5;13:*.tif=38;5;13:*.tiff=38;5;13:*.png=38;5;13:*.svg=38;5;13:*.svgz=38;5;13:*.mng=38;5;13:*.pcx=38;5;13:*.mov=38;5;13:*.mpg=38;5;13:*.mpeg=38;5;13:*.m2v=38;5;13:*.mkv=38;5;13:*.webm=38;5;13:*.ogm=38;5;13:*.mp4=38;5;13:*.m4v=38;5;13:*.mp4v=38;5;13:*.vob=38;5;13:*.qt=38;5;13:*.nuv=38;5;13:*.wmv=38;5;13:*.asf=38;5;13:*.rm=38;5;13:*.rmvb=38;5;13:*.flc=38;5;13:*.avi=38;5;13:*.fli=38;5;13:*.flv=38;5;13:*.gl=38;5;13:*.dl=38;5;13:*.xcf=38;5;13:*.xwd=38;5;13:*.yuv=38;5;13:*.cgm=38;5;13:*.emf=38;5;13:*.axv=38;5;13:*.anx=38;5;13:*.ogv=38;5;13:*.ogx=38;5;13:*.aac=38;5;45:*.au=38;5;45:*.flac=38;5;45:*.mid=38;5;45:*.midi=38;5;45:*.mka=38;5;45:*.mp3=38;5;45:*.mpc=38;5;45:*.ogg=38;5;45:*.ra=38;5;45:*.wav=38;5;45:*.axa=38;5;45:*.oga=38;5;45:*.spx=38;5;45:*.xspf=38;5;45:'

set GIT_COMP_DIR="/home/jowoods/junk/sd_elf_conveniences" # NOTE: CHANGE TO YOUR LOCAL SPOT.
source $GIT_COMP_DIR/source_me.csh

# Adding Wilton Matlab License to license file environment variable.
if ($?LM_LICENSE_FILE) then
   setenv LM_LICENSE_FILE $LM_LICENSE_FILE":1705@matlab-wil-lic-01.asml.com"
endif

# -----------------------------------------------------------------------------
# End of .cshrc
# -----------------------------------------------------------------------------
