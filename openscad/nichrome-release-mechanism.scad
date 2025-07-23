// ------------------------------------------------------------------------------
//| HydroModem - Nichrome Release Mechanism                                      |
//| Copyright (C) Wayne Piekarski 2024-2025                                      |
//| https://www.waynepiekarski.net/projects/hydro-modem.htm                      |
//|                                                                              |
//| This source describes Open Hardware and is licensed under the CERN-OHL-S v2. |
//|                                                                              |
//| You may redistribute and modify this source and make products using it under |
//| the terms of the CERN-OHL-S v2 (https://ohwr.org/cern_ohl_s_v2.txt).         |
//|                                                                              |
//| This source is distributed WITHOUT ANY EXPRESS OR IMPLIED WARRANTY,          |
//| INCLUDING OF MERCHANTABILITY, SATISFACTORY QUALITY AND FITNESS FOR A         |
//| PARTICULAR PURPOSE. Please see the CERN-OHL-S v2 for applicable conditions.  |
//|                                                                              |
//| Source location: https://www.waynepiekarski.net/projects/hydro-modem.htm     |
//|                                                                              |
//| As per CERN-OHL-S v2 section 4, should You produce hardware based on this    |
//| source, You must where practicable maintain the Source Location visible      |
//| on the external case of the device or other products you make using this     |
//| source.                                                                      |
// ------------------------------------------------------------------------------

// Nichrome 80 wire, 32 AWG
// https://www.amazon.com/dp/B07CJ63YYT
// Nichrome 80-250' - 32 Gauge Wire - 250ft - 0.2mm - 0.008in - Made in USA - Master Wire Supply

mount_width = 10; // Using 10mm square washers with M3 holes to grab onto the nichrome wire
wire_length = 10; // Gap between washers for the nichrome wire to burn
bolt_length = 20;

base = 5;
height = 20;
length = 100;
width = mount_width*2 + wire_length;

arm_height = height - 5;
arm_offset = 1; // Need clearance or the arm is a tight fit to close
bolt_height = arm_height / 2;
arm_thickness = wire_length-2;

infinity = 100;

for (copy=[-1,1]) scale([copy,1,1]) {
    // Base with text
    if (copy > 0) {
        difference() {
            translate([0,0,-base/2])
                cube([width,length,base], center=true);
            translate([0,0,-1]) linear_extrude(2) {
                translate([-6,-2,0])
                    rotate([0,0,90])
                        text("Nichrome 80 32AWG", halign="center", valign="bottom", size=5);
                translate([0,+2,0])
                    rotate([0,0,90])
                        text("2025-06-11 v1", halign="center", valign="center", size=5);
                translate([+6,+2,0])
                    rotate([0,0,90])
                        text("HydroModem", halign="center", valign="top", size=5);
            }
        }
    }

    // Mount for rotating release arm bolt
    translate([width/2-mount_width,-length/2,0]) {
        difference() {
            cube([mount_width,2*arm_thickness,height]);
            translate([0,arm_thickness,bolt_height+arm_offset])
                rotate([0,90,0])
                    cylinder(d=6, $fn=4, h=infinity, center=true);
        }
    }

    // Mount for the electrical metric bolts
    translate([-mount_width/2+mount_width/2+wire_length/2,length/2-bolt_length,0]) {
        difference() {
            union() {
                inset = 3;
                // Inset slightly so the square washers do not rotate
                translate([0,inset,mount_width])
                    color("green") cube([mount_width,bolt_length-2*inset,mount_width]);
                color("orange") cube([mount_width,bolt_length,height-mount_width]);
            }
            translate([mount_width/2,0,height-mount_width/2+arm_offset])
                rotate([90,0,0])
                    cylinder(d=3, $fn=4, h=infinity, center=true);
        }
    }
}

// The hole didn't line up and needs an 0.5mm offset to align properly.
// Use *0 or *1 there are two places where it can be enabled.
bugfix = 0.5;

// Rotating rope holding arm with rounded ends
debug = false;
color("orange")
translate(debug ? [0,bugfix*1,arm_height/2+arm_offset] : [width,0,arm_thickness/2-base]) rotate(debug ? [0,0,0] : [0,90,0])
{
    difference() {
        hull() {
            translate([0,length/2-arm_height/2,0])
                rotate([0,90,0])
                    cylinder(d=arm_height, $fn=100, h=arm_thickness, center=true);
            translate([0,-(length/2-arm_height/2),0])
                rotate([0,90,0])
                    cylinder(d=arm_height, $fn=100, h=arm_thickness, center=true);
        }
        // Bolt hole for rotation
        translate([0,-(length/2-arm_height/2-bugfix*0),0])
            rotate([0,90,0])
                cylinder(d=6, $fn=100, h=infinity, center=true);
        
        // Area for rope to pass through, needs to be at an angle
        // so the rope slides out and doesn't get caught
        tweak_angle = 15;
        tweak_ofs = 2.8;
        rope_diameter = 10;

        translate([0,-length/2+arm_height*1.5,0-arm_height/2-tweak_ofs])
            rotate([0,90,0])
                rotate([0,0,tweak_angle])
                cylinder(d=rope_diameter*2, $fn=4, h=infinity, center=true);
    }
}

// Rotating rope holding arm with bolt end to not burn from nichrome
// TODO: Currently will be at an angle since the nichrome wire is higher than axis of rotation
debug2 = false;
color("cyan")
translate(debug2 ? [0,bugfix*1,arm_height/2+arm_offset] : [-width,0,arm_thickness/2-base]) rotate(debug2 ? [0,0,0] : [0,90,0])
{
    difference() {
        hull() {
            // -5mm to ensure the arm never interferes with the nichrome mount
            translate([0,length/2-arm_height/2-bolt_length-5,0])
                rotate([0,90,0])
                    cube([arm_height,arm_height,arm_thickness], center=true);
            translate([0,-(length/2-arm_height/2),0])
                rotate([0,90,0])
                    cylinder(d=arm_height, $fn=100, h=arm_thickness, center=true);
        }
        // Mounting hole to fasten M3 bolt to rest against the nichrome wire
        rotate([90,0,0])
            translate([0,0,-infinity/2])
                cylinder(d=3, $fn=4, h=infinity, center=true);
        
        // Bolt hole for rotation
        translate([0,-(length/2-arm_height/2-bugfix*0),0])
            rotate([0,90,0])
                cylinder(d=6, $fn=100, h=infinity, center=true);
        
        // Area for rope to pass through, needs to be at an angle
        // so the rope slides out and doesn't get caught
        tweak_angle = 15;
        tweak_ofs = 2.8;
        rope_diameter = 10;

        translate([0,-length/2+arm_height*1.5,0-arm_height/2-tweak_ofs])
            rotate([0,90,0])
                rotate([0,0,tweak_angle])
                cylinder(d=rope_diameter*2, $fn=4, h=infinity, center=true);
    }
}
