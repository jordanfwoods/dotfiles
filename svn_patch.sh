#!/bin/bash
# bash file that makes svn more 'git-like'

# Location of svnvimdiffwrap.sh and svn-color.py
[[ ! -z $1 ]] && dir="$1"
[[   -z $1 ]] && dir="~/junk/dotfiles/"

##########################
# Basic Commands / aliases

# added commands: svnadd, svnci, svnreset, svnresethead

# svn add - begins tracking file. svnadd makes changelist act like a staging area.
alias svnadd='svn cl staging_area'

# svn ci - checks in all changes. svnci checks in changelist only.
alias svnci='svn ci --cl staging_area'

# svnreset acts like 'git reset HEAD <file>', i.e. removes item from staging area.
# note that local changes are not modified
alias svnreset='svn cl --remove'

# svnresethead acts like 'git reset HEAD', i.e. removes all item from staging area and removes cl.
# note that local changes are not modified
alias svnresethead='svn cl --remove --recursive --cl staging_area .'

# Force svn diff to use vimdiff
[ -f $dir/svnvimdiffwrap.sh ] && alias svnvimdiff="svn diff --diff-cmd $dir/svnvimdiffwrap.sh"

# Colorize svn (especially status)
[ -f $dir/svn-color.py ] && alias svncolor="$dir/svn-color.py"

# Colorize svn status
[ -f $dir/svn-color.py ] && alias svns="$dir/svn-color.py status"

##########################
# Create svnstash like git

export STASHDIR=~/.svnstash
svnstash() {
  # Help screen
  if [ -z $1 ] || [[ $1 =~ ^(-?-?[Hh](elp)?(ELP)?)$ ]]; then
    echo "svnstash replicates 'git stash' for a svn repo."
    echo " usage: 'svnstash [save]  <stash_name>' stashes changes [overwriting old stash if same name] and reverts the directory."
    echo "    or: 'svnstash keep    <stash_name>' creates stash, but does not revert the directory"
    echo "    or: 'svnstash list'                 lists names of stashed changes."
    echo "    or: 'svnstash pop     <stash_name>' applies changes and removes stash"
    echo "    or: 'svnstash apply   <stash_name>' applies changes and keeps stash"
    echo "    or: 'svnstash peek    <stash_name>' displays the stashed changes"
    echo "    or: 'svnstash discard <stash_name>' throws away stash without applying changes"
    echo "    or: 'svnstash drop    <stash_name>' same as 'discard'"
    return
  fi

  # Create file path for new stash file
  local dir=$STASHDIR
  [[ ! -d $STASHDIR ]] && mkdir $STASHDIR
  if [ -z $2 ] && ([ $1 == "apply" ] || [ $1 == "pop" ]  || [ $1 == "peek" ] || [ $1 == "save" ] ||
                   [ $1 == "keep" ]  || [ $1 == "drop" ] || [ $1 == "discard" ]); then
    echo "$1 expects a <stash_name>"; return
  elif [ -z $2 ]; then local file="${dir}/${1}.stash";
  else                 local file="${dir}/${2}.stash"; fi

  # Double check if it exists / doesn't exist.
  if ([ $1 == "keep" ] || [ $1 == "save" ] || [ -z $2 ]) && [ -f $file ]; then
    echo "stash with name '$(basename -s.stash $file)' exists already!"; return
  elif [ ! -f $file ] && ([ $1 == "apply" ] || [ $1 == "pop" ]); then
    echo "stash with name '$(basename -s.stash $file)' doesn't exist!"; return; fi

  # Apply desired changes.
  case $1 in
    "drop")    rm $file;;
    "discard") rm $file;;
    "apply")   patch -p0 < $file;;
    "pop")     patch -p0 < $file; rm $file;;
    "list")    ls -1t $dir | sed 's_\.\w*__g';;
    "peek")    colordiff < $file | less -r;;
    "keep")    svn diff > $file;;
    "save")    svn diff > $file; svn revert -R .;;
    *)         svn diff > $file; svn revert -R .;;
  esac
}

complete -W "-f help save keep list pop apply peek drop discard \`[ -d $STASHDIR ] && ls $STASHDIR | sed 's/.stash$//'\`" svnstash

##########################
# source completions for svn and also apply to svncolor

# source svn completions
[ -f /usr/share/bash-completion/completions/svn ] && source /usr/share/bash-completion/completions/svn

# Apply svn autocompletions to svncolor
complete -F _svn -o default -X '@(*/.svn|*/.svn/|.svn|.svn/)' svncolor

