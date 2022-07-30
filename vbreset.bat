::reboot vb program
@echo off
echo reboot VB progarm
set PATH=%PATH%;C:\Program Files\Oracle\VirtualBox;C:\Users\aalan

echo S1 alp_docker_server, port 25
echo S2 ubuntu64_web_server, port 26
echo 選擇代號[S1/S2/ALL]:
set /P act=

if %act%==S1 (
goto S1
)

if %act%==S2 (
goto S2
)

if %act%==ALL (
goto ALL
)

if %act%==s1 (
goto S1
)

if %act%==s2 (
goto S2
)

if %act%==all (
goto ALL
)

goto :Exit

:ALL
VBoxManage controlvm alp_docker poweroff > nul
VBoxManage startvm alp_docker >nul

goto exit

:S1
::VB_server_alp_docker reboot
VBoxManage controlvm alp_docker poweroff > nul
VBoxManage startvm alp_docker >nul
timeout/t 1 >nul
echo VB alp_server_S1 reboot OK!
goto exit

:S2
::VB_server_ubuntu64_web reboot
VBoxManage controlvm ubuntu64_web poweroff > nul
VBoxManage startvm ubuntu64_web >nul
timeout/t 1 >nul
echo VB ubuntu64_web_server_S2 reboot OK!
goto exit

:Exit