difference() {
    scale([0.1, 0.1, 0.06])
        surface(file="/home/rvansa/openscad/ichthys.png", invert=true, convexity=10);
    translate([4, 0, -3.5])
        rotate([-90, 0, 0]) cylinder(r=1.5, h=20, $fn=8);
}