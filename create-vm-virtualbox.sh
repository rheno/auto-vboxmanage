#!/bin/bash

# create single VM
VBoxManage import "FULL_PATH_OVA_FILE" --vsys 0 --vmname "VM_NAME"

# Modify VM (VM_NAME) network adapter (virtual network), memory and CPU 
VBoxManage modifyvm "VM_NAME" --nic1 nat --nic2 hostonly --hostonlyadapter2 vboxnet0 --memory 2048 --cpus 2


# create multiple VM's
for i in {1..5}
do
	VBoxManage import /Volumes/Data/Centos/virtualbox-centos8/Centos8.ova --vsys 0 --vmname "node-$i"
	VBoxManage modifyvm "node-$i" --nic1 nat --nic2 hostonly --hostonlyadapter2 vboxnet0 --memory 2048 --cpus 2
done

# Delete VM
VBoxManage unregistervm "VM_NAME" --delete

# start VM headless
VBoxManage startvm "VM_NAME" --type headless

# Stop VM
VBoxManage controlvm "VM_NAME" poweroff

# Source :
# https://networking.ringofsaturn.com/Unix/Create_Virtual_Machine_VBoxManage.php
