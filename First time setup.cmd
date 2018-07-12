
@echo off

cls
git pull

cls
docker login

cls
echo Attempting to stop any running Docker containers.
echo:
Windows\make stop

cls
echo Starting Docker containers and downloading what is needed. This may take a while the first time.
echo:
Windows\make start

cls
echo Downloading a copy of the Website repository
echo:
Windows\make clone-windows-website

cls
echo Downloading a copy of the Game repository
echo:
Windows\make clone-windows-game

cls
echo Downloading a copy of the Wiki repository
echo:
Windows\make clone-windows-wiki

cls
echo Importing the databases.
echo:
Windows\make import-windows


cls
echo Extracting client cache
echo:
md "%HOMEPATH%/OpenRSC"
"Windows/7z.exe" x "Game/client/cache.zip" -o"%HOMEPATH%/OpenRSC" -r

cls
echo First time setup is now complete. Go ahead and open "Start Game.cmd" now.
pause
