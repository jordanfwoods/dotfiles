#!/bin/bash
# Sometimes SVN must be used. But in order to make it more 'git like', this script makes 'gits'

# Location of svnvimdiffwrap.sh and svn-color.py
[[ ! -z $1 ]] && dir="$1"
[[   -z $1 ]] && dir="~/junk/dotfiles/"

cl="staging_area"
basedir="~/.svn-git/"
# [[ ! -f $basedir ]] && echo "mkdir $basedir"

# Colorize svn (especially status)
[    -f $dir/svn-color.py ]  && alias svncolor="$dir/svn-color.py"
[[ ! -f $dir/svn-color.py ]] && alias svncolor="svn"

##########################
# Use gits! (abbreviation of git-for-svn)
gits() {
  # if just 'gits', then do git status
  [ -z $1 ] && svncolor status ${@:2} && return 0

  # Help screen
  if [[ $1 =~ ^(-?-?[Hh](elp)?(ELP)?)$ ]]; then
    echo "Gits Commands:"
    echo "Key: [ ] Undecided. [X] Will not add  [I] In progress, tbd. [√] Feature is added and tested."
    echo "[√]   add        Add file contents to the index"
    echo "[ ]   branch     List, create, or delete branches"
    echo "[ ]   commit     Record changes to the repository"
    echo "[√]   diff       Show changes between commits, commit and working tree, etc"
    echo "[ ]   init       Takes an existing svn repo and starts a gits repo from the cwd."
    echo "[√]   log        Show commit logs"
    echo "[ ]   merge      Join two or more development histories together"
    echo "[√]   mv         Move or rename a file, a directory, or a symlink"
    echo "[√]   pull       Fetch from and merge with another repository or a local branch"
    echo "[√]   push       Update remote refs along with associated objects"
    echo "[I]   reset      Reset current HEAD to the specified state"
    echo "[I]   rm         Remove files from the working tree and from the index"
    echo "[I]   status     Show the working tree status"
    echo "[I]   stash      Stash the changes in a dirty working directory away"
    echo "[ ]   tag        Create, list, delete or verify a tag object signed with GPG"
    return
  fi

  # Apply desired changes.
  case $1 in
    "add")      gitsadd "${@:2}";;
    "branch")   echo "Be Patient, 'gits $1' has not yet been implemented";;
    "commit")   echo "At this moment, there are no local commits, only gits push to push staged changes to the remote repo";;
    "diff")     [[   -f $dir/svnvimdiffwrap.sh ]] && svn diff --diff-cmd $dir/svnvimdiffwrap.sh ${@:2} && return
                [ -x "$(command -v colordiff)" ]  && svn diff --diff-cmd colordiff ${@:2} && return 0
                svncolor diff ${@:2};;
    "init")     echo "Be Patient, 'gits $1' has not yet been implemented";;
    "log")      svncolor log | less;;
    "merge")    echo "Be Patient, 'gits $1' has not yet been implemented";;
    "mv")       svncolor mv ${@:2} && gitsadd "${@:2}";;
    "pull")     svncolor up ${@:2};;
    "push")     gitspush ${@:2};;
    "reset")    echo "Be Patient, 'gits $1' has not yet been implemented";;
    "rm")       echo "Be Patient, 'gits $1' has not yet been implemented";;
    "stash")    gitsstash "${@:2}";;
    "status")   svncolor status ${@:2};;
    "tag")      echo "Be Patient, 'gits $1' has not yet been implemented";;
    *)          echo "Command $1 not recognized, please use 'gits help' for more details";;
  esac
}

# autocomplete for gits
complete -W "init stash add branch checkout clone commit diff log merge mv pull push reset rm status tag" gits

##########################
# Basic Commands / aliases

# svnreset acts like 'git reset HEAD <file>', i.e. removes item from staging area.
# note that local changes are not modified
alias svnreset='svn cl --remove'

# svnresethead acts like 'git reset HEAD', i.e. removes all item from staging area and removes cl.
# note that local changes are not modified
alias svnresethead='svn cl --remove --recursive --cl staging_area .'

##########################
# gits function calls

gitsadd() {
  # Help screen
  if [ -z $1 ] || [[ $1 =~ ^(-?-?[Hh](elp)?(ELP)?)$ ]]; then
    echo "gits add adds a file to a SVN repo (if not already added), and adds it to a SVN changelist (called '$cl')"
    echo " usage: 'gitsadd <file1> [<file2> ...]'"
    return
  fi
  # if something is wrong, then don't stage anything
  for file in "$@"; do
    [[ ! -f $file ]] && echo "$file doesn't exist!" && return 1
  done
  # for each file, add to svn repo if needed, and add to changelist
  for file in "$@"; do
    ! (svn info   $file 1>/dev/null 2>&1) && svncolor add $file
    [[ ! -z $(svn status -q $file) ]] && svncolor cl $cl $file
  done
}

gitspush() {
  # Help screen
  if [ ! -z $1 ] || [[ $1 =~ ^(-?-?[Hh](elp)?(ELP)?)$ ]]; then
    echo "gits push commits the staged changes to the remote repository."
    echo " usage: 'gitspush -m \"<Commit Message>\"'"
    return
  fi
  # check for staged changes and commit
  [ -z $(svn status --cl $cl -q) ] && echo "No changes are staged to $cl!" && return 1
  svncolor ci --cl $cl
}

export STASHDIR=~/.gitsstash
gitsstash() {
  # Help screen
  if [ -z $1 ] || [[ $1 =~ ^(-?-?[Hh](elp)?(ELP)?)$ ]]; then
    echo "gitsstash replicates 'git stash' for a svn repo."
    echo " usage: 'gitsstash [save]  <stash_name>' stashes changes [overwriting old stash if same name] and reverts the directory."
    echo "    or: 'gitsstash keep    <stash_name>' creates stash, but does not revert the directory"
    echo "    or: 'gitsstash list'                 lists names of stashed changes."
    echo "    or: 'gitsstash pop     <stash_name>' applies changes and removes stash"
    echo "    or: 'gitsstash apply   <stash_name>' applies changes and keeps stash"
    echo "    or: 'gitsstash peek    <stash_name>' displays the stashed changes"
    echo "    or: 'gitsstash discard <stash_name>' throws away stash without applying changes"
    echo "    or: 'gitsstash drop    <stash_name>' same as 'discard'"
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

complete -W "-f help save keep list pop apply peek drop discard \`[ -d $STASHDIR ] && ls $STASHDIR | sed 's/.stash$//'\`" gitsstash

##########################
# source completions for svn and also apply to svncolor

# source svn completions
[ -f /usr/share/bash-completion/completions/svn ] && source /usr/share/bash-completion/completions/svn

# Apply svn autocompletions to svncolor
complete -F _svn -o default -X '@(*/.svn|*/.svn/|.svn|.svn/)' svncolor
