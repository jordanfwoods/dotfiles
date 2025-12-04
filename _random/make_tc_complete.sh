tool=$(dirname "${PWD}")
[[ ${tool##*/} == "modelsim" ]] && fileset=`ls ../../hdl/${PWD##*/}`
list=`ls -1 ../../hdl/${PWD##*/} 2> /dev/null | grep -sohE "\<tc[a-zA-Z0-9_.-]+.(sv|vh|svh|v)\>" | sed 's/\.[^.]*$//'`
list+=" `ls -1 ../../hdl/${PWD##*/} 2> /dev/null | grep -sohE '\<sim_blk_[a-zA-Z0-9_.-]+.(sv|vh|svh|v)\>' | sed 's/\.[^.]*$//'`"
echo "$list" | xargs -n1 | sort -u | xargs

