use <PropRep.scad>
use <cones.scad>


$fn=100;
unit=2.54;   
hh=221;
loose=0.2;

// Motor
shaft_length=9;
shaft_diameter=1.9;
motor_diameter=20.2;
motor_short_d=15.4;
motor_length=25;
ring_d=6;
ring_h=1.5;

// Battery
battery_height=30;

// Derived
motor_base = hh - motor_length - 2 * ring_h;
battery_base = motor_base - battery_height - 10;
stepup_base = battery_base - 30;
arduino_base = stepup_base - 43;
acc_base = arduino_base - 30;
bar_base = acc_base - 20;
tx_base = bar_base - 25;

* translate([0, 0, hh + 6])
    repeller();

* difference() {
    body();
    translate([-20, 0, -25]) cube([40, 40, 250]);
}

difference() {
    body();
    translate([-20, -40, -25]) cube([40, 40, 250]);
}

* union() {
    translate([0, 0, motor_base + ring_h]) motor();
    translate([0, 0, battery_base]) battery();
    translate([0, -7, stepup_base]) stepup();
    translate([0, -4, arduino_base]) rotate([0, 0, 180]) arduino_promini();
    translate([0, -4.5, acc_base]) rotate([0, 0, 180]) accelerometer();
    translate([0, -5.5, bar_base]) rotate([0, 0, 180]) barometer();
    translate([0, -3, tx_base + 15]) rotate([0, 180, 180]) transmitter();
}    

module body() {
    difference() {
        union() {
            difference() {
                cylinder(r = 13, h = hh);            
                translate([0, 0, hh - 2]) cylinder(r=4, h=3);
                translate([0, 0, -2]) cylinder(r = 11, h = hh);    
                //translate([0, 0, 10]) cylinder(r = 20, h = hh);
            }
            // Screw mounts
            translate([0, -8.5, motor_base - 5])
                rotate([90, 0, 0]) cylinder(r = 6, h = 2.5);           
            translate([0, 11, motor_base - 5])
                rotate([90, 0, 0]) cylinder(r = 6, h = 2.5);           
            // lower
            translate([0, -8.5, bar_base + 16])
                rotate([90, 0, 0]) cylinder(r = 6, h = 2.5);           
            translate([0, 11, bar_base + 16])
                rotate([90, 0, 0]) cylinder(r = 6, h = 2.5);           
        }
        // Screw mount negative
        translate([0, 20, motor_base - 5])
            rotate([90, 0, 0]) cylinder(r = 2, h = 40);
        translate([0, 15, motor_base - 5])            
            rotate([90, 0, 0]) cylinder(r = 4, h = 3.99);        
        translate([0, -10, motor_base - 5])            
            rotate([90, 0, 0]) cylinder(r = 4, h = 3.99);                
        translate([0, 20, bar_base + 16])
            rotate([90, 0, 0]) cylinder(r = 2, h = 40);        
        translate([0, 15, bar_base + 16])            
            rotate([90, 0, 0]) cylinder(r = 4, h = 3.99);        
        translate([0, -10, bar_base + 16])            
            rotate([90, 0, 0]) cylinder(r = 4, h = 3.99);                
    }
    // Motor mounts
    translate([0, 0, motor_base]) union() {
        translate([5, motor_short_d/2 + loose, 0])
            cube([2, 2, motor_length + 2 * ring_h]);
        translate([-7, motor_short_d/2 + loose, 0])
            cube([2, 2, motor_length + 2 * ring_h]);
        translate([5, -2 - motor_short_d/2 - loose, 0])
            cube([2, 2, motor_length + 2 * ring_h]);
        translate([-7, -2 - motor_short_d/2 - loose, 0])
            cube([2, 2, motor_length + 2 * ring_h]);    
    }
    // Battery holds
    translate([0, 0, battery_base - loose]) union() {
        translate([8, 2.5 + loose, 0]) cube([4, 2, battery_height + 2 * loose]);
        translate([8, -4.5 - loose, 0]) cube([4, 2, battery_height + 2 * loose]);
        translate([-12, 2.5 + loose, 0]) cube([4, 2, battery_height + 2 * loose]);
        translate([-12, -4.5 - loose, 0]) cube([4, 2, battery_height + 2 * loose]);
    }
    translate([-12, -4.5 - loose, battery_base + battery_height + loose])
        cube([4, 9 + 2 * loose, 2]);
    translate([-12, -4.5 - loose, battery_base - loose - 2])
        cube([4, 9 + 2 * loose, 2]);
    // Connector
    translate([0, 11, battery_base - 10]) difference() {
        union() {
            translate([2, 0, 0]) hull() {
                cube([3, 2, 40]);
                translate([0, 12, 20]) rotate([0, 90, 0]) cylinder(r = 10, h = 3);
            }
            translate([-5, 0, 0]) hull() {
                cube([3, 2, 40]);
                translate([0, 12, 20]) rotate([0, 90, 0]) cylinder(r = 10, h = 3);
            }
        }
        translate([-6, 12, 20]) rotate([0, 90, 0]) cylinder(d = 4, h=12);
    }
    // Step up holds
    union() {
        translate([-11, -6.5, stepup_base + 23 + loose]) rotate([0, 0, -30]) cube([13, 2.5, 2]);
        translate([0, -13, stepup_base + 23 + loose]) rotate([0, 0, 30]) cube([13, 2.5, 2]);
        translate([-11, -6.5, stepup_base - 2 - loose]) rotate([0, 0, -30]) cube([13, 2.5, 2]);
        translate([0, -13, stepup_base - 2 - loose]) rotate([0, 0, 30]) cube([13, 2.5, 2]);
    }
    // Arduino holds
    skew_holds(base = arduino_base + 33 + loose);
    skew_holds(base = arduino_base - 2 - loose);    
    // Accelerometer holds
    skew_holds(base = acc_base + 21 + loose);
    skew_holds(base = acc_base - 2 - loose);
    // Barometer holds
    skew_holds(base = bar_base + 11 + loose);
    skew_holds(base = bar_base - 2 - loose);
    // Transmitter holds
    skew_holds(base = tx_base + 15 + loose);
    skew_holds(base = tx_base - 6.5 - loose);
    // Tail    
    rotate([180, 0, 0]) difference() {
        haack(R=13, it=0.2, L=25);
        translate([0, 0, -2]) haack(R=11, it=0.2, L=25);
    }
}

module skew_holds(base = 0) {
    translate([0, 0, base]) linear_extrude(height = 2) union() {
        polygon(points = [[-12, 1], [-4, -11], [-8, -10], [-10, -8]], paths = [[0, 1, 2, 3]]);
        polygon(points = [[12, 1], [4, -11], [8, -10], [10, -8]], paths = [[0, 1, 2, 3]]);
    }
}

module repeller() {
    rotate([0, 90, 0])
        Repeller(rAx=1, r1Ax=13, lAx=10, L=20, twist=15, rot=60, r=135);
    translate([0, 0, 5])
        haack(R = 13, L = 20, it = 0.2);
}

module motor() {
    
    difference() {
        cylinder(r=motor_diameter / 2, h = motor_length);
        translate([-motor_diameter / 2, motor_short_d / 2, -1])
            cube([motor_diameter, motor_diameter, motor_length + 2]);
        translate([-motor_diameter / 2, - motor_diameter - motor_short_d / 2, -1])
            cube([motor_diameter, motor_diameter, motor_length + 2]);
    }
    translate([0, 0, motor_length]) cylinder(r=ring_d / 2, h = ring_h);
    translate([0, 0, motor_length + ring_h]) cylinder(r=shaft_diameter/2, h = shaft_length);
    translate([0, 0, -ring_h]) cylinder(r=ring_d / 2, h = ring_h);
}

module pin_male(n = 1, bent = false) {    
    pin=0.8;
    for (i = [0:n - 1]) translate([unit * i, 0, 0]) {
        cube([unit, unit, unit]);
        translate([unit/2 - pin/2, unit/2 - pin/2, -3]) cube([pin, pin, bent ? 7 : 11]);
        if (bent) {
            translate([unit/2 - pin/2, unit/2 - pin/2, 4 - pin/2]) cube([pin, 5, pin]); 
        }
    }    
}

module arduino_promini() {
    width=18; // 0.7 inch
    length=33; // 1.2 inch
    translate([-width / 2, 0, 0]) {        
        cube([width, 1.5, length]);        
    }    
    translate([-width/2 + unit, 0, 0])
        rotate([0, -90, 90]) pin_male(n = 12);
    translate([width/2, 0, 0])
        rotate([0, -90, 90]) pin_male(n = 12);
    translate([-width/2 + unit/2, 0, length - unit])
        rotate([90, 0, 0]) pin_male(n = 6, bent=true);
}

module accelerometer() {
    width=16;
    length=21;
    translate([-width / 2, 0, 0]) cube([width, 1.5, length]);
    translate([width/2, 0, 0])
        rotate([0, -90, 90]) pin_male(n = 8);
}

module stepup() {
    b_width=16;
    b_length=23;
    p_offset=7.5;
    p_width=5;
    p_length=9.5;
    p_height=12;
    translate([-b_width / 2, 0, 0]) union() {
        cube([b_width, 1.5, b_length]);
        translate([0, 0, p_offset]) cube([p_width, p_height, p_length]);        
    }
}

module barometer() {
    width=15;
    length=11;
    translate([-width / 2, 0, 0]) union() {
        cube([width, 1.5, length]);
        rotate([90, 0, 0]) pin_male(n = 6);
    }    
}

module transmitter() {
    width=19.5;
    length=19.5;
    translate([-width / 2, 0, 0]) union() {
        cube([width, 1.5, length]);
    }
    translate([width/2 - 5.5, 0, unit])
        rotate([-90, 0, 180]) pin_male(n = 3, bent = true);
}

module battery() {
    translate([-10, -2.5, 0]) cube([20, 5, battery_height]);
}

