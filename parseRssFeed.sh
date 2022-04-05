#!/bin/bash

[ ! `which sponge` ]	&& sudo apt install moreutils

f_curl () {
	curl --silent "$1" | sed -e 's/<item>/\n/g' | pcregrep -o1 '<title><!\[CDATA\[(.*)\]\]></title>' >> $2
	sort -u $2 | tr '|' ':' | sponge $2
}

f_curl2 () {
        curl --silent "$1" | sed -e 's/<item>/\n/g' | pcregrep -o1 '<title>(.*)</title>' >> $2
        sort -u $2 | tr '|' ':' | sponge $2
}

cd "$(dirname "$0")"

# Le monde
RSS_URL="https://www.lemonde.fr/rss/en_continu.xml"
FILE=./gros_titres_france.txt
f_curl $RSS_URL $FILE

# Le monde
RSS_URL="https://www.lemonde.fr/international/rss_full.xml"
FILE=./gros_titres_international.txt
f_curl $RSS_URL $FILE

# Le monde
RSS_URL="https://www.lemonde.fr/jeux-video/rss_full.xml"
FILE=./gros_titres_jeux-video.txt
f_curl $RSS_URL $FILE

# BBC
RSS_URL="http://feeds.bbci.co.uk/news/world/rss.xml"
FILE=./gros_titres_bbc_world.txt
f_curl $RSS_URL $FILE

# BBC
RSS_URL="http://feeds.bbci.co.uk/news/technology/rss.xml"
FILE=./gros_titres_bbc_technology.txt
f_curl $RSS_URL $FILE

# Intellasia
RSS_URL="https://www.intellasia.net/category/vietnam/economy/feed"
FILE=./gros_titres_intellasia_vietnam_economy.txt
f_curl2 $RSS_URL $FILE
