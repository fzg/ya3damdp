/*	TODO: Spring-loaded design
 *	Change CAD software?
*/

resolution = 64;

// inside_dia, height, wire section, number of turns per mm
module spring(id, h, wd, n) {
	n=n*h;
	id = id /2;
	color("grey") linear_extrude(height=h, twist=n*360) {
	 translate([id,0])  square(wd);
	};
}


module cyl(h, r, center) {
	cylinder(h=h, r=r, center=center, $fn=resolution);
}

module tube(h, d, hd, flr) {
	d2 = d - hd;
	difference(){
		 cyl(h=h, r=d);
		 translate([0,0,flr]){
		 cyl(h=h, r=hd, $fn=resolution);};
		};
}

module needle() {
	hole_dia = 0.75;		//Hole diameter
	ext_dia = 1;		//External diameter
	length = 40;		//Length
	tip_length = 2;		//Length of the tip
	e=0.5;			// Epsilon (width of sharp point)
	difference(){
		union(){
		 cylinder(h=length, d=ext_dia, $fn=resolution);
		 translate([0, 0,-tip_length]) {
		  cylinder(h=tip_length, d2=ext_dia, d1=hole_dia-e, $fn=resolution);
		 };			// translate
		};			// union
		translate([0, 0,-tip_length+2]) cylinder(h=length+tip_length+2, d=hole_dia-e, $fn=resolution);
	};				//difference
}

module cup(len, dia, hole_dia) {
	// TODO for etancheity, recess/
	cup_width = 1;
	difference() {
	 union() {
	  tube(h=len, d=dia, hd=dia-cup_width, flr=10);
	 translate([0,0]){#cyl(h=1.25, r=hole_dia/2);};
	 }
	 cyl(h=len, r=hole_dia/2);
	}
}

module plunger(len, dia) {
	trig_len = 8;
	plung_dia = 2;
	plung_len = 10;

	union() {
	 cyl(h=trig_len, r=dia, center=false);//cyl haut
	 translate([0,0,trig_len]){cyl(h=len-plung_len, r=plung_dia, center=false);};// tige
	 translate([0,0,len-plung_len]){cyl(h=plung_len, r=dia, center=false);};// cyl bas
	};
}

// cap = pi r r h 
module syringe(cap, w) {
	len = (cap / ((w/2)*(w/2)*PI)); // TODO add what's taken by the inside thingie
	echo("cap=",cap," w=", w, " len=", len);
	color("blue", 0.5) cup(len, dia=w, hole_dia=1);
	translate([0, 20, 0]) color("grey") needle();
	translate([0,-3*w,0]) color("pink") plunger(len, w);
	translate([0, -5*w]) spring(w,len,1, 0.25);

}


/*
	Capacity, width

*/
syringe(5000,  8);
