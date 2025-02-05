#!/bin/bash

cd $(dirname $0)

OUTWAV="out.wav"
SAMPLE_RATE=$(grep "#define SAMPLE_RATE" modem-const.h | awk '{ print $3 }')
echo "Using SAMPLE_RATE ${SAMPLE_RATE}"

set -xve
timeout 10s make read | grep "^[0-9A-F][0-9A-F][0-9A-F]$" > out.hex
# When using 5.0V, the center is about 512, but background hum from USB power is present
# When using 3.3V, the center is about 337, seems cleaner due to local 3V3 regulator
# DO NOT USE 5V: only 2.3V to 3.6V https://learn.sparkfun.com/tutorials/analog-mems-microphone-breakout---sph8878lr5h-1-hookup-guide
# 337 = 512 * 3.3/5.0
python3 ./ascii_to_wav.py out.hex ${OUTWAV} ${SAMPLE_RATE} 337 64
../../modem/bell103_goertzel_wav_decoder ${OUTWAV} "TEST" 10 ${SAMPLE_RATE}
