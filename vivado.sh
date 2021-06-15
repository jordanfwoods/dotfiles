#!/usr/bin/bash

# Set xpr variable to temp, then update once an actual XPR is found.
# If xpr variable is still set to temp, then no xpr was found.
xpr="temp"

# If no xpr is explicitly provided, then try to find one
if [ $# -eq 0 ] || [ "${1:(-4)}" != ".xpr" ]
then
   # loop through files in current directory to find xpr.
   for file in *
   do
      if [ "${file:(-4)}" == ".xpr" ]
      then
         xpr="$file"
         break
      fi
   done
else
   # if an xpr was explicitly given then use that
   $xpr="$1"
fi

# If no xpr was found then just use Vivado 2018.1
if [ "$xpr" == "temp" ]
then
   # If no file specified, then don't confuse them...
   if [ $# -eq 0 ] 
   then
      echo "No XPR Specified, opening Vivado 2018.1"
   else
      echo "No XPR Specified, opening $1 in Vivado 2018.1"
   fi
   /opt/Xilinx/Vivado/2018.1/bin/vivado $1

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

   # Open correct xpr in discovered version
   viv_cmd="/opt/Xilinx/Vivado/2${viv_ver:0:5}/bin/vivado $xpr"
   echo $viv_cmd; eval $viv_cmd
fi
