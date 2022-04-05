#!/bin/bash
#* h***************************************************************************
# For each .gp file, generate gnuplot frequencies and log frequencies
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

# For each .lev_freq file, generate gnuplot frequencies and log
ls data/*.lev_freq | while read _FIC; do
	./gnuplot_lev_freq.sh "$_FIC"
	./gnuplot_lev_freq_log.sh "$_FIC"
done
