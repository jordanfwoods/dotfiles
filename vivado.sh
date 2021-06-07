#!/usr/bin/bash

xpr="temp"

# If no xpr is provided, then try to find one
if [ $# -eq 0 ] || [ "${1:(-4)}" != ".xpr" ]
then
   for file in *
   do
      if [ "${file:(-4)}" == ".xpr" ]
      then
         xpr="$file"
      fi
   done
else
   $xpr="$1"
fi

if [ "$xpr" == "temp" ]
then
   echo "No XPR Specified, opening Viv18.1 with any given file"
   /opt/Xilinx/Vivado/2018.1/bin/vivado $1
else
   # need index to know which line we are on
   n=0

   # Loop through each line of .xpr file
   while read line;
   do
      # Incrment n to know current line number
      ((n++))

      # Vivado version information are stored on the 2nd line
      if [[ $n -eq 2 ]]; then
         # Find the 2 for the year number, and save all characters after that.
         viv_ver="${line#*2}"

         # Done with reading the vivado file.
         break
      fi
   done < $xpr

   # Open correct xpr in discovered version
   viv_cmd="/opt/Xilinx/Vivado/2${viv_ver:0:5}/bin/vivado $xpr"
   echo $viv_cmd; eval $viv_cmd
fi
