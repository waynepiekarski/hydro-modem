#!/bin/bash

cd $(dirname $0)

OUTWAV="live.wav"
SAMPLE_RATE=$(grep "#define SAMPLE_RATE" modem-const.h | awk '{ print $3 }')
echo "Using SAMPLE_RATE ${SAMPLE_RATE}"

set -xve

# This is recording some sound and detects very loud taps on a piezo, but no music.
# Currently also fails when connecting music from a phone, oscilloscope shows Vpp=1V so the signal should be strong
make read | grep --text "^[0-9A-F][0-9A-F][0-9A-F]$" | ../../modem/hex_to_wav ${OUTWAV} ${SAMPLE_RATE} 512 256
