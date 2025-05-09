EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "HydroModem - Piezo OPA1641 P-MOSFET ATmega328p 5V 16MHz"
Date "2025-05-07"
Rev "v4"
Comp "Copyright (C) Wayne Piekarski 2024-2025 - Licensed under CERN-OHL-S v2"
Comment1 "https://www.waynepiekarski.net/projects/hydro-modem.htm"
Comment2 ""
Comment3 " under the terms of the CERN-OHL-S v2 (https://ohwr.org/cern_ohl_s_v2.txt)"
Comment4 "You may redistribute and modify this source and make products using it"
$EndDescr
$Comp
L power:GND #PWR09
U 1 1 5ED23CB0
P 3600 3900
F 0 "#PWR09" H 3600 3650 50  0001 C CNN
F 1 "GND" H 3605 3727 50  0000 C CNN
F 2 "" H 3600 3900 50  0001 C CNN
F 3 "" H 3600 3900 50  0001 C CNN
	1    3600 3900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR013
U 1 1 5F0BBE07
P 5200 1550
F 0 "#PWR013" H 5200 1300 50  0001 C CNN
F 1 "GND" H 5205 1377 50  0000 C CNN
F 2 "" H 5200 1550 50  0001 C CNN
F 3 "" H 5200 1550 50  0001 C CNN
	1    5200 1550
	1    0    0    -1  
$EndComp
$Comp
L Connector:AVR-ISP-6 AVRISP0
U 1 1 5EFCCAD5
P 5100 1050
F 0 "AVRISP0" H 4750 1150 50  0000 R CNN
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
Text GLabel 4250 2750 2    50   Input ~ 0
RX5
Text GLabel 4250 2850 2    50   Input ~ 0
TX5
Text Notes 3750 2800 0    50   ~ 0
RXD
Text Notes 3750 2900 0    50   ~ 0
TXD
Text GLabel 1200 5100 0    50   Input ~ 0
RX3V3
Text GLabel 1200 5000 0    50   Input ~ 0
TX3V3
$Comp
L power:GND #PWR01
U 1 1 5FC4E142
P 1100 4900
F 0 "#PWR01" H 1100 4650 50  0001 C CNN
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
L power:GND #PWR017
U 1 1 608269CD
P 7550 850
F 0 "#PWR017" H 7550 600 50  0001 C CNN
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
L power:GND #PWR04
U 1 1 6027F232
P 2200 1950
F 0 "#PWR04" H 2200 1700 50  0001 C CNN
F 1 "GND" H 2205 1777 50  0000 C CNN
F 2 "" H 2200 1950 50  0001 C CNN
F 3 "" H 2200 1950 50  0001 C CNN
	1    2200 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:C C4
U 1 1 602814C0
P 2450 1550
F 0 "C4" V 2198 1550 50  0000 C CNN
F 1 "22pF" V 2289 1550 50  0000 C CNN
F 2 "custom:WP_C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 2488 1400 50  0001 C CNN
F 3 "~" H 2450 1550 50  0001 C CNN
	1    2450 1550
	0    1    1    0   
$EndComp
$Comp
L Device:C C5
U 1 1 602818F7
P 2450 1850
F 0 "C5" V 2700 1850 50  0000 C CNN
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
Text Notes 550  1500 0    50   ~ 0
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
L power:PWR_FLAG #FLG01
U 1 1 607F877B
P 1250 4650
F 0 "#FLG01" H 1250 4725 50  0001 C CNN
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
L Device:R R3
U 1 1 61C36083
P 2450 4050
F 0 "R3" H 2520 4096 50  0000 L CNN
F 1 "10K" H 2520 4005 50  0000 L CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 2380 4050 50  0001 C CNN
F 3 "~" H 2450 4050 50  0001 C CNN
	1    2450 4050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 61C38961
P 2150 4200
F 0 "C3" V 1898 4200 50  0000 C CNN
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
L Device:C C6
U 1 1 65FDD3FB
P 2800 1050
F 0 "C6" V 2548 1050 50  0000 C CNN
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
L MCU_Microchip_ATmega:ATmega328P-AU U1
U 1 1 5EFC922A
P 3600 2250
F 0 "U1" H 3600 2350 50  0000 C CNN
F 1 "ATmega328P-AU" H 3550 2250 50  0000 C CNN
F 2 "Package_QFP:TQFP-32_7x7mm_P0.8mm" H 3600 2250 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega328_P%20AVR%20MCU%20with%20picoPower%20Technology%20Data%20Sheet%2040001984A.pdf" H 3600 2250 50  0001 C CNN
	1    3600 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 1050 2950 1050
$Comp
L power:GND #PWR07
U 1 1 65FF6636
P 2600 1050
F 0 "#PWR07" H 2600 800 50  0001 C CNN
F 1 "GND" H 2605 877 50  0000 C CNN
F 2 "" H 2600 1050 50  0001 C CNN
F 3 "" H 2600 1050 50  0001 C CNN
	1    2600 1050
	0    1    1    0   
$EndComp
Wire Wire Line
	2600 1050 2650 1050
$Comp
L Device:R R15
U 1 1 608269B9
P 7000 850
F 0 "R15" V 6793 850 50  0000 C CNN
F 1 "25K5" V 6884 850 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 6930 850 50  0001 C CNN
F 3 "~" H 7000 850 50  0001 C CNN
	1    7000 850 
	0    1    1    0   
$EndComp
Text Notes 4250 4700 0    50   ~ 0
The modem runs with 5V assuming a regulated supply.\nOnly use 3V3 output UART voltages to protect the other\nside which might run with 3V3.
Text GLabel 3750 4400 0    50   Input ~ 0
RX5
Text GLabel 3950 4400 2    50   Input ~ 0
RX3V3
Wire Wire Line
	3750 4400 3950 4400
Text GLabel 4200 5000 2    50   Input ~ 0
TX3V3
Text GLabel 3750 4700 0    50   Input ~ 0
TX5
$Comp
L Device:R R8
U 1 1 67D5456A
P 3900 4850
F 0 "R8" H 3750 4750 50  0000 C CNN
F 1 "10K" H 3784 4850 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 3830 4850 50  0001 C CNN
F 3 "~" H 3900 4850 50  0001 C CNN
	1    3900 4850
	-1   0    0    1   
$EndComp
$Comp
L Device:R R9
U 1 1 67D54D0C
P 3900 5150
F 0 "R9" H 3750 5250 50  0000 C CNN
F 1 "20K" H 3784 5150 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 3830 5150 50  0001 C CNN
F 3 "~" H 3900 5150 50  0001 C CNN
	1    3900 5150
	-1   0    0    1   
$EndComp
Wire Wire Line
	3750 4700 3900 4700
Wire Wire Line
	3900 5000 4200 5000
Connection ~ 3900 5000
$Comp
L power:GND #PWR010
U 1 1 67D5C2B1
P 3900 5300
F 0 "#PWR010" H 3900 5050 50  0001 C CNN
F 1 "GND" H 3905 5127 50  0000 C CNN
F 2 "" H 3900 5300 50  0001 C CNN
F 3 "" H 3900 5300 50  0001 C CNN
	1    3900 5300
	1    0    0    -1  
$EndComp
Text Notes 4150 5500 0    50   ~ 0
If other side has 10K pullup, then need low-enough resistance to maintain 3V3.\nDo not use UART pullups on either side, no noise when connected together.\nAllows lower power wasted.\n5V over 3*1K = 1.67 mA\n5V over 3*10K = 0.167 mA
Text Notes 3750 4300 0    50   ~ 0
Incoming 3V3 UART works without conversion
$Comp
L Device:R R4
U 1 1 67CEBB95
P 2450 4350
F 0 "R4" H 2520 4396 50  0000 L CNN
F 1 "20K" H 2520 4305 50  0000 L CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 2380 4350 50  0001 C CNN
F 3 "~" H 2450 4350 50  0001 C CNN
	1    2450 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	1200 5100 1300 5100
Text Notes 600  5550 0    50   ~ 0
No RX pullups because we don't have 3V3 for the other side.
Wire Wire Line
	2600 3850 2450 3850
Wire Wire Line
	2450 3850 2450 3900
$Comp
L power:GND #PWR06
U 1 1 67CF6EF2
P 2450 4500
F 0 "#PWR06" H 2450 4250 50  0001 C CNN
F 1 "GND" H 2455 4327 50  0000 C CNN
F 2 "" H 2450 4500 50  0001 C CNN
F 3 "" H 2450 4500 50  0001 C CNN
	1    2450 4500
	1    0    0    -1  
$EndComp
Text Notes 900  4050 0    50   ~ 0
Use resistor ladder to generate 3V3
Text Notes 1350 6150 0    50   ~ 0
Based on https://www.instructables.com/The-Gladys-Hydrophone/ dual 9V version
$Comp
L Device:R R12
U 1 1 67D0282B
P 5400 7100
F 0 "R12" H 5300 7200 50  0000 C CNN
F 1 "10K" H 5284 7100 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 5330 7100 50  0001 C CNN
F 3 "~" H 5400 7100 50  0001 C CNN
	1    5400 7100
	-1   0    0    1   
$EndComp
$Comp
L Device:R R11
U 1 1 67D07C08
P 5400 6600
F 0 "R11" H 5300 6700 50  0000 C CNN
F 1 "10K" H 5284 6600 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 5330 6600 50  0001 C CNN
F 3 "~" H 5400 6600 50  0001 C CNN
	1    5400 6600
	-1   0    0    1   
$EndComp
$Comp
L Device:R R10
U 1 1 67D07F8E
P 4250 7450
F 0 "R10" V 4043 7450 50  0000 C CNN
F 1 "10K" V 4134 7450 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 4180 7450 50  0001 C CNN
F 3 "~" H 4250 7450 50  0001 C CNN
	1    4250 7450
	0    1    1    0   
$EndComp
$Comp
L Connector_Generic:Conn_01x02 PIEZO0
U 1 1 67D0F5A9
P 2200 6550
F 0 "PIEZO0" V 2200 6400 50  0000 R CNN
F 1 "Piezo" V 2300 6600 50  0000 R CNN
F 2 "custom:WP_PinSocket_1x02_P2.54mm_Vertical" H 2200 6550 50  0001 C CNN
F 3 "~" H 2200 6550 50  0001 C CNN
	1    2200 6550
	0    -1   -1   0   
$EndComp
Text GLabel 6100 6700 2    50   Input ~ 0
ANALOG0
Text Notes 1350 6350 0    50   ~ 0
Protection circuit from piezo spikes, use Schottky diodes\nOutput impedance 50 ohm, input impedance 1 Mohm
Text GLabel 4250 1950 2    50   Input ~ 0
ANALOG0
Wire Wire Line
	4200 1950 4250 1950
NoConn ~ 4200 2250
NoConn ~ 4200 2350
NoConn ~ 4200 2450
$Comp
L Amplifier_Operational:OPA1641 OPA1641
U 1 1 67FF95DC
P 4050 6850
F 0 "OPA1641" H 4050 6700 50  0000 L CNN
F 1 "OPA1641AQDGKRQ1" H 3650 7150 50  0000 L CNN
F 2 "Package_SO:VSSOP-8_3.0x3.0mm_P0.65mm" H 4050 6850 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/opa1641.pdf" H 4050 6850 50  0001 C CNN
	1    4050 6850
	1    0    0    -1  
$EndComp
Text GLabel 4000 6450 2    50   Input ~ 0
5V-In
$Comp
L power:GND #PWR011
U 1 1 680016CF
P 3950 7150
F 0 "#PWR011" H 3950 6900 50  0001 C CNN
F 1 "GND" H 3955 6977 50  0000 C CNN
F 2 "" H 3950 7150 50  0001 C CNN
F 3 "" H 3950 7150 50  0001 C CNN
	1    3950 7150
	1    0    0    -1  
$EndComp
$Comp
L Device:C C7
U 1 1 68004CCF
P 5100 6850
F 0 "C7" V 4848 6850 50  0000 C CNN
F 1 "22uF" V 4939 6850 50  0000 C CNN
F 2 "custom:WP_C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 5138 6700 50  0001 C CNN
F 3 "~" H 5100 6850 50  0001 C CNN
	1    5100 6850
	0    1    1    0   
$EndComp
Wire Wire Line
	4350 6850 4500 6850
$Comp
L Device:R R7
U 1 1 680124F8
P 3700 7650
F 0 "R7" H 3600 7750 50  0000 C CNN
F 1 "1K" H 3584 7650 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 3630 7650 50  0001 C CNN
F 3 "~" H 3700 7650 50  0001 C CNN
	1    3700 7650
	-1   0    0    1   
$EndComp
Wire Wire Line
	4850 6850 4900 6850
Wire Wire Line
	4400 7450 4500 7450
Wire Wire Line
	4500 6850 4500 7450
Wire Wire Line
	4100 7450 3700 7450
Wire Wire Line
	3700 7450 3700 7500
Wire Wire Line
	3750 6950 3700 6950
Wire Wire Line
	3700 6950 3700 7450
Connection ~ 3700 7450
$Comp
L Device:R R6
U 1 1 680316A2
P 3300 6750
F 0 "R6" V 3050 6750 50  0000 C CNN
F 1 "1K" V 3184 6750 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 3230 6750 50  0001 C CNN
F 3 "~" H 3300 6750 50  0001 C CNN
	1    3300 6750
	0    1    1    0   
$EndComp
Wire Wire Line
	3500 6750 3450 6750
Wire Wire Line
	3500 6750 3750 6750
Connection ~ 3500 6750
Text GLabel 3150 7000 2    50   Input ~ 0
5V-In
Wire Wire Line
	3150 7000 3100 7000
$Comp
L Device:R R5
U 1 1 68045395
P 2700 6950
F 0 "R5" H 2600 7050 50  0000 C CNN
F 1 "1M" H 2584 6950 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 2630 6950 50  0001 C CNN
F 3 "~" H 2700 6950 50  0001 C CNN
	1    2700 6950
	-1   0    0    1   
$EndComp
Text GLabel 3750 7900 2    50   Input ~ 0
Vmid
Wire Wire Line
	3750 7900 3700 7900
Wire Wire Line
	3700 7800 3700 7900
$Comp
L power:GND #PWR08
U 1 1 6804B8C6
P 3100 7750
F 0 "#PWR08" H 3100 7500 50  0001 C CNN
F 1 "GND" H 3105 7577 50  0000 C CNN
F 2 "" H 3100 7750 50  0001 C CNN
F 3 "" H 3100 7750 50  0001 C CNN
	1    3100 7750
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 6750 3500 7400
Text GLabel 2650 7200 0    50   Input ~ 0
Vmid
Wire Wire Line
	2650 7200 2700 7200
Wire Wire Line
	2700 7200 2700 7100
Wire Wire Line
	3150 6750 2700 6750
Wire Wire Line
	2700 6750 2700 6800
Wire Wire Line
	2300 6750 2700 6750
Connection ~ 2700 6750
$Comp
L power:GND #PWR05
U 1 1 6805F0FF
P 2200 6850
F 0 "#PWR05" H 2200 6600 50  0001 C CNN
F 1 "GND" H 2205 6677 50  0000 C CNN
F 2 "" H 2200 6850 50  0001 C CNN
F 3 "" H 2200 6850 50  0001 C CNN
	1    2200 6850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 6850 2200 6750
Wire Wire Line
	5400 6750 5400 6850
Wire Wire Line
	5400 6850 5250 6850
Wire Wire Line
	5400 6850 5400 6950
Connection ~ 5400 6850
Text GLabel 5450 6400 2    50   Input ~ 0
5V-In
Wire Wire Line
	5450 6400 5400 6400
Wire Wire Line
	5400 6400 5400 6450
$Comp
L power:GND #PWR014
U 1 1 6808701B
P 5400 7300
F 0 "#PWR014" H 5400 7050 50  0001 C CNN
F 1 "GND" H 5405 7127 50  0000 C CNN
F 2 "" H 5400 7300 50  0001 C CNN
F 3 "" H 5400 7300 50  0001 C CNN
	1    5400 7300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5400 7300 5400 7250
Text GLabel 1700 6950 2    50   Input ~ 0
5V-In
Text GLabel 750  7300 0    50   Input ~ 0
Vmid
$Comp
L Device:R R1
U 1 1 680A002F
P 800 7100
F 0 "R1" H 700 7200 50  0000 C CNN
F 1 "47K" H 684 7100 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 730 7100 50  0001 C CNN
F 3 "~" H 800 7100 50  0001 C CNN
	1    800  7100
	-1   0    0    1   
$EndComp
$Comp
L Device:R R2
U 1 1 680A0A1D
P 800 7500
F 0 "R2" H 700 7600 50  0000 C CNN
F 1 "47K" H 684 7500 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 730 7500 50  0001 C CNN
F 3 "~" H 800 7500 50  0001 C CNN
	1    800  7500
	-1   0    0    1   
$EndComp
Wire Wire Line
	800  7250 800  7300
Wire Wire Line
	800  7300 750  7300
Wire Wire Line
	800  7300 800  7350
Connection ~ 800  7300
$Comp
L power:GND #PWR02
U 1 1 680AC7F1
P 1200 7700
F 0 "#PWR02" H 1200 7450 50  0001 C CNN
F 1 "GND" H 1205 7527 50  0000 C CNN
F 2 "" H 1200 7700 50  0001 C CNN
F 3 "" H 1200 7700 50  0001 C CNN
	1    1200 7700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1200 7700 1200 7650
Wire Wire Line
	1200 7650 800  7650
$Comp
L Device:C C2
U 1 1 680A13E2
P 1700 7300
F 0 "C2" H 1650 7400 50  0000 C CNN
F 1 "0.1uF" H 1500 7300 50  0000 C CNN
F 2 "custom:WP_C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 1738 7150 50  0001 C CNN
F 3 "~" H 1700 7300 50  0001 C CNN
	1    1700 7300
	-1   0    0    1   
$EndComp
Connection ~ 1200 7650
$Comp
L Device:C C1
U 1 1 680A1DA2
P 1200 7500
F 0 "C1" H 1150 7600 50  0000 C CNN
F 1 "22uF" H 1000 7500 50  0000 C CNN
F 2 "custom:WP_C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 1238 7350 50  0001 C CNN
F 3 "~" H 1200 7500 50  0001 C CNN
	1    1200 7500
	-1   0    0    1   
$EndComp
Wire Wire Line
	1200 7350 1200 7300
Wire Wire Line
	1200 7300 800  7300
$Comp
L power:GND #PWR03
U 1 1 680D9BCB
P 1700 7700
F 0 "#PWR03" H 1700 7450 50  0001 C CNN
F 1 "GND" H 1705 7527 50  0000 C CNN
F 2 "" H 1700 7700 50  0001 C CNN
F 3 "" H 1700 7700 50  0001 C CNN
	1    1700 7700
	1    0    0    -1  
$EndComp
Wire Wire Line
	800  6950 1700 6950
Wire Wire Line
	1700 7700 1700 7450
Wire Wire Line
	1700 7150 1700 6950
Text Notes 1350 6000 0    50   ~ 0
https://electronics.stackexchange.com/questions/625058/safely-connect-audio-line-level-input-to-adc\nLine-In example similar except used 10 uF capacitor and 100K resistor divider
$Comp
L Connector_Generic:Conn_01x02 LINE0
U 1 1 6812DCFB
P 4800 6150
F 0 "LINE0" V 4800 6000 50  0000 R CNN
F 1 "LineIn" V 4900 6200 50  0000 R CNN
F 2 "custom:WP_PinSocket_1x02_P2.54mm_Vertical" H 4800 6150 50  0001 C CNN
F 3 "~" H 4800 6150 50  0001 C CNN
	1    4800 6150
	0    -1   -1   0   
$EndComp
$Comp
L Jumper:SolderJumper_2_Open EN1
U 1 1 6814534F
P 4700 6850
F 0 "EN1" H 4700 7055 50  0000 C CNN
F 1 "LineInJumper" H 4700 6964 50  0000 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 4700 6850 50  0001 C CNN
F 3 "~" H 4700 6850 50  0001 C CNN
	1    4700 6850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 6350 4900 6850
Connection ~ 4900 6850
Wire Wire Line
	4900 6850 4950 6850
$Comp
L power:GND #PWR012
U 1 1 68186CD1
P 4800 6350
F 0 "#PWR012" H 4800 6100 50  0001 C CNN
F 1 "GND" H 4805 6177 50  0000 C CNN
F 2 "" H 4800 6350 50  0001 C CNN
F 3 "" H 4800 6350 50  0001 C CNN
	1    4800 6350
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 6850 4500 6850
Connection ~ 4500 6850
$Comp
L Connector_Generic:Conn_01x02 ADC0
U 1 1 681A860E
P 5850 6200
F 0 "ADC0" V 5850 6050 50  0000 R CNN
F 1 "ADC-Debug" V 5950 6250 50  0000 R CNN
F 2 "custom:WP_PinSocket_1x02_P2.54mm_Vertical" H 5850 6200 50  0001 C CNN
F 3 "~" H 5850 6200 50  0001 C CNN
	1    5850 6200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5400 6850 5950 6850
Wire Wire Line
	5950 6400 5950 6850
Connection ~ 5950 6850
$Comp
L power:GND #PWR015
U 1 1 681B1202
P 5850 6400
F 0 "#PWR015" H 5850 6150 50  0001 C CNN
F 1 "GND" H 5855 6227 50  0000 C CNN
F 2 "" H 5850 6400 50  0001 C CNN
F 3 "" H 5850 6400 50  0001 C CNN
	1    5850 6400
	1    0    0    -1  
$EndComp
Text Notes 4450 7950 0    50   ~ 0
KGM21AR51E226MU\nKYOCERA AVX\nCAP CER 22UF 25V X5R 0805\nRuns at 2.5V which is 10% of 25V capacity\nX5R is approx same as X7R but 85C vs 125C
Wire Wire Line
	3950 6550 3950 6450
Wire Wire Line
	3950 6450 4000 6450
Text Notes 4500 7100 0    50   ~ 0
Solder to use OpAmp\nDesolder for Line-In
$Comp
L Diode:BAS40-04 BAS1
U 1 1 6800584C
P 3200 7400
F 0 "BAS1" V 3246 7587 50  0000 L CNN
F 1 "BAS40-04" V 3155 7587 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 2950 7700 50  0001 L CNN
F 3 "http://www.vishay.com/docs/85701/bas40v.pdf" H 3080 7500 50  0001 C CNN
	1    3200 7400
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3300 7400 3500 7400
Wire Wire Line
	3100 7000 3100 7100
Wire Wire Line
	3100 7700 3100 7750
Text Notes 2050 7750 0    50   ~ 0
BAS40-04\nDIODE ARR SCHOTT 40V 200MA SOT23
$Comp
L power:GND #PWR016
U 1 1 5F1B24B0
P 6350 3450
F 0 "#PWR016" H 6350 3200 50  0001 C CNN
F 1 "GND" H 6355 3277 50  0000 C CNN
F 2 "" H 6350 3450 50  0001 C CNN
F 3 "" H 6350 3450 50  0001 C CNN
	1    6350 3450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R13
U 1 1 5F1F9AD1
P 5450 2350
F 0 "R13" V 5243 2350 50  0000 C CNN
F 1 "4K7" V 5334 2350 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 5380 2350 50  0001 C CNN
F 3 "~" H 5450 2350 50  0001 C CNN
	1    5450 2350
	0    1    1    0   
$EndComp
Text GLabel 6050 1550 0    50   Input ~ 0
12V-In
$Comp
L Device:R R16
U 1 1 5F7CDCF8
P 7600 2650
F 0 "R16" H 7670 2696 50  0000 L CNN
F 1 "78K7" H 7670 2605 50  0000 L CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 7530 2650 50  0001 C CNN
F 3 "~" H 7600 2650 50  0001 C CNN
	1    7600 2650
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D3
U 1 1 5F7D0F82
P 7600 3100
F 0 "D3" V 7639 2982 50  0000 R CNN
F 1 "12V" V 7548 2982 50  0000 R CNN
F 2 "custom:WP_LED_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 7600 3100 50  0001 C CNN
F 3 "~" H 7600 3100 50  0001 C CNN
	1    7600 3100
	0    -1   -1   0   
$EndComp
Text GLabel 8300 2400 2    50   Input ~ 0
12V-Sw
$Comp
L Diode:1N4007 D1
U 1 1 5F79C0C4
P 6950 2900
F 0 "D1" V 6904 2979 50  0000 L CNN
F 1 "1N4007" V 6995 2979 50  0000 L CNN
F 2 "custom:WP_D_SOD-123" H 6950 2725 50  0001 C CNN
F 3 "http://www.vishay.com/docs/88503/1n4001.pdf" H 6950 2900 50  0001 C CNN
	1    6950 2900
	0    1    1    0   
$EndComp
$Comp
L Transistor_BJT:MMBT3904 Q1
U 1 1 5F79EF93
P 6000 2350
F 0 "Q1" H 6191 2396 50  0000 L CNN
F 1 "MMBT3904" H 6191 2305 50  0000 L CNN
F 2 "custom:WP_SOT-23" H 6200 2275 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N3904.pdf" H 6000 2350 50  0001 L CNN
	1    6000 2350
	1    0    0    -1  
$EndComp
$Comp
L custom:WP_FQP47P06 Q2
U 1 1 5F7A4116
P 6550 2100
F 0 "Q2" H 7068 2146 50  0000 L CNN
F 1 "SUP60061EL" H 7000 1900 50  0000 L CNN
F 2 "custom:WP_MOSFET_TO-220-3_Vertical" H 6550 2600 50  0001 L CNN
F 3 "https://www.mouser.com/datasheet/2/308/1/FQP47P06_D-2313837.pdf" H 6550 2700 50  0001 L CNN
F 4 "Trans" H 6550 2800 50  0001 L CNN "category"
F 5 "MOSFET P-CH 60V 47A TO-220" H 6550 2900 50  0001 L CNN "digikey description"
F 6 "FQP47P06-ND" H 6550 3000 50  0001 L CNN "digikey part number"
F 7 "TO-220" H 6550 3100 50  0001 L CNN "ipc land pattern name"
F 8 "yes" H 6550 3200 50  0001 L CNN "lead free"
F 9 "acd61957a0d81163" H 6550 3300 50  0001 L CNN "library id"
F 10 "Fairchild" H 6550 3400 50  0001 L CNN "manufacturer"
F 11 "512-FQP47P06" H 6550 3500 50  0001 L CNN "mouser part number"
F 12 "TO220B03" H 6550 3600 50  0001 L CNN "package"
F 13 "yes" H 6550 3700 50  0001 L CNN "rohs"
F 14 "+175°C" H 6550 3800 50  0001 L CNN "temperature range high"
F 15 "-55°C" H 6550 3900 50  0001 L CNN "temperature range low"
	1    6550 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	5800 2350 5600 2350
$Comp
L Device:R R14
U 1 1 5F8FF5E2
P 6100 1850
F 0 "R14" V 5893 1850 50  0000 C CNN
F 1 "100K" V 5984 1850 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 6030 1850 50  0001 C CNN
F 3 "~" H 6100 1850 50  0001 C CNN
	1    6100 1850
	-1   0    0    1   
$EndComp
Wire Wire Line
	6100 1550 6100 1700
Wire Wire Line
	6100 2000 6100 2100
Wire Wire Line
	6650 2100 6100 2100
Connection ~ 6100 2100
Wire Wire Line
	6100 2100 6100 2150
Wire Wire Line
	6100 1550 6950 1550
Wire Wire Line
	6950 1900 6950 1550
Wire Wire Line
	6050 1550 6100 1550
Connection ~ 6100 1550
Wire Wire Line
	6950 2400 6950 2300
Wire Wire Line
	6950 2750 6950 2400
Connection ~ 6950 2400
Wire Wire Line
	6950 3050 6950 3400
Wire Wire Line
	7600 2800 7600 2950
Wire Wire Line
	7600 3250 7600 3400
Wire Wire Line
	6950 2400 7600 2400
Wire Wire Line
	7600 2500 7600 2400
Connection ~ 7600 2400
Wire Wire Line
	6950 3400 7600 3400
Connection ~ 6950 3400
Wire Wire Line
	6100 3400 6350 3400
Wire Wire Line
	6100 2550 6100 3400
Wire Wire Line
	6350 3450 6350 3400
Connection ~ 6350 3400
Wire Wire Line
	6350 3400 6950 3400
$Comp
L custom:WP_RS232_Conn_01x05 UART0
U 1 1 681B480A
P 1500 5000
F 0 "UART0" H 1669 5050 50  0000 L CNN
F 1 "Uart0" H 1669 4959 50  0000 L CNN
F 2 "custom:WP_Serial_5P_M" H 1500 5000 50  0001 C CNN
F 3 "~" H 1500 5000 50  0001 C CNN
	1    1500 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 2400 8300 2400
Text Notes 6400 1900 0    50   ~ 0
R2 = 100K instead of original 1K\n100K is 0.12mA but 1K is 12mA\n1/8W 0805 resistors cannot handle 12mA\nMOSFET only needs small current to activate\nDo not use for fast PWM, may not be fast enough
Text Notes 4850 2900 0    50   ~ 0
R1 = 560ohm is currently 4mA. Recalculated to use 0.4mA,\nI(R2) >= I(R1) * 10 == 5875 ohms.\nRounded to nearest 4K7 which is close enough.\nUse 100K to limit collector current.
Text Notes 2050 5400 0    50   ~ 0
5-pin male plug for flash from PC.\nNo flip here because the colors and\nlabels are assuming a male plug. Can\nconnect to FTDI adapter for programming.
Text GLabel 5100 2350 0    50   Input ~ 0
MOSFET0
Text GLabel 8550 1400 0    50   Input ~ 0
SENSE0
Text GLabel 8500 650  0    50   Output ~ 0
5V-In
$Comp
L Device:R R17
U 1 1 6601D7FE
P 8750 800
F 0 "R17" H 8600 850 50  0000 C CNN
F 1 "10K" H 8600 750 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 8680 800 50  0001 C CNN
F 3 "~" H 8750 800 50  0001 C CNN
	1    8750 800 
	-1   0    0    1   
$EndComp
Text Notes 10500 1450 2    50   ~ 0
Measure water conduction, or a switch.\nCan use to trigger the release manually.
$Comp
L Connector_Generic:Conn_01x02 SENSE0
U 1 1 6603E39B
P 9450 1000
F 0 "SENSE0" H 9530 992 50  0000 L CNN
F 1 "Sense0" H 9530 901 50  0000 L CNN
F 2 "custom:WP_Power_PinHeader_1x02_P2.54mm_Vertical" H 9450 1000 50  0001 C CNN
F 3 "~" H 9450 1000 50  0001 C CNN
	1    9450 1000
	1    0    0    -1  
$EndComp
$Comp
L custom:WP_Power_Conn_01x02 VBAT0
U 1 1 67D64F4C
P 9400 2900
F 0 "VBAT0" H 9568 2900 50  0000 L CNN
F 1 "12V" H 9568 2809 50  0000 L CNN
F 2 "custom:WP_TerminalBlock_16AWG_bornier-2_P5.08mm" H 9400 2900 50  0001 C CNN
F 3 "~" H 9400 2900 50  0001 C CNN
	1    9400 2900
	1    0    0    -1  
$EndComp
Text GLabel 9200 2900 0    50   BiDi ~ 0
12V-In
$Comp
L power:GND #PWR019
U 1 1 67D6CD0F
P 8900 3000
F 0 "#PWR019" H 8900 2750 50  0001 C CNN
F 1 "GND" H 8905 2827 50  0000 C CNN
F 2 "" H 8900 3000 50  0001 C CNN
F 3 "" H 8900 3000 50  0001 C CNN
	1    8900 3000
	0    1    1    0   
$EndComp
Wire Wire Line
	8900 3000 9200 3000
Text Notes 8850 2800 0    50   ~ 0
XT90 to battery
$Comp
L Device:C C?
U 1 1 613F7D4A
P 8200 4950
AR Path="/613EEE93/613F7D4A" Ref="C?"  Part="1" 
AR Path="/613F7D4A" Ref="C8"  Part="1" 
F 0 "C8" H 8315 4996 50  0000 L CNN
F 1 "2u2" H 8315 4905 50  0000 L CNN
F 2 "custom:WP_C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 8238 4800 50  0001 C CNN
F 3 "http://datasheets.avx.com/X7RDielectric.pdf" H 8200 4950 50  0001 C CNN
F 4 "https://www.digikey.com/product-detail/en/avx-corporation/08055C104KAT2A/478-1395-1-ND/564427" H 8200 4950 50  0001 C CNN "Digikey"
F 5 "08055C104KAT2A" H 8200 4950 50  0001 C CNN "Part"
F 6 "0.1µF ±10% 50V Ceramic Capacitor X7R 0805 (2012 Metric)" H 8200 4950 50  0001 C CNN "Description"
	1    8200 4950
	1    0    0    -1  
$EndComp
$Comp
L custom:MCP1792T-3302H_CB U?
U 1 1 613F7D50
P 8300 4800
AR Path="/613EEE93/613F7D50" Ref="U?"  Part="1" 
AR Path="/613F7D50" Ref="U2"  Part="1" 
F 0 "U2" H 9100 4900 60  0000 C CNN
F 1 "MCP1792T-5" H 9100 5081 60  0000 C CNN
F 2 "custom:WP_SOT-23" H 9100 5040 60  0001 C CNN
F 3 "" H 8300 4800 60  0000 C CNN
	1    8300 4800
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 613F7D59
P 10000 4950
AR Path="/613EEE93/613F7D59" Ref="C?"  Part="1" 
AR Path="/613F7D59" Ref="C10"  Part="1" 
F 0 "C10" H 10115 4996 50  0000 L CNN
F 1 "2.2uF" H 10115 4905 50  0000 L CNN
F 2 "custom:WP_C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 10038 4800 50  0001 C CNN
F 3 "http://datasheets.avx.com/X7RDielectric.pdf" H 10000 4950 50  0001 C CNN
F 4 "https://www.digikey.com/product-detail/en/avx-corporation/08055C104KAT2A/478-1395-1-ND/564427" H 10000 4950 50  0001 C CNN "Digikey"
F 5 "08055C104KAT2A" H 10000 4950 50  0001 C CNN "Part"
F 6 "0.1µF ±10% 50V Ceramic Capacitor X7R 0805 (2012 Metric)" H 10000 4950 50  0001 C CNN "Description"
	1    10000 4950
	1    0    0    -1  
$EndComp
Text GLabel 8100 4700 0    50   BiDi ~ 0
12V-In
Text GLabel 10100 4700 2    50   BiDi ~ 0
5V-In
Wire Wire Line
	9900 4700 10000 4700
Wire Wire Line
	10000 4800 10000 4700
Connection ~ 10000 4700
Wire Wire Line
	10000 4700 10100 4700
Wire Wire Line
	8200 4800 8200 4700
Wire Wire Line
	8200 4700 8300 4700
Wire Wire Line
	8200 4700 8100 4700
Connection ~ 8200 4700
Wire Wire Line
	10000 5100 10000 5400
Wire Wire Line
	10000 5400 9100 5400
Wire Wire Line
	9100 5400 8200 5400
Wire Wire Line
	8200 5400 8200 5100
Connection ~ 9100 5400
$Comp
L power:GND #PWR?
U 1 1 613F7D6E
P 9100 5450
AR Path="/613EEE93/613F7D6E" Ref="#PWR?"  Part="1" 
AR Path="/613F7D6E" Ref="#PWR021"  Part="1" 
F 0 "#PWR021" H 9100 5200 50  0001 C CNN
F 1 "GND" H 9105 5277 50  0000 C CNN
F 2 "" H 9100 5450 50  0001 C CNN
F 3 "" H 9100 5450 50  0001 C CNN
	1    9100 5450
	1    0    0    -1  
$EndComp
Wire Wire Line
	9100 5450 9100 5400
Text Notes 8700 4850 0    50   ~ 0
MCP1792T-5002H_CB
Text Notes 8850 4350 0    50   ~ 0
Schottky Diode, SD0805S040S0R1\n40V 100MA 0805, Vf=0.4V-0.5V
Text Notes 7500 6400 0    50   ~ 0
This PCB can be optionally powered with the UART cable and 5V input.\nNeed Schottky across MCP1792T-5 to prevent reverse current through it,\nand allow 5V in to appear on 12V-In.\nIt worked without the Schottky, but probably not safe to use this long term.\nWith Schottky, there will be 4.5V on the 12V-In label on the whole board\n(but not used for peripheral UART device)\n\nDO NOT CONNECT BOTH 12V AND UART POWER SIMULTANEOUSLY!
$Comp
L Device:D_Schottky D4
U 1 1 6154626D
P 8450 4400
F 0 "D4" H 8450 4616 50  0000 C CNN
F 1 "SD0805S040S0R1" H 8450 4525 50  0000 C CNN
F 2 "custom:WP_LED_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 8450 4400 50  0001 C CNN
F 3 "http://datasheets.avx.com/schottky.pdf" H 8450 4400 50  0001 C CNN
F 4 "DIODE SCHOTTKY 40V 100MA 0805" H 8450 4400 50  0001 C CNN "Description"
	1    8450 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8600 4400 10000 4400
Wire Wire Line
	10000 4400 10000 4700
Wire Wire Line
	8300 4400 8200 4400
Wire Wire Line
	8200 4400 8200 4700
$Comp
L custom:WP_Power_Conn_01x02 SW0
U 1 1 67D06698
P 9400 3350
F 0 "SW0" H 9568 3350 50  0000 L CNN
F 1 "12V" H 9568 3259 50  0000 L CNN
F 2 "custom:WP_TerminalBlock_16AWG_bornier-2_P5.08mm" H 9400 3350 50  0001 C CNN
F 3 "~" H 9400 3350 50  0001 C CNN
	1    9400 3350
	1    0    0    -1  
$EndComp
Text GLabel 9200 3350 0    50   BiDi ~ 0
12V-Sw
$Comp
L power:GND #PWR020
U 1 1 67D067C9
P 8900 3450
F 0 "#PWR020" H 8900 3200 50  0001 C CNN
F 1 "GND" H 8905 3277 50  0000 C CNN
F 2 "" H 8900 3450 50  0001 C CNN
F 3 "" H 8900 3450 50  0001 C CNN
	1    8900 3450
	0    1    1    0   
$EndComp
Wire Wire Line
	8900 3450 9200 3450
Text Notes 8650 3250 0    50   ~ 0
To Nichrome Wire Release (high current)
$Comp
L Device:R R18
U 1 1 67D7EE75
P 8750 1200
F 0 "R18" H 8600 1250 50  0000 C CNN
F 1 "47K" H 8600 1150 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 8680 1200 50  0001 C CNN
F 3 "~" H 8750 1200 50  0001 C CNN
	1    8750 1200
	-1   0    0    1   
$EndComp
Wire Wire Line
	8500 650  8750 650 
$Comp
L power:GND #PWR018
U 1 1 67D8BA42
P 8750 1800
F 0 "#PWR018" H 8750 1550 50  0001 C CNN
F 1 "GND" H 8755 1627 50  0000 C CNN
F 2 "" H 8750 1800 50  0001 C CNN
F 3 "" H 8750 1800 50  0001 C CNN
	1    8750 1800
	1    0    0    -1  
$EndComp
$Comp
L Device:C C9
U 1 1 67D8C8B8
P 8750 1600
F 0 "C9" V 8498 1600 50  0000 C CNN
F 1 "0.1uF" V 8589 1600 50  0000 C CNN
F 2 "custom:WP_C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 8788 1450 50  0001 C CNN
F 3 "~" H 8750 1600 50  0001 C CNN
	1    8750 1600
	-1   0    0    1   
$EndComp
Wire Wire Line
	9250 1000 8750 1000
Wire Wire Line
	8750 1000 8750 950 
Wire Wire Line
	8750 1000 8750 1050
Connection ~ 8750 1000
Wire Wire Line
	8750 1350 8750 1400
Wire Wire Line
	8750 1400 8550 1400
Connection ~ 8750 1400
Wire Wire Line
	8750 1400 8750 1450
Wire Wire Line
	8750 1750 8750 1800
Wire Wire Line
	9250 1100 9250 1750
Wire Wire Line
	9250 1750 8750 1750
Connection ~ 8750 1750
Text Notes 7200 2200 0    50   ~ 0
P-MOSFET part numbers:\nSUP60061EL = 30 amps DC\nFQP47P06 = 10 amps DC
Wire Wire Line
	5100 2350 5300 2350
Text GLabel 4250 2050 2    50   Input ~ 0
MOSFET0
Wire Wire Line
	4250 2050 4200 2050
Text GLabel 4250 2150 2    50   Input ~ 0
SENSE0
Wire Wire Line
	4200 2150 4250 2150
Wire Wire Line
	6100 6700 6050 6700
Wire Wire Line
	6050 6700 6050 6850
Wire Wire Line
	5950 6850 6050 6850
$EndSCHEMATC
