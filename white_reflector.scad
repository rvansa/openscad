rr=10;
t=1.8;
cone_h=12;
bolt_r=3;
hold_l=32;

// lid
//translate([0, 0, 5.2])
rotate([180, 0, 0]) translate([0, 0, -2])
union() {
    difference() {
        translate([0, 0, -3]) cylinder(r=rr, h=5);
        translate([0, 0, -4]) cylinder(r=rr - 2, h=4);
        translate([0, 0, -0.5]) cylinder(r1=3, r2=5, h=3);
        difference() {
            translate([0, 0, -0.5]) cylinder(r=8, h=3);
            translate([0, 0, -1]) cylinder(r=7, h=4);
        }
    }
    for (angle = [0:60:300])
        rotate([0, 0, angle])
            translate([rr - 4, -1, 0]) cube([2, 2, 2]);
    for (angle = [30, 150, 210, 330])
        rotate([0, 0, angle]) translate([-rr - 2, -1.5, -3]) cube([3, 3, 5]);            
}

// base
translate([25, 0, 0]) rotate([180, 0, 0]) translate([0, 0, -2])
difference() {
    union() {
        difference() {
            translate([0, 0, -9]) cylinder(r=rr, h=11);    
            translate([0, 0, -0.5]) cylinder(r=2.5, h=3);
            translate([0, 0, -10]) cylinder(r=rr - 2, h=10);
            // holes
            translate([6, 0, -0.5]) cylinder(r=1, h=3, $fn=6);
            translate([-6, 0, -0.5]) cylinder(r=1, h=3, $fn=6);
        }
        difference() {
            translate([0, 0, -9 - cone_h]) cylinder(r1=3.5, r2=rr, h=cone_h);
            translate([0, 0, -9.1 - cone_h]) cylinder(r1=1.5, r2=rr - 2, h=cone_h + 0.2);
        }
        translate([0, rr - 2, -4]) rotate([-90, 0, 0])
            cylinder(r1=bolt_r, r2=bolt_r - 1, h=4);
        translate([0, -rr + 2, -4]) rotate([90, 0, 0])
            cylinder(r1=bolt_r, r2=bolt_r - 1, h=4);
        for (angle = [30, 150, 210, 330])
            rotate([0, 0, angle]) translate([-rr - 2, -1.5, 0]) cube([3, 3, 2]);            
    
    }
    for (angle = [45:90:360])
        rotate([0, 0, angle]) translate([5, -1, -15]) cube([5, 2, 12]);
}

// hold
//translate([bolt_r + 3, -rr - 3, -hold_l + 2]) rotate([0, 0, 90])
translate([0, -15, 0]) rotate([90, 0, 0])
difference() {
    cube([2 * rr + 6, bolt_r * 2 + 6, hold_l]);
    translate([3, -1, 3]) cube([2 * rr, bolt_r * 2 + 8, hold_l - 2]);
    translate([-1, bolt_r + 3, hold_l - bolt_r - 3]) rotate([0, 90, 0])
        cylinder(h = 2 * rr + 8, r = bolt_r);
    translate([rr + 3, bolt_r + 3, -0.5]) cylinder(r=1.5,h=4, $fn=8);
    translate([rr + 3, bolt_r + 3, 1.5]) cylinder(r1=1.5, r2=3, h=2, $fn=8);
}