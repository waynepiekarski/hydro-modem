EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 1 1
Title "HydroModem - MOSFET Release ATmega328p 3V3 8MHz"
Date "2025-03-16"
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
Text GLabel 4250 2450 2    50   Input ~ 0
SCL
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
$Comp
L power:GND #PWR0104
U 1 1 5F1B24B0
P 6450 3150
F 0 "#PWR0104" H 6450 2900 50  0001 C CNN
F 1 "GND" H 6455 2977 50  0000 C CNN
F 2 "" H 6450 3150 50  0001 C CNN
F 3 "" H 6450 3150 50  0001 C CNN
	1    6450 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 5F1F9AD1
P 5550 2050
F 0 "R5" V 5343 2050 50  0000 C CNN
F 1 "4K7" V 5434 2050 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 5480 2050 50  0001 C CNN
F 3 "~" H 5550 2050 50  0001 C CNN
	1    5550 2050
	0    1    1    0   
$EndComp
$Comp
L custom:WP_I2C_Output_01x04 J4
U 1 1 5F778407
P 9450 3000
F 0 "J4" H 9250 3200 50  0000 L CNN
F 1 "OUT0a" H 9350 3200 50  0000 L CNN
F 2 "custom:WP_I2C_PinHeader_1x04_P2.54mm_Vertical_Compact_Labels" H 9450 3000 50  0001 C CNN
F 3 "~" H 9450 3000 50  0001 C CNN
	1    9450 3000
	1    0    0    -1  
$EndComp
Text GLabel 9200 2900 0    50   Input ~ 0
12V-In
Text GLabel 6150 1250 0    50   Input ~ 0
12V-In
$Comp
L Device:R R10
U 1 1 5F7CDCF8
P 7700 2350
F 0 "R10" H 7770 2396 50  0000 L CNN
F 1 "78K7" H 7770 2305 50  0000 L CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 7630 2350 50  0001 C CNN
F 3 "~" H 7700 2350 50  0001 C CNN
	1    7700 2350
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D1
U 1 1 5F7D0F82
P 7700 2800
F 0 "D1" V 7739 2682 50  0000 R CNN
F 1 "12V" V 7648 2682 50  0000 R CNN
F 2 "custom:WP_LED_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 7700 2800 50  0001 C CNN
F 3 "~" H 7700 2800 50  0001 C CNN
	1    7700 2800
	0    -1   -1   0   
$EndComp
Text GLabel 8400 2100 2    50   Input ~ 0
12V-Sw
$Comp
L Diode:1N4007 D3
U 1 1 5F79C0C4
P 7050 2600
F 0 "D3" V 7004 2679 50  0000 L CNN
F 1 "1N4007" V 7095 2679 50  0000 L CNN
F 2 "custom:WP_D_SOD-123" H 7050 2425 50  0001 C CNN
F 3 "http://www.vishay.com/docs/88503/1n4001.pdf" H 7050 2600 50  0001 C CNN
	1    7050 2600
	0    1    1    0   
$EndComp
$Comp
L Transistor_BJT:MMBT3904 Q1
U 1 1 5F79EF93
P 6100 2050
F 0 "Q1" H 6291 2096 50  0000 L CNN
F 1 "MMBT3904" H 6291 2005 50  0000 L CNN
F 2 "custom:WP_SOT-23" H 6300 1975 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N3904.pdf" H 6100 2050 50  0001 L CNN
	1    6100 2050
	1    0    0    -1  
$EndComp
$Comp
L custom:WP_FQP47P06 Q2
U 1 1 5F7A4116
P 6650 1800
F 0 "Q2" H 7168 1846 50  0000 L CNN
F 1 "FQP47P06" H 7100 1600 50  0000 L CNN
F 2 "custom:WP_MOSFET_TO-220-3_Vertical" H 6650 2300 50  0001 L CNN
F 3 "https://www.mouser.com/datasheet/2/308/1/FQP47P06_D-2313837.pdf" H 6650 2400 50  0001 L CNN
F 4 "Trans" H 6650 2500 50  0001 L CNN "category"
F 5 "MOSFET P-CH 60V 47A TO-220" H 6650 2600 50  0001 L CNN "digikey description"
F 6 "FQP47P06-ND" H 6650 2700 50  0001 L CNN "digikey part number"
F 7 "TO-220" H 6650 2800 50  0001 L CNN "ipc land pattern name"
F 8 "yes" H 6650 2900 50  0001 L CNN "lead free"
F 9 "acd61957a0d81163" H 6650 3000 50  0001 L CNN "library id"
F 10 "Fairchild" H 6650 3100 50  0001 L CNN "manufacturer"
F 11 "512-FQP47P06" H 6650 3200 50  0001 L CNN "mouser part number"
F 12 "TO220B03" H 6650 3300 50  0001 L CNN "package"
F 13 "yes" H 6650 3400 50  0001 L CNN "rohs"
F 14 "+175°C" H 6650 3500 50  0001 L CNN "temperature range high"
F 15 "-55°C" H 6650 3600 50  0001 L CNN "temperature range low"
	1    6650 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	5900 2050 5700 2050
$Comp
L Device:R R9
U 1 1 5F8FF5E2
P 6200 1550
F 0 "R9" V 5993 1550 50  0000 C CNN
F 1 "100K" V 6084 1550 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 6130 1550 50  0001 C CNN
F 3 "~" H 6200 1550 50  0001 C CNN
	1    6200 1550
	-1   0    0    1   
$EndComp
Wire Wire Line
	6200 1250 6200 1400
Wire Wire Line
	6200 1700 6200 1800
Wire Wire Line
	6750 1800 6200 1800
Connection ~ 6200 1800
Wire Wire Line
	6200 1800 6200 1850
Wire Wire Line
	6200 1250 7050 1250
Wire Wire Line
	7050 1600 7050 1250
Wire Wire Line
	6150 1250 6200 1250
Connection ~ 6200 1250
Wire Wire Line
	7050 2100 7050 2000
Wire Wire Line
	7050 2450 7050 2100
Connection ~ 7050 2100
Wire Wire Line
	7050 2750 7050 3100
Wire Wire Line
	7700 2500 7700 2650
Wire Wire Line
	7700 2950 7700 3100
Wire Wire Line
	7050 2100 7700 2100
Wire Wire Line
	7700 2200 7700 2100
Connection ~ 7700 2100
Wire Wire Line
	7050 3100 7700 3100
Connection ~ 7050 3100
Wire Wire Line
	6200 3100 6450 3100
Text GLabel 4250 2350 2    50   Input ~ 0
SDA
Wire Wire Line
	4250 2350 4200 2350
Wire Wire Line
	4250 2450 4200 2450
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
	6200 2250 6200 3100
Wire Wire Line
	5400 2050 4200 2050
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
Text GLabel 9200 3100 0    50   UnSpc ~ 0
SCL
Text GLabel 9200 3200 0    50   UnSpc ~ 0
SDA
Wire Wire Line
	9250 2900 9200 2900
Wire Wire Line
	9200 3100 9250 3100
Wire Wire Line
	9250 3200 9200 3200
Wire Wire Line
	6450 3150 6450 3100
Connection ~ 6450 3100
Wire Wire Line
	6450 3100 7050 3100
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
F 1 "RS232" H 1669 4959 50  0000 L CNN
F 2 "custom:WP_Serial_5P_M" H 1500 5000 50  0001 C CNN
F 3 "~" H 1500 5000 50  0001 C CNN
	1    1500 5000
	1    0    0    -1  
$EndComp
Text GLabel 4250 2750 2    50   Input ~ 0
RX
Text GLabel 4250 2850 2    50   Input ~ 0
TX
Text Notes 3750 2800 0    50   ~ 0
RXD
Text Notes 3750 2900 0    50   ~ 0
TXD
Text GLabel 1200 5100 0    50   Input ~ 0
RX
Text GLabel 1200 5000 0    50   Input ~ 0
TX
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
F 1 "AB308-8.000MHZ" V 2850 1150 50  0000 L CNN
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
This board uses 3V3 and 8MHz for 500,000 bps.\n115,200 bps is not accurate at this frequency.\nUse 3V3 since this is a standard for all my\nother I2C and UART peripherals.
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
Text GLabel 2600 3900 2    50   Input ~ 0
3V3
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
Wire Wire Line
	2450 3900 2600 3900
Text Notes 1600 3800 0    50   ~ 0
Implement Arduino reset protocol\nConvert DTR down into a short pulse
Wire Wire Line
	1950 5300 1950 4200
Wire Wire Line
	1950 4200 2000 4200
Wire Wire Line
	1300 5300 1950 5300
Text Notes 1750 6800 0    50   ~ 0
4.5V-55V input, 3.3V out at 100 mA
$Comp
L Device:C C1
U 1 1 613F37CB
P 1550 7300
F 0 "C1" H 1665 7346 50  0000 L CNN
F 1 "2.2uF" H 1665 7255 50  0000 L CNN
F 2 "custom:WP_C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 1588 7150 50  0001 C CNN
F 3 "http://datasheets.avx.com/X7RDielectric.pdf" H 1550 7300 50  0001 C CNN
F 4 "https://www.digikey.com/product-detail/en/avx-corporation/08055C104KAT2A/478-1395-1-ND/564427" H 1550 7300 50  0001 C CNN "Digikey"
F 5 "08055C104KAT2A" H 1550 7300 50  0001 C CNN "Part"
F 6 "0.1µF ±10% 50V Ceramic Capacitor X7R 0805 (2012 Metric)" H 1550 7300 50  0001 C CNN "Description"
	1    1550 7300
	1    0    0    -1  
$EndComp
$Comp
L custom:MCP1792T-3302H_CB U1
U 1 1 613F37D1
P 1650 7150
F 0 "U1" H 2450 7250 60  0000 C CNN
F 1 "MCP1792T-33" H 2450 7431 60  0000 C CNN
F 2 "custom:WP_SOT-23" H 2450 7390 60  0001 C CNN
F 3 "" H 1650 7150 60  0000 C CNN
	1    1650 7150
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 613F37DA
P 3350 7300
F 0 "C2" H 3465 7346 50  0000 L CNN
F 1 "2.2uF" H 3465 7255 50  0000 L CNN
F 2 "custom:WP_C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 3388 7150 50  0001 C CNN
F 3 "http://datasheets.avx.com/X7RDielectric.pdf" H 3350 7300 50  0001 C CNN
F 4 "https://www.digikey.com/product-detail/en/avx-corporation/08055C104KAT2A/478-1395-1-ND/564427" H 3350 7300 50  0001 C CNN "Digikey"
F 5 "08055C104KAT2A" H 3350 7300 50  0001 C CNN "Part"
F 6 "0.1µF ±10% 50V Ceramic Capacitor X7R 0805 (2012 Metric)" H 3350 7300 50  0001 C CNN "Description"
	1    3350 7300
	1    0    0    -1  
$EndComp
Text GLabel 1450 7050 0    50   BiDi ~ 0
12V-In
Text GLabel 3450 7050 2    50   BiDi ~ 0
3V3
Wire Wire Line
	3250 7050 3350 7050
Wire Wire Line
	3350 7150 3350 7050
Connection ~ 3350 7050
Wire Wire Line
	3350 7050 3450 7050
Wire Wire Line
	1550 7150 1550 7050
Wire Wire Line
	1550 7050 1650 7050
Wire Wire Line
	1550 7050 1450 7050
Connection ~ 1550 7050
Wire Wire Line
	3350 7450 3350 7750
Wire Wire Line
	3350 7750 2450 7750
Wire Wire Line
	2450 7750 1550 7750
Wire Wire Line
	1550 7750 1550 7450
Connection ~ 2450 7750
$Comp
L power:GND #PWR0102
U 1 1 613F37EF
P 2450 7800
F 0 "#PWR0102" H 2450 7550 50  0001 C CNN
F 1 "GND" H 2455 7627 50  0000 C CNN
F 2 "" H 2450 7800 50  0001 C CNN
F 3 "" H 2450 7800 50  0001 C CNN
	1    2450 7800
	1    0    0    -1  
$EndComp
Wire Wire Line
	2450 7800 2450 7750
Text Notes 2050 7200 0    50   ~ 0
MCP1792T-3302H_CB
Text GLabel 2400 750  0    50   Output ~ 0
3V3
Wire Wire Line
	7700 2100 8400 2100
Text GLabel 4850 3900 2    50   Input ~ 0
SDA
Text GLabel 5650 3900 2    50   Input ~ 0
SCL
$Comp
L Device:R R3
U 1 1 61D62A5A
P 4750 3700
F 0 "R3" H 4820 3746 50  0000 L CNN
F 1 "2K2" H 4820 3655 50  0000 L CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 4680 3700 50  0001 C CNN
F 3 "~" H 4750 3700 50  0001 C CNN
	1    4750 3700
	1    0    0    -1  
$EndComp
Text GLabel 4850 3500 2    50   Input ~ 0
3V3
Wire Wire Line
	4850 3900 4750 3900
Wire Wire Line
	4750 3900 4750 3850
Wire Wire Line
	4750 3550 4750 3500
Wire Wire Line
	4750 3500 4850 3500
$Comp
L Device:R R6
U 1 1 61D72445
P 5550 3700
F 0 "R6" H 5620 3746 50  0000 L CNN
F 1 "2K2" H 5620 3655 50  0000 L CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 5480 3700 50  0001 C CNN
F 3 "~" H 5550 3700 50  0001 C CNN
	1    5550 3700
	1    0    0    -1  
$EndComp
Text GLabel 5650 3500 2    50   Input ~ 0
3V3
Wire Wire Line
	5650 3500 5550 3500
Wire Wire Line
	5550 3500 5550 3550
Wire Wire Line
	5550 3850 5550 3900
Wire Wire Line
	5550 3900 5650 3900
$Comp
L power:GND #PWR0112
U 1 1 61CAE1E0
P 8850 3000
F 0 "#PWR0112" H 8850 2750 50  0001 C CNN
F 1 "GND" H 8855 2827 50  0000 C CNN
F 2 "" H 8850 3000 50  0001 C CNN
F 3 "" H 8850 3000 50  0001 C CNN
	1    8850 3000
	0    1    1    0   
$EndComp
Wire Wire Line
	8850 3000 9250 3000
Text Notes 6500 1600 0    50   ~ 0
R2 = 100K instead of original 1K\n100K is 0.12mA but 1K is 12mA\n1/8W 0805 resistors cannot handle 12mA\nMOSFET only needs small current to activate\nDo not use for fast PWM, may not be fast enough
Text Notes 4950 2600 0    50   ~ 0
R1 = 560ohm is currently 4mA. Recalculated to use 0.4mA,\nI(R2) >= I(R1) * 10 == 5875 ohms.\nRounded to nearest 4K7 which is close enough.\nUse 100K to limit collector current.
Text Notes 2000 5100 0    50   ~ 0
5-pin male plug for flash from PC.\nNo flip here because the colors and\nlabels are assuming a male plug. Can\nconnect to FTDI adapter for programming.
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
Text GLabel 4250 1950 2    50   Input ~ 0
ADC0
Text GLabel 9150 1800 0    50   Input ~ 0
ADC0
Text GLabel 9100 1050 0    50   Output ~ 0
3V3
$Comp
L Device:R R7
U 1 1 6601D7FE
P 9350 1200
F 0 "R7" H 9200 1250 50  0000 C CNN
F 1 "10K" H 9200 1150 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 9280 1200 50  0001 C CNN
F 3 "~" H 9350 1200 50  0001 C CNN
	1    9350 1200
	-1   0    0    1   
$EndComp
Text Notes 10450 950  2    50   ~ 0
Measure water conduction, or a switch.\nCan use to trigger the release manually.
$Comp
L Connector_Generic:Conn_01x02 J17
U 1 1 6603E39B
P 10050 1400
F 0 "J17" H 10130 1392 50  0000 L CNN
F 1 "Sense0" H 10130 1301 50  0000 L CNN
F 2 "custom:WP_Power_PinHeader_1x02_P2.54mm_Vertical" H 10050 1400 50  0001 C CNN
F 3 "~" H 10050 1400 50  0001 C CNN
	1    10050 1400
	1    0    0    -1  
$EndComp
Text Notes 8850 2700 0    50   ~ 0
I2C peripheral connector
$Comp
L Device:R R2
U 1 1 608269B9
P 7000 850
F 0 "R2" V 6793 850 50  0000 C CNN
F 1 "12K4" V 6884 850 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 6930 850 50  0001 C CNN
F 3 "~" H 7000 850 50  0001 C CNN
	1    7000 850 
	0    1    1    0   
$EndComp
Text Notes 3750 4950 0    79   ~ 0
This board uses 3V3 at 8 MHz to maintain compatibility\nwith 3V3 I2C peripherals. Only the modem uses 5V at 16 MHz.\nThe modem needs to convert UART output to 3V3.
Text Notes 550  6550 0    50   ~ 0
This device is only powered via the 12V-In and not from the UART connector which is plugged into the modem
$Comp
L custom:WP_Power_Conn_01x02 BAT1
U 1 1 67D64F4C
P 2750 5800
F 0 "BAT1" H 2918 5800 50  0000 L CNN
F 1 "12V" H 2918 5709 50  0000 L CNN
F 2 "custom:WP_TerminalBlock_16AWG_bornier-2_P5.08mm" H 2750 5800 50  0001 C CNN
F 3 "~" H 2750 5800 50  0001 C CNN
	1    2750 5800
	1    0    0    -1  
$EndComp
Text GLabel 2550 5800 0    50   BiDi ~ 0
12V-In
$Comp
L power:GND #PWR0103
U 1 1 67D6CD0F
P 2250 5900
F 0 "#PWR0103" H 2250 5650 50  0001 C CNN
F 1 "GND" H 2255 5727 50  0000 C CNN
F 2 "" H 2250 5900 50  0001 C CNN
F 3 "" H 2250 5900 50  0001 C CNN
	1    2250 5900
	0    1    1    0   
$EndComp
Wire Wire Line
	2250 5900 2550 5900
Text Notes 4900 4100 0    50   ~ 0
Permanent I2C pullups
Text Notes 2200 5700 0    50   ~ 0
XT90 to battery
Text Notes 7300 5600 0    50   ~ 0
Provide 5V for UART-based peripherals, which will use a 3V3 regulator\nThe UART signalling voltage is 3V3.\nPeripheral may also use 5V directly without a regulator.
$Comp
L Device:C C?
U 1 1 613F7D4A
P 7750 4650
AR Path="/613EEE93/613F7D4A" Ref="C?"  Part="1" 
AR Path="/613F7D4A" Ref="C3"  Part="1" 
F 0 "C3" H 7865 4696 50  0000 L CNN
F 1 "2u2" H 7865 4605 50  0000 L CNN
F 2 "custom:WP_C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 7788 4500 50  0001 C CNN
F 3 "http://datasheets.avx.com/X7RDielectric.pdf" H 7750 4650 50  0001 C CNN
F 4 "https://www.digikey.com/product-detail/en/avx-corporation/08055C104KAT2A/478-1395-1-ND/564427" H 7750 4650 50  0001 C CNN "Digikey"
F 5 "08055C104KAT2A" H 7750 4650 50  0001 C CNN "Part"
F 6 "0.1µF ±10% 50V Ceramic Capacitor X7R 0805 (2012 Metric)" H 7750 4650 50  0001 C CNN "Description"
	1    7750 4650
	1    0    0    -1  
$EndComp
$Comp
L custom:MCP1792T-3302H_CB U?
U 1 1 613F7D50
P 7850 4500
AR Path="/613EEE93/613F7D50" Ref="U?"  Part="1" 
AR Path="/613F7D50" Ref="U2"  Part="1" 
F 0 "U2" H 8650 4600 60  0000 C CNN
F 1 "MCP1792T-5" H 8650 4781 60  0000 C CNN
F 2 "custom:WP_SOT-23" H 8650 4740 60  0001 C CNN
F 3 "" H 7850 4500 60  0000 C CNN
	1    7850 4500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 613F7D59
P 9550 4650
AR Path="/613EEE93/613F7D59" Ref="C?"  Part="1" 
AR Path="/613F7D59" Ref="C4"  Part="1" 
F 0 "C4" H 9665 4696 50  0000 L CNN
F 1 "2.2uF" H 9665 4605 50  0000 L CNN
F 2 "custom:WP_C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 9588 4500 50  0001 C CNN
F 3 "http://datasheets.avx.com/X7RDielectric.pdf" H 9550 4650 50  0001 C CNN
F 4 "https://www.digikey.com/product-detail/en/avx-corporation/08055C104KAT2A/478-1395-1-ND/564427" H 9550 4650 50  0001 C CNN "Digikey"
F 5 "08055C104KAT2A" H 9550 4650 50  0001 C CNN "Part"
F 6 "0.1µF ±10% 50V Ceramic Capacitor X7R 0805 (2012 Metric)" H 9550 4650 50  0001 C CNN "Description"
	1    9550 4650
	1    0    0    -1  
$EndComp
Text GLabel 7650 4400 0    50   BiDi ~ 0
12V-In
Text GLabel 9650 4400 2    50   BiDi ~ 0
5V-In
Wire Wire Line
	9450 4400 9550 4400
Wire Wire Line
	9550 4500 9550 4400
Connection ~ 9550 4400
Wire Wire Line
	9550 4400 9650 4400
Wire Wire Line
	7750 4500 7750 4400
Wire Wire Line
	7750 4400 7850 4400
Wire Wire Line
	7750 4400 7650 4400
Connection ~ 7750 4400
Wire Wire Line
	9550 4800 9550 5100
Wire Wire Line
	9550 5100 8650 5100
Wire Wire Line
	8650 5100 7750 5100
Wire Wire Line
	7750 5100 7750 4800
Connection ~ 8650 5100
$Comp
L power:GND #PWR?
U 1 1 613F7D6E
P 8650 5150
AR Path="/613EEE93/613F7D6E" Ref="#PWR?"  Part="1" 
AR Path="/613F7D6E" Ref="#PWR0106"  Part="1" 
F 0 "#PWR0106" H 8650 4900 50  0001 C CNN
F 1 "GND" H 8655 4977 50  0000 C CNN
F 2 "" H 8650 5150 50  0001 C CNN
F 3 "" H 8650 5150 50  0001 C CNN
	1    8650 5150
	1    0    0    -1  
$EndComp
Wire Wire Line
	8650 5150 8650 5100
Text Notes 8250 4550 0    50   ~ 0
MCP1792T-5002H_CB
Text Notes 6350 4200 0    50   ~ 0
Schottky Diode, SD0805S040S0R1\n40V 100MA 0805, Vf=0.4V-0.5V
Text Notes 7300 6350 0    50   ~ 0
This PCB can be optionally powered with the UART cable and 5V input.\nNeed Schottky across MCP1792T-5 to prevent reverse current through it,\nand allow 5V in to appear on 12V-In, and then run the 3V3 regulator.\nIt worked without the Schottky, but probably not safe to use this long term.\nWith Schottky, there will be 4.5V on the 12V-In label on the whole board,\nwhich is enough for the 3V3 regulator. (but not used for peripheral UART device)\n\nDO NOT CONNECT BOTH 12V AND UART POWER SIMULTANEOUSLY!
$Comp
L Device:D_Schottky D4
U 1 1 6154626D
P 8000 4100
F 0 "D4" H 8000 4316 50  0000 C CNN
F 1 "SD0805S040S0R1" H 8000 4225 50  0000 C CNN
F 2 "custom:WP_LED_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 8000 4100 50  0001 C CNN
F 3 "http://datasheets.avx.com/schottky.pdf" H 8000 4100 50  0001 C CNN
F 4 "DIODE SCHOTTKY 40V 100MA 0805" H 8000 4100 50  0001 C CNN "Description"
	1    8000 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	8150 4100 9550 4100
Wire Wire Line
	9550 4100 9550 4400
Wire Wire Line
	7850 4100 7750 4100
Wire Wire Line
	7750 4100 7750 4400
Wire Wire Line
	1200 5100 1300 5100
$Comp
L custom:WP_Power_Conn_01x02 SW1
U 1 1 67D06698
P 4100 5800
F 0 "SW1" H 4268 5800 50  0000 L CNN
F 1 "12V" H 4268 5709 50  0000 L CNN
F 2 "custom:WP_TerminalBlock_16AWG_bornier-2_P5.08mm" H 4100 5800 50  0001 C CNN
F 3 "~" H 4100 5800 50  0001 C CNN
	1    4100 5800
	1    0    0    -1  
$EndComp
Text GLabel 3900 5800 0    50   BiDi ~ 0
12V-Sw
$Comp
L power:GND #PWR0110
U 1 1 67D067C9
P 3600 5900
F 0 "#PWR0110" H 3600 5650 50  0001 C CNN
F 1 "GND" H 3605 5727 50  0000 C CNN
F 2 "" H 3600 5900 50  0001 C CNN
F 3 "" H 3600 5900 50  0001 C CNN
	1    3600 5900
	0    1    1    0   
$EndComp
Wire Wire Line
	3600 5900 3900 5900
Text Notes 3350 5700 0    50   ~ 0
To Nichrome Wire Release (high current)
Wire Wire Line
	4250 1950 4200 1950
NoConn ~ 4200 2150
NoConn ~ 4200 2250
Wire Wire Line
	1200 4800 1300 4800
$Comp
L Device:R R1
U 1 1 67D7EE75
P 9350 1600
F 0 "R1" H 9200 1650 50  0000 C CNN
F 1 "47K" H 9200 1550 50  0000 C CNN
F 2 "custom:WP_R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 9280 1600 50  0001 C CNN
F 3 "~" H 9350 1600 50  0001 C CNN
	1    9350 1600
	-1   0    0    1   
$EndComp
Wire Wire Line
	9100 1050 9350 1050
$Comp
L power:GND #PWR0111
U 1 1 67D8BA42
P 9350 2200
F 0 "#PWR0111" H 9350 1950 50  0001 C CNN
F 1 "GND" H 9355 2027 50  0000 C CNN
F 2 "" H 9350 2200 50  0001 C CNN
F 3 "" H 9350 2200 50  0001 C CNN
	1    9350 2200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C5
U 1 1 67D8C8B8
P 9350 2000
F 0 "C5" V 9098 2000 50  0000 C CNN
F 1 "0.1uF" V 9189 2000 50  0000 C CNN
F 2 "custom:WP_C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 9388 1850 50  0001 C CNN
F 3 "~" H 9350 2000 50  0001 C CNN
	1    9350 2000
	-1   0    0    1   
$EndComp
Wire Wire Line
	9850 1400 9350 1400
Wire Wire Line
	9350 1400 9350 1350
Wire Wire Line
	9350 1400 9350 1450
Connection ~ 9350 1400
Wire Wire Line
	9350 1750 9350 1800
Wire Wire Line
	9350 1800 9150 1800
Connection ~ 9350 1800
Wire Wire Line
	9350 1800 9350 1850
Wire Wire Line
	9350 2150 9350 2200
Wire Wire Line
	9850 1500 9850 2150
Wire Wire Line
	9850 2150 9350 2150
Connection ~ 9350 2150
Text Notes 7300 1900 0    50   ~ 0
P-MOSFET part numbers:\nSUP60061EL-GE3 = 30 amps DC\nFQP47P06 = 10 amps DC
$EndSCHEMATC
