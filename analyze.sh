#!/bin/bash
#* h***************************************************************************
# Orderly Ranking of Words 
#
# Author...... : Olivier Gabathuler
# Created..... : 2022-01-03 OGA V1.0.0
# Modified.... : 2022-04-17 OGA V1.0.1
# Notes....... : inspired by https://commons.wikimedia.org/wiki/File:Graphique_Zipf_pour_Ulysses.png
#
# Miscellaneous.
# --------------
# - Version: don't forget to update VERSION (look for VERSION below)!
# - Exit codes EXIT_xxxx are for internal use (see below).
#
#**************************************************************************h *#
# Version
VERSION=1.0.1

# Check params
[ $# -eq 0 ] && exit

# Classement ordonné des mots de $1
_1=$1
_DIR=`dirname $_1`
_FILE=`basename $_1 | cut -d'.' -f1`
cat ${_1}				|\
iconv -f UTF-8 -t ASCII//TRANSLIT	|\
tr ' ' '\n'				|\
tr -d "<>%‘…»«,;.():?!\*'\""		|\
tr '[A-Z]' '[a-z]'			|\
sed '/^$/d'				|\
sed '/^-$/d'				|\
sed '/^[a-z]$/d'			|\
sed '/^[0-9]*$/d'			|\
sed 's/^ //'				|\
sort					|\
uniq -c					|\
sort -r -g -k1				> ${_DIR}/${_FILE}.words

# Ajout du rang en abscisse
awk '{ print $1 }' ${_DIR}/${_FILE}.words | pr -n -t > ${_DIR}/${_FILE}.words.gp
