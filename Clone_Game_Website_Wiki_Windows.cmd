@echo off
echo:
echo Cloning the game repository.
make clone-windows-game
echo:
echo:
echo Cloning the website repository.
echo:
make clone-windows-website
echo:
echo:
echo Cloning the wiki repository.
echo:
make clone-windows-wiki
echo:
pause
