#!/usr/bin/bash
cp ~/vimfiles/vimrc vimrc
cp -rf ~/vimfiles/* vim
rm vim/vimrc */*/._* */*/*/._*
rm -rf vim/plugged
