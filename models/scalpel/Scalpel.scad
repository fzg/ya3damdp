include <MCAD/teardrop.scad>
resolution = 64;

module cyl(h, r, center) {
	cylinder(h=h, r=r, center=center, $fn=resolution);
}


module sharpener(height,l, h, w,mid_x, mid_y, ang) {
	 difference() {
	  minkowski() {				//TODO: make blade shorter(compensate for teardrop minkowskied and other mess)
	   blade_end(height,l, h-l, w-w/2);
	    translate([l/2,0, w/2]) rotate([90,0,0]) teardrop(w/2, l, 90); 
	  };
	  translate([-0.01,height,-h/2]) cube([5*height, h/2, h]);
	 };
}

module old_sharpener(height,l, h, w,mid_x, mid_y, ang) {
	difference() {
	 blade_end(height,l, h, w);
	 //translate([0,-2.5*w,0]) {		// Messes with the arc
	 rotate([ang]) {
	  #blade_end(height,l, h, w);
	 };
	 rotate([-ang]) {
	  #blade_end(height,l, h, w);
	 };
	 //};
	};						//difference
}


module blade_end(height, l, h, w) {
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
	 translate([0,0,w/4]) cube([height / 2, 10, w]);		// Snap-in part
	 translate([height / 2, -h, 0]) {
	  sharpener(height,l, h, w, 0, 0, 10);
	 };						// translate
	};						// translate
	};						// union
	
}

module handle(height, len, blade_l, blade_h, blade_w) {
	width = blade_w * 2;
	difference() {
	resize([len,width, blade_h+10]) rotate([0,90]) cyl(h=len, r=width, center=false);
	 //cube([len, width, height], center=true);
	 translate([-1,-blade_w/2,-blade_h/2 ])
	cube([blade_l+1, blade_w, blade_h], center=false);	// Hole for blade
	};
}

module scalpel(height, length) {
	blade_l = 40;
	blade_w = 2;
	blade_h = 10;

	rotate([90,0,90]) {
	 color("green", 0.2) handle(height, length, blade_l, blade_h, blade_w);
				// . y z x
	 translate([-0, blade_w/2, -blade_l]) color("grey") blade(height, blade_l,blade_h, blade_w);
	};		//rotate
}

scalpel(30, 100);
