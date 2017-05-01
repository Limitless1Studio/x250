#!/bin/sh

echo !!! If you dont have Xcode installed, this will not work !!!
sleep 2
# Fix Audio
~/desktop/x250/ALC3232/ALC3232.command

# Load final config.plist file to EFI partition
diskutil mount /dev/disk0s1
cd ~/desktop/x250/Files
sudo cp 3_Final_config.plist /volumes/EFI/EFI/CLOVER
mv /volumes/EFI/EFI/CLOVER/config.plist /volumes/EFI/EFI/CLOVER/2_first_reboot_config.plist
mv /volumes/EFI/EFI/CLOVER/3_Final_config.plist /volumes/EFI/EFI/CLOVER/config.plist

# Create PFNL SSDT for Backlight Fix. Also making and installing
# AppleBacklightInjector o /Library/Extensions/
cd
mkdir ~/Projects
cd ~/Projects
git
git clone https://github.com/RehabMan/HP-ProBook-4x30s-DSDT-Patch probook.git
git clone https://github.com/RehabMan/OS-X-Clover-Laptop-Config.git guide.git
cd ~/Projects/guide.git
make
sudo cp -R ~/Projects/probook.git/kexts/AppleBacklightInjector.kext /Library/Extensions
cp ~/Projects/guide.git/build/SSDT-PNLF.aml /volumes/EFI/EFI/CLOVER/ACPI/patched
sudo kextcache -i /

# Cleaning up the mess we made on your desktop. Files will be archived
# in your home folder. Finder > Go > Home > Archive.
cd
mkdir Archive
mv ~/desktop/x250finished ~/Archive
mv ~/desktop/x250modified ~/Archive
mv ~/desktop/x250original ~/Archive
mv ~/desktop/x250 ~/Archive
mv ~/ssdtPRGen.sh ~/Archive
mv ~/Projects ~/Archive

echo Restart twice rebuilding the kext cache each time using 'sudo kextcahe -u /'
sleep 5
osascript -e 'tell application "Terminal" to quit' &
exit
