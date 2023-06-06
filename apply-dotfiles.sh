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
      [[ -d $dot_file ]] && rm -rf ~/.$dot_file;
      cp -rfv $dot_file ~/.$dot_file;;
  esac
done
