#!/bin/bash

INPUT="$1"
if [[ "${INPUT}" == "" ]]; then
  echo "Need input video/audio file to create spectrogram"
  exit 1
fi

# fscale=log seems to show musical tones in a way that is easier to understand
# DTMF tones range from 697 Hz to 1633 Hz.
# Bell 103 FSK encoding is mark=1270 Hz,space=1070 Hz and mark=2225 Hz,space=2025 Hz.
# Smoke detectors are typically 3150 Hz.
# showspectrum can specify start and stop frequencies, but stop must be double the maximum you want to see in the graph (2x 3300)
# Need to use -pix_fmt yuv420p for the video to work on Android devices, do not recompress the audio to preserve its input quality
# Only render left channel since right probably has a top-side non-hydrophone with commentary: https://stackoverflow.com/questions/48896621/ffplay-how-to-get-only-single-channel-audio-from-video
# There is also a bug in ffmpeg on Ubuntu 20.04 where any extra channels don't render properly, so throw away the right channel https://trac.ffmpeg.org/ticket/9061
# Debian 12 has a bug in ffmpeg where 1920x1080 just deadlocks the CPU at 100%, the Y size needs to be power of 2 (512, 1024, 2048, etc)
set -xv

ffmpeg -y -f lavfi -i \
       "amovie=${INPUT},asplit=2[out1][waves]; [waves]pan=1c|c0=c0,showspectrumpic=s=1920x1024:fscale=lin:start=500:stop=6600[out0]" "${INPUT}-spectrogram.png" \
       || exit 1

# Generate spectrogram with the video overlaid in a scale (320,*) and origin=(175,0) - this can fail if the input file does not include a video stream, so do not check for errors
if [[ "$(file --dereference ${INPUT} | grep WAVE)" == "" ]]; then
  ffmpeg -y -f lavfi -i \
       "amovie=${INPUT}:s=dv+da[v][a],[a]asplit=2[out1][waves]; [waves]pan=1c|c0=c0,showspectrum=s=1920x1024:fscale=lin:overlap=1:start=500:stop=6600:legend=true:slide=scroll:color=rainbow:scale=log:gain=100[spec]; [v]scale=640:-1[vr]; [spec][vr]overlay=175:0[out0]" \
       -c:a copy \
       -crf 25 -codec:v libx264 -bf 2 -flags +cgop -pix_fmt yuv420p \
       "${INPUT}-video-spectrogram.mkv"
fi

# Copy the video stream from the MKV video, but compress the audio with AAC so that it can be a valid MP4 file (MP4 does not support uncompressed WAV, but Messenger will only send MP4 files)
# Use 320kbps for AAC which supposedly is high enough to not be detectable compression, but no exact citation
if [[ "$(file --dereference ${INPUT} | grep WAVE)" == "" ]]; then
  ffmpeg -y -i "${INPUT}-video-spectrogram.mkv" -c:v copy -c:a aac -b:a 320k "${INPUT}-video-spectrogram.mp4" || exit 1
fi

# Generate just a spectrogram with no video included
# Need to use power of two for the Y-resolution, otherwise this seems to run 100x slower on Debian 12, which is related to the above bug
ffmpeg -y -f lavfi -i \
       "amovie=${INPUT},asplit=2[out1][waves]; [waves]pan=1c|c0=c0,showspectrum=s=1920x1024:fscale=lin:overlap=1:start=500:stop=6600:legend=true:slide=scroll:color=rainbow:scale=log:gain=100[out0]" \
       -c:a copy \
       -crf 25 -codec:v libx264 -bf 2 -flags +cgop -pix_fmt yuv420p \
       "${INPUT}-spectrogram.mkv" \
       || exit 1
