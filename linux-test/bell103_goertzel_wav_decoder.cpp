// ---------------------------------------------------------------------
//
// HydroModem
// Underwater Bell 103 modem implementation for low-power microcontrollers
//
// Copyright (C) 2024-2025 Wayne Piekarski
// wayne@tinmith.net https://waynepiekarski.net/projects/hydro-modem.htm
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
// ---------------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <sndfile.h>
#include <cstring>
#include <string>
#include <vector>
#include <alsa/asoundlib.h>

std::string char2bin (unsigned char in) {
    std::string out;
    for (int b = 7; b >= 0; b--) {
        std::string bb = in & (1<<b) ? "1" : "0";
        out = out + bb;
    }
    return out;
}

unsigned char char2safe (unsigned char in) {
    if (isalnum(in) || in==' ') {
        return in;
    } else {
        return '~';
    }
}

// Find device names with: arecord --list-pcms
snd_pcm_t* open_alsa_microphone(const char* alsa_source_name, int samplerate) {
    int err;
    snd_pcm_t *capture_handle;
    snd_pcm_hw_params_t *hw_params;

    fprintf (stderr, "Opening up ALSA source [%s]\n", alsa_source_name);
    fprintf (stderr, "snd_pcm_open\n");
    if ((err = snd_pcm_open (&capture_handle, alsa_source_name, SND_PCM_STREAM_CAPTURE, 0)) < 0) {
        fprintf (stderr, "cannot open audio device %s (%s)\n", 
                 alsa_source_name,
                 snd_strerror (err));
        exit (1);
    }

    fprintf (stderr, "snd_pcm_hw_params_malloc\n");
    if ((err = snd_pcm_hw_params_malloc (&hw_params)) < 0) {
        fprintf (stderr, "cannot allocate hardware parameter structure (%s)\n",
                 snd_strerror (err));
        exit (1);
    }

    fprintf (stderr, "snd_pcm_hw_params_any\n");
    if ((err = snd_pcm_hw_params_any (capture_handle, hw_params)) < 0) {
        fprintf (stderr, "cannot initialize hardware parameter structure (%s)\n",
                 snd_strerror (err));
        exit (1);
    }

    fprintf (stderr, "snd_pcm_hw_params_set_access\n");
    if ((err = snd_pcm_hw_params_set_access (capture_handle, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED)) < 0) {
        fprintf (stderr, "cannot set access type (%s)\n",
                 snd_strerror (err));
        exit (1);
    }

    fprintf (stderr, "snd_pcm_hw_params_set_format\n");
    if ((err = snd_pcm_hw_params_set_format (capture_handle, hw_params, SND_PCM_FORMAT_S16_LE)) < 0) {
        fprintf (stderr, "cannot set sample format (%s)\n",
                 snd_strerror (err));
        exit (1);
    }

    unsigned int val = samplerate;
    int dir = 0;
    fprintf (stderr, "snd_pcm_hw_params_set_rate_near to %d Hz\n", val);
    if ((err = snd_pcm_hw_params_set_rate_near (capture_handle, hw_params, &val, &dir)) < 0) {
        fprintf (stderr, "cannot set sample rate (%s)\n",
                 snd_strerror (err));
        exit (1);
    }

    // Set mono channels
    fprintf (stderr, "snd_pcm_hw_params_set_channels to mono\n");
    if ((err = snd_pcm_hw_params_set_channels (capture_handle, hw_params, 1)) < 0) {
        fprintf (stderr, "cannot set channel count (%s)\n",
                 snd_strerror (err));
        exit (1);
    }

    fprintf (stderr, "snd_pcm_hw_params\n");
    if ((err = snd_pcm_hw_params (capture_handle, hw_params)) < 0) {
        fprintf (stderr, "cannot set parameters (%s)\n",
                 snd_strerror (err));
        exit (1);
    }
  
    fprintf (stderr, "snd_pcm_hw_params_free\n");
    snd_pcm_hw_params_free (hw_params);

    fprintf (stderr, "snd_pcm_prepare\n");
    if ((err = snd_pcm_prepare (capture_handle)) < 0) {
        fprintf (stderr, "cannot prepare audio interface for use (%s)\n",
                 snd_strerror (err));
        exit (1);
    }

    return capture_handle;
}

std::string decoded;
void emit_goertzel (unsigned char out) {
    // Filter out junk chars from noise due to testing
    if (char2safe(out) == out) {
        decoded.push_back(out);
    }
}

bool current_bit = false;
void emit_bit (bool bit) {
    current_bit = bit;
}

int SAMPLE_RATE = -1;

// Verbose debugging, normally can disable this
#define vprintf_goertzel(...) fprintf(stderr, __VA_ARGS__)
#define printf_goertzel(...) fprintf(stderr, __VA_ARGS__)
#define assert_goertzel(...) assert(__VA_ARGS__)
#include "goertzel_bell103.h"

int main(int _argc, const char *_argv[]) {
    // Process any command-line flags and remove them so they don't mess up the indexes of the required arguments
    int timing_drop = 0;
    bool disable_shift = false;
    std::vector<const char*> argv;
    for (int i = 0; i < _argc; i++) {
        if (strstr(_argv[i], "--timing-drop") == _argv[i]) {
            const char* equal = strchr(_argv[i],'=');
            if (equal != NULL) {
                timing_drop = atoi(equal+1);
                if (timing_drop < 0) {
                    fprintf(stderr, "Timing drop argument [%s] is invalid\n", _argv[i]);
                    exit(1);
                }
                fprintf(stderr, "Timing drop mode enabled with value %d\n", timing_drop);
            } else {
                timing_drop = 1;
                fprintf(stderr, "Timing drop mode enabled with default 1\n");
            }
        } else if (!strcmp(_argv[i], "--disable-shift")) {
            fprintf(stderr, "Disable shift mode\n");
            disable_shift = true;
        } else {
            argv.push_back(_argv[i]);
        }
    }
    int argc = argv.size();

    if (argc != 5) {
        fprintf(stderr, "Usage: %s <input_file.wav> <test_string> <baud> <samplerate> [--timing-drop|--timing-drop=N]\n", argv[0]);
        return 1;
    }

    // https://www.embedded.com/the-goertzel-algorithm/
    // Want the target frequencies to be integer multiples of sample_rate/window_size
    // At 10 baud, this would be 44100/(44100/10) == 10
    // window size = 4410. sample_rate = 44100. therefore sample_rate/N=10.
    // My frequencies are integer multiples and it doesn't work. Going to 12 baud gives some results though.
    // There must be some problem around the window size relative to the frequencies.
    //
    // The frequency resolution of the DFT will be the sample rate divided by the number of samples, or 44100 / 4410 = 10 Hz.
    // This means you can only distinguish frequencies that are at least 10 Hz apart. If your two frequencies
    // (1270 Hz and 1070 Hz) are closer than this, they will appear as a single peak in your DFT.
    SAMPLE_RATE = atoi(argv[4]);
    int baudrate = atoi(argv[3]);
    const int SAMPLES_PER_BAUD = SAMPLE_RATE / baudrate;
    fprintf(stderr, "Baud rate %d, samples per baud %d, sample rate %d\n", baudrate, SAMPLES_PER_BAUD, SAMPLE_RATE);

    SNDFILE *infile;
    SF_INFO sfinfo{};
    sfinfo.format = 0;
    const char* filename = argv[1];
    infile = sf_open(filename, SFM_READ, &sfinfo);
    snd_pcm_t *alsa;
    if (!infile) {
        fprintf(stderr, "Failed to sf_open(%s) with %s\n", filename, sf_strerror(infile));
        alsa = open_alsa_microphone(filename, SAMPLE_RATE);
        if (alsa == NULL) {
            fprintf(stderr, "Error opening file and ALSA source: %s\n", sf_strerror(infile));
            exit(1);
        }
        // We have an ALSA input working here, any other checks on it can happen here
    } else {
        if (sfinfo.samplerate != SAMPLE_RATE) {
            fprintf(stderr, "Unsupported rate %d. Requires %d rate.\n", sfinfo.samplerate, SAMPLE_RATE);
            sf_close(infile);
            return 1;
        }
        if (sfinfo.channels != 1) {
            fprintf(stderr, "Unsupported channels %d. Requires %d channels.\n", sfinfo.channels, 1);
            sf_close(infile);
            return 1;
        }
    }

    // Capture the input to an output file, useful for verifying the ALSA recorded microphone data
    SNDFILE *outfile;
    SF_INFO sfoutinfo{};
    sfoutinfo.channels = 1;
    sfoutinfo.samplerate = SAMPLE_RATE;
    sfoutinfo.format = SF_FORMAT_WAV | SF_FORMAT_PCM_16;
    const char* outfilename = "microphone-bell103-goertzel-recorded.wav";
    outfile = sf_open(outfilename, SFM_WRITE, &sfoutinfo);
    if (!outfile) {
        fprintf(stderr, "Could not record to output file %s\n", outfilename);
        exit(1);
    }
    fprintf (stderr, "Recording audio to %s\n", outfilename);

    // Save decoded data to a CSV file
    FILE *csv = fopen ("bell103-goertzel-decoded.csv", "w");
    if (csv == NULL) {
        fprintf(stderr, "Could not record CSV output file\n");
        exit(1);
    }
    
    std::string expected = argv[2];
    fprintf(stderr, "Expected [%s] = \n", expected.c_str());
    for (char ch: expected) {
        fprintf(stderr, "Expected: 0x%.2X [%c] b%.8s\n", ch, ch, char2bin(ch).c_str());
    }

    fprintf(stderr, "Processing audio source [%s]\n", filename);
    // Buffer elements can be any integer number and is the chunk size we read for efficiency, this is not the Goertzel window size
    // Use large buffer sizes to check that the buffer code handles short reads properly
    // Use small buffer sizes to reduce latency from sounds to seeing the effects
    const int BUFFER_ELEMS = 1000; // 0.25 sec latency at 4000 Hz
    // This is one fraction of a sample window, used to implement the shift_window feature later, must be an integer
    const int FRACTION_SIZE = 10;
    const int SAMPLES_PER_BAUD_FRACTION = SAMPLES_PER_BAUD / FRACTION_SIZE;
    if (SAMPLES_PER_BAUD % FRACTION_SIZE != 0) {
        fprintf(stderr, "SAMPLES_PER_BAUD=%d, FRACTION_SIZE=%d\n", SAMPLES_PER_BAUD, FRACTION_SIZE);
    }
    assert(SAMPLES_PER_BAUD % FRACTION_SIZE == 0); // Make sure the samples per baud divides evenly into ten bits
    short *buffer = (short*) malloc(BUFFER_ELEMS * sizeof(short));
    int readcount;

    init_goertzel();

    while (true) {
        if (infile) {
            readcount = sf_read_short(infile, buffer, BUFFER_ELEMS);
            if (readcount == 0) {
                fprintf (stderr, "Reached EOF on incoming audio stream\n");
                // The previous read was either a complete buffer or a short read, but we didn't reach the
                // window size, so do not process the remaining Goertzel data since there might be just 1 byte
                // or maybe a lot, but it won't be accurate. So do not call process_goertzel() here.
                break;
            }
        } else {
            readcount = snd_pcm_readi (alsa, buffer, BUFFER_ELEMS);
            if (readcount == 0) {
                fprintf (stderr, "Reached EOF reading from audio interface\n");
                break;
            }
        }
        int writecount = sf_write_short(outfile, buffer, readcount);
        if (writecount != readcount) {
            fprintf(stderr, "Failed to write to output file\n");
            exit(1);
        }

        for (int r = 0; r < readcount; r++) {
            // Feed each incoming sample into the Goertzel algorithm, and work out if we have filled up a window
            sample_goertzel(buffer[r]);
            fprintf(csv, "%d,%d,%d\n", sample_offset,current_bit,buffer[r]);
            goertzel_offset++;
            sample_offset++;

            if (goertzel_offset == SAMPLES_PER_BAUD) {
                // We have filled up a window of data, now need to process it
                process_goertzel();
                goertzel_offset = 0;
                // This function takes too long on an atmega328p, so simulate the loss of the next sample
                if (timing_drop) {
                    r += timing_drop;
                    fprintf(stderr, "    Timing drop simulating loss +%d of sample %d %3.1fs from process_goertzel()\n", timing_drop, sample_offset, sample_offset/(float)SAMPLE_RATE);
                }
            } else if ((!disable_shift) && (!reset_is_done) && (waiting_for_start) && (goertzel_offset != 0)) {
                // Due to how the algorithm works, the offset will never exceed a fraction value, so we can just test
                // for equality and not look for a modulus of the fraction size like was previously done.
                assert(goertzel_offset <= SAMPLES_PER_BAUD_FRACTION);
                if (goertzel_offset == SAMPLES_PER_BAUD_FRACTION) {
                // Implement the window shift algorithm based on detecting the transition to a start bit, since we don't
                // have the timing information on when this will happen. If we don't do this shifting, we can end up with
                // the Goertzel window half seeing the mark and half seeing the space and smearing them together and the
                // expected characters don't get decoded. With this enabled we see correct chars decoded in our test cases.
                // It is important we have a series of 10 mark bits before the first space bit to allow this algorithm to
                // sync up properly.
                // If we are at some fraction of the way into the sample, see if we have made a state change from mark to space which would indicate a message start
                        bool mark_space = get_goertzel_mark_space();
                        if (!mark_space) {
                            // We have found the first space, indicating start of message, but do not reset_goertzel()
                            // or we lose a fraction worth of energy that we've already seen, but the reset is done
                            vprintf_goertzel("Found first space at ofs=%d,sample=%d, will continue to use this window energy\n", goertzel_offset, sample_offset);
                            reset_is_done = 1;
                        } else {
                            // Did not see a space, so nuke the energy built up and try again for a fresh space detection
                            vprintf_goertzel("Still waiting for first space at ofs=%d,sample=%d, reset_goertzel to re-align window start\n", goertzel_offset, sample_offset);
                            reset_goertzel();
                            goertzel_offset = 0;
                        }
                        // This function takes too long on an atmega328p, so simulate the loss of the next sample
                        if (timing_drop) {
                            r += timing_drop;
                            fprintf(stderr, "    Timing drop simulating loss +%d of sample %d %3.1f from get_goertzel_mark_space()\n", timing_drop, sample_offset, sample_offset/(float)SAMPLE_RATE);
                        }
                }
            }
        }
    }

    free(buffer);
    if (infile) {
        sf_close(infile);
    } else {
        snd_pcm_close (alsa);
    }
    sf_close(outfile);
    fclose(csv);

    // Print out the decoded string for use in shell scripts
    printf("%.f %.f = [%s]\n", diff_total_log10, diff_total, decoded.c_str());

    if (decoded.size() == 0) {
        fprintf(stderr, "Error: Did not recover any data\n");
        exit(1);
    }
    if (expected != decoded) {
        fprintf(stderr, "Error: Expected does not match decoded\nError: Expected %zu=[%s]\nError: Decoded  %zu=[%s]\n", expected.length(), expected.c_str(), decoded.length(), decoded.c_str());
        size_t i = 0;
        while((i < expected.length()) && (i < decoded.length())) {
            if (expected.at(i) != decoded.at(i)) {
                fprintf(stderr, "Error: Mismatch at 0ofs=%zu 1ofs=%zu, expected [%c] != decoded [%c]\n", i, i+1, expected.at(i), decoded.at(i));
                break;
            }
            i++;
        }
        exit(1);
    }
    
    return 0;
}
