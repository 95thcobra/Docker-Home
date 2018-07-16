@echo off
echo:
echo Attempting to import (or overwrite) the game database.
echo:
Windows\make import-windows-game
echo:
echo:
echo Attempting to import (or overwrite) the website database.
echo:
Windows\make import-windows-website
echo:
echo:
echo Attempting to import (or overwrite) the wiki database.
echo:
Windows\make import-windows-wiki
echo:
pause
