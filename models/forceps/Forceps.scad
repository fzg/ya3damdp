

module fillet(r,h) {
difference() {
cylinder(h=h, r=r);
translate([0,0,-0.1]) cylinder(h=h+0.2, r=r/2);

};
}

module f_hole(l, w, h) {
 translate([h-h/2,-h/30,-h/2]) rotate([90,0,0]) fillet(r=2*h, h=w/2);
 }

module f_thing(l,w,h) {
 translate([0,0,-w/2]) cube([h,w,w], center=true);
}

module f_arm(l,w,h) {
union() {
 translate([-l/2,-w/2,0]) cube([l/2,w,h],center=false);
translate([r/2,w/2,0]) rotate([90,0,0]) cylinder(d=w, h=w/2);
};
 translate([0,-w/2,0]) cube([l/2-h,w,w/2],center=false);

 
}

module f_shear(l,w,h) {
 union() {
  difference() {
   union() {
    union() {
     f_arm(l,w,h);
     translate([-l/2,0,h]) f_thing(l,w,h);
    };
    translate([l/2,0,0]) {translate([-w/2,-w/2,0])cube([w/2,w/2,w/2]);f_hole(l,w,h);}
   }
  translate([0,w,0])rotate([90,0,0]) cylinder(h=w*2, r=h/2);
  }				// difference
 }
}


module forceps(l,w,h) {
 rotate([0,0,0]) color("yellow",0.5) f_shear(l,w,h);
 translate([0,2*w,0]) rotate([180,-0,]) color("blue",0.5) f_shear(l,w,h);
}
translate([90,0,0]) forceps(80,12,4);