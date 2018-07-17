
@echo off
SETLOCAL ENABLEEXTENSIONS
set RED=Color 04
set GREEN=Color 0A
set NC=Color 0F
cls

echo Open RSC Installer:
echo:
echo An easy to run RSC private server environment using Docker magic.
echo:
echo Before continuing, Open RSC needs to know if you have Java JDK, Docker, and Git installed.
echo This installer can install one or both for you if needed.
echo:
echo Choices:
echo   1 - Install for me!
echo   2 - I'm all set, continue!
echo:
SET /P install=Please enter a number choice from above:
echo:

IF /i "%install%"=="1" goto doinstall
IF /i "%install%"=="2" goto skip

echo Error! %install% is not a valid option. Press enter to try again."
echo:
SET /P install=""
Setup_Windows.cmd

:doinstall
echo:
echo Installing Chocolatey base system.
echo:
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
echo:
echo:
echo Installing basic software needed to run.
echo:
choco install -y 7zip.install
echo:
echo:
echo Do you have Java JDK installed already?"
echo:
echo Choices:
echo   1 - Install for me!
echo   2 - I'm all set, continue!
echo:
SET /P java=Please enter a number choice from above:
echo:
IF /i "%java%"=="1" goto installjava
IF /i "%java%"=="2" goto askdocker

echo Error! %java% is not a valid option. Press enter to try again."
echo:
SET /P java=""
goto doinstall

:installjava
echo:
echo Installing Java JDK.
echo:
choco install -y jdk8
echo:
echo:
goto askdocker

:askdocker
echo:
echo Do you have Docker installed already?
echo:
echo Choices:
echo   1 - Install for me!
echo   2 - I'm all set, continue!
echo:
SET /P docker=Please enter a number choice from above:
echo:
IF /i "%docker%"=="1" goto installdocker
IF /i "%docker%"=="2" goto askgit

echo Error! %docker% is not a valid option. Press enter to try again."
echo:
SET /P docker=""
goto askdocker

:installdocker
echo:
echo Installing Docker.
echo:
choco install -y docker docker-compose
echo:
echo:
echo Don't forget to make your C: drive shared with containers in the Docker settings!
SET /P install="Please follow the Docker install prompts and press enter here once finished."
echo:
goto askgit

:askgit
echo:
echo Do you have Git installed already?
echo:
echo Choices:
echo   1 - Install for me!
echo   2 - I'm all set, continue!
echo:
SET /P git=Please enter a number choice from above:
echo:
IF /i "%git%"=="1" goto installgit
IF /i "%git%"=="2" goto askide

echo Error! %git% is not a valid option. Press enter to try again."
echo:
SET /P git=""
goto askgit

:installgit
echo:
echo Installing Git
echo:
choco install -y git.install
echo:
echo:
goto askide

:askide
echo:
echo Do you want a programming IDE installed?
echo:
echo Choices:
echo   1 - Install NetBeans
echo   2 - Install IntelliJ IDEA Community Edition
echo   3 - Install Eclipse
echo   4 - I'm all set, continue!
echo:
SET /P git=Please enter a number choice from above:
echo:
IF /i "%git%"=="1" goto installnetbeans
IF /i "%git%"=="2" goto installintellij
IF /i "%git%"=="3" goto installeclipse
IF /i "%git%"=="4" goto skip

echo Error! %git% is not a valid option. Press enter to try again."
echo:
SET /P git=""
goto askide

:installnetbeans
echo:
choco install -y netbeans
echo:
goto skip

:installintellij
echo:
choco install -y intellijidea-community
echo:
goto skip

:installeclipse
echo:
choco install -y eclipse
echo:
goto skip

:skip
echo:
echo Checking for updates to the Docker-Home repository.
echo:
git pull
echo:
echo:
docker login
echo:
echo:
echo Attempting to stop any running Docker containers.
echo:
Windows\make stop
echo:
echo:
echo Starting Docker containers and downloading what is needed. This may take a while the first time.
echo:
Windows\make start
echo:
echo:
echo:
echo Open RSC Installer
echo An easy to run RSC private server environment using Docker magic.
echo:
echo Choices:
echo  1 - Single player RSC game + basic database editing (using PHPMyAdmin)
echo  2 - Game + Website + PHPMyAdmin
echo  3 - Game + Website + PHPMyAdmin + RSC Preservation Wiki
echo:
SET /P choice=Which of the above do you want? Type 1, 2, or 3, and press enter."
echo:
echo:
echo Downloading a copy of the Website repository
echo:
Windows\make clone-windows-website
echo:
echo:
echo Downloading a copy of the Game repository
echo:
Windows\make clone-windows-game
echo:
echo:
echo Importing the game databases.
echo:
Windows\make import-windows-game
echo:
echo Importing the website database.
echo:
Windows\make import-windows-website
echo:
echo:
echo Extracting client cache
echo:
md "%HOMEPATH%/OpenRSC"
"Windows/7z.exe" x "Game/client/cache.zip" -o"%HOMEPATH%/OpenRSC" -r
echo:
echo:
echo First time setup is now complete. Go ahead and open "Start Game.cmd" now.
echo:
pause
