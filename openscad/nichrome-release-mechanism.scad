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
 
base = 5;
height = 20;
length = 100;
width = 30;
thickness = 10;

arm_height = height - 5;
arm_offset = 1; // Need clearance or the arm is a tight fit to close
bolt_height = arm_height / 2;
arm_thickness = 10-2;

infinity = 50;

for (copy=[-1,1]) scale([copy,1,1]) {
    // Base
    translate([0,0,-base/2])
        cube([width,length,base], center=true);

    // Mount for rotating release arm bolt
    translate([width/2-thickness,-length/2,0]) {
        difference() {
            cube([thickness,2*arm_thickness,height]);
            translate([0,arm_thickness,bolt_height+arm_offset])
                rotate([0,90,0])
                    cylinder(d=6, $fn=4, h=infinity, center=true);
        }
    }

    // Mount for the electrical metric bolts
    bolt = 20;
    translate([width/2-thickness,length/2-bolt,0]) {
        difference() {
            cube([thickness,bolt,height]);
            translate([thickness/2,0,height-thickness/2+arm_offset])
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
