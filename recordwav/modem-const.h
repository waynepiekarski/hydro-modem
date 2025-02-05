// ---------------------------------------------------------------------
//
// HydroModem
// Underwater Bell 103 modem implementation for low-power microcontrollers
//
// Copyright (C) 2024-2025 Wayne Piekarski
// wayne@tinmith.net https://waynepiekarski.net
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

// Constants that control the implementation of the modem for all utilities to share

// Detection doesn't work below about 3000 Hz in minimodem, so need to be at least 4000 Hz
// On atmega328p, 2500 or 2600 Hz worked perfectly so use that and we
// get more CPU time per sample (400 usec) without going over budget.
// 2600 is higher than 2x 1270, while 2500 is lower and potentially lower
// than the Nyquist frequency limit. So use 2600 for correctness. Cannot
// use 2540 since it doesn't divide properly into other factors. 2500 also
// fails on minimodem since it is below the Nyquist frequency.
// Oddly, some higher frequencies fail, maybe due to some spectral leakage
// from the tone frequencies in use.
// 2500 Hz: <2540 Hz, works perfectly, within time budget
// 2540 Hz: 2x of 1270 freq, cannot divide SAMPLES_PER_BAUD by 10
// 2600 Hz: > 2x of 1270 freq, works perfectly, within time budget
// 2700 Hz: mostly fails, within time budget (this worked better than 2600 in simulation)
// 3000 Hz: sometimes glitches, within time budget
// 3200 Hz: rare glitches, within time budget
// 3300 Hz: fails, within time budget
// Time budget cutoff:
// 3400 Hz: fails, over time budget
// 3500 Hz: usually glitches, over time budget
// 4000 Hz: usually works, over time budget
// 8000 Hz: fails, over time budget
#define SAMPLE_RATE 2600

// We have been testing with a standard baud rate of 10 bits per second
#define BAUD_RATE 10

// Derive and check other values based on the above constants
#define SAMPLES_PER_BAUD (SAMPLE_RATE/BAUD_RATE)
#define SAMPLES_PER_BAUD_TENTH (SAMPLES_PER_BAUD/10)
static_assert(SAMPLES_PER_BAUD % 10 == 0); // Make sure this divides evenly
static_assert(SAMPLE_RATE % BAUD_RATE == 0);
#define SAMPLE_USEC (1000000/SAMPLE_RATE)
// Do not check for exact division into 1 second since the timing drift will be less than a microsecond
//static_assert(1000000 % SAMPLE_RATE == 0);
