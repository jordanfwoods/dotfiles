#!/bin/bash
dot_list=$(ls /home/jwoods/junk/dotfiles/)

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

   # Only copy contents out of tmux directory, not directory again
   elif [ $dot_file == "tmux" ]
   then
      echo "cp -rf ~/.tmux/*             ./tmux/"
            cp -rf ~/.tmux/*             ./tmux/

   elif [ $dot_file == "vim" ]
   then
      for vim_dir in $(ls /home/jwoods/.vim/)
      do
        if   [ $vim_dir != "plugged" ]
        then
          echo "cp -rf ~/.vim/$vim_dir/*      ./vim/$vim_dir/"
                cp -rf ~/.vim/$vim_dir/*      ./vim/$vim_dir/
        fi
      done

   # ignore a few files, but otherwise copy all files in.
   elif [ $dot_file != "update_dotfiles.sh" ] &&
        [ $dot_file != "README.md" ]          &&
        [ $dot_file != "vivado.sh" ]          &&
        [ $dot_file != "svn-color.py" ]       &&
        [ $dot_file != "gitprompt.pl" ]       &&
        [ $dot_file != "svnprompt.pl" ]       &&
        [ $dot_file != "svnvimdiffwrap.sh" ]
   then
      printf "cp -rf ~/.%-18s ./%0s\n" $dot_file $dot_file
              cp -rf ~/.$dot_file ./$dot_file
   fi
done

