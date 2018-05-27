#!/bin/sh
# This script will automatically download the needed kexts and create a
# directory in the process
# Explain that Xcode must be installed
clear
echo "\n================================================================================\n"
echo " (!) Xcode must be installed to continue. Answer the following questions"
echo "     accordingly to ensure successful downloads and folder creation."
echo "\n================================================================================\n"

# Ask if user has Xcode installed
read -r -p "---> Do you have Xcode installed? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
  echo "\n================================================================================\n"
    continue
else
  echo "\n================================================================================\n"
    echo " (!) Sign in with your apple ID. If you do not have a developer account, you"
    echo "     will need to create one to download and install the latest Xcode."
    echo "\n================================================================================\n"
    sleep 5
    echo " (!) Opening apple downloads page. Do not use the Mac App Store as iCloud"
    echo "     has not been fixed yet. After downloading and installing, continue."
    echo "           *** Must Unzip, and move to the applications folder ***"
    echo "\n================================================================================\n"
    sleep 5
    open https://developer.apple.com/download/more/

fi
# Asking user if they have opened and accepted terms
read -r -p "---> Has Xcode been opened and the terms accepted? <--- " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "\n================================================================================\n"
    continue
else
    echo "\n================================================================================\n"
    echo " (!) You must open Xcode and accept the terms and conditions."
    echo "\n================================================================================\n"
    sleep 3
    echo # Blank line
    echo " (i) Opening Xcode, continue after accepting the terms."
    echo "\n================================================================================\n"
    open -a Xcode
    sleep 3

fi
# Asking user if they have already installed the command line Tools
read -r -p "---> Have you installed the Xcode comand line Tools? <--- " response
echo    # Move to a new line
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "\n================================================================================\n"
    continue
else
    echo "\n================================================================================\n"
    echo " (!) You must install Xcode command line tools."
    echo "\n================================================================================\n"
    sleep 3

    echo " (i) Opening Installer for command line toos, continue after installation is"
    echo "     complete."
    echo "\n================================================================================\n"
    sleep 3
    echo # Blank line
    xcode-select --install
fi

read -r -p "Press enter to begin downloads. "

echo "\n================================================================================\n"
echo "----------------------Making x250 Folder!----------------------"
echo "\n================================================================================\n"
# redirect will not work without the . before /
cd ./desktop
mkdir -v x250
cd ./x250
mkdir -v Kexts
mkdir -v Files
mkdir -v Programs
mkdir -v iMessage
mkdir -v Patches
cd ~/Desktop/x250/Kexts

echo "\n================================================================================\n"
echo "----------------------Donwloading Kexts!----------------------"
echo "\n================================================================================\n"
# curl -L -O must be used for BitBucket zips
# curl -o must be used to rename the file correctly because the link does not
# end in .zip

# curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/RehabMan-FakeSMC-2017-0414.zip
# curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/RehabMan-FakeSMC-2017-0607.zip
# Updated 12/28/17
# curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/RehabMan-FakeSMC-2017-1017.zip
# Updated 5/27/18
curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/RehabMan-FakeSMC-2018-0403.zip

# IntelMausiEthernet is up-to-date as of 7/27; No action required
# curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-intel-network/downloads/RehabMan-IntelMausiEthernet-v2-2017-0321.zip
# Updated 12/28/17
# curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-intel-network/downloads/RehabMan-IntelMausiEthernet-v2-2017-0914.zip
# Updated 5/27/18
curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-intel-network/downloads/RehabMan-IntelMausiEthernet-v2-2018-0424.zip

# Battery Kext is up-to-date as of 7/27; No action required
# curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-acpi-battery-driver/downloads/RehabMan-Battery-2017-0428.zip
# Updated 12/28/17
# Checked 5/27/18
curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-acpi-battery-driver/downloads/RehabMan-Battery-2017-1001.zip

# BrcmPatchRAM kext is up-to-date as of 7/27; No action required
# No Update Required 12/28/17
# curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-brcmpatchram/downloads/RehabMan-BrcmPatchRAM-2016-0705.zip
# Updated 5/27/18
curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-brcmpatchram/downloads/RehabMan-BrcmPatchRAM-2018-0505.zip

# curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-usb-inject-all/downloads/RehabMan-USBInjectAll-2017-0112.zip
# curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-usb-inject-all/downloads/RehabMan-USBInjectAll-2017-0724.zip
# Updated 12/28/17
# curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-usb-inject-all/downloads/RehabMan-USBInjectAll-2017-1214.zip
# Updated 5/27/18
curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-usb-inject-all/downloads/RehabMan-USBInjectAll-2018-0420.zip

# I moved these downloads to the dowloads directory to eliminate confusion on which
# Kexts folder we are referring to
cd ~/downloads
# curl --progress-bar -L -o OS-X-Voodoo-PS2-Controller-master.zip https://github.com/tluck/OS-X-Voodoo-PS2-Controller/archive/master.zip
curl --progress-bar -L -o OS-X-Voodoo-PS2-Controller-master.zip https://github.com/tluck/OS-X-Voodoo-PS2-Controller/archive/3b5d68a4b6dc2afb478b0232aaa5849b12b49b82.zip
curl --progress-bar -o Kexts.zip https://www.tonymacx86.com/attachments/kexts-zip.218178/
cd ~/desktop/x250/Kexts

echo "\n================================================================================\n"
echo "----------------------Unzipping Kexts!----------------------"
echo "\n================================================================================\n"

# unzip is the command to unzip kexts

# unzip -q RehabMan-FakeSMC-2017-0414.zip
# unzip -q RehabMan-FakeSMC-2017-0607.zip
# Updated 12/28/17
# Updated 5/27/18
unzip -q RehabMan-FakeSMC-2018-0403.zip

# No update required 7/27
# unzip -q RehabMan-IntelMausiEthernet-v2-2017-0321.zip
# Updated 12/28/17
# Updated 5/27/18
unzip -q RehabMan-IntelMausiEthernet-v2-2018-0424.zip

# No update Required 7/27
# unzip -q RehabMan-Battery-2017-0428.zip
# Updated 12/28/17
# Updated 5/27/18
unzip -q RehabMan-Battery-2017-1001.zip

# No update Required 7/27
# No update Required 12/28/17
# Updated 5/27/18
unzip -q RehabMan-BrcmPatchRAM-2018-0505.zip

# unzip -q RehabMan-USBInjectAll-2017-0112.zip
# unzip -q RehabMan-USBInjectAll-2017-0724.zip
# Updated 12/28/17
# Updated 5/27/18
unzip -q RehabMan-USBInjectAll-2018-0420.zip

cd ~/downloads
unzip -q Kexts.zip
unzip -q OS-X-Voodoo-PS2-Controller-master.zip
# cd ~/downloads/OS-X-Voodoo-PS2-Controller-master
cd ~/downloads/OS-X-Voodoo-PS2-Controller-3b5d68a4b6dc2afb478b0232aaa5849b12b49b82
sudo make --silent
cd ~/desktop/x250/Kexts

echo "\n================================================================================\n"
echo "----------------------Cleaning up Kexts folder!----------------------"
echo "\n================================================================================\n"

# sudo rm -r must be used to remove kexts which are a directory
# sudo rm -f is used to delete a single file which .zips are
sudo rm -v -r FakeSMC_ACPISensors.kext
sudo rm -v -r FakeSMC_CPUSensors.kext
sudo rm -v -r FakeSMC_GPUSensors.kext
sudo rm -v -r FakeSMC_LPCSensors.kext
sudo rm -v -r Debug
sudo rm -v -r HWMonitor.app
sudo rm -v -r __MACOSX

# No update required 7/27
# rm -v -f RehabMan-Battery-2017-0428.zip
# Updated 12/28/17
rm -v -f RehabMan-Battery-2017-1001.zip

# rm -v -f RehabMan-FakeSMC-2017-0414.zip
# rm -v -f RehabMan-FakeSMC-2017-0607.zip
# Updated 12/28/17
# Updated 5/27/18
rm -v -f RehabMan-FakeSMC-2018-0403.zip

# No adjustment neaded. Kext not updated 7/27
# rm -v -f RehabMan-IntelMausiEthernet-v2-2017-0321.zip
# Updated 12/28/17
# Updated 5/28/18
rm -v -f RehabMan-IntelMausiEthernet-v2-2018-0424.zip

# No update required 7/27
# No update required 12/28/17
# Updated 5/27/18
rm -v -f RehabMan-BrcmPatchRAM-2018-0505.zip

# rm -v -f RehabMan-USBInjectAll-2017-0112.zip
# rm -v -f RehabMan-USBInjectAll-2017-0724.zip
# Updated 12/28/17
# Updated 5/27/18
rm -v -f RehabMan-USBInjectAll-2018-0420.zip

mv -v ~/desktop/x250/Kexts/Release/ACPIBatteryManager.kext ~/desktop/x250/Kexts/
mv -v ~/desktop/x250/Kexts/Release/IntelMausiEthernet.kext ~/desktop/x250/Kexts/
mv -v ~/desktop/x250/Kexts/Release/USBInjectAll.kext ~/desktop/x250/Kexts/
mv -v ~/desktop/x250/Kexts/Release/BrcmPatchRAM2.kext ~/desktop/x250/Kexts/
mv -v ~/desktop/x250/Kexts/Release/BrcmFirmwareRepo.kext ~/desktop/x250/Kexts/
mv -v ~/downloads/Kexts/USB_Injector_X250.kext ~/desktop/x250/Kexts/
sudo rm -v -r Release
chmod 755 ~/downloads/OS-X-Voodoo-PS2-Controller-3b5d68a4b6dc2afb478b0232aaa5849b12b49b82
cd ~/downloads/OS-X-Voodoo-PS2-Controller-3b5d68a4b6dc2afb478b0232aaa5849b12b49b82/build/products/Release
sudo mv -v ~/downloads/OS-X-Voodoo-PS2-Controller-3b5d68a4b6dc2afb478b0232aaa5849b12b49b82/build/products/Release/VoodooPS2Controller.kext ~/desktop/x250/Kexts/
sudo mv -v ~/downloads/OS-X-Voodoo-PS2-Controller-3b5d68a4b6dc2afb478b0232aaa5849b12b49b82/build/products/Release/VoodooPS2Daemon ~/desktop/x250/Files
mv -v ~/downloads/OS-X-Voodoo-PS2-Controller-3b5d68a4b6dc2afb478b0232aaa5849b12b49b82/VoodooPS2Daemon/org.rehabman.voodoo.driver.Daemon.plist ~/desktop/x250/Files
cd ~/downloads
sudo rm -v -r Kexts
sudo rm -v -r __MACOSX
sudo rm -v -r OS-X-Voodoo-PS2-Controller-3b5d68a4b6dc2afb478b0232aaa5849b12b49b82
sudo rm -v -f OS-X-Voodoo-PS2-Controller-master.zip
sudo rm -v -f Kexts.zip

echo "\n================================================================================\n"
echo "----------------------Donwloading Programs!----------------------"
echo "\n================================================================================\n"

cd ~/Desktop/x250/Programs

# curl --progress-bar -L -o Cloverv24kr4061.zip https://downloads.sourceforge.net/project/cloverefiboot/Installer/Clover_v2.4k_r4061.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcloverefiboot%2F&ts=1493489376&use_mirror=pilotfiber
# curl --progress-bar -L -o Cloverv24kr4128.zip https://downloads.sourceforge.net/project/cloverefiboot/Installer/Clover_v2.4k_r4128.zip?r=&ts=1501198181&use_mirror=cytranet
# curl --progress-bar -L -o Cloverv24kr4359.zip https://downloads.sourceforge.net/project/cloverefiboot/Installer/Clover_v2.4k_r4359.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcloverefiboot%2F&ts=1514337371&use_mirror=astuteinternet
# curl --progress-bar -L -O https://bitbucket.org/RehabMan/clover/downloads/Clover_v2.4k_r4359.RM-4506.7036cf0a.zip
# Updated 5/27/18
curl --progress-bar -L -O https://bitbucket.org/RehabMan/clover/downloads/Clover_v2.4k_r4444.RM-4652.c1f8602f.zip
# curl --progress-bar -L -O http://wizards.osxlatitude.com/kext/kw.zip
# Updated 5/27/18
curl --progress-bar -L -O https://us.softpedia-secure-download.com/dl/2794b5e648fc3a12018c12eef4ae56d0/5b0adb89/400110511/mac/Utilities/kw.zip
sleep 5

echo "\n================================================================================\n"
echo "----------------------Unzipping Programs!----------------------"
echo "\n================================================================================\n"

# unzip Cloverv24kr4359.zip
# unzip -q Clover_v2.4k_r4359.RM-4506.7036cf0a.zip
# Updated 5/27/18
unzip -q Clover_v2.4k_r4444.RM-4652.c1f8602f.zip
unzip kw.zip

echo "\n================================================================================\n"
echo "----------------------Cleaning up Programs folder!----------------------"
echo "\n================================================================================\n"

# rm -v -f Clover_v2.4k_r4359.pkg.md5
# rm -v -f Clover_v2.4k_r4359.RM-4506.7036cf0a.pkg.md5
rm -v -f Clover_v2.4k_r4444.RM-4652.c1f8602f.pkg.md5
# rm -v -f Cloverv24kr4359.zip
# rm -v -f Clover_v2.4k_r4359.RM-4506.7036cf0a.zip
rm -v -f Clover_v2.4k_r4444.RM-4652.c1f8602f.zip
rm -v -f kw.zip
sudo rm -v -r __MACOSX

echo "\n================================================================================\n"
echo "----------------------Donwloading Files!----------------------"
echo "\n================================================================================\n"

# curl -L -O must be used for BitBucket zips
# curl -o must be used to rename the file correctly because the link does not
# end in .zip
cd ~/Desktop/x250/Files
curl --progress-bar -L -O https://github.com/JrCs/CloverGrowerPro/raw/master/Files/HFSPlus/X64/HFSPlus.efi
curl --progress-bar -L -O https://bitbucket.org/RehabMan/acpica/downloads/iasl.zip
curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-maciasl-patchmatic/downloads/RehabMan-patchmatic-2016-0312.zip
curl --progress-bar -O https://raw.githubusercontent.com/RehabMan/OS-X-ACPI-Battery-Driver/master/SSDT-BATC.dsl
curl --progress-bar -O https://raw.githubusercontent.com/Limitless1Studio/ssdtPRGen.sh-Command/Beta/ssdtPRgensh.command
curl --progress-bar -O https://raw.githubusercontent.com/Limitless1Studio/x250/master/finalconfig.plist
curl --progress-bar -O https://raw.githubusercontent.com/Limitless1Studio/x250/master/graphicsconfig.plist
curl --progress-bar -O https://raw.githubusercontent.com/Limitless1Studio/x250/master/installconfig.plist

echo "\n================================================================================\n"
echo "----------------------Unzipping Files!----------------------"
echo "\n================================================================================\n"

# unzip is the command to unzip kexts
unzip iasl.zip
unzip RehabMan-patchmatic-2016-0312.zip

echo "\n================================================================================\n"
echo "----------------------Cleaning up Files folder!----------------------"
echo "\n================================================================================\n"

# sudo rm -r must be used to remove kexts which are a directory
# sudo rm -f is used to delete a single file which .zips are
sudo rm -v -f iasl.zip
sudo rm -v -f RehabMan-patchmatic-2016-0312.zip
echo "\n================================================================================\n"
echo "----------------------Downloading iMessage Tools!----------------------"
echo "\n================================================================================\n"

cd ~/Desktop/x250/iMessage
curl --progress-bar -L -o simplemlbsh.zip https://www.tonymacx86.com/attachments/simplemlb-sh-zip.263858/
curl --progress-bar -L -o imessagedebugv2.zip http://www.tonymacx86.com/attachments/imessagedebugv2-zip.114403/
sleep 5

echo "\n================================================================================\n"
echo "----------------------Unzipping iMessage Files!----------------------"
echo "\n================================================================================\n"

unzip imessagedebugv2.zip
unzip simplemlbsh.zip

echo "\n================================================================================\n"
echo "----------------------Cleaning up iMessage folder!----------------------"
echo "\n================================================================================\n"

sudo rm -v -f simplemlbsh.zip
sudo rm -v -f imessagedebugv2.zip
sudo rm -v -r __MACOSX

echo "\n================================================================================\n"
echo "----------------------Donwloading Patches!----------------------"
echo "\n================================================================================\n"

# curl -L -O must be used for BitBucket zips
# curl -o must be used to rename the file correctly because the link does not
# end in .zip
cd ~/Desktop/x250/Patches
curl --progress-bar -o ~/Desktop/x250/Patches/system_WAK2.txt https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/system/system_WAK2.txt
curl --progress-bar -o ~/Desktop/x250/Patches/system_HPET.txt https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/system/system_HPET.txt
curl --progress-bar -o ~/Desktop/x250/Patches/system_IRQ.txt https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/system/system_IRQ.txt
curl --progress-bar -o ~/Desktop/x250/Patches/system_RTC.txt https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/system/system_RTC.txt
curl --progress-bar -o ~/Desktop/x250/Patches/system_IMEI.txt https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/system/system_IMEI.txt
curl --progress-bar -o ~/Desktop/x250/Patches/system_OSYS_win8.txt https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/system/system_OSYS_win8.txt
curl --progress-bar -o ~/Desktop/x250/Patches/system_SMBUS.txt https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/system/system_SMBUS.txt
curl --progress-bar -o ~/Desktop/x250/Patches/system_Mutex.txt https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/system/system_Mutex.txt
curl --progress-bar -o ~/Desktop/x250/Patches/graphics_Rename-PCI0_VID.txt https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/graphics/graphics_Rename-PCI0_VID.txt
curl --progress-bar -o ~/Desktop/x250/Patches/graphics_Rename-B0D3.txt https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/graphics/graphics_Rename-B0D3.txt
curl --progress-bar -o ~/Desktop/x250/Patches/led_blink.txt https://raw.githubusercontent.com/shmilee/T450-Hackintosh/master/DSDT/patch-files/2_led_blink.txt
curl --progress-bar -o ~/Desktop/x250/Patches/usb_prw.txt https://raw.githubusercontent.com/shmilee/T450-Hackintosh/master/DSDT/patch-files/2_usb_prw.txt
curl --progress-bar -o ~/Desktop/x250/Patches/Fn_Keys.txt https://raw.githubusercontent.com/shmilee/T450-Hackintosh/master/DSDT/patch-files/3_Fn_Keys.txt
curl --progress-bar -o ~/Desktop/x250/Patches/BatteryManagement.txt https://raw.githubusercontent.com/shmilee/T450-Hackintosh/master/DSDT/patch-files/4_battery_Lenovo-T450.txt
curl --progress-bar -o ~/Desktop/x250/Patches/HDEF-layout1.txt https://raw.githubusercontent.com/shmilee/T450-Hackintosh/master/DSDT/patch-files/5_audio_HDEF-layout1.txt

echo "\n================================================================================\n"
echo "----------------------Donwloading ALC3232 Fix!----------------------"
echo "\n================================================================================\n"

cd ~/desktop/x250
curl --progress-bar -L -O https://github.com/Limitless1Studio/x250ALC3232/archive/master.zip

echo "\n================================================================================\n"
echo "----------------------Unzipping ALC3232!----------------------"
echo "\n================================================================================\n"

unzip master.zip

echo "\n================================================================================\n"
echo "----------------------Cleaning up ALC3232 folder!----------------------"
echo "\n================================================================================\n"

mv -v ~/desktop/x250/x250ALC3232-master/ALC3232 ~/desktop/x250
sudo rm -v -r x250ALC3232-master
sudo rm -v -f master.zip
echo "\n================================================================================\n"


exit
