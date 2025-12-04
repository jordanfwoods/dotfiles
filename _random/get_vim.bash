#!/usr/bin/bash
cp ~/.vimrc vimrc
cp -rf ~/.vim/* vim
rm */*/._* */*/*/._*
rm -rf vim/plugged
