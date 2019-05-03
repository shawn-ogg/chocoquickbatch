@echo off

:: Check to see if we are admin
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' (
	goto admin
)
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

"%temp%\getadmin.vbs"
exit /B

PAUSE
:admin

set choco="%ALLUSERSPROFILE%\chocolatey\bin\choco"
IF "%1" == "chocoisinstalled" (
	echo.
	echo.
	echo ************************ 
	echo USING CHOCO TO INSTALL PACKAGES
	echo ************************ 
	
	:: editors
	%choco% install vim -y
	%choco% install geany -y
	%choco% install vscode -y
	%choco% install notepadplusplus -y

	:: browser
	%choco% install chromium -y
	%choco% install firefox -y
	%choco% install tor-browser -y

	:: dev
	%choco% install git -y
	%choco% install sourcetree -y
	%choco% install mysql.workbench -y
	%choco% install runinbash -y
	%choco% install vagrant -y
	%choco% install wsl -y
	%choco% install wsl-ubuntu-1804 -y
	%choco% install virtualbox -y
	%choco% install wsltty -y

	:: connectivity
	%choco% install citrix-receiver -y
	%choco% install thunderbird -y
	%choco% install filezilla -y
	%choco% install openssh -y
	%choco% install wireshark -y
	
	:: tools
	%choco% install 7zip.install -y
	%choco% install treesizefree -y
	%choco% install everything -y
	%choco% install tomboy -y
	%choco% install gpg4win -y
	%choco% install foxitreader -y
	%choco% install logitech-options -y
	%choco% install ditto -y	

	:: multimedia
	%choco% install vlc -y
	%choco% install opencodecs -y
	%choco% install foobar2000 -y
	%choco% install audacity -y
	%choco% install handbrake.install -y
	:: %choco% install kdenlive -y
	:: %choco% install obs -y

	:: games
	%choco% install steam -y
	%choco% install goggalaxy -y
	%choco% install mumble -y
	
	:: graphics
	%choco% install paint.net -y
	%choco% install gimp -y
	%choco% install irfanview -y

	:: office
	%choco% install libreoffice-fresh -y
	%choco% install kmymoney -y

	:: chat
	%choco% install skype -y
	%choco% install wire -y
	%choco% install telegram -y
	

	echo.
	echo.
	echo ************************ 
	echo FINISHED! Check that everything is okay before closing
	echo ************************ 
	echo.
	pause
) ELSE (
	IF EXIST "%ALLUSERSPROFILE%\chocolatey\bin" (
		echo.
		echo ************************ 
		echo UPDATING CHOCO
		echo ************************ 

		%choco% update all -y
		echo.
		echo.
		echo ************************ 
		echo FINISHED! Check that everything is okay before closing
		echo ************************ 
		echo.
		pause
	) ELSE (
		echo.
		echo.
		echo ************************ 
		echo INSTALLING CHOCO
		echo ************************ 

		@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

		start %~dpnx0 chocoisinstalled
        )
)
