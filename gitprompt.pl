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
my $prompt  = "";  # What will be printed to prompt
my $GITBR   = "";  # Where the current working github branch is stored
my $GITST   =  0;  # Saves the Number of files to commit.
my $GITPUSH =  0;  # Saves the Number of files to commit.

# Saves the current working branch name
open IF, "/usr/bin/git branch 2>/dev/null|" or exit;
while(<IF>) {
  if (/^\* (.*)/) {

    $GITBR=$1;
    last;
  }
}
close IF;

open IF, "/usr/bin/git status --porcelain 2>/dev/null|" or exit;
while(<IF>) { $GITST++; }  # Count number of files to check in
close IF;

# Saves the Color based on current working branch name.
my $COL="0;37m"; # Always Grey

# Earmarks the Colored Branch to be printed in parentheses.
# An Asterisk identifies need for commit.
if ( $GITBR ne "" ) {
  $prompt .= "\033[$COL\(${GITBR}";
  $prompt .= "*" if ( ${GITST} > 0 );
  $prompt .= "!" if ( ${GITPUSH} > 0 );
  $prompt .= "\)\033[0m ";
}

# Print $prompt to the console.
print($prompt);
