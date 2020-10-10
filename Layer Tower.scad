// PARAMETERS
nozzleDiameter = 1;

echo("\n
+-------+\n
| START |\n
+-------+\n
");

width  = 21;
depth  = 3;
height = 10;

difference(){
    hull() {
        cube(size = [width, depth, height - 1]);
    
        translate([1,0,height - height/10])
            cube(size = [width-2,depth,height/10]);
    }

    rotate(90, [1,0,0])
        translate([1,height/10,-1])
            linear_extrude(height=2)
            text(".04", font="Consolas:style=Regular", size=height-2, spacing=1);
}

for( level = [1:10] ) {
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

echo("\n
+-----+\n
| END |\n
+-----+\n
");