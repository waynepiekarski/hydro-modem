#!/bin/bash

# Check for decoder flags and remove them from the args
DECODER_ARGS=""
i=1
while [[ $i -le $# ]]; do
    if [[ "${!i}" == --timing-drop* ]]; then
        DECODER_ARGS="$DECODER_ARGS ${!i}"
        shift
    elif [[ "${!i}" == "--disable-shift" ]]; then
        DECODER_ARGS="$DECODER_ARGS ${!i}"
        shift
    else
        ((i++))
    fi
done

# Sample rate to use
if [[ "$1" == "" ]]; then
    SAMPLERATE="44100"
else
    SAMPLERATE="$1"
fi

trap 'rc=$?; echo "Error code $rc at $LINENO in $0"; exit $rc' ERR

cd $(dirname $0)
mkdir -p .temp
TEST=".temp/test-decoder"
set -euvx

# Approximately 1 ascii character per second to make is easy to measure in audio tools
# 10.6 is a close value but not exact
# 10 divides evenly into 44100 so use that instead, 300 is too fast and hard to understand
BPS=10

# Minimodem changes the frequencies depending on the baud rate.
# Bell 103 is 300 baud with mark=1270 space=1070
# Lower baud rates match other standards and will not be the same frequency, so hardcode it if we want to test with our own decoder
FREQ="--mark 1270 --space 1070"

# Use very low bps to make it easy to hear and observe spectrograms no matter what the sample size is

# Uppercase U is 0x55 which is b1010101
# Number 3 is 0x33 which is b00110011
# Uppercase X is 0x58
# Test we can decode the minimodem output using my own decoder
for phrase in "12345" "ABCXYZ" "U" "3" "X"; do
    echo -n "${phrase}" | minimodem --ascii --tx ${BPS} ${FREQ} --file "${TEST}-${SAMPLERATE}-${phrase}-1cps.wav" --samplerate ${SAMPLERATE}
    soxi -D ${TEST}-${SAMPLERATE}-${phrase}-1cps.wav
    minimodem --rx ${BPS} ${FREQ} --file "${TEST}-${SAMPLERATE}-${phrase}-1cps.wav" --samplerate ${SAMPLERATE} --ascii | grep "${phrase}"
    ./bell103_goertzel_wav_decoder ${DECODER_ARGS} "${TEST}-${SAMPLERATE}-${phrase}-1cps.wav" "${phrase}" ${BPS} ${SAMPLERATE}
done

# Create an audio sample with a leading mark padding tone to ensure it is strong enough to sync up with background noise
./bell103_goertzel_wav_encoder "${TEST}-${SAMPLERATE}-numbers-1cps.wav" "@@@@@@@@@@12345" ${BPS} ${SAMPLERATE}

# Reduce volume and add 4 seconds of padding to the Bell 103 audio so we can have some noise at the start
sox -R -v 0.025 "${TEST}-${SAMPLERATE}-numbers-1cps.wav" "${TEST}-${SAMPLERATE}-numbers-1cps-padded.wav" pad 4 0

# What is the worst volume level we can recover the Bell 103 data with minimodem?
sox -R -v 0.004 "${TEST}-${SAMPLERATE}-numbers-1cps.wav" "${TEST}-${SAMPLERATE}-numbers-1cps-paddedlow.wav" pad 4 0
minimodem --rx ${BPS} ${FREQ} --file "${TEST}-${SAMPLERATE}-numbers-1cps-paddedlow.wav" --samplerate ${SAMPLERATE} --ascii | grep "12345"

# Render as spectrograms for inspection
if [[ ! -f "${TEST}-${SAMPLERATE}-numbers-1cps.wav-spectrogram.mkv" ]]; then
    ./generate-spectrogram.sh "${TEST}-${SAMPLERATE}-numbers-1cps.wav"
fi

# Test the lowest volume level and with noise that works with my own decoder
sox -R -v 0.006 "${TEST}-${SAMPLERATE}-numbers-1cps.wav" "${TEST}-${SAMPLERATE}-numbers-1cps-paddedlow.wav" pad 4 0

# Decode just the low volume level audio, check that the signal is valid
./bell103_goertzel_wav_decoder ${DECODER_ARGS} "${TEST}-${SAMPLERATE}-numbers-1cps-paddedlow.wav" "12345" ${BPS} ${SAMPLERATE} > "${TEST}-${SAMPLERATE}-numbers-1cps-paddedlow.decoded" || ( echo "Skipping error detection: Extra chars can be around 12345" )
grep "12345" "${TEST}-${SAMPLERATE}-numbers-1cps-paddedlow.decoded" || ( echo "Error! Did not find search string in decoded output from low volume sample"; exit 1 )

echo "Completed all decoder tests!"
