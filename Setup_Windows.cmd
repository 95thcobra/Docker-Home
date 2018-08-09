
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
echo Installing the required Chocolatey base system.
echo:
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
echo:
echo:
echo Installing basic software needed to run the rest of this script.
echo:
choco install -y 7zip.install make
echo:
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
echo Do you have Java JDK 8 and Apache Ant installed already?"
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
echo Installing Java JDK and Apache Ant.
echo:
choco install -y jdk8 ant
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
choco install -y docker-for-windows
echo:
echo:
echo Launching Docker for Windows. The Docker whale icon is by the system clock.
echo Allow it a short bit of time to start running.
echo ""
call START "C:\Program Files\Docker\Docker\Docker for Windows.exe"
echo ""
echo Once started, right click on it and click "Settings..."
echo Then click the "Shared Drives" tab on the left.
echo Check the box beside the "C:" drive so that the Docker containers can work.
echo Click "Apply" and then press enter here so the script can continue.
echo:
echo:
SET /P install="Press enter when the above steps have been completed."
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
make stop
echo:
echo:
echo Starting Docker containers and downloading what is needed. This may take a while the first time.
echo:
make start
echo:
echo:

:edition
echo:
echo Open RSC Installer
echo An easy to run RSC private server environment using Docker magic.
echo:
echo Choices:
echo  1 - Single player RSC game + basic database editing (using PHPMyAdmin)
echo  2 - Game + Website + PHPMyAdmin
echo:
SET /P edition=Which of the above do you want? Type 1, 2, or 3, and press enter."
echo:

IF /i "%edition%"=="1" goto game
IF /i "%edition%"=="2" goto gameweb

echo Error! %edition% is not a valid option. Press enter to try again."
echo:
SET /P edition=""
goto edition

:game
echo:
echo Downloading a copy of the Game repository
echo:
make clone-windows-game
echo:
echo:
echo Importing the game databases.
echo:
make pull-game-windows
echo:
make import-windows-game
echo:
echo:
goto final

:gameweb
echo:
echo Downloading a copy of the Website repository
echo:
make clone-windows-website
echo:
echo:
echo Downloading a copy of the Game repository
echo:
make clone-windows-game
echo:
echo:
make pull-game-windows
echo:
echo Importing the game databases.
echo:
make import-windows-game
echo:
echo:
echo Importing the website database.
echo:
make pull-website-windows
echo:
make import-windows-website
echo:
echo:
goto final

:gamewebwiki
echo:
echo Downloading a copy of the Website repository
echo:
make clone-windows-website
echo:
echo:
echo Downloading a copy of the Game repository
echo:
make clone-windows-game
echo:
echo:
make pull-wiki-windows
echo:
echo Downloading a copy of the Wiki repository
echo:
make clone-windows-wiki
echo:
echo:
make pull-game-windows
echo:
echo Importing the game databases.
echo:
make import-windows-game
echo:
echo:
echo Importing the website database.
echo:
make pull-website-windows
echo:
make import-windows-website
echo:
echo:
echo Extracting Wiki database
echo:
7z x "Website/Wiki/openrsc_wiki.sql.zip" -o"Website/Wiki"
echo:
echo:
echo Importing the wiki database.
echo:
make import-windows-wiki
echo:
goto final

:final
echo:
echo Extracting client cache
echo:
md "%HOMEPATH%/OpenRSC"
7z x "Game/client/cache.zip" -o"%HOMEPATH%/OpenRSC" -r
echo:
echo:
echo First time setup is now complete. Go ahead and open "Start Game.cmd" now.
echo:
pause
