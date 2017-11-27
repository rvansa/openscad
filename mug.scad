use <writescad/Write.scad>
use <bend.scad>

$fa=3;
inner_r=40;
outer_r=50;
volume_height=80;
outer_height=82;
topper_height=6;
sc_height=20;
mini=1;
decade_height=10;
sphere_r=160;
font_name="writescad/knewave.dxf";
font_size=6;
name_r_in = 47;
name_r_out = 147;
name_dim = [80, 48, 2];

debug_shift=1;

PI=3.1415926;
bottom=outer_height - volume_height;

//intersection() {
//translate([-100, -100, 0]) cube([200, 200, 200]);
//translate([0, 0, -70]) mug();
//}
mug();

module mug() {
	difference() {
		union() {
			body();
			handle();
		}
		volume();
	}
	translate([0, 0, bottom - mini/2])
		union() {
			spiral();
			centis();
		}
	translate([0, 0, outer_height - decade_height])
		decades(10, decade_height);
	braille();	
	rotate(180, [0, 0, 1])
		translate([0, -177.5, 40])
			rotate(75, [1, 0, 0])
				translate([-30, 0, -name_r_out])
					bent_name();
}


module body() {
   sphere_center=outer_r + sqrt(pow(sphere_r, 2) - pow(outer_height/2, 2));
   translate([0, 0, outer_height])
   	cylinder(r=outer_r, h=topper_height);
	for(c=[0:outer_height - 1]) {
		translate([0, 0, c])
			cylinder(r1=sphere_center - sqrt(pow(sphere_r, 2) - pow(c - outer_height/2, 2)),
			         r2=sphere_center - sqrt(pow(sphere_r, 2) - pow(c + 1 - outer_height/2, 2)),
		            h=1, center=false);
	}
}

module volume() {
		   translate([0, 0, bottom])
			   cylinder(r=inner_r, h=volume_height + topper_height - 2 + debug_shift, center=false);
			translate([0, 0, bottom + volume_height + topper_height - 2])
				cylinder(r1=inner_r, r2=inner_r + 1 + debug_shift, h=1 + debug_shift);
			translate([0, 0, bottom + volume_height + topper_height - 1])
				cylinder(r1=inner_r + 1, r2=inner_r + 4 + debug_shift, h=1 + debug_shift);
}

module bent_name() {	
	cylindric_bend([100, 100, 20], name_r_out, 10)
   	translate([30, 0, -32])	
			rotate(90, [0, 0, 1]) rotate(150, [1, 0, 0])
				translate([0, 0, -name_r_in])
					cylindric_bend(name_dim, name_r_in)
						translate([name_dim.x, 0, 0]) mirror([1, 0, 0])							
							translate([name_dim.x, name_dim.y, 0])
								rotate(180, [0, 0, 1])
									name();
}

module name(sc=0.4) {
	scale([sc, sc, 1])
		linear_extrude(height=2, convexity=10)
			import(file="fishA.dxf", layer="A");
}


module braille(font_size=16) {
	translate([-6, -76, 71]) rotate(16, [1, 0, 0])
  		write("A", h=font_size, t=3, font="writescad/braille.dxf");
	translate([-6, -88, 65]) rotate(28, [1, 0, 0])
	   write("N", h=font_size, t=3, font="writescad/braille.dxf");
	translate([-6, -87, 50.5]) rotate(90, [1, 0, 0])
   	write("I", h=font_size, t=3, font="writescad/braille.dxf");
	translate([-6, -85.5, 35]) rotate(93, [1, 0, 0])
		write("T", h=font_size, t=3, font="writescad/braille.dxf");
	translate([-6, -88, 17]) rotate(84, [1, 0, 0])
		write("A", h=font_size, t=3, font="writescad/braille.dxf");
}

module spiral() {
	angles = 360 / $fa;
	sc_length=sqrt(4 * PI*PI * inner_r*inner_r + sc_height*sc_height);
	ss_length=sc_length / angles;
	ss_angle=asin(sc_height / sc_length);

	for(angle = [1:angles * (volume_height / sc_height)]) {
		rotate([0, 0, -360 * angle / angles])
			translate([inner_r - 0.8 * mini, 0, sc_height * angle / angles])
				rotate([-ss_angle, 0, 180 / angles])
					cube([mini, ss_length, mini]);
	}
}

module decades(num_decades, decade_height) {
	for(dec = [0:num_decades - 1]) {
		rotate([0, 0, -dec * 360 / num_decades])
			translate([inner_r - 0.8 * mini, -mini/2, 0])
				union() {
					cube([mini, mini, decade_height]);
					translate([0.5, font_size * 0.9, (decade_height - font_size)/2]) 
						rotate([90, 0, 270])
							union() {
								if (dec != 0)
									write(str(dec * 10/num_decades), h=font_size, t=mini, font=font_name);
								translate([font_size, 0, 0])
									write("0", h=font_size, t=mini, font=font_name);
							}
				}
   }
	for(un = [1:100]) {
		rotate([0, 0, -un * 360 / 100])
			translate([inner_r - 0.8 * mini, -mini/2, decade_height - 2 * mini])
				cube([mini, mini, 2 * mini]);
	
	}
}

module centis() {
	for (cent = [0:4]) {
		translate([inner_r, font_size, cent * sc_height + 1.5])
			rotate([90, 0, 270])
				write(str(cent * 100), h=font_size, t=mini, font=font_name);
	}
}

module handle() {
	function handle_p(c, outer_height, handle_height) =
		2*(c-outer_height/2)/handle_height;

	function handle_y(p, handle_distance, handle_approach) =
		-handle_distance + pow(p, 6) * handle_approach;

	handle_r=15;
	handle_finish=10;
	handle_height=outer_height - 2*handle_finish;
	handle_distance=1.6*outer_r;
	handle_approach=outer_r/3.2;
	for(c=[0:outer_height-1]) {
		assign(p =handle_p(c,   outer_height, handle_height),
             p2=handle_p(c+1, outer_height, handle_height))
      assign(y =handle_y(p,   handle_distance, handle_approach),
    			 y2=handle_y(p2,  handle_distance, handle_approach),
 				 s =0.5 + pow(p, 2)/2,
             s2=0.5 + pow(p2,2)/2) {
			translate([0, y, c])
				skewY(atan((y2-y + (s2 - s)*handle_r)))
					scale([1, s, 1])
						cylinder(r=handle_r, h=1);
		}
	}
}

module skewY(angle) {
	multmatrix([[1, 0,          0, 0],
				   [0, 1, tan(angle), 0],
               [0, 0,          1, 0],
               [0, 0,          0, 1]])
		child();
}
