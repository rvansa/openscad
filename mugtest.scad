use <writescad/Write.scad>

PI=3.1415;
inner_r=20;
sc_height=10;
angles=36;
volume_height=10;
mini=0.7;

module spiral() {
	sc_length=sqrt(4 * PI*PI * inner_r*inner_r + sc_height*sc_height);
	ss_length=sc_length / angles;
	ss_angle=asin(sc_height / sc_length);

	for(angle = [1:angles * (volume_height / sc_height)]) {
		rotate([0, 0, -360 * angle / angles])
			translate([inner_r - mini, 0, sc_height * angle / angles])
				rotate([-ss_angle, 0, 180 / angles])
					cube([mini, ss_length, mini]);
	}
}

spiral();
difference() {
	cylinder(r=inner_r + mini, h=volume_height);
	translate([0, 0, 0.5])
		cylinder(r=inner_r, h=volume_height + 1);

}
decades(10, 10);

module decades(num_decades, decade_height, font_size=4) {
	for(dec = [0:num_decades - 1]) {
		rotate([0, 0, -dec * 360 / num_decades])
			translate([inner_r - mini, -mini/2, 0])
				union() {
					cube([mini, mini, decade_height]);
					translate([0.7, font_size * 0.7, (decade_height - font_size)/2]) 
						rotate([90, 0, 270])
							write(str(dec * 100/num_decades), h=font_size, t=1, font="writescad/Letters.dxf");
				}
   }
	for(un = [1:50]) {
		rotate([0, 0, -un * 360 / 50])
			translate([inner_r - mini, -mini/2, decade_height - 3 * mini])
				cube([mini, mini, 3 * mini]);
	
	}
}