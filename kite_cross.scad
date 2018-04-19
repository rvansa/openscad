ml = 40;
thick = 3;
d = 10.5;
a = 38.5;

difference() {
    cube([d + 2 * thick, ml, d + 2 * thick]);
    translate([thick, -0.1, thick]) cube([d, ml + 0.2, d]);  
}
translate([(d - ml)/2 + thick, (ml - d)/2 - thick, d + thick]) 
    difference() {
        cube([ml, d + 2 * thick, d + 2 * thick]);
        translate([-0.1, thick, thick]) cube([ml + 0.2, d, d]);  
    }
translate([0, 0, d + thick]) linear_extrude(height = thick)
    polygon(points = [[0, 0], [(d - ml)/2 + thick, (ml - d)/2 - thick],
        [(d - ml)/2 + thick, (ml + d)/2 + thick],
        [0, ml], [d + 2 * thick, ml],
        [(ml + d) / 2 + thick, (ml + d) / 2 + thick],
        [(ml + d) / 2 + thick, (ml - d) / 2 - thick],
        [d + 2 * thick, 0]],
        paths = [[0, 1, 2, 3, 4, 5, 6, 7]]);
   