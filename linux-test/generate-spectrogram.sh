#!/bin/bash

INPUT="$1"
if [[ "${INPUT}" == "" ]]; then
  echo "Need input video/audio file to create spectrogram"
  exit 1
fi

BASENAME="$(basename "${INPUT}")"
BASEDIR="$(dirname "${INPUT}")"

# Generate the output files in the same directory as the input unless it is overridden here
if [[ "$2" != "" ]]; then
    BASEDIR="$2"
fi

OUTPUT="${BASEDIR}/${BASENAME}"
echo "Processing input ${INPUT} to ${OUTPUT}-*"

# fscale=log seems to show musical tones in a way that is easier to understand
# DTMF tones range from 697 Hz to 1633 Hz.
# Bell 103 FSK encoding is mark=1270 Hz,space=1070 Hz and mark=2225 Hz,space=2025 Hz.
# Smoke detectors are typically 3150 Hz.
# showspectrum can specify start and stop frequencies, but stop must be double the maximum you want to see in the graph (2x 3300)
# Need to use -pix_fmt yuv420p for the video to work on Android devices, do not recompress the audio to preserve its input quality
# Only render left channel since right probably has a top-side non-hydrophone with commentary: https://stackoverflow.com/questions/48896621/ffplay-how-to-get-only-single-channel-audio-from-video
# There is also a bug in ffmpeg on Ubuntu 20.04 where any extra channels don't render properly, so throw away the right channel https://trac.ffmpeg.org/ticket/9061
# Debian 12 has a bug in ffmpeg where 1920x1080 just deadlocks the CPU at 100%, the Y size needs to be power of 2 (512, 1024, 2048, etc)
set -eux

ffmpeg -y -f lavfi -i \
       "amovie=${INPUT},asplit=2[out1][waves]; [waves]pan=1c|c0=c0,showspectrumpic=s=1920x1024:win_func=hann:fscale=lin:start=500:stop=6600:legend=true:color=rainbow:scale=log:gain=100[out0]" "${OUTPUT}-spectrogram.png" \
       || exit 1

# Use sox to generate an equivalent spectrogram, convert from video format since sox doesn't always support MP4
ffmpeg -y -i "${INPUT}" -vn -acodec pcm_s16le -ac 1 "${OUTPUT}-spectrogram-sox.wav"
sox "${OUTPUT}-spectrogram-sox.wav" -n spectrogram -x 800 -y 512 -o "${OUTPUT}-spectrogram-sox.png" || exit 1

# If the modem decoder exists in this directory, then run it over the input and extract out any text
FFMPEG_SUBTITLES=""
if [[ -x `dirname $0`/bell103_goertzel_wav_decoder ]]; then
    BPS=10
    SAMPLE_RATE=$(sox --info "${OUTPUT}-spectrogram-sox.wav" | grep "Sample Rate" | awk -F':' '{ print $2 }')
    TEST_STRING=""
    `dirname $0`/bell103_goertzel_wav_decoder "${OUTPUT}-spectrogram-sox.wav" "${TEST_STRING}" "${BPS}" "${SAMPLE_RATE}" "--gen-subtitles=${OUTPUT}-subtitles.srt" 2> /dev/null > "${OUTPUT}-bell103-decoded.txt"
    echo "Modem text at ${BPS} bps, calculated sample rate ${SAMPLE_RATE}, extracted from input ${INPUT}"
    cat "${OUTPUT}-bell103-decoded.txt"
    wc --lines "${OUTPUT}-subtitles.srt"
    cp "${OUTPUT}-subtitles.srt" "${OUTPUT}-spectrogram.srt"
    cp "${OUTPUT}-subtitles.srt" "${OUTPUT}-video-spectrogram.srt"
    FFMPEG_SUBTITLES="-vf subtitles=${OUTPUT}-subtitles.srt:force_style='Fontname=monospace,Fontsize=10,PrimaryColour=&H00FFFFFF,OutlineColour=&H00000000,BorderStyle=1,Outline=2,Shadow=0,Alignment=6,MarginV=0'"
fi

# Generate spectrogram with the video overlaid in a scale (320,*) and origin=(175,0) - this can fail if the input file does not include a video stream, so do not check for errors
if [[ "$(file --dereference ${INPUT} | grep WAVE)" == "" ]]; then
  ffmpeg -y -f lavfi -i \
       "amovie=${INPUT}:s=dv+da[v][a],[a]asplit=2[out1][waves]; [waves]pan=1c|c0=c0,showspectrum=s=1920x1024:fscale=lin:overlap=1:start=500:stop=6600:legend=true:slide=scroll:color=rainbow:scale=log:gain=100[spec]; [v]scale=640:-1[vr]; [spec][vr]overlay=175:0[out0]" \
       -c:a copy \
       -crf 25 -codec:v libx264 -bf 2 -flags +cgop -pix_fmt yuv420p \
       ${FFMPEG_SUBTITLES} \
       "${OUTPUT}-video-spectrogram.mkv"

  # Copy the video stream from the MKV video, but compress the audio with AAC so that it can be a valid MP4 file (MP4 does not support uncompressed WAV, but Messenger will only send MP4 files)
  # Use 320kbps for AAC which supposedly is high enough to not be detectable compression, but no exact citation
  ffmpeg -y -i "${OUTPUT}-video-spectrogram.mkv" -c:v copy -c:a aac -b:a 320k "${OUTPUT}-video-spectrogram.mp4" || exit 1
fi

# Generate just a spectrogram with no video included
# Need to use power of two for the Y-resolution, otherwise this seems to run 100x slower on Debian 12, which is related to the above bug
ffmpeg -y -f lavfi -i \
       "amovie=${INPUT},asplit=2[out1][waves]; [waves]pan=1c|c0=c0,showspectrum=s=512x512:fscale=lin:overlap=1:start=500:stop=6600:legend=true:slide=scroll:color=rainbow:scale=log:gain=100[out0]" \
       -c:a copy \
       -crf 25 -codec:v libx264 -bf 2 -flags +cgop -pix_fmt yuv420p \
       ${FFMPEG_SUBTITLES} \
       "${OUTPUT}-spectrogram.mkv" \
       || exit 1

# Export the last frame of the spectrogram video out to an image, it looks nicer than the equivalent showspectrumpic
ffmpeg -y -sseof -1 -i "${OUTPUT}-spectrogram.mkv" -vframes 1 "${OUTPUT}-spectrogram-lastframe.png" || exit 1

echo "Done"
