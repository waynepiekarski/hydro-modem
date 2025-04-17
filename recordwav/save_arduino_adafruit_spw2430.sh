#!/bin/bash

cd $(dirname $0)

OUTWAV="out.wav"
SAMPLE_RATE=$(grep "#define SAMPLE_RATE" modem-const.h | awk '{ print $3 }')
echo "Using SAMPLE_RATE ${SAMPLE_RATE}"

set -xve

# Adafruit SPW2430 has a 0.67V DC bias, so 0.67*255=171
# When talking swings 100 mVpp, so from 0.66-0.68 V
# Could potentially be 1Vpp for a loud sound, so from 0..1.76V?
# Needs massive gain of 2048 to hear anything and is very noisy

SAMPLE_RATE=4000
timeout 10s make read | grep --text "^[0-9A-F][0-9A-F][0-9A-F]$" > out.hex
python3 ./ascii_to_wav.py out.hex ${OUTWAV} ${SAMPLE_RATE} 171 2048
../../modem/bell103_goertzel_wav_decoder ${OUTWAV} "TEST" 10 ${SAMPLE_RATE}
