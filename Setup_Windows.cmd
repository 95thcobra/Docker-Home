
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
echo Before continuing, Open RSC needs to know if you have Java, Docker, and Git installed.
echo This installer can install one or both for you if needed.
echo:
echo Choices:
echo   1 - Install for me!
echo   2 - I'm all set, continue! (default)"
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
echo Do you have Java OpenJDK installed already?"
echo:
echo Choices:
echo   1 - Install for me!
echo   2 - I'm all set, continue! (default)"
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
echo Downloading Java OpenJDK.
echo:
"Windows/wget.exe" "http://download.oracle.com/otn-pub/java/jdk/10.0.1+10/fb4372174a714e6b8c52526dc134031e/jdk-10.0.1_windows-x64_bin.exe" --no-check-certificate
echo:
echo Download complete. Installing Oracle Java JDK 10.
echo:
"jdk-10.0.1_windows-x64_bin.exe"
echo:
SET /P install="Please follow the Java install prompts and press enter here once finished."
echo:
goto askdocker

:askdocker
echo:
echo Do you have Docker installed already?
echo:
echo Choices:
echo   1 - Install for me!
echo   2 - I'm all set, continue! (default)"
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
echo Downloading Docker.
echo:
"Windows/wget.exe" "https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe"
echo:
echo Download complete. Installing Docker.
echo:
"Docker%20for%20Windows%20Installer.exe"
echo:
SET /P install="Please follow the Docker install prompts and press enter here once finished."
echo:
goto askgit

:askgit
echo:
echo Do you have Git installed already?
echo:
echo Choices:
echo   1 - Install for me!
echo   2 - I'm all set, continue! (default)"
echo:
SET /P git=Please enter a number choice from above:
echo:
IF /i "%git%"=="1" goto installgit
IF /i "%git%"=="2" goto skip

echo Error! %git% is not a valid option. Press enter to try again."
echo:
SET /P git=""
goto askgit

:installgit
echo:
"Windows/wget.exe" "https://github.com/git-for-windows/git/releases/download/v2.18.0.windows.1/Git-2.18.0-64-bit.exe"
echo:
echo Installing Git.
echo:
"Git-2.18.0-64-bit.exe"
echo:
SET /P install="Please follow the Git install prompts and press enter here once finished."
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
