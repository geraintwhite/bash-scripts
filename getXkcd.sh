#!/bin/bash

wget http://dynamic.xkcd.com/random/comic/ -nv -O xkcd
comic=$(sed '66q;d' xkcd | sed -n 's/.*<img src="\([^"]*\)".*/\1/p')
wget $comic
rm xkcd
xdg-open $(echo $comic |  sed 's:.*/::')
