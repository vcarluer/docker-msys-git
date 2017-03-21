echo === msys-git docker ==============================================
echo Docker container based on microsoft/windowsservercore
echo Author: vcarluer@gmail.com
echo SSH public key:
cat ~/.ssh/id_rsa.pub
echo Type 'info' to get information about this image
echo ==================================================================

typeInfo() {
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
	cat ~/.ssh/id_rsa.pub
	echo Use 'ssh-keyscan -H HOST >> %USERPROFILE%/.ssh/known_hosts' to add HOST key
	echo ==================================================================
}

alias info=typeInfo

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour

export PS1='\[\033[01;33m\]\u:\[\033[01;36m\]\W \[\033[01;35m\]\$ \[\033[00m\]'
alias ls='ls --color=auto'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
alias ..='cd ..'
alias ...='cd ../..'
alias psl=powershell
set -o vi
trap '' SIGINT
