@echo off
mkdir %USERPROFILE%\.ssh
ssh-keygen -f %USERPROFILE%\.ssh\id_rsa -t rsa -N ''
cls
echo === msys-git docker ==============================================
echo Docker container based on microsoft/windowsservercore
echo Author: vcarluer@gmail.com
echo /
echo MinGW/MSYS tools installed with bash, vim, openssh and find tools
echo Use 'mingw-get install xxx' to install a new tool
echo Bash is not the default shell due to an issue with ctrl+c signal trap
echo /
echo Msysgit 1.9.5 installed due to a bug with git 2.x based on msys2
echo Https://github.com/docker/for-win/issues/262
echo /
echo The entry point script generates new ssh keys for the container.
echo SSH public key:
cat c:\Users\ContainerAdministrator\.ssh\id_rsa.pub
echo Use 'ssh-keyscan -H HOST >> %USERPROFILE%/.ssh/known_hosts' to add HOST key
echo ==================================================================
cmd /S /C %1
