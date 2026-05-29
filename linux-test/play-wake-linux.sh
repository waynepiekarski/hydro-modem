#!/bin/bash

TEMP="temp-play-wake-linux.wav"
DEVICE="plughw:CARD=Device,DEV=0"

echo "`date`: Starting $0"

# 10x tilde ~ is about 1 second of silence to break up the message
./bell103_goertzel_wav_encoder ${TEMP} "~~~~~~~~~~WAKE~~~~~~~~~~" 10 44100

# Repeat the audio forever
while [ 1 ]; do
    sox ${TEMP} -t alsa "${DEVICE}" repeat -

    # sox can fail during early boot if ALSA is not ready
    echo "`date`: sox playback failed, restarting after 1 second"
    sleep 1s
done
