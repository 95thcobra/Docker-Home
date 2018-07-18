@echo off
echo:
echo Stopping the running Docker containers.
echo:
make stop
echo:
echo:
echo Killing any running in the background instance of the game server.
echo:
tskill java /a
echo:
pause
