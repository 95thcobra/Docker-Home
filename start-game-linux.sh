#!/bin/bash
sudo make pull

#Compile
sudo Ant/bin/ant -f Game/client/build.xml compile
sudo Ant/bin/ant -f Game/server/build.xml compile

#Client
Ant/bin/ant -f Game/client/build.xml runclient &

#Server
Ant/bin/ant -f Game/server/build.xml runserver
