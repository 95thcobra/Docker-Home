@echo off
echo:
Windows\make pull
echo:
echo:
set PATH=Ant/bin
echo:
echo:
call ant -f Game/client/build.xml compile
echo:
echo:
call ant -f Game/server/build.xml compile
echo:
echo:
call START "" ant -f Game/client/build.xml runclient
echo:
echo:
call ant -f Game/server/build.xml runserver
echo:
pause
