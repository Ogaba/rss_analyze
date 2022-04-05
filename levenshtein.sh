#!/bin/bash

[ ! `which sponge` ]	&& sudo apt install moreutils

# https://fr.wikipedia.org/wiki/Mesure_de_similarit%C3%A9

# En mathématiques et en informatique théorique, une mesure de similarité, plus exactement une mesure de distance entre mots, est une façon de représenter par un nombre la différence entre deux mots, ou plus généralement deux chaînes de caractères. Cela permet de comparer des mots ou chaines de façon simple et pratique. C'est donc une forme de distance mathématique et de métrique pour les chaînes de caractères.

# En programmation, la mesure la plus simple et la plus courante est la distance de Levenshtein : elle est obtenue en comptant le nombre de modification de caractères individuels (ajout, retrait, ou changement) pour passer d'une chaîne à l'autre. 

# Ici on s'appuie sur une fonction compilée en C : levenshtein_s.o dont le code source est levenshtein_s.c :
f_levenshtein () {
 ls $_LIST_FILES | while read _FIC; do
  if [ -s "$_FIC" ]; then
   _DIR_FREQ=`dirname $_FIC`
   _NAME_FREQ=`basename $_FIC`.lev_freq
   _FIC_FREQ="${_DIR_FREQ}/${_NAME_FREQ}"
   >$_FIC_FREQ
   echo "Traitement de $_FIC en cours"
   cat $_FIC | while read _LINE; do
    IFS=" "
    _LVS=`levenshtein_s.o "$_LINE"`
    echo "${_LVS}" >> "${_FIC_FREQ}"
   done
   cat "${_FIC_FREQ}" | sort -g | uniq -c | sponge "${_FIC_FREQ}"
  fi
 done
}

# Calcul de la distance de levenshtein cumulée entre les mots d'une ligne d'un fichier :
cd "$(dirname "$0")"
mkdir lev_freq 2>/dev/null
if [ -n "$1" ]; then
 echo "Traitement des fichiers $1"
 _LIST_FILES="$1"
 f_levenshtein
else
 echo "Traitement des fichiers *.txt"
 _LIST_FILES="data/*.txt"
 f_levenshtein
fi
