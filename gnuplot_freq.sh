#!/bin/bash
#* h***************************************************************************
# Generate Gnuplot from various data collected.
#
# Author...... : Olivier Gabathuler
# Created..... : 2009-09-16 OGA V1.0.0
# Modified.... : 2016-01-06 OGA V1.1.0
# Notes....... :
#
# Miscellaneous.
# --------------
# - Version: don't forget to update VERSION (look for VERSION below)!
# - Exit codes EXIT_xxxx are for internal use (see below).
#
#**************************************************************************h *#
# Specific GnuPlot functions
. ./fonctions.sh

# Main
echo "Begining $0"

# Version
VERSION=1.1.0

# Gnuplot Data
_TMP=~/tmp/$0.tmp.$$
_DATA="$1"
_FILE=`basename $_DATA`
_FIC=gnuplot/${_FILE}.png
_XMAX=`tail -n1 $_DATA | awk '{ print $1 }'`
_YMAX=`cat $_DATA | awk '{ print $2 }' | head -n1`

# Generate Plot if data exists
>$_TMP
f_set_terminal_png 7200 4800
f_set_margins
echo "set boxwidth 0.5" >> $_TMP
echo "set style fill solid" >> $_TMP
echo "set multiplot" >> $_TMP
echo "set key title \"Fréquence d'apparition des mots de $1 (loi de Zipf)\"" >> $_TMP
f_set_xlabel_logarithme
f_set_ylabel_logarithme
echo "set logscale x" >> $_TMP
echo "set logscale y" >> $_TMP
echo "set xrange [1:$_XMAX]" >> $_TMP
echo "set xtics (\"0\" 0.1, \"1\" 1, \"10\" 10, \"100\" 100, \"1000\" 1000, \"10000\" 10000)" >> $_TMP
echo "set yrange [1:$(($_YMAX + $_YMAX * 10))]" >> $_TMP
echo "set ytics (\"0\" 0.1, \"1\" 1, \"10\" 10, \"100\" 100, \"1000\" 1000, \"10000\" 10000)" >> $_TMP
#echo "set samples 10" >> $_TMP
echo -n "plot " >> $_TMP
echo " adding ${_DATA} ..."
f_plot_BOXES3 "$_DATA" 1 2 8 3
echo " generating ${_FIC} ..."
printf "\nEOF" >> $_TMP
chmod u+x $_TMP
$_TMP > ${_FIC}
rm $_TMP 2>/dev/null

# End
echo "Ending $0"
