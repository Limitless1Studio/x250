#!/bin/sh
final_tasks()
{
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

# Move iasl, voodoodaemon, remove unneeded voodoo related kexts
read -r -p "---> Would you like to move iasl and VoodooPS2Daemon to /usr/bin and remove unecessary VoodooPS2Controller Files? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
    cd ~/desktop/x250/Files
    sudo cp -a iasl /usr/bin/
    sudo cp -a VoodooPS2Daemon /usr/bin/
    sudo cp -a org.rehabman.voodoo.driver.Daemon.plist /Library/LaunchDaemons
    sudo rm -rf /System/Library/Extensions/AppleACPIPS2Nub.kext
    sudo rm -rf /System/Library/Extensions/ApplePS2Controller.kext
    echo "Files have been moved and unnecssary files removed."
    sleep 3
    clear
else
    clear
    continue
fi
}

prepare_patching()
{
# Give permissions to all needed commands
read -r -p "---> Would you like to give proper permissions to the rest of the scripts needed? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
    echo "\n (i) Assigning permissions to all other neccessay scripts.\n"
    cd ~/desktop/x250/ALC3232
    chmod 755 ALC3232.command
    cd ~/desktop/x250/Files
    chmod 775 ssdtPRgensh.command
    chmod 755 Patching.command
    echo # Blank line
    echo " (i) Permissions assigned."
    sleep 3
    echo "\n================================================================================\n"
else
    echo "\n (i) Skipped."
    echo "\n================================================================================\n"
    continue
fi

# Create patching directory
read -r -p "--> Would you like to create a directory for patching? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
    cd
    mkdir x250original
    echo "\n (i) Folder created in  home directory."
    echo "\n================================================================================\n"
    sleep 3
else
    echo "\n (i) Skipped."
    echo "\n================================================================================\n"
    continue
fi

# Moving Extracted .aml files from EFI
read -r -p "---> Would you like move the extracted files to the patching directories? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "\n================================================================================\n"
    echo "\n (i) Moving Files."
    cd /volumes/EFI/EFI/CLOVER/ACPI/patched
    sudo cp -a DSDT.aml ~/desktop/x250original
    sudo cp -a SS**.aml ~/desktop/x250original
    sudo rm -rf ~/desktop/x250original/SSDT-*x.aml
    mv ~/desktop/x250original/SSDT-0.aml /volumes/EFI/EFI/CLOVER/ACPI/patched
    mv ~/desktop/x250original/SSDT-2.aml /volumes/EFI/EFI/CLOVER/ACPI/patched
    mv ~/desktop/x250original/SSDT-4.aml /volumes/EFI/EFI/CLOVER/ACPI/patched
    mv ~/desktop/x250original/SSDT-5.aml /volumes/EFI/EFI/CLOVER/ACPI/patched
    mv ~/desktop/x250original/SSDT-9.aml /volumes/EFI/EFI/CLOVER/ACPI/patched
    mv ~/desktop/x250original/SSDT-11.aml /volumes/EFI/EFI/CLOVER/ACPI/patched
    mv ~/desktop/x250original/SSDT-12.aml /volumes/EFI/EFI/CLOVER/ACPI/patched
    cd ~/desktop/x250/Files
    sudo cp -a SSDT-BATC.dsl ~/desktop/x250original
    echo "\n (i) Files have been moved."
    echo "\n================================================================================\n"
    sleep 3
else
    echo "\n================================================================================\n"
    continue
fi

# Create Power management SSDT.dsl
read -r -p "---> Would you like to create the Power Management SSDT? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
    ~/desktop/x250/files/ssdtPRgensh.command
    mv ~/desktop/x250original/ssdt.dsl ~/desktop/x250original/SSDT.dsl
    echo # Blank line
    echo "\n (i)Power Management SSDT created placed in x250orginal."
    echo "\n================================================================================\n"
    sleep 3
else
    clear
    continue
fi
# Create PFNL SSDT for Backlight Fix. Also making and installing
# AppleBacklightInjector to /Library/Extensions/
read -r -p "---> Would you like to create PNFL and fix AppleBacklight? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "\n================================================================================\n"
    cd
    mkdir ~/Projects
    cd ~/Projects
    git clone https://github.com/RehabMan/HP-ProBook-4x30s-DSDT-Patch probook.git
    git clone https://github.com/RehabMan/OS-X-Clover-Laptop-Config.git guide.git
    cd ~/Projects/guide.git
    make
    sudo cp -R ~/Projects/probook.git/kexts/AppleBacklightInjector.kext /Library/Extensions
    cp -a ~/Projects/guide.git/build/SSDT-PNLF.aml /volumes/EFI/EFI/CLOVER/ACPI/patched
    echo "\n================================================================================\n"
    echo "\n (i) PNFL.aml created and in /volumes/EFI/EFI/CLOVER/ACPI/patched."
    echo "\n (i) AppleBacklightInjector is now in /L/E/"
    echo "\n================================================================================\n"
else
    echo "\n================================================================================\n"
    continue
fi

}

customize_os()
{
echo "\n================================================================================\n"
echo " (i) This section of the script contains an option to disable Hibernation which"
echo "     should be disabled to prevent file corruption. It also contains options to"
echo "     disable apps from anywhere, turn dock delays off, and show the path you are"
echo "     currently in within the top bar of finder."
echo "\n================================================================================\n"

read -r -p "---> Would you like to cutomize features on the OS? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    continue
else
    prepare_patching
fi

# Ask user if they would like app from anywhere fixed
echo "\n================================================================================\n"
echo "Starting cutomize OS"
echo "\n================================================================================\n"
echo "\t  No = Will skip the task. It will not undo this if already implemented."
echo "\t Yes = Will enable apps from anywhere to open without error.\n"

read -r -p "---> Would you like to enable apps from anywhere? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
    sudo spctl --master-disable
    echo " (i) Apps From Anywhere is enabled."
    echo "\n================================================================================\n"
    sleep 2
else
    echo " (i) Skipped"
    echo "\n================================================================================\n"
    continue
fi

# Disable Hibernate
echo "\t  No = Will skip the task. It will not undo this if already implemented."
echo "\t Yes = Will turn Hibernate off.\n"

read -r -p "---> Would you like to disable Hibernate? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    sudo pmset -a hibernatemode 0
    sudo pmset -a autopoweroff 0
    sudo pmset -a standby 0
    sudo rm /private/var/vm/sleepimage
    sudo touch /private/var/vm/sleepimage
    sudo chflags uchg /private/var/vm/sleepimage
    echo "\n (i) Hibernate is disabled. This maybe necessary to do again after OS updates."
    echo "\n================================================================================\n"
else
    echo "\n================================================================================\n"
    continue
fi

# Check sleep status.
echo "\t  No = The action will be skipped."
echo "\t Yes = Hibernate status will be displayed below.\n"

read -r -p "---> Would you like to check Hibernate status? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
    sudo pmset -g custom | grep "hibernatemode \|standby \|autopoweroff "
    sleep 5
    echo "\n================================================================================\n"
else
    echo "\n================================================================================\n"
    continue
fi

# Disable dock open delay
echo "\t  No = Will skip the action. Does not undo Dock open delay."
echo "\t Yes = Sets dock open delay to 0.\n"

read -r -p "---> Would you like to disable Dock opening delay? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
    defaults write com.apple.Dock autohide-delay -float 0 && killall Dock
    echo "\n (i) Autohide delays have been removed from the Dock."
    echo "\n================================================================================\n"
    sleep 3
else
    echo "\n================================================================================\n"
    continue
fi

# Show File path in Finder
echo "\t  No = The action will be skipped. This does not undo."
echo "\t Yes = This will turn on folder path in Finder.\n"

read -r -p "---> Would you like to show the folder path in the Title of Finder windows? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true; killall Finder
    echo "\n (i) Full file path will now show in Finder Title."
    echo "\n================================================================================\n"
    prepare_patching
else
    echo "\n================================================================================\n"
    prepare_patching
fi
final_tasks
}


reboots ()
{
# Verify that Clover has been installed
echo "\n================================================================================\n"
echo " (!) You must have clover installed for the rest of the script to run correctly."
echo "     If you have not installed Clover Bootloader to the EFI partition, open the"
echo "     \"Clover_v2.4k_r4061.pkg\" from /x250/Programs and run the installer as"
echo "     described after selecting no. Continue with this script when finished."
echo "\n================================================================================"
echo # Blank line
read -r -p "---> Have you already installed Clover Bootloader to the HHD/SSD? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    continue
else
    echo "\n================================================================================\n"
    echo "---> Run Clover_v2.4k_r4061.pkg selecting the following conditions: <---\n"
    echo "\t\xE2\x9C\x94 Install for UEFI booting only"
    echo "\t\xE2\x9C\x94 Install Clover in the ESP"
    echo "\t\xE2\x9C\x94 Select BGM under Themes"
    echo "\t\xE2\x9C\x94 Select OsxAptioFixDRV-64 under drivers64UEFI\n"
    echo " (!) Do Not continue until Clover Bootloader is installed on the EFI/ESP."
fi

# Ensure HFSplus is in SSDs EFI partion before reboot.
echo "\n================================================================================\n"
echo "\t  No = Files will be moved to the EFI partition"
echo "\t Yes = The action will be skipped\n"

read -r -p "---> Have you placed HFSplus.efi in the HHD/SSD's EFI partition? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    continue
else
    echo "\n================================================================================\n"
    diskutil mount /dev/disk0s1
    cd ~/desktop/x250/Files
    sudo cp -a HFSPlus.efi /volumes/ESP/EFI/CLOVER/drivers64UEFI
    echo "\n (i) HSFPlus.efi is now in /volumes/ESP/EFI/CLOVER/drivers64UEFI."
fi

# Ensure that vital kexts are in place before rebooting.
echo "\n================================================================================\n"
echo "\t  No = Kexts will be moved to the EFI partition"
echo "\t Yes = The action will be skipped\n"

read -r -p "---> Have you placed FakeSMC, IntelMausiEthernet, and VoodooPS2Controller kexts on the HHD/SSDs EFI partition? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    continue
else
    cd ~/desktop/x250/kexts
    sudo cp -R VoodooPS2Controller.kext /volumes/ESP/EFI/CLOVER/Kexts/Other
    sudo cp -R IntelMausiEthernet.kext /volumes/ESP/EFI/CLOVER/Kexts/Other
    sudo cp -R FakeSMC.kext /volumes/ESP/EFI/CLOVER/Kexts/Other
    echo "\n (i) Kexts are now in /volumes/ESP/EFI/CLOVER/Kexts/Other."
fi

# Ask User if they would like to compelte first reboot.
echo "\n================================================================================\n"
echo " (!) This reboot is for extracting ACPI files. At the Clover Bootloader screen"
echo "     press Fn+F4. Next, boot back into macOS and run this script again. If you "
echo "     do not have Kexts and HFSplus.efi on the ESP/EFI partition, the reboot will"
echo "     fail. If the reboot fails after Clover Bootloader has been installed, you"
echo "     must mount the EFI partion and move the kexts manually to Volumes > EFI > "
echo "     EFI > CLOVER > Kexts > Other and move HSFplus.efi to Volumes > EFI > EFI > "
echo "     CLOVER > drivers64UEFI. They will not move automaticaly using this script "
echo "     after the first reboot has been completed with Clover Bootloader installed"
echo "     to the EFI/ESP partition on the x250."
echo "\n================================================================================\n"
echo "\t      No = The action will be skipped and the EFI partition mounted."
echo "\t     Yes = Restart\n"

read -r -p "---> Would you like to complete the first reboot now? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "\n================================================================================\n"
    echo " (i) Sending restart command in 5 seconds."
    sleep 5
    osascript -e 'tell application "System Events" to restart'
    exit
else
    echo "\n================================================================================\n"
    echo " (i) Mounting the EFI partion."
    diskutil mount /dev/disk0s1
fi

# Check check if ig-plaform-id and kexttopatch patches are enabled
echo "\n================================================================================\n"
echo " (!) In order to implement excellerated graphics you must change the ig-platform"
echo "     -id in the config.plist. Do Not use Clover Configurator to do this as it "
echo "     will corrupt a vital patch that is stored in the config.plist."
echo "\n================================================================================\n"
echo "\t  No = config.plist will automatically open in Xcode. Instruction below."
echo "\t Yes = The action will be skipped.\n"
read -r -p "---> Have you changed ig-platform-id and enabled the kextstopatch for graphics? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    continue
else
    echo "\n================================================================================\n"
    echo "---> In Xcode <--- "
    echo "\t\xE2\x9C\x94 Expand Graphics and change ig-platform-id to 0x16260006."
    echo "\t\xE2\x9C\x94 Expand KernelAndKextPatches -> KextsToPatch -> Items 0 - 3"
    echo "\t\xE2\x9C\x94 Change Disabled Boolean to No for Items 0 - 3."
    echo "\t\xE2\x9C\x94 File > Save the config.plist file."
    echo "\t\xE2\x9C\x94 Quit Xcode manually.\n"
    echo " (i) Opening config.plist. Continue when tasks above are completed."
    sleep 5
    open /volumes/EFI/EFI/CLOVER/config.plist
fi

# Check check if ig-plaform-id and kexttopatch patches are enabled
echo "\n================================================================================\n"
echo " (!) This reboot is to implement accelerated graphics. You must have completed"
echo "     the first reboot succesfully, enabled KextsToPatch correctly and changed"
echo "     ig-plaform-id to 0x16260006 as described in previous step for this to work."
echo "\n================================================================================\n"

read -r -p "Would you like to reboot for the second time and rebuild the kext cache? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "\n================================================================================\n"
    sudo touch /System/Library/Extensions && sudo kextcache -u /
    echo "\n================================================================================\n"
    echo "Sending restart command in 5 seconds."
    sleep 5
    osascript -e 'tell application "System Events" to restart'
    exit
else
    customize_os
fi
}

main()
{
# Making space
clear
echo "\n================================================================================\n"
echo " (!) Before Patching there are two mission critical reboots that need to happen."
echo "     You will receive a number of prompts at the beginning of this script to "
echo "     ensure the patching and implementation of fixes goes correctly."
echo "\n================================================================================\n"
sleep 5
read -r -p "---> Have you already performed both reboots? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    customize_os
else
    reboots
fi
}

main

read -r -p "Press enter when you're ready to close this window. " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    osascript -e 'tell application "Terminal" to quit' &
    exit
else
    osascript -e 'tell application "Terminal" to quit' &
    exit
fi
