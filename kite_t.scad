ml = 40;
thick = 3;
d = 10;
a = 38.5;

difference() {
    union() {
        cube([d + 2 * thick, ml, thick + d / 2 + 0.5]);
        rotate([0, 0, 90 - a]) cube([d + 2 * thick, ml, thick + d / 2 + 0.5]);
        linear_extrude(height = thick)
            polygon(points = [
                [0, ml], [0, ml / 2],
                [-cos(a) * ml + sin(a) * (d + 2 * thick), sin(a) * ml + cos(a) * (d + 2 * thick)]],
        paths = [[0, 1, 2]]);
    }
    translate([thick, -0.1, thick]) cube([d, ml + 0.2, d / 2 + 0.5 + 0.1]);
    rotate([0, 0, 90 - a])
        translate([thick, 12, thick]) cube([d, ml + 0.2, d / 2 + 0.5 + 0.1]);
}