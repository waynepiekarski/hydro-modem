
# Generate STL files from all SCAD files
TARGETS += $(shell ls -1 *.scad | sed "s/.scad/.stl/g")
# Generate PNG files from all SCAD files
TARGETS += $(shell ls -1 *.scad | sed "s/.scad/.png/g")
# Generate 3MF files from all STL files
TARGETS += $(shell ls -1 *.scad | sed "s/.scad/.3mf/g")


all: $(TARGETS)

%.stl: %.scad
	openscad --render -o $@ $<

%.png: %.scad
	openscad --render -o $@ $<

%.3mf: %.stl
	./PrusaSlicer.AppImage --output $@ --export-3mf $<

clean:
	git clean -dxf *.3mf *.stl *.png *.gcode
