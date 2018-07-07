#!/bin/bash

sudo make stop
sudo make start
sudo make clone
sleep 5
sudo make import
