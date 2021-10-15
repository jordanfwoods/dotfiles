#!/usr/bin/bash

# Set xpr variable to temp, then update once an actual XPR is found.
# If xpr variable is still set to temp, then no xpr was found.
xpr="temp"
src="-source ~/.tcl"

###############################
## Try to Find the .xpr File ##
###############################

# If explicit xpr is provided, then no need to search.
if [ "${1:(-4)}" == ".xpr" ]
then
  xpr="$1"

# If nothing is provided then search current directory.
elif [ $# -eq 0 ]
then
  path="."

# if any other string is provided, then assume it's a directory.
else
  path=${1%/}
fi

# if necessary, search for xpr
if ! [ -z ${path+x} ]
then
  # loop through files in relevant directory to find xpr.
  for file in ${path}/*
  do
    if [ "${file:(-4)}" == ".xpr" ]
    then
      xpr="$file"
      break
    fi
  done
fi


##########################################
## Open Vivado with any .xpr file found ##
##########################################

# If no xpr was found then just use Vivado 2018.1
if [ "$xpr" == "temp" ]
then
  if [ "${path}" == "." ]
  then
    echo "No XPR Specified, opening Vivado 2018.1"
  else
    echo "No XPR found in ${1} directory, opening Vivado 2018.1"
  fi
  /opt/Xilinx/Vivado/2018.1/bin/vivado $src

# If there is a valid XPR file, then parse the file to find the correct Vivado
# version
else
  # need index to know which line we are on
  n=0

  # Loop through each line of .xpr file
  while read line;
  do
    # Incrment n to know current line number
    ((n++))

    # Vivado version information is stored on the 2nd line
    if [[ $n -eq 2 ]]; then
      # Find the 2 for the year number, and save all characters after that.
      viv_ver="${line#*2}"

      # Done with reading the vivado file.
      break
    fi
  done < $xpr # This feeds in the XPR file to the while read line command

  # Open correct xpr in discovered version and display the command
  viv_cmd="/opt/Xilinx/Vivado/2${viv_ver:0:5}/bin/vivado $xpr $src"
  echo $viv_cmd
  eval $viv_cmd
fi
