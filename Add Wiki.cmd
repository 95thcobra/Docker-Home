@echo off

cls
echo Downloading a copy of the Wiki repository
echo:
Windows\make clone-windows-wiki

cls
echo Importing the databases.
echo:
Windows\make import-windows-wiki

pause
