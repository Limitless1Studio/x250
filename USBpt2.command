#!/bin/sh

echo "\n================================================================================\n"
echo "----------------------Moving Files to USB!----------------------"
echo "\n================================================================================\n"

sudo cp -vR ~/Desktop/USB/FakeSMC.kext /Volumes/ESP/EFI/CLOVER/kexts/Other
sudo cp -vR ~/Desktop/USB/IntelMausiEthernet.kext /Volumes/ESP/EFI/CLOVER/kexts/Other
sudo cp -vR ~/Desktop/USB/VoodooPS2Controller.kext /Volumes/ESP/EFI/CLOVER/kexts/Other

sudo cp -vR ~/Desktop/USB/HFSPlus.efi /Volumes/ESP/EFI/CLOVER/drivers64UEFI

sudo cp -vR ~/Desktop/USB/installconfig.plist /Volumes/ESP/EFI/CLOVER/config.plist
