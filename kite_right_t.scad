ml = 40;
thick = 3;
d = 10;

difference() {
    cube([d + 2 * thick, ml, d/2 + thick]);
    translate([thick, -1, thick]) cube([d, ml + 2, d/2 + 1]);
}
translate([d + 2 * thick, ml/2 - d/2 - thick, 0]) difference() {
    cube([ml / 2, d + 2 * thick, d/2 + thick]);
    translate([-1, thick, thick]) cube([ml / 2 + 2, d, d/2 + 1]);
}
linear_extrude(height = thick)
    polygon(points = [
                [d + 2 * thick, 0], [d + 2 * thick + ml/2, ml/2 - d/2 - thick],
                [d + 2 * thick + ml/2, ml/2 + d/2 + thick],
                [d + 2 * thick, ml]],
        paths = [[0, 1, 2, 3]]);