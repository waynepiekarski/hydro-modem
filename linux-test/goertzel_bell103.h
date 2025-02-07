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

#ifndef vprintf_goertzel
#define vprintf_goertzel(...)
#endif

#define MARK_FREQ 1270
#define SPACE_FREQ 1070

int bit_count = 0;
unsigned char current_byte = 0;
int waiting_for_start = 1; // Flag to indicate waiting for start bit
int reset_is_done = 0;
int goertzel_offset = 0;
int sample_offset = 0;
char last_char = -1;

// 64-bit integers with 16-bit resolution passes all tests
// 16 MHz atmega328p: int64_t<<8 sample=190us, char=220us, 4KHz=250us (64-bit fixed is even slower)
//#define STYPE int64_t
//#define FIXEDRES 8 /* Any less than 8 fails */
//#define STYPEFMT "%ld"
// 16 MHz atmega328p: int32_t<<8  sample=136us, char=60us, 4KHz=250us (32-bit doesn't work)
//#define STYPE int32_t
//#define FIXEDRES 8
//#define STYPEFMT "%d"
// 16 MHz atmega328p: int16_t<<4  sample=120us, char=12us, 4KHz=250us (16-bit has almost zero char time, but can't work)
//#define STYPE int16_t
//#define FIXEDRES 2
//#define STYPEFMT "%d"
// 16 MHz atmega328p: float       sample=180us, char=116us, 4KHz=250us (sample+char is over 250us budget, but no fixed conversions)
//
// On the Lilygo esp32:esp32:lilygo_t_display_s3 ESP32-S3R8 each sample is 1-2 microseconds with floats so could run at ~400 KHz
#define STYPE float
#define FLOATRES 1
#define STYPEFMT "%18.1f"

// Implement fixed point arithmetic, use 1 (without a decimal point) for no implementation
#ifdef FLOATRES
//#warning Using floats with test multiplier
//#define FMUL(a,b) (((a)*(b))/(FLOATRES))
//#define TOFIXED(a) ((FLOATRES)*(a))
//#define FROMFIXED(a) ((a)/(FLOATRES))
#define FMUL(a,b) ((a)*(b))
#define TOFIXED(a) (a)
#define FROMFIXED(a) (a)
#else
#warning Using fixed-point arithmetic
#define FMUL(a,b) (((a)*(b))>>(FIXEDRES))
#define TOFIXED(a) ((a)*((STYPE)1<<(FIXEDRES)))
#define FROMFIXED(a) ((a)>>(FIXEDRES))
#endif


// Goertzel algorithm for frequency detection
STYPE s_mark = 0, c_mark = 0, s_space = 0, c_space = 0;
STYPE coeff_mark;
STYPE coeff_space;

#ifdef __linux__
double diff_total; // Confidence interval based on the strength of the diff values accumulated
double diff_total_log10;
#endif // __linux__

void init_goertzel (void) {
    assert_goertzel(SAMPLE_RATE > 0);
    coeff_mark = TOFIXED(2 * cos(2 * M_PI * MARK_FREQ / SAMPLE_RATE));
    coeff_space = TOFIXED(2 * cos(2 * M_PI * SPACE_FREQ / SAMPLE_RATE));
    printf_goertzel("coeff_mark=" STYPEFMT ", coeff_space=" STYPEFMT "\n", FROMFIXED(coeff_mark), FROMFIXED(coeff_space));
#ifdef __linux__
    diff_total = 0;
    diff_total_log10 = 0;
#endif // __linux__
}

void reset_goertzel (void) {
    s_mark = 0;
    c_mark = 0;
    s_space = 0;
    c_space = 0;
}

#if defined(__SIZEOF_INT128__) && defined(__linux__) && !defined(FLOATRES)
#warning Checking multiplication overflows with 128-bit integers
void check_overflow_mul(STYPE a, STYPE b) {
    STYPE r = a * b;
    __int128 aa = a;
    __int128 bb = b;
    __int128 rr = aa * bb;
    if (r != rr) {
        fprintf(stderr, "Overflow detected multiplying " STYPEFMT " by " STYPEFMT " with sizeof=%zu\n", a, b, sizeof(STYPE));
        exit(1);
    }
}
#else
inline void check_overflow_mul(STYPE, STYPE) { }
#endif

static_assert(sizeof(short) == sizeof(int16_t));
// Arduino ADC is 0-1023 while Linux is signed 16-bit integer
void sample_goertzel (int16_t sample) {
    STYPE s_prev_mark = s_mark;
    STYPE s_prev_space = s_space;

    // The sample doesn't have any official units and is an integer already, so no need to
    // use TOFIXED to round it from a float
    s_mark = /*TOFIXED*/(sample) + FMUL(coeff_mark, s_prev_mark) - c_mark;
    check_overflow_mul(coeff_mark, s_prev_mark);
    c_mark = s_prev_mark;

    s_space = /*TOFIXED*/(sample) + FMUL(coeff_space, s_prev_space) - c_space;
    check_overflow_mul(coeff_space, s_prev_space);
    c_space = s_prev_space;
}

#define UNUSED(expr) do { (void)(expr); } while (0)

// Check early what the result of mark > space is, and return a bool with the result
bool get_goertzel_mark_space (void) {
    // Calculate the power values for both frequencies, avoid the square root since we are comparing them
    STYPE power_mark  = (FMUL(s_mark, s_mark)   + FMUL(c_mark, c_mark)   - FMUL(FMUL(coeff_mark, s_mark), c_mark));
    STYPE power_space = (FMUL(s_space, s_space) + FMUL(c_space, c_space) - FMUL(FMUL(coeff_space, s_space), c_space));
    vprintf_goertzel("  PRE ");
    // vprintf_goertzel("%4d,%6d: ", goertzel_offset, sample_offset);
    vprintf_goertzel("%4.2fs ", sample_offset / (float)SAMPLE_RATE);
    vprintf_goertzel("[%c]=%d ", power_mark > power_space ? 'M' : 'S', power_mark > power_space ? 1 : 0);
    vprintf_goertzel("mark=" STYPEFMT "(%4.1f), space=" STYPEFMT "(%4.1f) -- ", FROMFIXED(power_mark), log10(FROMFIXED(power_mark)), FROMFIXED(power_space), log10(FROMFIXED(power_space)));
    if (power_mark >= power_space) {
        return true;
    } else {
        return false;
    }
}

char process_goertzel (void) {
    last_char = -1;
    // Calculate the power values for both frequencies, avoid the square root since we are comparing them
    STYPE power_mark  = (FMUL(s_mark, s_mark)   + FMUL(c_mark, c_mark)   - FMUL(FMUL(coeff_mark, s_mark), c_mark));
    STYPE power_space = (FMUL(s_space, s_space) + FMUL(c_space, c_space) - FMUL(FMUL(coeff_space, s_space), c_space));
    printf_goertzel("%4.2fs ", sample_offset / (float)SAMPLE_RATE);
    printf_goertzel("[%c]=%d ", power_mark > power_space ? 'M' : 'S', power_mark > power_space ? 1 : 0);
#ifdef __linux__
    STYPE diff = FROMFIXED(power_mark-power_space);
    char diffc = (diff < 0 ? '-' : '+');
    if (diff < 0) {
        diff = -diff;
    }
    if (FROMFIXED(diff) > 0.0001) {
        diff_total += FROMFIXED(diff);
        diff_total_log10 += log10(FROMFIXED(diff));
    }
#endif // __linux__
    printf_goertzel("mark=" STYPEFMT "(%4.1f), space=" STYPEFMT "(%4.1f), diff=%c" STYPEFMT "(%c%4.1f =+ %18.0f)", FROMFIXED(power_mark), log10(FROMFIXED(power_mark)), FROMFIXED(power_space), log10(FROMFIXED(power_space)), diffc, FROMFIXED(diff), diffc, log10(FROMFIXED(diff)), diff_total );

    emit_bit(power_mark > power_space);

    // Implement the detection of collecting the bits into 8-bit bytes using start and stop bits
    if (waiting_for_start) {
        if (power_space > power_mark) { // Start bit detected
            waiting_for_start = 0;
            bit_count = 0;
            current_byte = 0;
            printf_goertzel("bS=0 Found start bit\n");
        } else {
            // Optionally handle timeout or resynchronization if no start bit is found for a long time
            printf_goertzel("bW=1 Waiting for start bit\n");
        }
    } else { // Accumulating data bits or checking for stop bit
        if (bit_count < 8) {
            if (power_mark > power_space) {
                current_byte |= (1 << bit_count);
                printf_goertzel("b%d=1", bit_count);
            } else {
                current_byte |= (0 << bit_count);
                printf_goertzel("b%d=0", bit_count);
            }
            bit_count++;
        } else { // Stop bit expected
            if (power_mark > power_space) { // Stop bit detected
                printf_goertzel("bF=0 Stop: Raw 0x%.2X [%c] b%.8s",
                                current_byte, char2safe(current_byte), char2bin(current_byte).c_str());
                emit_goertzel(current_byte);
                last_char = current_byte; // Char cannot be -1=0xFF or it will be ignored
                waiting_for_start = 1;
                reset_is_done = 0;
            } else {
                printf_goertzel("bF=1 Stop: Did not find expected stop bit");
                // You might want to add resynchronization logic here
            }
        }
        printf_goertzel("\n");
    }

    reset_goertzel();
    return last_char;
}
