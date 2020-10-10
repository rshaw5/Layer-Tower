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
textWidth = tabWidth * .8;

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
         text("0.4", font="Consolas:style=Regular");
}

// CREATE ALL OTHER TABS
*for( level = [1:10] ) {
    translate([0,0,height * level]) {
        difference(){
            hull() {
                translate([1, 0, 0])
                    cube(size = [width-2,depth,height/10]);
                
                translate([0,0,height/10])
                    cube(size = [width, depth, height - 1]);
                
                translate([1,0,height - height/10])
                    cube(size = [width-2,depth,height/10]);
            }

            rotate(90, [1,0,0])
                translate([1,height/10,-1])
                    linear_extrude(height=2)
                    text(str((level * 0.2)), font="Consolas:style=Regular", size=height-2, spacing=1);
            }
    }
}

echo(str("\n
    +-----+\n
    | END |\n
    +-----+\n"));