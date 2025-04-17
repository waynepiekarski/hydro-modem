#!/bin/bash

cd $(dirname $0)

OUTWAV="out.wav"
SAMPLE_RATE=$(grep "#define SAMPLE_RATE" modem-const.h | awk '{ print $3 }')
echo "Using SAMPLE_RATE ${SAMPLE_RATE}"

set -xve
timeout 10s make read | grep --text "^[0-9A-F][0-9A-F][0-9A-F]$" > out.hex
# 0x1FF-0x200 typically, which is 512 decimal
python3 ./ascii_to_wav.py out.hex ${OUTWAV} ${SAMPLE_RATE} 512 64
../../modem/bell103_goertzel_wav_decoder ${OUTWAV} "TEST" 10 ${SAMPLE_RATE}
