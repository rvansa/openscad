
$fa=3;
inner_r=40;
outer_r=50;
topper_height=6;
mini=1;
drink_hole_dim = [15, 5, 7];
air_hole_dim = [5, 5, 7];
outer_dist=6;
debug_shift = 0.5;

* topper();
* rotate(90, [0, 0, 1])
	translate([0,0,topper_height])
		top();
translate([0, 0, topper_height + 2 * mini]) mirror([0, 0, 1])
	ring();


module topper() {
	difference() {
		cylinder(r=outer_r, h=topper_height);
		translate([0, 0, -debug_shift])
			cylinder(r=inner_r, h=topper_height - 2 + 2 * debug_shift, center=false);
		translate([0, 0, topper_height - 2])
			cylinder(r1=inner_r, r2=inner_r + 1 + debug_shift, h=1 + debug_shift);
		translate([0, 0, topper_height - 1])
			cylinder(r1=inner_r + 1, r2=inner_r + 4 + debug_shift, h=1 + debug_shift);
	}
}

module top() {
	difference() {
		union() {
			cylinder(r=outer_r, h=mini);
			translate([-drink_hole_dim.x/2, outer_r - drink_hole_dim.y - outer_dist, 0])
				cube(drink_hole_dim);		
			translate([-air_hole_dim.x/2, - outer_r + air_hole_dim.y + outer_dist, 0])
				cube(air_hole_dim);		
		}
		translate([-drink_hole_dim.x/2, outer_r - drink_hole_dim.y - outer_dist, 0])
			translate([mini, mini, -debug_shift])
				cube([drink_hole_dim.x - 2*mini, drink_hole_dim.y - 2 * mini, drink_hole_dim.z + 2 * debug_shift]);
		translate([-air_hole_dim.x/2, - outer_r + air_hole_dim.y + outer_dist, 0])
			translate([mini, mini, -debug_shift])
				cube([air_hole_dim.x - 2*mini, air_hole_dim.y - 2 * mini, air_hole_dim.z + 2 * debug_shift]);		
	}
	scale([0.4, 0.4, 1])
		rotate(180, [0, 0, 1]) translate([-76, -76, mini]) 
			linear_extrude(height=mini, convexity=10)
				import(file="smiley.dxf", layer="smiley");
}

module ring() {
	difference() {
		cylinder(r=outer_r + mini, h=topper_height + 2 * mini);
		translate([0,0,-debug_shift])
			cylinder(r=outer_r - 0.1,  h=topper_height + mini + debug_shift);
		cylinder(r=outer_r - 3,    h=topper_height + 2 * mini + debug_shift);
	}	
}