@echo off
echo:
echo Fetching updates to local repositories.
echo:
git pull
make pull-game-windows
make pull-website-windows
echo:
echo:
echo Local repositories have been updated if existing.
echo:
pause
