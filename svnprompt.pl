#!/usr/bin/perl
# Bit of a hack to get the git status into the csh prompt.
# Put this script in ~/gitprompt.pl and add these lines to your .tcshrc
#   if ( $?prompt && -x /opt/rh/rh-git218/root/usr/bin/git && -x ~/gitprompt.pl ) then
#       alias precmd ~/gitprompt.pl
#   endif

# Libraries
use Socket;
use Cwd qw(cwd);

# Variables
my $prompt = "";  # What will be printed to prompt
my $info   = 0;
my $count  = 0;

# check to see if it is a valid SVN repo
open IF, "/usr/bin/svn info . 2>/dev/null|" or exit;
while(<IF>) { $info++; }
close IF;

# check to see if there are any local changes to repo
open IF, "/usr/bin/svn status . 2>/dev/null|" or exit;
while(<IF>) { 
  # Ignore External definitioned directories.
  if    (/^X (.*)/)          { }
  # Ignore Empty lines
  elsif (/^$/)               { }
  # Ignore secondary lines for External defitions.
  elsif (/^Performing (.*)/) { }
  # Count any other changes.
  else                       { $count++; }
}
close IF;

# Saves the Color based on current working branch name.
my $COL="0;37m"; # Always Grey

# Earmarks the Colored Branch to be printed in parentheses.
# An Asterisk identifies need for commit.
if ( $info ne 0 ) {
  $prompt .= "\033[$COL\(svn";
  $prompt .= "*" if ( ${count} > 0 );
  $prompt .= "\)\033[0m ";
}

# Print $prompt to the console.
print($prompt);
