@echo off
Windows\make pull
set PATH=Ant/bin
call ant -f Game/client/build.xml compile
call ant -f Game/server/build.xml compile
call START "" ant -f Game/client/build.xml runclient
call ant -f Game/server/build.xml runserver
pause
