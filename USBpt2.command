#!/bin/sh

echo "\n================================================================================\n"
echo "----------------------Moving Files to USB!----------------------"
echo "\n================================================================================\n"

sudo mv -v ~/Desktop/USB/FakeSMC.kext /Volumes/CLOVER\ EFI/EFI/CLOVER/kexts/Other
sudo mv -v ~/Desktop/USB/IntelMausiEthernet.kext /Volumes/CLOVER\ EFI/EFI/CLOVER/kexts/Other
sudo mv -v ~/Desktop/USB/VoodooPS2Controller.kext /Volumes/CLOVER\ EFI/EFI/CLOVER/kexts/Other

sudo mv -v ~/Desktop/USB/HFSPlus.efi /Volumes/CLOVER\ EFI/EFI/CLOVER/drivers64UEFI

sudo mv -v ~/Desktop/USB/installconfig.plist /Volumes/CLOVER\ EFI/EFI/CLOVER/config.plist 
