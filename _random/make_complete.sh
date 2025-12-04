#!/bin/bash
sorted() {
   echo `echo "$@" | xargs -n1 | sort -u | xargs`
}

getMakes() {
    local new_list=$@
    _print() {
       echo " $@ " >&2
    }
    _add() {
       local temp=`egrep -sh '^\s+?include\s+\\$\(BUILDFILES_PREFIX\)' $@ | sed -n -e "s#\s\+\?include\s\+.(BUILDFILES_PREFIX)# $buildfiles#p"`
       temp+=`egrep -sh '^\s+?include\s+[^$]' $@ | sed -n -e "s#\s\+\?include\s\+# #p"`
       echo " " `sorted $temp`
       return
    }
    _recur() {
        temp=`sorted $@`
        new_list+=`_add $temp`
        new_list=`sorted $new_list`
        # _print "Temp     $temp"
        # _print "new_list $temp"
        if [[ $temp == $new_list ]]; then
            echo $temp
            return
        fi
        _recur $new_list
    }
    _recur $@
}

makes=''
[[ -f 'Makefile' ]] && makes+='Makefile '
[[ -f 'makefile' ]] && makes+='makefile '
pre=`grep -si 'include $(BUILDFILES_PREFIX)/pre_include.mk' $makes`

# If there's a pre_include statement, then look up the tool we are in, and
# add pre_include, post_include, and the tool-specific makefile to list of files to grep
if [[ ! -z $pre ]]; then
   buildfiles=`grep -se "BUILDFILES_PREFIX\s\+\?=\s\?" $makes | sed -n -e 's/^BUILDFILES_PREFIX\s\+\?=\s\?//p'`
   tool=$(dirname "${PWD}")
   makes+=" $buildfiles/${tool##*/}.mk"
   makes=`getMakes $makes`
fi

# Grep files for lines that start with '<COMMAND> : ...'
# remove the colon, .PHONY, comments, and a couple corner cases etc.
list=`grep -sohE "^[a-zA-Z0-9_. -]+\s*:" $makes | sed -n -e "/\<BUILDFILES_.\+/d" -e "/\<HDL_SOURCES_REL.\+/d" -e "/\..\+/d" -e "/^[^     #].*:/s/:.*//p"`
# Add custom Make variables that I want to auto-fill
list+=" TC="
list+=" MODELSIM_BATCH="
# Sort, remove duplicates, and 'echo' to return the vals to the complete statement.
sorted $list
# echo $makes
