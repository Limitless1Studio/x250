#!/bin/sh

echo "\n================================================================================\n"
echo "----------------------Making USB Folder!----------------------"
echo "\n================================================================================\n"

cd ~/Desktop
mkdir -v USB

echo "\n================================================================================\n"
echo "----------------------Donwloading USB Files!----------------------"
echo "\n================================================================================\n"

cd ~/Desktop/USB
curl --progress-bar -L -o Cloverv24kr4061.zip https://downloads.sourceforge.net/project/cloverefiboot/Installer/Clover_v2.4k_r4061.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcloverefiboot%2F&ts=1493489376&use_mirror=pilotfiber
curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/RehabMan-FakeSMC-2017-0414.zip
curl --progress-bar -L -O https://bitbucket.org/RehabMan/os-x-intel-network/downloads/RehabMan-IntelMausiEthernet-v2-2017-0321.zip
curl --progress-bar -O https://github.com/JrCs/CloverGrowerPro/raw/master/Files/HFSPlus/X64/HFSPlus.efi


cd ~/downloads
curl --progress-bar -L -o OS-X-Voodoo-PS2-Controller-master.zip https://github.com/tluck/OS-X-Voodoo-PS2-Controller/archive/master.zip
sleep 5

echo "\n================================================================================\n"
echo "----------------------Unzipping Clover!----------------------"
echo "\n================================================================================\n"

cd ~/Desktop/USB
unzip Cloverv24kr4061.zip
unzip -q RehabMan-FakeSMC-2017-0414.zip
unzip -q RehabMan-IntelMausiEthernet-v2-2017-0321.zip

cd ~/downloads

unzip -q OS-X-Voodoo-PS2-Controller-master.zip

cd ~/downloads/OS-X-Voodoo-PS2-Controller-master

sudo make --silent


echo "\n================================================================================\n"
echo "----------------------Cleaning up Clover Bootloader Files!----------------------"
echo "\n================================================================================\n"

cd ~/Desktop/USB
rm -v -f Clover_v2.4k_r4061.pkg.md5
rm -v -f Cloverv24kr4061.zip
mv -v ~/desktop/USB/Release/IntelMausiEthernet.kext ~/desktop/USB
sudo rm -v -r FakeSMC_ACPISensors.kext
sudo rm -v -r FakeSMC_CPUSensors.kext
sudo rm -v -r FakeSMC_GPUSensors.kext
sudo rm -v -r FakeSMC_LPCSensors.kext
sudo rm -v -r Debug
sudo rm -v -r HWMonitor.app
rm -v -f RehabMan-FakeSMC-2017-0414.zip
rm -v -f RehabMan-IntelMausiEthernet-v2-2017-0321.zip
sudo rm -v -r Release

cd ~/downloads/OS-X-Voodoo-PS2-Controller-master/build/products/Release

sudo mv -v ~/downloads/OS-X-Voodoo-PS2-Controller-master/build/products/Release/VoodooPS2Controller.kext ~/desktop/USB

cd ~/downloads

sudo rm -v -r OS-X-Voodoo-PS2-Controller-master
sudo rm -v -f OS-X-Voodoo-PS2-Controller-master.zip

exit 0
