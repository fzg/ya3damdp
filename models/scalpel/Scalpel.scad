resolution = 64;

module cyl(h, r, center) {
	cylinder(h=h, r=r, center=center, $fn=resolution);
}


module sharpener(height,l, h, w,mid_x, mid_y, ang) {
	difference() {
	 blade_end(height,l, h, w);
	 rotate([ang]) {
	  blade_end(height,l, h, w);
	 };
	 rotate([-ang]) {
	  blade_end(height,l, h, w);
	 };
	};						//difference
}

module blade_end(height, l, h, w){
	  cube([l, height, w]);			// Blade shaft-end

	translate([l,0, 0]) {
	   union() {				// Blade curved-end
	    intersection() {
	     cube([l, height, w]);
	      translate([0,height,0]){
	       cyl(h=w, r=height, center=false);	// End arc
	      };					// translate
	     };					// inter
	     translate([0, l/2, 0]) {
	      rotate([0,00,90]){
              //cyl(h=w, r1=0.1, r2=l*2.5); // 
	      };					// rotate
	     }; 					// translate
	    };					// inter
	   };						// union
}

module blade(height, l, h, w){ // Snap-in blade of set length and width
	rotate([90, 0, 0]) {
	union() {			
	 cube([height / 2, 10, w]);		// Snap-in part
	 translate([height / 2, -h, 0]) {
	sharpener(height,l, h, w, 0, 0, 20);
	  };						// translate
	 };						// translate
	};						// union
	
}

module handle(height, len, blade_h, blade_w) {
	width = blade_w * 2;
	difference() {
	 cube([len, width, height], center=true);
	 cube([len, blade_w, blade_h], center=true);	// Hole for blade
	};
}

module scalpel(height, length) {
	blade_l = 40;
	blade_w = 2;
	blade_h = 10;

	rotate([90,0,90]) {
	 handle(height, length, blade_h, blade_w);
	 translate([blade_l+20, blade_w/2, -blade_h / 2]) {
	  blade(height, blade_l,blade_h, blade_w);
	 };		// translate
	};		//rotate
}

scalpel(30, 100);
