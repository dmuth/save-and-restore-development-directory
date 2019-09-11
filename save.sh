#!/bin/bash
#
# This script will go through a directory, get the 
# remote called "origin" for every Git repo, and then print
# out all directory and remove information, so that the 
# entire directory structure can be recreated on another computer.
#


# Errors are fatal
set -e

echo "# "
echo "# Save your development/ directory."
echo "# "
echo "# Git Repo: https://github.com/dmuth/save-and-restore-development-directory "
echo "# "

if test ! "$2"
then
	echo "! "
	echo "! Syntax: $0 directory output_file"
	echo "! "
	echo "! directory - Top-level directory to get Git remotes from. "
	echo "! 	There can be as much nesting as you like. :-)"
	echo "! "
	echo "! output_file - Where to write the directory and Git remote information"
	echo "! "
	echo "! "
	exit 1
fi

SRC=$1
DEST=$PWD/$2
ORIG=$PWD

pushd $SRC > /dev/null

echo "# "
echo "# Starting in $SRC..."
echo "# "

#
# Remove the destination file if it already exists :-)
#
echo -n > $DEST

for DIR in $(find . -name .git -type d)
do

	echo "Checking ${DIR}..."

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

	echo -e "${DIR}\t${REMOTE}" >> $DEST

done

echo "# "
echo "# Done!  Git repo data written to ${DEST}"
echo "# "




