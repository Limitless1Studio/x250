#!/bin/sh
# This script will automatically download the needed kexts and create a
# directory in the process

echo ----------------------Making x250 Folder!----------------------
# redirect will not work without the . before /
cd ./desktop
mkdir x250
cd ./x250
mkdir Kexts
mkdir Files
mkdir Programs
mkdir iMessage
mkdir Patches
cd ~/Desktop/x250/Kexts
echo ----------------------Done!----------------------
echo ----------------------Donwloading Kexts!----------------------
# curl -L -O must be used for BitBucket zips
# curl -o must be used to rename the file correctly because the link does not
# end in .zip
curl -o Tluck-VoodooPS2Controller.zip https://www.tonymacx86.com/attachments/tluck-voodoops2controller-zip.242311/
curl -L -O https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/RehabMan-FakeSMC-2017-0414.zip
curl -L -O https://bitbucket.org/RehabMan/os-x-intel-network/downloads/RehabMan-IntelMausiEthernet-v2-2017-0321.zip
curl -L -O https://bitbucket.org/RehabMan/os-x-acpi-battery-driver/downloads/RehabMan-Battery-2017-0428.zip
curl -L -O https://bitbucket.org/RehabMan/os-x-brcmpatchram/downloads/RehabMan-BrcmPatchRAM-2016-0705.zip
curl -L -O https://bitbucket.org/RehabMan/os-x-usb-inject-all/downloads/RehabMan-USBInjectAll-2017-0112.zip
# I moved this download to the dowloads directory to eliminate confusion on which
# Kexts folder we are referring to
cd ~/downloads
curl -o Kexts.zip https://www.tonymacx86.com/attachments/kexts-zip.218178/
cd ~/desktop/x250/Kexts
echo ----------------------Done!----------------------
echo ----------------------Unzipping Kexts!----------------------
# unzip is the command to unzip kexts
unzip RehabMan-FakeSMC-2017-0414.zip
unzip RehabMan-IntelMausiEthernet-v2-2017-0321.zip
unzip RehabMan-Battery-2017-0428.zip
unzip RehabMan-BrcmPatchRAM-2016-0705.zip
unzip RehabMan-USBInjectAll-2017-0112.zip
unzip Tluck-VoodooPS2Controller.zip
cd ~/downloads
unzip Kexts.zip
cd ~/desktop/x250/Kexts
echo ----------------------Done!----------------------
echo ----------------------Cleaning up Kexts folder!----------------------
# sudo rm -r must be used to remove kexts which are a directory
# sudo r -f is used to delete a single file which .zips are
sudo rm -r FakeSMC_ACPISensors.kext
sudo rm -r FakeSMC_CPUSensors.kext
sudo rm -r FakeSMC_GPUSensors.kext
sudo rm -r FakeSMC_LPCSensors.kext
sudo rm -r Debug
sudo rm -r __MACOSX
sudo rm -r HWMonitor.app
rm -f RehabMan-Battery-2017-0428.zip
rm -f RehabMan-FakeSMC-2017-0414.zip
rm -f RehabMan-IntelMausiEthernet-v2-2017-0321.zip
rm -f RehabMan-BrcmPatchRAM-2016-0705.zip
rm -f RehabMan-USBInjectAll-2017-0112.zip
rm -f Tluck-VoodooPS2Controller.zip
mv ~/desktop/x250/Kexts/Release/ACPIBatteryManager.kext ~/desktop/x250/Kexts/
mv ~/desktop/x250/Kexts/Release/IntelMausiEthernet.kext ~/desktop/x250/Kexts/
mv ~/desktop/x250/Kexts/Release/USBInjectAll.kext ~/desktop/x250/Kexts/
mv ~/desktop/x250/Kexts/Release/BrcmPatchRAM2.kext ~/desktop/x250/Kexts/
mv ~/desktop/x250/Kexts/Release/BrcmFirmwareRepo.kext ~/desktop/x250/Kexts/
mv ~/downloads/Kexts/USB_Injector_X250.kext ~/desktop/x250/Kexts/
mv ~/desktop/x250/Kexts/org.rehabman.voodoo.driver.Daemon.plist ~/desktop/x250/Files
mv ~/desktop/x250/Kexts/VoodooPS2Daemon ~/desktop/x250/Files
sudo rm -r Release
cd ~/downloads
sudo rm -r Kexts
sudo rm -r __MACOSX
sudo rm -f Kexts.zip
echo ----------------------Done!----------------------
echo ----------------------Donwloading Programs!----------------------
cd ~/Desktop/x250/Programs
curl -L -o Cloverv24kr4061.zip https://downloads.sourceforge.net/project/cloverefiboot/Installer/Clover_v2.4k_r4061.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcloverefiboot%2F&ts=1493489376&use_mirror=pilotfiber
curl -L -o CCV.zip http://mackie100projects.altervista.org/download-mac.php?version=vibrant
curl -L -O http://wizards.osxlatitude.com/kext/kw.zip
curl -L -O https://bitbucket.org/RehabMan/os-x-maciasl-patchmatic/downloads/RehabMan-MaciASL-2017-0117.zip
echo ----------------------Done!----------------------
echo ----------------------Unzipping Programs!----------------------
unzip Cloverv24kr4061.zip
unzip CCV.zip
unzip kw.zip
unzip RehabMan-MaciASL-2017-0117.zip
echo ----------------------Done!----------------------
echo ----------------------Cleaning up Programs folder!----------------------
rm -f Clover_v2.4k_r4061.pkg.md5
rm -f Cloverv24kr4061.zip
rm -f CCV.zip
rm -f kw.zip
rm -f RehabMan-MaciASL-2017-0117.zip
sudo rm -r __MACOSX
echo ----------------------Done!----------------------
echo ----------------------Donwloading Files!----------------------
# curl -L -O must be used for BitBucket zips
# curl -o must be used to rename the file correctly because the link does not
# end in .zip
cd ~/Desktop/x250/Files
curl -L -O https://github.com/JrCs/CloverGrowerPro/raw/master/Files/HFSPlus/X64/HFSPlus.efi
curl -L -O https://bitbucket.org/RehabMan/acpica/downloads/iasl.zip
curl -L -O https://github.com/Limitless1Studio/x250/raw/master/SSDT-BATC.aml
echo ----------------------Done!----------------------
echo ----------------------Unzipping Files!----------------------
# unzip is the command to unzip kexts
unzip iasl.zip
echo ----------------------Done!----------------------
echo ----------------------Cleaning up Files folder!----------------------
# sudo rm -r must be used to remove kexts which are a directory
# sudo r -f is used to delete a single file which .zips are
rm -f iasl.zip
echo ----------------------Done!----------------------
echo ----------------------Downloading iMessage Tools!----------------------
cd ~/Desktop/x250/iMessage
curl -L -o DPCIManager_ML.zip https://downloads.sourceforge.net/project/dpcimanager/1.5/DPCIManager_ML.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fdpcimanager%2F&ts=1493495370&use_mirror=pilotfiber
curl -L -O https://gist.github.com/theracermaster/b6a9db46b14061d4c995/archive/6f11dc5e8182bba0449e8f3bbe00152428f904ea.zip
curl -L -o imessagedebugv2-zip http://www.tonymacx86.com/attachments/imessagedebugv2-zip.114403/
sleep 5
echo ----------------------Done!----------------------
echo ----------------------Unzipping iMessage Files!----------------------
unzip DPCIManager_ML.zip
unzip imessagedebugv2-zip
unzip 6f11dc5e8182bba0449e8f3bbe00152428f904ea.zip
echo ----------------------Done!----------------------
echo ----------------------Cleaning up iMessage folder!----------------------
mv ~/Desktop/x250/iMessage/b6a9db46b14061d4c995-6f11dc5e8182bba0449e8f3bbe00152428f904ea/simpleMLB.sh ~/Desktop/x250/iMessage
rm -f DPCIManager_ML.zip
rm -f dspci
rm -f imessagedebugv2-zip
rm -f 6f11dc5e8182bba0449e8f3bbe00152428f904ea.zip
sudo rm -r b6a9db46b14061d4c995-6f11dc5e8182bba0449e8f3bbe00152428f904ea
echo ----------------------Done!----------------------
echo ----------------------Donwloading Patches!----------------------
# curl -L -O must be used for BitBucket zips
# curl -o must be used to rename the file correctly because the link does not
# end in .zip
cd ~/Desktop/x250/Patches
curl -L -O https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/graphics/graphics_PNLF.txt
curl -L -O https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/graphics/graphics_Rename-B0D3.txt
curl -L -O https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/graphics/graphics_Rename-PCI0_VID.txt
curl -L -O https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/system/system_IMEI.txt
curl -L -O https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/system/system_WAK2.txt
curl -L -O https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/system/system_Mutex.txt
curl -L -O https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/system/system_HPET.txt
curl -L -O https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/system/system_IRQ.txt
curl -L -O https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/system/system_OSYS_win8.txt
curl -L -O https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/system/system_RTC.txt
curl -L -O https://raw.githubusercontent.com/RehabMan/Laptop-DSDT-Patch/master/system/system_SMBUS.txt
curl -L -O https://raw.githubusercontent.com/shmilee/T450-Hackintosh/master/DSDT/patch-files/2_led_blink.txt
curl -L -O https://raw.githubusercontent.com/shmilee/T450-Hackintosh/master/DSDT/patch-files/2_usb_prw.txt
curl -L -O https://raw.githubusercontent.com/shmilee/T450-Hackintosh/master/DSDT/patch-files/3_Fn_Keys.txt
curl -L -O https://raw.githubusercontent.com/shmilee/T450-Hackintosh/master/DSDT/patch-files/4_battery_Lenovo-T450.txt
curl -L -O https://raw.githubusercontent.com/shmilee/T450-Hackintosh/master/DSDT/patch-files/5_audio_HDEF-layout1.txt

echo ----------------------Done!----------------------
