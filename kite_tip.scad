ml = 40;
thick = 3;
d = 10;
a = 38.5;
h = thick + d / 2 + 0.5;

difference() {
    union() {
        rotate([0, 0, -a]) translate([-d - 2 * thick, 0, 0])
            cube([d + 2 * thick, ml, thick + d / 2 + 0.5]);
        rotate([0, 0, a])
            cube([d + 2 * thick, ml, thick + d / 2 + 0.5]);
        linear_extrude(height = thick)
            polygon(points = [
                [sin(a) * ml - cos(a) * (d + 2 * thick), cos(a) * ml + sin(a) * (d + 2 * thick)],
                [0, ml / 2],
                [-sin(a) * ml + cos(a) * (d + 2 * thick), cos(a) * ml + sin(a) * (d + 2 * thick)]],
        paths = [[0, 1, 2]]);
    }
    rotate([0, 0, a])
        translate([thick, 18, thick]) cube([d, ml + 0.2, d / 2 + 0.5 + 0.1]);
    rotate([0, 0, -a])
        translate([-d - thick, 18, thick]) cube([d, ml + 0.2, d / 2 + 0.5 + 0.1]);
    difference() {
        translate([-15, 0, -0.2]) cube([30, 13, h + 0.4]);
        translate([0, 20, -0.1])
            rotate_extrude(convexity = 16) square([d + 2.4, h + 0.2]);
    }
}