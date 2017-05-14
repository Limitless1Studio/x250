#!/bin/sh
final_tasks()
{
# Fix Audio
echo " (!) This runs the ALC3232.command. It will make and install the necessary kexts"
echo "     to fix Audio. It may be necessary to repair permissions using Kext Wizard"
echo "     after running this."
echo "\n================================================================================\n"

read -r -p "---> Would you like to fix Audio? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "\n================================================================================\n"
    echo " (i) Starting ALC3232.command."
    echo "\n================================================================================\n"
    ~/desktop/x250/ALC3232/ALC3232.command
    sleep 2
    echo "\n================================================================================\n"
    echo " (i) ALC3232.command finished."
    echo "\n================================================================================\n"
    sleep 3
else
    echo "\n (i) Skipped."
    echo "\n================================================================================\n"
fi

# Move iasl, voodoodaemon, remove unneeded voodoo related kexts
echo " (!) These files should be removed to ensure the most stable trackpad and typing"
echo "     experience possible."
echo "\n================================================================================\n"
read -r -p "---> Would you like to move iasl and VoodooPS2Daemon to /usr/bin and remove unecessary VoodooPS2Controller Files? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
    cd ~/desktop/x250/Files
    sudo cp -a VoodooPS2Daemon /usr/bin/
    sudo cp -a org.rehabman.voodoo.driver.Daemon.plist /Library/LaunchDaemons
    sudo rm -rf /System/Library/Extensions/AppleACPIPS2Nub.kext
    sudo rm -rf /System/Library/Extensions/ApplePS2Controller.kext
    echo " (i) Files have been moved and unnecssary files removed."
    echo "\n================================================================================\n"
    sleep 3
    read -r -p "Press enter when you're ready to close this window. " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
    then
        osascript -e 'tell application "Terminal" to quit' &
        exit
    else
        osascript -e 'tell application "Terminal" to quit' &
        exit
    fi
else
    echo "\n================================================================================\n"
    read -r -p "Press enter when you're ready to close this window. " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
    then
        osascript -e 'tell application "Terminal" to quit' &
        exit
    else
        osascript -e 'tell application "Terminal" to quit' &
        exit
    fi
fi
}

compile_dsdt()
{
echo "\n================================================================================"
echo "[(D/S)SDT]: Compiling DSDT/SSDTs"
echo "================================================================================\n"
echo "\n    >>>>   Compiling Started   <<<<    \n"
echo "     ...    Compiling DSDT...."
/usr/bin/iasl ~/x250finished/DSDT.dsl

# Using pre-made SSDT by using ssdtPRgen.sh
echo "     ...    Compiling SSDT..."
/usr/bin/iasl ~/x250finished/SSDT.dsl

echo "     ...    Compiling SSDT-BATC..."
/usr/bin/iasl ~/x250finished/SSDT-BATC.dsl

echo "     ...    Compiling SSDT-1..."
/usr/bin/iasl ~/x250finished/SSDT-1.dsl

echo "     ...    Compiling SSDT-10..."
/usr/bin/iasl ~/x250finished/SSDT-10.dsl

echo "\n[--Done--]: All done...\n"
final_tasks
}

patch_ssdt()
{

########################
# SSDT-1 (iGPU) Patches
########################

echo "\n================================================================================"
echo "[--SSDT--]: Patching SSDT-1"
echo "================================================================================\n"
echo "\n    >>>>   SSDT-1 (iGPU) Patch Started   <<<<    \n"

echo "     ...    [gfx] Rename VID to IGPU"
/usr/bin/patchmatic ~/x250finished/SSDT-1.dsl ~/Desktop/x250/patches/graphics_Rename-PCI0_VID.txt ~/x250finished/SSDT-1.dsl

########################
# SSDT-10 (dGPU) Patches
########################

echo "\n================================================================================"
echo "[--SSDT--]: Patching SSDT-10"
echo "================================================================================\n"
echo "\n    >>>>   SSDT-1 (dGPU) Patch Started   <<<<    \n"

echo "     ...    [gfx] Rename VID to IGPU"
/usr/bin/patchmatic ~/x250finished/SSDT-10.dsl ~/Desktop/x250/patches/graphics_Rename-PCI0_VID.txt ~/x250finished/SSDT-10.dsl

echo "\n    >>>>   Continuing to Compile DSDT\SSDT's...   <<<<    \n"

compile_dsdt
}

patch_dsdt()
{
echo "\n================================================================================"
echo "[--DSDT--]: Patching DSDT"
echo "================================================================================\n"
echo "\n    >>>>   DSDT Patch Started   <<<<    \n"

echo "     ...    [syn] Fix _WAK Arg0 v2"
/usr/bin/patchmatic ~/x250finished/DSDT.dsl ~/Desktop/x250/patches/system_WAK2.txt ~/x250finished/DSDT.dsl

echo "     ...    [sys] HPET Fix"
/usr/bin/patchmatic ~/x250finished/DSDT.dsl ~/Desktop/x250/patches/system_HPET.txt ~/x250finished/DSDT.dsl

echo "     ...    [sys] IRQ Fix"
/usr/bin/patchmatic ~/x250finished/DSDT.dsl ~/Desktop/x250/patches/system_IRQ.txt ~/x250finished/DSDT.dsl

echo "     ...    [sys] RTC Fix"
/usr/bin/patchmatic ~/x250finished/DSDT.dsl ~/Desktop/x250/patches/system_RTC.txt ~/x250finished/DSDT.dsl

echo "     ...    [sys] Add IMEI"
/usr/bin/patchmatic ~/x250finished/DSDT.dsl ~/Desktop/x250/patches/system_IMEI.txt ~/x250finished/DSDT.dsl

echo "     ...    [sys] OS Check Fix"
/usr/bin/patchmatic ~/x250finished/DSDT.dsl ~/Desktop/x250/patches/system_OSYS_win8.txt ~/x250finished/DSDT.dsl

echo "     ...    [sys] SMBus Fix"
/usr/bin/patchmatic ~/x250finished/DSDT.dsl ~/Desktop/x250/patches/system_SMBUS.txt ~/x250finished/DSDT.dsl

echo "     ...    [sys] Fix Mutex with non-zero SyncLevel"
/usr/bin/patchmatic ~/x250finished/DSDT.dsl ~/Desktop/x250/patches/system_Mutex.txt ~/x250finished/DSDT.dsl

echo "     ...    [gfx] Rename VID to IGPU"
/usr/bin/patchmatic ~/x250finished/DSDT.dsl ~/Desktop/x250/patches/graphics_Rename-PCI0_VID.txt ~/x250finished/DSDT.dsl

echo "     ...    [gfx] Add Rename B0D3 to HDAU"
/usr/bin/patchmatic ~/x250finished/DSDT.dsl ~/Desktop/x250/patches/graphics_Rename-B0D3.txt ~/x250finished/DSDT.dsl

echo "     ...    [misc] Led Blink Fix"
/usr/bin/patchmatic ~/x250finished/DSDT.dsl ~/Desktop/x250/patches/led_blink.txt ~/x250finished/DSDT.dsl

echo "     ...    [misc] USB PRW Fix"
/usr/bin/patchmatic ~/x250finished/DSDT.dsl ~/Desktop/x250/patches/usb_prw.txt ~/x250finished/DSDT.dsl

echo "     ...    [misc] Fn Key Fix"
/usr/bin/atchmatic ~/x250finished/DSDT.dsl ~/Desktop/x250/patches/Fn_Keys.txt ~/x250finished/DSDT.dsl

echo "     ...    [misc] Battery Management"
/usr/bin/patchmatic ~/x250finished/DSDT.dsl ~/Desktop/x250/patches/BatteryManagement.txt ~/x250finished/DSDT.dsl

echo "     ...    [audio] HDEF 1 Fix"
/usr/bin/patchmatic ~/x250finished/DSDT.dsl ~/Desktop/x250/patches/HDEF-layout1.txt ~/x250finished/DSDT.dsl
patch_ssdt
}

decompile_dsdt()
{
echo "\n================================================================================"
echo "[(D/S)SDT]: Decompiling DSDT..."
echo "================================================================================\n"
echo "\n    >>>>   Decompiling Started   <<<<    \n"
cd ~/x250original
/usr/bin/iasl -da -dl *.aml
mv ~/x250original/DSDT.dsl ~/x250finished/DSDT.dsl
mv ~/x250original/SSDT-1.dsl ~/x250finished/SSDT-1.dsl
mv ~/x250original/SSDT-10.dsl ~/x250finished/SSDT-10.dsl
patch_dsdt
}

autopatcher()
{
read -r -p "---> Would you like to patch the DSDT and SSDTs? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "\n================================================================================"
    echo "Lenevo ThinkPad x250 DSDT/SSDT autopatch script by Limitless1Studio."
    echo "================================================================================\n"
    decompile_dsdt
else
    echo "\n (i) Skipped."
    echo "\n================================================================================\n"
    final_tasks
fi

}

prepare_patching()
{
# Give permissions to all needed commands
read -r -p "---> Would you like to give proper permissions to the rest of the scripts needed? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "\n================================================================================\n"
    echo " (i) Assigning permissions to all other neccessay scripts.\n"
    cd ~/desktop/x250/ALC3232
    chmod 755 ALC3232.command
    cd ~/desktop/x250/Files
    chmod 775 ssdtPRgensh.command
    echo # Blank line
    echo " (i) Permissions assigned."
    echo "\n================================================================================\n"
    sleep 3

else
    echo "\n (i) Skipped."
    echo "\n================================================================================\n"
    continue
fi
# Move IASL and Patchmatic to /usr/bin/
echo " (!) Patchmatic and IASL are used to automate the patching process. Without them"
echo "     in /usr/bin/ the patching script will fail."
echo "\n================================================================================\n"

read -r -p "--> Would you like to move Patchmatic and IASL to /usr/bin/? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "\n================================================================================\n"
    echo " (i) Copying iasl and patchmatic."
    cp -a ~/Desktop/x250/Files/patchmatic /usr/bin
    cp -a ~/Desktop/x250/Files/iasl /usr/bin
    echo "\n (i) iasl and patchmatic are now in /usr/bin/."
    echo "\n================================================================================\n"
else
    echo "\n (i) Skipped."
    echo "\n================================================================================\n"
fi

# Create patching directory
read -r -p "--> Would you like to create a directory for patching? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
    cd
    mkdir x250original
    mkdir x250finished
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
    cd /volumes/EFI/EFI/CLOVER/ACPI/origin
    sudo cp -a DSDT.aml ~/x250original
    sudo cp -a SSDT-1.aml ~/x250original
    sudo cp -a SSDT-10.aml ~/x250original
    mv /volumes/EFI/EFI/CLOVER/ACPI/origin/SSDT-0.aml /volumes/EFI/EFI/CLOVER/ACPI/patched
    mv /volumes/EFI/EFI/CLOVER/ACPI/origin/SSDT-2.aml /volumes/EFI/EFI/CLOVER/ACPI/patched
    mv /volumes/EFI/EFI/CLOVER/ACPI/origin/SSDT-3.aml /volumes/EFI/EFI/CLOVER/ACPI/patched
    mv /volumes/EFI/EFI/CLOVER/ACPI/origin/SSDT-4.aml /volumes/EFI/EFI/CLOVER/ACPI/patched
    mv /volumes/EFI/EFI/CLOVER/ACPI/origin/SSDT-5.aml /volumes/EFI/EFI/CLOVER/ACPI/patched
    mv /volumes/EFI/EFI/CLOVER/ACPI/origin/SSDT-9.aml /volumes/EFI/EFI/CLOVER/ACPI/patched
    mv /volumes/EFI/EFI/CLOVER/ACPI/origin/SSDT-11.aml /volumes/EFI/EFI/CLOVER/ACPI/patched
    mv /volumes/EFI/EFI/CLOVER/ACPI/origin/SSDT-12.aml /volumes/EFI/EFI/CLOVER/ACPI/patched
    cd ~/desktop/x250/Files
    sudo cp -a SSDT-BATC.dsl ~/x250finished
    echo "\n (i) Files have been moved."
    echo "\n================================================================================\n"
    sleep 3
else
    echo "\n (i) Skipped."
    echo "\n================================================================================\n"
    continue
fi

# Create Power management SSDT.dsl
read -r -p "---> Would you like to create the Power Management SSDT? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "\n================================================================================\n"
    echo " (i) Starting ssdtPRgensh.command."
    echo "\n================================================================================\n"
    ~/desktop/x250/files/ssdtPRgensh.command
    echo "\n================================================================================\n"
    echo " (i) ssdtPRgensh.command Finished."
    echo " (i) Power Management SSDT created placed in x250orginal."
    echo "\n================================================================================\n"
    sleep 3
else
    echo "\n (i) Skipped."
    echo "\n================================================================================\n"
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
    echo "\n (i) Skipped."
    echo "\n================================================================================\n"
    continue
fi
autopatcher
}

customize_os()
{
echo "\n================================================================================\n"
echo " (!) This section of the script contains an option to disable Hibernation which"
echo "     should be disabled to prevent file corruption. It also contains options to"
echo "     disable apps from anywhere, turn dock delays off, and show the path you are"
echo "     currently in within the top bar of finder."
echo "\n================================================================================\n"

read -r -p "---> Would you like to cutomize features on the OS? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "\n (i) Skipped."
    continue
else
    echo "\n================================================================================\n"
    prepare_patching
fi

# Ask user if they would like app from anywhere fixed
echo "\n================================================================================\n"
echo " (i) Starting cutomize OS"
echo "\n================================================================================\n"
echo "\t  No = Will skip the task. It will not undo this if already implemented."
echo "\t Yes = Will enable apps from anywhere to open without error.\n"

read -r -p "---> Would you like to enable apps from anywhere? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo # Blank line
    sudo spctl --master-disable
    echo "\n (i) Apps From Anywhere is enabled."
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
    echo "\n================================================================================\n"
    sleep 5
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
echo "\n================================================================================"
echo "Lenevo ThinkPad x250 installer script by Limitless1Studio."
echo "================================================================================\n"
echo "About this script:\n"
echo " (1) Before Patching there are two mission critical reboots that need to happen."
echo "     You will receive a number of prompts at the beginning of this script to "
echo "     ensure the patching and implementation of fixes goes correctly."
echo " (2) At various points in this script you will be asked to enter your password."
echo " (3) The (!) symbol indicates that there is vital information contained in the "
echo "     text that follows it. Keep an eye out for this text and be sure to read it."
echo " (4) This script relies on the Downloads.command script. If you have not ran the"
echo "     Downloads.command don't worry, it is included in this one. Select no on the"
echo "     following prompt and the downloads script will run."
echo " (5) If you ever make the wrong selection, or for some reason need to run this"
echo "     script again you can."
echo " (6) When prompted with a question, the script will except Y,N, or Yes,No. It is"
echo "     not case sensitive."
echo "\n================================================================================\n"
read -r -p "---> Have you read the \"About this Script\" section? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "\n================================================================================\n"
    echo " (i) Installer script is starting."
    echo "\n================================================================================\n"
    continue
else
    main
fi
read -r -p "---> Have you already ran the Downloads.command? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "\n================================================================================\n"
    continue
else
  echo "\n================================================================================\n"
  echo " (i) Starting Downloads.command."
  echo "\n================================================================================\n"
  curl -L -O https://raw.githubusercontent.com/Limitless1Studio/x250/master/Downloads.command
  chmod 755 Downloads.command
  ~/Downloads.command
  sleep 2
  echo "\n================================================================================\n"
  echo " (i) Downloads.command Has finished."
  echo "\n================================================================================\n"
  sleep 3
  main
fi

read -r -p "---> Have you already performed both reboots? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "\n================================================================================\n"
    echo " (i) Mounting EFI partition.\n"
    diskutil mount /dev/disk0s1
    customize_os
else
    reboots
fi
}

main
