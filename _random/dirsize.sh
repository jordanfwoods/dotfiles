#!/usr/bin/bash
wds='.'
[[ "$#" -ne "0" ]] && wds=$@

for cwd in $wds
do
   # echo $cwd
   # ls-list all directories, du-get depth of dirs # sed-remove './', sort-sort in numberical order
   du -hx --max-depth=1 $cwd 2> /dev/null | sed 's_\./__gi' | sort -rn > ~/.tmp
   # Display in size order.
   egrep '^ *[0-9.]*G' ~/.tmp
   egrep '^ *[0-9.]*M' ~/.tmp
   egrep '^ *[0-9.]*K' ~/.tmp
   # don't keep list
   rm -rf ~/.tmp
done
