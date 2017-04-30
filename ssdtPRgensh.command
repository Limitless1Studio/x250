#!/bin/sh

curl -o ~/ssdtPRGen.sh https://raw.githubusercontent.com/Limitless1Studio/ssdtPRGen.sh-Command/Beta/ssdtPRGen.sh
chmod a+x ssdtPRGen.sh
sleep 5
~/ssdtPRGen.sh
mv ~/Library/ssdtPRGen/ssdt.dsl ~/desktop/x250/Files
