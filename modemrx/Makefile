
NAME = $(shell basename $(CURDIR))
ARCH = $(shell uname --machine)

ifeq ($(FQBN),)
  FQBN=arduino:avr:pro:cpu=8MHzatmega328
endif
BUILD_DIR=build

# The standard Arduino Uno board at 16 MHz 5V uses 115200 for the bootloader, while my custom 8 MHz 3.3V board uses 57600 for better UART reliability
ifeq ($(OPTIBOOT_BAUD),)
OPTIBOOT_BAUD=57600
endif
OUTFILE=$(BUILD_DIR)/$(NAME).ino.hex
# By default use an 8 MHz external crystal configuration when using Optiboot, but not for Arduino Uno
OPTIBOOT_BUILD=atmega328_external8_isp


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
# so this needs to be confisued in the fuses as well. The OptiBoot Makefile and
# Makefile.isp implement all of the fuses and flashing.
optiboot:
	$(MAKE) -C $(CURDIR)/../optiboot/optiboot/bootloaders/optiboot $(OPTIBOOT_BUILD)

# Upload the binary via the serial port, assuming bootloader is already flashed. No need to unplug the device and use AVRISP adapter.
# Need to power cycle the device and this should then catch it during the OptiBoot startup when the lights are blinking
# After modifying sensorhub's startup to re-run the bootloader, it now properly waits for stk500 commands on power up,
# so you can now power cycle and upload again like before with the Arduino bootloader.
UPPER=$(shell echo $(NAME) | tr '[:lower:]' '[:upper:]' | tr '-' '_' | awk -F'_' '{ print $$1 }')
# Split the project name before any hyphens and just use the first part for any variable names
ifeq ($(PORT),)
PORT=$(shell ../../get_config_var $(UPPER)_SERIAL_DEVICE)
endif
ifeq ($(BAUD),)
BAUD=$(shell ../../get_config_var $(UPPER)_SERIAL_BAUD)
endif
$(warning Using name [$(NAME)] -> [$(UPPER)], port $(UPPER)_SERIAL_DEVICE=$(PORT) and baud $(UPPER)_SERIAL_BAUD=$(BAUD))
ifeq ($(PORT),)
$(error No $(UPPER)_SERIAL_DEVICE defined)
endif
ifeq ($(BAUD),)
$(error No $(UPPER)_SERIAL_BAUD defined)
endif
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


# BOOTLOADER command requires OptiBoot for working watchdog support, and it can software reboot the ATmega328
# and then upload without any kind of physical activity like pressing a button, flicking a switch, or DTR line.
# The reboot actually happens immediately at BOOTLOADER,Now so avrdude needs to run during the time the chip
# is in the bootloader and before it starts running the SensorHub code.
reboot:
	stty raw -crtscts -echo ispeed $(BAUD) ospeed $(BAUD) -F $(PORT)
	/bin/echo -e '$$BOOTLOADER*07\n\r' > $(PORT)
	/bin/echo -e '$$BOOTLOADER*07\n\r' > $(PORT)
	/bin/echo -e '$$BOOTLOADER*07\n\r' > $(PORT)

autoupload: $(OUTFILE)
	make -C $(CURDIR) reboot
	timeout 5s cat $(PORT) || true
	make -C $(CURDIR) upload

# Use GPIO 20 to toggle the Arduino !RESET line to enter bootloader mode, requires sudo access
gpioupload: $(OUTFILE)
	$(CURDIR)/../../testing/gpio-uart-arduino-reset.sh
	make -C $(CURDIR) upload

# Directly flash to the hardware via the AVRISP connector, skipping OptiBoot and no ability to update via UART
# Arguments for the fuses are copied from the optiboot Makefile to be consistent
flash: $(OUTFILE)
	sudo $(AVRDUDE) -C$(AVRDUDE_CONF) -patmega328p -c usbasp -e -u -U lock:w:0xff:m -U efuse:w:0xFD:m -U hfuse:w:0xDE:m -U lfuse:w:0xF7:m -U flash:w:$(OUTFILE) -U lock:w:0xcf:m
