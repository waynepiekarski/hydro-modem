TARGETS = linux-test modemrelease modemrx recordwav

DEPS = build/arduino.done build/apt-get-deps.done

all: all-make

all-make: $(foreach target, $(TARGETS), make-$(target))

make-%: $(DEPS)
	$(MAKE) -C $*

build/arduino.done: download-arduino-tools download-arduino-libs
	./download-arduino-tools
	./download-arduino-libs
	mkdir -p build && touch $@

build/apt-get-deps.done: apt-get-deps
	./apt-get-deps
	mkdir -p build && touch $@
