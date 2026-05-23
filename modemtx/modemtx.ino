#include <Arduino.h>
#include <Wire.h>

#include "modem-const.h"

#define MARK_FREQ 1270
#define SPACE_FREQ 1070

#define BAUD_MSEC (1000/BAUD_RATE)

// Undefine this string to read chars from the serial port
#define TRANSMIT_STRING "WAKE"

// Configure piezo center on pin 9, metal attached to GND pin
#define PIEZO_PIN 9

/*
  Can connect the audio pin 9 to a piezo speaker, or to an audio amplifier.

  Arduino Mini Nano V3.0 ATmega328P - 5V regulator, powered via USB
  TDA7498E 160w x2 Two Channel Audio Power Amplifier Board Digital Stereo Power AMP Module BTL Mode

                  10 kΩ Resistor            10 µF Electrolytic
   Arduino Pin ───────[====]───────┬───────────┤|(────────────> RCA Center Pin
                                   │          (+)  (-)           (Left/Right Signal)
                                   │         [Stripe]
                                   v
                             2.2 kΩ Resistor
                                   │
                                   v
   Arduino GND ────────────────────┴──────────────────────────> RCA Outer Shield
                                                                 (Ground)
 */

void setup()
{
    // Configure the built-in LED for debugging
    pinMode(LED_BUILTIN, OUTPUT);
    digitalWrite(LED_BUILTIN, HIGH);

    // Configure the serial port with the defaults for testing
    Serial.begin(MAKEFILE_BAUD);

    // Enable the piezo pin for output, disable any output
    pinMode(PIEZO_PIN, OUTPUT);
    noTone(PIEZO_PIN);

    delay(1000);
    Serial.print("Modem TX: ");
    Serial.print("Baud=");
    Serial.print(BAUD_RATE);
    Serial.print(",ToneMsec=");
    Serial.print(BAUD_MSEC);
    Serial.print(",MarkHz=");
    Serial.print(MARK_FREQ);
    Serial.print(",SpaceHz=");
    Serial.print(SPACE_FREQ);
    Serial.print(",F_CPU=");
    Serial.print(F_CPU);
#ifdef TRANSMIT_STRING
    Serial.print(",Output=[");
    Serial.print(TRANSMIT_STRING);
    Serial.print("]");
#else
    Serial.print(",Output=UART");
#endif // TRANSMIT_STRING
    Serial.println();
}

void play_bit(uint16_t freq) {
    tone(PIEZO_PIN, freq);
    delay(BAUD_MSEC);
}

void play_flush() {
    // Play ten mark bits to flush out the receiver and clear the state ready for transmission
    for (int b = 0; b < 10; b++) {
        play_bit(MARK_FREQ);
    }
}

void play_char(char ch) {
    // Play at least one mark bit to clear the state before sending the start bit
    play_bit(MARK_FREQ);

    // Start bit
    play_bit(SPACE_FREQ);

    // Each bit in the char
    for (int bn = 0; bn < 8; bn++) {
        bool b = ch & (1 << bn);
        play_bit(b ? MARK_FREQ : SPACE_FREQ);
    }

    // Stop bit
    play_bit(MARK_FREQ);

    // Optional extra mark padding can be sent here
    // play_bit(MARK_FREQ);
}

#ifdef TRANSMIT_STRING
#warning Transmitting hard-coded debug string
void loop() {
    play_flush();
    for (const char* ch = TRANSMIT_STRING; *ch != '\0'; ch++) {
        // Invert the LED for each char transmitted
        bool value = digitalRead(LED_BUILTIN);
        digitalWrite(LED_BUILTIN, !value);

        play_char(*ch);
        Serial.print("[");
        Serial.print(*ch);
        Serial.print("]");
    }

    // Transmit no audio between messages
    noTone(PIEZO_PIN);
    delay(1000);
}

#else // TRANSMIT_STRING

#warning Transmitting input chars from UART serial
void loop()
{
    bool first = true;

    // If any incoming characters are found, play them out. New chars might arrive
    // during the transmission so they will all be sent together.
    while (Serial.available() > 0) {

        // Flush out the receiver and clear the state ready for transmission
        if (first) {
            play_flush();
            first = false;
        }

        char ch = Serial.read();

        // Invert the LED for each char processed
        bool value = digitalRead(LED_BUILTIN);
        digitalWrite(LED_BUILTIN, !value);

        // Send the char
        play_char(ch);
        Serial.print("[");
        Serial.print(ch);
        Serial.print("]");
    }

    // Shut off the output when idle. The play_flush() will run whenever new chars
    // arrive so no need to output mark tones here.
    noTone(PIEZO_PIN);
}

#endif // TRANSMIT_STRING
