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
#include <Wire.h>

#define PIN_STATUS_LED 13 // PB5, SCK, standard Arduino Uno LED
static_assert(PIN_STATUS_LED == LED_BUILTIN);

#define PIN_INPUT A0 // ADC0 pin can be analog or digital input for a trigger

#define PIN_MOSFET 15 // PC1, physical pin 24

#define MANUAL_TRIGGER_MSEC 500

#define WAKE_ACTIVE_MSEC 1000

char wake_word[] = "WAKE";

void setup()
{
    // Configure the built-in LED for debugging
    pinMode(LED_BUILTIN, OUTPUT);
    digitalWrite(LED_BUILTIN, HIGH);

    // Configure the MOSFET to be off by default
    digitalWrite(PIN_MOSFET, LOW);

    // Read the manual triggering
    pinMode(PIN_INPUT, INPUT);

    // Configure the serial port
    Serial.begin(MAKEFILE_BAUD);

    delay(1000);
    Serial.println("ModemRelease " __DATE__ " " __TIME__);
}

char *wake_ptr = wake_word;

void trigger_mosfet (void) {
    Serial.println("MOSFET ON-WAIT");
    digitalWrite(PIN_MOSFET, HIGH);
    delay(WAKE_ACTIVE_MSEC);
    Serial.println("MOSFET OFF");
    digitalWrite(PIN_MOSFET, LOW);
}

void loop()
{
// #define DEBUG_LOOP
#if DEBUG_LOOP
    static unsigned long last_blink = 0;
    if ((millis() - last_blink) > 1000) {
        Serial.println("DEBUG");
        Serial.println(millis());
        digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN));
        last_blink = millis();
    }
#endif // DEBUG_LOOP

    // If the wake word is finished then do the release
    if (*wake_ptr == '\0') {
        Serial.print("Wake word detected ");
        Serial.println(wake_word);
        trigger_mosfet();
        wake_ptr = wake_word;
    }

    while (Serial.available() > 0) {
        // Do not overrun the wake_word buffer
        if (*wake_ptr == '\0') {
            return;
        }
        char ch = Serial.read();
        if (ch == *wake_ptr) {
            // Match, go to the next
            wake_ptr++;
            Serial.print("MATCH: ");
        } else {
            // No match, so reset to the start
            wake_ptr = wake_word;
            Serial.print("WAKEFAIL: ");
        }
        Serial.println(ch);
        // Invert the LED for each char processed
        bool value = digitalRead(LED_BUILTIN);
        digitalWrite(LED_BUILTIN, !value);
    }

    // Wires open is 1, shorted/conducting is 0
    bool trigger_current = !digitalRead(PIN_INPUT);
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
            Serial.println("Trigger pin change to pressed");
        } else {
            Serial.println("Trigger pin change to released");
        }
    } else {
        // Trigger is the same state, so lets wait to see if the press is long enough
        if ((millis() - last_trigger_time) > 3000) {
            Serial.println(millis());
            if (trigger_current) {
                if (trigger_state == false) {
                    Serial.println("Manual trigger detected");
                    trigger_mosfet();
                    // Prevent trigger happening again until it is released
                    trigger_state = true;
                } else {
                    Serial.println("Manual trigger ignored until release state change");
                }
            } else {
                if (trigger_state == true) {
                    Serial.println("Release trigger, state changed");
                    trigger_state = false;
                } else {
                    Serial.println("Ignoring existing trigger release");
                }
            }
            last_trigger_time = millis();
        }
    }
}
