piStandoffHeight = 6;
piStandoffBoltSize = 2.5;

// rotate([270,0,0])
//    translate([45,-19,31.0])
//        import("./pi.stl"); 

shaftDiameter = 10.1;
clampWidth = 15 ;
clampThickness = 2.5 ;
clampLegLengthFromShaft = 7 ;
clampLegThickness = clampThickness + 1 ; // default is 'clampThickness' to keep it the same thickness as the clamp
clampLegGap = 8 ;
clampToClampScrewCenter = (clampLegLengthFromShaft - clampThickness) / 2 - 3 ; //using '(clampLegLengthFromShaft - clampThickness) / 2' nearly centres this hole on the clamp leg
clampScrewDiameter = 4.5 ;
shaftToMountPlate = 0 ;
mountPlateThickness = 5 ;
mountPlateLength = 38 ;
mountHoleSpacing = 30 ;
mountHoleDiameter = 4.0 ;
screwHoleSmoothness = 14 ; //6 = printable vertically. Applies to mount plate screw holes and clamp leg screw holes
clampSmoothness = 80 ;

shaftSpacing = 60.0;
piLength = 92.0;
piWidth = 58.3;
piHeight = 18.2 + piStandoffHeight;
piCaseWallThickness = 2.0;
piCaseOffset = shaftDiameter/2;
piCaseRailWidth = 2.0;
piCaseRailOffset = 2.4;

piCaseLength = piLength + piCaseWallThickness;
piCaseWidth = piWidth + piCaseWallThickness*2.0;
piCaseHeight = piHeight + piCaseWallThickness*2.0;

clampWingLength = 9;
clampWingWidth = clampWidth;
clampWingHeight = 5;

piPowerHeight = 9;
piPowerWidth = 13.5;
piPowerVertOffset = -3.8 + piHeight-piCaseWallThickness*2+piPowerHeight/2 - piStandoffHeight;
piPowerHorzOffset = 4.0;

piGPIOHeight = 6.75;
piGPIOWidth = 52.0;
piGPIOVertOffset = 1.1;
piGPIOHorzOffset = 7.3;

piSDHeight = 5.0;
piSDWidth = 15.0;
piSDVertOffset = -1.2 + piHeight + piCaseWallThickness*2 - piStandoffHeight;
piSDHorzOffset = -2 + piWidth/2 - piCaseWallThickness*2;

piCaseMountHoleDiameter = piStandoffBoltSize + 0.1;

clampOffset = 0;// - clampWidth -piWidth/2 + clampWidth/2 - piCaseWallThickness;
clamp1HorzOffset = 55;
clamp2HorzOffset = shaftSpacing - clamp1HorzOffset;

//clampWithMountPlate();

//translate([50,0,50]) clamp();

piCase();

module piCase() {
    difference() {
        union(){
            piCaseTop();
            piCaseBottom();
            piCaseSides();
            piCaseBack();
                //piCaseRails();
                //piCaseRailsFillets();
			clampWings();
            clamps();
        }

        piMountingHoles();
    }
}

module piMountingHoles() {
    rotate([0,0,0])
        translate([6.6,6.5,piCaseHeight-piCaseWallThickness])
            cylinder(h=piCaseWallThickness, d=piCaseMountHoleDiameter, center=false, $fn = screwHoleSmoothness);
    rotate([0,0,0])
        translate([63.9,6.5,piCaseHeight-piCaseWallThickness])
            cylinder(h=piCaseWallThickness, d=piCaseMountHoleDiameter, center=false, $fn = screwHoleSmoothness);
    rotate([0,0,0])
        translate([6.6,55.0,piCaseHeight-piCaseWallThickness])
            cylinder(h=piCaseWallThickness, d=piCaseMountHoleDiameter, center=false, $fn = screwHoleSmoothness);
    rotate([0,0,0])
        translate([63.9,55.0,piCaseHeight-piCaseWallThickness])
            cylinder(h=piCaseWallThickness, d=piCaseMountHoleDiameter, center=false, $fn = screwHoleSmoothness);
}

module clampWings() {
	translate([clampWingWidth/2+piCaseLength/2+clampOffset,-clampWingLength, 0])
		rotate([0,0,90])
			cube([clampWingLength, clampWingWidth, clampWingHeight]);
	translate([clampWingWidth/2+piCaseLength/2+clampOffset, -0.6, 0])
		rotate([0,90,90])
			cube([2, clampWingWidth, 3.1]);
	translate([clampWingWidth/2+piCaseLength/2+clampOffset, 0.5, -1])
		rotate([0,90,90])
			cube([2.9, clampWingWidth, 2]);
}

module piSDSlot() {
    rotate([90,0,90])
        translate([piSDHorzOffset, piSDVertOffset, -0.1])
            squareSlot(height=piSDHeight, width=piSDWidth, depth=piCaseWallThickness+0.2);
}

module piCaseGPIO() {
    rotate([0,0,0])
        translate([piGPIOHorzOffset+piCaseWallThickness,piGPIOVertOffset+piCaseWallThickness+piGPIOHeight/2,-0.1])
            squareSlot(height=piGPIOHeight, width=piGPIOWidth, depth=piCaseWallThickness+0.2);
}

module squareSlot(height=1, width=3, depth=1) {
	translate([0,-height/2,0])
	cube([width, height, depth]);
}

module roundedSlot(height=1, width=3, depth=1) {
    union() {
        rotate([0,0,0])
            translate([height/2,0,0])
                cylinder(h=depth, r=height/2, center=false);
        rotate([0,0,0])
            translate([width-height/2,0,0])
                cylinder(h=depth, r=height/2, center=false);
        rotate([0,0,0])
            translate([height/2,-height/2,0])
                cube([width-height, height, depth]);
    }
}

module piCasePower() {
    rotate([90,0,0])
        translate([piCaseWallThickness+piPowerHorzOffset,piCaseWallThickness+piPowerVertOffset,-piCaseWidth-piCaseWallThickness-0.1])
            squareSlot(height=piPowerHeight, width=piPowerWidth, depth=piCaseWallThickness+0.2);
}

module piCaseRailsFillets() {
    difference() {
        rotate([0,0,0])
            translate([0, piCaseWallThickness, piCaseHeight-piCaseWallThickness-piCaseRailWidth*2-piCaseRailOffset-piCaseWallThickness])
                piCaseRail();
        rotate([0,90,0])
            translate([-piCaseHeight+piCaseWallThickness+piCaseRailWidth*2+piCaseRailOffset,piCaseWallThickness+piCaseRailWidth,0])
                cylinder(h=piCaseLength, r=piCaseRailWidth, center=false);
    }

    difference() {
        rotate([0,0,0])
            translate([0, piCaseWidth-piCaseWallThickness, piCaseHeight-piCaseWallThickness-piCaseRailWidth*2-piCaseRailOffset])
                piCaseRail();
        rotate([0,90,0])
            translate([-piCaseHeight+piCaseWallThickness+piCaseRailWidth*2+piCaseRailOffset,piCaseWidth-piCaseWallThickness,0])
                cylinder(h=piCaseLength, r=piCaseRailWidth, center=false);
    }
}

module fillet() {
    rotate([0,0,0])
        translate([0, piCaseWallThickness, piCaseHeight-piCaseWallThickness-piCaseRailWidth*2-piCaseRailOffset])
            piCaseRail();

    rotate([0,90,0])
        translate([0,0,0])
            cylinder(h=piCaseLength, r=piCaseRailWidth, center=false);
}

module piCaseRails() {
    rotate([0,0,0])
        translate([0, piCaseWallThickness, piCaseHeight-piCaseWallThickness-piCaseRailWidth-piCaseRailOffset])
            piCaseRail();

    rotate([0,0,0])
        translate([0, piCaseWidth-piCaseRailWidth, piCaseHeight-piCaseWallThickness-piCaseRailWidth-piCaseRailOffset])
            piCaseRail();
}

module piCaseRail() {
    cube([piCaseLength, piCaseRailWidth, piCaseRailWidth], false);
//        translate([0,piCaseRailWidth,0])
//            fillet();

//    }
}

module piCaseSides() {
    rotate([0,0,0])
        translate([0,0,0])
            cube([piCaseLength, piCaseWallThickness, piCaseHeight], false);

    difference() {
        rotate([0,0,0])
            translate([0,piCaseWidth,0])
                cube([piCaseLength, piCaseWallThickness, piCaseHeight], false);
        piCasePower();
    }
}

module piCaseBack() {
    difference() {
        rotate([0, 0, 0])
            translate([0,0,0])
                cube([piCaseWallThickness, piCaseWidth, piCaseHeight], false);

        piSDSlot();
    }
}

module piCaseBottom() {
    rotate([0, 0, 0])
        translate([0,0,piHeight+piCaseWallThickness])
            cube([piCaseLength, piCaseWidth, piCaseWallThickness], false);
}

module piCaseTop(){
    difference() {
        rotate([0, 0, 0])
            translate([0,0,0])
                cube([piCaseLength, piCaseWidth, piCaseWallThickness], false);
        piCaseGPIO();
    }
}

module clamps(){
    rotate([90,0,90])
        translate([clamp1HorzOffset,-shaftDiameter/2,piCaseLength/2-clampWidth/2])
            clamp();
    rotate([90,0,90])
        translate([-clamp2HorzOffset,-shaftDiameter/2,piCaseLength/2-clampWidth/2])
            clamp();
}

module clampWithMountPlate(){
	union(){
		clamp();
        plate();
	}
}

module plate(){
    translate([0,shaftDiameter / 2 + shaftToMountPlate + mountPlateThickness / 2,clampWidth / 2])
        difference(){
            cube([mountPlateLength,mountPlateThickness,clampWidth], center = true);
            translate([-mountHoleSpacing / 2,0,0]) rotate([90,0,0]) cylinder(r = mountHoleDiameter / 2, h = mountPlateThickness + 2, center = true, $fn = screwHoleSmoothness);
            translate([mountHoleSpacing / 2,0,0]) rotate([90,0,0]) cylinder(r = mountHoleDiameter / 2, h = mountPlateThickness + 2, center = true, $fn = screwHoleSmoothness);
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
