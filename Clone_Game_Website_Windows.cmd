@echo off
echo:
echo Cloning the game repository.
echo:
Windows\make clone-windows-game
echo:
echo:
echo Cloning the website repository.
echo:
Windows\make clone-windows-website
echo:
pause
