::stop VB program
@echo off
echo stop VB program
set PATH=%PATH%;C:\Program Files\Oracle\VirtualBox;C:\Users\aalan

VBoxManage controlvm alp_docker poweroff > nul 2>&1
VBoxManage controlvm ubuntu64_web poweroff > nul 2>&1

echo VB stop OK!