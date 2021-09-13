shaftDiameter = 16.1;
clampWidth = 22;
clampThickness = 2.5 ;
clampLegLengthFromShaft = 10 ;
clampLegThickness = clampThickness + 2 ; // default is 'clampThickness' to keep it the same thickness as the clamp
clampLegGap = 13;
clampToClampScrewCenter = (clampLegLengthFromShaft - clampThickness) / 2 - 3 ; //using '(clampLegLengthFromShaft - clampThickness) / 2' nearly centres this hole on the clamp leg
clampScrewDiameter = 4.5 ;
shaftToMountPlate = 0 ;
mountPlateThickness = 5 ;
mountPlateLength = 105 ;
mountHoleSpacing = 30 ;
mountHoleDiameter = 3.5 ;
screwHoleSmoothness = 14 ; //6 = printable vertically. Applies to mount plate screw holes and clamp leg screw holes
clampSmoothness = 80 ;

tieGuideWidth = 11;
tieGuidHeight = 4;
tieGuideOpening = 2;

solarShieldOuterDiameter = clampWidth;
solarShieldInnerDiameter = solarShieldOuterDiameter-4;
solarShieldLength = 30;
solarShieldCenterHeight = 5;

clampWithMountPlate();

module clampWithMountPlate(){
	union(){
        	clamp();
		plate();
		//solarShield();
    }
}

module solarShield() {
    translate([-mountPlateLength/2, solarShieldCenterHeight+shaftDiameter/2+shaftToMountPlate+mountPlateThickness, clampWidth/2])
        rotate([90,0,90])
        		difference() {
				union() {
					cylinder(d=solarShieldOuterDiameter, h=solarShieldLength, center=false, $fn=clampSmoothness);
					translate([-solarShieldCenterHeight,-solarShieldOuterDiameter/2,0])
						cube([solarShieldCenterHeight, solarShieldOuterDiameter, solarShieldLength], center=false);
				}
				cylinder(d=solarShieldInnerDiameter, h=solarShieldLength, center=false, $fn=clampSmoothness);
				translate([-solarShieldOuterDiameter/2-solarShieldCenterHeight, -solarShieldOuterDiameter/2,0])
					cube([solarShieldOuterDiameter/2-solarShieldCenterHeight, solarShieldOuterDiameter, solarShieldLength]);
			}
}

module plate(){
    translate([0,shaftDiameter / 2 + shaftToMountPlate + mountPlateThickness / 2,clampWidth / 2])
        union(){
            cube([mountPlateLength,mountPlateThickness,clampWidth], center = true);
//            rotate([90,0,0])
//                translate([mountPlateLength/2-(mountPlateLength/2-clampWidth/2)/2, tieGuidHeight, -mountPlateThickness/2])
//                    cylinder(r=tieGuideWidth/2, h=mountPlateThickness, center=false);
        }
}

module clamp(){
    difference(){
        union(){
            cylinder(r = shaftDiameter / 2 + clampThickness, h = clampWidth, $fn = clampSmoothness);
            translate([0,-(shaftDiameter / 2 + clampLegLengthFromShaft) / 2,clampWidth / 2]) cube([clampLegThickness * 2 + clampLegGap, shaftDiameter / 2 + clampLegLengthFromShaft,clampWidth], center = true);
        }
            translate([0,0,-1]) cylinder(r = shaftDiameter / 2,h = clampWidth + 2, $fn = clampSmoothness);        
            translate([0, -(shaftDiameter / 4 + clampLegLengthFromShaft ) + 0.1, clampWidth / 2]) cube([clampLegGap, shaftDiameter / 2 + clampLegLengthFromShaft * 2, clampWidth + 2], center = true);
            translate([0, -(shaftDiameter / 2 + clampThickness + clampToClampScrewCenter ), clampWidth / 2]) rotate([0, 90, 0]) cylinder(r = clampScrewDiameter / 2, h = clampLegThickness * 2 + clampLegGap + 2,center = true, $fn = screwHoleSmoothness);
    }
}