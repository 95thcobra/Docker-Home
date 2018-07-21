@echo off
echo:
echo Fetching updates to local repositories.
echo:
make pull-game-windows
make pull-website-windows
make pull-wiki-windows
echo:
echo:
echo Local repositories have been updated if existing.
echo:
pause
