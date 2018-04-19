use <PropRep.scad>
use <cones.scad>


$fn=100;
//motor();
//translate([0, 0, 40])
    repeller();

//translate([0, 0, -50]) arduino_nano();

module repeller() {
    rotate([0, 90, 0])
        Repeller(rAx=1, r1Ax=11.5, lAx=10, L=15, twist=15, rot=60);
    translate([0, 0, 5])
        haack(R = 11.5, L = 20, it = 0.2);
}

module motor() {
    shaft_length=9;
    shaft_diameter=1.9;
    motor_diameter=20.2;
    motor_short_d=15.4;
    motor_length=25;
    ring_d=6;
    ring_h=1.5;

    difference() {
        cylinder(r=motor_diameter / 2, h = motor_length);
        translate([-motor_diameter / 2, motor_short_d / 2, -1])
            cube([motor_diameter, motor_diameter, motor_length + 2]);
        translate([-motor_diameter / 2, - motor_diameter - motor_short_d / 2, -1])
            cube([motor_diameter, motor_diameter, motor_length + 2]);
    }
    translate([0, 0, motor_length]) cylinder(r=ring_d / 2, h = ring_h);
    translate([0, 0, motor_length + ring_h]) cylinder(r=shaft_diameter/2, h = shaft_length);
}

module arduino_nano() {
    width=18.54;
    length=43.18;
    translate([-width / 2, 0, 0]) cube([width, 1, length]);
}

module accelerometer() {
    width=16;
    length=21;
    translate([-width / 2, 0, 0]) cube([width, 1, length]);
}