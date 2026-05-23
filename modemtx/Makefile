
NAME = $(shell basename $(CURDIR))
ARCH = $(shell uname --machine)

ifeq ($(FQBN),)
  FQBN=arduino:avr:pro:cpu=8MHzatmega328
endif
BUILD_DIR=build

# The standard Arduino Uno board at 16 MHz 5V uses 115200 for the Arduino bootloader
# All my custom boards use Optiboot bootloader and 57600 for better UART reliability
ifeq ($(OPTIBOOT_BAUD),)
OPTIBOOT_BAUD=57600
OPTIBOOT_BUILD=optiboot_external8
endif
OUTFILE=$(BUILD_DIR)/$(NAME).ino.hex


all:	$(OUTFILE)


# Default SERIAL_RX_BUFFER_SIZE appears to be 64, but using larger values causes lack of memory problems
# CPP_EXTRA_FLAGS += -DSERIAL_RX_BUFFER_SIZE=128 -DSERIAL_TX_BUFFER_SIZE=64
CPP_EXTRA_FLAGS += -Wshadow -Werror -Wno-error=cpp -DMAKEFILE_BAUD=$(BAUD)

# Per-project customized Makefile variables
include Makefile.local

# Build up final compiler flags for arduino-cli
BUILDPROPS += --build-properties compiler.cpp.extra_flags="$(CPP_EXTRA_FLAGS)"


$(OUTFILE): $(NAME).ino $(wildcard *.cpp) $(wildcard *.h) Makefile Makefile.local
	../run-arduino-cli $(SKETCHBOOK) --fqbn=$(FQBN) compile --warnings all $(NAME) $(BUILDPROPS) --output-dir $(BUILD_DIR)
	ls -al $@

dump: $(OUTFILE)
	nm --demangle --size-sort $(BUILD_DIR)/$(NAME).ino.elf

strings: $(OUTFILE)
	strings $(BUILD_DIR)/$(NAME).ino.elf

clean:
	rm -rf $(BUILD_DIR) /tmp/arduino-*
	find ../arduino-sketchbook-dir -name "*.o" -exec rm {} \;

.PHONY: clean flash reboot

# Need to specify .SECONDARY to prevent intermediate files being deleted
.SECONDARY:


# Arduino Pro Mini 8MHz 3.3V is https://www.sparkfun.com/products/11114
# Board schematic: https://www.arduino.cc/en/uploads/Main/Arduino-Pro-Mini-schematic.pdf
# Arduino bootloader code: https://github.com/arduino/ArduinoCore-avr/blob/master/bootloaders/atmega/ATmegaBOOT_168.c
# The bootloader flashes LED on PB5, which is the SCK pin on the AVRISP6 connector
# RESET is connected to DTR on the RS-232 adapter
#
# We use OptiBoot v6.2 which supports the watchdog and software reset, whereas the
# standard Arduino bootloader does not work for this. OptiBoot also uses only 512 bytes
# so this needs to be configured in the fuses as well. The OptiBoot Makefile and
# Makefile.isp implement all of the fuses and flashing.
optiboot:	$(OPTIBOOT_BUILD)

optiboot_external8:
	$(MAKE) -C $(CURDIR)/../optiboot/optiboot/bootloaders/optiboot atmega328_external8_isp

optiboot_external16:
	$(MAKE) -C $(CURDIR)/../optiboot/optiboot/bootloaders/optiboot atmega328_external16_isp

optiboot_external7:
	$(MAKE) -C $(CURDIR)/../optiboot/optiboot/bootloaders/optiboot atmega328_external_7372800_isp


# Lookup any port and baud rate information for this project
UPPER=$(shell echo $(NAME) | tr '[:lower:]' '[:upper:]' | tr '-' '_' | awk -F'_' '{ print $$1 }')
# Split the project name before any hyphens and just use the first part for any variable names
ifeq ($(PORT),)
PORT=$(shell ../../get_config_var $(UPPER)_SERIAL_DEVICE)
ifneq ($(PORT),)
$(warning Lookup name [$(NAME)] -> [$(UPPER)], port $(UPPER)_SERIAL_DEVICE=$(PORT))
endif
endif

ifeq ($(BAUD),)
BAUD=$(shell ../../get_config_var $(UPPER)_SERIAL_BAUD)
ifneq ($(PORT),)
$(warning Lookup name [$(NAME)] -> [$(UPPER)], baud $(UPPER)_SERIAL_BAUD=$(BAUD))
endif
endif

ifeq ($(PORT),)
PORT := $(shell if [ -c /dev/ttyUSB0 ]; then echo /dev/ttyUSB0; elif [ -c /dev/ttyACM0 ]; then echo /dev/ttyACM0; else echo "/dev/no-ttyUSB0-or-ttyACM0-found"; fi)
$(warning Automatic detection of upload PORT=$(PORT))
endif

ifeq ($(BAUD),)
$(error No $(UPPER)_SERIAL_BAUD defined)
endif

# Upload the binary via the serial port, assuming bootloader is already flashed. No need to unplug the device and use AVRISP adapter.
# Need to power cycle the device and this should then catch it during the OptiBoot startup when the lights are blinking
# After modifying sensorhub's startup to re-run the bootloader, it now properly waits for stk500 commands on power up,
# so you can now power cycle and upload again like before with the Arduino bootloader.
AVRDUDE=$(CURDIR)/../arduino-data-$(ARCH)-dir/packages/arduino/tools/avrdude/6.3.0-arduino17/bin/avrdude
AVRDUDE_CONF=$(CURDIR)/../arduino-data-$(ARCH)-dir/packages/arduino/tools/avrdude/6.3.0-arduino17/etc/avrdude.conf
# Note that -carduino is required, -cstk500 does not work with Optiboot. Arduino uses a variant of STK500 but not compatible.
upload: $(OUTFILE)
	while ! $(AVRDUDE) -C$(AVRDUDE_CONF) -patmega328p -carduino -P$(PORT) -b$(OPTIBOOT_BAUD) -D -Uflash:w:$(OUTFILE):i; do \
		date; \
		echo "Retry until success"; \
	done
	make -C $(CURDIR) read

# Upload using the arduino-cli upload tool instead of manual avrdude, needed to work with Arduino Nano with old bootloader
uploadcli: $(OUTFILE)
	../run-arduino-cli upload --fqbn $(FQBN) --port $(PORT) --input-dir $(BUILD_DIR)
	make -C $(CURDIR) read

read:
	stty raw -crtscts -echo ispeed $(BAUD) ospeed $(BAUD) -F $(PORT)
	cat $(PORT)

screen:
	echo "Terminate screen session with: C-a k y"
	sleep 1s
	screen $(PORT) $(BAUD)

arduino-uno-upload:
	$(MAKE) clean
	$(MAKE) OPTIBOOT_BAUD=115200 FQBN=arduino:avr:pro:cpu=16MHzatmega328 upload

# Directly flash to the hardware via the AVRISP connector, skipping OptiBoot and no ability to update via UART.
# Fuses must be consistent with the optiboot Makefile *_isp rules.
# Requires the PCB to have an external oscillator, fuses are the same for all frequencies.
flash: $(OUTFILE)
	sudo $(AVRDUDE) -C$(AVRDUDE_CONF) -patmega328p -c usbasp -e -u -U lock:w:0xff:m -U efuse:w:0xFD:m -U hfuse:w:0xDE:m -U lfuse:w:0xF7:m -U flash:w:$(OUTFILE) -U lock:w:0xcf:m
