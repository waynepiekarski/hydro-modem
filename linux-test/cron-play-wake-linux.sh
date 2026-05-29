#!/bin/bash

# Script to run at boot, run this from crontab as a normal user using the @reboot tag
cd `dirname $0`
./play-wake-linux.sh &>> cron-play-wake-linux.log &
