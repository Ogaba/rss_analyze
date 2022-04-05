#!/bin/bash
#* h***************************************************************************
# For each .txt file, anlayse words frequencies
# For each .gp file, generate gnuplot frequencies
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

# For each .txt file, analyse words frequencies
ls data/*.txt | while read _FIC; do
        ./analyze.sh "$_FIC"
done

# For each .gp file, generate gnuplot frequencies
ls data/*.gp | while read _FIC; do
	./gnuplot_freq.sh "$_FIC"
done
