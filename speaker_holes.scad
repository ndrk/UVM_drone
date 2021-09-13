PLATE_LENGTH = 30.0;
PLATE_WIDTH = 30.0;
PLATE_THICKNESS = 1.0;
PLATE_LIP_WIDTH = 1;
HOLE_TEXT_DEPTH = 0.5;
HOLE_TEXT_SIZE = 1;
HOLE_TEXT_VERT_OFFSET = 1.2;
HOLE_DIAMETER = 1.0;
PLATE_CORNER_RADIUS = 3.0;
SMOOTHNESS = 20;

holes = [
	[15.0,	15.0],
	[5.0,	5.0],
	[25.0,	5.0],
	[5.0,	25.0],
	[25.0,	25.0],
	[10.0,	10.0]
];

labels = [
	["SPEAKER BELL",	holes[0][0],	holes[0][1]-HOLE_TEXT_VERT_OFFSET],
	["SCREW",		holes[1][0],	holes[1][1]-HOLE_TEXT_VERT_OFFSET],
	["SCREW",		holes[2][0],	holes[2][1]-HOLE_TEXT_VERT_OFFSET],
	["SCREW",		holes[3][0],	holes[3][1]-HOLE_TEXT_VERT_OFFSET],
	["SCREW",		holes[4][0],	holes[4][1]-HOLE_TEXT_VERT_OFFSET],
	["LEDs",			holes[5][0],	holes[5][1]-HOLE_TEXT_VERT_OFFSET]
];
// END Box Front Settings

include <include/drill_guide.scad>;
