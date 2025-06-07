#!/bin/bash

set -xve

# Debian requires dialout to access /dev/ttyUSB* devices
sudo usermod -a -G dialout $USER
