#!/bin/sh
# Move .AML files to patched folder
echo !!! All DSDT/SSDT files should be patched and in x250finished !!!
sleep 5
cd ~/desktop/x250finished
sudo cp *.aml /volumes/efi/efi/clover/acpi/patched
cd ~/desktop/x250/kexts
sudo cp -R *.kext /System/Library/Extensions
sudo chown -R root:wheel /System/Library/Extensions
sudo chmod -R go-w /System/Library/Extensions
echo "Sleeping for 20 seconds before rebuild of kext cache - wait … "
sleep 20
sudo touch /System/Library/Extensions && sudo kextcache -u /
osascript -e 'tell application "Terminal" to quit' &
exit
