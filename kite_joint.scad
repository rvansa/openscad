ml = 40;
thick = 3;
d = 10;
r = 10;
$fn=20;

difference() {
    cube([d + 2 * thick, ml, d/2 + thick]);
    translate([thick, -1, thick]) cube([d, ml + 2, d/2 + 1]);
}
difference() {
    hull() {
        cube([d + 2 * thick, ml, thick]);
        translate([d + 2 * thick + r, ml/2, 0])
            cylinder(d=r * 2, h=thick);
    }
    translate([d + 2 * thick + r, ml/2, -1])
        cylinder(d=4, h=thick + 2);
}