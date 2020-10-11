echo(str("\n
    +-------+\n
    | START |\n
    +-------+\n"));

// PARAMETERS
nozzleDiameter = 1;

//  CALCULATIONS
tabHeight = nozzleDiameter * 20;
tabWidth  = tabHeight * 2.5;

textHeight = tabHeight * .8;
textWidth = tabWidth * .6;

chamferHeight = tabHeight * .1;
chamferWidth  = tabWidth * .9;

depth  = nozzleDiameter * 5;

echo(str(
    "\n nozzleDiameter = ", nozzleDiameter,
    "\n tabWidth = ", tabWidth,
    "\n tabHeight = ", tabHeight,
    "\n textWidth = ", textWidth,
    "\n textHeight = ", textHeight,
    "\n chamferWidth = ", chamferWidth,
    "\n chamferHeight = ", chamferHeight,
    "\n depth = ", depth,
    "\n")
);

// CREATE FIRST TAB
difference(){
    hull() {
        // Main Tab
        cube(size = [ tabWidth, depth, tabHeight - chamferHeight ]);
    
        // Top Chamfer
        translate([(tabWidth - chamferWidth)/2,0, tabHeight - chamferHeight])
            cube(size = [chamferWidth,depth,chamferHeight]);
    }

    // Label
    translate([.8 * ((tabWidth-textWidth)/2), 0, (tabHeight - textHeight)/2])
    resize([textWidth,0,textHeight])
    rotate([90,0,0])
    linear_extrude(depth)
         text("0.04", font="Consolas:style=Regular");
}

// CREATE ALL OTHER TABS
layerModifier = ceil((nozzleDiameter-0.04)/0.36);
echo(str("layerIncrements = ", layerModifier));

layerIncrement = layerModifier * 0.04;
echo(str("layerIncrement = ", layerIncrement));

layerSteps = [ for (i = [0.04 : layerIncrement : nozzleDiameter]) i ];
totalLayers = len(layerSteps) - 1;
*for ( level = [1:totalLayers]){
    translate([0, 0, tabHeight * level])
        cube([tabWidth, depth, tabHeight]);
}

for( level = [1:totalLayers] ) {
    translate([0,0,tabHeight * level]) {
        difference(){
            hull() {
                // Bottom Chamfer
                translate([(tabWidth - chamferWidth)/2,0, 0])
                  cube(size = [chamferWidth,depth,chamferHeight]);
                
                // Main Tab
                translate([0,0,chamferHeight])
                  cube(size = [ tabWidth, depth, tabHeight - chamferHeight * 2 ]);
            
                // Top Chamfer
                translate([(tabWidth - chamferWidth)/2,0, tabHeight - chamferHeight])
                  cube(size = [chamferWidth,depth,chamferHeight]);
            }
            
            // Label
            translate([.8 * ((tabWidth-textWidth)/2), nozzleDiameter, (tabHeight - textHeight)/2])
            resize([textWidth,0,textHeight])
            rotate([90,0,0])
            linear_extrude(depth)
                  text(str(layerSteps[level]), font="Consolas:style=Regular");
            }
    }
}

echo(str("\n
    +-----+\n
    | END |\n
    +-----+\n"));