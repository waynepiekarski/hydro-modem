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
#define PIN_STATUS_LED 13 // PB5, SCK, standard Arduino Uno LED, physical 17)
static_assert(PIN_STATUS_LED == LED_BUILTIN);

// Attach piezo microphone to analog pin 0 to read audio from the ADC (pin 14 = A0 = PC0 = physical 23)
#define ANALOG_PIN A0
static_assert(ANALOG_PIN == 14);
// Attach oscilloscope to digital pin 7 to see pulse at the start and end of interrupt handler (digital pin 7 = PD7 = physical 11)
#define SCOPE_PIN  7
// Second oscilloscope pin which toggles if a sample has taken too long (digital pin 6 = PD6 = physical 10)
#define ERROR_PIN  6
// Manual trigger of the release mechanism, short pin to ground (pin 16 = A2 = PC2 = physical 25)
#define PIN_TRIGGER A2
static_assert(PIN_TRIGGER == 16);
// MOSFET release (pin 15 = A1 = PC1 = physical 24)
#define PIN_MOSFET 15
static_assert(PIN_TRIGGER != PIN_MOSFET);
static_assert(PIN_TRIGGER != ANALOG_PIN);
static_assert(PIN_MOSFET != ANALOG_PIN);
// Milliseconds the user must short the manual trigger wires before release
#define MANUAL_TRIGGER_MSEC 3000
// Milliseconds to activate the MOSFET for the release burn
#define WAKE_ACTIVE_MSEC 1000
#endif // __AVR__

#ifdef ARDUINO_ARCH_ESP32
#define ANALOG_PIN 0
#define SCOPE_PIN 7
#define ERROR_PIN 6
#endif // __ARDUINO_ARCH_ESP32

#ifndef MAKEFILE_BAUD
#define MAKEFILE_BAUD 500000
#endif // MAKEFILE_BAUD

#include "modem-const.h"

char wake_word[] = "WAKE";

// Only enable one of these at a time, cannot measure time in interrupt handlers
// #define BENCHMARKING

// Interrupt handler or loop timing can be used
// #define INTERRUPT_HANDLER

#ifdef BENCHMARKING
#ifdef INTERRUPT_HANDLER
#error Cannot perform benchmarking within an interrupt handler
#endif
#endif


#ifdef __AVR__
// On atmega328p, double and float are the same, so there is no performance
// improvement from float compared to double.
static_assert(sizeof(double) == sizeof(float));
#endif // __AVR__

inline void emit_bit(bool) {
    // Only used on Linux for debugging
}

char *wake_ptr = wake_word;

void trigger_mosfet (void) {
    Serial.println("MOSFET ON-WAIT");
    digitalWrite(PIN_MOSFET, HIGH);
    delay(WAKE_ACTIVE_MSEC);
    Serial.println("MOSFET OFF");
    digitalWrite(PIN_MOSFET, LOW);
}

void emit_goertzel(char out) {
    (void)(out); // Tell compiler it is ok to be unused

    // Must be a cheap operation since it is called from process_goertzel in the timing loop
    // Disable this when we measure performance on the oscilloscope
    // At  115200 baud, one bit = 8.7 usec, 1 byte = ~87 usec (4 KHz = 250 usec)
    // At  500000 baud, one bit = 2.0 usec, 1 byte = ~20 usec
    // At 1000000 baud, one bit = 1.0 usec, 1 byte = ~10 usec

    // Filter out garbage decoded values to not corrupt the terminal
    if ((out >= ' ') && (out <= '~')) {
        Serial.print(out);
    } else {
        Serial.print('?');
    }

    // Implement optional wake word detector
    if (out == *wake_ptr) {
        // Match, go to the next
        wake_ptr++;
    } else {
        // No match, so reset to the start
        wake_ptr = wake_word;
    }
    // Does the wake word match yet?
    if (*wake_ptr == '\0') {
        Serial.println ("");
        Serial.println ("Wake word detected");
        trigger_mosfet();
        wake_ptr = wake_word;
    }

    // Invert the LED to show a char was processed
    // Done in a loop to burn spare CPU time and look to see how much remains
    // Do this an odd number of times otherwise you won't observe the LED change
    // Currently this can be set to 8 without triggering a timeout
    for (uint8_t i = 0; i < 7; i++) {
        bool value = digitalRead(LED_BUILTIN);
        digitalWrite(LED_BUILTIN, !value);
    }

    // Implement the manual release detection
    
    // Wires open is 1, shorted/conducting is 0
    bool trigger_current = !digitalRead(PIN_TRIGGER);
    static unsigned long last_trigger_time = 0;
    static unsigned long last_trigger_current = 0;
    static bool trigger_state = false;
    // Initialize static variables
    if (last_trigger_time == 0) {
        last_trigger_time = millis();
        last_trigger_current = trigger_current;
        trigger_state = false;
    }

    if (last_trigger_current != trigger_current) {
        // Trigger changed state, so restart the clock
        last_trigger_time = millis();
        last_trigger_current = trigger_current;
        if (trigger_current) {
            // Serial.println("Trigger pin change to pressed");
        } else {
            // Serial.println("Trigger pin change to released");
        }
    } else {
        // Trigger is the same state, so lets wait to see if the press is long enough
        if ((millis() - last_trigger_time) > MANUAL_TRIGGER_MSEC) {
            // Serial.println(millis());
            if (trigger_current) {
                if (trigger_state == false) {
                    Serial.println("Manual trigger detected");
                    trigger_mosfet();
                    // Prevent trigger happening again until it is released
                    trigger_state = true;
                } else {
                    // Serial.println("Manual trigger ignored until release state change");
                }
            } else {
                if (trigger_state == true) {
                    // Serial.println("Release trigger, state changed");
                    trigger_state = false;
                } else {
                    // Serial.println("Ignoring existing trigger release");
                }
            }
            last_trigger_time = millis();
        }
    }

}

// Ignore debug printing
#define printf_goertzel(...)
#define assert_goertzel(...)
#include "goertzel_bell103.h"

void setup() {
    Serial.begin(MAKEFILE_BAUD);
    init_goertzel();

    pinMode(SCOPE_PIN, OUTPUT);
    pinMode(ERROR_PIN, OUTPUT);
    digitalWrite(SCOPE_PIN, 0);
    digitalWrite(ERROR_PIN, 0);
    pinMode(LED_BUILTIN, OUTPUT);
    digitalWrite(LED_BUILTIN, HIGH);

#ifdef INTERRUPT_HANDLER
    // Calculate OCR1A value for Timer1 (16-bit)
    // Timer1 is a higher resolution (16-bit) compared to Timer0
#define OCR1A_VALUE (F_CPU / SAMPLE_RATE / 8) - 1

    // Disable interrupts globally
    cli();

    // Set Timer1 to CTC mode (Clear Timer on Compare Match)
    TCCR1B |= (1 << WGM12);

    // Set prescaler to 8
    TCCR1B |= (1 << CS11);

    // Set the compare match value
    OCR1A = OCR1A_VALUE;

    // Enable Timer1 Compare Match A interrupt
    TIMSK1 |= (1 << OCIE1A);

    // Enable interrupts globally
    sei();
    Serial.println("INTERRUPT INIT");
#else
    Serial.println("LOOP INIT");
#endif // INTERRUPT_HANDLER
    Serial.println("MODEM INIT");
    Serial.print("SAMPLE_RATE=");
    Serial.println(SAMPLE_RATE);
    Serial.print("BAUD_RATE=");
    Serial.println(BAUD_RATE);
    Serial.print("SAMPLE_USEC=");
    Serial.println(SAMPLE_USEC);
    Serial.print("SAMPLES_PER_BAUD=");
    Serial.println(SAMPLES_PER_BAUD);
    Serial.print("WAKE_WORD=");
    Serial.println(wake_word);
}

void sample() {
#ifdef BENCHMARKING
    // micros() seems to have a resolution of 0 or 4 usec when tested
    unsigned long start_us = micros();
#endif // BENCHMARKING

    // Process this sample from 0-1023 and make it so it is from -512..+512
    int16_t raw_sample = analogRead(ANALOG_PIN);
    int16_t sample = raw_sample - 512;
    sample_goertzel(sample);
    goertzel_offset++;
    sample_offset++;

#undef GRAPHICAL_DEBUG
#ifdef GRAPHICAL_DEBUG
#warning Graphical debugging enabled
    // Debug out the microphone values
    // Serial.println(sample);

    // Values range from 0-1023 so graph them to fit in 64 columns
    if (raw_sample < 10) Serial.print(' ');
    if (raw_sample < 100) Serial.print(' ');
    if (raw_sample < 1000) Serial.print(' ');
    Serial.print(raw_sample);
    int16_t col = raw_sample / 16;
    for (int i = 0; i < col; i++) {
        Serial.print(" ");
    }
    Serial.println("*");
    return;
#endif // GRAPHICAL_DEBUG

    bool done_window = (goertzel_offset == SAMPLES_PER_BAUD);
    bool done_tenth = ((!reset_is_done) && (waiting_for_start) && (goertzel_offset == SAMPLES_PER_BAUD_TENTH));

    // Read more data until we have enough to calculate frequencies using Goetzel
    // This will make most samples cheap to process, and the Goetzel step more expensive
    if (!done_window && !done_tenth) {
#ifdef BENCHMARKING
        unsigned long end_us = micros();
        Serial.print("BenchSample: ");
        unsigned long diff_us = end_us - start_us;
        Serial.println(diff_us);
        if (diff_us > SAMPLE_USEC) {
            Serial.print("BenchSample larger than sample time window ");
            Serial.println(SAMPLE_USEC);
        }
#endif // BENCHMARKING
        return;
    }
#ifdef BENCHMARKING
    start_us = micros();
#endif // BENCHMARKING
    if (done_window) {
        char ch = process_goertzel();
        goertzel_offset = 0;

#ifdef BENCHMARKING
        unsigned long end_us = micros();
        Serial.print("BenchWindow: ");
        unsigned long diff_us = end_us - start_us;
        Serial.println(diff_us);
        if (diff_us > SAMPLE_USEC) {
            Serial.print("BenchWindow larger than sample time window ");
            Serial.println(SAMPLE_USEC);
        }
#else
        UNUSED(ch);
#endif // BENCHMARKING

        // Expensive char printing that doesn't affect the benchmark timing
#ifdef BENCHMARKING
        if (ch != -1) {
            Serial.print("[");
            if (isalnum(ch) || (ch == ' ')) {
                Serial.print(ch);
            } else {
                Serial.print('~');
            }
            Serial.print("]=x");
            Serial.print((unsigned char)ch, HEX);
            Serial.println();
        }
#endif // BENCHMARKING
    } else if (done_tenth) {
        bool mark_space = get_goertzel_mark_space();
        if (!mark_space) {
            // We have found the first space, indicating start of message, but do not reset_goertzel()
            // or we lose a tenth worth of energy that we've already seen, but the reset is done
            reset_is_done = 1;
        } else {
            // Did not see a space, so nuke the energy built up and try again for a fresh space detection
            reset_goertzel();
            goertzel_offset = 0;
        }

#ifdef BENCHMARKING
        unsigned long end_us = micros();
        Serial.print("BenchAlign: ");
        unsigned long diff_us = end_us - start_us;
        Serial.println(diff_us);
        if (diff_us > SAMPLE_USEC) {
            Serial.print("BenchAlign larger than sample time window ");
            Serial.println(SAMPLE_USEC);
        }
#endif // BENCHMARKING
    } else {
        Serial.println("Unexpected condition\n");
    }
}

unsigned long last_usec = 0;
uint16_t sample_count = 0;

void loop() {
// #define DEBUG_LOOP
#ifdef DEBUG_LOOP
    unsigned long last_blink = 0;
    if ((millis() - last_blink) > 1000) {
        Serial.println("DEBUG");
        Serial.println(millis());
        digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN));
        last_blink = millis();
    }
#endif // DEBUG_LOOP

#ifndef INTERRUPT_HANDLER
    // If there is no interrupt handler, implement the sample rate by checking the timer
    unsigned long now_usec = micros();
    unsigned long diff_usec = now_usec - last_usec;
    if (diff_usec >= SAMPLE_USEC) {
        digitalWrite(SCOPE_PIN, 1);
        sample_count++;
        sample();
        digitalWrite(SCOPE_PIN, 0);
        unsigned long used_usec = micros();
        if ((used_usec-now_usec) > SAMPLE_USEC) {
            // Toggle the oscilloscope pin to show the rate of timeouts
            digitalWrite(ERROR_PIN, !digitalRead(ERROR_PIN));
            // TODO: Every time we finish a Goertzel window, we lost a sample and we are now
            // one behind. We lose one sample per bit and each char is 10 bits. For a 3
            // char message like '123' there are 3*10=30 bits. We have drifted by 30/400=7.5%
            // but still less that one tenth of a window. We need to eventually deal with
            // this problem to prevent drift for longer messages.
#define VERBOSE_DEBUG
#ifdef VERBOSE_DEBUG
            Serial.print("sample() took too long ");
            Serial.print(used_usec-now_usec);
            Serial.print(" on loop ");
            Serial.print(sample_count);
            Serial.println();
#endif // VERBOSE_DEBUG
        }
        last_usec = now_usec;
    }
#endif // INTERRUPT_HANDLER
}

#ifdef INTERRUPT_HANDLER
ISR(TIMER1_COMPA_vect) {
    // Process one audio sample and then end quickly, do not measure time since the
    // timing functions don't advance in an interrupt handler.
    digitalWrite(SCOPE_PIN, 1);
    sample();
    digitalWrite(SCOPE_PIN, 0);
}
#endif // INTERRUPT_HANDLER
