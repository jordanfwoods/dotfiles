#!/bin/bash
dot_list=$(ls /home/jwoods/junk/dotfiles/)
tabs 10

for dot_file in $dot_list
do
  # Only copy subversion config file, not entire directory
  if   [ $dot_file == "subversion" ]
  then
    printf "cp -rf ~/.subversion/config\t./subversion/config\r\n"
            cp -rf ~/.subversion/config  ./subversion/config

  # Only copy autostart out of config directory, not entire directory
  elif [ $dot_file == "config" ]
  then
    printf "cp -rf ~/.config/autostart/*\t./config/autostart/\r\n"
            cp -rf ~/.config/autostart/* ./config/autostart/

  # Only copy contents out of fonts directory, not directory again
  elif [ $dot_file == "fonts" ]
  then
    printf "cp -rf ~/.fonts/*\t\t./fonts/\r\n"
            cp -rf ~/.fonts/*    ./fonts/

  # Only copy contents out of tmux directory, not directory again
  elif [ $dot_file == "tmux" ]
  then
    printf "cp -rf ~/.tmux/*\t\t./tmux/\r\n"
            cp -rf ~/.tmux/*    ./tmux/

  elif [ $dot_file == "vim" ]
  then
    for vim_dir in $(ls /home/jwoods/.vim/)
    do
      if   [ $vim_dir != "plugged" ]
      then
        printf "cp -rf ~/.vim/$vim_dir/*\t./vim/$vim_dir/\r\n"
                cp -rf ~/.vim/$vim_dir/*  ./vim/$vim_dir/
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
    printf "cp -rf ~/.%-18s\t./%0s\r\n" "$dot_file" "$dot_file"
            cp -rf ~/.$dot_file ./$dot_file
  fi
done

tabs 8
