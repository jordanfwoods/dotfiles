#!/usr/bin/bash
output=""
[[ -z $(command -v watson) ]] && echo "" && exit
stat=$(watson status)
[[ $stat = No* ]] && echo "#[fg=colour147]No Watson Project Started#[fg=colour15] | " && exit
output="#[fg=colour172]$(echo $stat | cut -d " " -f 2)"
[[ $stat == *"["* ]] && output="$output #[fg=colour15][#[fg=colour147]"
[[ $stat == *"["* ]] && output="$output$(echo $stat | cut -d ] -f 1 | cut -d [ -f 2)#[fg=colour15]]"
echo "$output#[fg=colour15] | "
# "#[fg=colour2]#(watson status | cut -d \" \" -f 2) "\
# "#[fg=colour15][#[fg=colour28]#(watson status | cut -d ] -f 1 | cut -d [ -f 2)#[fg=colour15]] | "\
