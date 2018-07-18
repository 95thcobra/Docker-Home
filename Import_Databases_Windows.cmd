@echo off
echo:
echo Attempting to import (or overwrite) the game database.
echo:
make import-windows-game
echo:
echo:
echo Attempting to import (or overwrite) the website database.
echo:
make import-windows-website
echo:
echo:
echo Attempting to import (or overwrite) the wiki database.
echo:
make import-windows-wiki
echo:
pause
