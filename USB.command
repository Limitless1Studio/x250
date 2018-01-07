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
echo "----------------------Making USB Folder!----------------------"
echo "\n================================================================================\n"

cd ~/Desktop
mkdir -v USB

echo "\n================================================================================\n"
echo "----------------------Donwloading USB Files!----------------------"
echo "\n================================================================================\n"

cd ~/Desktop/USB
# curl --progress-bar -L -o Cloverv24kr4061.zip https://downloads.sourceforge.net/project/cloverefiboot/Installer/Clover_v2.4k_r4061.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcloverefiboot%2F&ts=1493489376&use_mirror=pilotfiber
# Updated 12/28/17
# curl --progress-bar -L -o Cloverv24kr4359.zip https://downloads.sourceforge.net/project/cloverefiboot/Installer/Clover_v2.4k_r4359.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcloverefiboot%2F&ts=1514337371&use_mirror=astuteinternet
# Updated to RehabMans branch 1/1/2018
curl --progress-bar -L -O https://bitbucket.org/RehabMan/clover/downloads/Clover_v2.4k_r4359.RM-4506.7036cf0a.zip
# curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/RehabMan-FakeSMC-2017-0414.zip
# Updated 12/28/17
curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/RehabMan-FakeSMC-2017-1017.zip
# curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-intel-network/downloads/RehabMan-IntelMausiEthernet-v2-2017-0321.zip
# Updated 12/28/17
curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-intel-network/downloads/RehabMan-IntelMausiEthernet-v2-2017-0914.zip
curl --progress-bar -L -O https://github.com/JrCs/CloverGrowerPro/raw/master/Files/HFSPlus/X64/HFSPlus.efi
curl --progress-bar -O https://raw.githubusercontent.com/Limitless1Studio/x250/master/installconfig.plist


cd ~/downloads
# curl --progress-bar -L -o OS-X-Voodoo-PS2-Controller-master.zip https://github.com/tluck/OS-X-Voodoo-PS2-Controller/archive/master.zip
curl --progress-bar -L -o OS-X-Voodoo-PS2-Controller-master.zip https://github.com/tluck/OS-X-Voodoo-PS2-Controller/archive/3b5d68a4b6dc2afb478b0232aaa5849b12b49b82.zip
sleep 5

echo "\n================================================================================\n"
echo "----------------------Unzipping Files!----------------------"
echo "\n================================================================================\n"

cd ~/Desktop/USB
# unzip Cloverv24kr4061.zip
# unzip Cloverv24kr4359.zip
unzip -q Clover_v2.4k_r4359.RM-4506.7036cf0a.zip
# unzip -q RehabMan-FakeSMC-2017-0414.zip
unzip -q RehabMan-FakeSMC-2017-1017.zip

#unzip -q RehabMan-IntelMausiEthernet-v2-2017-0321.zip
unzip -q RehabMan-IntelMausiEthernet-v2-2017-0914.zip

cd ~/downloads

unzip -q OS-X-Voodoo-PS2-Controller-master.zip

cd ~/downloads/OS-X-Voodoo-PS2-Controller-3b5d68a4b6dc2afb478b0232aaa5849b12b49b82

sudo make --silent


echo "\n================================================================================\n"
echo "----------------------Cleaning up USB Folder!----------------------"
echo "\n================================================================================\n"

cd ~/Desktop/USB
# rm -v -f Clover_v2.4k_r4061.pkg.md5
# rm -v -f Clover_v2.4k_r4359.pkg.md5
rm -v -f Clover_v2.4k_r4359.RM-4506.7036cf0a.pkg.md5
# rm -v -f Cloverv24kr4061.zip
# rm -v -f Cloverv24kr4359.zip
rm -v -f Clover_v2.4k_r4359.RM-4506.7036cf0a.zip

mv -v ~/desktop/USB/Release/IntelMausiEthernet.kext ~/desktop/USB
sudo rm -v -r FakeSMC_ACPISensors.kext
sudo rm -v -r FakeSMC_CPUSensors.kext
sudo rm -v -r FakeSMC_GPUSensors.kext
sudo rm -v -r FakeSMC_LPCSensors.kext
sudo rm -v -r Debug
sudo rm -v -r HWMonitor.app
sudo rm -v -r __MACOSX
# rm -v -f RehabMan-FakeSMC-2017-0414.zip
rm -v -f RehabMan-FakeSMC-2017-1017.zip

# rm -v -f RehabMan-IntelMausiEthernet-v2-2017-0321.zip
rm -v -f RehabMan-IntelMausiEthernet-v2-2017-0914.zip

sudo rm -v -r Release

cd ~/downloads/OS-X-Voodoo-PS2-Controller-3b5d68a4b6dc2afb478b0232aaa5849b12b49b82/build/products/Release

sudo mv -v ~/downloads/OS-X-Voodoo-PS2-Controller-3b5d68a4b6dc2afb478b0232aaa5849b12b49b82/build/products/Release/VoodooPS2Controller.kext ~/desktop/USB

cd ~/downloads

sudo rm -v -r OS-X-Voodoo-PS2-Controller-3b5d68a4b6dc2afb478b0232aaa5849b12b49b82
sudo rm -v -f OS-X-Voodoo-PS2-Controller-master.zip

exit 0
