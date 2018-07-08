@echo off
cls
docker login
cls
echo Attempting to stop any running Docker containers.
echo:
Windows\make stop
cls
echo Starting Docker containers and downloading what is needed. This may take a while the first time.
echo:
Windows\make start

cls
echo Downloading a copy of the Open-RSC-Website repository
echo:
Windows\make clone-windows-website
cls
echo Downloading a copy of the Open-RSC-Game repository
echo:
Windows\make clone-windows-game
cls
echo Waiting for 5 seconds to give the MySQL server time to start before importing the databases.
echo:
timeout 5
Windows\make import-windows

cls
echo First time setup is now complete. Visit http://localhost in your browser to verify.
pause