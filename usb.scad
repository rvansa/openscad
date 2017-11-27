usb_w=8;
usb_h=3;
usb_l=5;
box_l=16;
box_w=usb_w + 2*3;
base_w=40;
base_h=3;

// base
difference() {
    intersection() {
        cylinder(r=base_w/2, h=base_h);
        translate([-base_w/2, -box_l/2, 0]) cube([base_w, box_l, base_h]);
    }
    // screw holes
    translate([-13, 0, -0.5]) cylinder(r1=2.5, r2=4, h=base_h + 1);
    translate([ 13, 0, -0.5]) cylinder(r1=2.5, r2=4, h=base_h + 1);
    // channels
    translate([-usb_w / 2 + 1.1, box_l / 2 - 6, base_h - 1]) cube([1, 2, 2]);
    translate([-usb_w / 2 + 1.1, box_l / 2 - 6, base_h - 1])
        rotate([-30, 0, 0]) translate([0, -2, 0]) cube([1, 2, 1]);
    translate([ usb_w / 2 - 2.1, box_l / 2 - 6, base_h - 1]) cube([1, 2, 2]);
    translate([ usb_w / 2 - 2.1, box_l / 2 - 6, base_h - 1])
        rotate([-30, 0, 0]) translate([0, -2, 0]) cube([1, 2, 1]);
    
}

// box
translate([-box_w/2, -box_l/2, base_h])
    difference() {
        cube([box_w, box_l, usb_h]);
        translate([(box_w - usb_w) / 2, box_l - usb_l, -0.5])
            union() {
                cube([usb_w, usb_l + 1, usb_h + 1]);
                translate([-1.5, 3, 0])    cube([2, 1.5, usb_h + 1]);
                translate([usb_w - 0.5, 3, 0]) cube([2, 1.5, usb_h + 1]);
            }
        // channels
        translate([(box_w - usb_w) / 2, 2, -0.5])
            cube([2.1, box_l - usb_l + 1, usb_h + 1]);
        translate([(box_w - usb_w) / 2, 0, -0.5])
            linear_extrude(height=usb_h + 1)
                polygon([[0,-2],[2.1,2.1],[0, 2.1]], paths=[[0,1,2,0]]);             
        translate([(box_w + usb_w) / 2 - 2.1, 2, -0.5])
            cube([2.1, box_l - usb_l + 1, usb_h + 1]);
        translate([(box_w + usb_w) / 2, 0, -0.5])
            linear_extrude(height=usb_h + 1)
                polygon([[0,-2],[-2.1,2.1],[0, 2.1]], paths=[[0,1,2,0]]);                     
        translate([(box_w - usb_w) / 2 + 1, 6.5, -0.5]) cube([usb_w - 2, 2, usb_h + 1]);
        translate([(box_w - usb_w) / 2 + 1, 2, -0.5]) cube([usb_w - 2, 2, usb_h + 1]);
        // left rail
        translate([-1, -2, 1]) cube([2, box_l + 1, 1]);
        translate([1, -2, 2]) rotate([0, 30, 0])
            translate([-2, 0, -0.5]) cube([2, box_l + 1, 0.5]);
        translate([1, -2, 1]) rotate([0, -30, 0])
            translate([-2, 0, 0]) cube([2, box_l + 1, 0.5]);
        // right rail                       
        translate([box_w - 1, -2, 1]) cube([2, box_l + 1, 1]);
        translate([box_w - 1, -2, 2]) rotate([0, -30, 0])
            translate([0, 0, -0.5]) cube([2, box_l + 1, 0.5]);
        translate([box_w - 1, -2, 1]) rotate([0, 30, 0])
            cube([2, box_l + 1, 0.5]);
    }
    
 // cover
//translate([-(box_w + 5) / 2, -box_l / 2, 6])
translate([-(box_w + 5) / 2, -15, usb_h + 2]) rotate([180, 0, 0])
union() {
    difference() {
        translate([0, -2.5, 0]) cube([box_w + 5, box_l + 2.5, usb_h + 2]);
        translate([2, -0.5, -0.5]) cube([box_w + 1, box_l + 1, usb_h + 0.5]);   
        translate([(box_w - usb_w) / 2 + 2.5, -3.5, -1]) cube([1, 4, 2]);
        translate([(box_w + usb_w) / 2 + 1.5, -3.5, -1]) cube([1, 4, 2]);
    }
    difference() {
        translate([2, -0.5, 1]) cube([1, box_l - 1, 1]);
        translate([2, box_l - 1.5, 0])
            rotate([0, 0, 30]) translate([0, -2, 0.5]) cube([1, 2, 2]);
    }
    difference() {
        translate([box_w + 2, -0.5, 1]) cube([1, box_l - 1, 1]);
        translate([box_w + 3, box_l - 1.5, 0])
            rotate([0, 0, -30]) translate([-1, -2, 0.5]) cube([1, 2, 2]);
    }
}
