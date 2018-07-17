@echo off
echo:
echo Cloning the game repository.
Windows\make clone-windows-game
echo:
echo:
echo Cloning the website repository.
echo:
Windows\make clone-windows-website
echo:
echo:
echo Cloning the wiki repository.
echo:
Windows\make clone-windows-wiki
echo:
pause
