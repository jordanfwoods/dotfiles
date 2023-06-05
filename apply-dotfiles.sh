#!/bin/bash
dir='/home/jwoods/junk/dotfiles/'
[[ ! -d $dir ]] && dir='/Users/jordan/sandbox/dotfiles/'
dot_list=$(ls $dir)

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
      echo "2: $dot_file";
      cp -rv $dot_file ~/.$dot_file;;
  esac
  # printf "cp -rf ./%-18s\t~/.%0s\r\n" "$dot_file" "$dot_file"
          # cp -rf ~/.$dot_file ./$dot_file
done

    # "bash_aliases")       echo "$option";;
    # "config")             echo "$option";;
    # "ctagsignore")        echo "$option";;
    # "fonts")              echo "$option";;
