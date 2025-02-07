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

#include <Arduino.h>

#ifdef __AVR__
// Verify this is running on an Arduino Uno, which is 16 MHz and not 8 Mhz
#if (F_CPU == 16000000)
#else
#error F_CPU is not configured for 16 MHz mode, this project is for Arduino Uno and should be run with: make arduino-uno-upload
#endif // F_CPU
#include <avr/interrupt.h>
#endif // __AVR__

#ifdef __AVR__
// Attach MAX4466 microphone to analog pin 0 to read audio from the ADC
#define ANALOG_PIN PIN_A0
// Attach oscilloscope to digital pin 7 to see pulse at the start and end of interrupt handler
#define SCOPE_PIN  7
#endif // __AVR__

#include "modem-const.h"

void setup() {
    Serial.begin(MAKEFILE_BAUD);
    pinMode(SCOPE_PIN, OUTPUT);
    digitalWrite(SCOPE_PIN, 0);
    Serial.print("SAMPLE_RATE=");
    Serial.println(SAMPLE_RATE);
}

void sample() {
    // Samples range from 0-1023 but should be adjusted to -512..+512 later on
    uint16_t raw_sample = analogRead(ANALOG_PIN);

#undef GRAPHICAL_DEBUG
#ifdef GRAPHICAL_DEBUG
#warning Graphical debugging enabled
    // Values range from 0-1023 so graph them to fit in 64 columns
    if (raw_sample < 10) Serial.write(' ');
    if (raw_sample < 100) Serial.write(' ');
    if (raw_sample < 1000) Serial.write(' ');
    Serial.print(raw_sample);
    int16_t col = raw_sample / 16;
    for (int i = 0; i < col; i++) {
        Serial.write(' ');
    }
    Serial.write('*');
    Serial.write('\n');
    return;
#endif // GRAPHICAL_DEBUG

    // At  115200 baud, one bit = 8.7 usec, 1 byte = ~87 usec (4 KHz = 250 usec)
    // At  500000 baud, one bit = 2.0 usec, 1 byte = ~20 usec
    // At 1000000 baud, one bit = 1.0 usec, 1 byte = ~10 usec
    // Do not use Serial.print() which supports special formatting, it cannot print the uint16_t in time
    static const char hexDigits[] = "0123456789ABCDEF";
    Serial.write(hexDigits[(raw_sample >> 8) & 0x0F]);
    Serial.write(hexDigits[(raw_sample >> 4) & 0x0F]);
    Serial.write(hexDigits[(raw_sample)      & 0x0F]);
    Serial.write('\n');
}

unsigned long last_usec = 0;

void loop() {
    // Implement the sample rate by checking the timer
    unsigned long now_usec = micros();
    unsigned long diff_usec = now_usec - last_usec;
    if (diff_usec >= SAMPLE_USEC) {
        digitalWrite(SCOPE_PIN, 1);
        sample();
        digitalWrite(SCOPE_PIN, 0);
        unsigned long used_usec = micros()-now_usec;
        if (used_usec > SAMPLE_USEC) {
            Serial.print("TIMEOUT ");
            Serial.println(used_usec);
        }
        last_usec = now_usec;
    }
}
