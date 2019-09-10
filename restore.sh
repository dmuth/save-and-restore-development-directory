#!/bin/bash
#
# This script will check out a bunch of Git repos into directories
# specified by the save file created by the save.sh script
# under the directory specified.
#

# Errors are fatal
set -e


if test ! "$2"
then
	echo "! "
	echo "! Syntax: $0 file directory"
	echo "! "
	echo "! file - The file written by save.sh which has directories and Git remotes."
	echo "! directory - The target directory to do all checkouts under"
	echo "! "
	exit 1
fi

SRC=$1
DEST=$2

if test ! -r $SRC
then
	echo "! "
	echo "! Unable to read file '${SRC}'!"
	echo "! "
	exit 1
fi

echo "# "
echo "# Restoring Git repos from ${SRC}..."
echo "# "

#
# Fully qualify our source file since we'll be going to the new one
#
SRC=$PWD/$SRC

pushd $DEST > /dev/null


#
# Change our input field separtor to only break on newlines
#
IFS_OLD=$IFS
IFS=$'\n'

#
# Go through each directory/repo combination, create the directory,
# change to the directory, and check out the repo
#
for LINE in $(cat $SRC)
do
	DIR=$(echo $LINE | cut -f1)
	REPO=$(echo $LINE | cut -f2)

	if test -d $DIR
	then
		echo "# "
		echo "# Directory ${DIR} already exists, skipping it..."
		echo "# "
		echo "# (Note that it may not have a valid Git checkout, if in doubt, remove it!)"
		echo "# "
		echo "# "
		continue
	fi

	echo "# "
	echo "# Restoring ${DIR} with ${REPO}..."
	echo "# "

	mkdir -p $DIR
	pushd $DIR > /dev/null
	git clone $REPO .
	popd >/dev/null

done


#
# Restore the input field separator
#
IFS=$IFS_OLD


