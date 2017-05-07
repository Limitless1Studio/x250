#!/bin/sh
clear
echo Before Patching there are two mission critical reboots that need to happen. You will receive a number of prompts at the begging of this script to make sure the patching and implementation of fixes goes correctly.
sleep 5
clear
echo Mounting the EFI partion.
diskutil mount /dev/disk0s1
clear
# Ensure HFSplus is in SSDs EFI partion before reboot.
read -r -p "Have you placed HFSplus.efi in the HHD/SSD's EFI partition? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    clear
    continue
else
    clear
    diskutil mount /dev/disk0s1
    cd ~/desktop/x250/Files
    #sudo cp HFSPlus.efi /volumes/EFI/EFI/CLOVER/drivers64UEFI
    sudo cp HFSPlus.efi /volumes/ESP/EFI/CLOVER/drivers64UEFI
    echo HSFPlus.efi is now in place.
    sleep 5
fi
# Ensure that vital kexts are in place before rebooting.
read -r -p "Have you placed FakeSMC, IntelMausiEthernet, and VoodooPS2Controller kexts on the HHD/SSDs EFI partition? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    clear
    continue
else
    clear
    cd ~/desktop/x250/kexts
    sudo cp -R VoodooPS2Controller.kext /volumes/ESP/EFI/CLOVER/Kexts/Other
    #sudo cp -R VoodooPS2Controller.kext /volumes/EFI/EFI/CLOVER/Kexts/Other
    sudo cp -R IntelMausiEthernet.kext /volumes/ESP/EFI/CLOVER/Kexts/Other
    #sudo cp -R IntelMausiEthernet.kext /volumes/EFI/EFI/CLOVER/Kexts/Other
    sudo cp -R FakeSMC.kext /volumes/ESP/EFI/CLOVER/Kexts/Other
    #sudo cp -R FakeSMC.kext /volumes/EFI/EFI/CLOVER/Kexts/Other
    echo Kexts have been moved.
    Sleep 5
fi
# Ask User if they would like to compelte first reboot.
read -r -p "Would you like to complete the first reboot now? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    clear
    echo Sending restart command in 5 seconds.
    sleep 5
    osascript -e 'tell application "System Events" to restart'
    exit
else
    clear
    continue
fi
# Check check if ig-plaform-id and kexttopatch patches are enabled
read -r -p "Have you changed ig-platform-id and enabled the kextstopatch for graphics? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    clear
    continue
else
    clear
    echo In Xcode expand Graphics and change ig-platform-id to 0x16260006.
    echo #
    echo In Xcode expand KernelAndKextPatches > KextsToPatch > Items 0 - 3 and change Disabled Boolean to No for all four.
    echo #
    echo You must manually save the config.plist file after you make the changes above and quit Xcode manually.
    sleep 10
    echo Opening config.plist
    open /volumes/EFI/EFI/CLOVER/config.plist
    sleep 45
fi
# Check check if ig-plaform-id and kexttopatch patches are enabled
read -r -p "Would you like to reboot for the second time and rebuild the kext cache? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    clear
    sudo touch /System/Library/Extensions && sudo kextcache -u /
    echo Sending restart command in 5 seconds.
    sleep 5
    osascript -e 'tell application "System Events" to restart'
    exit
else
    clear
    continue
fi
# Ask user if they would like app from anywhere fixed
read -r -p "Would you like to enable apps from anywhere? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    clear
    sudo spctl --master-disable
    echo Apps From Anywhere is enabled.
    sleep 2
else
    clear
    continue
fi
# Disable Hibernate
read -r -p "Would you like to disable Hibernate? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    clear
    sudo pmset -a hibernatemode 0
    sudo pmset -a autopoweroff 0
    sudo pmset -a standby 0
    sudo rm /private/var/vm/sleepimage
    sudo touch /private/var/vm/sleepimage
    sudo chflags uchg /private/var/vm/sleepimage
    echo Hibernate is disabled. This maybe necessary to do again after OS updates.
    sleep 3
else
    clear
    continue
fi
# Show sleep status. Uncomment if you want to see it.
read -r -p "Would you like to check Hibernate status? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
sudo pmset -g custom | grep "hibernatemode \|standby \|autopoweroff "
else
    clear
    continue
fi
# Disable dock open delay
read -r -p "Would you like to disable Dock opening delay? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    clear
    defaults write com.apple.Dock autohide-delay -float 0 && killall Dock
    echo Autohide delays have been removed from dock.
    sleep 5
else
    clear
    continue
fi
# Show File path in Finder
read -r -p "Would you like to show the folder bath in the Title of Finder windows? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    clear
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true; killall Finder
    echo Full file path will now show in Finder Title.
else
    clear
    continue
fi
# Give permissions to all needed commands
read -r -p "Would you like to show the folder bath in the Title of Finder windows? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo Assigning permissions to all other neccessay scripts.
    cd ~/desktop/x250/ALC3232
    chmod 755 ALC3232.command
    cd ~/desktop/x250/Files
    chmod 775 ssdtPRgensh.command
    chmod 755 3PostPatching.command
    chmod 755 4Final.command
    clear
    echo Done!
    sleep 3
else
    clear
    continue
fi
# Move iasl, voodoodaemon, remove unneeded voodoo related kexts
read -r -p "Would you like to move iasl and VoodooPS2Daemon to /usr/bin and remove unecessary VoodooPS2Controller Files? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    cd ~/desktop/x250/Files
    sudo cp iasl /usr/bin/
    sudo cp VoodooPS2Daemon /usr/bin/
    sudo cp org.rehabman.voodoo.driver.Daemon.plist /Library/LaunchDaemons
    sudo rm -rf /System/Library/Extensions/AppleACPIPS2Nub.kext
    sudo rm -rf /System/Library/Extensions/ApplePS2Controller.kext
    echo Files have been moved and unecssary files removed.
    sleep 3
else
    clear
    continue
fi
# Create patching directory
read -r -p "Would you like to create a directory for patching? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    cd ~/desktop
    mkdir x250original
    mkdir x250modified
    mkdir x250finished
    echo Folders are created and on the desktop.
    sleep 3
    clear
else
    clear
    continue
fi
# Moving Extracted .aml files from USBs EFI
read -r -p "Would you like to create a directory for patching? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    cd /volumes/EFI/EFI/CLOVER/ACPI/origin
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
    echo BATC SSDT created.
    sleep 3
    clear
else
    clear
    continue
fi
# Create Power management SSDT.dsl
read -r -p "Would you like to create a Power Management SSDT? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    ~/desktop/x250/files/ssdtPRgensh.command
    cd ~/desktop/x250original
    iasl -da -dl *.aml
    sudo cp DSDT.dsl ~/desktop/x250modified
    sudo cp SSDT-1.dsl ~/desktop/x250modified
    sudo cp SSDT-3.dsl ~/desktop/x250modified
    sudo cp SSDT-10.dsl ~/desktop/x250modified
    mv ~/desktop/x250modified/ssdt.dsl ~/desktop/x250modified/SSDT.dsl
    echo Power Management SSDT created.
    sleep 3
    clear
else
    clear
    continue
fi
# Create PFNL SSDT for Backlight Fix. Also making and installing
# AppleBacklightInjector to /Library/Extensions/
read -r -p "Would you like to create PNFL and fix AppleBacklight? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    cd
    mkdir ~/Projects
    cd ~/Projects
    git
    git clone https://github.com/RehabMan/HP-ProBook-4x30s-DSDT-Patch probook.git
    git clone https://github.com/RehabMan/OS-X-Clover-Laptop-Config.git guide.git
    cd ~/Projects/guide.git
    make
    sudo cp -R ~/Projects/probook.git/kexts/AppleBacklightInjector.kext /Library/Extensions
    cp ~/Projects/guide.git/build/SSDT-PNLF.aml ~/dekstop/x250finished
    clear
    echo PNFL.aml created and AppleBacklightInjector is moved.
    sleep 5
    clear
else
    clear
    continue
fi
# Fix Audio
read -r -p "Would you like to fix Audio? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    ~/desktop/x250/ALC3232/ALC3232.command
else
    clear
    continue
fi
osascript -e 'tell application "Terminal" to quit' &
exit
