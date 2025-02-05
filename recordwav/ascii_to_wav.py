#!/usr/bin/python3

import wave
import struct
import sys

def ascii_to_wav(input_filename, output_filename, sample_rate=44100, bit_depth=16, shift=512, scale=1):
  """Converts an ASCII file of integers to a WAV file.

  Args:
      input_filename: The path to the input ASCII file.
      output_filename: The path to the output WAV file.
      sample_rate: The sample rate of the audio (default: 44100 Hz).
      bit_depth: The bit depth of the audio (default: 16 bits).
  """
  print(f"Shift={shift}, Scale={scale}")

  with open(input_filename, 'r') as infile, wave.open(output_filename, 'wb') as outfile:
    # Set WAV file parameters
    outfile.setnchannels(1)  # Mono audio
    outfile.setsampwidth(bit_depth // 8) 
    outfile.setframerate(sample_rate)

    for line in infile:
      try:
        rawvalue = int(line.strip(), 16)

        # Convert the Arduino 0..1023 to -512..+512
        value = rawvalue - shift
        value = value * scale
        # Clamp the values if they go out of bounds, otherwise struct.pack fails
        if value < -32767:
          value = -32767
        if value > 32767:
          value = 32767
        # print(f"In={rawvalue}, Out={value}")

        # Pack the value into the appropriate format
        packed_value = struct.pack('<h', value)  # Assuming signed 16-bit integers

        outfile.writeframes(packed_value)
      except ValueError:
        print(f"Skipping invalid line: {line}")

if __name__ == "__main__":
  if len(sys.argv) < 4:
    print("Usage: python script_name.py input_file.txt output_file.wav samplerate")
    sys.exit(1)

  input_file = sys.argv[1]
  output_file = sys.argv[2]
  sample_rate = int(sys.argv[3])
  if len(sys.argv) >= 5:
    shift = int(sys.argv[4]);
  else:
    shift = 512;
  if len(sys.argv) >= 6:
    scale = int(sys.argv[5])
  else:
    scale = 1;
  ascii_to_wav(input_file, output_file, sample_rate, 16, shift, scale)
