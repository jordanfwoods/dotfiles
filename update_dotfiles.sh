#!/bin/bash
dot_list=$(ls ~/junk/github/jordanfwoods/jfw_dotfiles/)

for dot_file in $dot_list
do
   # Only copy subversion config file, not entire directory
   if   [ $dot_file == "subversion" ]
   then
      echo "cp -rf ~/.subversion/config  ./subversion/config"
            cp -rf ~/.subversion/config  ./subversion/config

   # Only copy autostart out of config directory, not entire directory
   elif [ $dot_file == "config" ]
   then
      echo "cp -rf ~/.config/autostart/* ./config/autostart/"
            cp -rf ~/.config/autostart/* ./config/autostart/

   # Only copy contents out of fonts directory, not directory again
   elif [ $dot_file == "fonts" ]
   then
      echo "cp -rf ~/.fonts/*            ./fonts/"
            cp -rf ~/.fonts/*            ./fonts/

   # ignore a few files, but otherwise copy all files in.
   elif [ $dot_file != "update_dotfiles.sh" ] &&
        [ $dot_file != "README.md" ]          &&
        [ $dot_file != "svnvimdiffwrap.sh" ]
   then
      printf "cp -rf ~/.%-18s ./%0s\n" $dot_file $dot_file
      # echo "cp -rf ~/.$dot_file ./$dot_file"
            cp -rf ~/.$dot_file ./$dot_file
   fi
done

