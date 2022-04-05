#!/bin/bash
#* h***************************************************************************
# Common Gnuplot Functions
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
VERSION=1.1.0
# Function GnuPlot

f_set_terminal_png()
{ # Common header to plot in PNG graphics
 V_SIZE=40
 H_SIZE=120
 H_SIZE2=`echo "$H_SIZE + 8" | bc`
 echo "gnuplot<<EOF" > $_TMP
 echo -n "set terminal png size $1,$2 " >> $_TMP
 echo -n "$H_SIZE2 " >> $_TMP
 echo "$V_SIZE + 8" | bc >> $_TMP
}

f_set_margins()
{
 echo "set lmargin at screen 0.15" >> $_TMP
 echo "set rmargin at screen 0.85" >> $_TMP
 echo "set bmargin at screen 0.1" >> $_TMP
 echo "set tmargin at screen 0.9" >> $_TMP
}

f_set_styleline()
{
# $1 : point size
echo "set style line 2 lt rgb \"red\" lw $1" >> $_TMP
echo "set style line 3 lt rgb \"orange\" lw $1" >> $_TMP
echo "set style line 4 lt rgb \"yellow\" lw $1" >> $_TMP
echo "set style line 5 lt rgb \"green\" lw $1" >> $_TMP
echo "set style line 6 lt rgb \"cyan\" lw $1" >> $_TMP
echo "set style line 7 lt rgb \"blue\" lw $1" >> $_TMP
echo "set style line 8 lt rgb \"violet\" lw $1" >> $_TMP
echo "set style line 9 lt rgb \"skyblue\" lw $1" >> $_TMP
echo "set style line 10 lt rgb \"turquoise\" lw $1" >> $_TMP
echo "set style line 11 lt rgb \"magenta\" lw $1" >> $_TMP
echo "set style line 12 lt rgb \"olive\" lw $1" >> $_TMP
echo "set style line 13 lt rgb \"beige\" lw $1" >> $_TMP
echo "set style line 14 lt rgb \"orchid\" lw $1" >> $_TMP
echo "set style line 15 lt rgb \"salmon\" lw $1" >> $_TMP
echo "set style line 16 lt rgb \"seagreen\" lw $1" >> $_TMP
echo "set style line 17 lt rgb \"pink\" lw $1" >> $_TMP
echo "set style line 18 lt rgb \"gray\" lw $1" >> $_TMP
echo "set style line 19 lt rgb \"black\" lw $1" >> $_TMP
}

f_set_linetype()
{
# $1 : linetype
# $2 : point size
case $1 in
	2) echo "set linetype 2 linecolor \"red\" lw $2" >> $_TMP;;
	5) echo "set linetype 5 linecolor \"green\" lw $2" >> $_TMP;;
	*) echo "set linetype 19 linecolor \"black\" lw $2" >> $_TMP;;
esac
}

f_plot_linespoints_CSPLINES()
{ # $1 : file
  # $2 : Y
  # $3 : X
  # $4 : point size
  # $5 : linestyle
 printf "\"${1}\" u $3:$2 t \"$1\" w linespoints linestyle $5 pointtype $5 pointsize $4 smooth csplines" >> $_TMP
}

f_plot_LP4()
{ # $1 : file
  # $2 : Y
  # $3 : X
  # $4 : point size
  # $5 : linestyle
 printf "\"${1}\" u $3:$2 t \"$1 (Y axis)\" w points linestyle $5 pointtype $5 pointsize $4" >> $_TMP
}

f_plot_LP3()
{ # $1 : file
  # $2 : Y
  # $3 : X
  # $4 : point size
  # $5 : pointtype and linestyle
 printf "\"${1}\" u $3:$2 t \"$1 (Y axis)\" w linespoints linestyle $5 pointtype $5 pointsize $4" >> $_TMP
}

f_plot_BOXES3()
{ # $1 : file
  # $2 : Y
  # $3 : X
 printf "\"${1}\" u $3:$2 t \"$1 (Y axis)\" w boxes noenhanced" >> $_TMP
}

f_plot_LP2()
{ # $1 : file
  # $2 : title
  # $3 : X
  # $4 : Y
  # $5 : point size
 printf "\"${1}\" u $3:$4 t \"$2\" w linespoints linestyle $4 pointtype $4 pointsize $5" >> $_TMP
}

f_plot_LP()
{ # $1 : file
  # $2 : title
  # $3 : X
  # $4 : Y
  # $5 : point size
 printf "\"${1}\" u $3:$4 t \"$2\" w linespoints linestyle 1 linetype 1 linewidth "`echo "$5 * $5"|bc -l`" pointtype $4 pointsize $5 linecolor rgb '#"`echo "$4 ^ 3"|bc -l`"ad'" >> $_TMP
}

f_set_xlabel_nombre()
{
 printf "\nset xlabel \"longueur du mot de départ en nombre de caractères\"\n" >> $_TMP
}

f_set_xlabel_nombre_seq()
{
 printf "\nset xlabel \"nombre de gros titres\"\n" >> $_TMP
}

f_set_xlabel_nombre_lev()
{
 printf "\nset xlabel \"Distance cumulée entre les mots d'une phrase (échelle linéaire)\"\n" >> $_TMP
}

f_set_xlabel_nombre_lev_log()
{
 printf "\nset xlabel \"Distance cumulée entre les mots d'une phrase (échelle logarithmique)\"\n" >> $_TMP
}

f_set_ylabel_nombre_titres()
{
 printf "\nset ylabel \"Nombre de gros titres uniques (échelle linéaire)\"\n" >> $_TMP
}

f_set_ylabel_nombre_titres_uniques()
{
 printf "\nset ylabel \"Nombre de gros titres uniques (échelle linéaire)\"\n" >> $_TMP
}

f_set_ylabel_nombre_seq_titres_uniques()
{
 printf "\nset ylabel \"Fréquence d'apparition de ces gros titres (échelle linéaire)\"\n" >> $_TMP
}

f_set_y2label_nombre_seq_titres_uniques()
{
 printf "\nset y2label \"Fréquence d'apparition de ces gros titres (échelle linéaire)\"\n" >> $_TMP
}

f_set_ylabel_logarithme_seq_titres_uniques()
{
 printf "\nset ylabel \"Fréquence d'apparition de ces gros titres (échelle logarithmique)\"\n" >> $_TMP
}

f_set_ylabel_logarithme_titres_uniques()
{
 printf "\nset ylabel \"Fréquence de gros titres uniques (échelle logarithmique)\"\n" >> $_TMP
}

f_set_ylabel_nombre_lev_seq()
{
 printf "\nset ylabel \"Fréquence d'apparition d'une longueur de phrase (échelle linéaire)\"\n" >> $_TMP
}

f_set_ylabel_nombre_lev_seq_titres()
{
 printf "\nset ylabel \"Fréquence d'apparition d'une longueur de gros titre (échelle linéaire)\"\n" >> $_TMP
}

f_set_ylabel_nombre_lev_seq_log()
{
 printf "\nset ylabel \"Fréquence d'apparition d'une longueur de phrase (échelle logarithmique)\"\n" >> $_TMP
}
