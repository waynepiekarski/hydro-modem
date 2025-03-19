EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "HydroModem - Piezo Audio Modem ATmega328p 5V 16MHz"
Date "2025-03-15"
Rev "v1"
Comp "Copyright (C) Wayne Piekarski 2024-2025 - Licensed under CERN-OHL-S v2"
Comment1 "https://www.waynepiekarski.net/projects/hydro-modem.htm"
Comment2 ""
Comment3 " under the terms of the CERN-OHL-S v2 (https://ohwr.org/cern_ohl_s_v2.txt)"
Comment4 "You may redistribute and modify this source and make products using it"
$EndDescr
$Comp
L power:GND #PWR0101
U 1 1 5ED23CB0
P 3600 3900
F 0 "#PWR0101" H 3600 3650 50  0001 C CNN
F 1 "GND" H 3605 3727 50  0000 C CNN
F 2 "" H 3600 3900 50  0001 C CNN
F 3 "" H 3600 3900 50  0001 C CNN
	1    3600 3900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0107
U 1 1 5F0BBE07
P 5200 1550
F 0 "#PWR0107" H 5200 1300 50  0001 C CNN
F 1 "GND" H 5205 1377 50  0000 C CNN
F 2 "" H 5200 1550 50  0001 C CNN
F 3 "" H 5200 1550 50  0001 C CNN
	1    5200 1550
	1    0    0    -1  
$EndComp
$Comp
L Connector:AVR-ISP-6 AVRISP6
U 1 1 5EFCCAD5
P 5100 1050
F 0 "AVRISP6" H 4750 1150 50  0000 R CNN
F 1 "AVR-ISP-6" H 4750 1050 50  0000 R CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x03_P2.54mm_Vertical" V 4850 1100 50  0001 C CNN
F 3 "https://www.mill-max.com/catalog/download/2019-03%3A018.3M_0.pdf" H 3825 500 50  0001 C CNN
	1    5100 1050
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4200 1550 4550 1550
Wire Wire Line
	4200 1450 4450 1450
Wire Wire Line
	4200 1350 4350 1350
Wire Wire Line
	4450 1450 4450 850 
Wire Wire Line
	4450 850  4700 850 
Wire Wire Line
	4350 1350 4350 950 
Wire Wire Line
	4350 950  4700 950 
Wire Wire Line
	4700 1150 4650 1150
Wire Wire Line
	4550 1550 4550 1050
Wire Wire Line
	4550 1050 4700 1050
Wire Wire Line
	4700 750  4700 550 
Wire Wire Line
	4700 550  5200 550 
Wire Wire Line
	5200 1450 5200 1550
Text GLabel 4250 2550 2    50   Input ~ 0
RESET
Wire Wire Line
	4250 2550 4200 2550
Text GLabel 4700 1450 2    50   Input ~ 0
RESET
Wire Wire Line
	4650 1150 4650 1450
Wire Wire Line
	4650 1450 4700 1450
Wire Wire Line
	4250 2750 4200 2750
Wire Wire Line
	4250 3450 4200 3450
Wire Wire Line
	4200 3350 4250 3350
Wire Wire Line
	4250 3250 4200 3250
Wire Wire Line
	4200 3150 4250 3150
Wire Wire Line
	4250 3050 4200 3050
Wire Wire Line
	4200 2950 4250 2950
Wire Wire Line
	4250 2850 4200 2850
NoConn ~ 3000 1250
NoConn ~ 3000 1350
NoConn ~ 4200 1050
NoConn ~ 4200 1150
NoConn ~ 4200 1250
$Comp
L custom:WP_RS232_Conn_01x05 J3
U 1 1 5FC2CA83
P 1500 5000
F 0 "J3" H 1669 5050 50  0000 L CNN
F 1 "UART0" H 1669 4959 50  0000 L CNN
F 2 "custom:WP_Serial_5P_F" H 1500 5000 50  0001 C CNN
F 3 "~" H 1500 5000 50  0001 C CNN
	1    1500 5000
	1    0    0    -1  
$EndComp
Text GLabel 4250 2750 2    50   Input ~ 0
RX5
Text GLabel 4250 2850 2    50   Input ~ 0
TX5
Text Notes 3750 2800 0    50   ~ 0
RXD
Text Notes 3750 2900 0    50   ~ 0
TXD
Text GLabel 1200 5000 0    50   Input ~ 0
RX3V3
Text GLabel 1200 5100 0    50   Input ~ 0
TX3V3
$Comp
L power:GND #PWR0105
U 1 1 5FC4E142
P 1100 4900
F 0 "#PWR0105" H 1100 4650 50  0001 C CNN
F 1 "GND" V 1105 4772 50  0000 R CNN
F 2 "" H 1100 4900 50  0001 C CNN
F 3 "" H 1100 4900 50  0001 C CNN
	1    1100 4900
	0    1    1    0   
$EndComp
Wire Wire Line
	1100 4900 1300 4900
Text GLabel 1200 4800 0    50   Input ~ 0
5V-In
NoConn ~ 4250 2950
NoConn ~ 4250 3050
NoConn ~ 4250 3150
NoConn ~ 4250 3250
NoConn ~ 4250 3350
NoConn ~ 4250 3450
Text GLabel 2600 4200 2    50   Input ~ 0
RESET
Wire Wire Line
	1300 5300 1300 5200
Wire Wire Line
	1200 5000 1300 5000
Wire Wire Line
	1200 4800 1250 4800
Text GLabel 4700 1550 2    50   Input ~ 0
PB5_SCK
Wire Wire Line
	4700 1550 4550 1550
Connection ~ 4550 1550
$Comp
L Device:LED D2
U 1 1 608269C3
P 7350 850
F 0 "D2" V 7389 732 50  0000 R CNN
F 1 "FLASH" V 7298 732 50  0000 R CNN
F 2 "custom:WP_LED_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 7350 850 50  0001 C CNN
F 3 "~" H 7350 850 50  0001 C CNN
	1    7350 850 
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0108
U 1 1 608269CD
P 7550 850
F 0 "#PWR0108" H 7550 600 50  0001 C CNN
F 1 "GND" H 7555 677 50  0000 C CNN
F 2 "" H 7550 850 50  0001 C CNN
F 3 "" H 7550 850 50  0001 C CNN
	1    7550 850 
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7550 850  7500 850 
Wire Wire Line
	7200 850  7150 850 
Wire Wire Line
	6850 850  6800 850 
Text GLabel 6800 850  0    50   Input ~ 0
PB5_SCK
Text Notes 6400 1000 0    50   ~ 0
Blinks during flashing, attached to PB5 / SCK
$Comp
L Device:Crystal Y1
U 1 1 6027E69C
P 2850 1700
F 0 "Y1" V 2750 1800 50  0000 L CNN
F 1 "AB308-16.000MHZ" V 2850 1150 50  0000 L CNN
F 2 "Crystal:Crystal_Round_D1.0mm_Vertical" H 2850 1700 50  0001 C CNN
F 3 "https://abracon.com/Resonators/ab308.pdf" H 2850 1700 50  0001 C CNN
	1    2850 1700
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0109
U 1 1 6027F232
P 2200 1950
F 0 "#PWR0109" H 2200 1700 50  0001 C CNN
F 1 "GND" H 2205 1777 50  0000 C CNN
F 2 "" H 2200 1950 50  0001 C CNN
F 3 "" H 2200 1950 50  0001 C CNN
	1    2200 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:C C6
U 1 1 602814C0
P 2450 1550
F 0 "C6" V 2198 1550 50  0000 C CNN
F 1 "22pF" V 2289 1550 50  0000 C CNN
F 2 "custom:WP_C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 2488 1400 50  0001 C CNN
F 3 "~" H 2450 1550 50  0001 C CNN
	1    2450 1550
	0    1    1    0   
$EndComp
$Comp
L Device:C C7
U 1 1 602818F7
P 2450 1850
F 0 "C7" V 2700 1850 50  0000 C CNN
F 1 "22pF" V 2600 1850 50  0000 C CNN
F 2 "custom:WP_C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 2488 1700 50  0001 C CNN
F 3 "~" H 2450 1850 50  0001 C CNN
	1    2450 1850
	0    -1   1    0   
$EndComp
Wire Wire Line
	2300 1850 2200 1850
Wire Wire Line
	2200 1850 2200 1950
Wire Wire Line
	2200 1850 2200 1550
Wire Wire Line
	2200 1550 2300 1550
Connection ~ 2200 1850
Wire Wire Line
	2600 1550 2850 1550
Wire Wire Line
	2850 1850 2600 1850
Wire Wire Line
	3250 1800 3250 1850
Wire Wire Line
	3250 1550 3250 1600
Text Notes 1400 1800 0    50   ~ 0
22pF based on CL\nof 16pF from AB308\nand 5pF parasitic
Text Notes 1150 2550 0    50   ~ 0
This modem must use >= 4.0V and 16MHz.\nMust use 500,000 bps for fast transmit.\n115,200 bps is not accurate at this frequency.
Wire Wire Line
	4200 1650 4250 1650
Wire Wire Line
	4250 1650 4250 1600
Wire Wire Line
	4250 1600 3250 1600
Wire Wire Line
	3250 1800 4250 1800
Wire Wire Line
	4250 1800 4250 1750
Wire Wire Line
	4250 1750 4200 1750
Wire Wire Line
	3600 3750 3600 3900
Wire Wire Line
	2850 1550 3250 1550
Connection ~ 2850 1550
Wire Wire Line
	2850 1850 3250 1850
Connection ~ 2850 1850
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 607F877B
P 1250 4650
F 0 "#FLG0101" H 1250 4725 50  0001 C CNN
F 1 "PWR_FLAG" H 1250 4823 50  0000 C CNN
F 2 "" H 1250 4650 50  0001 C CNN
F 3 "~" H 1250 4650 50  0001 C CNN
	1    1250 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 4650 1250 4800
Connection ~ 1250 4800
Wire Wire Line
	1250 4800 1300 4800
Text GLabel 2600 3850 2    50   Input ~ 0
5V-In
$Comp
L Device:R R11
U 1 1 61C36083
P 2450 4050
F 0 "R11" H 2520 4096 50  0000 L CNN
F 1 "10K" H 2520 4005 50  0000 L CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 2380 4050 50  0001 C CNN
F 3 "~" H 2450 4050 50  0001 C CNN
	1    2450 4050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C8
U 1 1 61C38961
P 2150 4200
F 0 "C8" V 1898 4200 50  0000 C CNN
F 1 "0.1uF" V 1989 4200 50  0000 C CNN
F 2 "custom:WP_C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 2188 4050 50  0001 C CNN
F 3 "~" H 2150 4200 50  0001 C CNN
	1    2150 4200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2300 4200 2450 4200
Connection ~ 2450 4200
Wire Wire Line
	2450 4200 2600 4200
Text Notes 900  3900 0    50   ~ 0
Implement Arduino reset protocol\nConvert DTR down into a short pulse
Wire Wire Line
	1950 5300 1950 4200
Wire Wire Line
	1950 4200 2000 4200
Wire Wire Line
	1300 5300 1950 5300
Text GLabel 2400 750  0    50   Output ~ 0
5V-In
$Comp
L Device:C C9
U 1 1 65FDD3FB
P 2800 1050
F 0 "C9" V 2548 1050 50  0000 C CNN
F 1 "0.1uF" V 2639 1050 50  0000 C CNN
F 2 "custom:WP_C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 2838 900 50  0001 C CNN
F 3 "~" H 2800 1050 50  0001 C CNN
	1    2800 1050
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2400 750  3600 750 
Connection ~ 3600 750 
Wire Wire Line
	3700 750  4700 750 
Wire Wire Line
	3600 750  3700 750 
Connection ~ 3700 750 
$Comp
L MCU_Microchip_ATmega:ATmega328P-AU U3
U 1 1 5EFC922A
P 3600 2250
F 0 "U3" H 3600 2350 50  0000 C CNN
F 1 "ATmega328P-AU" H 3550 2250 50  0000 C CNN
F 2 "Package_QFP:TQFP-32_7x7mm_P0.8mm" H 3600 2250 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega328_P%20AVR%20MCU%20with%20picoPower%20Technology%20Data%20Sheet%2040001984A.pdf" H 3600 2250 50  0001 C CNN
	1    3600 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 1050 2950 1050
$Comp
L power:GND #PWR0114
U 1 1 65FF6636
P 2600 1050
F 0 "#PWR0114" H 2600 800 50  0001 C CNN
F 1 "GND" H 2605 877 50  0000 C CNN
F 2 "" H 2600 1050 50  0001 C CNN
F 3 "" H 2600 1050 50  0001 C CNN
	1    2600 1050
	0    1    1    0   
$EndComp
Wire Wire Line
	2600 1050 2650 1050
$Comp
L Device:R R2
U 1 1 608269B9
P 7000 850
F 0 "R2" V 6793 850 50  0000 C CNN
F 1 "25K5" V 6884 850 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 6930 850 50  0001 C CNN
F 3 "~" H 7000 850 50  0001 C CNN
	1    7000 850 
	0    1    1    0   
$EndComp
Text Notes 5650 3050 0    50   ~ 0
The modem runs with 5V assuming a regulated supply.\nOnly use 3V3 output UART voltages to protect the other side which runs with 3V3.
Text Notes 650  5700 0    50   ~ 0
5-pin female plug to use as a peripheral.\nMust flip here to connect to the UART host.\nCannot be programmed from here without an inverter adapter.
Text GLabel 5150 2750 0    50   Input ~ 0
RX5
Text GLabel 5350 2750 2    50   Input ~ 0
RX3V3
Wire Wire Line
	5150 2750 5350 2750
Text GLabel 5600 3350 2    50   Input ~ 0
TX3V3
Text GLabel 5150 3050 0    50   Input ~ 0
TX5
$Comp
L Device:R R3
U 1 1 67D5456A
P 5300 3200
F 0 "R3" H 5150 3100 50  0000 C CNN
F 1 "10K" H 5184 3200 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 5230 3200 50  0001 C CNN
F 3 "~" H 5300 3200 50  0001 C CNN
	1    5300 3200
	-1   0    0    1   
$EndComp
$Comp
L Device:R R4
U 1 1 67D54D0C
P 5300 3500
F 0 "R4" H 5150 3600 50  0000 C CNN
F 1 "20K" H 5184 3500 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 5230 3500 50  0001 C CNN
F 3 "~" H 5300 3500 50  0001 C CNN
	1    5300 3500
	-1   0    0    1   
$EndComp
Wire Wire Line
	5150 3050 5300 3050
Wire Wire Line
	5300 3350 5600 3350
Connection ~ 5300 3350
$Comp
L power:GND #PWR0102
U 1 1 67D5C2B1
P 5300 3650
F 0 "#PWR0102" H 5300 3400 50  0001 C CNN
F 1 "GND" H 5305 3477 50  0000 C CNN
F 2 "" H 5300 3650 50  0001 C CNN
F 3 "" H 5300 3650 50  0001 C CNN
	1    5300 3650
	1    0    0    -1  
$EndComp
Text Notes 5650 4300 0    50   ~ 0
If other side has 10K pullup, then need low-enough resistance to maintain 3V3.\n\nDo not use UART pullups on either side, no noise when connected together. Allows lower power wasted.\n\n5V over 3*1K = 1.67 mA\n5V over 3*10K = 0.167 mA\n\nEstimate is 7mA for atmega328p modem, so 1.67 mA is too high!
Text Notes 5650 2600 0    50   ~ 0
Incoming 3V3 UART works without conversion
$Comp
L Device:R R1
U 1 1 67CEBB95
P 2450 4350
F 0 "R1" H 2520 4396 50  0000 L CNN
F 1 "20K" H 2520 4305 50  0000 L CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 2380 4350 50  0001 C CNN
F 3 "~" H 2450 4350 50  0001 C CNN
	1    2450 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	1200 5100 1300 5100
Text Notes 2050 5000 0    50   ~ 0
No RX pullups because we don't have 3V3 for the other side.
Wire Wire Line
	2600 3850 2450 3850
Wire Wire Line
	2450 3850 2450 3900
$Comp
L power:GND #PWR0103
U 1 1 67CF6EF2
P 2450 4500
F 0 "#PWR0103" H 2450 4250 50  0001 C CNN
F 1 "GND" H 2455 4327 50  0000 C CNN
F 2 "" H 2450 4500 50  0001 C CNN
F 3 "" H 2450 4500 50  0001 C CNN
	1    2450 4500
	1    0    0    -1  
$EndComp
Text Notes 900  4050 0    50   ~ 0
Use resistor ladder to generate 3V3
Text Notes 4200 5800 0    50   ~ 0
https://electronics.stackexchange.com/questions/707747/is-this-a-good-circuit-for-connecting-a-piezo-disc-sensor-to-a-microcontroller
$Comp
L Device:R R5
U 1 1 67D0282B
P 4650 6250
F 0 "R5" V 4443 6250 50  0000 C CNN
F 1 "10K" V 4534 6250 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 4580 6250 50  0001 C CNN
F 3 "~" H 4650 6250 50  0001 C CNN
	1    4650 6250
	0    1    1    0   
$EndComp
$Comp
L Device:R R7
U 1 1 67D07C08
P 5150 6250
F 0 "R7" V 4943 6250 50  0000 C CNN
F 1 "10K" V 5034 6250 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 5080 6250 50  0001 C CNN
F 3 "~" H 5150 6250 50  0001 C CNN
	1    5150 6250
	0    1    1    0   
$EndComp
$Comp
L Device:R R8
U 1 1 67D07F8E
P 5150 7700
F 0 "R8" V 4943 7700 50  0000 C CNN
F 1 "10K" V 5034 7700 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 5080 7700 50  0001 C CNN
F 3 "~" H 5150 7700 50  0001 C CNN
	1    5150 7700
	0    1    1    0   
$EndComp
$Comp
L Device:R R6
U 1 1 67D082D3
P 4650 7700
F 0 "R6" V 4443 7700 50  0000 C CNN
F 1 "10K" V 4534 7700 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 4580 7700 50  0001 C CNN
F 3 "~" H 4650 7700 50  0001 C CNN
	1    4650 7700
	0    1    1    0   
$EndComp
$Comp
L Connector_Generic:Conn_01x02 PIEZO1
U 1 1 67D0F5A9
P 4600 7000
F 0 "PIEZO1" V 4600 6850 50  0000 R CNN
F 1 "Piezo" V 4700 7050 50  0000 R CNN
F 2 "custom:WP_PinSocket_1x02_P2.54mm_Vertical" H 4600 7000 50  0001 C CNN
F 3 "~" H 4600 7000 50  0001 C CNN
	1    4600 7000
	0    -1   -1   0   
$EndComp
$Comp
L pspice:DIODE D1
U 1 1 67D135C1
P 4900 6500
F 0 "D1" V 4946 6372 50  0000 R CNN
F 1 "1N4007" V 4855 6372 50  0000 R CNN
F 2 "custom:WP_D_SOD-123" H 4900 6500 50  0001 C CNN
F 3 "~" H 4900 6500 50  0001 C CNN
	1    4900 6500
	0    -1   -1   0   
$EndComp
$Comp
L pspice:DIODE D3
U 1 1 67D140C7
P 4900 7450
F 0 "D3" V 5150 7400 50  0000 R CNN
F 1 "1N4007" V 5050 7400 50  0000 R CNN
F 2 "custom:WP_D_SOD-123" H 4900 7450 50  0001 C CNN
F 3 "~" H 4900 7450 50  0001 C CNN
	1    4900 7450
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R9
U 1 1 67D0870C
P 4650 6750
F 0 "R9" V 4443 6750 50  0000 C CNN
F 1 "1M" V 4534 6750 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 4580 6750 50  0001 C CNN
F 3 "~" H 4650 6750 50  0001 C CNN
	1    4650 6750
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0104
U 1 1 67D2C358
P 5550 7700
F 0 "#PWR0104" H 5550 7450 50  0001 C CNN
F 1 "GND" H 5555 7527 50  0000 C CNN
F 2 "" H 5550 7700 50  0001 C CNN
F 3 "" H 5550 7700 50  0001 C CNN
	1    5550 7700
	1    0    0    -1  
$EndComp
Text GLabel 5500 6250 2    50   Input ~ 0
5V-In
Text GLabel 5500 6900 2    50   Input ~ 0
ADC0
Wire Wire Line
	4500 6250 4450 6250
Wire Wire Line
	4450 6250 4450 6750
Wire Wire Line
	4450 6750 4500 6750
Wire Wire Line
	4450 6750 4450 7200
Wire Wire Line
	4450 7200 4600 7200
Connection ~ 4450 6750
Wire Wire Line
	4450 7200 4450 7700
Wire Wire Line
	4450 7700 4500 7700
Connection ~ 4450 7200
Wire Wire Line
	4800 7700 4900 7700
Wire Wire Line
	4900 7700 4900 7650
Wire Wire Line
	4900 7700 5000 7700
Connection ~ 4900 7700
Wire Wire Line
	4900 7250 4900 7200
Wire Wire Line
	4800 6750 4900 6750
Connection ~ 4900 6750
Wire Wire Line
	4900 6750 4900 6700
Wire Wire Line
	4700 7200 4900 7200
Connection ~ 4900 7200
Wire Wire Line
	4900 6300 4900 6250
Wire Wire Line
	4900 6250 4800 6250
Wire Wire Line
	4900 6250 5000 6250
Connection ~ 4900 6250
Wire Wire Line
	5300 7700 5550 7700
Wire Wire Line
	4900 6750 4900 6900
Wire Wire Line
	5500 6250 5300 6250
Wire Wire Line
	5500 6900 5350 6900
Connection ~ 4900 6900
Wire Wire Line
	4900 6900 4900 7200
Text Notes 4200 5900 0    50   ~ 0
ADC protection circuit from piezo spikes, use 1N4007 and not Schottky
Text GLabel 4250 1950 2    50   Input ~ 0
ADC0
Wire Wire Line
	4200 1950 4250 1950
NoConn ~ 4200 2050
NoConn ~ 4200 2150
NoConn ~ 4200 2250
NoConn ~ 4200 2350
NoConn ~ 4200 2450
$Comp
L Connector_Generic:Conn_01x01 J1
U 1 1 67D6A912
P 5350 7100
F 0 "J1" V 5222 7180 50  0000 L CNN
F 1 "ADC-Debug" V 5313 7180 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x01_P2.54mm_Vertical" H 5350 7100 50  0001 C CNN
F 3 "~" H 5350 7100 50  0001 C CNN
	1    5350 7100
	0    1    1    0   
$EndComp
Connection ~ 5350 6900
Wire Wire Line
	5350 6900 4900 6900
$EndSCHEMATC
