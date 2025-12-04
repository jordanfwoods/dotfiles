#!bash
#
# This script is GENERATED and will be overwritten automatically.
# Do not modify it directly.  Instead, modify git-completion.tcsh
# and source it again.

source /home/jowoods/junk/dotfiles/git-completion.bash

# Remove the colon as a completion separator because tcsh cannot handle it
COMP_WORDBREAKS=${COMP_WORDBREAKS//:}

# For file completion, tcsh needs the '/' to be appended to directories.
# By default, the bash script does not do that.
# We can achieve this by using the below compatibility
# method of the git-completion.bash script.
__git_index_file_list_filter ()
{
	__git_index_file_list_filter_compat
}

# Set COMP_WORDS in a way that can be handled by the bash script.
COMP_WORDS=($2)

# The cursor is at the end of parameter #1.
# We must check for a space as the last character which will
# tell us that the previous word is complete and the cursor
# is on the next word.
if [ "${2: -1}" == " " ]; then
	# The last character is a space, so our location is at the end
	# of the command-line array
	COMP_CWORD=${#COMP_WORDS[@]}
else
	# The last character is not a space, so our location is on the
	# last word of the command-line array, so we must decrement the
	# count by 1
	COMP_CWORD=$((${#COMP_WORDS[@]}-1))
fi

# Call __git_wrap__git_main() or __git_wrap__gitk_main() of the bash script,
# based on the first argument
__git_wrap__${1}_main

IFS=$'\n'
if [ ${#COMPREPLY[*]} -eq 0 ]; then
	# No completions suggested.  In this case, we want tcsh to perform
	# standard file completion.  However, there does not seem to be way
	# to tell tcsh to do that.  To help the user, we try to simulate
	# file completion directly in this script.
	#
	# Known issues:
	#     - Possible completions are shown with their directory prefix.
	#     - Completions containing shell variables are not handled.
	#     - Completions with ~ as the first character are not handled.

	# No file completion should be done unless we are completing beyond
	# the git sub-command.  An improvement on the bash completion :)
	if [ ${COMP_CWORD} -gt 1 ]; then
		TO_COMPLETE="${COMP_WORDS[${COMP_CWORD}]}"

		# We don't support ~ expansion: too tricky.
		if [ "${TO_COMPLETE:0:1}" != "~" ]; then
			# Use ls so as to add the '/' at the end of directories.
			COMPREPLY=(`ls -dp ${TO_COMPLETE}* 2> /dev/null`)
		fi
	fi
fi

# tcsh does not automatically remove duplicates, so we do it ourselves
echo "${COMPREPLY[*]}" | sort | uniq

# If there is a single completion and it is a directory, we output it
# a second time to trick tcsh into not adding a space after it.
if [ ${#COMPREPLY[*]} -eq 1 ] && [ "${COMPREPLY[0]: -1}" == "/" ]; then
	echo "${COMPREPLY[*]}"
fi

