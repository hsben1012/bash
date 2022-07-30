::reset vm program
@echo off
echo restart VM progarm
set PATH=%PATH%;C:\Program Files (x86)\VMware\VMware Player\;C:\Users\aalan

vmrun reset K:\VM\os\UBS2204_01\UBS2204_01.vmx >nul
vmrun reset K:\VM\os\alp\alp.vmx >nul
vmrun reset K:\VM\os\alp.podman\alpine64.vmwarevm\alpine64.vmx >nul
vmrun reset K:\VM\os\alp.podman_01\alpine64.vmwarevm\alpine64.vmx >nul
vmrun reset K:\VM\os\alp.podman_02\alpine64.vmwarevm\alpine64.vmx >nul
vmrun reset K:\VM\os\CDC\alp.podman_03\alpine64.vmwarevm\alpine64.vmx >nul

echo VM restart OK!