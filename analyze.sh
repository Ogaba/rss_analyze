#!/bin/bash
#* h***************************************************************************
# Orderly Ranking of Words 
#
# Author...... : Olivier Gabathuler
# Created..... : 2022-01-03 OGA V1.0.0
# Modified.... : 
# Notes....... :
#
# Miscellaneous.
# --------------
# - Version: don't forget to update VERSION (look for VERSION below)!
# - Exit codes EXIT_xxxx are for internal use (see below).
#
#**************************************************************************h *#
# Main

# Version
VERSION=1.0.0

# Check params
[ $# -eq 0 ] && exit

# Classement ordonné des mots de $1
_1=$1
_DIR=`dirname $_1`
_FILE=`basename $_1 | cut -d'.' -f1`
cat ${_1}				|\
iconv -f UTF-8 -t ASCII//TRANSLIT	|\
tr ' ' '\n'				|\
tr -d '…»«,;.():?!\*'			|\
tr '[A-Z]' '[a-z]'			|\
tr ' ' '\n'				|\
sed '/^$/d'				|\
sed '/^[a-z]$/d'			|\
sed '/^[0-9]+/d'			|\
sed 's/^ //'				|\
sort					|\
uniq -c					|\
sort -r -g -k1				> ${_DIR}/${_FILE}.words

>${_DIR}/${_FILE}.words.gp
_I=1
awk '{ print $1 }' ${_DIR}/${_FILE}.words | while read _LINE; do
	echo "$_I $_LINE" >> ${_DIR}/${_FILE}.words.gp
	_I=$(($_I + 1))
done
