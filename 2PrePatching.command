#!/bin/sh
echo !!! You must have the USB inserted for this to work !!!
sleep 3
# Disable apps from anywhere
sudo spctl --master-disable

# Disable Hibernate
sudo pmset -a hibernatemode 0
sudo pmset -a autopoweroff 0
sudo pmset -a standby 0
sudo rm /private/var/vm/sleepimage
sudo touch /private/var/vm/sleepimage
sudo chflags uchg /private/var/vm/sleepimage

# Disable dock open delay
defaults write com.apple.Dock autohide-delay -float 0 && killall Dock

# Show File path in Finder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true; killall Finder
# Give permissions to all needed commands
cd ~/desktop/x250/ALC3232
chmod 755 ALC3232.command
cd ~/desktop/x250/Files
chmod 775 ssdtPRgensh.command
chmod 755 3PostPatching.command
chmod 755 4Final.command

# Show sleep status. Uncomment if you want to see it.
#sudo pmset -g custom | grep "hibernatemode \|standby \|autopoweroff "

# Move iasl, voodoodaemon, remove unneeded voodoo related kexts
cd ~/desktop/x250/Files
sudo cp iasl /usr/bin/
sudo cp VoodooPS2Daemon /usr/bin/
sudo cp org.rehabman.voodoo.driver.Daemon.plist /Library/LaunchDaemons
sudo rm -rf /System/Library/Extensions/AppleACPIPS2Nub.kext
sudo rm -rf /System/Library/Extensions/ApplePS2Controller.kext

# Create patching directory
cd ~/desktop
mkdir x250original
mkdir x250modified
mkdir x250finished

# Moving Extracted .aml files from USBs EFI
cd /volumes/Clover\ EFI/efi/clover/ACPI/origin
sudo cp DSDT.aml ~/desktop/x250original
sudo cp SS**.aml ~/desktop/x250original
sudo rm -rf ~/desktop/x250original/SSDT-*x.aml
mv ~/desktop/x250original/SSDT-0.aml ~/desktop/x250finished
mv ~/desktop/x250original/SSDT-2.aml ~/desktop/x250finished
mv ~/desktop/x250original/SSDT-4.aml ~/desktop/x250finished
mv ~/desktop/x250original/SSDT-5.aml ~/desktop/x250finished
mv ~/desktop/x250original/SSDT-9.aml ~/desktop/x250finished
mv ~/desktop/x250original/SSDT-11.aml ~/desktop/x250finished
mv ~/desktop/x250original/SSDT-12.aml ~/desktop/x250finished
cd ~/desktop/x250/Files
sudo cp SSDT-BATC.dsl ~/desktop/x250modified

# Create Power management SSDT.dsl
~/desktop/x250/files/ssdtPRgensh.command
cd ~/desktop/x250original
iasl -da -dl *.aml
sudo cp DSDT.dsl ~/desktop/x250modified
sudo cp SSDT-1.dsl ~/desktop/x250modified
sudo cp SSDT-3.dsl ~/desktop/x250modified
sudo cp SSDT-10.dsl ~/desktop/x250modified
mv ~/desktop/x250modified/ssdt.dsl ~/desktop/x250modified/SSDT.dsl
# Mount SSD/HHD EFI partition
diskutil unmount /dev/disk1s1
diskutil unmount /dev/disk1s2
diskutil mount /dev/disk0s1
cd ~/desktop/x250/Files
sudo cp HFSPlus.efi /volumes/EFI/EFI/CLOVER/drivers64UEFI
sudo cp 2_first_reboot_config.plist /volumes/EFI/EFI/CLOVER
mv /volumes/EFI/EFI/CLOVER/config.plist /volumes/EFI/EFI/CLOVER/1_for_install_config.plist
mv /volumes/EFI/EFI/CLOVER/2_first_reboot_config.plist /volumes/EFI/EFI/CLOVER/config.plist
echo --- All clear to remove the USB drive. You shouldnt need it again! ---
echo --- Patch DSDT and SSDTs. Save all .dsl x250modified --> x250finished as .aml. ---
sleep 5
osascript -e 'tell application "Terminal" to quit' &
exit
