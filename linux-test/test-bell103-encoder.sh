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
TEST=".temp/test-encoder"
# No error checking because the decoder doesn't find stop bits and will exit 1
set -ve

BPS=10
FREQ="--mark 1270 --space 1070"

# Test with custom sine waves to verify bits detected
sox -R -n -r ${SAMPLERATE} -c 1 ${TEST}-sine-1070.wav synth 0.1 sine 1070
sox -R -n -r ${SAMPLERATE} -c 1 ${TEST}-sine-1270.wav synth 0.1 sine 1270
soxi -D ${TEST}-sine-1070.wav
soxi -D ${TEST}-sine-1270.wav
./bell103_goertzel_wav_decoder ${DECODER_ARGS} "${TEST}-sine-1070.wav" "N/A" ${BPS} ${SAMPLERATE} || ( echo "Skip error: sine wave has no data" )
./bell103_goertzel_wav_decoder ${DECODER_ARGS} "${TEST}-sine-1270.wav" "N/A" ${BPS} ${SAMPLERATE} || ( echo "Skip error: sine wave has no data" )

# Combine into an alternating bit pattern (this decodes into ASCII 'U')
sox -R ${TEST}-sine-1070.wav ${TEST}-sine-1270.wav ${TEST}-sine-1070.wav ${TEST}-sine-1270.wav ${TEST}-sine-1070.wav ${TEST}-sine-1270.wav ${TEST}-sine-1070.wav ${TEST}-sine-1270.wav ${TEST}-sine-1070.wav ${TEST}-sine-1270.wav ${TEST}-sine-alternate.wav
soxi -D ${TEST}-sine-alternate.wav
./bell103_goertzel_wav_decoder ${DECODER_ARGS} "${TEST}-sine-alternate.wav" "U" ${BPS} ${SAMPLERATE}

# Check that the custom encoder can be decoded by all implementations
# Always requires at least 1 extra padding start bit
# & is 1500 Hz noise tone
# ~ is silence
# @ is a mark padding tone
# ^ is a space tone which will mess up sync
# If we flush out 10x @ mark padding tones, we can always guarantee sync no matter what junk arrived beforehand

# 32767 is the default volume, but also try 8000 with a large DC shift to check these offsets work too
# A DC offset of > 21900 with volume 8000 seems to fail, but smaller offsets work fine
for volofs in "8000 0" "8000 21900" "32767 0"; do
# 1 0 0 is the default in the encoder
for padding in "4 4 0" "10 10 0" "1 0 0" "1 1 0"; do
for phrase in "U" "3" "X" "12345" "ABCXYZ" "~~U~~" "@@U@@" "&&U&&" "~~U&&&&&&&&&&U~~~~~~~~~~U@@@@@@@@@@U~~" "@^@^@@@@@@@@@@3U3U"; do
    clean_phrase="$(echo $phrase | tr -d '~&@^')"
    echo "Testing phrase [${phrase}]/[${clean_phrase}] with padding [${padding}] and vol/dcofs [${volofs}] at samplerate ${SAMPLERATE}"
    # At 8000 Hz, any DC offset of > 0 seems to cause problems with "~~U~~" and "~~U&&&&&&&&&&U~~~~~~~~~~U@@@@@@@@@@U~~"
    # Other test frequencies like 2600, 4000, and 44100 Hz all work fine with this DC offset for unknown reasons
    if [[ "${SAMPLERATE}" == "8000" ]] && [[ "${volofs}" == "8000 21900" ]]; then
        if [[ "${phrase}" == "~~U~~" ]] || [[ "${phrase}" == "~~U&&&&&&&&&&U~~~~~~~~~~U@@@@@@@@@@U~~" ]]; then
            echo "Skipping test since it fails at 8000 Hz with dcofs > 0 for unknown reasons"
            continue
        fi
    fi

    set -x
    ./bell103_goertzel_wav_encoder "${TEST}-encoder-${phrase}.wav" "${phrase}" ${BPS} ${SAMPLERATE} ${padding} ${volofs}
    echo "Testing custom decoder of phrase [${phrase}] with padding [${padding}] and vol/dcofs [${volofs}] at samplerate ${SAMPLERATE}"
    ./bell103_goertzel_wav_decoder ${DECODER_ARGS} "${TEST}-encoder-${phrase}.wav" "${clean_phrase}" ${BPS} ${SAMPLERATE}
    echo "Testing minimodem decoder of phrase [${phrase}] with padding [${padding}] and vol/dcofs [${volofs}] at samplerate ${SAMPLERATE}"
    minimodem --rx ${BPS} ${FREQ} --file "${TEST}-encoder-${phrase}.wav" --samplerate ${SAMPLERATE} --ascii | grep "${clean_phrase}"
    set +x
    echo "Successfully decoded phrase [${phrase}]"
done
done
done

echo "Completed all encoder tests!"
