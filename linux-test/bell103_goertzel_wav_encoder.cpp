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
#include <alsa/asoundlib.h>

std::string char2bin (unsigned char in) {
    std::string out;
    for (int b = 7; b >= 0; b--) {
        std::string bb = in & (1<<b) ? "1" : "0";
        out = out + bb;
    }
    return out;
}

int SAMPLE_RATE = -1;
int MAXIMUM_VOLUME = 32767; // Maximum volume of a 16-bit PCM file
int OFFSET_DC = 0;
// Include Goertzel implementation to get the frequency constants
#define assert_goertzel(...)
#define printf_goertzel(...)
void emit_goertzel(unsigned char) { }
void emit_bit(bool) { }
#include "goertzel_bell103.h"

void fill_buffer_tone (short* buffer, int samples, uint16_t freq, int sample_rate) {
    int amplitude = MAXIMUM_VOLUME;
    for (int i = 0; i < samples; ++i) {
        double time = static_cast<double>(i) / sample_rate;
        int result = amplitude * sin(2.0 * M_PI * freq * time) + OFFSET_DC;
        if ((result < -32767) || (result > 32767)) {
            fprintf(stderr, "Amplitude %d is out of +/- 32767 range with maximum %d and DC offset %d\n", result, MAXIMUM_VOLUME, OFFSET_DC);
            exit(1);
        }
        buffer[i] = result;
    }
}

void write_buffer_tone (SNDFILE* fp, short* buffer, int samples, uint16_t freq, int sample_rate) {
    fill_buffer_tone (buffer, samples, freq, sample_rate);
    int writecount = sf_write_short(fp, buffer, samples);
    if (writecount != samples) {
        fprintf(stderr, "Failed to write expected samples to output file\n");
        exit(1);
    }
}

int main(int argc, char *argv[]) {
    if ((argc < 5) || (argc > 10)) {
        fprintf(stderr, "Usage: %s <output_file.wav> <test_string> <baud> <samplerate> <start_padding> <end_padding> <shift> <max_volume> <dcofs>\n", argv[0]);
        return 1;
    }

    int start_padding = 1; // Always require at least 1 extra start padding bit for minimodem to decode
    int end_padding = 0;
    int shift_padding_pct = 0; // Shift all the output so it does not align on the expected boundary, find sync bugs
    int shift_padding = 0;
    if (argc >= 6) {
        start_padding = atoi(argv[5]);
    }
    if (argc >= 7) {
        end_padding   = atoi(argv[6]);
    }
    if (argc >= 8) {
        shift_padding_pct = atoi(argv[7]);
    }
    if (argc >= 9) {
        MAXIMUM_VOLUME = atoi(argv[8]);
    }
    if (argc >= 10) {
        OFFSET_DC = atoi(argv[9]);
    }

    SAMPLE_RATE = atoi(argv[4]);
    int baudrate = atoi(argv[3]);
    int SAMPLES_PER_BAUD = SAMPLE_RATE / baudrate;
    fprintf(stderr, "Baud rate %d, samples per baud %d, sample rate %d\n", baudrate, SAMPLES_PER_BAUD, SAMPLE_RATE);
    shift_padding = shift_padding_pct * SAMPLES_PER_BAUD / 100;
    fprintf(stderr, "Start padding %d baud, end padding %d baud, shift padding %d%% of %d = %d\n", start_padding, end_padding, shift_padding_pct, SAMPLES_PER_BAUD, shift_padding);
    fprintf(stderr, "Maximum volume is %d, DC offset is %d\n", MAXIMUM_VOLUME, OFFSET_DC);
    if (shift_padding < 0) {
        fprintf(stderr, "Cannot shift negative %d\n", shift_padding);
        exit(1);
    }
    if ((MAXIMUM_VOLUME < 1) || (MAXIMUM_VOLUME > 32767)) {
        fprintf(stderr, "Invalid maximum volume %d\n", MAXIMUM_VOLUME);
        exit(1);
    }

    const char* outfilename = argv[1];
    SF_INFO sfoutinfo{};
    sfoutinfo.channels = 1;
    sfoutinfo.samplerate = SAMPLE_RATE;
    sfoutinfo.format = SF_FORMAT_WAV | SF_FORMAT_PCM_16;
    SNDFILE* outfile = sf_open(outfilename, SFM_WRITE, &sfoutinfo);
    if (!outfile) {
        fprintf(stderr, "Could not record to output file %s\n", outfilename);
        exit(1);
    }
    fprintf (stderr, "Writing encoded audio to %s\n", outfilename);

    std::string expected = argv[2];
    fprintf(stderr, "Expected [%s] = \n", expected.c_str());
    for (char ch: expected) {
        fprintf(stderr, "Expected: 0x%.2X [%c] b%.8s\n", ch, ch, char2bin(ch).c_str());
    }

    // Write blank padding to shift everything, this will find bugs in the Goertzel decoder
    // that currently work when the samples nicely align to the window size
    {
        short *ofsbuf = (short*) malloc(shift_padding * sizeof(short));
        write_buffer_tone(outfile, ofsbuf, shift_padding, 0, SAMPLE_RATE);
        free(ofsbuf);
    }

    short *buffer = (short*) malloc(SAMPLES_PER_BAUD * sizeof(short));
    int readcount;

    // Loop through each char, and each of those becomes one bit which is one baud
    for (size_t i = 0; i < expected.size(); i++) {
        fprintf (stderr, "Starting [%c] char #%zu\n", expected[i], i);

        // Handle special chars that are used to debug alternative tones
        if (expected[i] == '&') {
            fprintf (stderr, "Writing [%c] alternative tone at 1500 Hz\n", expected[i]);
            write_buffer_tone(outfile, buffer, SAMPLES_PER_BAUD, 1500, SAMPLE_RATE);
            continue;
        } else if (expected[i] == '~') {
            fprintf (stderr, "Writing [%c] silence tone at 0 Hz\n", expected[i]);
            write_buffer_tone(outfile, buffer, SAMPLES_PER_BAUD, 0, SAMPLE_RATE);
            continue;
        } else if (expected[i] == '@') {
            fprintf (stderr, "Writing [%c] mark padding tone at %d Hz\n", expected[i], MARK_FREQ);
            write_buffer_tone(outfile, buffer, SAMPLES_PER_BAUD, MARK_FREQ, SAMPLE_RATE);
            continue;
        } else if (expected[i] == '^') {
            fprintf (stderr, "Writing [%c] space breaking tone at %d Hz\n", expected[i], SPACE_FREQ);
            write_buffer_tone(outfile, buffer, SAMPLES_PER_BAUD, SPACE_FREQ, SAMPLE_RATE);
            continue;
        }

        // Extra intro bits that do nothing
        for (int s = 0; s < start_padding; s++) {
            fprintf (stderr, "Writing [%c] optional intro padding %d mark=1 bit freq=%d\n", expected[i], s, MARK_FREQ);
            write_buffer_tone(outfile, buffer, SAMPLES_PER_BAUD, MARK_FREQ, SAMPLE_RATE);
        }

        // Start bit
        fprintf (stderr, "Writing [%c] start bit space=0 freq=%d\n", expected[i], SPACE_FREQ);
        write_buffer_tone(outfile, buffer, SAMPLES_PER_BAUD, SPACE_FREQ, SAMPLE_RATE);

        // Each bit in the char
        for (int bn = 0; bn < 8; bn++) {
            bool b = expected[i] & (1 << bn);
            fprintf(stderr, "Writing [%c]@%d: b=%d, freq=%d\n", expected[i], bn, b, b ? MARK_FREQ : SPACE_FREQ);
            write_buffer_tone(outfile, buffer, SAMPLES_PER_BAUD, b ? MARK_FREQ : SPACE_FREQ, SAMPLE_RATE);
        }

        // Stop bit
        fprintf (stderr, "Writing [%c] stop bit mark=1 freq=%d\n", expected[i], MARK_FREQ);
        write_buffer_tone(outfile, buffer, SAMPLES_PER_BAUD, MARK_FREQ, SAMPLE_RATE);

        // Extra stop bits that are not needed but can make the output easier to understand
        for (int s = 0; s < end_padding; s++) {
            fprintf (stderr, "Writing [%c] optional ending padding %d stop bit mark=1 freq=%d\n", expected[i], s, MARK_FREQ);
            write_buffer_tone(outfile, buffer, SAMPLES_PER_BAUD, MARK_FREQ, SAMPLE_RATE);
        }
    }

    // Fill up to the sample size of blank padding at the end of the file too, this makes sure the decoder
    // sees a complete file without missing bytes at the end.
    int ending_padding = SAMPLES_PER_BAUD-(shift_padding%SAMPLES_PER_BAUD);
    if ((ending_padding > 0) && (ending_padding != SAMPLES_PER_BAUD)) {
        fprintf(stderr, "Adding ending padding of %d bytes to align the file ending\n", ending_padding);
        short *ofsbuf = (short*) malloc(ending_padding * sizeof(short));
        write_buffer_tone(outfile, ofsbuf, ending_padding, 0, SAMPLE_RATE);
        free(ofsbuf);
    }

    free(buffer);
    sf_close(outfile);

    // Print out the decoded string for use in shell scripts
    printf("%s\n", expected.c_str());
    
    return 0;
}
