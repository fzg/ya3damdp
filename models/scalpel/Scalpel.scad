

module blade(l, w){

	
}

module handle(len) {
	width = 0.6;
	height=2;

	difference(){
	cube([len, width, height], center=true);
	cube([len, blade_, height/2], center=true);
	}
}

module scalpel(length) {

	blade_l = 4;
	blade_w = 0.1;

	handle(length, blade_w);
	blade(blade_l, blade_w);
}

scalpel(10);