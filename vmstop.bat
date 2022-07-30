::stop vm program
@echo off
echo stop VM program
set PATH=%PATH%;C:\Program Files (x86)\VMware\VMware Player\;C:\Users\aalan

vmrun stop K:\VM\os\UBS2204_01\UBS2204_01.vmx >nul
vmrun stop K:\VM\os\alp\alp.vmx >nul
vmrun stop K:\VM\os\alp.podman\alpine64.vmwarevm\alpine64.vmx >nul
vmrun stop K:\VM\os\alp.podman_01\alpine64.vmwarevm\alpine64.vmx >nul
vmrun stop K:\VM\os\alp.podman_02\alpine64.vmwarevm\alpine64.vmx >nul
vmrun stop K:\VM\os\CDC\alp.podman_03\alpine64.vmwarevm\alpine64.vmx >nul

timeout/t 1 >nul
echo VM stop OK!