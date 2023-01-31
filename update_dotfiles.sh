#!/bin/bash
dot_list=$(ls /home/jwoods/junk/dotfiles/)
tabs 10 > /dev/null

verbose=false
while getopts ":vh" option; do
  case $option in
  h) echo "display this help message:   $0 -h";
     echo "display all update commands: $0 -v"; exit;;
  v) verbose=true;;
  ?) echo "error: option -$OPTARG is not implemented";
     echo "available options are: -h -v"; exit;;
  esac
done


for dot_file in $dot_list
do
  # Only copy subversion config file, not entire directory
  if   [ $dot_file == "subversion" ]
  then
    if $verbose ; then printf "cp -rf ~/.subversion/config\t./subversion/config\r\n" ; fi
                               cp -rf ~/.subversion/config  ./subversion/config

  # Only copy autostart out of config directory, not entire directory
  elif [ $dot_file == "config" ]
  then
    if  $verbose ; then printf "cp -rf ~/.config/autostart/*\t./config/autostart/\r\n" ; fi
                                cp -rf ~/.config/autostart/*  ./config/autostart/

  # Only copy contents out of fonts directory, not directory again
  elif [ $dot_file == "fonts" ]
  then
    if  $verbose ; then printf "cp -rf ~/.fonts/*\t\t./fonts/\r\n" ; fi
                                cp -rf ~/.fonts/*    ./fonts/

  # Only copy contents out of tmux directory, not directory again
  elif [ $dot_file == "tmux" ]
  then
    if  $verbose ; then printf "cp -rf ~/.tmux/*\t\t./tmux/\r\n" ; fi
                                cp -rf ~/.tmux/*    ./tmux/

  elif [ $dot_file == "vim" ]
  then
    for vim_dir in $(ls /home/jwoods/.vim/)
    do
      if   [ $vim_dir != "plugged" ]
      then
        if $verbose ; then printf "cp -rf ~/.vim/$vim_dir/*\t./vim/$vim_dir/\r\n" ; fi
                                   cp -rf ~/.vim/$vim_dir/*  ./vim/$vim_dir/
      fi
    done

  # ignore a few files, but otherwise copy all files in.
  elif [ $dot_file != "update_dotfiles.sh" ] &&
       [ $dot_file != "README.md"          ] &&
       [ $dot_file != "dotfiles.tar.gz"    ] &&
       [ $dot_file != "dotfiles.tar.z"     ] &&
       [ $dot_file != "vivado.sh"          ] &&
       [ $dot_file != "svn-color.py"       ] &&
       [ $dot_file != "gitprompt.pl"       ] &&
       [ $dot_file != "svnprompt.pl"       ] &&
       [ $dot_file != "svnvimdiffwrap.sh"  ]
  then
    if $verbose ; then printf "cp -rf ~/.%-18s\t./%0s\r\n" "$dot_file" "$dot_file" ; fi
                               cp -rf ~/.$dot_file ./$dot_file
  fi
done

tabs 8 > /dev/null

if $verbose ; then printf "\r\n" ; fi
git status

tarball="dotfiles.tar.z"
if [ -z "$tarball" ] ; then rm $tarball ; fi
tar -zcf $tarball *
scp $tarball jwoods@homeserver:/home/jwoods/
