#!/bin/bash

############################
# create directory variables
xilinx="/opt/Xilinx"
dot="/home/jwoods/junk/github/jordanfwoods/jfw_dotfiles"
svn="/home/jwoods/svn"
junk="/home/jwoods/junk"
jwoods="/home/jwoods/jwoods"
per="$jwoods/personal"

bfm="$svn/fpga_common_lib/trunk/common/sim/models"
cam="$svn/Camera/CameraFirmware/"
centroid="$svn/Firmware/trunk/core/08_misc/Centroiding"
gse="$svn/csp-em-05/fw/branch/csp-gse"
las="$svn/irad-lasercomm/FW/FPGA/branch/PAT_FFT"
mis="$svn/mist-so13239/FW/TRUNK/Zynq_PL_Design"

################
# Vivado Aliases
# Legacy - Uses "viv" in most applications.
alias  viv4="$xilinx/Vivado/2014.4/bin/vivado"
alias  viv6="$xilinx/Vivado/2016.2/bin/vivado"
alias  viv8="$xilinx/Vivado/2018.1/bin/vivado"
alias  viv2="$xilinx/Vivado/2018.2/bin/vivado"
alias  viv9="$xilinx/Vivado/2019.1/bin/vivado"
# created vivado.sh automatically opens correct version of vivado
alias   viv="$dot/vivado.sh"

#####
# SVN 
# Alternate Diff using vimdiff
alias svnvimdiff="svn diff --diff-cmd $dot/svnvimdiffwrap.sh"
# Alternate svn st to colorize svn status
# alias svns="/usr/local/bin/svn-color.py"
alias svns="$dot/svn-color.py status ."

##########################
# Change Directory Aliases
# Common FW locations
alias cdsvn="cd $svn"
alias cdbfm="cd $bfm"
alias cdcen="cd $centroid"
# SpaceCam
alias cdcam="cd $cam"
alias cdgse="cd $gse"
# Lasercomm - IRAD
alias cdlas="cd $las"
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
