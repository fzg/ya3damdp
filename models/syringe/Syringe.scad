
resolution = 64;

module cyl(h, d, center) {
	cylinder(h=h, d=d, center=center, $fn=resolution);
}

module tube(h, d, hd, flr) {
	d2 = d - hd;
	difference(){
		 cyl(h=h, d=d, center=true);
		 translate([0,0,flr]){
		 cylinder(h=h-flr, d=hd, center=true, $fn=resolution);};
		};
}

module needle() {
	hole_dia = 0.75;	//Hole diameter
	ext_dia = 1;		//External diameter
	length = 80;		//Length
	tip_length = 2;	//Length of the tip
	e=0.125;			// Epsilon (width of sharp point)

	difference(){
		union(){
		 cylinder(h=length, d1=ext_dia, d2=hole_dia-e, center=true, $fn=resolution);
		 cylinder(h=tip_length, d=ext_dia, center=true, $fn=resolution);
		};
	cylinder(h=length+tip_length, d=hole_dia, center=true, $fn=resolution);};
}

module cup(len, dia, hole_dia) {
	// TODO for etancheity, recess/
	cup_width = 1;
	difference() {
	union() {
	 tube(h=len, d=dia, hd=dia-cup_width, flr=10);
	 translate([]){cylinder(h=1.25, d=2*hole_dia, center=true, $fn=resolution);};
	}
	 cylinder(h=len, d=hole_dia, center=true, $fn=resolution);
	}
}

module plunger(len, dia) {
trig_len = 8;
plung_dia = 2;
plung_len = 10;
union() {


cyl(h=trig_len, d=dia, center=false);//cyl haut
translate([0,0,trig_len]){cyl(h=len-plung_len, d=plung_dia, center=false);};// tige
translate([0,0,len-plung_len]){cyl(h=plung_len, d=dia, center=false);};// cyl bas
};
}

// cap = pi r r h 
module syringe(cap, w) {
	len = (cap / ((w/2)*(w/2)*PI)); // TODO add what's taken by the inside thingie
	echo("cap=",cap," w=", w, " len=", len);
	cup(len, dia=w, hole_dia=1);
	translate([0, 0, -.5*len]){
	 needle();
	};
	plunger(len, w);
}


/*
	Capacity, width

*/
syringe(20000,  10);
