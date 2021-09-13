shaftDiameter = 16.1;
clampWidth = 15 ;
clampThickness = 2.5 ;
clampLegLengthFromShaft = 10 ;
clampLegThickness = clampThickness + 2 ; // default is 'clampThickness' to keep it the same thickness as the clamp
clampLegGap = 13 ;
clampToClampScrewCenter = (clampLegLengthFromShaft - clampThickness) / 2 - 3 ; //using '(clampLegLengthFromShaft - clampThickness) / 2' nearly centres this hole on the clamp leg
clampScrewDiameter = 4.5 ;
shaftToMountPlate = 0 ;
mountPlateThickness = 5 ;
mountPlateLength = 38 ;
mountHoleSpacing = 30 ;
mountHoleDiameter = 3.5 ;
screwHoleSmoothness = 14 ; //6 = printable vertically. Applies to mount plate screw holes and clamp leg screw holes
clampSmoothness = 80 ;

sensorLength = 50.8;
sensorWidth = 57.2;
sensorBorder = 1.0;
sensorMount1HorzOffset = 3.17 + sensorBorder;
sensorMount1VertOffset = 53.98 + sensorBorder;
sensorMount2HorzOffset = 47.62 + sensorBorder;
sensorMount2VertOffset = 3.18 + sensorBorder;

boardHeight = 25.0;

pocketDiameter = 4.0;
pocketHeight = 4.0;
pocketWallThickness = 3.0;
pocketOuterDiameter = pocketDiameter+pocketWallThickness*2;

caseInnerLength = sensorLength + sensorBorder*2;;
caseInnerWidth = sensorWidth + sensorBorder*2;
caseInnerHeight = boardHeight + pocketWallThickness;

caseWallThickness = 2;
caseLength = caseInnerLength + caseWallThickness*2;
caseWidth = caseInnerWidth + caseWallThickness*2;
caseHeight = caseInnerHeight + caseWallThickness*2;

cableHoleWidth = 14.0;
cableHoleHeight = 6.0;

caseTiltAngle = 0;

clampBaseWidth = 4;
clampBaseLength = caseLength + clampBaseWidth*2 + pocketHeight*2 + 2;
clampBaseHeight = clampWidth;

pivotArmLength = caseWidth/2 + 5.5;
pivotArmWidth = clampBaseWidth;
pivotArmHeight = clampWidth;
pivotArmHoleDiameter = 3.0;

screwHoleDiameter = 3.5;
heatInsertDiameter = 2.0;

endVentHeight = 1.5;
endVentWidth = caseInnerWidth-15;
sideVentHeight = endVentHeight;
sideLongVentWidth = 15;
sideShortVentWidth = 10;

co2Mount();

module co2Mount() {
    union() {
		armAssembly();
        case();
		//lid();
    }
}

module armAssembly() {
	translate([0, -(shaftDiameter/2), 0])
		clamp();
	clampBase();
	pivotArm(-(clampBaseLength/2-pivotArmWidth/2));
	pivotArm(clampBaseLength/2-pivotArmWidth/2);
}

module lid() {
	translate([-caseLength/2,caseWidth+clampBaseWidth+pivotArmLength-caseWidth/2,-caseHeight/2+clampWidth/2-10])
	rotate([180,0,0])
	union() {
		// Lid
		cube([caseLength, caseWidth, caseWallThickness], center=false);
		//Screw Pocket
		translate([caseWallThickness, caseWidth-12, -pocketDiameter/2-pocketWallThickness])
			rotate([0,90,0])
				insertPocketWithArm();
		translate([caseLength-pocketHeight-caseWallThickness, 12, -pocketDiameter/2-pocketWallThickness])
			rotate([0,90,0])
				insertPocketWithArm();
	}
}

module case() {
    //The next 3 lines are used to create the tilt of the case
    translate([0, pivotArmLength+clampBaseWidth, +clampBaseHeight/2])
    rotate([caseTiltAngle,0,0])
    translate([0, -pivotArmLength-clampBaseWidth, -clampBaseHeight/2])
    
    translate([0, 0, clampBaseHeight/2])
        translate([-caseLength/2, clampBaseWidth+pivotArmLength-caseWidth/2,-caseHeight/2])
            union() {
                difference() {
                    // Outside cube of case
                    cube([caseLength, caseWidth, caseHeight], false);
                    // Inside cube of case
                    translate([caseWallThickness, caseWallThickness,0])
                        cube([caseInnerLength, caseInnerWidth, caseInnerHeight], false);
					//Pocket Holes
					rotate([0,90,0])
						translate([-caseHeight/2,caseWidth/2,0])
							cylinder(d=heatInsertDiameter, h=caseWallThickness+0.1, center=false, $fn=screwHoleSmoothness);
					rotate([0,90,0])
						translate([-caseHeight/2,caseWidth/2,caseLength-caseWallThickness])
							cylinder(d=heatInsertDiameter, h=caseWallThickness+0.1, center=false, $fn=screwHoleSmoothness);
					// Wire Passage 1
                    translate([caseLength/2-cableHoleWidth/2, caseWallThickness+0.1, caseHeight/3])
                        rotate([90,0,0])
                            roundedSlot(height=cableHoleHeight, width=cableHoleWidth+cableHoleHeight, depth=caseWallThickness+0.2);
                    // Wire Passage 2
                    //translate([caseLength/2-cableHoleWidth/2, caseWidth+0.1, caseHeight/3])
                    //    rotate([90,0,0])
                    //        roundedSlot(height=cableHoleHeight, width=cableHoleWidth, depth=caseWallThickness+0.2);
					// Lid Screw Hole
					translate([0, 12, pocketOuterDiameter/2])
						rotate([0,90,0])
							cylinder(d=screwHoleDiameter, h=caseWallThickness, $fn=screwHoleSmoothness);
					// Lid Screw Hole
					translate([caseLength-caseWallThickness, caseWidth-12, pocketOuterDiameter/2])
						rotate([0,90,0])
							cylinder(d=screwHoleDiameter, h=caseWallThickness, $fn=screwHoleSmoothness);
					// End Vents
					translate([caseLength/2-endVentWidth/2, caseWidth, caseHeight-15])
						rotate([90,0,0])
							roundedSlot(height=endVentHeight, width=endVentWidth, depth=caseWallThickness+0.1);
					translate([caseLength/2-endVentWidth/2, caseWidth, caseHeight-20])
						rotate([90,0,0])
							roundedSlot(height=endVentHeight, width=endVentWidth, depth=caseWallThickness+0.1);
					translate([caseLength/2-endVentWidth/2, caseWidth, caseHeight-25])
						rotate([90,0,0])
							roundedSlot(height=endVentHeight, width=endVentWidth, depth=caseWallThickness+0.1);
					// Side Vents
					translate([-0.1,caseLength-sideLongVentWidth,caseHeight-15])
						rotate([90,0,90])
							roundedSlot(height=sideVentHeight, width=sideLongVentWidth, depth=caseWallThickness+0.2);
					translate([-0.1,caseLength-sideLongVentWidth,caseHeight-20])
						rotate([90,0,90])
							roundedSlot(height=sideVentHeight, width=sideLongVentWidth, depth=caseWallThickness+0.2);
					translate([-0.1,caseLength-sideLongVentWidth,caseHeight-25])
						rotate([90,0,90])
							roundedSlot(height=sideVentHeight, width=sideLongVentWidth, depth=caseWallThickness+0.2);
					translate([-0.1,sideLongVentWidth/2,caseHeight-15])
						rotate([90,0,90])
							roundedSlot(height=sideVentHeight, width=sideLongVentWidth, depth=caseWallThickness+0.2);
					translate([-0.1,sideLongVentWidth/2,caseHeight-20])
						rotate([90,0,90])
							roundedSlot(height=sideVentHeight, width=sideLongVentWidth, depth=caseWallThickness+0.2);
					// Side Vents
					translate([caseInnerLength+caseWallThickness,caseLength-sideLongVentWidth,caseHeight-15])
						rotate([90,0,90])
							roundedSlot(height=sideVentHeight, width=sideLongVentWidth, depth=caseWallThickness+0.1);
					translate([caseInnerLength+caseWallThickness,caseLength-sideLongVentWidth,caseHeight-20])
						rotate([90,0,90])
							roundedSlot(height=sideVentHeight, width=sideLongVentWidth, depth=caseWallThickness+0.1);
					translate([caseInnerLength+caseWallThickness,sideLongVentWidth/2,caseHeight-15])
						rotate([90,0,90])
							roundedSlot(height=sideVentHeight, width=sideLongVentWidth, depth=caseWallThickness+0.1);
					translate([caseInnerLength+caseWallThickness,sideLongVentWidth/2,caseHeight-20])
						rotate([90,0,90])
							roundedSlot(height=sideVentHeight, width=sideLongVentWidth, depth=caseWallThickness+0.1);
					translate([caseInnerLength+caseWallThickness,sideLongVentWidth/2,caseHeight-25])
						rotate([90,0,90])
							roundedSlot(height=sideVentHeight, width=sideLongVentWidth, depth=caseWallThickness+0.1);
                }
				// Pivot Point 1
				translate([-pocketHeight+caseWallThickness, caseWidth/2, caseHeight/2])
					rotate([0,90,0])
						insertPocket(height=pocketHeight-caseWallThickness);
				translate([-pocketHeight, caseWidth/2, caseHeight/2])
					rotate([0,90,0])
						insertPocket(diameter=pocketDiameter-1, height=caseWallThickness, wallThickness=pocketWallThickness+0.5);
				// Pivot Point 2
				translate([caseLength, caseWidth/2, caseHeight/2])
					rotate([0,90,0])
						insertPocket(height=pocketHeight-caseWallThickness);
				translate([caseLength+pocketHeight-caseWallThickness, caseWidth/2, caseHeight/2])
					rotate([0,90,0])
						insertPocket(diameter=pocketDiameter-1, height=caseWallThickness, wallThickness=pocketWallThickness+0.5);
                // Sensor Mount Point 1
                translate([caseWallThickness+sensorMount1HorzOffset, caseWallThickness+sensorMount1VertOffset, caseInnerHeight-pocketHeight])
                    rotate([0,0,0])
                        insertPocket();
                // Sensor Mount Point 2
                translate([caseWallThickness+sensorMount2HorzOffset, caseWallThickness+sensorMount2VertOffset, caseInnerHeight-pocketHeight])
                    rotate([0,0,0])
                        insertPocket();
				// Sensor Support
				translate([caseWallThickness+sensorMount1HorzOffset, caseWallThickness+sensorMount2VertOffset, caseInnerHeight-pocketHeight])
					rotate([0,0,0])
				        cylinder(d=pocketOuterDiameter, h=pocketHeight, center=false, $fn=screwHoleSmoothness);
				// Sensor Support
				translate([caseWallThickness+sensorMount2HorzOffset, caseWallThickness+sensorMount1VertOffset, caseInnerHeight-pocketHeight])
					rotate([0,0,0])
				        cylinder(d=pocketOuterDiameter, h=pocketHeight, center=false, $fn=screwHoleSmoothness);
            }
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

module insertPocket(diameter=pocketDiameter, height=pocketHeight, wallThickness=pocketWallThickness) {
    difference() {
        cylinder(d=diameter+wallThickness*2, h=height, center=false, $fn=screwHoleSmoothness);
        cylinder(d=diameter, h=height, center=false, $fn=screwHoleSmoothness);
    }
}

module insertPocketWithArm() {
    difference() {
		union() {
			translate([-pocketOuterDiameter/2, -pocketOuterDiameter/2, 0])
				cube([pocketOuterDiameter/2, pocketOuterDiameter, pocketHeight]);
	        cylinder(d=pocketDiameter+pocketWallThickness*2, h=pocketHeight, center=false, $fn=screwHoleSmoothness);
		}
        cylinder(d=pocketDiameter, h=pocketHeight, center=false, $fn=screwHoleSmoothness);
    }
}

module pivotArm(offset=0) {
    translate([offset, clampBaseWidth,0])
        difference() {
            union() {
                rotate([0,0,90])
                    translate([0,-pivotArmWidth/2,0])
                        cube([pivotArmLength, pivotArmWidth, pivotArmHeight], false);
                rotate([0,90,0])
                    translate([-pivotArmHeight/2, pivotArmLength, -pivotArmWidth/2])
                        cylinder(h=pivotArmWidth, r=pivotArmHeight/2, center=false);
            }
            translate([-pivotArmHeight/2, pivotArmLength, pivotArmHeight/2])
            rotate([0,90,0])
                cylinder(d=pivotArmHoleDiameter, h=pivotArmHeight, center=false, $fn=screwHoleSmoothness);
        }
}

module clampBase() {
    rotate([])
        translate([-clampBaseLength/2,0,0])
            cube([clampBaseLength, clampBaseWidth, clampBaseHeight], false);
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