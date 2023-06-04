#!/bin/bash
dot_list=$(/bin/ls /Users/jordan/sandbox/dotfiles/)

while getopts ":vht" option; do
  case $option in
  h) echo "apply-updates.sh help";
     echo "\tdisplay this help message:         $0 -h"; exit;;
  ?) echo "error: option -$OPTARG is not implemented";
     echo "available options are: -h"; exit;;
  esac
done

for dot_file in $dot_list; do
  case $dot_file in
    "bash_profile" | "bashrc" | "gitconfig" | "subversion" | "tmux" | "tmux.conf" | "vim" | "vimrc" )
      cp -r $dot_file ~/.$dot_file;;
  esac
  # echo "2: $dot_file"
  # printf "cp -rf ./%-18s\t~/.%0s\r\n" "$dot_file" "$dot_file"
          # cp -rf ~/.$dot_file ./$dot_file
done

    # "bash_aliases")       echo "$option";;
    # "config")             echo "$option";;
    # "ctagsignore")        echo "$option";;
    # "fonts")              echo "$option";;
