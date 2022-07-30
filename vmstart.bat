cls
@echo off
chcp 65001 >nul
echo start VM program
::start vm program
set PATH=%PATH%;C:\Program Files (x86)\VMware\VMware Player\;C:\Users\aalan\

echo S1 ubuntu_server
echo S3 alpine_server
echo S4 alpine_server_MariaDB
echo S5 alpine_server_MariaDB_1
echo S6 alpine_server_MariaDB_2
echo S7 alpine_server_MariaDB_3_CDC
echo 選擇代號[S1/S3/S4/S5/S6/S7/ALL]:
set /P act=

if %act%==S1 (
goto S1
)

if %act%==S3 (
goto S3
)

if %act%==S4 (
goto S4
)

if %act%==S5 (
goto S5
)

if %act%==S6 (
goto S6
)

if %act%==S7 (
goto S7
)

if %act%==ALL (
goto ALL
)

if %act%==s1 (
goto S1
)

if %act%==s3 (
goto S3
)

if %act%==s4 (
goto S4
)

if %act%==s5 (
goto S5
)

if %act%==s6 (
goto S6
)

if %act%==s7 (
goto S7
)

if %act%==all (
goto ALL
)

goto :Exit

:ALL
vmrun start K:\VM\os\UBS2204_01\UBS2204_01.vmx
vmrun start K:\VM\os\alp\alp.vmx
vmrun start K:\VM\os\alp.podman\alpine64.vmwarevm\alpine64.vmx
vmrun start K:\VM\os\alp.podman_01\alpine64.vmwarevm\alpine64.vmx
vmrun start K:\VM\os\alp.podman_02\alpine64.vmwarevm\alpine64.vmx
vmrun start K:\VM\os\CDC\alp.podman_03\alpine64.vmwarevm\alpine64.vmx
vmrun start K:\VM\os\UBS2204_02\UBS2204_01.vmx
vmrun start K:\VM\os\UbuntuD\UbuntuD.vmx
echo All VM start OK!

goto exit

:S1
::VM_server_01_ubuntu start
vmrun start K:\VM\os\UBS2204_01\UBS2204_01.vmx
timeout/t 1 >nul
echo VM Ubuntu_S1 start OK!
goto exit

:S3
::VM_server_01_alpine start
vmrun start K:\VM\os\alp\alp.vmx
timeout/t 1 >nul
echo VM alp_S3 start OK!
goto exit

:S4
::VM_server_02_alpine start
vmrun start K:\VM\os\alp.podman\alpine64.vmwarevm\alpine64.vmx
timeout/t 1 >nul
echo VM alp_S4 start OK!
goto exit

:S5
::VM_server_03_alpine start
vmrun start K:\VM\os\alp.podman_01\alpine64.vmwarevm\alpine64.vmx
timeout/t 1 >nul
echo VM alp_S5 start OK!
goto exit

:S6
::VM_server_04_alpine start
vmrun start K:\VM\os\alp.podman_02\alpine64.vmwarevm\alpine64.vmx
timeout/t 1 >nul
echo VM alp_S6 start OK!
goto exit

:S7
::VM_server_05_alpine start
vmrun start K:\VM\os\CDC\alp.podman_03\alpine64.vmwarevm\alpine64.vmx
timeout/t 1 >nul
echo VM alp_S7 start OK!
goto exit

:Exit