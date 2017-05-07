#!/bin/sh
# Move .AML files to patched folder
clear
echo !!! All DSDT/SSDT files should be patched and in x250finished !!!
sleep 5
clear
# Move .AMLs into EFI.
read -r -p "Have you placed patched and converted all DSDT/SSDTs and placed in x250finished? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    cd ~/desktop/x250finished
    sudo cp *.aml /volumes/EFI/EFI/CLOVER/ACPI/patched
    echo All files in x250finished have been moved to EFI
    sleep 5
    clear
else
    clear
    exit
fi
# Cleaning up the mess we made on your desktop. Files will be archived
# in your home folder. Finder > Go > Home > Archive.
read -r -p "Would you like to archive the folders created on your desktop? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    cd
    mkdir Archive
    mv ~/desktop/x250finished ~/Archive
    mv ~/desktop/x250modified ~/Archive
    mv ~/desktop/x250original ~/Archive
    mv ~/desktop/x250 ~/Archive
    mv ~/ssdtPRGen.sh ~/Archive
    mv ~/Projects ~/Archive
    echo Files are now archived in your home folder. Finder > Go > Home > Archive.
    sleep 5
    clear
else
    clear
    continue
fi
#
read -r -p "Have you enabled all KextsToPatch in the config.plist? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    clear
    continue
else
    clear
    echo In Xcode expand KernelAndKextPatches > KextsToPatch > Items 0 - 7 and change Disabled Boolean to No for all KextsToPatch entries.
    echo #
    echo You must manually save the config.plist file after you make the changes above and quit Xcode manually.
    sleep 10
    echo Opening config.plist
    open /volumes/EFI/EFI/CLOVER/config.plist
    sleep 45
    clear
fi
# Install Kexts to /system/library/extensions using Kext Wizard.
read -r -p "Would you like to remove kexts from EFI and install to /S/L/E/ using Kext Wizard? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    cd /volumes/ESP/EFI/CLOVER/Kexts/Other
    sudo rm -r VoodooPS2Controller.kext
    sudo rm -r IntelMausiEthernet.kext
    sudo rm -r FakeSMC.kext
    echo Kexts removed from EFI/Other
    sleep 3
    clear
    echo Opening Kext Wizard. Install by browsing to ~/dekstop/x250/kexts under the installtion tab.
    sleep 3
    echo After you have installed the kexts, be sure to switch to the Maintenance tab and select System/Library/Extensions and Execute.
    echo Must repair permissions when finished.
    sleep 4
    open -a "Kext Wizard"
    sleep 5
else
    clear
    continue
fi
# Final reboot
read -r -p "Would you like to reboot for the final time and rebuild the kext cache? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    clear
    sudo touch /System/Library/Extensions && sudo kextcache -u /
    clear
    echo You may need to rebuild the cache and reboot a couple more times in order to implement Backlight control correctly.
    sleep 10
    clear
    echo Sending restart command in 5 seconds.
    sleep 5
    osascript -e 'tell application "System Events" to restart'
    exit
else
    clear
    continue
fi
read -r -p "Do you want to review the results? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    exit
else
    osascript -e 'tell application "Terminal" to quit' &
    exit
fi
