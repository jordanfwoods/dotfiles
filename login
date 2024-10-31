#------------------------------------------------------------------------------
# Begin of .login
#------------------------------------------------------------------------------
#
##############################################################################
#
# RCS tracking information : 
# $Id: .login_tm-e-sd,v 1.2 2016/04/06 07:01:50 vlmaint Exp vlmaint $ 
#
#
# For questions contact EEI Support 2220
#
#
#         .login file
#
#         Read in after the .cshrc file when you log in.
#         Not read in for subsequent shells.  For setting up
#         terminal and global environment characteristics.
#
#    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#    !!!  Standard .login for all E-DEV users    !!!
#    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
#
##############################################################################


#------------------------------------------------------------------------------
# TERMINAL SETTINGS
#------------------------------------------------------------------------------

#Setup for vt100-terminal
if ( $?TERM ) then
	if ( $TERM == "network" ) then
		echo '[61"p'
		setenv TERM "vt100"
	endif
endif

stty erase '^?'                         # make the Back Space work ???
umask 027                               # user file/dir creation mask (d:drwxr-x--- f:-rw-r-----)
limit coredumpsize 0                    # prevent creation of large useless files
limit stacksize unlimited               # for running encore and outgen properly

#------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
#------------------------------------------------------------------------------

setenv PRINTER mfvdh252                 # set default printer
setenv LP ${PRINTER}
setenv LPDEST ${PRINTER}
setenv EDITOR vi                        # set default editor

setenv MAIL /var/mail_AL1/$USER
setenv OPENWINHOME /usr/openwin
#setenv NTRIGUE_SERVER nlelcw01
setenv HOST `hostname`                  # set hostame 
setenv WINDOW_MGR olwm
setenv OW_WINDOW_MANAGER olwm

#setenv PATH ${PATH}:/etc               # advanced users only
#setenv PATH ${PATH}:/usr/sbin          # advanced users only
setenv PATH /usr/ucb:${PATH}
#setenv PATH /opt/webclient/apps:${PATH} # remove in future
setenv PATH /usr/ccs/bin:${PATH}
setenv PATH /usr/local/bin:${PATH}       # needed for ssh
setenv PATH ${OPENWINHOME}/bin:${PATH}
setenv PATH /usr/dt/bin:${PATH}
#setenv PATH ${PATH}:/ecad/vl/pv/v61/design/rcs # advanced users only
setenv PATH ${PATH}:/home/jowoods/junk/dotfiles/docx2txt-1.4 # advanced users only

setenv LD_LIBRARY_PATH $OPENWINHOME/lib

setenv MANPATH ~/man
setenv MANPATH ${MANPATH}:/usr/share/man
setenv MANPATH ${MANPATH}:$OPENWINHOME/man
setenv MANPATH ${MANPATH}:/usr/man

#------------------------------------------------------------------------------
# E-CAD setup
#------------------------------------------------------------------------------


if ( ! -d ~/vl/std) then				# initial powerview setup
    mkdir ~/vl >& /dev/null         			# first time user login
    mkdir ~/vl/std >& /dev/null
endif

source ~vlmaint/ecadsetup2				# loading CAD settings

#------------------------------------------------------------------------------
# Personalize PATH SETTINGS
#------------------------------------------------------------------------------

setenv PATH .:$home/bin:${PATH}

#------------------------------------------------------------------------------
# start openwindows on console only
# set TERM and unset TERMCAP for terminal switch.
# if TERM = sun, you have a prompt, not running openwindows 
#   (default a start of login on console
# if TERM = sun-cmd, you have a unix prompt in a window
#------------------------------------------------------------------------------

if ((`tty | awk '{print $1}'` == /dev/console) && ($TERM == sun)) then
	$OPENWINHOME/bin/openwin
        clear
        logout
endif

if (  $?SSH_TTY ) then     # check if ssh connection, if so tunnel DISPLAY.
   if (  $?DISPLAY ) then
    echo "DISPLAY tunneled through  SSH: $DISPLAY"
   endif
else                       # check if rlogin, telnet connection and set DISPLAY
   set HOST=`/usr/bin/who am i | awk -F\( '{print $2}' | awk -F\) '{print $1}'`
   if ("`echo $HOST | grep ':'`" != "" ) then
      echo "Remote login detected, setting DISPLAY to ${HOST}"
      setenv DISPLAY ${HOST}
      setenv PMDISPLAY $DISPLAY
   else if ( "$HOST" != "" ) then
      echo "Remote login detected, setting DISPLAY to ${HOST}:0.0"
      setenv DISPLAY ${HOST}:0.0
      setenv PMDISPLAY $DISPLAY
   endif
endif

if (`who am i | egrep -c ttyp` == 1 ) then              # for SunOS 4.1.3_U1
        setenv TERM sun-cmd				# to indicate a unix prompt
        unsetenv TERMCAP				# in a window
endif

setenv GIT_SSH_COMMAND 'ssh -i ~/.ssh/id_rsa_git'
setenv TZ 'America/Los_Angeles'

#------------------------------------------------------------------------------
# End of .login
#------------------------------------------------------------------------------
exit
