#!/bin/bash

cd $(dirname $0)

OUTWAV="live.wav"
SAMPLE_RATE=$(grep "#define SAMPLE_RATE" modem-const.h | awk '{ print $3 }')
echo "Using SAMPLE_RATE ${SAMPLE_RATE}"

set -xve

# When using 5.0V, the center is about 512, but background hum from USB power is present
# When using 3.3V, the center is about 337, seems cleaner due to local 3V3 regulator
# 337 = 512 * 3.3/5.0
make read | grep "^[0-9A-F][0-9A-F][0-9A-F]$" | ../../modem/hex_to_wav ${OUTWAV} ${SAMPLE_RATE} 337 64
