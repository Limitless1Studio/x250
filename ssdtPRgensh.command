#!/bin/sh

curl -o ~/ssdtPRGen.sh https://raw.githubusercontent.com/Limitless1Studio/ssdtPRGen.sh-Command/Beta/ssdtPRGen.sh
cd
chmod a+x ssdtPRGen.sh
~/ssdtPRGen.sh
mv ~/Library/ssdtPRGen/ssdt.dsl ~/x250orginal
osascript -e 'quit app "TextEdit"'
