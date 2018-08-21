$fn = 50;
plate_x = 105;
plate_y = 130;
box_h = 40;
mount_hole_depth = 8;
// board offsets
bx_off = 15;
by_off = 34;
bx = 91.5;
by = 60;

// disk offsets
dx_off = 25;
dy_off = 30;
dx = 70.1;
dy = 101.85;
dz = 10;

// lid
difference() {
    minkowski() {
        cube([plate_x, plate_y, 1]);
        cylinder(r = 5, h = 1);
    }             
    translate([0, 0, -1]) cylinder(r = 1.5, h = 4);
    translate([plate_x, 0, -1]) cylinder(r = 1.5, h = 4);
    translate([0, plate_y, -1]) cylinder(r = 1.5, h = 4);
    translate([plate_x, plate_y, -1]) cylinder(r = 1.5, h = 4);
    translate([15, 112, 1]) rotate([0, 0, -90])
        linear_extrude(height = 2) text("π", size = 100);
}


// shell
*difference() {
    minkowski() {
        cube([plate_x, plate_y, box_h - 1]);
        cylinder(r = 5, h = 1);
    }             
    translate([2, 2, 2]) minkowski() {
        cube([plate_x - 4, plate_y - 4, box_h - 1]);
        cylinder(r = 5, h = 1);
    }
    // disk screw holes
    translate([dx_off, dy_off, -1]) union() {
        translate([4.07, 14, 0]) disk_screw_hole();
        translate([4.07 + 61.72, 14, 0]) disk_screw_hole();
        translate([4.07, 90.6, 0]) disk_screw_hole();
        translate([4.07 + 61.72, 90.6, 0]) disk_screw_hole();
    }
    // usb port
    translate([bx_off + bx, by_off + by - 29.5, 20.5]) cube([4.5, 15.5, 16.5]);
    // eth port
    translate([bx_off + bx, by_off + by - 50, 20.5]) cube([4.5, 18, 14.5]);
    // vertical vents
    for (off = [4:4:48])    
        translate([-6, off, 3]) air_hole();
    for (off = [96:4:plate_y - 4])    
        translate([-6, off, 3]) air_hole();
    for (off = [4:4:36])    
        translate([plate_x + 2, off, 3]) air_hole();
    for (off = [88:4:plate_y - 4])    
        translate([plate_x + 2, off, 3]) air_hole();
    for (off = [4:4:plate_x - 4])
        translate([off + 2, -6, 3]) rotate([0, 0, 90]) air_hole();
    for (off = [4:4:plate_x - 4])
        translate([off + 2, plate_y + 2, 3]) rotate([0, 0, 90]) air_hole();
    // horizontal vents
    for (off = [10:4:plate_x - 10])
        translate([off, 5, -1]) cube([2, 25, 4]);
    for (off = [10:4:plate_x - 10])
        translate([off, 60, -1]) cube([2, 20, 4]);
    for (off = [10:4:plate_x - 10])
        translate([off, 102, -1]) cube([2, 10, 4]);
    // button holes
    translate([bx_off - 21, by_off + 48.5, 23]) rotate([0, 90, 0]) cylinder(r = 2, h = 4);    
    translate([bx_off - 21, by_off + 27.2, 23]) rotate([0, 90, 0]) cylinder(r = 2, h = 4);    
    // bottom stack/leg holes
    translate([0, 0, -1]) cylinder(r = 1.4, h = 9);
    translate([plate_x, 0, -1]) cylinder(r = 1.4, h = 9);
    translate([0, plate_y, -1]) cylinder(r = 1.4, h = 9);
    translate([plate_x, plate_y, -1]) cylinder(r = 1.4, h = 9);
}

// board
* translate([bx_off, by_off, 20]) cube([bx, by, 2]);
* translate([bx_off + 46, by_off + 30, 21]) import("banana_pi_1.stl");

* union() {
    // board mounts
    translate([bx_off, by_off + 5, 0]) board_mount();
    translate([bx_off + bx - 6, by_off, 0]) board_mount();
    translate([bx_off + bx - 6, by_off + by - 6, 0]) board_mount();
    translate([bx_off, by_off + by - 6, 0]) board_mount();
    // button support mounts
    translate([bx_off - 10, by_off + 12, 0]) board_mount(19);
    translate([bx_off - 10, by_off + by - 6, 0]) board_mount(19);
    // button support
    translate([bx_off - 28, by_off + 12, 0]) button_support();
    // buttons
    // translate([bx_off - 24, by_off + 48.5, 23]) rotate([0, 90, 0])
    translate([-10, 40, 0])
        union() {
            cylinder(r = 1.8, h = 23);
            cylinder(r = 3, h = 2);
        }
    translate([-10, 30, 0])
        union() {
            cylinder(r = 1.8, h = 23);
            cylinder(r = 3, h = 2);
        }
    // lid mounts
    lid_mount();
    translate([plate_x, 0, 0]) lid_mount();
    translate([0, plate_y, 0]) lid_mount();
    translate([plate_x, plate_y, 0]) lid_mount();
    // legs
    translate([-12, 20, 0]) leg();
    translate([-12, 5, 0]) leg();
    translate([-12, 105, 0]) leg();
    translate([-12, 120, 0]) leg();
}

module button_support() {
    difference() {
        cube([6, by - 12, 2]);
        translate([3, 3, -1]) cylinder(r = 1.5, h = 4);
        translate([3, by - 15, -1]) cylinder(r = 1.5, h = 4);
    }
    translate([0, 31.5, 2]) difference() {
        cube([6, 10, 6]);
        translate([-1, 5, 2]) rotate([0, 90, 0]) cylinder(r = 2, h = 12);    
    }
    translate([0, 10.2, 2]) difference() {
        cube([6, 10, 6]);
        translate([-1, 5, 2]) rotate([0, 90, 0]) cylinder(r = 2, h = 12);    
    }   
}

module board_mount(mount_h = 20) {
    difference() {
        cube([6, 6, mount_h]);
        translate([3, 3, mount_h - mount_hole_depth + 1]) cylinder(r = 1.4, h = mount_hole_depth + 1);
    }
}

module disk_screw_hole() {
   cylinder(r = 1.5, h = 20); 
}

module air_hole() {   
    cube([4, 2, box_h - 7]);
    translate([0, 1, box_h - 8]) rotate([45, 0, 0]) cube([4, sqrt(2), sqrt(2)]);
}

module lid_mount() {
    difference() {
        cylinder(r = 3.5, h = box_h);
        translate([0, 0, box_h - 8]) cylinder(r = 1.4, h = 9);        
    }
}

module leg() {
    difference() {
        cylinder(r = 5, h = 10);
        translate([0, 0, -1]) cylinder(r = 1.5, h = 12);
        translate([0, 0, 2]) cylinder(r = 3, h = 9);
    }
}

// disk
* translate([dx_off, dy_off, 2]) union() {
    cube([dx, dy, dz]);
    // space for connector
    translate([4, -30, 2]) cube([dx - 8, 30, dz - 4]);
}

