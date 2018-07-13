
@echo off

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
echo Importing the databases.
echo:
Windows\make import-windows
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
