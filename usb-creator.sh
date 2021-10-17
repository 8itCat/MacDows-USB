#!/bin/bash

echo "Welcome to MacDows USB creator!"
echo "Made with ❤️  by 8itCat"
echo "Let's get started..."
echo "-------------------------------"
sleep 2

# Ask user for ISO and validate that it's a Windows ISO
while true
do
echo
echo "Drag and drop your Windows ISO onto this window and press Enter:"
read ISO
echo
    if [[ $ISO == *"iso"* ]]; then
        mountedDisk=$(echo $(hdiutil mount $(echo $ISO | tr -d \')) | cut -d' ' -f2-)
        cd $mountedDisk
        if [[ $(ls $mountedDisk) == *"setup.exe"* ]]; then
            echo "Successfully verified the Windows ISO!"
            break
        else
            echo "Unable to verify ISO as Windows.."
            echo "Please validate that you selected the correct ISO"
            echo "or re-download the ISO from Microsoft's website"
            cd
        fi
    else
        echo "Not a valid option, try again..."
    fi
done

# Ask user for USB and validate that it will work
while true
do
echo
echo "Plug in a USB drive and select it to make it bootable with Windows" 
diskutil list > /tmp/disks.txt 
DISKS=(grep -hnr "/dev/" /tmp/disks.txt | cut -d'/' -f3-)
if [[ $DISKS == *"synthesized"* ]] || [[ $DISKS == *"disk image"* ]] || [[ $DISKS == *"internal"* ]]
rm /tmp/disks.txt
echo "Enter a number as shown in the list (press 'r' to refresh):"
read disk 
done

