inner_r=10;
base_h=2;
cylinder_h=9;
cone_h=12;
bolt_r=3;
led_h=4;
hold_l=60;

// base
translate([-15, 0, 2]) rotate([180, 0, 0])
difference() {
    union() {
        difference() {
            translate([0, 0, -cylinder_h]) cylinder(r=inner_r + 3, h=base_h + cylinder_h);    
            for(angle = [0, 60, 120, 180]) rotate([0, 0, angle])
                translate([inner_r - 1, 0, -0.5]) cylinder(r=0.5, h=base_h + 1);
            translate([0, 0, -cylinder_h - 1]) cylinder(r=inner_r + 1, h=cylinder_h + 1);
            translate([0, 0, -0.5]) cylinder(r = inner_r - 3, h=base_h + 1);
        }
        // cone
        difference() {
            translate([0, 0, -cylinder_h - cone_h])
                cylinder(r1=3.5, r2=inner_r + 3, h=cone_h);
            translate([0, 0, -cylinder_h - cone_h - 0.1])
                cylinder(r1=1.5, r2=inner_r + 1, h=cone_h + 0.2);
        }
        // glue pads
        for (angle = [30, 150, 210, 330]) rotate([0, 0, angle])
            translate([-inner_r - 6.5, -2, 0]) cube([4, 4, base_h]);
        // bolts
        translate([0, inner_r + 2, -4]) rotate([-90, 0, 0])
            cylinder(r1=bolt_r, r2=bolt_r - 1, h=4);
        translate([0, -inner_r - 2, -4]) rotate([90, 0, 0])
            cylinder(r1=bolt_r, r2=bolt_r - 1, h=4);
    }
    for (angle = [30, 150, 210, 330]) rotate([0, 0, angle])
        translate([-inner_r - 4, -1.5, -cylinder_h - cone_h/2 - 1]) cube([8, 3, 14]);
}

//lid
translate([20, 0, led_h + 2]) rotate([180, 0, 0])
union() {
    difference() {
        cylinder(r=inner_r + 3, h=led_h + 2);
        translate([0, 0, -1]) cylinder(r=inner_r + 1, h=led_h + 1);
        translate([0, 0, led_h - 0.5]) cylinder(r1=3, r2=5, h=3);
        difference() {
            cylinder(r=inner_r, h=led_h + 3);
            cylinder(r=inner_r - 3, h=led_h + 3);
        }
    }
    for (angle = [0:60:360]) rotate([0, 0, angle])
        translate([-inner_r, -1.5, led_h]) cube([4, 3, 2]);
    for (angle = [30, 150, 210, 330]) rotate([0, 0, angle])
            translate([-inner_r - 6.5, -2, 0]) cube([4, 4, led_h + 2]);
}

translate([0, -15, 0]) rotate([90, 0, 0])
difference() {
    cube([2 * inner_r + 12, bolt_r * 2 + 6, hold_l]);
    translate([3, -1, 3]) cube([2 * inner_r + 6, bolt_r * 2 + 8, hold_l - 2]);
    translate([3.1, bolt_r + 3, hold_l - bolt_r - 3]) rotate([0, -90, 0])
        cylinder(h = 4.2, r1=bolt_r + 0.5, r2=bolt_r - 0.5);
    translate([2 * inner_r + 8.9, bolt_r + 3, hold_l - bolt_r - 3]) rotate([0, 90, 0])
        cylinder(h = 4.2, r1=bolt_r + 0.5, r2=bolt_r - 0.5);
}