# windows server core + MinGW/MSYS + msysgit
# Author: vcarluer@gmail.com
# https://github.com/vcarluer/msys-git
# https://hub.docker.com/r/microsoft/windowsservercore/
# http://mingw.org/
# https://github.com/msysgit/msysgit
#
# git 2.x based on msys2 has a bug with Windows Server Core
# https://github.com/docker/for-win/issues/262
# cygwin has the same problem
# => This image uses git 1.9.5 which is based on a fork of msys
#
# no correct text editor available on Windows image either
# => This image has msys installed with some basic tools:
# bash as default shell, vim, openssh, find tools
#
# you can add new gnu tools with 'mingw-get install xxx'
# https://sourceforge.net/projects/mingw/files/MSYS/
#
# the entry point script generate new ssh keys for the container
# use 'ssh-keyscan -H HOST >> %USERPROFILE%/.ssh/known_hosts' to add HOST key
#
FROM microsoft/windowsservercore
# Set Powershell context
SHELL ["powershell", "-NoProfile", "-command"]
RUN Set-ExecutionPolicy -ExecutionPolicy Unrestricted
# === mingw ===
# Downloading and installing mingw
RUN mkdir c:\install
RUN (new-object system.net.webclient).DownloadFile('https://freefr.dl.sourceforge.net/project/mingw/Installer/mingw-get/mingw-get-0.6.2-beta-20131004-1/mingw-get-0.6.2-mingw32-beta-20131004-1-bin.zip', 'c:\install\mingw.zip')
RUN Expand-Archive -Path C:\install\mingw.zip -DestinationPath c:\mingw
RUN c:\mingw\bin\mingw-get.exe update
# === msys ===
# Downloading and installing msys bash, vim and openssh and findutils
RUN c:\mingw\bin\mingw-get.exe install bash msys-vim msys-openssh msys-findutils
# === git ===
# Downloading and install git 1.9.5 based on msys (git 2 is based on msys2 which bug on WindowsServerCore image)
RUN (new-object system.net.webclient).DownloadFile('https://github.com/msysgit/msysgit/releases/download/Git-1.9.5-preview20150319/Git-1.9.5-preview20150319.exe', 'c:\install\git-1.9.5.exe')
RUN c:\install\git-1.9.5.exe /SILENT
ENV HOME="c:\Users\ContainerAdministrator"
# === PATH ===
# Setting PATH for mingw/msys and git
RUN $path = $env:path + ';c:\mingw\bin;c:\mingw\msys\1.0\bin;c:\Program Files (x86)\Git\bin'; Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\' -Name Path -Value $path
SHELL ["cmd", "/S", "/C"]
# === bash ===
# Setting environment
COPY bashrc C:\\Users\\ContainerAdministrator\\.bashrc
COPY vimrc C:\\Users\\ContainerAdministrator\\.vimrc
# === ssh ===
COPY entrypoint.cmd C:\\entrypoint.cmd
# ready
WORKDIR C:\\Users\\ContainerAdministrator
ENTRYPOINT ["c:/entrypoint.cmd"]
CMD c:\\Windows\\System32\\cmd.exe
