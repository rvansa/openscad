$fn=64;

difference() {
    union() {
        hull() {
            cylinder(d=20, h=4);
            translate([150, 0, 0]) cylinder(d=20, h=4);
        }
        translate([0,0,4]) cylinder(d=20, h=3);
    }
    translate([0,0,-1]) cylinder(h=10, d=4);
    translate([0,0,4]) cylinder(h=10, d=16);
    translate([150,0,-1]) cylinder(h=10, d=4);
    translate([10,-5,-1]) cube([130,10,6]);
}

translate([-30, 0, 0]) difference() {
    cylinder(d=20, h=3);
    translate([0,0,-1]) cylinder(d=4, h=5);
}