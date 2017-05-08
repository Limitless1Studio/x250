#!/bin/sh
clear
echo Before Patching there are two mission critical reboots that need to happen. You will receive a number of prompts at the begging of this script to make sure the patching and implementation of fixes goes correctly.
sleep 5
clear
echo Mounting the EFI partion.
diskutil mount /dev/disk0s1
clear
# Ensure HFSplus is in SSDs EFI partion before reboot.
echo Enter no to move the file. Enter yes if this task has already been completed.
echo # Blank line
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
    sudo cp -a HFSPlus.efi /volumes/ESP/EFI/CLOVER/drivers64UEFI
    echo HSFPlus.efi is now in place.
    sleep 5
fi
# Ensure that vital kexts are in place before rebooting.
echo Enter no to move the Kexts. Enter yes if this task has already been completed.
echo # Blank line
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
    echo # Blank line
    echo Kexts have been moved.
    Sleep 5
fi
# Ask User if they would like to compelte first reboot.
echo "This reboot is for extracting ACPI files. When you reach the clover Bootloader press F4 followed by Fn+F4 and then boot back into macOS to run this script again.\n\nIf you have already done this, enter no and continue."
echo # Blank line
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
echo "If you select No on the following prompt, your config.plist will open in Xcode. Follow the instructions below and continue when complete.\n\nIf you have alrady done this enter yes and continue."
echo # Blank line
read -r -p "Have you changed ig-platform-id and enabled the kextstopatch for graphics? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    clear
    continue
else
    clear
    echo "In Xcode expand Graphics and change ig-platform-id to 0x16260006.\n\nExpand KernelAndKextPatches -> KextsToPatch -> Items 0 - 3 and change Disabled Boolean to No for all four."
    echo # Blank line
    echo "You must manually save the config.plist file after you make the changes above and quit Xcode manually.\n\nOpening config.plist"
    sleep 10
    open /volumes/EFI/EFI/CLOVER/config.plist
    echo # Blank line
fi
# Check check if ig-plaform-id and kexttopatch patches are enabled
echo "If all prompts are true prior to this prompt, after this reboot graphics should be working.\n\nSelect no if you have already completed reboots."
echo # Blank line
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
    echo # Blank line
    sudo spctl --master-disable
    echo Apps From Anywhere is enabled.
    sleep 2
    clear
else
    clear
    continue
fi
# Disable Hibernate
read -r -p "Would you like to disable Hibernate? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
    sudo pmset -a hibernatemode 0
    sudo pmset -a autopoweroff 0
    sudo pmset -a standby 0
    sudo rm /private/var/vm/sleepimage
    sudo touch /private/var/vm/sleepimage
    sudo chflags uchg /private/var/vm/sleepimage
    echo Hibernate is disabled. This maybe necessary to do again after OS updates.
    sleep 3
    clear
else
    clear
    continue
fi
# Show sleep status. Uncomment if you want to see it.
read -r -p "Would you like to check Hibernate status? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
    sudo pmset -g custom | grep "hibernatemode \|standby \|autopoweroff "
    sleep 5
    clear
else
    clear
    continue
fi
# Disable dock open delay
read -r -p "Would you like to disable Dock opening delay? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
    defaults write com.apple.Dock autohide-delay -float 0 && killall Dock
    echo Autohide delays have been removed from dock.
    sleep 5
    clear
else
    clear
    continue
fi
# Show File path in Finder
read -r -p "Would you like to show the folder path in the Title of Finder windows? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true; killall Finder
    echo Full file path will now show in Finder Title.
    sleep 5
    clear
else
    clear
    continue
fi
# Give permissions to all needed commands
read -r -p "Would you like to give proper permissions to the rest of the scripts needed? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
    echo Assigning permissions to all other neccessay scripts.
    cd ~/desktop/x250/ALC3232
    chmod 755 ALC3232.command
    cd ~/desktop/x250/Files
    chmod 775 ssdtPRgensh.command
    chmod 755 3PostPatching.command
    chmod 755 4Final.command
    echo # Blank line
    echo Done!
    sleep 3
    clear
else
    clear
    continue
fi
# Move iasl, voodoodaemon, remove unneeded voodoo related kexts
read -r -p "Would you like to move iasl and VoodooPS2Daemon to /usr/bin and remove unecessary VoodooPS2Controller Files? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
    cd ~/desktop/x250/Files
    sudo cp -a iasl /usr/bin/
    sudo cp -a VoodooPS2Daemon /usr/bin/
    sudo cp -a org.rehabman.voodoo.driver.Daemon.plist /Library/LaunchDaemons
    sudo rm -rf /System/Library/Extensions/AppleACPIPS2Nub.kext
    sudo rm -rf /System/Library/Extensions/ApplePS2Controller.kext
    echo Files have been moved and unnecssary files removed.
    sleep 3
    clear
else
    clear
    continue
fi
# Create patching directory
read -r -p "Would you like to create a directory for patching? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
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
# Moving Extracted .aml files from EFI
read -r -p "Would you like move the extracted files to the patching directories? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
    cd /volumes/EFI/EFI/CLOVER/ACPI/origin
    sudo cp -a DSDT.aml ~/desktop/x250original
    sudo cp -a SS**.aml ~/desktop/x250original
    sudo rm -rf ~/desktop/x250original/SSDT-*x.aml
    mv ~/desktop/x250original/SSDT-0.aml ~/desktop/x250finished
    mv ~/desktop/x250original/SSDT-2.aml ~/desktop/x250finished
    mv ~/desktop/x250original/SSDT-4.aml ~/desktop/x250finished
    mv ~/desktop/x250original/SSDT-5.aml ~/desktop/x250finished
    mv ~/desktop/x250original/SSDT-9.aml ~/desktop/x250finished
    mv ~/desktop/x250original/SSDT-11.aml ~/desktop/x250finished
    mv ~/desktop/x250original/SSDT-12.aml ~/desktop/x250finished
    cd ~/desktop/x250/Files
    sudo cp -a SSDT-BATC.dsl ~/desktop/x250modified
    echo Files have been moved.
    sleep 3
    clear
else
    clear
    continue
fi
# Create Power management SSDT.dsl
read -r -p "Would you like to create the Power Management SSDT. [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
    ~/desktop/x250/files/ssdtPRgensh.command
    mv ~/desktop/x250modified/ssdt.dsl ~/desktop/x250modified/SSDT.dsl
    echo # Blank line
    echo Power Management SSDT created placed in x250modifed. Must save as .aml and place in x250 finished.
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
    git clone https://github.com/RehabMan/HP-ProBook-4x30s-DSDT-Patch probook.git
    git clone https://github.com/RehabMan/OS-X-Clover-Laptop-Config.git guide.git
    cd ~/Projects/guide.git
    make
    sudo cp -R ~/Projects/probook.git/kexts/AppleBacklightInjector.kext /Library/Extensions
    cp -a ~/Projects/guide.git/build/SSDT-PNLF.aml ~/Desktop/x250finished
    clear
    echo PNFL.aml created and in x250finished.
    echo # Blank line
    echo AppleBacklightInjector is now in /L/E/
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
    clear
    ~/desktop/x250/ALC3232/ALC3232.command
    sleep 5
    clear
else
    clear
    continue
fi
# Convert .aml to .dsl for patching.
read -r -p "Would you like to convert .aml files to dsl for patching? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    cd ~/desktop/x250original
    iasl -da -dl *.aml
    sudo cp -a DSDT.dsl ~/desktop/x250modified
    sudo cp -a SSDT-1.dsl ~/desktop/x250modified
    sudo cp -a SSDT-3.dsl ~/desktop/x250modified
    sudo cp -a SSDT-10.dsl ~/desktop/x250modified
    clear
    echo .dsl files are now converted and in x250 ready for patching. Save as .aml to x250finished after patching is complete.
    sleep 5
    echo # Blank line
else
    echo # Blank line
    continue
fi
read -r -p "Press enter when you're ready to close this window. " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    osascript -e 'tell application "Terminal" to quit' &
    exit
else
    osascript -e 'tell application "Terminal" to quit' &
    exit
fi
