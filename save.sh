#!/bin/bash
#
# This script will go through a directory, get the 
# remote called "origin" for every Git repo, and then print
# out all directory and remove information, so that the 
# entire directory structure can be recreated on another computer.
#


# Errors are fatal
set -e

>&2 echo "# "
>&2 echo "# Save your development/ directory."
>&2 echo "# "
>&2 echo "# Git Repo: https://github.com/dmuth/save-and-restore-development-directory "
>&2 echo "# "

if test ! "$2"
then
	>&2 echo "! "
	>&2 echo "! Syntax: $0 directory output_file"
	>&2 echo "! "
	>&2 echo "! directory - Top-level directory to get Git remotes from. "
	>&2 echo "! 	There can be as much nesting as you like. :-)"
	>&2 echo "! "
	>&2 echo "! output_file - Where to write the directory and Git remote information (Specify a dash for stdout)"
	>&2 echo "! "
	>&2 echo "! "
	exit 1
fi

SRC=$1
DEST=$PWD/$2
ORIG=$PWD

#
# Save stdout
#
exec 6>&1

#
# If we're not writing to stdout, redirect stdout to our output file.
#
if test "$2" != "-"
then
	exec 1> $DEST
fi

pushd $SRC > /dev/null

>&2 echo "# "
>&2 echo "# Starting in $SRC..."
>&2 echo "# "

#
# Remove the destination file if it already exists :-)
#
echo -n

for DIR in $(find . -name .git -type d)
do

	>&2 echo "Checking ${DIR}..."

	#
	# Get the name of the directory over the .git directory
	#
	DIR=$(dirname $DIR)

	#
	# Drop into that directory, get the remove, and jump back out!
	#
	pushd $DIR > /dev/null
	REMOTE=$(git remote -v | egrep ^origin | head -n1 | awk '{print $2}')
	popd > /dev/null

	#
	# Skip anything without a remove
	#
	if test ! "$REMOTE"
	then
		continue
	fi

	echo -e "${DIR}\t${REMOTE}" 

done

exec 1>&6

>&2 echo "# "
>&2 echo "# Done!  Git repo data written to ${DEST}"
>&2 echo "# "




