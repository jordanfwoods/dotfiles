#!/bin/bash

############################
# create directory variables
xilinx="/opt/Xilinx"
dot="/home/jwoods/junk/dotfiles"
svn="/home/jwoods/svn"
junk="/home/jwoods/junk"
per="$junk/personal/doc"

bfm="$svn/fpga_common_lib/trunk/common/sim/models"
cm5="$svn/5MP/Camera/CameraFirmware/"
cm9="$svn/af-spacecam9mp-development/fw/"
cen="$svn/Firmware/trunk/core/08_misc/Centroiding"
gse="$svn/csp-em-05/fw/branch/csp-gse"
hei="$svn/heimdall-development/FW/Trunk"
las="$svn/irad-lasercomm/FW/FPGA/branch/PAT_FFT"
mis="$svn/mist-so13239/FW/TRUNK/Zynq_PL_Design"

# Make scp a LOT shorter
scp="jwoods@homeserver:/home/jwoods/lab"

# bash file that makes svn more 'git-like'
[ -f $dot/svn_patch.sh ] && source $dot/svn_patch.sh $dot
# [ -f $dot/svn-git.sh ] && source $dot/svn-git.sh $dot

################
# Vivado Aliases
# Legacy - Uses "viv" in most applications.
alias  viv4="$xilinx/Vivado/2014.4/bin/vivado"
alias  viv6="$xilinx/Vivado/2016.2/bin/vivado"
alias  viv8="$xilinx/Vivado/2018.1/bin/vivado"
alias  viv2="$xilinx/Vivado/2018.2/bin/vivado"
alias  viv9="$xilinx/Vivado/2019.1/bin/vivado"
alias  viv1="$xilinx/Vivado/2021.2/bin/vivado"
# created vivado.sh automatically opens correct version of vivado
alias   viv="$dot/vivado.sh"

##########################
# Change Directory Aliases
# Common FW locations
alias cdsvn="cd $svn"
alias cdbfm="cd $bfm"
alias cdcen="cd $cen"
# SpaceCam
alias cdcam="cd $cm5"
alias   cd9="cd $cm9"
alias cdgse="cd $gse"
# Lasercomm - IRAD
alias cdlas="cd $las"
# Heimdall - Combine MIST with SpaceCam
alias cdhei="cd $hei"
# MIST
alias cdmis="cd $mis"
# Personal Aliases
alias cdjun="cd $junk"
alias  cdot="cd $dot"
alias cdper="cd $per"

#####################
# Commonly used files
alias  Time="libreoffice $per/TimeCard.xlsx &"
alias  Pass="libreoffice $per/Passwords.docx &"
